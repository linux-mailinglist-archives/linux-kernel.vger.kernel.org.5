Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3B79FB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjINGHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:07:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B663DF;
        Wed, 13 Sep 2023 23:07:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F063B8088;
        Thu, 14 Sep 2023 06:07:27 +0000 (UTC)
Date:   Thu, 14 Sep 2023 09:07:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20230914060726.GN5285@atomide.com>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-3-tony@atomide.com>
 <4c9c637a-9117-4f43-a64f-892fa33958c1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9c637a-9117-4f43-a64f-892fa33958c1@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230914 05:43]:
> On 12. 09. 23, 13:03, Tony Lindgren wrote:
> > +/*
> > + * The "console=" option is handled by console_setup() in printk. We can't use
> > + * early_param() as do_early_param() checks for "console" and "earlycon" options
> > + * so console_setup() potentially handles console also early. Use parse_args().
> 
> So why not concentrate console= handling on one place, ie. in
> console_setup()? The below (second time console= handling) occurs quite
> illogical to me.

Well console_setup() knows nothing about the probing serial port controller
device, tries to call __add_preferred_console() based on a few hardcoded
device names and some attempted guessing, and is stuffed into printk.c :)

I don't think we should pile on more stuff into printk.c for this.

If we wanted to do something, let's set up the console list somewhere else,
and then just have console_setup() add every console option to that list
and leave the rest of console_setup in place to avoid breaking things all
over the place.

Then we can export some find_named_console() type function for serial core
to use. Or do you have some better ideas in mind?

Regards,

Tony
