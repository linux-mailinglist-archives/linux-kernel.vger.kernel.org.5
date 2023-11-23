Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693B47F5D83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjKWLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344907AbjKWLNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:13:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 251B5D49;
        Thu, 23 Nov 2023 03:13:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C701042;
        Thu, 23 Nov 2023 03:14:16 -0800 (PST)
Received: from [10.57.70.183] (unknown [10.57.70.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502F33F73F;
        Thu, 23 Nov 2023 03:13:28 -0800 (PST)
Message-ID: <2ba7bab4-daee-4883-acd4-ec9a10c82103@arm.com>
Date:   Thu, 23 Nov 2023 11:13:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Don't reserve IOVA when address and size are zero
To:     Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org,
        will@kernel.org, robh@kernel.org, treding@nvidia.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20231123061201.16614-1-amhetre@nvidia.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231123061201.16614-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-23 6:12 am, Ashish Mhetre wrote:
> When the bootloader/firmware doesn't setup the framebuffers, their
> address and size are zero in "iommu-addresses" property. If we intend to
> use display driver in kernel without framebuffer then it's causing
> the display IOMMU mappings to fail as IOVA is reserved with size and
> address as zero.

Can you clarify the problem there? Looking at the code in 
iova_reserve_iommu_regions() I'm guessing it's that "region->start + 
region->length - 1" underflows so reserve_iova() actually ends up 
reserving the entire valid IOVA space?

> An ideal solution would be firmware removing the "iommu-addresses"
> property and corresponding "memory-region" if display is not present.
> But the kernel should be able to handle this by checking for size and
> address of IOVA and skipping the IOVA reservation if both are 0.

Surely it doesn't make sense to reserve a 0-length region at *any* base 
address? The symptom above wouldn't be quite the same if the base was 
nonzero, but corrupting the rbtree with an entry where pfn_hi < pfn_lo 
would definitely not be good either.

> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 157b286e36bf..150ef65d357a 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -255,6 +255,10 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				size_t length;
>   
>   				maps = of_translate_dma_region(np, maps, &iova, &length);
> +				if (iova == 0 && length == 0) {
> +					dev_dbg(dev, "Skipping IOVA reservation as address and size are zero\n");

FWIW I'd be inclined to log a visible warning that firmware is giving us 
nonsense.

Thanks,
Robin.

> +					continue;
> +				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
>   				region = iommu_alloc_resv_region(iova, length, prot, type,
