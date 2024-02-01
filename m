Return-Path: <linux-kernel+bounces-48350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EE845AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22667292C76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB19C5F49A;
	Thu,  1 Feb 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2ajoABc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D05CDF8;
	Thu,  1 Feb 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799647; cv=none; b=ICxsMxP40S97C7Dmf6VD3RJYq9xZ8vwnIyBAawfg6ZKxv6xxhP3w1p7j6kbvo1Rxz0EF/Ok2UN2RescOoNBNVHeBJp9qvyQI/6jFBv+654QSwMR2mI3bUhXztLAbRXQIjSdI3YBZjOlhzxNHnTIRyRE3IVwnasNuX5+6egpgZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799647; c=relaxed/simple;
	bh=XHfskHspmfYJuhvD8hh+5pmEbJ+2xIhYyQSuomUDNtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO/ZIfxYu+RzXNVoXzJJnJllX7mekqtG00D2omKXQCW8PWx1i8hCzPiM/BaBknaw+yFEO/ZoXpbFq/KiimxB65YmoKC9wFsOix+IV/O31T4t5U2aJAduQEDkngsca+Zyl3PtZseyNaE/CRA6PO1yBaDbVqHBmShLPl1iWcIIDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H2ajoABc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946D0C433C7;
	Thu,  1 Feb 2024 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706799646;
	bh=XHfskHspmfYJuhvD8hh+5pmEbJ+2xIhYyQSuomUDNtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2ajoABcYubKrIdEleS5/7jOZk4Loau492H6Swd6yTqTTQsKC7RzraOlr1H3+fqMw
	 kW/Z56aCWlTxkQj/rH3tErFw833VrC+RnDLKIMGZsMpCt7iYQuz7GaiOdDfhyP+t4T
	 1t3/was8W0cBOJiUrZRv4dq/z/Va9Bf+1ebYbRUc=
Date: Thu, 1 Feb 2024 07:00:45 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, megi@xff.cz,
	samuel@sholland.org, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: anx7688: Add driver for ANX7688 USB-C HDMI
 bridge
Message-ID: <2024020118-zesty-enticing-b7b3@gregkh>
References: <Zbt1dIByBZ2stzjm@mobian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt1dIByBZ2stzjm@mobian>

On Thu, Feb 01, 2024 at 11:41:56AM +0100, Pavel Machek wrote:
> +#define DEBUG

Please don't.  This is dynamic, use the dynamic debugging and set it
from userspace if you want to debug the driver.

> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/power_supply.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/pd.h>
> +#include <linux/usb/role.h>
> +#include <linux/usb/typec.h>
> +
> +/* firmware regs */
> +
> +#define ANX7688_REG_VBUS_OFF_DELAY_TIME 0x22
> +#define ANX7688_REG_FEATURE_CTRL        0x27
> +#define ANX7688_REG_EEPROM_LOAD_STATUS1 0x11
> +#define ANX7688_REG_EEPROM_LOAD_STATUS0 0x12
> +#define ANX7688_REG_FW_VERSION1         0x15
> +#define ANX7688_REG_FW_VERSION0         0x16
> +
> +#define ANX7688_EEPROM_FW_LOADED	0x01

Mix of tabs and spaces, please just use tabs.

> +static const char * const anx7688_supply_names[] = {
> +        "avdd33",
> +        "avdd18",
> +        "dvdd18",
> +        "avdd10",
> +        "dvdd10",
> +	"i2c",
> +        "hdmi_vt",
> +
> +        "vconn", // power for VCONN1/VCONN2 switches
> +        "vbus", // vbus power
> +};

Again, tabs vs. spaces, please use checkpatch.

> +#define ANX7688_NUM_SUPPLIES ARRAY_SIZE(anx7688_supply_names)
> +#define ANX7688_NUM_ALWAYS_ON_SUPPLIES (ANX7688_NUM_SUPPLIES - 1)
> +
> +#define ANX7688_I2C_INDEX (ANX7688_NUM_SUPPLIES - 4)
> +#define ANX7688_VCONN_INDEX (ANX7688_NUM_SUPPLIES - 2)
> +#define ANX7688_VBUS_INDEX (ANX7688_NUM_SUPPLIES - 1)
> +
> +enum {
> +	ANX7688_F_POWERED,
> +	ANX7688_F_CONNECTED,
> +	ANX7688_F_FW_FAILED,
> +	ANX7688_F_PWRSUPPLY_CHANGE,
> +	ANX7688_F_CURRENT_UPDATE,
> +};
> +
> +struct anx7688 {
> +        struct device *dev;
> +        struct i2c_client *client;
> +        struct i2c_client *client_tcpc;
> +        struct regulator_bulk_data supplies[ANX7688_NUM_SUPPLIES];
> +	struct power_supply *vbus_in_supply;
> +	struct notifier_block vbus_in_nb;
> +	int input_current_limit; // mA
> +        struct gpio_desc *gpio_enable;
> +        struct gpio_desc *gpio_reset;
> +        struct gpio_desc *gpio_cabledet;

I'm stopping here, again, tabs, you know this :(

greg k-h

