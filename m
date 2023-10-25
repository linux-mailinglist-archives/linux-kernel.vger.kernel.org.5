Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F97D64ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjJYIYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjJYIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:24:37 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 523FF9C;
        Wed, 25 Oct 2023 01:24:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 686C480B0;
        Wed, 25 Oct 2023 08:24:34 +0000 (UTC)
Date:   Wed, 25 Oct 2023 11:24:33 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <20231025082433.GQ34982@atomide.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <2023102401-playtime-moonrise-6f05@gregkh>
 <20231024122955.GL34982@atomide.com>
 <2023102442-statue-kept-febc@gregkh>
 <20231025065152.GO34982@atomide.com>
 <ZTjEtWcF4a95BWBK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTjEtWcF4a95BWBK@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [231025 07:32]:
> Your diff is missing the actual tty devices. 'tty' is just the class
> directory. 

Ah right, that explains :) The find must be for ttyS* in this case,
here's the diff for qemu x86 for command:

# find /sys -name ttyS*

--- /tmp/before 2023-10-25 10:50:29.870083012 +0300
+++ /tmp/after  2023-10-25 10:52:52.770393075 +0300
@@ -3,7 +3,7 @@
 /sys/class/tty/ttyS0
 /sys/class/tty/ttyS3
 /sys/class/tty/ttyS1
-/sys/devices/pnp0/00:04/tty/ttyS0
-/sys/devices/platform/serial8250/tty/ttyS2
-/sys/devices/platform/serial8250/tty/ttyS3
-/sys/devices/platform/serial8250/tty/ttyS1
+/sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty/ttyS0
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty/ttyS3
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty/ttyS1
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty/ttyS2

> And can you post the equivalent diff for serdev as well for completeness?

I don't have an x86 or arm64 testcase for serdev, but here's a armv7 wlcore
hci-uart serdev diff for command:

# find /sys -name ttyS* -o -name serial0

--- /tmp/before 2023-10-25 08:23:15.468382112 +0000
+++ /tmp/after  2023-10-25 08:23:15.468382112 +0000
@@ -1,10 +1,9 @@
-# find /sys -name ttyS* -o -name serial0
-/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/4806e050.target-module/4806e000.serial/serial0
-/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/48020050.target-module/48020000.serial/tty/ttyS2
-/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/4806a050.target-module/4806a000.serial/tty/ttyS0
-/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/4806c050.target-module/4806c000.serial/tty/ttyS1
-/sys/devices/platform/serial8250/tty/ttyS4
-/sys/devices/platform/serial8250/tty/ttyS5
+/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/4806e050.target-module/4806e000.serial/4806e000.serial:0/4806e000.serial:0.0/serial0
+/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/48020050.target-module/48020000.serial/48020000.serial:0/48020000.serial:0.0/tty/ttyS2
+/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/4806a050.target-module/4806a000.serial/4806a000.serial:0/4806a000.serial:0.0/tty/ttyS0
+/sys/devices/platform/ocp/48000000.interconnect/48000000.interconnect:segment@0/4806c050.target-module/4806c000.serial/4806c000.serial:0/4806c000.serial:0.0/tty/ttyS1
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.5/tty/ttyS5
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.4/tty/ttyS4
 /sys/class/tty/ttyS4
 /sys/class/tty/ttyS2
 /sys/class/tty/ttyS0

> > There are multiple ports claimed by serial8250. So I think the new sysfs
> > output is correct showing more ttys. If there's some reason why serial8250
> > should only have one tty and this output is not correct let me know too..
> 
> There should not be more class devices, you've just moved them and thus
> there are more class directories (with one device per directory).

OK makes sense.

Thanks,

Tony
