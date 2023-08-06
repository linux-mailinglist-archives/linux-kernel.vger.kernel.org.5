Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7F77139D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 06:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjHFEeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 00:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFEeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 00:34:02 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4914A1FDE;
        Sat,  5 Aug 2023 21:34:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4157480A0;
        Sun,  6 Aug 2023 04:33:59 +0000 (UTC)
Date:   Sun, 6 Aug 2023 07:33:57 +0300
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
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after
 fixing controller port name
Message-ID: <20230806043357.GL14799@atomide.com>
References: <20230803071034.25571-1-tony@atomide.com>
 <0e1bc27d-dc84-473d-bfdf-db0743c5d64a@roeck-us.net>
 <20230805044910.GJ14799@atomide.com>
 <a6973497-f45f-6456-ac2b-d3c0262d892b@roeck-us.net>
 <20230805114846.GK14799@atomide.com>
 <aeca6f69-49df-898c-e70b-afcc5427a29b@roeck-us.net>
 <095e0120-ba81-64e7-e5d0-c042fb64978f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <095e0120-ba81-64e7-e5d0-c042fb64978f@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [230805 16:12]:
> On 8/5/23 08:50, Guenter Roeck wrote:
> > On 8/5/23 04:48, Tony Lindgren wrote:
> > > * Guenter Roeck <linux@roeck-us.net> [230805 10:50]:
> > > > On 8/4/23 21:49, Tony Lindgren wrote:
> > > > > * Guenter Roeck <linux@roeck-us.net> [230804 21:42]:
> > > > > > kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
> > > > > > serial8250 serial8250.0: unable to register port at index 1 (IO2f8 MEM0 IRQ3): -17
> > > > > > sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
> > > > > 
> > > > > The issue above should be fixed with commit:
> > > > > 
> > > > > bbb4abb1bcfb ("serial: 8250: Reinit port_id when adding back serial8250_isa_devs")
> > > > > 
> > > > 
> > > > No. I tested the tip of tty-linus (v6.5-rc4-9-gdfe2aeb226fd) which includes
> > > > above commit, but still see the problem. sparc images also still stall after
> > > > the "cannot create duplicate filename" message.
> > > > I bisected the sparc problem - it also bisects to commit d962de6ae51f.
> > > > 
> > > > The problem affects all mips boot tests, all sparc boot tests, as well as
> > > > arm sx1, ppc bamboo and sam460ex emulations. As far as I can see, those
> > > > call serial8250_register_8250_port() without calling  serial8250_setup_port()
> > > > and thus don't set port_id. I am only testing a few of those, so I strongly
> > > > suspect that all similar callers of serial8250_register_8250_port() are
> > > > affected (i.e., almost all of them) if they register more than one serial port.
> > > 
> > > OK thanks for explaining. So we need to initialize port->port_id for the
> > > multi-port instances to avoid being stuck with the port->line index. I'll
> > > take a look.
> > > 
> > > I wonder if we should just revert d962de6ae51f for now. It needs to be
> > > tested to see if something else also needs reverting though.
> > > 
> > 
> > It is actually more complicated like that. Adding some debug into, I get the following
> > from a mips boot. Turns out that serial8250_setup_port() is actually called.
> > 
> > ...
> > ####### serial8250_setup_port: index 0
> > ####### serial8250_setup_port: index 0 returning 819a5ab8
> > ####### serial8250_setup_port: index 1
> > ####### serial8250_setup_port: index 1 returning 819a5d20
> > ####### serial8250_setup_port: index 2
> > ####### serial8250_setup_port: index 2 returning 819a5f88
> > ####### serial8250_setup_port: index 3
> > ####### serial8250_setup_port: index 3 returning 819a61f0
> > ...
> > #### serial8250_register_8250_port: uart=819a5ab8
> > #### serial8250_register_8250_port: uart=819a5ab8 port_id=0 line=0
> > ...
> > #### serial8250_register_8250_port: uart=819a5d20
> > #### serial8250_register_8250_port: uart=819a5d20 port_id=1 line=1
> > sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
> > 
> > So line and port_id are both set, but the created sysfs attribute
> > is still duplicate. I'll do some more debugging.
> > 
> 
> Ok, it is actually quite simple. In serial8250_register_8250_port(),
> uart->port.port_id has the correct and expected value. However, that is
> overwritten with
> 	uart->port.port_id      = up->port.port_id;
> where 'up' is the port pointer passed by the caller of serial8250_register_8250_port().
> And 'port_id' is always 0 in _that_ port pointer (while 'line' is set correctly).

To me it seems we can't use port->port_id until multiport drivers
initialize it, or set port->port_id automatically with ida_alloc().

Meanwhile, we can just change back to using port->line assuming that
fixes the issue for your tests. This means the port names are broken
like we had in -rc1 but that's a cosmetic issue for now.

Below is what I have in mind for a partial revert of commit d962de6ae51f.

Regards,

Tony

8< ------------------
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -151,7 +151,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->ctrl_id, port->port_id);
+				      port->ctrl_id, port->line);
 	if (err)
 		goto err_put_device;
 
-- 
2.41.0
