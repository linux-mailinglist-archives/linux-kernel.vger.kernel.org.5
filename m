Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B155770DC5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHEEtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEEtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:49:14 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 822174C04;
        Fri,  4 Aug 2023 21:49:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A28F380F7;
        Sat,  5 Aug 2023 04:49:11 +0000 (UTC)
Date:   Sat, 5 Aug 2023 07:49:10 +0300
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
Message-ID: <20230805044910.GJ14799@atomide.com>
References: <20230803071034.25571-1-tony@atomide.com>
 <0e1bc27d-dc84-473d-bfdf-db0743c5d64a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1bc27d-dc84-473d-bfdf-db0743c5d64a@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [230804 21:42]:
> On Thu, Aug 03, 2023 at 10:10:32AM +0300, Tony Lindgren wrote:
> > While fixing DEVNAME to be more usable, I broke serial_base_match() as the
> > ctrl and port prefix for device names seemed unnecessary.
> > 
> > The prefixes are still needed by serial_base_match() to probe the serial
> > base controller port, and serial tx is now broken.
> > 
> > Let's fix the issue by checking against dev->type and drv->name instead
> > of the prefixes that are no longer in the DEVNAME.
> > 
> > Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> With this patch applied, I see the following traceback in the pending-fixes
> branch.
> 
> Bisect log attached as well. It actually points to commit d962de6ae51f
> ("serial: core: Fix serial core port id to not use port->line").
> Bisect was on mips, but I also see problems on arm, ppc, and sparc.
> sparc boot tests show the warning message and then stall until aborted
> (which of course may be a different problem).

Sorry about all the hassles and thanks for testing again.

I too noticed several issues remaining after testing reloading the hardware
specific serial driver, the issues I saw should be fixed in tty-linus.

> kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
> serial8250 serial8250.0: unable to register port at index 1 (IO2f8 MEM0 IRQ3): -17
> sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'

The issue above should be fixed with commit:

bbb4abb1bcfb ("serial: 8250: Reinit port_id when adding back serial8250_isa_devs")

Not sure about the sparc one you mentioned, but let's when you run your
tests again.

Regards,

Tony
