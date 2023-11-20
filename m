Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E39C7F19EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKTRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:30:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A66CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wiezd/vwYSqpEHIOZBhRGI+wBEWN8CahQi5f/TV2hvs=; b=Ej2/zPoaX2Qduy+l9cXzF43q44
        4UaBhyypySzb1OgmJKpjpVnS50BIS5lNwe1VDb7nQ5mPDhKtw+vXTLzinDMquI1WIrZVUHWuaZBqv
        EzOs0WIvkkZ866ez+MlaL+ijQgJqT+/zSkHtqejs0HzkTVvlSy2vwhdex9Z0/H4LkAQZqqbpJS5lc
        xU7FxJnBCjt3wkl7obs3viwnCxQRqJYKX+F/rkCxQOp0tcYtWTx8ZfcbLpK8lVPl9RFraZLawAXgp
        hBqKPqQ5GtIFiKvnzISMf8iT11Z6hEYaenjAubpjlGzNAyxRIX4ovpfQEztzxo+9UseWN0w1sDqcS
        or9nfolA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r585t-004oJH-Pr; Mon, 20 Nov 2023 17:29:57 +0000
Date:   Mon, 20 Nov 2023 17:29:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
Message-ID: <ZVuXlcwgcw0ShjRQ@casper.infradead.org>
References: <20231120023537.1785-1-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120023537.1785-1-justinjiang@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:35:36AM +0800, Zhiguo Jiang wrote:
> +			/*
> +			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
> +			 * it should alloc from buddy highatomic migrate freelist firstly
> +			 * to ensure quick and successful allocation.

Assuming that all the serious question shave been dealt with, let's
fix the less important problems ...

			 * If pcplist is empty and alloc_flags contains
			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
			 * freelist first.

> @@ -2918,7 +2927,7 @@ static inline
>  struct page *rmqueue(struct zone *preferred_zone,
>  			struct zone *zone, unsigned int order,
>  			gfp_t gfp_flags, unsigned int alloc_flags,
> -			int migratetype)
> +			int migratetype, bool *highatomc_allocation)

bool *highatomic

> +	/*
> +	 * The high-order atomic allocation pageblock reserved conditions:
> +	 *
> +	 * If the high-order atomic allocation page is alloced from pcplist,
> +	 * the highatomic pageblock does not need to be reserved, which can
> +	 * void to migrate an increasing number of pages into buddy

	 * avoid migrating an increasing number of pages into buddy

> +	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of

"increased"

> +	 * allocation failure on other buddy migrate freelists.
> +	 *
> +	 * If the high-order atomic allocation page is alloced from buddy

"allocated"

> @@ -3208,6 +3234,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  	struct pglist_data *last_pgdat = NULL;
>  	bool last_pgdat_dirty_ok = false;
>  	bool no_fallback;
> +	bool highatomc_allocation = false;

Again, just call this 'highatomic'.

