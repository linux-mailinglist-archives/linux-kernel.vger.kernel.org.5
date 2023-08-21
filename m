Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C0782942
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjHUMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjHUMio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:38:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA2EC2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f3PuHd+3Oo29kL/k7GHTJhIOx0IaiYuSIgTjmSIW73E=; b=QCHoLk5S5S1i0rIVGjBE6qUveQ
        RX+Xy4MHXX1/Al/BtxdRkyzbzDU39wSegEAp+k+hqGXQFMesZxmLsM/qKNSq/BdEagjkFIWkhbisM
        MAcRyd/rbI+lgkwfpwJeJnEe0v7k5U5FavE337DcvxcXs2zwJW1xafvO1Bc0OCI9oJJ11dAhJ7Hdo
        mO47LaLLNcmT0xKqZEPoCDPq0yAobV1fFqQNolS9K9WmvXesmrx1wv/GXEOHMZiThV3tGpAs1i5yR
        OXfPGWAzItW5axn4E4PQyIYJTQFtoRU0yQFTbC0V9sxefQxEiOar/acB3NARL+SZj0cuY86eUILOw
        pLqHlqqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY4B1-00ADDJ-AW; Mon, 21 Aug 2023 12:38:35 +0000
Date:   Mon, 21 Aug 2023 13:38:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        david@redhat.com, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 1/8] mm: migrate: remove PageTransHuge check in
 numamigrate_isolate_page()
Message-ID: <ZONay3H/RB381x8a@casper.infradead.org>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821115624.158759-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 07:56:17PM +0800, Kefeng Wang wrote:
> Since we begin to convert the numa migration code to use folio, which
> could let us to handle arbitrary sizes of folio, so drop assert that
> we only support PageTransHuge page(PMD size) when order > 0.

Have you looked at the implementation of PageTransHuge()?  Your
description doesn't match what the code does.

> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b7fa020003f3..646d8ee7f102 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2483,8 +2483,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
>  
> -	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
> -
>  	/* Do not migrate THP mapped by multiple processes */
>  	if (PageTransHuge(page) && total_mapcount(page) > 1)
>  		return 0;
> -- 
> 2.41.0
> 
> 
