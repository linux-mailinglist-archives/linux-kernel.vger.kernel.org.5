Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D797A40BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjIRFxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbjIRFxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:53:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D6127
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695016373; x=1726552373;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lr2VLEqOOl6l6fFZ2myn82dovZkpVyL1rsDIF1sxlRg=;
  b=Xd88YunwNVhyPjU3VhY9jA3XCHeoMqVU/tM+VcvjGm4zyNYPWq/X6Hsm
   q7SPeY/jZNryaCfkfSlHxce3x+RB1UNY1ntDDf5HMljjC0SCumcU1kcjy
   aYjjJJYff77FDC8xNP6H6qJsLA2QXrw5XbvF4dLBGPDOruIt034rD6x3S
   9Rz/s+yWsaXzobeatyn5MtyEI+RNBzqkfB2VkfU0nA352AZt3vLfLzPku
   WvAggD18yc/TOXWgdMf8OQ/MxlhWrS7QSPrSWc9OLnV/dA4lE/IBWz3zP
   xv2IA2IjiuPYQMXtpv+P3XuED5oYQd9FTTgLCY5oD/AmlrTBUb8+/T818
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359825864"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="359825864"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 22:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815887772"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="815887772"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2023 22:52:48 -0700
Message-ID: <a39dcdcb-e904-a09d-f553-66bac5257205@linux.intel.com>
Date:   Mon, 18 Sep 2023 13:49:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jgg@nvidia.com
Subject: Re: [PATCH v3 3/7] iommu: Validate that devices match domains
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1694693889.git.robin.murphy@arm.com>
 <d29334e44c0e6489629dbe13c969c47d4285a877.1694693889.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d29334e44c0e6489629dbe13c969c47d4285a877.1694693889.git.robin.murphy@arm.com>
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

On 9/16/23 12:58 AM, Robin Murphy wrote:
> Before we can allow drivers to coexist, we need to make sure that one
> driver's domain ops can't misinterpret another driver's dev_iommu_priv
> data. To that end, add a token to the domain so we can remember how it
> was allocated - for now this may as well be the device ops, since they
> still correlate 1:1 with drivers. We can trust ourselves for internal
> default domain attachment, so add the check where it covers both the
> external attach interfaces.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 13 +++++++++----
>   include/linux/iommu.h |  1 +
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2f29ee9dea64..f4cc91227b22 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2000,26 +2000,28 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
>   static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
>   						 unsigned type)
>   {
> +	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
>   	struct iommu_domain *domain;
>   	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
>   
> -	if (bus == NULL || bus->iommu_ops == NULL)
> +	if (!ops)
>   		return NULL;
>   
> -	domain = bus->iommu_ops->domain_alloc(alloc_type);
> +	domain = ops->domain_alloc(alloc_type);
>   	if (!domain)
>   		return NULL;
>   
>   	domain->type = type;
> +	domain->owner = ops;
>   	/*
>   	 * If not already set, assume all sizes by default; the driver
>   	 * may override this later
>   	 */
>   	if (!domain->pgsize_bitmap)
> -		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +		domain->pgsize_bitmap = ops->pgsize_bitmap;
>   
>   	if (!domain->ops)
> -		domain->ops = bus->iommu_ops->default_domain_ops;
> +		domain->ops = ops->default_domain_ops;
>   
>   	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
>   		iommu_domain_free(domain);
> @@ -2176,6 +2178,9 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   	    group->domain != group->blocking_domain)
>   		return -EBUSY;
>   
> +	if (dev_iommu_ops(iommu_group_first_dev(group)) != domain->owner)
> +		return -EINVAL;

Should we apply this check in iommu_attach_device_pasid()?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..43acf1b8ed56 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3414,6 +3414,9 @@ int iommu_attach_device_pasid(struct iommu_domain 
*domain,
         if (!group)
                 return -ENODEV;

+       if (dev_iommu_ops(dev) != domain->owner)
+               return -EINVAL;
+
         mutex_lock(&group->mutex);
         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {

> +
>   	return __iommu_group_set_domain(group, domain);
>   }
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a249e10c8e9f..75ffcac199e3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -95,6 +95,7 @@ struct iommu_domain_geometry {
>   struct iommu_domain {
>   	unsigned type;
>   	const struct iommu_domain_ops *ops;
> +	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>   	struct iommu_domain_geometry geometry;
>   	struct iommu_dma_cookie *iova_cookie;

Best regards,
baolu
