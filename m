Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AA7FBB88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjK1N1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbjK1N1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:27:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7FA90
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:27:58 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32CC466072EC;
        Tue, 28 Nov 2023 13:27:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701178077;
        bh=kBc7Y+zosMPofwq2XTkvgCJWkVZoaNkjI56eoYzJNSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pq+7YeEIucLzH5N+I2HU0WykCkAZgYe0/9VwN3bvo4s2TUpSNiSlO8m/3Zx1XRPDd
         T1045eFgpJRHD9ohbGeKtsqOo2tBMMB6VBY37iStFSxDQxyL+4mpqVEzUr1npuJ3kr
         0kKMutpBGVi7u+zeSyE0ytUhH91NJ9Ns1wVgS83lD7Cz1x4uAL7xaJHs0K7Jdud8iM
         A3NXCultDMHXitq+5JLg4BtNz3HMwVSH8JdIyoseEYOAQdQ9PL6aXQI/ajcUHYJy4h
         q20dHf54jTD9rOqhsCRsGAbcjac2wuKtKo9XwJpW+wy5/XPz+tPABsmWgdaFF4Loya
         TzeN7tA05QHHg==
Date:   Tue, 28 Nov 2023 14:27:53 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 1/3] drm/panfrost: Ignore core_mask for poweroff and
 disable PWRTRANS irq
Message-ID: <20231128142753.5cd0c2fd@collabora.com>
In-Reply-To: <20231128124510.391007-2-angelogioacchino.delregno@collabora.com>
References: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
        <20231128124510.391007-2-angelogioacchino.delregno@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 13:45:08 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

