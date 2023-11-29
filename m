Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9917FDAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjK2PRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjK2PRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:17:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AFDBE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVe+YsT+KR+z33Feh0S2abrktnXFj3/Xq7PW7szlVro=; b=OqoUxFpIqv9MhZcTS2Ll09NpHG
        699z6qO5qmlcNFR+1/9OLhgk4TBWZyo0iTYRrjK8OySQIMBBkPWtpqkKvyTrdPUCwEs45hUBSOaUC
        kYfvehnaUlhhLjSky8aLSOMWHKuLTDdPIQ8M/DM2fq4KFZXfSd3QtHefF/rk8d2yB9QtOfi37UF3X
        AmPyFsKY5BSoucK7HfyX1rV4rH5yTpc7Yc1pM9h3MDmkC2YH4gIacTzJR1t2sC+FJVf5mv/FCi1iT
        ZoDNVJ9utk4HgVCUv4QlW+RoZyIkiSZMMqb3ZzlrQMlx6ei66rtZensSuc7SYEf4m0FHKg5QpmsRE
        py05Z28g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8MJr-00DVpi-As; Wed, 29 Nov 2023 15:17:43 +0000
Date:   Wed, 29 Nov 2023 15:17:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm:vmscan: fix shrink sc->nr counter values issue
Message-ID: <ZWdWFx1mXl29dP5U@casper.infradead.org>
References: <20231129130126.2130-1-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129130126.2130-1-justinjiang@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:01:26PM +0800, Zhiguo Jiang wrote:
> It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
> set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
> are both zero at the same time.

Have you observed this happening, or is this from code review?

> It can't be guaranteed for the PGDAT_WRITEBACK flag that only pages
> marked for immediate reclaim are on evictable LRUs in other following
> shrink processes of the same kswapd shrink recycling. So when both a
> small amount of pages marked for immediate reclaim and a large amount
> of pages marked for non-immediate reclaim are on evictable LRUs at the
> same time, if it's only determined that there is at least a page marked
> for immediate reclaim on evictable LRUs, kswapd shrink is throttled to
> sleep, which will increase kswapd process consumption.
> 
> It can be fixed to throttle kswapd shrink when sc->nr.immediate is equal
> to sc->nr.file_taken.

So you're fixing two distinct things in the same patch?

> +++ b/mm/vmscan.c
> @@ -5915,17 +5915,17 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  
>  		/* Allow kswapd to start writing pages during reclaim.*/
> -		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
> +		if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
>  			set_bit(PGDAT_DIRTY, &pgdat->flags);
>  
>  		/*
> -		 * If kswapd scans pages marked for immediate
> +		 * If kswapd scans massive pages marked for immediate

I don't understand why you've added the word "massive".  Do you mean
that the pages are large, or that kswapd has scanned a lot of pages?

>  		 * reclaim and under writeback (nr_immediate), it
>  		 * implies that pages are cycling through the LRU
>  		 * faster than they are written so forcibly stall
>  		 * until some pages complete writeback.
>  		 */
> -		if (sc->nr.immediate)
> +		if (sc->nr.immediate && sc->nr.immediate == sc->nr.file_taken)
>  			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
>  	}
