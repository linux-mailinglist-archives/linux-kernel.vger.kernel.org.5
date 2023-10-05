Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510917BA0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjJEOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjJEOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3E47890
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0CEC4163C;
        Thu,  5 Oct 2023 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696501479;
        bh=L7H7NJS6F4MBzkskoR+AunNd9V27dLQ5iOr9pCHdFLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdStW7QSEo3jm/lbZCA2tJ3RgquEek4K2koYvfXTBIYDiXnHza44r4FFKgK/rfDGv
         x3MD6xLL+UBJ4G45TxkbTn/vgOnYjBU6HiPlcFxxg7/sNHwm8luPsWTqPlhxvKVkA9
         VrQeflu+1VgmeC49SML+BaQV3NVz70TlBphLIazg=
Date:   Thu, 5 Oct 2023 12:24:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Message-ID: <2023100531-matron-oversold-4a73@gregkh>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911135259.14046-1-nipun.gupta@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:22:59PM +0530, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
> 
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
> 
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
> 
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changes v3->v4:
> - Rebased on Linux 6.6-rc1
> 
> Changes v2->v3:
> - Rebased on Linux 6.5-rc1
> - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.
> 
> Changes v1->v2:
> - fixed scenario where msi write was called asyncronously in
>   an atomic context, by using irq_chip_(un)lock, and using sync
>   MCDI API for write MSI message.
> - fixed broken Signed-off-by chain.
> 
>  drivers/cdx/Kconfig                     |   1 +
>  drivers/cdx/Makefile                    |   2 +-
>  drivers/cdx/cdx.c                       |   9 ++
>  drivers/cdx/cdx.h                       |  12 ++
>  drivers/cdx/cdx_msi.c                   | 183 ++++++++++++++++++++++++
>  drivers/cdx/controller/cdx_controller.c |  23 +++
>  drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++++
>  drivers/cdx/controller/mcdi_functions.c |  26 +++-
>  drivers/cdx/controller/mcdi_functions.h |  20 +++
>  include/linux/cdx/cdx_bus.h             |  32 +++++
>  kernel/irq/msi.c                        |   1 +
>  11 files changed, 370 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/cdx/cdx_msi.c
> 
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> index a08958485e31..86df7ccb76bb 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -8,6 +8,7 @@
>  config CDX_BUS
>  	bool "CDX Bus driver"
>  	depends on OF && ARM64
> +	select GENERIC_MSI_IRQ_DOMAIN

This config option isn't in my tree anywhere, where did it come from?
What is it supposed to do?

>  	help
>  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>  	  exposes Fabric devices which uses composable DMA IP to the
> diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
> index 0324e4914f6e..4bad79d1d188 100644
> --- a/drivers/cdx/Makefile
> +++ b/drivers/cdx/Makefile
> @@ -5,4 +5,4 @@
>  # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
>  #
>  
> -obj-$(CONFIG_CDX_BUS) += cdx.o controller/
> +obj-$(CONFIG_CDX_BUS) += cdx.o cdx_msi.o controller/

So you are always building this in even if the build doesn't support
MSI?  Why will that not break the build?


> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..8d777cdacf1d 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -56,6 +56,7 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/of_device.h>
>  #include <linux/slab.h>
> @@ -478,6 +479,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>  
>  	/* Populate CDX dev params */
>  	cdx_dev->req_id = dev_params->req_id;
> +	cdx_dev->msi_dev_id = dev_params->msi_dev_id;
>  	cdx_dev->vendor = dev_params->vendor;
>  	cdx_dev->device = dev_params->device;
>  	cdx_dev->bus_num = dev_params->bus_num;
> @@ -491,12 +493,19 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>  	cdx_dev->dev.bus = &cdx_bus_type;
>  	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
>  	cdx_dev->dev.release = cdx_device_release;
> +	cdx_dev->msi_write_pending = false;
> +	mutex_init(&cdx_dev->irqchip_lock);
>  
>  	/* Set Name */
>  	dev_set_name(&cdx_dev->dev, "cdx-%02x:%02x",
>  		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
>  		     cdx_dev->dev_num);
>  
> +	if (cdx->msi_domain) {
> +		cdx_dev->num_msi = dev_params->num_msi;
> +		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
> +	}
> +
>  	ret = device_add(&cdx_dev->dev);
>  	if (ret) {
>  		dev_err(&cdx_dev->dev,
> diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
> index c436ac7ac86f..ece11c04d646 100644
> --- a/drivers/cdx/cdx.h
> +++ b/drivers/cdx/cdx.h
> @@ -21,6 +21,8 @@
>   * @res: array of MMIO region entries
>   * @res_count: number of valid MMIO regions
>   * @req_id: Requestor ID associated with CDX device
> + * @msi_dev_id: MSI device ID associated with CDX device
> + * @num_msi: Number of MSI's supported by the device
>   */
>  struct cdx_dev_params {
>  	struct cdx_controller *cdx;
> @@ -31,6 +33,8 @@ struct cdx_dev_params {
>  	struct resource res[MAX_CDX_DEV_RESOURCES];
>  	u8 res_count;
>  	u32 req_id;
> +	u32 msi_dev_id;
> +	u32 num_msi;
>  };
>  
>  /**
> @@ -59,4 +63,12 @@ void cdx_unregister_controller(struct cdx_controller *cdx);
>   */
>  int cdx_device_add(struct cdx_dev_params *dev_params);
>  
> +/**
> + * cdx_msi_domain_init - Init the CDX bus MSI domain.
> + * @dev: Device of the CDX bus controller
> + *
> + * Return: CDX MSI domain, NULL on failure
> + */
> +struct irq_domain *cdx_msi_domain_init(struct device *dev);
> +
>  #endif /* _CDX_H_ */
> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
> new file mode 100644
> index 000000000000..d7f4c88428d6
> --- /dev/null
> +++ b/drivers/cdx/cdx_msi.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD CDX bus driver MSI support
> + *
> + * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/msi.h>
> +#include <linux/cdx/cdx_bus.h>
> +
> +#include "cdx.h"
> +
> +static void cdx_msi_write_msg(struct irq_data *irq_data,
> +			      struct msi_msg *msg)
> +{
> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
> +	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
> +
> +	/* We would not operate on msg here rather we wait for
> +	 * irq_bus_sync_unlock() to be called from preemptible
> +	 * task context.
> +	 */
> +	msi_desc->msg = *msg;
> +	cdx_dev->msi_write_pending = true;
> +}
> +
> +static void cdx_msi_write_irq_lock(struct irq_data *irq_data)
> +{
> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
> +	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
> +
> +	mutex_lock(&cdx_dev->irqchip_lock);
> +}
> +
> +static void cdx_msi_write_irq_unlock(struct irq_data *irq_data)
> +{
> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
> +	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	int ret;
> +
> +	if (!cdx_dev->msi_write_pending) {
> +		mutex_unlock(&cdx_dev->irqchip_lock);
> +		return;
> +	}
> +
> +	cdx_dev->msi_write_pending = false;
> +	mutex_unlock(&cdx_dev->irqchip_lock);
> +
> +	dev_config.msi.msi_index = msi_desc->msi_index;
> +	dev_config.msi.data = msi_desc->msg.data;
> +	dev_config.msi.addr = ((u64)(msi_desc->msg.address_hi) << 32) |
> +			      msi_desc->msg.address_lo;
> +
> +	dev_config.type = CDX_DEV_MSI_CONF;
> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
> +				      &dev_config);
> +	if (ret)
> +		dev_err(&cdx_dev->dev, "Write MSI failed to CDX controller\n");

How noisy iks this going to be in an irq handler if something goes
wrong?

And you are doing this write outside of the lock, is that intentional?
If so, why not document that?


> +}
> +
> +static struct irq_chip cdx_msi_irq_chip = {
> +	.name			= "CDX-MSI",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_affinity	= msi_domain_set_affinity,
> +	.irq_write_msi_msg	= cdx_msi_write_msg,
> +	.irq_bus_lock		= cdx_msi_write_irq_lock,
> +	.irq_bus_sync_unlock	= cdx_msi_write_irq_unlock
> +};
> +
> +int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
> +{
> +	int ret;
> +
> +	ret = msi_setup_device_data(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
> +					  0, irq_count - 1);
> +	if (ret)
> +		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);

meta-comment, CDX really should have a module namespace one of these
days, right?

> +
> +/* Convert an msi_desc to a globally unique identifier. */
> +static irq_hw_number_t cdx_domain_calc_hwirq(struct cdx_device *dev,
> +					     struct msi_desc *desc)
> +{
> +	return ((irq_hw_number_t)dev->msi_dev_id << 10) | desc->msi_index;

How does this make a unique number?  Is msi_dev_id guaranteed to be
unique across all cdx busses?  That's not normally the case for most bus
types, unless you are guaranteeing this in the cdx core somewhere?

And why shift 10 bits?  That's a fun magic number...

> +}
> +
> +static void cdx_msi_set_desc(msi_alloc_info_t *arg,
> +			     struct msi_desc *desc)
> +{
> +	arg->desc = desc;
> +	arg->hwirq = cdx_domain_calc_hwirq(to_cdx_device(desc->dev), desc);
> +}
> +
> +static int cdx_msi_prepare(struct irq_domain *msi_domain,
> +			   struct device *dev,
> +			   int nvec, msi_alloc_info_t *info)
> +{
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +	struct device *parent = dev->parent;
> +	struct msi_domain_info *msi_info;
> +	u32 dev_id = 0;

No need to set this, right?

> +	int ret;
> +
> +	/* Retrieve device ID from requestor ID using parent device */
> +	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map",
> +			"msi-map-mask", NULL, &dev_id);
> +	if (ret) {
> +		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set the device Id to be passed to the GIC-ITS */
> +	info->scratchpad[0].ul = dev_id;
> +
> +	msi_info = msi_get_domain_info(msi_domain->parent);
> +
> +	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);

Do you know that there will be a ops pointer here?  And the msi_prepare
callback?  Or will this always just be:

> +}
> +
> +static struct msi_domain_ops cdx_msi_ops = {
> +	.msi_prepare	= cdx_msi_prepare,
> +	.set_desc	= cdx_msi_set_desc

This structure?

> +};
> +
> +static struct msi_domain_info cdx_msi_domain_info = {
> +	.ops	= &cdx_msi_ops,
> +	.chip	= &cdx_msi_irq_chip,
> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS
> +};
> +
> +struct irq_domain *cdx_msi_domain_init(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct fwnode_handle *fwnode_handle;
> +	struct irq_domain *cdx_msi_domain;
> +	struct device_node *parent_node;
> +	struct irq_domain *parent;
> +
> +	fwnode_handle = of_node_to_fwnode(np);
> +
> +	parent_node = of_parse_phandle(np, "msi-map", 1);
> +	if (!parent_node) {
> +		dev_err(dev, "msi-map not present on cdx controller\n");

Is this a requirement now?  What about systems without it?

> +struct cdx_msi_config {
> +	u16 msi_index;
> +	u32 data;
> +	u64 addr;
> +};

Are you ok with the "hole" in this structure?

And I really need a msi maintainer to review this before I can take it,
thanks.

greg k-h
