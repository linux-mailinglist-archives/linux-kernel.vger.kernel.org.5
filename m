Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2739F7E1077
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjKDRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjKDRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 13:21:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5D1BF;
        Sat,  4 Nov 2023 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iZ7+BGlL3zWN+SVM8jQZNXOzKUk6jFAu7ijAJTmB0CI=; b=nfkprV5s7Ii9/+5g7i9kwyvnLm
        9Gm2ylhNX07Mcj2zN9mgCu9+DxcLZ3UgS3QQxSO4OZZdQy2S7lT4iDB1F+nThKOHHsoZPPe40CYdu
        3ALSQt7gJ6IHC0+PgArkPOTU5/RnPjM43yamW8uDNR3wwkqVnSTZFGf2ZJ3N5xgNtDcUrSwgnBaGK
        mDg0kdZxD6h98WEsw1MS8Qa3XiW2yHZvU31Tzfrs9IeM+YMEK2lw7XD+VMzqaD367KAMcuIuo+hTz
        Jls2hnyGZQVzlcXPoE1VZlhxf3IfGTv4V3PegJNCPA3q7QJfyzidJjZAPfPEPbpJpp2a0s/Nriv6D
        JAVjTYSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qzKKM-00CZqt-UJ; Sat, 04 Nov 2023 17:20:55 +0000
Date:   Sat, 4 Nov 2023 17:20:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 06/10] mm: memory: use a folio in zap_pte_range()
Message-ID: <ZUZ9dg4YHZdUKDqO@casper.infradead.org>
References: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
 <20231104035522.2418660-7-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104035522.2418660-7-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:55:18AM +0800, Kefeng Wang wrote:
> -/* Decides whether we should zap this page with the page pointer specified */
> -static inline bool should_zap_page(struct zap_details *details, struct page *page)
> +/* Decides whether we should zap this folio with the folio pointer specified */
> +static inline bool should_zap_page(struct zap_details *details, struct folio *folio)

Surely we should rename this to should_zap_folio()?

> @@ -1487,10 +1492,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			 * see zap_install_uffd_wp_if_needed().
>  			 */
>  			WARN_ON_ONCE(!vma_is_anonymous(vma));
> -			rss[mm_counter(page)]--;
> +			rss[mm_counter(&folio->page)]--;
>  			if (is_device_private_entry(entry))
> -				page_remove_rmap(page, vma, false);
> -			put_page(page);
> +				page_remove_rmap(&folio->page, vma, false);
> +			folio_put(folio);

This is wrong.  If we have a PTE-mapped THP, you'll remove the head page
N times instead of removing each of N pages.

I suspect you're going to collide with Ryan's work by doing this ...
