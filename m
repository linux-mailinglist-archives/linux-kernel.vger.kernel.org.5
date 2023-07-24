Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAF75EACD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGXF0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXF0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:26:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34396100;
        Sun, 23 Jul 2023 22:26:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 79D8B809F;
        Mon, 24 Jul 2023 05:26:49 +0000 (UTC)
Date:   Mon, 24 Jul 2023 08:26:48 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add sysfs links for serial core port
 instances for ttys
Message-ID: <20230724052648.GW5194@atomide.com>
References: <20230719051613.46569-1-tony@atomide.com>
 <ZLd1uCKoGMBruwiN@smile.fi.intel.com>
 <20230719054321.GJ5194@atomide.com>
 <ZLfsVU7uiA3IReHU@smile.fi.intel.com>
 <20230720041319.GM5194@atomide.com>
 <ZLpYfZDplupNQHnb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpYfZDplupNQHnb@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:06]:
> On Thu, Jul 20, 2023 at 07:13:19AM +0300, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@intel.com> [230719 13:59]:
> > > On Wed, Jul 19, 2023 at 08:43:21AM +0300, Tony Lindgren wrote:
> > > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230719 05:34]:
> > > > > On Wed, Jul 19, 2023 at 08:16:11AM +0300, Tony Lindgren wrote:
> 
> ...
> 
> > > > > > And with this, we can add /dev/serial/by-id symlinks to the serial port
> > > > > > device instances so we can start using serial core port addressing in
> > > > > > addition to the legacy ttyS naming.
> > > > > > 
> > > > > > The naming we can use is dev_name:0.0 where 0.0 are the serial core
> > > > > > controller id and port id, so for the ttyS0 example above the naming
> > > > > > would be 00:04.0:0.0.
> > > > > 
> > > > > This is interesting idea. But any hint why it can be useful?
> > > > 
> > > > If you have lots of serial ports and we are stuck with adding aliases
> > > > for the ports in the dts files where the ttyS naming and ordering does
> > > > not really help or may not necessarily make sense if the ports are on
> > > > different buses or domains. With CONFIG_SERIAL_8250_RUNTIME_UARTS=4,
> > > > the ttyS naming is only needed for the legacy ports really.
> > > 
> > > I see. Does it fix the long standing issue with ttyS enumeration (on x86
> > > at least) when depending on the presence of the legacy ports the HSUART
> > > (high speed) can preempt the legacy placeholders (ttyS0..ttyS3)?
> > >
> > > To me sounds like it may very well do fix it and I would be glad to see that
> > > in the commit message (as selling point) and in documentation.
> > 
> > It won't affect how ttyS0..ttyS3 get assigned, but it helps finding your
> > HSUART instance with DEVNAME:0.0 style addressing. So you don't need to
> > care what ttyS number the port has. If you have such a test case maybe give
> > it a try.
> 
> Exactly, the problem (currently) is, that depending on the BIOS settings
> the kernel can't use the same command line and this is quite a PITA for
> our customers!
> 
> As far as we can specify hardware (path) to the console, it will be so
> cool and hopefully solves this very long standing issue.

OK great, I'll update the patch description for next revision.

Regards,

Tony
