Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD27C6524
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377184AbjJLGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJLGIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:08:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82CA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697090929; x=1728626929;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vnvBwkspZUy3N5RRakd9NDz8RSPL4W2JB+T3C/ANT28=;
  b=TtU/Aday6waleFCLs6Lh4WT7VKJejGAgxLASlghF28PdcL75gYcKQtoR
   tCi2Uk/4tVvhlLo2tS3jteNld5p7H1mD0XVwNs/kpZVCV/KmnKRyrgA2y
   0xJ/pjLVnMGfs+SMYB7lbtN7bnworui6nKz4B5zfVXQq7/A0/Y7ax4xBr
   b4UYOg3Yx+hI4pquytV4USq5wYro0sMdLIUNtm/I2gEcgAL3b3B796LjZ
   gAylKhFwysZcZ9nuUQAqQti7zld2dIU7/3h9Wu5Uz6Cjq0c/yuj5ikT2E
   O3HM+Oc8UPRMXqaxMru+u/uBrH/+6W3oWlm5m+YV1STdi+dWdDRe+ytCB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="375194946"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="375194946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 23:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="789259868"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="789259868"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2023 23:08:46 -0700
Message-ID: <43ca2a88-942e-4d65-87f1-30a7cf537edd@linux.intel.com>
Date:   Thu, 12 Oct 2023 14:05:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1697047261.git.robin.murphy@arm.com>
 <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 2:14 AM, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down the
> road and just rework it to preserve the current behaviour without
> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup

The iommu_present() is only used in below two drivers.

$ git grep iommu_present
drivers/gpu/drm/mediatek/mtk_drm_drv.c: if 
(!iommu_present(&platform_bus_type))
drivers/gpu/drm/tegra/drm.c:    if (host1x_drm_wants_iommu(dev) && 
iommu_present(&platform_bus_type)) {

Both are platform drivers and have the device pointer passed in. Just
out of curiosity, why not replacing them with device_iommu_mapped()
instead? Sorry if I overlooked previous discussion.

Best regards,
baolu

> to IOMMU device registration"), any registered IOMMU instance is already
> considered "present" for every entry in iommu_buses, so it's simply a
> case of validating the bus and checking we have at least once IOMMU.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Tweak to use the ops-based check rather than group-based, to
>      properly match the existing behaviour
> v4: Just look for IOMMU instances instead of managed devices
> ---
>   drivers/iommu/iommu.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5a3ce293a5de..7bb92e8b7a49 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2000,9 +2000,28 @@ int bus_iommu_probe(const struct bus_type *bus)
>   	return 0;
>   }
>   
> +/**
> + * iommu_present() - make platform-specific assumptions about an IOMMU
> + * @bus: bus to check
> + *
> + * Do not use this function. You want device_iommu_mapped() instead.
> + *
> + * Return: true if some IOMMU is present and aware of devices on the given bus;
> + * in general it may not be the only IOMMU, and it may not have anything to do
> + * with whatever device you are ultimately interested in.
> + */
>   bool iommu_present(const struct bus_type *bus)
>   {
> -	return bus->iommu_ops != NULL;
> +	bool ret = false;
> +
> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +		if (iommu_buses[i] == bus) {
> +			spin_lock(&iommu_device_lock);
> +			ret = !list_empty(&iommu_device_list);
> +			spin_unlock(&iommu_device_lock);
> +		}
> +	}
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_present);
>   
