Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750BF767059
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjG1PSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjG1PS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1656430FC;
        Fri, 28 Jul 2023 08:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCDC62173;
        Fri, 28 Jul 2023 15:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62509C433C8;
        Fri, 28 Jul 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690557506;
        bh=4CAHd/2r0jRCEBdeMRRG/xbAeKcA6Rjt+NeWrcq7040=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8XoCTCn3tpOxd6XF8c8QZxi1Xn7N1hTaVnUIPI3fNndomp5AxOqkwQAQ0zcRsXx7
         cpceRit7q95Xz2UOzpVhsSX1YuV3VFYUrr1mF+e/9R0ccqHDCE4fvSCeVsnSrE793E
         aYv652LYImnjokxHsM97tk5pkbCrfIZRBzYuHaC9COQl0nIPqEDe6D8tkLLpnW/4ET
         jTLem+01z8cM9ToiR8MP5pQbfCSKU9DyAj2KdH7jZZdV6PtftvEopRMYT58cLcUHBS
         LiHai2TR2UHlf8cWFBkUdAzaVz3bHCsd6oCLexfmVTJ8UOOmQFZThaDC+gP4X/tD5A
         cSFviGT3GqR0Q==
Date:   Fri, 28 Jul 2023 16:18:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <20230728151818.GL8175@google.com>
References: <20230725102532.2567580-1-ckeepax@opensource.cirrus.com>
 <20230725102532.2567580-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725102532.2567580-2-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod, Bard, Pierre-Louis, Sanyog,

This has been on the list for some time now.

Would one of you please review this, so we can get it merged?

On Tue, 25 Jul 2023, Charles Keepax wrote:

> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Currently the in-band alerts for SoundWire peripherals can only
> be communicated to the driver through the interrupt_callback
> function. This however is slightly inconvient for devices that wish to
> share IRQ handling code between SoundWire and I2C/SPI, the later would
> normally register an IRQ handler with the IRQ subsystem. However there
> is no reason the SoundWire in-band IRQs can not also be communicated
> as an actual IRQ to the driver.
> 
> Add support for SoundWire peripherals to register a normal IRQ handler
> to receive SoundWire in-band alerts, allowing code to be shared across
> control buses. Note that we allow users to use both the
> interrupt_callback and the IRQ handler, this is useful for devices which
> must clear additional chip specific SoundWire registers that are not a
> part of the normal IRQ flow, or the SoundWire specification.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v5.
> 
> Thanks,
> Charles
> 
>  drivers/soundwire/bus.c       | 32 ++++++++++++++++++++++++++++++++
>  drivers/soundwire/bus_type.c  | 12 ++++++++++++
>  include/linux/soundwire/sdw.h |  9 +++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index dba920ec88f6f..cf55386256f3f 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> +#include <linux/irq.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/soundwire/sdw_registers.h>
> @@ -25,6 +26,23 @@ static int sdw_get_id(struct sdw_bus *bus)
>  	return 0;
>  }
>  
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
>  /**
>   * sdw_bus_master_add() - add a bus Master instance
>   * @bus: bus instance
> @@ -151,6 +169,14 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  	bus->params.curr_bank = SDW_BANK0;
>  	bus->params.next_bank = SDW_BANK1;
>  
> +	bus->irq_chip.name = dev_name(bus->dev);
> +	bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
> +					       &sdw_domain_ops, bus);
> +	if (!bus->domain) {
> +		dev_err(bus->dev, "Failed to add IRQ domain\n");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(sdw_bus_master_add);
> @@ -187,6 +213,9 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  void sdw_bus_master_delete(struct sdw_bus *bus)
>  {
>  	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
> +
> +	irq_domain_remove(bus->domain);
> +
>  	sdw_master_device_del(bus);
>  
>  	sdw_bus_debugfs_exit(bus);
> @@ -1725,6 +1754,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  				struct device *dev = &slave->dev;
>  				struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>  
> +				if (slave->prop.use_domain_irq && slave->irq)
> +					handle_nested_irq(slave->irq);
> +
>  				if (drv->ops && drv->ops->interrupt_callback) {
>  					slave_intr.sdca_cascade = sdca_cascade;
>  					slave_intr.control_port = clear;
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 1f43ee848eac8..fafbc284e82da 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -122,6 +122,12 @@ static int sdw_drv_probe(struct device *dev)
>  	if (drv->ops && drv->ops->read_prop)
>  		drv->ops->read_prop(slave);
>  
> +	if (slave->prop.use_domain_irq) {
> +		slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
> +		if (!slave->irq)
> +			dev_warn(dev, "Failed to map IRQ\n");
> +	}
> +
>  	/* init the sysfs as we have properties now */
>  	ret = sdw_slave_sysfs_init(slave);
>  	if (ret < 0)
> @@ -166,7 +172,13 @@ static int sdw_drv_remove(struct device *dev)
>  	int ret = 0;
>  
>  	mutex_lock(&slave->sdw_dev_lock);
> +
>  	slave->probed = false;
> +
> +	if (slave->prop.use_domain_irq)
> +		irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
> +						     slave->dev_num));
> +
>  	mutex_unlock(&slave->sdw_dev_lock);
>  
>  	if (drv->remove)
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index f523ceabd0596..8923387a7405b 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -6,6 +6,8 @@
>  
>  #include <linux/bug.h>
>  #include <linux/lockdep_types.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/bitfield.h>
>  
> @@ -370,6 +372,7 @@ struct sdw_dpn_prop {
>   * @clock_reg_supported: the Peripheral implements the clock base and scale
>   * registers introduced with the SoundWire 1.2 specification. SDCA devices
>   * do not need to set this boolean property as the registers are required.
> + * @use_domain_irq: call actual IRQ handler on slave, as well as callback
>   */
>  struct sdw_slave_prop {
>  	u32 mipi_revision;
> @@ -394,6 +397,7 @@ struct sdw_slave_prop {
>  	u8 scp_int1_mask;
>  	u32 quirks;
>  	bool clock_reg_supported;
> +	bool use_domain_irq;
>  };
>  
>  #define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
> @@ -641,6 +645,7 @@ struct sdw_slave_ops {
>   * struct sdw_slave - SoundWire Slave
>   * @id: MIPI device ID
>   * @dev: Linux device
> + * @irq: IRQ number
>   * @status: Status reported by the Slave
>   * @bus: Bus handle
>   * @prop: Slave properties
> @@ -670,6 +675,7 @@ struct sdw_slave_ops {
>  struct sdw_slave {
>  	struct sdw_slave_id id;
>  	struct device dev;
> +	int irq;
>  	enum sdw_slave_status status;
>  	struct sdw_bus *bus;
>  	struct sdw_slave_prop prop;
> @@ -885,6 +891,7 @@ struct sdw_master_ops {
>   * is used to compute and program bus bandwidth, clock, frame shape,
>   * transport and port parameters
>   * @debugfs: Bus debugfs
> + * @domain: IRQ domain
>   * @defer_msg: Defer message
>   * @clk_stop_timeout: Clock stop timeout computed
>   * @bank_switch_timeout: Bank switch timeout computed
> @@ -920,6 +927,8 @@ struct sdw_bus {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;
>  #endif
> +	struct irq_chip irq_chip;
> +	struct irq_domain *domain;
>  	struct sdw_defer defer_msg;
>  	unsigned int clk_stop_timeout;
>  	u32 bank_switch_timeout;
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]
