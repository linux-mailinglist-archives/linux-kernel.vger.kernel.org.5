Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675E17A7A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjITLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjITLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:13:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8044E4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:13:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81508C433CA;
        Wed, 20 Sep 2023 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208413;
        bh=Jl9sN6MH4FuJOWjrEPg++mG8zFXtqvv+0NEC7/S5d5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeHVQpRVGj8XHwKxxNfMca2SYIpartUGr5Kp52KgY4kcv8H9mhYbFcH2ASKTucTdK
         kTFNlNcoGl7wQ7O7kWnBeDTFabx+BSA0WIuUYdQO4juV+y2W+W0EULvh7oRbOF/4ab
         oluF6vDicelylaX6uE12AL9khmzMJ89VZapgjFDfg7DuHIN/dKvZncio1l75F3YniF
         uv/dgMikzYAUmGmTH7/YbA6PuOc2IWl+4CKUh8tlEMFmGVpax07UGNU8rY3Z5bjsua
         nxHgX5927tVhEAZ6+juPaAC9lB83pBM9sHXRQKQXqb3wPYpThvLNkKW/03sgCsB/5X
         a6WOzKrMG4etA==
Date:   Wed, 20 Sep 2023 12:13:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver
Message-ID: <20230920111329.GD13143@google.com>
References: <20230907031320.6814-1-advantech.susiteam@gmail.com>
 <20230907031320.6814-5-advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907031320.6814-5-advantech.susiteam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023, advantech.susiteam@gmail.com wrote:

> From: Wenkai <advantech.susiteam@gmail.com>
> 
> This patch introduces the Advantech EIO-IS200 Series EC Core Driver.
> The EIO-IS200 combines hardware functionality with firmware
> capabilities to provide key features through a dedicated Power
> Management Channel (PMC).
> 
> Key Features:
> - Implements the core EIO-IS200 IC driver that serves as the
>   interface to the IC's firmware and hardware functions.
> - Contains low-level functions for accessing the IC's Power
>   Management Channel (PMC).
> - Manages PMC command execution, PMC buffer handling, and
>   communication.
> - Expose a regmap and a mutex for low-level access.
> - Activates support for GPIO, I2C, Hwmon, and Watchdog functionalities
>   of the EIO-IS200 IC.
> - Provides various sysfs attributes to expose information about the
>   EC chip, firmware, and motherboard.
> - Includes a timeout parameter to allow modification of the default
>   PMC command timeout value, which is particularly useful when
>   dealing with an extremely slow-responding device.
> 
> Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
> ---
>  drivers/mfd/eiois200_core.c | 590 ++++++++++++++++++++++++++++++++++++

Please organise patches by functionality, not file.

Each of the patches in this series are worthless without the others.

Have you run static analysis on this?

What about checkpatch.pl?

>  1 file changed, 590 insertions(+)
>  create mode 100644 drivers/mfd/eiois200_core.c
> 
> diff --git a/drivers/mfd/eiois200_core.c b/drivers/mfd/eiois200_core.c
> new file mode 100644
> index 000000000000..7459dee1ed53
> --- /dev/null
> +++ b/drivers/mfd/eiois200_core.c
> @@ -0,0 +1,590 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Advantech EIO-IS200 Series EC base Driver
> + *
> + * This driver provides an interface to access the EIO-IS200 Series EC
> + * firmware via its own Power Management Channel (PMC) for subdrivers:
> + *
> + * - Watchdog: drivers/watchdog/eiois200_wdt
> + * - GPIO: drivers/gpio/gpio_eiois200
> + * - Hwmon: drivers/hwmon/eiois200_hwmon
> + * - I2C: drivers/i2c/busses/i2c_eiois200
> + * - Thermal: drivers/thermal/eiois200_thermal

None of these exist.  I would remove these completely. They will be
highly susceptible to bit-rot.

> + * A system may have one or two independent EIO-IS200s.
> + *
> + * Copyright (C) 2023 Advantech Co., Ltd.
> + * Author: wenkai.chung <wenkai.chung@advantech.com.tw>

Is the name on your government ID "wenkai.chung"?
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/isa.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mutex.h>
> +#include <linux/time.h>
> +#include <linux/uaccess.h>
> +
> +#include "eiois200.h"
> +
> +#define TIMEOUT_MAX	(10 * 1000 * 1000)

There are helpers to convert between time bases.  Please use them.

Where do these values come from?

> +#define TIMEOUT_MIN	200
> +
> +static uint timeout = 5000;

Why 5000?

> +module_param(timeout, uint, 0664);
> +MODULE_PARM_DESC(timeout,
> +		 "Default PMC command timeout in usec.\n");

How useful is it to override this on the commandline, really?

> +struct eiois200_dev_port {
> +	u16 idx;
> +	u16 data;

2 of the worst variable names of all time.

Please ensure variable names describe their purpose.

> +};
> +
> +struct eiois200_dev_port pnp_port[] = {
> +	{ .idx = EIOIS200_PNP_INDEX,	 .data = EIOIS200_PNP_DATA     },
> +	{ .idx = EIOIS200_SUB_PNP_INDEX, .data = EIOIS200_SUB_PNP_DATA },
> +};
> +
> +static struct eiois200_dev *eiois200_dev;
> +static struct regmap *regmap_is200;

Avoid globals at all (most, many ...) costs.

> +static struct mfd_cell susi_mfd_devs[] = {
> +	{ .name = "eiois200_wdt"     },
> +	{ .name = "gpio_eiois200"    },
> +	{ .name = "eiois200_hwmon"   },
> +	{ .name = "eiois200_i2c"     },
> +	{ .name = "eiois200_thermal" },
> +};
> +
> +struct regmap_range is200_range[] = {
> +	 regmap_reg_range(EIOIS200_PNP_INDEX,	  EIOIS200_PNP_DATA),
> +	 regmap_reg_range(EIOIS200_SUB_PNP_INDEX, EIOIS200_SUB_PNP_DATA),
> +	 regmap_reg_range(EIOIS200_PMC_PORT,	  EIOIS200_PMC_PORT + 0x0F),
> +	 regmap_reg_range(EIOIS200_PMC_PORT_SUB,  EIOIS200_PMC_PORT_SUB + 0x0F),
> +};
> +
> +static const struct regmap_access_table volatile_regs = {
> +	.yes_ranges   = is200_range,
> +	.n_yes_ranges = ARRAY_SIZE(is200_range),
> +};
> +
> +static const struct regmap_config pnp_regmap_config = {
> +	.name		= "eiois200-gpio",
> +	.reg_bits	= 16,
> +	.val_bits	= 8,
> +	.volatile_table = &volatile_regs,
> +	.io_port	= true,
> +};
> +
> +/* Following are EIO-IS200 pnp io port access functions */

"IO"

Probably "PNP" too.

> +static int is200_pnp_read(struct eiois200_dev_port *port, u8 idx)
> +{
> +	int val;
> +
> +	if (regmap_write(regmap_is200, port->idx, idx))
> +		pr_err("Error port write 0x%X\n", port->idx);

Why pr_err()?  You should have a 'dev' pointer.  So use dev_err().

> +	if (regmap_read(regmap_is200, port->data, &val))
> +		pr_err("Error port read 0x%X\n", port->data);
> +
> +	return val;
> +}
> +
> +static void is200_pnp_write(struct eiois200_dev_port *port, u8 idx, u8 data)
> +{
> +	if (regmap_write(regmap_is200, port->idx, idx) ||
> +	    regmap_write(regmap_is200, port->data, data))
> +		pr_err("Error port write 0x%X %X\n",
> +		       port->idx, port->data);
> +}
> +
> +static void is200_pnp_enter(struct eiois200_dev_port *port)
> +{
> +	if (regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_ENTER) ||
> +	    regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_ENTER))

How are these 2 calls any different to each other?

> +		pr_err("Error port write 0x%X\n", port->idx);

Return error?

> +}
> +
> +static void is200_pnp_leave(struct eiois200_dev_port *port)
> +{
> +	if (regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_EXIT))
> +		pr_err("Error port write 0x%X\n", port->idx);

Return error?

> +}
> +
> +/* Following are EIO-IS200 io port access functions for pmc command */
> +static int pmc_write_data(int id, u8 value, u16 timeout)
> +{
> +	int ret;
> +
> +	if (WAIT_IBF(id, timeout))
> +		return -ETIME;

What's happening here?

> +	ret = regmap_write(regmap_is200, eiois200_dev->pmc[id].data, value);
> +	if (ret)
> +		pr_err("Error pmc write %X:%X\n",
> +		       eiois200_dev->pmc[id].data, value);
> +
> +	return ret;
> +}
> +
> +static int pmc_write_cmd(int id, u8 value, u16 timeout)
> +{
> +	int ret;
> +
> +	if (WAIT_IBF(id, timeout))
> +		return -ETIME;
> +
> +	ret = regmap_write(regmap_is200, eiois200_dev->pmc[id].cmd, value);
> +	if (ret)
> +		pr_err("Error pmc write %X:%X\n",
> +		       eiois200_dev->pmc[id].data, value);
> +
> +	return ret;
> +}
> +
> +static int pmc_read_data(int id, u8 *value, u16 timeout)
> +{
> +	int val, ret;
> +
> +	if (WAIT_OBF(id, timeout))
> +		return -ETIME;
> +
> +	ret = regmap_read(regmap_is200, eiois200_dev->pmc[id].data, &val);
> +	if (ret)
> +		pr_err("Error pmc read %X\n", eiois200_dev->pmc[id].data);
> +	else
> +		*value = val & 0xFF;
> +
> +	return ret;
> +}
> +
> +static int pmc_read_status(int id)
> +{
> +	int val;
> +
> +	if (regmap_read(regmap_is200, eiois200_dev->pmc[id].data, &val)) {
> +		pr_err("Error pmc read %X\n", eiois200_dev->pmc[id].data);
> +		return 0;

You've just filed and yet you are returning success?

> +	}
> +
> +	return val;
> +}
> +
> +static void pmc_clear(int id)
> +{
> +	int val;
> +
> +	/* Check if input buffer blocked */
> +	if ((pmc_read_status(id) & EIOIS200_PMC_STATUS_IBF) == 0)
> +		return;
> +
> +	/* Read out previous garbage */
> +	if (regmap_read(regmap_is200, eiois200_dev->pmc[id].data, &val))
> +		pr_err("Error pmc clear\n");
> +
> +	usleep_range(10, 100);
> +}
> +
> +/**
> + * eiois200_core_pmc_wait - Wait for input / output buffer to be ready.
> + * @id:			0 for main chip, 1 for sub chip.
> + * @wait:		%PMC_WAIT_INPUT or %PMC_WAIT_OUTPUT.
> + *			%PMC_WAIT_INPUT for waiting input buffer data ready.
> + *			%PMC_WAIT_OUTPUT for waiting output buffer empty.
> + * max_duration:	The timeout value in usec.
> + */
> +int eiois200_core_pmc_wait(int id,
> +			   enum eiois200_pmc_wait wait,
> +			   uint max_duration)
> +{
> +	u32	cnt = 0;
> +	uint	val;
> +	int	ret;
> +	int	new_timeout = max_duration ? max_duration : timeout;
> +	ktime_t time_end    = ktime_add_us(ktime_get(), new_timeout);

Remove all of this type of lining up.

> +
> +	if (new_timeout > TIMEOUT_MAX ||
> +	    new_timeout < TIMEOUT_MIN) {

Why the '\n' here?

> +		pr_err("Error timeout value: %dus\nTimeout value should between %d and %d\n",

Avoid line breaks in error messages.

> +		       new_timeout, TIMEOUT_MIN, TIMEOUT_MAX);
> +		return -ETIME;
> +	}
> +
> +	do {
> +		ret = regmap_read(regmap_is200,
> +				  eiois200_dev->pmc[id].status,
> +				  &val);
> +		if (ret)
> +			return ret;
> +
> +		if (wait == PMC_WAIT_INPUT) {
> +			if ((val & EIOIS200_PMC_STATUS_IBF) == 0)
> +				return 0;
> +		} else {
> +			if ((val & EIOIS200_PMC_STATUS_OBF) != 0)
> +				return 0;
> +		}
> +
> +		/* Incremental delay */
> +		fsleep(cnt++ * 10);
> +
> +	} while (ktime_before(ktime_get(), time_end));
> +
> +	return -ETIME;
> +}
> +EXPORT_SYMBOL_GPL(eiois200_core_pmc_wait);
> +
> +/**
> + * eiois200_core_pmc_operation - Execute a pmc command

"PMC"

> + * @op:		Pointer to an pmc command.
> + */
> +int eiois200_core_pmc_operation(struct _pmc_op *op)
> +{
> +	u8 	i;
> +	int	ret;
> +	bool	read_cmd = op->cmd & 0x01;
> +	ktime_t t = ktime_get();
> +
> +	mutex_lock(&eiois200_dev->mutex);
> +
> +	pmc_clear(op->chip);
> +
> +	ret = pmc_write_cmd(op->chip, op->cmd, op->timeout);
> +	if (ret)
> +		goto err;
> +
> +	ret = pmc_write_data(op->chip, op->control, op->timeout);
> +	if (ret)
> +		goto err;
> +
> +	ret = pmc_write_data(op->chip, op->device_id, op->timeout);
> +	if (ret)
> +		goto err;
> +
> +	ret = pmc_write_data(op->chip, op->size, op->timeout);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0 ; i < op->size ; i++) {

Remove the spaces before the ';'s.

> +		if (read_cmd)
> +			ret = pmc_read_data(op->chip, &op->payload[i], op->timeout);
> +		else
> +			ret = pmc_write_data(op->chip, op->payload[i], op->timeout);
> +
> +		if (ret)
> +			goto err;
> +	}
> +
> +	mutex_unlock(&eiois200_dev->mutex);
> +
> +	return 0;
> +
> +err:
> +	mutex_unlock(&eiois200_dev->mutex);
> +
> +	pr_err("PMC error duration:%lldus\n",
> +	       ktime_to_us(ktime_sub(ktime_get(), t)));

Why the line wrap.

> +	pr_err(".cmd=0x%02X, .ctrl=0x%02X .id=0x%02X, .size=0x%02X .data=0x%02X%02X\n",
> +	       op->cmd, op->control, op->device_id,
> +	       op->size, op->payload[0], op->payload[1]);

Are these prints actually useful?

I'd suggest that they are debug prints at best.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(eiois200_core_pmc_operation);
> +
> +static int get_pmc_port(struct device *dev, int id, struct eiois200_dev_port *port)
> +{
> +	struct _pmc_port *pmc = &eiois200_dev->pmc[id];

What's with the '_'?

This usually means that it's internal and should not be used.

> +	is200_pnp_enter(port);
> +
> +	/* Switch to PMC device page */
> +	is200_pnp_write(port, EIOIS200_LDN, EIOIS200_LDN_PMC1);
> +
> +	/* Active this device */
> +	is200_pnp_write(port, EIOIS200_LDAR, EIOIS200_LDAR_LDACT);
> +
> +	/* Get PMC cmd and data port */
> +	pmc->data  = is200_pnp_read(port, EIOIS200_IOBA0H) << 8;
> +	pmc->data |= is200_pnp_read(port, EIOIS200_IOBA0L);
> +	pmc->cmd   = is200_pnp_read(port, EIOIS200_IOBA1H) << 8;
> +	pmc->cmd  |= is200_pnp_read(port, EIOIS200_IOBA1L);
> +
> +	/* Disable IRQ */
> +	is200_pnp_write(port, EIOIS200_IRQCTRL, 0);
> +
> +	is200_pnp_leave(port);
> +
> +	/* Make sure IO ports are not occupied */
> +	if (!devm_request_region(dev, pmc->data, 2, KBUILD_MODNAME)) {
> +		dev_err(dev, "Request region %X error\n", pmc->data);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eiois200_exist(struct device *dev)
> +{
> +	u16  chip_id = 0;
> +	u8   tmp = 0;
> +	int  i = 0;
> +	int  ret = -ENOMEM;
> +	char chip[][8] = { "First",  "Second" };
> +
> +	for (i = 0 ; i < ARRAY_SIZE(pnp_port) ; i++) {

Should 'i' be 'port' here?

> +		struct eiois200_dev_port *port = pnp_port + i;
> +
> +		if (!devm_request_region(dev,
> +					 pnp_port[i].idx,
> +					 2,

What's 2?  This should probably be defined.

> +					 KBUILD_MODNAME))
> +			continue;
> +
> +		is200_pnp_enter(port);
> +
> +		chip_id  = is200_pnp_read(port, EIOIS200_CHIPID1) << 8;
> +		chip_id |= is200_pnp_read(port, EIOIS200_CHIPID2);
> +
> +		if (chip_id != EIOIS200_CHIPID &&
> +		    chip_id != EIO201_211_CHIPID)
> +			continue;
> +
> +		/* Turn on the enable flag */
> +		tmp = is200_pnp_read(port, EIOIS200_SIOCTRL);
> +		tmp |= EIOIS200_SIOCTRL_SIOEN;
> +		is200_pnp_write(port, EIOIS200_SIOCTRL, tmp);
> +
> +		is200_pnp_leave(port);
> +
> +		ret = get_pmc_port(dev, i, port);
> +		if (ret)
> +			return ret;
> +
> +		eiois200_dev->flag |= i == 0 ?  EIOIS200_F_CHIP_EXIST :

This logic either needs improving or commented on.

> +						EIOIS200_F_SUB_CHIP_EXIST;
> +
> +		pr_info("%s chip detected: %04X\n", chip[i], chip_id);

We can almost certainly do without these in production code.

> +	}
> +
> +	return ret;
> +}
> +
> +/* read information about acpi stored in EC */

Please use prober grammar.

"Read ACPI information stored in the EC"

> +static uint8_t acpiram_access(uint8_t offset)
> +{
> +	u8  val;
> +	int ret;
> +
> +	mutex_lock(&eiois200_dev->mutex);
> +
> +	pmc_clear(0);
> +
> +	ret = pmc_write_cmd(0, EIOIS200_PMC_CMD_ACPIRAM_READ, 0);

All of the magic numbers in this function need to be defined.

> +	if (ret)
> +		goto err;
> +
> +	ret = pmc_write_data(0, offset, 0);
> +	if (ret)
> +		goto err;
> +
> +	ret = pmc_write_data(0, 1, 0);
> +	if (ret)
> +		goto err;
> +
> +	ret = pmc_read_data(0, &val, 0);
> +	if (ret)
> +		goto err;
> +
> +err:
> +	mutex_unlock(&eiois200_dev->mutex);
> +	return ret ? 0 : val;

If it fails, you return success?

> +}
> +
> +static int firmware_code_base(struct device *dev)
> +{
> +	u8 ic_vendor, ic_code, code_base;
> +
> +	ic_vendor = acpiram_access(EIOIS200_ACPIRAM_ICVENDOR);
> +	ic_code   = acpiram_access(EIOIS200_ACPIRAM_ICCODE);
> +	code_base = acpiram_access(EIOIS200_ACPIRAM_CODEBASE);
> +
> +	if (ic_vendor != 'R')
> +		return -ENODEV;
> +
> +	if (ic_code != EIOIS200_ICCODE &&
> +	    ic_code != EIO201_ICCODE   &&
> +	    ic_code != EIO211_ICCODE)
> +		goto err;
> +
> +	if (code_base == 0x80) {

No magic numbers please.

> +		eiois200_dev->flag |= EIOIS200_F_NEW_CODE_BASE;
> +		return 0;
> +	}
> +
> +	if (code_base == 0 && (ic_code != EIO201_ICCODE &&
> +			       ic_code != EIO211_ICCODE)) {
> +		pr_info("Old code base not supported, yet.");
> +		return -ENODEV;
> +	}
> +
> + err:
> +	dev_err(dev,
> +		"Codebase check fail:\n"
> +		"ic_vendor: 0x%X  ,ic_code : 0x%X ,code_base : 0x%X\n",
> +		ic_vendor, ic_code, code_base);

These are really ugly prints.

Also, they should not contain new lines.

> +	return -ENODEV;
> +}
> +
> +int eiois200_probe(struct device *dev, unsigned int id)

.probe() usually goes near the bottom.

> +{
> +	int  ret = 0;
> +	void __iomem *iomem;

Swap these over.

> +	iomem = devm_ioport_map(dev, 0, EIOIS200_SUB_PNP_DATA + 1);
> +	if (!iomem)
> +		return -ENOMEM;
> +
> +	regmap_is200 = devm_regmap_init_mmio(dev, iomem, &pnp_regmap_config);
> +	if (!regmap_is200)
> +		return -ENOMEM;
> +
> +	eiois200_dev = devm_kzalloc(dev,
> +				    sizeof(struct eiois200_dev),

sizeof(*eiois200_dev)

> +				    GFP_KERNEL);
> +	if (!eiois200_dev)
> +		return -ENOMEM;
> +
> +	mutex_init(&eiois200_dev->mutex);
> +
> +	if (eiois200_exist(dev))
> +		return -ENODEV;
> +
> +	if (firmware_code_base(dev)) {
> +		dev_err(dev, "Chip code base check fail\n");
> +		return -EIO;
> +	}
> +
> +	dev_set_drvdata(dev, eiois200_dev);

What data have you stored in eiois200_dev?

> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, susi_mfd_devs,
> +				   ARRAY_SIZE(susi_mfd_devs),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		dev_err(dev, "Cannot register child devices (error = %d)\n", ret);
> +
> +	pr_info("%s started", KBUILD_MODNAME);

These prints are not useful, please remove them.

> +
> +	return 0;
> +}
> +
> +struct {
> +	char name[32];
> +	int  cmd;
> +	int  ctrl;
> +	int  size;
> +} attrs[] = {
> +	{ "board_name",		0x53, 0x10, 16 },
> +	{ "board_serial",	0x53, 0x1F, 16 },
> +	{ "board_manufacturer", 0x53, 0x11, 16 },
> +	{ "board_id",		0x53, 0x1E,  4 },
> +	{ "firmware_version",	0x53, 0x22, 16 },
> +	{ "firmware_build",	0x53, 0x23, 26 },
> +	{ "firmware_date",	0x53, 0x24, 16 },
> +	{ "chip_id",		0x53, 0x12, 12 },
> +	{ "chip_detect",	0x53, 0x15, 12 },
> +	{ "platform_type",	0x53, 0x13, 16 },
> +	{ "platform_revision",	0x53, 0x14,  4 },
> +	{ "eapi_version",	0x53, 0x30,  4 },
> +	{ "eapi_id",		0x53, 0x31,  4 },
> +	{ "boot_count",		0x55, 0x10,  4 },
> +	{ "powerup_hour",	0x55, 0x11,  4 },
> +};
> +
> +static ssize_t info_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)

SYSFS handling usually goes near the top.

> +{
> +	uint i;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(attrs) ; i++)
> +		if (!strcmp(attr->attr.name, attrs[i].name)) {
> +			int ret;
> +			char str[32] = "";
> +			struct _pmc_op op = {
> +				.cmd     = attrs[i].cmd,
> +				.control = attrs[i].ctrl,
> +				.payload = (u8 *)str,
> +				.size    = attrs[i].size,
> +			};
> +
> +			ret = eiois200_core_pmc_operation(&op);
> +			if (ret)
> +				return ret;
> +
> +			if (attrs[i].size == 4)
> +				return sysfs_emit(buf, "%X\n", *(u32 *)str);
> +			else
> +				return sysfs_emit(buf, "%s\n", str);
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static DEVICE_ATTR(board_name,		0444, info_show, NULL);
> +static DEVICE_ATTR(board_serial,	0444, info_show, NULL);
> +static DEVICE_ATTR(board_manufacturer,	0444, info_show, NULL);
> +static DEVICE_ATTR(firmware_version,	0444, info_show, NULL);
> +static DEVICE_ATTR(firmware_build,	0444, info_show, NULL);
> +static DEVICE_ATTR(firmware_date,	0444, info_show, NULL);
> +static DEVICE_ATTR(chip_id,		0444, info_show, NULL);
> +static DEVICE_ATTR(chip_detect,		0444, info_show, NULL);
> +static DEVICE_ATTR(platform_type,	0444, info_show, NULL);
> +static DEVICE_ATTR(platform_revision,	0444, info_show, NULL);
> +static DEVICE_ATTR(board_id,		0444, info_show, NULL);
> +static DEVICE_ATTR(eapi_version,	0444, info_show, NULL);
> +static DEVICE_ATTR(eapi_id,		0444, info_show, NULL);
> +static DEVICE_ATTR(boot_count,		0444, info_show, NULL);
> +static DEVICE_ATTR(powerup_hour,	0444, info_show, NULL);
> +
> +static struct attribute *pmc_attrs[] = {
> +	&dev_attr_board_name.attr,
> +	&dev_attr_board_serial.attr,
> +	&dev_attr_board_manufacturer.attr,
> +	&dev_attr_firmware_version.attr,
> +	&dev_attr_firmware_build.attr,
> +	&dev_attr_firmware_date.attr,
> +	&dev_attr_chip_id.attr,
> +	&dev_attr_chip_detect.attr,
> +	&dev_attr_platform_type.attr,
> +	&dev_attr_platform_revision.attr,
> +	&dev_attr_board_id.attr,
> +	&dev_attr_eapi_version.attr,
> +	&dev_attr_eapi_id.attr,
> +	&dev_attr_boot_count.attr,
> +	&dev_attr_powerup_hour.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group attr_group = {
> +	.attrs = pmc_attrs,
> +};
> +
> +static const struct attribute_group *attr_groups[] = {
> +	&attr_group,
> +	NULL
> +};

Pretty sure there are helper MACROS for this.

> +static struct isa_driver eiois200_driver = {
> +	.probe    = eiois200_probe,
> +
> +	.driver = {
> +		.owner = THIS_MODULE,

Are you sure the class doesn't do this for you?

> +		.name  = KBUILD_MODNAME,

Use a proper string.

> +		.dev_groups = attr_groups,
> +	},
> +};
> +
> +module_isa_driver(eiois200_driver, 1);
> +
> +MODULE_AUTHOR("susi.driver <susi.driver@advantech.com.tw>");

This does not match the credentials above.

> +MODULE_DESCRIPTION("Advantech EIO-IS200 series EC core driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
