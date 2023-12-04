Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74646803581
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjLDNwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjLDNwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:52:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A773D109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:52:54 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8CC166607090;
        Mon,  4 Dec 2023 13:52:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701697973;
        bh=ZHk+VSdrtCpr3xI/eSrC5xKDAHY8U7v792lIefOdo7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d71sU6p2t7UvmvC7Oc7EBjD949GkU7zzAV/BHVVT9pQjLJHck7k3KnuYIsa3M8+lP
         ilQcGOFA0XnLAFvsMVo80BFJRwmL+AVHaHs2e3v79uGkSZy8zy4mJVdr29FimgDoff
         2hPA5zplsvtADFcavmoA6Y8AxRmLFgIugr8xjY9fa1E+uh02DCs3o8a2LBRHWAOg25
         D14YHfXJmpWvwO8GHMXdfHz9QAePmAkwVBC4VIQ4m4S1xU6qGEif1bGpdjbNYn5tjp
         ZNwQztUPvUtFYrmRHK0AF392QiOkHoqoAsjhR5lDIvBFhK8rvgfve9+F7cIwemDd48
         w9QGcq2yrhUcA==
Date:   Mon, 4 Dec 2023 14:52:48 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 3/3] drm/panfrost: Synchronize and disable interrupts
 before powering off
Message-ID: <20231204145248.27f3ddec@collabora.com>
In-Reply-To: <20231204114215.54575-4-angelogioacchino.delregno@collabora.com>
References: <20231204114215.54575-1-angelogioacchino.delregno@collabora.com>
        <20231204114215.54575-4-angelogioacchino.delregno@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Dec 2023 12:42:15 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> To make sure that we don't unintentionally perform any unclocked and/or
> unpowered R/W operation on GPU registers, before turning off clocks and
> regulators we must make sure that no GPU, JOB or MMU ISR execution is
> pending: doing that requires to add a mechanism to synchronize the
> interrupts on suspend.
> 
> Add functions panfrost_{gpu,job,mmu}_suspend_irq() which will perform
> interrupts masking and ISR execution synchronization, and then call
> those in the panfrost_device_runtime_suspend() handler in the exact
> sequence of job (may require mmu!) -> mmu -> gpu.
> 
> As a side note, JOB and MMU suspend_irq functions needed some special
> treatment: as their interrupt handlers will unmask interrupts, it was
> necessary to add an `is_suspended` bitmap which is used to address the
> possible corner case of unintentional IRQ unmasking because of ISR
> execution after a call to synchronize_irq().
> 
> At resume, clear each is_suspended bit in the reset path of JOB/MMU
> to allow unmasking the interrupts.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c |  3 +++
>  drivers/gpu/drm/panfrost/panfrost_device.h |  8 +++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 18 +++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 26 ++++++++++++++++++----
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 22 +++++++++++++++---
>  drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
>  8 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index c90ad5ee34e7..a45e4addcc19 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -421,6 +421,9 @@ static int panfrost_device_runtime_suspend(struct device *dev)
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
> index 54a8aad54259..62f7e3527385 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -25,6 +25,13 @@ struct panfrost_perfcnt;
>  #define NUM_JOB_SLOTS 3
>  #define MAX_PM_DOMAINS 5
>  
> +enum panfrost_drv_comp_bits {
> +	PANFROST_COMP_BIT_GPU,
> +	PANFROST_COMP_BIT_JOB,
> +	PANFROST_COMP_BIT_MMU,
> +	PANFROST_COMP_BIT_MAX
> +};
> +
>  /**
>   * enum panfrost_gpu_pm - Supported kernel power management features
>   * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
> @@ -109,6 +116,7 @@ struct panfrost_device {
>  
>  	struct panfrost_features features;
>  	const struct panfrost_compatible *comp;
> +	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
>  
>  	spinlock_t as_lock;
>  	unsigned long as_in_use_mask;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 7adc4441fa14..9063ce254642 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -22,9 +22,13 @@
>  static irqreturn_t panfrost_gpu_irq_handler(int irq, void *data)
>  {
>  	struct panfrost_device *pfdev = data;
> -	u32 state = gpu_read(pfdev, GPU_INT_STAT);
> -	u32 fault_status = gpu_read(pfdev, GPU_FAULT_STATUS);
> +	u32 fault_status, state;
>  
> +	if (test_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended))
> +		return IRQ_NONE;
> +
> +	fault_status = gpu_read(pfdev, GPU_FAULT_STATUS);
> +	state = gpu_read(pfdev, GPU_INT_STAT);
>  	if (!state)
>  		return IRQ_NONE;
>  
> @@ -61,6 +65,8 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>  	gpu_write(pfdev, GPU_INT_MASK, 0);
>  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
>  
> +	clear_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
> +
>  	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
>  	ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
>  		val, val & GPU_IRQ_RESET_COMPLETED, 10, 10000);
> @@ -452,6 +458,14 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>  		dev_err(pfdev->dev, "l2 power transition timeout");
>  }
>  
> +void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev)
> +{
> +	set_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
> +
> +	gpu_write(pfdev, GPU_INT_MASK, 0);
> +	synchronize_irq(pfdev->gpu_irq);
> +}
> +
>  int panfrost_gpu_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> index 876fdad9f721..d841b86504ea 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> @@ -15,6 +15,7 @@ u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev);
>  int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
>  void panfrost_gpu_power_on(struct panfrost_device *pfdev);
>  void panfrost_gpu_power_off(struct panfrost_device *pfdev);
> +void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev);
>  
>  void panfrost_cycle_counter_get(struct panfrost_device *pfdev);
>  void panfrost_cycle_counter_put(struct panfrost_device *pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index f9446e197428..0c2dbf6ef2a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -405,6 +405,8 @@ void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
>  	int j;
>  	u32 irq_mask = 0;
>  
> +	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> +
>  	for (j = 0; j < NUM_JOB_SLOTS; j++) {
>  		irq_mask |= MK_JS_MASK(j);
>  	}
> @@ -413,6 +415,14 @@ void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
>  	job_write(pfdev, JOB_INT_MASK, irq_mask);
>  }
>  
> +void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
> +{
> +	set_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> +
> +	job_write(pfdev, JOB_INT_MASK, 0);
> +	synchronize_irq(pfdev->js->irq);
> +}
> +
>  static void panfrost_job_handle_err(struct panfrost_device *pfdev,
>  				    struct panfrost_job *job,
>  				    unsigned int js)
> @@ -792,17 +802,25 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
>  	struct panfrost_device *pfdev = data;
>  
>  	panfrost_job_handle_irqs(pfdev);
> -	job_write(pfdev, JOB_INT_MASK,
> -		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
> -		  GENMASK(NUM_JOB_SLOTS - 1, 0));
> +
> +	/* Enable interrupts only if we're not about to get suspended */
> +	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
> +		job_write(pfdev, JOB_INT_MASK,
> +			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
> +			  GENMASK(NUM_JOB_SLOTS - 1, 0));
> +
>  	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
>  {
>  	struct panfrost_device *pfdev = data;
> -	u32 status = job_read(pfdev, JOB_INT_STAT);
> +	u32 status;
> +
> +	if (test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
> +		return IRQ_NONE;
>  
> +	status = job_read(pfdev, JOB_INT_STAT);
>  	if (!status)
>  		return IRQ_NONE;
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> index 17ff808dba07..ec581b97852b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> @@ -47,6 +47,7 @@ int panfrost_job_get_slot(struct panfrost_job *job);
>  int panfrost_job_push(struct panfrost_job *job);
>  void panfrost_job_put(struct panfrost_job *job);
>  void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
> +void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
>  int panfrost_job_is_idle(struct panfrost_device *pfdev);
>  
>  #endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index ac4296c1e54b..f38385fe76bb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -231,6 +231,8 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
>  {
>  	struct panfrost_mmu *mmu, *mmu_tmp;
>  
> +	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
> +
>  	spin_lock(&pfdev->as_lock);
>  
>  	pfdev->as_alloc_mask = 0;
> @@ -670,6 +672,9 @@ static irqreturn_t panfrost_mmu_irq_handler(int irq, void *data)
>  {
>  	struct panfrost_device *pfdev = data;
>  
> +	if (test_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended))
> +		return IRQ_NONE;
> +
>  	if (!mmu_read(pfdev, MMU_INT_STAT))
>  		return IRQ_NONE;
>  
> @@ -744,9 +749,12 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
>  			status = mmu_read(pfdev, MMU_INT_RAWSTAT) & ~pfdev->as_faulty_mask;
>  	}
>  
> -	spin_lock(&pfdev->as_lock);
> -	mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_mask);
> -	spin_unlock(&pfdev->as_lock);
> +	/* Enable interrupts only if we're not about to get suspended */
> +	if (!test_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended)) {
> +		spin_lock(&pfdev->as_lock);
> +		mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_mask);
> +		spin_unlock(&pfdev->as_lock);
> +	}
>  
>  	return IRQ_HANDLED;
>  };
> @@ -777,3 +785,11 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev)
>  {
>  	mmu_write(pfdev, MMU_INT_MASK, 0);
>  }
> +
> +void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
> +{
> +	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
> +
> +	mmu_write(pfdev, MMU_INT_MASK, 0);
> +	synchronize_irq(pfdev->mmu_irq);
> +}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> index cc2a0d307feb..022a9a74a114 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> @@ -14,6 +14,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping);
>  int panfrost_mmu_init(struct panfrost_device *pfdev);
>  void panfrost_mmu_fini(struct panfrost_device *pfdev);
>  void panfrost_mmu_reset(struct panfrost_device *pfdev);
> +void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
>  
>  u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
>  void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);

