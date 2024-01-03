Return-Path: <linux-kernel+bounces-15436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E1822BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF07BB228C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E018E21;
	Wed,  3 Jan 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUJmz+cW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7BA18E0C;
	Wed,  3 Jan 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704280791; x=1735816791;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BN4G4B17WwmtxZfwQRC+8qZ6+KYHHxYIaVabnY6Z5v8=;
  b=iUJmz+cWf8c7u5PdHvduyBhBFPFAAm+/XQRH+fYHjodr8SQczYKYG+yI
   zrk90iGdwroZlrYMSNdr3//gwjy6RuS2utsvsK6DmHOI7OkUYEoGDGOfa
   rfUl5ZsSS2G0zSRePRGRiT6ZaFNLHIUEHLONaIiG2Mo5hz0GjeN3lL/QS
   Dy4VKsTroa5y4CHXpOTfjUaa8NaNowBr+2QfemDVA6APjdeszpzZYE+lT
   neRt/ILFJLFPO5fGnpdLadtPNG+9nGr2Oieq6ILcocbcP83idzvpsoSfH
   MelfZX2fteDou96ojWhzAFg4OJjjCrS0bEq1mr9EgNH8z0dx8qJmDQQyE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4342999"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4342999"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:19:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="779965501"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="779965501"
Received: from bergbenj-mobl1.ger.corp.intel.com ([10.251.211.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:19:45 -0800
Date: Wed, 3 Jan 2024 13:19:43 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com, 
    alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com, 
    hugo@hugovil.com, m.brock@vanmierlo.com, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, LinoSanfilippo@gmx.de, 
    Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v7 5/7] serial: core, imx: do not set RS485 enabled if
 it is not supported
In-Reply-To: <20240103061818.564-6-l.sanfilippo@kunbus.com>
Message-ID: <75c0cbd4-7cec-a415-bfba-376f035f76@linux.intel.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com> <20240103061818.564-6-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-84096764-1704280789=:1706"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-84096764-1704280789=:1706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jan 2024, Lino Sanfilippo wrote:

> If the imx driver cannot support RS485 it nullifies the ports
> rs485_supported structure. But it still calls uart_get_rs485_mode() which
> may set the RS485_ENABLED flag nevertheless.
> 
> This may lead to an attempt to configure RS485 even if it is not supported
> when the flag is evaluated in uart_configure_port() at port startup.
> 
> Avoid this by bailing out of uart_get_rs485_mode() if the RS485_ENABLED
> flag is not supported by the caller.
> 
> With this fix a check for RTS availability is now obsolete in the imx
> driver, since it can not evaluate to true any more. So remove this check.
> 
> Furthermore the explicit nullifcation of rs485_supported is not needed,
> since the memory has already been set to zeros at allocation. So remove
> this, too.
> 
> Fixes: 00d7a00e2a6f ("serial: imx: Fill in rs485_supported")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/imx.c         | 7 -------
>  drivers/tty/serial/serial_core.c | 3 +++
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 9cffeb23112b..198ce7e7bc8b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2206,7 +2206,6 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
>  	return HRTIMER_NORESTART;
>  }
>  
> -static const struct serial_rs485 imx_no_rs485 = {};	/* No RS485 if no RTS */
>  static const struct serial_rs485 imx_rs485_supported = {
>  	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
>  		 SER_RS485_RX_DURING_TX,
> @@ -2290,8 +2289,6 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	/* RTS is required to control the RS485 transmitter */
>  	if (sport->have_rtscts || sport->have_rtsgpio)
>  		sport->port.rs485_supported = imx_rs485_supported;
> -	else
> -		sport->port.rs485_supported = imx_no_rs485;
>  	sport->port.flags = UPF_BOOT_AUTOCONF;
>  	timer_setup(&sport->timer, imx_uart_timeout, 0);
>  
> @@ -2328,10 +2325,6 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
> -	    (!sport->have_rtscts && !sport->have_rtsgpio))
> -		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
> -
>  	/*
>  	 * If using the i.MX UART RTS/CTS control then the RTS (CTS_B)
>  	 * signal cannot be set low during transmission in case the
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 28bcbc686c67..93e4e1693601 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3600,6 +3600,9 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	u32 rs485_delay[2];
>  	int ret;
>  
> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
> +		return 0;
> +

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-84096764-1704280789=:1706--

