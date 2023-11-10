Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EA7E82AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjKJT3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbjKJT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC7FF38792
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:07:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C42C12FC;
        Fri, 10 Nov 2023 06:08:01 -0800 (PST)
Received: from [10.57.36.221] (unknown [10.57.36.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2B083F7C5;
        Fri, 10 Nov 2023 06:07:13 -0800 (PST)
Message-ID: <aefbde74-d34b-452d-b6a1-7417bc30dea4@arm.com>
Date:   Fri, 10 Nov 2023 14:07:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] drm/panfrost: Implement ability to turn on/off GPU
 clocks in suspend
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
 <20231109102543.42971-4-angelogioacchino.delregno@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231109102543.42971-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 10:25, AngeloGioacchino Del Regno wrote:
> Currently, the GPU is being internally powered off for runtime suspend
> and turned back on for runtime resume through commands sent to it, but
> note that the GPU doesn't need to be clocked during the poweroff state,
> hence it is possible to save some power on selected platforms.
> 
> Add suspend and resume handlers for full system sleep and then add
> a new panfrost_gpu_pm enumeration and a pm_features variable in the
> panfrost_compatible structure: BIT(GPU_PM_CLK_DIS) will be used to
> enable this power saving technique only on SoCs that are able to
> safely use it.
> 
> Note that this was implemented only for the system sleep case and not
> for runtime PM because testing on one of my MediaTek platforms showed
> issues when turning on and off clocks aggressively (in PM runtime)
> resulting in a full system lockup.
> 
> Doing this only for full system sleep never showed issues during my
> testing by suspending and resuming the system continuously for more
> than 100 cycles.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 61 ++++++++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_device.h | 11 ++++
>  2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 28f7046e1b1a..b4ddbc3b8069 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -403,7 +403,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev)
>  	panfrost_job_enable_interrupts(pfdev);
>  }
>  
> -static int panfrost_device_resume(struct device *dev)
> +static int panfrost_device_runtime_resume(struct device *dev)
>  {
>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>  
> @@ -413,7 +413,7 @@ static int panfrost_device_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static int panfrost_device_suspend(struct device *dev)
> +static int panfrost_device_runtime_suspend(struct device *dev)
>  {
>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>  
> @@ -426,5 +426,58 @@ static int panfrost_device_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -EXPORT_GPL_RUNTIME_DEV_PM_OPS(panfrost_pm_ops, panfrost_device_suspend,
> -			      panfrost_device_resume, NULL);
> +static int panfrost_device_resume(struct device *dev)
> +{
> +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> +		ret = clk_enable(pfdev->clock);
> +		if (ret)
> +			return ret;
> +
> +		if (pfdev->bus_clock) {
> +			ret = clk_enable(pfdev->bus_clock);
> +			if (ret)
> +				goto err_bus_clk;
> +		}
> +	}
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		goto err_resume;
> +
> +	return 0;
> +
> +err_resume:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
> +		clk_disable(pfdev->bus_clock);
> +err_bus_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> +		clk_disable(pfdev->clock);
> +	return ret;
> +}
> +
> +static int panfrost_device_suspend(struct device *dev)
> +{
> +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> +		if (pfdev->bus_clock)
> +			clk_disable(pfdev->bus_clock);
> +
> +		clk_disable(pfdev->clock);
> +	}
> +
> +	return 0;
> +}
> +
> +EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
> +	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
> +};
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 1ef38f60d5dc..d7f179eb8ea3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -25,6 +25,14 @@ struct panfrost_perfcnt;
>  #define NUM_JOB_SLOTS 3
>  #define MAX_PM_DOMAINS 5
>  
> +/**
> + * enum panfrost_gpu_pm - Supported kernel power management features
> + * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
> + */
> +enum panfrost_gpu_pm {
> +	GPU_PM_CLK_DIS,
> +};
> +
>  struct panfrost_features {
>  	u16 id;
>  	u16 revision;
> @@ -75,6 +83,9 @@ struct panfrost_compatible {
>  
>  	/* Vendor implementation quirks callback */
>  	void (*vendor_quirk)(struct panfrost_device *pfdev);
> +
> +	/* Allowed PM features */
> +	u8 pm_features;
>  };
>  
>  struct panfrost_device {

