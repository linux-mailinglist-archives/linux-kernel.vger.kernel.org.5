Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0B7790D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjHKNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHKNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:34:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB0ED;
        Fri, 11 Aug 2023 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691760869; x=1723296869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uVCLkN8WdGHGzXLonW5NPFK2ABMF5cEFU1d/gEuTIdg=;
  b=Iq3RZ1S5gmd0uHMxPMbwZQdrYcslfibXcjig5jQ0CLxKXvK/GPeefdaT
   F1WdYpohVc84BxiDQLISs8XmkhoZb/SB1sPTGazVeWlvN06a7wrIBOdwm
   E/qmbEWVOEwUs36Doj+cTyTU+6RUNy0DppDGbutUjFdR+Eaoz9kB+fW0x
   Ct80awVzYF96GNRAqAx4D3IokqPVXFziwgJxplHPvds9qIsHPlqtW7mMb
   N/nrTZqgnR344M+Rl4R/IQum71HPFAcXcypUJL9m8FyUluTYr7k/aioSA
   5+JMflYpxBAKdhgdsFmhH+0kyeoBSnzFWD0V/j+/Chj5rVw8+V90FmNk7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369148273"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369148273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906445162"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="906445162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 06:34:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUSHY-00GxAT-0F;
        Fri, 11 Aug 2023 16:34:24 +0300
Date:   Fri, 11 Aug 2023 16:34:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <ZNY431TgMElF35UC@smile.fi.intel.com>
References: <20230811103648.2826-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811103648.2826-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:36:45PM +0300, Tony Lindgren wrote:
> We want to fix the serial core port DEVNAME to use a port id of the
> hardware specific controller port instance instead of the port->line.
> 
> For example, the 8250 driver sets up a number of serial8250 ports
> initially that can be inherited by the hardware specific driver. At that
> the port->line no longer decribes the port's relation to the serial core
> controller instance.
> 
> Let's fix the issue by assigning port->port_id for each serial core
> controller port instance.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 7d695d83767c ("serial: core: Fix serial_base_match() after fixing controller port name")
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> - Generated with --base as suggested by Andy, this is against tty-linus
> 
> - Initialized ida_alloc_range() values as suggested by Andy
> 
> - Added Reviewed-by from Dhruva
> 
> - Kept Guenter's Tested-by
> 
> ---
>  drivers/tty/serial/serial_base.h     |  1 +
>  drivers/tty/serial/serial_base_bus.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -16,6 +16,7 @@ struct device;
>  
>  struct serial_ctrl_device {
>  	struct device dev;
> +	struct ida port_ida;
>  };
>  
>  struct serial_port_device {
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/container_of.h>
>  #include <linux/device.h>
> +#include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/serial_core.h>
>  #include <linux/slab.h>
> @@ -112,6 +113,8 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
>  	if (!ctrl_dev)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ida_init(&ctrl_dev->port_ida);
> +
>  	err = serial_base_device_init(port, &ctrl_dev->dev,
>  				      parent, &serial_ctrl_type,
>  				      serial_base_ctrl_release,
> @@ -142,16 +145,31 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
>  						struct serial_ctrl_device *ctrl_dev)
>  {
>  	struct serial_port_device *port_dev;
> +	int min = 0, max = -1;	/* Use -1 for max to apply IDA defaults */
>  	int err;
>  
>  	port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
>  	if (!port_dev)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* Device driver specified port_id vs automatic assignment? */
> +	if (port->port_id) {
> +		min = port->port_id;
> +		max = port->port_id;
> +	}
> +
> +	err = ida_alloc_range(&ctrl_dev->port_ida, min, max, GFP_KERNEL);
> +	if (err < 0) {
> +		kfree(port_dev);
> +		return ERR_PTR(err);
> +	}
> +
> +	port->port_id = err;
> +
>  	err = serial_base_device_init(port, &port_dev->dev,
>  				      &ctrl_dev->dev, &serial_port_type,
>  				      serial_base_port_release,
> -				      port->ctrl_id, port->line);
> +				      port->ctrl_id, port->port_id);
>  	if (err)
>  		goto err_put_device;
>  
> @@ -165,16 +183,24 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
>  
>  err_put_device:
>  	put_device(&port_dev->dev);
> +	ida_free(&ctrl_dev->port_ida, port->port_id);
>  
>  	return ERR_PTR(err);
>  }
>  
>  void serial_base_port_device_remove(struct serial_port_device *port_dev)
>  {
> +	struct serial_ctrl_device *ctrl_dev;
> +	struct device *parent;
> +
>  	if (!port_dev)
>  		return;
>  
> +	parent = port_dev->dev.parent;
> +	ctrl_dev = to_serial_base_ctrl_device(parent);
> +
>  	device_del(&port_dev->dev);
> +	ida_free(&ctrl_dev->port_ida, port_dev->port->port_id);
>  	put_device(&port_dev->dev);
>  }
>  
> 
> base-commit: a4a79e03bab57729bd8046d22bf3666912e586fb
> -- 
> 2.41.0

-- 
With Best Regards,
Andy Shevchenko


