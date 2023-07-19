Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA1758D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGSF2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:28:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A541BF2;
        Tue, 18 Jul 2023 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689744524; x=1721280524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hQg3EFz6MDv5rNRrtClQQip7QilFfkNcCy3V0EZ+QZc=;
  b=XLfQJdfRft6ayHhbo5VU3oqh3OzpEAU3ZXXMu5hxhRCHAFzxDpmtOc37
   scPivGIpuH5VWkgiwTpwfayPxQlU2IqKMc72sfHOG8aO+zqdnwrzfJNfZ
   5gPJBabipHUdGv86KvEscftp3pBPPW4lWCVsfOOQBma8eMvv/0dm3dUJf
   BLfRGygX2MBx4hMBgEAGkvWxzRgT2OK7p/nkb8HIdK/5mTxPaMchlp5es
   hbc07yiuYgeg2TupK3VcMsjBCbxvHbln+TBeYatWlTPoWWU+HUVLJCJZA
   y4DbLCKe4oMrjjLvz4jyercz3hjTRdAji60sWNUrl0izLcCCVo6hftZzu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452751822"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="452751822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="717865700"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="717865700"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2023 22:28:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLzjk-00D7sU-1O;
        Wed, 19 Jul 2023 08:28:32 +0300
Date:   Wed, 19 Jul 2023 08:28:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix serial core port id to not use
 port->line
Message-ID: <ZLd0gI7DC1WAXRvO@smile.fi.intel.com>
References: <20230719051235.46396-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719051235.46396-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:12:33AM +0300, Tony Lindgren wrote:
> The serial core port id should be serial core controller specific port
> instance, which is not always the port->line index.
> 
> For example, 8250 driver maps a number of legacy ports, and when a
> hardware specific device driver takes over, we typically have one
> driver instance for each port. Let's instead add port->port_id to
> keep track serial ports mapped to each serial core controller instance.
> 
> Currently this is only a cosmetic issue for the serial core port device
> names. The issue can be noticed looking at /sys/bus/serial-base/devices
> for example though. Let's fix the issue to avoid port addressing issues
> later on.

Good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_core.c  | 2 ++
>  drivers/tty/serial/serial_base_bus.c | 2 +-
>  include/linux/serial_core.h          | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -497,6 +497,7 @@ static struct uart_8250_port *serial8250_setup_port(int index)
>  
>  	up = &serial8250_ports[index];
>  	up->port.line = index;
> +	up->port.port_id = index;
>  
>  	serial8250_init_port(up);
>  	if (!base_ops)
> @@ -1040,6 +1041,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  			uart_remove_one_port(&serial8250_reg, &uart->port);
>  
>  		uart->port.ctrl_id	= up->port.ctrl_id;
> +		uart->port.port_id	= up->port.port_id;
>  		uart->port.iobase       = up->port.iobase;
>  		uart->port.membase      = up->port.membase;
>  		uart->port.irq          = up->port.irq;
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -136,7 +136,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
>  	err = serial_base_device_init(port, &port_dev->dev,
>  				      &ctrl_dev->dev, &serial_port_type,
>  				      serial_base_port_release,
> -				      port->line);
> +				      port->port_id);
>  	if (err)
>  		goto err_put_device;
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -460,6 +460,7 @@ struct uart_port {
>  	int			(*iso7816_config)(struct uart_port *,
>  						  struct serial_iso7816 *iso7816);
>  	int			ctrl_id;		/* optional serial core controller id */
> +	int			port_id;		/* optional serial core port id */
>  	unsigned int		irq;			/* irq number */
>  	unsigned long		irqflags;		/* irq flags  */
>  	unsigned int		uartclk;		/* base uart clock */
> -- 
> 2.41.0

-- 
With Best Regards,
Andy Shevchenko


