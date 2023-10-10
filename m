Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BD17BF04E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379279AbjJJBbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379278AbjJJBbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:31:51 -0400
Received: from out-203.mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E329191
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:31:49 -0700 (PDT)
Date:   Mon, 9 Oct 2023 18:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696901508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ho1/AhNyD0qYiEmVEK/IfiNfgDoSn0wjA0JY40hhrfo=;
        b=eRylKYE4l/CKWymVpIyaPDUoBL9vKiqAT0GEXztgMI21lINvE61Io6wKq3XH8UO0uvw7Kb
        zbCMF2VYFQEJzkDE36IwgbqO9pdqe3JFypmJ8s46vInBChDcv2+24kT6ka2+P/W9iXjMNB
        /MhETnefBKNjqKZnOhZAD6hR6oLVAjI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCHv5] mm: optimization on page allocation when CMA enabled
Message-ID: <ZSSpfw_VdFkus4F5@P9FQF9L96D>
References: <1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20231006141750.5423083520f74bc0746fd249@linux-foundation.org>
 <CAGWkznHqQHMN1QXz7os7AQTYdzc3+LEq+z2bWOzLbiseV=560A@mail.gmail.com>
 <20231009171415.cfc26b45c2f9f4489afe16c2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009171415.cfc26b45c2f9f4489afe16c2@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:14:15PM -0700, Andrew Morton wrote:
> On Sun, 8 Oct 2023 15:54:40 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> 
> > > Roman previously asked
> > >
> > > : Also I'm a bit concerned about potential performance implications.
> > > : Would be great to provide some benchmarks or some data.  Probably it's
> > > : ok because of we have pcp caches on top, but I'm not 100% sure.
> > >
> > > Are you able to perform such testing and tell us the result?
> > I have applied this patch in a v5.4 based ANDROID system and got no
> > regression problem. Actually, this commit is aimed to have
> > alloc_pages(GFP_USER) use CMA instead of stealing U&R(could lead to
> > GFP_KERNEL fail) only when zone's free pages and free cma are around
> > WATERMARK_LOW/MIN which would NOT affect most scenarios.
> 
> OK, thanks.
> 
> Could the appropriate people please take a look at this?  It has been
> in mm-unstable since May.

I have 2 concerns:
1) it's still hard to understand the commit message and comments, I can
   only reverse-engineer it based on the code changes;
2) performance concerns I expressed earlier are not addressed. Idk what's
   a good benchmark for the page allocator, probably something i/o or
   networking heavy.

On the positive side I believe that the patch is solving a real problem.
