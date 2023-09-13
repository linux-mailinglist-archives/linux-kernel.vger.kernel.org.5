Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B813F79F373
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjIMVH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjIMVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:07:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B75F1BCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:07:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6655AC433C8;
        Wed, 13 Sep 2023 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694639271;
        bh=RNYP9+p+x6ZzoNqDo1JjEqeN5WDavOAss0TMtv0FSd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJieTzkWepHpXecGf8t8Ijddd8IpFJqDWvCMhN8ZxENiV1Rs1sqhQ8mBITiN4qB1o
         9n/MSZuMCni9rbepiJz+5kA1EPSxgJkipqfrU7zlJ3PGp7aBm9azwd30YnDrdEsVBb
         uI2Hp+QSxGL5jkTYgJtafMqpfmJJmWRMAQEVGlfo=
Date:   Wed, 13 Sep 2023 14:07:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
Message-Id: <20230913140750.616d3d87fe986a74d870b71f@linux-foundation.org>
In-Reply-To: <20230912175228.952039-2-shr@devkernel.io>
References: <20230912175228.952039-1-shr@devkernel.io>
        <20230912175228.952039-2-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 10:52:25 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This change adds a "smart" page scanning mode for KSM. So far all the
> candidate pages are continuously scanned to find candidates for
> de-duplication. There are a considerably number of pages that cannot be
> de-duplicated. This is costly in terms of CPU. By using smart scanning
> considerable CPU savings can be achieved.
> 
> This change takes the history of scanning pages into account and skips
> the page scanning of certain pages for a while if de-deduplication for
> this page has not been successful in the past.
> 
> To do this it introduces two new fields in the ksm_rmap_item structure:
> age and skip_age. age, is the KSM age and skip_page is the age for how

s/skip_page/skip_age/

> long page scanning of this page is skipped. The age field is incremented
> each time the page is scanned and the page cannot be de-duplicated.
> 
> How often a page is skipped is dependent how often de-duplication has
> been tried so far and the number of skips is currently limited to 8.
> This value has shown to be effective with different workloads.
> 
> The feature is currently disable by default and can be enabled with the
> new smart_scan knob.
> 
> The feature has shown to be very effective: upt to 25% of the page scans
> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
> a similar de-duplication rate can be maintained.
> 

All seems nice.  I'll sit out v1, see what people have to say.

Some nits:

> --- a/mm/ksm.c
> +++ b/mm/ksm.c
>
> ...
>
> @@ -2305,6 +2314,45 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>  	return rmap_item;
>  }
>  
> +static unsigned int inc_skip_age(rmap_age_t age)
> +{
> +	if (age <= 3)
> +		return 1;
> +	if (age <= 5)
> +		return 2;
> +	if (age <= 8)
> +		return 4;
> +
> +	return 8;
> +}

"inc_skip_age" sounds like it increments something.  Can we give it a
better name?

And a nice comment explaining its role in life.

> +static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
> +{
> +	rmap_age_t age;
> +
> +	if (!ksm_smart_scan)
> +		return false;
> +
> +	if (PageKsm(page))
> +		return false;
> +
> +	age = rmap_item->age++;
> +	if (age < 3)
> +		return false;
> +
> +	if (rmap_item->skip_age == age) {
> +		rmap_item->skip_age = 0;
> +		return false;
> +	}
> +
> +	if (rmap_item->skip_age == 0) {
> +		rmap_item->skip_age = age + inc_skip_age(age);
> +		remove_rmap_item_from_tree(rmap_item);
> +	}
> +
> +	return true;
> +}

Would a better name be should_skip_rmap_item()?

But even that name implies that the function is idempotent (has no
side-effects).  Again, an explanatory comment would be good.  And
simple comments over each non-obvious `if' statement.

>
> ...
>
