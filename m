Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621B7DAE3D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjJ2Ukr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2Ukp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:40:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A5B6;
        Sun, 29 Oct 2023 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6waNhTR+o+oIxNaOT4t0XGJ4/XH/ruK+m0W6clw3ZeA=; b=Zk7tjG5wKVi6QbIzzn68YStq16
        57v23MVZQgD9Aaslc6J29o8nzcPpfIaCNICUhBsZBFWuGIm8XfEb4vxCMaSF+dMJyfRZZi07/CGgV
        sq9JWVeF3tzdsytUaezhQGt7uEt3kznNRVGydmi4wwesl92UY36yqjC/Y0/egKMQP8n3B2Ox84iJE
        Lck0evHllaksBJxlVP8BALQSRbqJCSTILL45M6shVjKVkGevDSdjIYf7zH7U6neFoLVVttXDNmj/J
        GqUIRdN4WvbO8XPzALUPUTaYd/OG6DQWnwXvOBFQ6TZazcr+wnSIt0nL0HzyPXE0cerIxNEfumU2Q
        FN5UO73A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxCaJ-00HaHF-Ko; Sun, 29 Oct 2023 20:40:36 +0000
Date:   Sun, 29 Oct 2023 20:40:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 05/11] shmem: account for large order folios
Message-ID: <ZT7DQ3Ye/k6HDIpm@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7@eucas1p2.samsung.com>
 <20231028211518.3424020-6-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-6-da.gomez@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 09:15:42PM +0000, Daniel Gomez wrote:
> @@ -856,16 +856,16 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>  						pgoff_t start, pgoff_t end)
>  {
>  	XA_STATE(xas, &mapping->i_pages, start);
> -	struct page *page;
> +	struct folio *folio;
>  	unsigned long swapped = 0;
>  	unsigned long max = end - 1;
>  
>  	rcu_read_lock();
> -	xas_for_each(&xas, page, max) {
> -		if (xas_retry(&xas, page))
> +	xas_for_each(&xas, folio, max) {
> +		if (xas_retry(&xas, folio))
>  			continue;
> -		if (xa_is_value(page))
> -			swapped++;
> +		if (xa_is_value(folio))
> +			swapped += folio_nr_pages(folio);

... you can't call folio_nr_pages() if xa_is_value().

