Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356A800AF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378845AbjLAMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378804AbjLAMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:34:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6380C13E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:34:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84FF91007;
        Fri,  1 Dec 2023 04:35:26 -0800 (PST)
Received: from [10.1.28.20] (e122027.cambridge.arm.com [10.1.28.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B87CF3F5A1;
        Fri,  1 Dec 2023 04:34:37 -0800 (PST)
Message-ID: <865217b6-f4bc-410c-ba5b-f765c03d6002@arm.com>
Date:   Fri, 1 Dec 2023 12:34:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/panfrost: Ignore core_mask for poweroff and
 disable PWRTRANS irq
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        m.szyprowski@samsung.com, krzysztof.kozlowski@linaro.org
References: <20231201104027.35273-1-angelogioacchino.delregno@collabora.com>
 <20231201104027.35273-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231201104027.35273-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 10:40, AngeloGioacchino Del Regno wrote:
> Some SoCs may be equipped with a GPU containing two core groups
> and this is exactly the case of Samsung's Exynos 5422 featuring
> an ARM Mali-T628 MP6 GPU: the support for this GPU in Panfrost
> is partial, as this driver currently supports using only one
> core group and that's reflected on all parts of it, including
> the power on (and power off, previously to this patch) function.
> 
> The issue with this is that even though executing the soft reset
> operation should power off all cores unconditionally, on at least
> one platform we're seeing a crash that seems to be happening due
> to an interrupt firing which may be because we are calling power
> transition only on the first core group, leaving the second one
> unchanged, or because ISR execution was pending before entering
> the panfrost_gpu_power_off() function and executed after powering
> off the GPU cores, or all of the above.
> 
> Finally, solve this by:
>  - Avoid to enable the power transition interrupt on reset; and
>  - Ignoring the core_mask and ask the GPU to poweroff both core groups
> 
> Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 09f5e1563ebd..bd41617c5e4b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -78,7 +78,12 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>  	}
>  
>  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_MASK_ALL);
> -	gpu_write(pfdev, GPU_INT_MASK, GPU_IRQ_MASK_ALL);
> +
> +	/* Only enable the interrupts we care about */
> +	gpu_write(pfdev, GPU_INT_MASK,
> +		  GPU_IRQ_MASK_ERROR |
> +		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED |
> +		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
>  
>  	/*
>  	 * All in-flight jobs should have released their cycle
> @@ -425,11 +430,10 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
>  
>  void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>  {
> -	u64 core_mask = panfrost_get_core_mask(pfdev);
>  	int ret;
>  	u32 val;
>  
> -	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present & core_mask);
> +	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
>  	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
>  					 val, !val, 1, 1000);
>  	if (ret)
> @@ -441,7 +445,7 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>  	if (ret)
>  		dev_err(pfdev->dev, "tiler power transition timeout");
>  
> -	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present & core_mask);
> +	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
>  	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
>  				 val, !val, 0, 1000);
>  	if (ret)

