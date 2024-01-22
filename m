Return-Path: <linux-kernel+bounces-32477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD9835C25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBF81C225BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E129418;
	Mon, 22 Jan 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFyAwzpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011B210FE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910235; cv=none; b=VN7isVisgvJesmpfhoT1ZiEF1opXlY0IpP1y5b1o9bnoT6JzXZdzRDHBWRUEh21b19fEGl8P549k/nCqG628iIHqFhecFEarqiSbd3SfbifvpnnP3hMX44K2UCBod+SM6JOdP7qVixx0GbY3YIpFAZWgyOgwWx9MGKgEXGDpitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910235; c=relaxed/simple;
	bh=icaWjQBZC0XFd0b4Ij8tJXj4p1YbQUzYrdzVztOJtvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFAkFxPUMnhnAzlL4r8eKskHR2Di/+WbP1quix5TsJ7mVLdJn72ybe4IoE8jUUati9LXC3qJ4i+6jKDtclbODynHMSBC14p+y1o83HFSk9JP664pUTMS3njyDJGWzwIXFGZKfdzl9XR9jfpaYghJbvGOWU1uL2e3wkCp3MMr1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFyAwzpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2999EC4166A;
	Mon, 22 Jan 2024 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705910234;
	bh=icaWjQBZC0XFd0b4Ij8tJXj4p1YbQUzYrdzVztOJtvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFyAwzpFmOi8HV2fyl+IpPIMbVo6ypzcz6TX2q163Z0ahwnkaXnvnDJwoAMBRoqCJ
	 LITW2XeuJMnkG4UZLBQx1fWVftNnKrQu28k6tuMc02NyzJcl9+nMHb0gBq8L5vZXQu
	 latBee1UMcgpvgtIVcNybctFcdtzErscI80DKoYO26+441eeYHX0z2CpKmuCBjHESu
	 oPHK+x1aMpdvduohPYulQDMUkJrsa7cbvGuw9/6XRf/2kfRg0CFPT5bb47EgYUB6Np
	 9LDXD0J6LOkTnO8vscL0cRKg8AT65na8ZEIl3jCDpKtDH8h2GN9JnZp/n2lGjx4a7t
	 Kl1ZAy/+LdmhA==
Date: Mon, 22 Jan 2024 13:27:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 03/13] drivers: soundwire: amd: refactor amd soundwire
 manager device node creation
Message-ID: <Za4f1rwAXAiJU-j5@matsya>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
 <20240110094416.853610-4-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110094416.853610-4-Vijendar.Mukunda@amd.com>

On 10-01-24, 15:14, Vijendar Mukunda wrote:

Same comment on patch title

> Refactor amd SoundWire manager device node creation logic and implement generic
> functions to have a common functionality for SoundWire manager platform device
> creation, start and exit sequence for both legacy(NO DSP) and SOF stack for AMD
> platforms. These functions will be invoked from legacy and SOF stack.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/Makefile        |   2 +-
>  drivers/soundwire/amd_init.c      | 147 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_init.h      |  13 +++
>  drivers/soundwire/amd_manager.c   |  16 +---
>  include/linux/soundwire/sdw_amd.h |  54 ++++++++++-
>  5 files changed, 218 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/soundwire/amd_init.c
>  create mode 100644 drivers/soundwire/amd_init.h
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 657f5888a77b..e80a2c2cf3e7 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -20,7 +20,7 @@ soundwire-bus-y += irq.o
>  endif
>  
>  #AMD driver
> -soundwire-amd-y :=	amd_manager.o
> +soundwire-amd-y := amd_init.o amd_manager.o
>  obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
>  
>  #Cadence Objs
> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
> new file mode 100644
> index 000000000000..d732ab0bfd59
> --- /dev/null
> +++ b/drivers/soundwire/amd_init.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * SoundWire AMD Manager Initialize routines
> + *
> + * Initializes and creates SDW devices based on ACPI and Hardware values
> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
 2023-24..?

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "amd_init.h"
> +
> +static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < ctx->count; i++) {
> +		if (!(ctx->link_mask & BIT(i)))
> +			continue;
> +		platform_device_unregister(ctx->pdev[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
> +{
> +	struct sdw_amd_ctx *ctx;
> +	struct acpi_device *adev;
> +	struct resource *sdw_res;
> +	struct acp_sdw_pdata sdw_pdata[2];
> +	struct platform_device_info pdevinfo[2];
> +	u32 link_mask;
> +	int count, index;
> +
> +	if (!res)
> +		return NULL;
> +
> +	adev = acpi_fetch_acpi_dev(res->handle);
> +	if (!adev)
> +		return NULL;
> +
> +	if (!res->count)
> +		return NULL;
> +
> +	count = res->count;
> +	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
> +
> +	/*
> +	 * we need to alloc/free memory manually and can't use devm:
> +	 * this routine may be called from a workqueue, and not from
> +	 * the parent .probe.
> +	 * If devm_ was used, the memory might never be freed on errors.
> +	 */
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx->count = count;
> +	ctx->link_mask = res->link_mask;
> +	sdw_res = kzalloc(sizeof(*sdw_res), GFP_KERNEL);
> +	if (!sdw_res) {
> +		kfree(ctx);
> +		return NULL;
> +	}
> +	sdw_res->flags = IORESOURCE_MEM;
> +	sdw_res->start = res->addr;
> +	sdw_res->end = res->addr + res->reg_range;
> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
> +	link_mask = ctx->link_mask;
> +	for (index = 0; index < count; index++) {
> +		if (!(link_mask & BIT(index)))
> +			continue;
> +
> +		sdw_pdata[index].instance = index;
> +		sdw_pdata[index].acp_sdw_lock = res->acp_lock;
> +		pdevinfo[index].name = "amd_sdw_manager";
> +		pdevinfo[index].id = index;
> +		pdevinfo[index].parent = res->parent;
> +		pdevinfo[index].num_res = 1;
> +		pdevinfo[index].res = sdw_res;
> +		pdevinfo[index].data = &sdw_pdata[index];
> +		pdevinfo[index].size_data = sizeof(struct acp_sdw_pdata);
> +		pdevinfo[index].fwnode = acpi_fwnode_handle(adev);
> +		ctx->pdev[index] = platform_device_register_full(&pdevinfo[index]);
> +		if (IS_ERR(ctx->pdev[index]))
> +			goto err;
> +	}
> +	kfree(sdw_res);
> +	return ctx;
> +err:
> +	while (index--) {
> +		if (!(link_mask & BIT(index)))
> +			continue;
> +
> +		platform_device_unregister(ctx->pdev[index]);
> +	}
> +
> +	kfree(sdw_res);
> +	kfree(ctx);
> +	return NULL;
> +}
> +
> +static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
> +{
> +	struct amd_sdw_manager *amd_manager;
> +	int i, ret;
> +
> +	/* Startup SDW Manager devices */
> +	for (i = 0; i < ctx->count; i++) {
> +		if (!(ctx->link_mask & BIT(i)))
> +			continue;
> +		amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
> +		ret = amd_sdw_manager_start(amd_manager);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
> +{
> +	*sdw_ctx = sdw_amd_probe_controller(res);
> +	if (!*sdw_ctx)
> +		return -ENODEV;
> +
> +	return sdw_amd_startup(*sdw_ctx);
> +}
> +EXPORT_SYMBOL_NS(sdw_amd_probe, SOUNDWIRE_AMD_INIT);
> +
> +void sdw_amd_exit(struct sdw_amd_ctx *ctx)
> +{
> +	sdw_amd_cleanup(ctx);
> +	kfree(ctx->ids);
> +	kfree(ctx);
> +}
> +EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_DESCRIPTION("AMD SoundWire Init Library");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/soundwire/amd_init.h b/drivers/soundwire/amd_init.h
> new file mode 100644
> index 000000000000..f710703ffae9
> --- /dev/null
> +++ b/drivers/soundwire/amd_init.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __AMD_INIT_H
> +#define __AMD_INIT_H
> +
> +#include <linux/soundwire/sdw_amd.h>
> +
> +int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager);
> +
> +#endif
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index afa2d83b7e69..0fcf8f8545b1 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -19,6 +19,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include "bus.h"
> +#include "amd_init.h"
>  #include "amd_manager.h"
>  
>  #define DRV_NAME "amd_sdw_manager"
> @@ -864,10 +865,8 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>  	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>  }
>  
> -static void amd_sdw_probe_work(struct work_struct *work)
> +int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
>  {
> -	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
> -							   probe_work);
>  	struct sdw_master_prop *prop;
>  	int ret;
>  
> @@ -876,11 +875,11 @@ static void amd_sdw_probe_work(struct work_struct *work)
>  		amd_enable_sdw_pads(amd_manager);
>  		ret = amd_init_sdw_manager(amd_manager);
>  		if (ret)
> -			return;
> +			return ret;
>  		amd_enable_sdw_interrupts(amd_manager);
>  		ret = amd_enable_sdw_manager(amd_manager);
>  		if (ret)
> -			return;
> +			return ret;
>  		amd_sdw_set_frameshape(amd_manager);
>  	}
>  	/* Enable runtime PM */
> @@ -889,6 +888,7 @@ static void amd_sdw_probe_work(struct work_struct *work)
>  	pm_runtime_mark_last_busy(amd_manager->dev);
>  	pm_runtime_set_active(amd_manager->dev);
>  	pm_runtime_enable(amd_manager->dev);
> +	return 0;
>  }
>  
>  static int amd_sdw_manager_probe(struct platform_device *pdev)
> @@ -964,11 +964,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, amd_manager);
>  	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>  	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
> -	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
> -	/*
> -	 * Instead of having lengthy probe sequence, use deferred probe.
> -	 */
> -	schedule_work(&amd_manager->probe_work);
>  	return 0;
>  }
>  
> @@ -978,7 +973,6 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>  	int ret;
>  
>  	pm_runtime_disable(&pdev->dev);
> -	cancel_work_sync(&amd_manager->probe_work);
>  	amd_disable_sdw_interrupts(amd_manager);
>  	sdw_bus_master_delete(&amd_manager->bus);
>  	ret = amd_disable_sdw_manager(amd_manager);
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index 56b4117c087a..1e5ff4c46365 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -26,6 +26,7 @@
>  #define AMD_SDW_POWER_OFF_MODE		2
>  #define ACP_SDW0	0
>  #define ACP_SDW1	1
> +#define AMD_SDW_MAX_MANAGER_COUNT	2
>  
>  struct acp_sdw_pdata {
>  	u16 instance;
> @@ -63,7 +64,6 @@ struct sdw_amd_dai_runtime {
>   * @reg_mask: register mask structure per manager instance
>   * @amd_sdw_irq_thread: SoundWire manager irq workqueue
>   * @amd_sdw_work: peripheral status work queue
> - * @probe_work: SoundWire manager probe workqueue
>   * @acp_sdw_lock: mutex to protect acp share register access
>   * @status: peripheral devices status array
>   * @num_din_ports: number of input ports
> @@ -87,7 +87,6 @@ struct amd_sdw_manager {
>  	struct sdw_manager_reg_mask *reg_mask;
>  	struct work_struct amd_sdw_irq_thread;
>  	struct work_struct amd_sdw_work;
> -	struct work_struct probe_work;
>  	/* mutex to protect acp common register access */
>  	struct mutex *acp_sdw_lock;
>  
> @@ -120,5 +119,56 @@ struct sdw_amd_acpi_info {
>  	u32 link_mask;
>  };
>  
> +/**
> + * struct sdw_amd_ctx - context allocated by the controller
> + * driver probe

missing a blank line there

> + * @count: link count
> + * @num_slaves: total number of devices exposed across all enabled links
should this be not per link?

> + * @link_mask: bit-wise mask listing SoundWire links reported by the
> + * Controller
> + * @ids: array of slave_id, representing Slaves exposed across all enabled
> + * links

this does not tell us which device to expect in which link..?

> + * @pdev: platform device structure
> + */
> +struct sdw_amd_ctx {
> +	int count;
> +	int num_slaves;
> +	u32 link_mask;
> +	struct sdw_extended_slave_id *ids;
> +	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
> +};
> +
> +/**
> + * struct sdw_amd_res - Soundwire AMD global resource structure,
> + * typically populated by the DSP driver/Legacy driver
> + *
> + * @addr: acp pci device resource start address
> + * @reg_range: ACP register range
> + * @link_mask: bit-wise mask listing links selected by the DSP driver/
> + * legacy driver
> + * @count: link count
> + * @mmio_base: mmio base of SoundWire registers
> + * @handle: ACPI parent handle
> + * @parent: parent device
> + * @dev: device implementing hwparams and free callbacks
> + * @acp_lock: mutex protecting acp common registers access
> + */
> +struct sdw_amd_res {
> +	u32 addr;
> +	u32 reg_range;
> +	u32 link_mask;
> +	int count;
> +	void __iomem *mmio_base;
> +	acpi_handle handle;
> +	struct device *parent;
> +	struct device *dev;
> +	/* use to protect acp common registers access */
> +	struct mutex *acp_lock;
> +};
> +
> +int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
> +
> +void sdw_amd_exit(struct sdw_amd_ctx *ctx);
> +
>  int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
>  #endif
> -- 
> 2.34.1

-- 
~Vinod

