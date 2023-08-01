Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F376BD71
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjHATMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjHATMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3611BF1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43CE1616A2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648E4C433C7;
        Tue,  1 Aug 2023 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690917124;
        bh=4bXA5LiSffF092ekI7PffAzaTl6bqdrbyGn+kgTWpbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZEdvlhTzezxEqSfa0ASwLVi0dnTnxkbKdEU2UkKjHfsFUTlLYHL++IN6NTL+wt6xy
         bDzxreMQo07YDJuakNU+RKRtWd9GaOmcWnM/HsAdz8JTb3I8JesU6O9y4PBfNdN5Es
         dPUSZe/J7gNzd2X7GnCJGgdhUFdn3XT5yQg2D70c=
Date:   Tue, 1 Aug 2023 12:12:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com
Subject: Re: [PATCH 1/5] mm/compaction: allow blockpfn outside of pageblock
 for high order buddy page
Message-Id: <20230801121203.a58e15d4f290721746340801@linux-foundation.org>
In-Reply-To: <20230729174354.2239980-2-shikemeng@huaweicloud.com>
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
        <20230729174354.2239980-2-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 01:43:50 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> Commit 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in
> free scanner") skiped compound pages to save iterations and limit blockpfn
> to reach outside of page block in case of bogus compound_order. While this
> also limit pfnblock outside page block in case a buddy page with order
> higher than page block is found. After this, isolate_freepages_range will
> fail unexpectedly as it will fail to isolate the page block which was
> isolated successfully by high order buddy page in previous page block
> and abort the free page isolation.
> 
> Fix this by allow blockpfn outside of pageblock in case of high order
> buddy page.
> 
> ...
>
> @@ -1418,7 +1420,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>  	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>  
>  	/* Skip this pageblock in the future as it's full or nearly full */
> -	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
> +	if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
>  		set_pageblock_skip(page);
>  }
>  

This needed alteration for mm-unstable changes:

@@ -1441,7 +1443,7 @@ fast_isolate_around(struct compact_contr
 	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
-	if (start_pfn == end_pfn)
+	if (start_pfn >= end_pfn)
 		set_pageblock_skip(page);
 
 	return;

