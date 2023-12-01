Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345FF800AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378856AbjLAMeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378804AbjLAMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:34:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C75613E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:34:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881D51042;
        Fri,  1 Dec 2023 04:35:28 -0800 (PST)
Received: from [10.1.28.20] (e122027.cambridge.arm.com [10.1.28.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDE3B3F8A4;
        Fri,  1 Dec 2023 04:34:39 -0800 (PST)
Message-ID: <0220b97f-04fa-4811-b16b-ffdafc91648b@arm.com>
Date:   Fri, 1 Dec 2023 12:34:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/panfrost: Add gpu_irq, mmu_irq to struct
 panfrost_device
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        m.szyprowski@samsung.com, krzysztof.kozlowski@linaro.org
References: <20231201104027.35273-1-angelogioacchino.delregno@collabora.com>
 <20231201104027.35273-3-angelogioacchino.delregno@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231201104027.35273-3-angelogioacchino.delregno@collabora.com>
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
> In preparation for adding a IRQ synchronization mechanism for PM suspend
> add gpu_irq and mmu_irq variables to struct panfrost_device and change
> functions panfrost_gpu_init() and panfrost_mmu_init() to use those.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although this now makes the job IRQ look out of place - I'm not sure why
we have the struct panfrost_job_slot as a separately allocated structure
either. Anyway - that's irrelevant to this patch!

Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 10 +++++-----
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 10 +++++-----
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 0fc558db6bfd..54a8aad54259 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -94,6 +94,8 @@ struct panfrost_device {
>  	struct device *dev;
>  	struct drm_device *ddev;
>  	struct platform_device *pdev;
> +	int gpu_irq;
> +	int mmu_irq;
>  
>  	void __iomem *iomem;
>  	struct clk *clock;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index bd41617c5e4b..7adc4441fa14 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -454,7 +454,7 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>  
>  int panfrost_gpu_init(struct panfrost_device *pfdev)
>  {
> -	int err, irq;
> +	int err;
>  
>  	err = panfrost_gpu_soft_reset(pfdev);
>  	if (err)
> @@ -469,11 +469,11 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
>  
>  	dma_set_max_seg_size(pfdev->dev, UINT_MAX);
>  
> -	irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "gpu");
> -	if (irq < 0)
> -		return irq;
> +	pfdev->gpu_irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "gpu");
> +	if (pfdev->gpu_irq < 0)
> +		return pfdev->gpu_irq;
>  
> -	err = devm_request_irq(pfdev->dev, irq, panfrost_gpu_irq_handler,
> +	err = devm_request_irq(pfdev->dev, pfdev->gpu_irq, panfrost_gpu_irq_handler,
>  			       IRQF_SHARED, KBUILD_MODNAME "-gpu", pfdev);
>  	if (err) {
>  		dev_err(pfdev->dev, "failed to request gpu irq");
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 846dd697c410..ac4296c1e54b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -753,13 +753,13 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
>  
>  int panfrost_mmu_init(struct panfrost_device *pfdev)
>  {
> -	int err, irq;
> +	int err;
>  
> -	irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "mmu");
> -	if (irq < 0)
> -		return irq;
> +	pfdev->mmu_irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "mmu");
> +	if (pfdev->mmu_irq < 0)
> +		return pfdev->mmu_irq;
>  
> -	err = devm_request_threaded_irq(pfdev->dev, irq,
> +	err = devm_request_threaded_irq(pfdev->dev, pfdev->mmu_irq,
>  					panfrost_mmu_irq_handler,
>  					panfrost_mmu_irq_handler_thread,
>  					IRQF_SHARED, KBUILD_MODNAME "-mmu",

