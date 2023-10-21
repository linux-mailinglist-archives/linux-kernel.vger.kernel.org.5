Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D37D1A47
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJUBZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:25:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3829CD6A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697851524; x=1729387524;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zLh2pwlSFXDc8f1T4HvmKnsr4cUsTKT+TV1gVp5dCqM=;
  b=JNHk2YquRcw9WrfxnSgd9ro56ijSWEFG68qq8f7YULqSUtnSyErgC4+x
   9wE8VcETLiCQJF+rrre80+nnQHX1UaXJixORfppkUTbSPWi04n2+hPjqV
   /uCTz9nuf2O85snfszwgq/pO76WXUzzOgwQ12vnrvEIQPaQBVGUXvU4+H
   NtN7fA1E4NGW/8CNnsmSVEFo2PbTm9jLrHDqTRC1rvEBWL5OtVbNxdgK3
   cy63dTlSprvmkyulX9Vek1ZbWD7EjPxEkut+34NjuGpTepmuTHdXTJv61
   mPWt40EgpS8voRx4sO51GxxSizdRDJdCs9SnoOX8g91eEzmJu53WvNrwP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="376978665"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="376978665"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5268878"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.224]) ([10.255.30.224])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:24:09 -0700
Message-ID: <f840af3a-45fe-477e-bd45-2bee95b8c8d5@linux.intel.com>
Date:   Sat, 21 Oct 2023 09:25:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH 1/2] iommufd/device: Drop enforce_cache_coherency in
 iommufd_device_do_replace
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        kevin.tian@intel.com
References: <cover.1697848510.git.nicolinc@nvidia.com>
 <5593200da9015fee7b2e8195c2998f36148d83de.1697848510.git.nicolinc@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5593200da9015fee7b2e8195c2998f36148d83de.1697848510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/21 8:37, Nicolin Chen wrote:
> According to the conversion in the following link:
> https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> 
> The enforce_cache_coherency should be set/enforced in the hwpt allocation
> routine. The iommu driver in its attach_dev() op should decide whether to
> reject or not a device that doesn't match with the configuration of cache
> coherency. Drop the enforce_cache_coherency piece in replace(). Also move
> the remaining "num_devices++" piece closer to the refcount that uses this
> num_devices.
> 
> Cc: stable@vger.kernel.org
> Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
> Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index e88fa73a45e6..c93f3478f808 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -429,16 +429,6 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>   		return NULL;
>   	}
>   
> -	/* Try to upgrade the domain we have */
> -	list_for_each_entry(cur, &igroup->device_list, group_item) {
> -		num_devices++;
> -		if (cur->enforce_cache_coherency) {
> -			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> -			if (rc)
> -				goto err_unlock;
> -		}
> -	}
> -
>   	old_hwpt = igroup->hwpt;
>   	if (hwpt->ioas != old_hwpt->ioas) {
>   		list_for_each_entry(cur, &igroup->device_list, group_item) {
> @@ -465,6 +455,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>   
>   	igroup->hwpt = hwpt;
>   
> +	list_for_each_entry(cur, &igroup->device_list, group_item)
> +		num_devices++;

Minor: How about using list_count_nodes()?

>   	/*
>   	 * Move the refcounts held by the device_list to the new hwpt. Retain a
>   	 * refcount for this thread as the caller will free it.

Either way,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
