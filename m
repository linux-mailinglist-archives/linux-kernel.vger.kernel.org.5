Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BAE7FC21A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbjK1OGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345463AbjK1OGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:06:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A501BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:06:17 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 203FF66020EE;
        Tue, 28 Nov 2023 14:06:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701180375;
        bh=BeGFMXqQNnwSAvSoTab+xhTNp0QLj8WV+WogQaN7kgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fITqgi3xuq9T2gdBtj2+QArt1iPmNMtSQkyY+P/0N95XzzSdFbY6V3zHR2PI5LpeW
         9gQc9Ni9AzXSv6E/K4N1XUz5+DTJoR9SpjTxdWWXtSrXwa5/Eyy3z1Xxbi3Lrx4Ex1
         QC7Oh8thJT+Mo5PWsNVJrXcng5tWUj4cwlgBogto4sEcpbLCUGMd03i+E+UKbMK42B
         8cOsI44kcUSTamVkvcFOLkw/6xsoyxmyflcXsWEkxzkwONnd4vc0WVV3u9qO5aY/ce
         PHqyU3GHbY2wNE5lB9VQheKfnZVDMDe1dAiLw9p6udVoNnXR+Tce+I1jVPdJRPVY+3
         LpyKuI73jhBiw==
Date:   Tue, 28 Nov 2023 15:06:12 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 3/3] drm/panfrost: Synchronize and disable interrupts
 before powering off
Message-ID: <20231128150612.17f6a095@collabora.com>
In-Reply-To: <20231128124510.391007-4-angelogioacchino.delregno@collabora.com>
References: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
        <20231128124510.391007-4-angelogioacchino.delregno@collabora.com>
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

On Tue, 28 Nov 2023 13:45:10 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> To make sure that we don't unintentionally perform any unclocked and/or
> unpowered R/W operation on GPU registers, before turning off clocks and
> regulators we must make sure that no GPU, JOB or MMU ISR execution is
> pending: doing that required to add a mechanism to synchronize the
> interrupts on suspend.
> 
> Add functions panfrost_{gpu,job,mmu}_suspend_irq() which will perform
> interrupts masking and ISR execution synchronization, and then call
> those in the panfrost_device_runtime_suspend() handler in the exact
> sequence of job (may require mmu!) -> mmu -> gpu.
> 
> As a side note, JOB and MMU suspend_irq functions needed some special
> treatment: as their interrupt handlers will unmask interrupts, it was
> necessary to add a bitmap for "is_suspending" which is used to address
> the possible corner case of unintentional IRQ unmasking because of ISR
> execution after a call to synchronize_irq().
> 
> Of course, unmasking the interrupts is being done as part of the reset
> happening during runtime_resume(): since we're anyway resuming all of
> GPU, JOB, MMU, the only additional action is to zero out the newly
> introduced `is_suspending` bitmap directly in the resume handler, as
> to avoid adding panfrost_{job,mmu}_resume_irq() function just for
> clearing own bits, especially because it currently makes way more sense
> to just zero out the bitmap.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c |  4 ++++
>  drivers/gpu/drm/panfrost/panfrost_device.h |  7 +++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    |  7 +++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 18 +++++++++++++++---
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 17 ++++++++++++++---
>  drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
>  8 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index c90ad5ee34e7..ed34aa55a7da 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -407,6 +407,7 @@ static int panfrost_device_runtime_resume(struct device *dev)
>  {
>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>  
> +	bitmap_zero(pfdev->is_suspending, PANFROST_COMP_BIT_MAX);

I would let each sub-block clear their bit in the reset path, since
that's where the IRQs are effectively unmasked.

>  	panfrost_device_reset(pfdev);
>  	panfrost_devfreq_resume(pfdev);
>  
> @@ -421,6 +422,9 @@ static int panfrost_device_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  
>  	panfrost_devfreq_suspend(pfdev);
> +	panfrost_job_suspend_irq(pfdev);
> +	panfrost_mmu_suspend_irq(pfdev);
> +	panfrost_gpu_suspend_irq(pfdev);
>  	panfrost_gpu_power_off(pfdev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 54a8aad54259..29f89f2d3679 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -25,6 +25,12 @@ struct panfrost_perfcnt;
>  #define NUM_JOB_SLOTS 3
>  #define MAX_PM_DOMAINS 5
>  
> +enum panfrost_drv_comp_bits {
> +	PANFROST_COMP_BIT_MMU,
> +	PANFROST_COMP_BIT_JOB,
> +	PANFROST_COMP_BIT_MAX
> +};
> +
>  /**
>   * enum panfrost_gpu_pm - Supported kernel power management features
>   * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
> @@ -109,6 +115,7 @@ struct panfrost_device {
>  
>  	struct panfrost_features features;
>  	const struct panfrost_compatible *comp;
> +	DECLARE_BITMAP(is_suspending, PANFROST_COMP_BIT_MAX);

nit: Maybe s/is_suspending/suspended_irqs/, given the state remains
until the device is resumed.
