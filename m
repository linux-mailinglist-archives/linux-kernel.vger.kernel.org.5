Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C22B79BFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355960AbjIKWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbjIKTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:06:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90991D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:06:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA228D75;
        Mon, 11 Sep 2023 12:06:56 -0700 (PDT)
Received: from [10.57.0.19] (unknown [10.57.0.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A09A3F738;
        Mon, 11 Sep 2023 12:06:17 -0700 (PDT)
Message-ID: <40649946-739b-fec6-d743-f7828613fec5@arm.com>
Date:   Mon, 11 Sep 2023 20:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] iommu/sun50i: Allow page sizes between 4K and 1M
Content-Language: en-GB
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, joro@8bytes.org,
        will@kernel.org
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230911190218.1758812-1-jernej.skrabec@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230911190218.1758812-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-11 20:02, Jernej Skrabec wrote:
> While peripheral supports only 4K page sizes, we can easily emulate
> support for bigger page sizes, up to 1M. This is done by making multiple
> entries in map function or clearing multiple entries in unmap.

No, it's done by converting over to the {map,unmap}_pages ops. There's 
no need to resurrect this horrible bodge.

Thanks,
Robin.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 49 +++++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 74c5cb93e900..93077575d60f 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -95,6 +95,10 @@
>   
>   #define SPAGE_SIZE			4096
>   
> +#define SUN50I_IOMMU_PGSIZES		(SZ_4K | SZ_8K | SZ_16K | SZ_32K | \
> +					 SZ_64K | SZ_128K | SZ_256K | \
> +					 SZ_512K | SZ_1M)
> +
>   struct sun50i_iommu {
>   	struct iommu_device iommu;
>   
> @@ -593,10 +597,12 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
>   {
>   	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
>   	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> -	u32 pte_index;
> +	u32 pte_index, pages, i;
>   	u32 *page_table, *pte_addr;
>   	int ret = 0;
>   
> +	pages = size / SPAGE_SIZE;
> +
>   	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
>   	if (IS_ERR(page_table)) {
>   		ret = PTR_ERR(page_table);
> @@ -604,18 +610,22 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
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
> +	for (i = 0; i < pages; i++) {
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
> +	sun50i_table_flush(sun50i_domain, &page_table[pte_index], pages);
>   
>   out:
>   	return ret;
> @@ -626,8 +636,10 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
>   {
>   	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
>   	phys_addr_t pt_phys;
> +	u32 dte, pages, i;
>   	u32 *pte_addr;
> -	u32 dte;
> +
> +	pages = size / SPAGE_SIZE;
>   
>   	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
>   	if (!sun50i_dte_is_pt_valid(dte))
> @@ -636,13 +648,14 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
>   	pt_phys = sun50i_dte_get_pt_address(dte);
>   	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
>   
> -	if (!sun50i_pte_is_page_valid(*pte_addr))
> -		return 0;
> +	for (i = 0; i < pages; i++)
> +		if (!sun50i_pte_is_page_valid(pte_addr[i]))
> +			return 0;
>   
> -	memset(pte_addr, 0, sizeof(*pte_addr));
> -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +	memset(pte_addr, 0, sizeof(*pte_addr) * pages);
> +	sun50i_table_flush(sun50i_domain, pte_addr, pages);
>   
> -	return SZ_4K;
> +	return size;
>   }
>   
>   static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
> @@ -827,7 +840,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
>   }
>   
>   static const struct iommu_ops sun50i_iommu_ops = {
> -	.pgsize_bitmap	= SZ_4K,
> +	.pgsize_bitmap	= SUN50I_IOMMU_PGSIZES,
>   	.device_group	= sun50i_iommu_device_group,
>   	.domain_alloc	= sun50i_iommu_domain_alloc,
>   	.of_xlate	= sun50i_iommu_of_xlate,
