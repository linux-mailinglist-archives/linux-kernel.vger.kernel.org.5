Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C53762941
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGZD2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZD2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:28:40 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E58C213C;
        Tue, 25 Jul 2023 20:28:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7AFBA80A9;
        Wed, 26 Jul 2023 03:28:38 +0000 (UTC)
Date:   Wed, 26 Jul 2023 06:28:37 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <20230726032837.GZ5194@atomide.com>
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
 <ZL+QuHE4CztPvBxo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL+QuHE4CztPvBxo@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230725 09:07]:
> On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
> > We are missing the serial core controller id for the serial core port
> > name. Let's fix the issue for sane sysfs output, and to avoid issues
> > addressing serial ports later on.
> > 
> > And as we're now showing the controller id, the "ctrl" and "port" prefix
> > for the DEVNAME become useless, we can just drop them. Let's standardize on
> > DEVNAME:0 for controller name, where 0 is the controller id. And
> > DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
> > 
> > This makes the sysfs output nicer, on qemu for example:
> > 
> > $ ls /sys/bus/serial-base/devices
> > 00:04:0         serial8250:0    serial8250:0.2
> > 00:04:0.0       serial8250:0.1  serial8250:0.3
> 
> Hmm... Why 0.0 is absent for serial8250?

The serial8250:0.0 port was around initially, and then it's preallocated
slot got taken over by the 00:04:0.0 device. See nr_uarts in 8250_core.c
for what is going on.

> Btw, what was before this patch there?

# ls /sys/bus/serial-base/devices/
ctrl.00:04.0       port.00:04.0       port.serial8250.2
ctrl.serial8250.0  port.serial8250.1  port.serial8250.3

The earlier naming is different format from the DEVNAME:0.0. The sysfs
output is not usable directly for the users for the port addressing we're
discussing.

Sorry I did not notice the different format earier, I noticed only when I
started playing with using the DEVNAME:0.0 style port addressing.

> And maybe ls -l will look more informative?

I've appended qemu output of the ls -l for DEVNAME:0.0 style naming below.

> > Andy, I kept your Reviewed-by although I updated the device naming and
> > description, does the patch still look OK to you?
> 
> Looks okay, but I have a question above.

OK best to get the device names right if we're planning to use them :)

Regards,

Tony


8< ------
 ls -l /sys/bus/serial-base/devices/
total 0
lrwxrwxrwx    1 root     root             0 Jul 25 05:21 00:04:0 -> ../../../devices/pnp0/00:04/00:04:0
lrwxrwxrwx    1 root     root             0 Jul 25 05:21 00:04:0.0 -> ../../../devices/pnp0/00:04/00:04:0/00:04:0.0
lrwxrwxrwx    1 root     root             0 Jul 25 05:21 serial8250:0 -> ../../../devices/platform/serial8250/serial8250:0
lrwxrwxrwx    1 root     root             0 Jul 25 05:21 serial8250:0.1 -> ../../../devices/platform/serial8250/serial8250:0/serial8250:0.1
lrwxrwxrwx    1 root     root             0 Jul 25 05:21 serial8250:0.2 -> ../../../devices/platform/serial8250/serial8250:0/serial8250:0.2
lrwxrwxrwx    1 root     root             0 Jul 25 05:21 serial8250:0.3 -> ../../../devices/platform/serial8250/serial8250:0/serial8250:0.3
