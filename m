Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AE7D61D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjJYGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:51:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCC8310A;
        Tue, 24 Oct 2023 23:51:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 200DE80B0;
        Wed, 25 Oct 2023 06:51:54 +0000 (UTC)
Date:   Wed, 25 Oct 2023 09:51:52 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <20231025065152.GO34982@atomide.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <2023102401-playtime-moonrise-6f05@gregkh>
 <20231024122955.GL34982@atomide.com>
 <2023102442-statue-kept-febc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102442-statue-kept-febc@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231024 14:01]:
> On Tue, Oct 24, 2023 at 03:29:55PM +0300, Tony Lindgren wrote:
> > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231024 11:52]:
> > > What does this change the sysfs tree to look like?
> > 
> > On x86 qemu for the ttys:
> > 
> > # find /sys -name tty
> > /sys/class/tty
> > /sys/class/tty/tty
> > /sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty
> > /sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty
> > /sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty
> > /sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty
> > /sys/devices/virtual/tty
> > /sys/devices/virtual/tty/tty
> 
> A diff of before vs. after would make more sense for those of us who
> don't have your same system configuration :)

Here's the diff of the same command before and after:

--- /tmp/before 2023-10-25 09:45:12.197283690 +0300
+++ /tmp/after  2023-10-25 09:43:30.681797899 +0300
@@ -1,7 +1,9 @@
 # find /sys -name tty
 /sys/class/tty
 /sys/class/tty/tty
-/sys/devices/pnp0/00:04/tty
-/sys/devices/platform/serial8250/tty
+/sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty
+/sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty
 /sys/devices/virtual/tty
 /sys/devices/virtual/tty/tty

There are multiple ports claimed by serial8250. So I think the new sysfs
output is correct showing more ttys. If there's some reason why serial8250
should only have one tty and this output is not correct let me know too..

Regards,

Tony
