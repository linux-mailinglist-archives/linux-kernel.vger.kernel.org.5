Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30E7B0AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjI0RAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjI0RAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFFF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED933C433C9;
        Wed, 27 Sep 2023 17:00:35 +0000 (UTC)
Date:   Wed, 27 Sep 2023 18:00:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] bootmem: use kmemleak_free_part_phys in
 free_bootmem_page/put_page_bootmem
Message-ID: <ZRRfsf2tnUIuA+94@arm.com>
References: <20230927035923.1425340-1-liushixin2@huawei.com>
 <20230927035923.1425340-2-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035923.1425340-2-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:59:21AM +0800, Liu Shixin wrote:
> Since kmemleak_alloc_phys() rather than kmemleak_alloc() was called from
> memblock_alloc_range_nid(), kmemleak_free_part_phys() should be used to
> delete kmemleak object in free_bootmem_page() and put_page_bootmem().
> 
> Fixes: 028725e73375 ("bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page")
> Fixes: dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in put_page_bootmem")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

>  include/linux/bootmem_info.h | 2 +-
>  mm/bootmem_info.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index e1a3c9c9754c..cffa38a73618 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -60,7 +60,7 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
>  
>  static inline void free_bootmem_page(struct page *page)
>  {
> -	kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
> +	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);

We have a page_to_phys(), though it looks like the generic
implementation (wrongly) assumes a dma_addr_t type rather than
phys_addr_t. We have phys_do_dma() for such conversion as it needs to
take the device into account, so I guess most page_to_phys() uses under
drivers/ are wrong.

Maybe as a separate series clean-up those page_to_phys() uses in
drivers.

>  	free_reserved_page(page);
>  }
>  #endif
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index b1efebfcf94b..fa7cb0c87c03 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -34,7 +34,7 @@ void put_page_bootmem(struct page *page)
>  		ClearPagePrivate(page);
>  		set_page_private(page, 0);
>  		INIT_LIST_HEAD(&page->lru);
> -		kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
> +		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
>  	}
>  }
> -- 
> 2.25.1

-- 
Catalin
