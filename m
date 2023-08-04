Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA076FD2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjHDJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHDJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:22:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 111EC5245;
        Fri,  4 Aug 2023 02:21:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 75C0980F7;
        Fri,  4 Aug 2023 09:21:06 +0000 (UTC)
Date:   Fri, 4 Aug 2023 12:21:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] serial: core: Fix kmemleak issue for serial core device
 remove
Message-ID: <20230804092105.GI14799@atomide.com>
References: <20230804090909.51529-1-tony@atomide.com>
 <959278d8-d76e-fda8-6d0d-64e284c0ba1b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959278d8-d76e-fda8-6d0d-64e284c0ba1b@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230804 09:16]:
> On 04. 08. 23, 11:09, Tony Lindgren wrote:
> > Kmemleak reports issues for serial8250 ports after the hardware specific
> > driver takes over on boot as noted by Tomi.
> > 
> > The kerneldoc for device_initialize() says we must call device_put()
> > after calling device_initialize(). We are calling device_put() on the
> > error path, but are missing it from the device remove path. This causes
> > release() to never get called for the devices on remove.
> > 
> > Let's add the missing put_device() calls for both serial ctrl and
> > port devices.
> > 
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >   drivers/tty/serial/serial_base_bus.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> > --- a/drivers/tty/serial/serial_base_bus.c
> > +++ b/drivers/tty/serial/serial_base_bus.c
> > @@ -99,6 +99,7 @@ void serial_base_ctrl_device_remove(struct serial_ctrl_device *ctrl_dev)
> >   		return;
> >   	device_del(&ctrl_dev->dev);
> > +	put_device(&ctrl_dev->dev);
> >   }
> >   struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
> > @@ -174,6 +175,7 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
> >   		return;
> >   	device_del(&port_dev->dev);
> > +	put_device(&port_dev->dev);
> 
> I didn't check the code, but device_unregister()?

I thought about that as it does the same, but since we're not calling
device_register() I felt it would be and unpaired call. No objections to
changing to use device_unregister() naturally if folks prefer that.

Regards,

Tony
