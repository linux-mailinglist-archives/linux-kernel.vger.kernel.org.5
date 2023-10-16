Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC667CA7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:14:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5718E;
        Mon, 16 Oct 2023 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697458442; x=1728994442;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fYX09gVTs+rdDQq31Aoyype6rTbwF7iR1knuJuk7e3c=;
  b=YJIgkJkiK06uaWWlR8PBXUYghOok8tWbm6xqg/Gp+UrIm9/teAqypPSw
   XblyLHWYKcS4rlVfvmM7j4jYLckJzWY0100mIwISAO0DwH5jLtJ5jDeK4
   IQDwrBX3rZGy3Y6cop36fusWR3WZZX04dfUSQXYr3Tj9u17s2ZTOGJoyv
   xIHHEqoY3XlztNI0a3wFGLaUIpiHiOYrVVjliyK6RhygxHcQXz0PhferE
   gOwpVBxSJIhsIbwmRr8anteOrjdWGWjHl9NgS/taEIgStVhwyyY7/2N80
   jGzNad//S4EJFuYrPPAqW/QHYuvrFWlircBFxHWDMtB5tMblDY6uXpqiI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="449720154"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="449720154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929322173"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="929322173"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:13:59 -0700
Date:   Mon, 16 Oct 2023 15:13:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Laing <richard.laing@alliedtelesis.co.nz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ilpo.jarvinen@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Allow TX FIFO to drain before writing
 to UART_LCR An issue has been observed on the Broadcom BCM56160 serial port
 which appears closely related to a similar issue on the Marvell Armada 38x
 serial port.
In-Reply-To: <20231016013207.2249946-2-richard.laing@alliedtelesis.co.nz>
Message-ID: <fb92ed83-478-4d71-2bd-ab3a37b1352@linux.intel.com>
References: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz> <20231016013207.2249946-2-richard.laing@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023, Richard Laing wrote:

Your subject line is way too long. If you refer to some other issue, 
please link to it properly with commit id and/or with Link: tags.

> Writes to UART_LCR can result in characters that are currently held in the
> TX FIFO being lost rather than sent, even if the userspace process has
> attempted to flush them.
> 
> This is most visible when using the "resize" command (tested on Busybox),
> where we have observed the escape code for restoring cursor position
> becoming mangled.
> 
> Since this appears to be a more common problem add a new driver option
> to flush the TX FIFO before writing to the UART_LCR.

This looks like a problem we already have solution for, the userspace can 
use TCSADRAIN/FLUSH to indicate what kind of flushing it wants for Tx 
when it makes the tcsetattr() call. Thus, userspace can avoid the Tx side 
corruption as long as its behavior is sane and doesn't e.g. try to race 
writes with tcsetattr() call as mentioned in commit 094fb49a2d0d ("tty: 
Prevent writing chars during tcsetattr TCSADRAIN/FLUSH").

Have you tried to use the userspace solution? Isn't it working for some 
reason?

-- 
 i.

> 
> Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
> ---
>  drivers/tty/serial/8250/8250_dw.c    | 18 ++++++++++++++++++
>  drivers/tty/serial/8250/8250_dwlib.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f4cafca1a7da..17ee824294c7 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -161,6 +161,10 @@ static void dw8250_serial_out(struct uart_port *p, int offset, int value)
>  {
>  	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
> +	/* Allow the TX to drain before we reconfigure */
> +	if (offset == UART_LCR && d->drain_before_lcr_change)
> +		dw8250_tx_wait_empty(p);
> +
>  	writeb(value, p->membase + (offset << p->regshift));
>  
>  	if (offset == UART_LCR && !d->uart_16550_compatible)
> @@ -197,6 +201,10 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>  {
>  	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
> +	/* Allow the TX to drain before we reconfigure */
> +	if (offset == UART_LCR && d->drain_before_lcr_change)
> +		dw8250_tx_wait_empty(p);
> +
>  	value &= 0xff;
>  	__raw_writeq(value, p->membase + (offset << p->regshift));
>  	/* Read back to ensure register write ordering. */
> @@ -211,6 +219,10 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>  {
>  	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
> +	/* Allow the TX to drain before we reconfigure */
> +	if (offset == UART_LCR && d->drain_before_lcr_change)
> +		dw8250_tx_wait_empty(p);
> +
>  	writel(value, p->membase + (offset << p->regshift));
>  
>  	if (offset == UART_LCR && !d->uart_16550_compatible)
> @@ -228,6 +240,10 @@ static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
>  {
>  	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
> +	/* Allow the TX to drain before we reconfigure */
> +	if (offset == UART_LCR && d->drain_before_lcr_change)
> +		dw8250_tx_wait_empty(p);
> +
>  	iowrite32be(value, p->membase + (offset << p->regshift));
>  
>  	if (offset == UART_LCR && !d->uart_16550_compatible)
> @@ -597,6 +613,8 @@ static int dw8250_probe(struct platform_device *pdev)
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
>  
> +	data->drain_before_lcr_change = device_property_read_bool(dev, "drain-before-lcr-change");
> +
>  	/* If there is separate baudclk, get the rate from it. */
>  	data->clk = devm_clk_get_optional(dev, "baudclk");
>  	if (data->clk == NULL)
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index f13e91f2cace..f7d88fa8f058 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -45,6 +45,7 @@ struct dw8250_data {
>  
>  	unsigned int		skip_autocfg:1;
>  	unsigned int		uart_16550_compatible:1;
> +	unsigned int		drain_before_lcr_change:1;
>  };
>  
>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);

