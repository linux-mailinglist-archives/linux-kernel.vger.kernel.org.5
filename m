Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B57ADCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjIYQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:19:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332B1B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:19:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9199DDA7;
        Mon, 25 Sep 2023 09:19:45 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB443F59C;
        Mon, 25 Sep 2023 09:19:05 -0700 (PDT)
Message-ID: <3b116df9-cdaa-a6f8-6e5d-8865eefc31ce@arm.com>
Date:   Mon, 25 Sep 2023 17:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

I think you want the "out" label here, so that "mapped" is still updated 
and the core knows how much to undo on failure. I guess one could argue 
that the pagetables are already messed up if that happens, but it still 
doesn't seem like a good reason to deliberately compound the problem by 
leaving behind even more "unexpected" entries.

Thanks,
Robin.

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
