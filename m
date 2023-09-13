Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303A79E7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjIMMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjIMMPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:15:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DA5719A8;
        Wed, 13 Sep 2023 05:15:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D44208088;
        Wed, 13 Sep 2023 12:15:33 +0000 (UTC)
Date:   Wed, 13 Sep 2023 15:15:32 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20230913121532.GJ5285@atomide.com>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-3-tony@atomide.com>
 <ZQB+Z2Zwkyz7u9IL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQB+Z2Zwkyz7u9IL@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230912 15:07]:
> On Tue, Sep 12, 2023 at 02:03:44PM +0300, Tony Lindgren wrote:
> > +static LIST_HEAD(serial_base_consoles);
> 
> Don't you need a locking to access this list?
> If not, perhaps a comment why it's okay?

It's updated at arch_initcall() time only, I'll add a comment.

> > +	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
> > +			       port->ctrl_id, port->port_id);
> 
> What about starting using cleanup.h?

OK seems to simplify things nicely :)

> > +EXPORT_SYMBOL_GPL(serial_base_add_preferred_console);
> 
> Can we use (start using) namespaced exports?

Sorry forgot about the namespace stuff already..

> ...
> 
> > +static int __init serial_base_add_con(char *name, char *opt)
> 
> const name
> const opt
> ?

For name yes, opt has issues as noted in the first patch in this
series.

> > +	opt = strchr(val, ',');
> > +	if (opt) {
> > +		opt[0] = '\0';
> > +		opt++;
> > +	}
> 
> strsep() ?
> 
> Actually param_array() uses strcspn() in similar situation.

OK I'll change to use strcspn().

> > +	if (!strlen(val))
> > +		return 0;
> 
> Btw, have you seen lib/cmdline.c? Can it be helpful here?

I don't think so as at this point we don't have param=value
pairs and param is the port name.

Will fix up the rest of the stuff you commented too thanks.

Regards,

Tony
