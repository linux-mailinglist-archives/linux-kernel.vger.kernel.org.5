Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1C7D4D62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjJXKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJXKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:11:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2C510A;
        Tue, 24 Oct 2023 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698142268; x=1729678268;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tE95dj+Xi4i7eZDrnp1PqL4N61DsKgtiHEoinaj/irc=;
  b=mj34lhheIDp7Arf5c4WRRyMMJ6VozlJ29oYLJ/7CQjL1pjhbXu4pwqpV
   SpkIDOUV6cZwOHSF23msPdRqubh27iarPbJpEr5fthK/6F9/lOzbwweGy
   cC1bFDiGIDF6fITjkN9fhhv9ziVAbyxG8SGUaSiI99RktstQsfda6rwUO
   5RemDTVp+8wVkYmcr7305Cce70JaJRLYQaQzvz0TzYcstfnPhCzSbCEON
   i4w/JCW6bkLV+fvdRz6avoHDUQuQBV032yE2Tcm7BgfvcSWFX5WDL/N4S
   g6oThCVl+A/j5Vd1ZrTiyyrMSmlAB2zJR44Llf1U08Me5j1YusZRpMVoh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473250339"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="473250339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089797091"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089797091"
Received: from nkraljev-mobl.ger.corp.intel.com ([10.249.41.91])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:10:39 -0700
Date:   Tue, 24 Oct 2023 13:10:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Brenda Streiff <brenda.streiff@ni.com>
cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 tty-next 2/2] serial: 8250: add driver for NI UARTs
In-Reply-To: <20231023210458.447779-3-brenda.streiff@ni.com>
Message-ID: <9ec2e99-b3a6-fb1a-148d-54bf4db16a95@linux.intel.com>
References: <20231023210458.447779-1-brenda.streiff@ni.com> <20231023210458.447779-3-brenda.streiff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Brenda Streiff wrote:

> The National Instruments (NI) 16550 is a 16550-like UART with larger
> FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
> patch adds a driver that can operate this UART, which is used for
> onboard serial ports in several NI embedded controller designs.
> 
> Portions of this driver were originally written by Jaeden Amero and
> Karthik Manamcheri, with extensive cleanups and refactors since.
> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>
> ---

> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/clk.h>
> +
> +#include "8250.h"
> +
> +/* Extra bits in UART_ACR */
> +#define NI16550_ACR_AUTO_DTR_EN			BIT(4)
> +
> +/* TFS - TX FIFO Size */
> +#define NI16550_TFS_OFFSET	0x0C
> +/* RFS - RX FIFO Size */
> +#define NI16550_RFS_OFFSET	0x0D
> +
> +/* PMR - Port Mode Register */
> +#define NI16550_PMR_OFFSET	0x0E
> +/* PMR[1:0] - Port Capabilities */
> +#define NI16550_PMR_CAP_MASK			GENMASK(1, 0)
> +#define NI16550_PMR_NOT_IMPL			0x00 /* not implemented */
> +#define NI16550_PMR_CAP_RS232			0x01 /* RS-232 capable */
> +#define NI16550_PMR_CAP_RS485			0x02 /* RS-485 capable */
> +#define NI16550_PMR_CAP_DUAL			0x03 /* dual-port */

Use FIELD_PREP() for these and add include for it.

> +/* PMR[4] - Interface Mode */
> +#define NI16550_PMR_MODE_MASK			GENMASK(4, 4)
> +#define NI16550_PMR_MODE_RS232			0x00 /* currently 232 */
> +#define NI16550_PMR_MODE_RS485			0x10 /* currently 485 */

Use FIELD_PREP() for these

> +
> +/* PCR - Port Control Register */
> +/*
> + * Wire Mode      | Tx enabled?          | Rx enabled?
> + * ---------------|----------------------|--------------------------
> + * PCR_RS422      | Always               | Always
> + * PCR_ECHO_RS485 | When DTR asserted    | Always
> + * PCR_DTR_RS485  | When DTR asserted    | Disabled when TX enabled
> + * PCR_AUTO_RS485 | When data in TX FIFO | Disabled when TX enabled
> + */
> +#define NI16550_PCR_OFFSET	0x0F

> +#define NI16550_PCR_RS422			0x00
> +#define NI16550_PCR_ECHO_RS485			0x01
> +#define NI16550_PCR_DTR_RS485			0x02
> +#define NI16550_PCR_AUTO_RS485			0x03

Are these part of NI16550_PCR_WIRE_MODE_MASK, if yes, reverse order and 
use FIELD_PREP() for them.

> +#define NI16550_PCR_WIRE_MODE_MASK		GENMASK(1, 0)
> +#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
> +#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
> +
> +/* flags for ni16550_device_info */
> +#define NI_HAS_PMR		BIT(0)
> +
> +struct ni16550_device_info {
> +	u32 uartclk;
> +	u8 prescaler;
> +	u8 flags;
> +};
> +
> +struct ni16550_data {
> +	int line;
> +	struct clk *clk;
> +};
> +
> +static int ni16550_enable_transceivers(struct uart_port *port)
> +{
> +	u8 pcr;
> +
> +	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
> +	pcr |= NI16550_PCR_TXVR_ENABLE_BIT;
> +	dev_dbg(port->dev, "enable transceivers: write pcr: 0x%02x\n", pcr);
> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> +
> +	return 0;
> +}
> +
> +static int ni16550_disable_transceivers(struct uart_port *port)
> +{
> +	u8 pcr;
> +
> +	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
> +	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> +
> +	return 0;
> +}
> +
> +static int ni16550_rs485_config(struct uart_port *port,
> +				struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	struct uart_8250_port *up = container_of(port, struct uart_8250_port, port);
> +	u8 pcr;
> +
> +	pcr = serial_in(up, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* RS-485 */

Very obvious comment, remove.

> +		dev_dbg(port->dev, "2-wire Auto\n");
> +		pcr |= NI16550_PCR_AUTO_RS485;
> +		up->acr |= NI16550_ACR_AUTO_DTR_EN;
> +	} else {
> +		/* RS-422 */
> +		dev_dbg(port->dev, "4-wire\n");

I might have asked this earlier but I don't recall anymore if there was 
an answer...

This comment and debug print confuses me, because RS-485 can also be 
4-wire full duplex, although it's rare to have such a setup in practice.

Also there's another recent patch where adding SER_RS422_ENABLED came 
up (IIRC) so you might want to look into that discussion too if there's 
something relevant for you.

> +		pcr |= NI16550_PCR_RS422;
> +		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
> +	}
> +
> +	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
> +	serial_out(up, NI16550_PCR_OFFSET, pcr);
> +	serial_icr_write(up, UART_ACR, up->acr);
> +
> +	return 0;
> +}
> +
> +static bool is_pmr_rs232_mode(struct uart_8250_port *up)
> +{
> +	u8 pmr = serial_in(up, NI16550_PMR_OFFSET);
> +	u8 pmr_mode = pmr & NI16550_PMR_MODE_MASK;
> +	u8 pmr_cap = pmr & NI16550_PMR_CAP_MASK;
> +
> +	/*
> +	 * If the PMR is not implemented, then by default NI UARTs are
> +	 * connected to RS-485 transceivers
> +	 */
> +	if (pmr_cap == NI16550_PMR_NOT_IMPL)
> +		return false;
> +
> +	if (pmr_cap == NI16550_PMR_CAP_DUAL)
> +		/*
> +		 * If the port is dual-mode capable, then read the mode bit
> +		 * to know the current mode
> +		 */
> +		return pmr_mode == NI16550_PMR_MODE_RS232;
> +	/*
> +	 * If it is not dual-mode capable, then decide based on the
> +	 * capability
> +	 */
> +	return pmr_cap == NI16550_PMR_CAP_RS232;
> +}
> +
> +static void ni16550_config_prescaler(struct uart_8250_port *up,
> +				     u8 prescaler)
> +{
> +	/*
> +	 * Page in the Enhanced Mode Registers
> +	 * Sets EFR[4] for Enhanced Mode.
> +	 */
> +	u8 lcr_value;
> +	u8 efr_value;
> +
> +	lcr_value = serial_in(up, UART_LCR);
> +	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +
> +	efr_value = serial_in(up, UART_EFR);
> +	efr_value |= UART_EFR_ECB;
> +
> +	serial_out(up, UART_EFR, efr_value);
> +
> +	/* Page out the Enhanced Mode Registers */
> +	serial_out(up, UART_LCR, lcr_value);
> +
> +	/* Set prescaler to CPR register. */
> +	serial_out(up, UART_SCR, UART_CPR);
> +	serial_out(up, UART_ICR, prescaler);
> +}
> +
> +static const struct serial_rs485 ni16550_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
> +	/*
> +	 * delay_rts_* and RX_DURING_TX are not supported.
> +	 *
> +	 * RTS_{ON,AFTER}_SEND are supported, but ignored; the transceiver
> +	 * is connected in only one way and we don't need userspace to tell
> +	 * us, but want to retain compatibility with applications that do.
> +	 */
> +};
> +
> +static void ni16550_rs485_setup(struct uart_port *port)
> +{
> +	port->rs485_config = ni16550_rs485_config;
> +	port->rs485_supported = ni16550_rs485_supported;
> +	/*
> +	 * The hardware comes up by default in 2-wire auto mode and we
> +	 * set the flags to represent that
> +	 */
> +	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
> +}
> +
> +static int ni16550_port_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	ret = serial8250_do_startup(port);
> +	if (ret)
> +		return ret;
> +
> +	return ni16550_enable_transceivers(port);
> +}
> +
> +static void ni16550_port_shutdown(struct uart_port *port)
> +{
> +	ni16550_disable_transceivers(port);
> +
> +	serial8250_do_shutdown(port);
> +}
> +
> +static int ni16550_get_regs(struct platform_device *pdev,
> +			    struct uart_port *port)
> +{
> +	struct resource *regs;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (regs) {
> +		port->iotype = UPIO_PORT;
> +		port->iobase = regs->start;
> +
> +		return 0;
> +	}
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (regs) {
> +		port->iotype = UPIO_MEM;
> +		port->mapbase = regs->start;
> +		port->mapsize = resource_size(regs);
> +		port->flags |= UPF_IOREMAP;
> +
> +		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
> +					     port->mapsize);
> +		if (!port->membase)
> +			return -ENOMEM;
> +
> +		return 0;
> +	}
> +
> +	dev_err(&pdev->dev, "no registers defined\n");
> +	return -EINVAL;
> +}
> +
> +static u8 ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)
> +{
> +	/*
> +	 * Very old implementations don't have the TFS or RFS registers
> +	 * defined, so we may read all-0s or all-1s. For such devices,
> +	 * assume a FIFO size of 128.
> +	 */

This is not a good place to add such a large comment, I'd make this a 
function comment instead because it's basically why you have this 
function in the first place.

> +	u8 value = serial_in(uart, reg);
> +
> +	if (value == 0x00 || value == 0xFF)
> +		return 128;
> +
> +	return value;
> +}


-- 
 i.

