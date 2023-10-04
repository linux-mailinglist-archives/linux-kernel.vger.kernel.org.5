Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95DC7B77B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjJDGRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:17:14 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC5DCAF;
        Tue,  3 Oct 2023 23:17:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E9E7C80A7;
        Wed,  4 Oct 2023 06:17:09 +0000 (UTC)
Date:   Wed, 4 Oct 2023 09:17:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20231004061708.GD34982@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <62d3678a-a23d-4619-95de-145026629ba8@gmail.com>
 <20231003121455.GB34982@atomide.com>
 <20231003122137.GC34982@atomide.com>
 <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Maximilian Luz <luzmaximilian@gmail.com> [231003 22:09]:
> On 10/3/23 14:21, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [231003 12:15]:
> > > Hi,
> > > 
> > > * Maximilian Luz <luzmaximilian@gmail.com> [231003 11:57]:
> > > > A bad workaround is to disable runtime PM, e.g. via
> > > > 
> > > >    echo on > /sys/bus/serial-base/devices/dw-apb-uart.4:0/dw-apb-uart.4:0.0/power/control
> > > 
> > > If the touchscreen controller driver(s) are using serdev they are
> > > children of the dw-apb-uart.4:0.0 and can use runtime PM calls to
> > > block the parent device from idling as necessary. The hierarchy
> > > unless changed using ignore_children.
> > 
> > Sorry about all the typos, I meant "the hierarchy works unless changed"
> > above. The rest of the typos are easier to decipher probably :)
> 
> Unfortunately that doesn't quite line up with what I can see on v6.5.5. The
> serdev controller seems to be a child of dw-apb-uart.4, a platform device. The
> serial-base and serdev devices are siblings. According to sysfs:
> 
>     /sys/bus/platform/devices/dw-apb-uart.4
>     ├── driver -> ../../../../bus/platform/drivers/dw-apb-uart
>     ├── subsystem -> ../../../../bus/platform
>     │
>     ├── dw-apb-uart.4:0
>     │  ├── driver -> ../../../../../bus/serial-base/drivers/ctrl
>     │  ├── subsystem -> ../../../../../bus/serial-base
>     │  │
>     │  └── dw-apb-uart.4:0.0
>     │     ├── driver -> ../../../../../../bus/serial-base/drivers/port
>     │     └── subsystem -> ../../../../../../bus/serial-base
>     │
>     └── serial0
>        ├── subsystem -> ../../../../../bus/serial
>        │
>        └── serial0-0
>           ├── driver -> ../../../../../../bus/serial/drivers/surface_serial_hub
>           └── subsystem -> ../../../../../../bus/serial

The hierachy above is correct. Looks like I pasted the wrong device above,
I meant dw-apb-uart.4, sorry about the extra confusion added. Eventually
the serdev device could be a child of dw-apb-uart.4:0.0 at some point as
it's specific to a serial port instance, but for now that should not be
needed.

If serial0-0 is runtime PM active, then dw-apb-uart.4 is runtime PM active
also unless ingore_children is set.

> Runtime suspend on serial0-0 is disabled/not set up at all. So I assume that if
> it were a descendent of dw-apb-uart.4:0.0, things should have worked
> out-of-the-box.

Hmm yes so maybe the issue is not with surface_serial_hub, but with serial
port device being nable to resume after __device_suspend_late() has
disabled runtime PM like you've been saying.

If the issue is with the serial port not being able to runtime resume, then
the patch below should help. Care to give it a try?

Regards,

Tony

8< ------------------
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -46,8 +46,27 @@ static int serial_port_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
-				 NULL, serial_port_runtime_resume, NULL);
+/*
+ * Allow serdev devices to talk to hardware during system suspend.
+ * Assumes the serial port hardware controller device driver calls
+ * pm_runtime_force_suspend() and pm_runtime_force_resume() for
+ * system suspend as needed.
+ */
+static int serial_port_prepare(struct device *dev)
+{
+	return pm_runtime_resume_and_get(dev);
+}
+
+static void serial_port_complete(struct device *dev)
+{
+	pm_runtime_put_sync(dev);
+}
+
+static const struct dev_pm_ops __maybe_unused serial_port_pm = {
+	SET_RUNTIME_PM_OPS(NULL, serial_port_runtime_resume, NULL)
+	.prepare = serial_port_prepare,
+	.complete = serial_port_complete,
+};
 
 static int serial_port_probe(struct device *dev)
 {
-- 
2.42.0
