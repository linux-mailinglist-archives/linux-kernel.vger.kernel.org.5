Return-Path: <linux-kernel+bounces-141978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6578A25B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ACE285D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E61B950;
	Fri, 12 Apr 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N5w9h6zK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21878C13;
	Fri, 12 Apr 2024 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899612; cv=none; b=qW23aO07sFNU7pK1+PQHYMjG+GEx3uiBUDCWh/i3unZEfX6mb91gGpRwzc/BPkA/EAdoSYw8eWfApF2wrDI9ymTg8G3atdisXT2xmJ5jNaOn5AHY2GgE2mgeXUFV7+vMnMtbwew0Un1DMdMxnUlLx9Y3w8BWZ2TLTh7tmvh5qcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899612; c=relaxed/simple;
	bh=x71PJqK49LwuCjl9CvP6DX6KHdBlBM5DQb98t1OTDOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N35w3AaZ/wSsRJMbX79gMMZdQMkDmKyA/gIt2jVWqPaF2uaIFdgI5Oa4xkAOxQPXOqDS77aXWlDdIE1b6cf2PE2NTD+wGN6cwnPk/uQKuSzzrdtAfJcaxOw2zhgjO1cw7Se9wF4Qo/AK3dEll/VQT6X9k641U3NC0uXqliTRyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N5w9h6zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE8CC2BBFC;
	Fri, 12 Apr 2024 05:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899612;
	bh=x71PJqK49LwuCjl9CvP6DX6KHdBlBM5DQb98t1OTDOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5w9h6zKeKatlQlfgqtYDpbeOdqzpSRYTHo92ZZgaJu8IvfvnOMl5blm/j1XoKmTQ
	 OMDTEuWf6po62x+FWyvJCKW7cHWCOw+0jl9Fw+20tG071H0Zc626EvYe+h73XrfFl8
	 UleWX2/QZLS/trJVLEVnXao9jOT2/a2MROG3YMlY=
Date: Fri, 12 Apr 2024 07:26:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: parker@finest.io
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 2/7] serial: exar: add support for reading from Exar
 EEPROM
Message-ID: <2024041247-clamor-bottom-ae36@gregkh>
References: <cover.1712863999.git.pnewman@connecttech.com>
 <d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>

On Thu, Apr 11, 2024 at 04:25:40PM -0400, parker@finest.io wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> - Adds support for reading a word from the Exar EEPROM.
> - Adds exar_write_reg/exar_read_reg for reading and writing to the UART's
> config registers.

First off, thanks for splitting this up, looks much better.

Some minor nits here:

> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 110 ++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 4d1e07343d0b..49d690344e65 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -128,6 +128,16 @@
>  #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
>  #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity */
> 
> +/* EEPROM registers */
> +#define UART_EXAR_REGB                  0x8e
> +#define UART_EXAR_REGB_EECK             BIT(4)
> +#define UART_EXAR_REGB_EECS             BIT(5)
> +#define UART_EXAR_REGB_EEDI             BIT(6)
> +#define UART_EXAR_REGB_EEDO             BIT(7)
> +#define UART_EXAR_REGB_EE_ADDR_SIZE     6
> +#define UART_EXAR_REGB_EE_DATA_SIZE     16

Use tabs after the define name and before the value?

> +
> +
>  /*
>   * IOT2040 MPIO wiring semantics:
>   *
> @@ -195,6 +205,106 @@ struct exar8250 {
>  	int			line[];
>  };
> 
> +static inline void exar_write_reg(struct exar8250 *priv,
> +				unsigned int reg, uint8_t value)
> +{
> +	if (!priv || !priv->virt)
> +		return;
> +
> +	writeb(value, priv->virt + reg);
> +}
> +
> +static inline uint8_t exar_read_reg(struct exar8250 *priv, unsigned int reg)
> +{
> +	if (!priv || !priv->virt)
> +		return 0;

How can either of these ever happen?  You control when this is called,
right?  So just make sure that isn't an issue.

> +
> +	return readb(priv->virt + reg);
> +}
> +
> +static inline void exar_ee_select(struct exar8250 *priv, bool enable)
> +{
> +	uint8_t value = 0x00;

This is the kernel, please use kernel types, not userspace types (i.e.
u8 not uint8_t).  Yes, there are lots of places in the kernel that have
userspace types, but let's not add to the mess please.

> +
> +	if (enable)
> +		value |= UART_EXAR_REGB_EECS;
> +
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);

Why wait this amount of time?  A comment would be nice.  Why not just
do a read to ensure the write happened instead?

> +}
> +
> +static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
> +{
> +	uint8_t value = UART_EXAR_REGB_EECS;

Same comment about the type, here and everywhere else.

> +
> +	if (bit)
> +		value |= UART_EXAR_REGB_EEDI;
> +
> +	//Clock out the bit on the i2c interface

Comments using // are fine, but please put a space after the "//" to
make them readable

> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);

Same commment about the time value, here and everywhere else.  Why slow
things down if you don't have to?

thanks,

greg k-h

