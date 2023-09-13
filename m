Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1986B79F2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjIMUU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIMUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:20:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 012641BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:20:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9776D1FB;
        Wed, 13 Sep 2023 13:21:00 -0700 (PDT)
Received: from [10.57.93.239] (unknown [10.57.93.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E20A63F738;
        Wed, 13 Sep 2023 13:20:21 -0700 (PDT)
Message-ID: <157d5041-96ac-6bad-9137-19a78fbf3591@arm.com>
Date:   Wed, 13 Sep 2023 21:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] iommu/sun50i: Convert to map_pages/unmap_pages
Content-Language: en-GB
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, joro@8bytes.org,
        will@kernel.org
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230912181941.2971036-1-jernej.skrabec@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230912181941.2971036-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 19:19, Jernej Skrabec wrote:
> Convert driver to use map_pages and unmap_pages. Since functions operate
> on page table, extend them to be able to operate on whole table, not
> just one entry.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
> Hi!
> 
> I'm not sure if it makes sense to check validity of page table entry when
> unmaping pages makes sense. What do you think?

As things currently stand it's largely a matter of opinion - some 
drivers consider that unmapping something which hasn't been mapped is 
nonsensical, and almost always represents the caller having gone wrong, 
thus report it as an error; others take the view that as long as they 
can achieve the requested end result, they're not going to think too 
hard about how they got there. The same arguments apply to whether you'd 
quietly replace an existing PTE or not when mapping, so I'd say the main 
thing is to at least be self-consistent one way or the other.

Cheers,
Robin.

> 
> Best regards,
> Jernej
> 
>   drivers/iommu/sun50i-iommu.c | 55 +++++++++++++++++++++---------------
>   1 file changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 74c5cb93e900..be6102730a56 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -589,11 +589,12 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
>   }
>   
>   static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
> -			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			    int prot, gfp_t gfp, size_t *mapped)
>   {
>   	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
>   	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> -	u32 pte_index;
> +	u32 pte_index, count, i;
>   	u32 *page_table, *pte_addr;
>   	int ret = 0;
>   
> @@ -604,45 +605,55 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	}
>   
>   	pte_index = sun50i_iova_get_pte_index(iova);
> -	pte_addr = &page_table[pte_index];
> -	if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
> -		phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
> -		dev_err(iommu->dev,
> -			"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
> -			&iova, &page_phys, &paddr, prot);
> -		ret = -EBUSY;
> -		goto out;
> +	count = min(pgcount, (size_t)NUM_PT_ENTRIES - pte_index);
> +	for (i = 0; i < count; i++) {
> +		pte_addr = &page_table[pte_index + i];
> +		if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
> +			phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
> +
> +			dev_err(iommu->dev,
> +				"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
> +				&iova, &page_phys, &paddr, prot);
> +			ret = -EBUSY;
> +			goto out;
> +		}
> +		*pte_addr = sun50i_mk_pte(paddr, prot);
> +		paddr += SPAGE_SIZE;
>   	}
>   
> -	*pte_addr = sun50i_mk_pte(paddr, prot);
> -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +	sun50i_table_flush(sun50i_domain, &page_table[pte_index], i);
> +	*mapped = i * SPAGE_SIZE;
>   
>   out:
>   	return ret;
>   }
>   
>   static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> -				 size_t size, struct iommu_iotlb_gather *gather)
> +				 size_t pgsize, size_t pgcount,
> +				 struct iommu_iotlb_gather *gather)
>   {
>   	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
> +	u32 dte, count, i, pte_index;
>   	phys_addr_t pt_phys;
>   	u32 *pte_addr;
> -	u32 dte;
>   
>   	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
>   	if (!sun50i_dte_is_pt_valid(dte))
>   		return 0;
>   
>   	pt_phys = sun50i_dte_get_pt_address(dte);
> -	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
> +	pte_index = sun50i_iova_get_pte_index(iova);
> +	pte_addr = (u32 *)phys_to_virt(pt_phys) + pte_index;
>   
> -	if (!sun50i_pte_is_page_valid(*pte_addr))
> -		return 0;
> +	count = min(pgcount, (size_t)NUM_PT_ENTRIES - pte_index);
> +	for (i = 0; i < count; i++)
> +		if (!sun50i_pte_is_page_valid(pte_addr[i]))
> +			break;
>   
> -	memset(pte_addr, 0, sizeof(*pte_addr));
> -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +	memset(pte_addr, 0, sizeof(*pte_addr) * i);
> +	sun50i_table_flush(sun50i_domain, pte_addr, i);
>   
> -	return SZ_4K;
> +	return i * SPAGE_SIZE;
>   }
>   
>   static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
> @@ -838,8 +849,8 @@ static const struct iommu_ops sun50i_iommu_ops = {
>   		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
>   		.iotlb_sync	= sun50i_iommu_iotlb_sync,
>   		.iova_to_phys	= sun50i_iommu_iova_to_phys,
> -		.map		= sun50i_iommu_map,
> -		.unmap		= sun50i_iommu_unmap,
> +		.map_pages	= sun50i_iommu_map,
> +		.unmap_pages	= sun50i_iommu_unmap,
>   		.free		= sun50i_iommu_domain_free,
>   	}
>   };
