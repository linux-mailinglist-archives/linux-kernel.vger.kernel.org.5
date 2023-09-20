Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37F7A73A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjITHF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjITHFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:05:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FB92
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:05:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717AAC433C7;
        Wed, 20 Sep 2023 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695193549;
        bh=D71g/sc3S99iEmpZ7lfdfo+6gOqMaQMSS/2C/00QovU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9pRqVqgjNvj/RaSLw9PKLWnmmt6zm8thVstnSJlZSOPk1sirZgsaPS2sVAPzF9vA
         B889ZtLJkhTcmigtlJCE3Yg1DAmAn0684GNYGRUh0aZT106PhT9hjM9qLlVCUIpvWh
         VYf9hEZt2FRd1jNL4cyPIIvH/ztVxaptm+heRMcNp+DuMPg558SSpjrXrsFS3BgBTC
         ywLpDB0qIMhrYxrJYNqp+brUYD2tqpMKY7TeQlDb4Rzgt1FP5hMaSzZVYwcSsEbA4a
         NyjycGjX/PrgwRMnqEwKsoogl3RT+sKEpxvE8nehYmcw9b6XMN8hP9giSizNksA4ky
         jIlZq3DpFA/nw==
Date:   Wed, 20 Sep 2023 09:05:13 +0200
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        rdunlap@infradead.org
Subject: Re: [PATCH] soundwire: bus: Make IRQ handling conditionally built
Message-ID: <ZQqZqalGdqy86qdD@matsya>
References: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-23, 17:10, Charles Keepax wrote:
> SoundWire has provisions for a simple callback for the IRQ handling so
> has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> moving the IRQ handling into its own file and only add it to the build
> when IRQ_DOMAIN is included in the kernel.
> 
> Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/Makefile   |  4 +++
>  drivers/soundwire/bus.c      | 31 +++----------------
>  drivers/soundwire/bus_type.c | 11 +++----
>  drivers/soundwire/irq.c      | 59 ++++++++++++++++++++++++++++++++++++
>  drivers/soundwire/irq.h      | 43 ++++++++++++++++++++++++++
>  5 files changed, 115 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/soundwire/irq.c
>  create mode 100644 drivers/soundwire/irq.h
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index c3d3ab3262d3a..657f5888a77b0 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -15,6 +15,10 @@ ifdef CONFIG_DEBUG_FS
>  soundwire-bus-y += debugfs.o
>  endif
>  
> +ifdef CONFIG_IRQ_DOMAIN
> +soundwire-bus-y += irq.o
> +endif

Any reason why we cant use depends for this?


> +
>  #AMD driver
>  soundwire-amd-y :=	amd_manager.o
>  obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1720031f35a35..0e7bc3c40f9df 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -3,13 +3,13 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> -#include <linux/irq.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/soundwire/sdw_registers.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
> +#include "irq.h"
>  #include "sysfs_local.h"
>  
>  static DEFINE_IDA(sdw_bus_ida);
> @@ -25,23 +25,6 @@ static int sdw_get_id(struct sdw_bus *bus)
>  	return 0;
>  }
>  
> -static int sdw_irq_map(struct irq_domain *h, unsigned int virq,
> -		       irq_hw_number_t hw)
> -{
> -	struct sdw_bus *bus = h->host_data;
> -
> -	irq_set_chip_data(virq, bus);
> -	irq_set_chip(virq, &bus->irq_chip);
> -	irq_set_nested_thread(virq, 1);
> -	irq_set_noprobe(virq);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops sdw_domain_ops = {
> -	.map	= sdw_irq_map,
> -};
> -
>  /**
>   * sdw_bus_master_add() - add a bus Master instance
>   * @bus: bus instance
> @@ -168,13 +151,9 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  	bus->params.curr_bank = SDW_BANK0;
>  	bus->params.next_bank = SDW_BANK1;
>  
> -	bus->irq_chip.name = dev_name(bus->dev);
> -	bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
> -					       &sdw_domain_ops, bus);
> -	if (!bus->domain) {
> -		dev_err(bus->dev, "Failed to add IRQ domain\n");
> -		return -EINVAL;
> -	}
> +	ret = sdw_irq_create(bus, fwnode);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }
> @@ -213,7 +192,7 @@ void sdw_bus_master_delete(struct sdw_bus *bus)
>  {
>  	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
>  
> -	irq_domain_remove(bus->domain);
> +	sdw_irq_delete(bus);
>  
>  	sdw_master_device_del(bus);
>  
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index fafbc284e82da..9fa93bb923d70 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -7,6 +7,7 @@
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
> +#include "irq.h"
>  #include "sysfs_local.h"
>  
>  /**
> @@ -122,11 +123,8 @@ static int sdw_drv_probe(struct device *dev)
>  	if (drv->ops && drv->ops->read_prop)
>  		drv->ops->read_prop(slave);
>  
> -	if (slave->prop.use_domain_irq) {
> -		slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
> -		if (!slave->irq)
> -			dev_warn(dev, "Failed to map IRQ\n");
> -	}
> +	if (slave->prop.use_domain_irq)
> +		sdw_irq_create_mapping(slave);
>  
>  	/* init the sysfs as we have properties now */
>  	ret = sdw_slave_sysfs_init(slave);
> @@ -176,8 +174,7 @@ static int sdw_drv_remove(struct device *dev)
>  	slave->probed = false;
>  
>  	if (slave->prop.use_domain_irq)
> -		irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
> -						     slave->dev_num));
> +		sdw_irq_dispose_mapping(slave);
>  
>  	mutex_unlock(&slave->sdw_dev_lock);
>  
> diff --git a/drivers/soundwire/irq.c b/drivers/soundwire/irq.c
> new file mode 100644
> index 0000000000000..0c08cebb1235c
> --- /dev/null
> +++ b/drivers/soundwire/irq.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2023 Cirrus Logic, Inc. and
> +//                    Cirrus Logic International Semiconductor Ltd.
> +
> +#include <linux/device.h>
> +#include <linux/fwnode.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/soundwire/sdw.h>
> +#include "irq.h"
> +
> +static int sdw_irq_map(struct irq_domain *h, unsigned int virq,
> +		       irq_hw_number_t hw)
> +{
> +	struct sdw_bus *bus = h->host_data;
> +
> +	irq_set_chip_data(virq, bus);
> +	irq_set_chip(virq, &bus->irq_chip);
> +	irq_set_nested_thread(virq, 1);
> +	irq_set_noprobe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops sdw_domain_ops = {
> +	.map	= sdw_irq_map,
> +};
> +
> +int sdw_irq_create(struct sdw_bus *bus,
> +		   struct fwnode_handle *fwnode)
> +{
> +	bus->irq_chip.name = dev_name(bus->dev);
> +
> +	bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
> +					       &sdw_domain_ops, bus);
> +	if (!bus->domain) {
> +		dev_err(bus->dev, "Failed to add IRQ domain\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void sdw_irq_delete(struct sdw_bus *bus)
> +{
> +	irq_domain_remove(bus->domain);
> +}
> +
> +void sdw_irq_create_mapping(struct sdw_slave *slave)
> +{
> +	slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
> +	if (!slave->irq)
> +		dev_warn(&slave->dev, "Failed to map IRQ\n");
> +}
> +
> +void sdw_irq_dispose_mapping(struct sdw_slave *slave)
> +{
> +	irq_dispose_mapping(irq_find_mapping(slave->bus->domain, slave->dev_num));
> +}
> diff --git a/drivers/soundwire/irq.h b/drivers/soundwire/irq.h
> new file mode 100644
> index 0000000000000..b6de49419fdf5
> --- /dev/null
> +++ b/drivers/soundwire/irq.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Cirrus Logic, Inc. and
> + *                    Cirrus Logic International Semiconductor Ltd.
> + */
> +
> +#ifndef __SDW_IRQ_H
> +#define __SDW_IRQ_H
> +
> +#include <linux/soundwire/sdw.h>
> +#include <linux/fwnode.h>
> +
> +#if IS_ENABLED(CONFIG_IRQ_DOMAIN)
> +
> +int sdw_irq_create(struct sdw_bus *bus,
> +		   struct fwnode_handle *fwnode);
> +void sdw_irq_delete(struct sdw_bus *bus);
> +void sdw_irq_create_mapping(struct sdw_slave *slave);
> +void sdw_irq_dispose_mapping(struct sdw_slave *slave);
> +
> +#else // CONFIG_IRQ_DOMAIN

/* ...*/ style please

> +
> +static inline int sdw_irq_create(struct sdw_bus *bus,
> +				 struct fwnode_handle *fwnode)
> +{
> +	return 0;
> +}
> +
> +static inline void sdw_irq_delete(struct sdw_bus *bus)
> +{
> +}
> +
> +static inline void sdw_irq_create_mapping(struct sdw_slave *slave)
> +{
> +}
> +
> +static inline void sdw_irq_dispose_mapping(struct sdw_slave *slave)
> +{
> +}
> +
> +#endif // CONFIG_IRQ_DOMAIN
> +
> +#endif // __SDW_IRQ_H
> -- 
> 2.39.2

-- 
~Vinod
