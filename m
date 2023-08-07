Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE07724B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjHGMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjHGMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:49:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2408710FE;
        Mon,  7 Aug 2023 05:49:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76FA41FB;
        Mon,  7 Aug 2023 05:50:25 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B8523F64C;
        Mon,  7 Aug 2023 05:49:40 -0700 (PDT)
Message-ID: <3c387223-eb0e-a8af-b9de-20235d7337fa@arm.com>
Date:   Mon, 7 Aug 2023 13:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iommu: Explicitly include correct DT includes
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20230714174640.4058404-1-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230714174640.4058404-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 6:46 pm, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.

Thanks Rob; FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

I guess you're hoping for Joerg to pick this up? However I wouldn't 
foresee any major conflicts if you do need to take it through the OF tree.

Cheers,
Robin.

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c            | 1 -
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c          | 3 +--
>   drivers/iommu/ipmmu-vmsa.c                       | 1 -
>   drivers/iommu/sprd-iommu.c                       | 1 +
>   drivers/iommu/tegra-smmu.c                       | 2 +-
>   drivers/iommu/virtio-iommu.c                     | 2 +-
>   7 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index b5b14108e086..bb89d49adf8d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> @@ -3,7 +3,7 @@
>    * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
> -#include <linux/of_device.h>
> +#include <linux/device.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/ratelimit.h>
>   
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index a86acd76c1df..d6d1a2a55cc0 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -29,7 +29,6 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> -#include <linux/of_device.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index a503ed758ec3..cc3f68a3516c 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -22,8 +22,7 @@
>   #include <linux/init.h>
>   #include <linux/mutex.h>
>   #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm.h>
>   #include <linux/pm_runtime.h>
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9f64c5c9f5b9..0aeedd3e1494 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -17,7 +17,6 @@
>   #include <linux/io-pgtable.h>
>   #include <linux/iommu.h>
>   #include <linux/of.h>
> -#include <linux/of_device.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/sizes.h>
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 39e34fdeccda..51144c232474 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -14,6 +14,7 @@
>   #include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/slab.h>
>   
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 1cbf063ccf14..e445f80d0226 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -9,7 +9,7 @@
>   #include <linux/iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3551ed057774..17dcd826f5c2 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -13,7 +13,7 @@
>   #include <linux/interval_tree.h>
>   #include <linux/iommu.h>
>   #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>   #include <linux/pci.h>
>   #include <linux/virtio.h>
>   #include <linux/virtio_config.h>
