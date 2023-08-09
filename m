Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B177522E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHIF05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHIF0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:26:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41C621BCE;
        Tue,  8 Aug 2023 22:26:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 51B6A80AF;
        Wed,  9 Aug 2023 05:26:52 +0000 (UTC)
Date:   Wed, 9 Aug 2023 08:26:50 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] serial: core: Revert port_id use
Message-ID: <20230809052650.GT14799@atomide.com>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Guenter Roeck <linux@roeck-us.net> [230806 13:19]:
> On Sun, Aug 06, 2023 at 09:20:50AM +0300, Tony Lindgren wrote:
> > Guenter reports boot issues with duplicate sysfs entries for multiport
> > drivers. Let's go back to using port->line for now to fix the regression.
> > 
> > With this change, the serial core port device names are not correct for the
> > hardware specific 8250 single port drivers, but that's a cosmetic issue for
> > now.
> > 
> > Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
> > Reported-by: Guenter Roeck <groeck7@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for testing.

Guenter, care to also test the patch below on top of this fix and
see if things still behave for you?

I'll send a proper patch assuming things test fine.

Regagrds,

Tony

8< --------------------
diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -16,6 +16,7 @@ struct device;
 
 struct serial_ctrl_device {
 	struct device dev;
+	struct ida ida;
 };
 
 struct serial_port_device {
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -10,6 +10,7 @@
 
 #include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
@@ -112,6 +113,8 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	if (!ctrl_dev)
 		return ERR_PTR(-ENOMEM);
 
+	ida_init(&ctrl_dev->ida);
+
 	err = serial_base_device_init(port, &ctrl_dev->dev,
 				      parent, &serial_ctrl_type,
 				      serial_base_ctrl_release,
@@ -142,16 +145,31 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 						struct serial_ctrl_device *ctrl_dev)
 {
 	struct serial_port_device *port_dev;
+	unsigned int min = 0, max = ~0U;
 	int err;
 
 	port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
 	if (!port_dev)
 		return ERR_PTR(-ENOMEM);
 
+	/* Device driver specified port_id vs automatic assignment? */
+	if (port->port_id) {
+		min = port->port_id;
+		max = port->port_id;
+	}
+
+	err = ida_alloc_range(&ctrl_dev->ida, min, max, GFP_KERNEL);
+	if (err < 0) {
+		kfree(port_dev);
+		return ERR_PTR(err);
+	}
+
+	port->port_id = err;
+
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->ctrl_id, port->line);
+				      port->ctrl_id, port->port_id);
 	if (err)
 		goto err_put_device;
 
@@ -165,16 +183,24 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 
 err_put_device:
 	put_device(&port_dev->dev);
+	ida_free(&ctrl_dev->ida, port->port_id);
 
 	return ERR_PTR(err);
 }
 
 void serial_base_port_device_remove(struct serial_port_device *port_dev)
 {
+	struct serial_ctrl_device *ctrl_dev;
+	struct device *parent;
+
 	if (!port_dev)
 		return;
 
+	parent = port_dev->dev.parent;
+	ctrl_dev = to_serial_base_ctrl_device(parent);
+
 	device_del(&port_dev->dev);
+	ida_free(&ctrl_dev->ida, port_dev->port->port_id);
 	put_device(&port_dev->dev);
 }
 
-- 
2.41.0
