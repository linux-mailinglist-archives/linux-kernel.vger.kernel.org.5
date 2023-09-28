Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CB7B1066
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI1Bg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Bgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:36:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0647BB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 18:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695865012; x=1727401012;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k2IBvK6ZA6AxFCZCz+4sX+cJsNm9cNzhfSFcC+S7MHU=;
  b=BSvzKdzmkvFosb1uGAfg8ntSqZ/i0HvNP+Uz5A9hWsJwlP91IC8aH2Am
   qBYV2QCEtfWTYxqvuCEkGqwSyc3sHv41F2Da0zkQFVo7NKv5euaCXus/5
   zfCvwGN4QmHva3pIMgKyFlL5/i1xw3AAxunn37MjMxVXJIImdDPiNJCKD
   Alwks1FzrRVYtbwrsS+R0vnnmqRtSbHbbUC4eX8FM6xMl11gusPBuvjQs
   VLObHmlgBgZtIT2sY11MTKkKzJ8v9KkXrrZrXArdRgZA2mqL/mpDS74wh
   iHG63pkjMTcn1hx7dc2bZ4Kl3PPG0YkoT60s1pG1ZWusyG/rjRh04phJe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="379240974"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="379240974"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 18:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778746235"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="778746235"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 18:36:44 -0700
Message-ID: <7c7b8981-022c-2fa8-7ee5-9c97d8e17862@linux.intel.com>
Date:   Thu, 28 Sep 2023 09:33:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, robin.murphy@arm.com, jgg@nvidia.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Sanity check on param list for
 iommu_get_resv_regions
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, joro@8bytes.org, will@kernel.org
References: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 10:25 PM, Dawei Li wrote:
> In iommu_get_resv_regions(), param list is an argument supplied by caller,
> into which callee is supposed to insert resv regions.
> 
> In other words, this 'list' argument is expected to be an empty list,
> so make an explicit annotation on it.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   drivers/iommu/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1ecac2b5c54f..a01c4a7a9d19 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -813,7 +813,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>   
>   	mutex_lock(&group->mutex);
>   	for_each_group_device(group, device) {
> -		struct list_head dev_resv_regions;
> +		LIST_HEAD(dev_resv_regions);
>   
>   		/*
>   		 * Non-API groups still expose reserved_regions in sysfs,
> @@ -822,7 +822,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>   		if (!device->dev->iommu)
>   			break;
>   
> -		INIT_LIST_HEAD(&dev_resv_regions);
>   		iommu_get_resv_regions(device->dev, &dev_resv_regions);
>   		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
>   		iommu_put_resv_regions(device->dev, &dev_resv_regions);
> @@ -1061,12 +1060,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>   					       struct device *dev)
>   {
>   	struct iommu_resv_region *entry;
> -	struct list_head mappings;
>   	unsigned long pg_size;
> +	LIST_HEAD(mappings);
>   	int ret = 0;
>   
>   	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
> -	INIT_LIST_HEAD(&mappings);
>   
>   	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
>   		return -EINVAL;
> @@ -2813,6 +2811,9 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> +	if (WARN_ON(!list_empty(list)))
> +		return;

I don't understand why the input list *must* be empty. This interface
has already been exported, so please update the comment to explain this
new requirement.

> +
>   	if (ops->get_resv_regions)
>   		ops->get_resv_regions(dev, list);
>   }

Best regards,
baolu
