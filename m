Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE67FC990
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjK1Wd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjK1Wd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:33:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFEF219A4;
        Tue, 28 Nov 2023 14:34:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B808B1FB;
        Tue, 28 Nov 2023 14:34:48 -0800 (PST)
Received: from [10.57.71.132] (unknown [10.57.71.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B473F6C4;
        Tue, 28 Nov 2023 14:33:44 -0800 (PST)
Message-ID: <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
Date:   Tue, 28 Nov 2023 22:33:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] iommu/dma: use page allocation function provided by
 iommu-pages.h
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128204938.1453583-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> Convert iommu/dma-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.

These have nothing to do with IOMMU pagetables, they are DMA buffers and 
they belong to whoever called the corresponding dma_alloc_* function.

Thanks,
Robin.

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   drivers/iommu/dma-iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 85163a83df2f..822adad464c2 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -31,6 +31,7 @@
>   #include <linux/vmalloc.h>
>   
>   #include "dma-iommu.h"
> +#include "iommu-pages.h"
>   
>   struct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -874,7 +875,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   static void __iommu_dma_free_pages(struct page **pages, int count)
>   {
>   	while (count--)
> -		__free_page(pages[count]);
> +		__iommu_free_page(pages[count]);
>   	kvfree(pages);
>   }
>   
> @@ -912,7 +913,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   			order_size = 1U << order;
>   			if (order_mask > order_size)
>   				alloc_flags |= __GFP_NORETRY;
> -			page = alloc_pages_node(nid, alloc_flags, order);
> +			page = __iommu_alloc_pages_node(nid, alloc_flags,
> +							order);
>   			if (!page)
>   				continue;
>   			if (order)
> @@ -1572,7 +1574,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>   
>   	page = dma_alloc_contiguous(dev, alloc_size, gfp);
>   	if (!page)
> -		page = alloc_pages_node(node, gfp, get_order(alloc_size));
> +		page = __iommu_alloc_pages_node(node, gfp, get_order(alloc_size));
>   	if (!page)
>   		return NULL;
>   
