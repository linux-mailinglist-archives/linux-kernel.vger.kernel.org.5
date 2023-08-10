Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11A77731B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjHJIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHJIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:39:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B55DC;
        Thu, 10 Aug 2023 01:39:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A8aZxA116335;
        Thu, 10 Aug 2023 03:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691656595;
        bh=TK+7eZtAxQ6ybowS5kLhfjD7TB/ir+8Wnhi5be/ubNE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DcBHrFn7DCDbqpqYrSKzTvhrG1Q7FxcHW9tZJiQZITJC3ycPXRvz1fTik9j6G1BdW
         tMu++J9R+farI/CttE7v8a6bxKnBVUVnxlCYPanoGeu6jJP8GSmh5NCqcU5/sgIeiN
         cTpU4ZAz85155g5AVEwyz0AB+B4zbQSPjC4r1O68=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A8aZ73088447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 03:36:35 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 03:36:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 03:36:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A8aYjQ045402;
        Thu, 10 Aug 2023 03:36:34 -0500
Date:   Thu, 10 Aug 2023 14:06:33 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <20230810083633.tu2na6fcbg2kv53s@dhruva>
References: <20230810065737.47294-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810065737.47294-1-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2023 at 09:57:34 +0300, Tony Lindgren wrote:
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
> 
> Fixes: 7d695d83767c ("serial: core: Fix serial_base_match() after fixing controller port name")
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Please can you provide the base commit? I am unable to cleanly apply
this patch on commit: 21ef7b1e17d0 (tag: next-20230809, linux-next/master) Add linux-next specific files for 20230809

>  drivers/tty/serial/serial_base.h     |  1 +
>  drivers/tty/serial/serial_base_bus.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
[...]
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
> +	unsigned int min = 0, max = ~0U;
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
> -- 
> 2.41.0
> 

This is the issue I faced:

➜ patch -p1 < patches/20230810_tony_serial_core_fix_serial_core_port_id_including_multiport_devices.mbx

patching file drivers/tty/serial/serial_base.h
patching file drivers/tty/serial/serial_base_bus.c
Hunk #3 FAILED at 145.
1 out of 4 hunks FAILED -- saving rejects to file
drivers/tty/serial/serial_base_bus.c.rej

Perhaps this patch needs a rebase?

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
