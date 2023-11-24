Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312E27F6BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjKXF5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXF5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:57:10 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD6189;
        Thu, 23 Nov 2023 21:57:17 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 3A38B60B1C;
        Fri, 24 Nov 2023 05:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1700805436;
        bh=D+5OJtIXXHhQ4jFCNY71lo60Nt7F5l8pHOuTGGgUjUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgmlAdYVqncyCUSzoeA/3qdXsRIFmTqgdm2efS+e3q8k+zjjcNuNJkDR9CkXfZYje
         dOc2SYOtgA9VDPqZxWhUf4nt2ywLzLPYgEbySct6hYIW4ce3iN7W6EJW0zVTzzEbw8
         M7LRhCCant9aj5L3wzZUjanaRiNlc1KCJXJEfzflEj57FOcocmADfNTBRMQFecPbvO
         ffT3gHtTzJw+++Rx8SIuxr60bkI6nlInfYGpKLoamMDCr7+L08XfSUjYydYK8K043u
         njjx5bFbgKysdVNWgCocxRudQ7lbrRUFMPo6WNg+kEarkMPNGo27mCgc9tw9A3ZUPA
         IOnmnkfcdF3xQ==
Date:   Fri, 24 Nov 2023 07:56:43 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <20231124055643.GH5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-4-tony@atomide.com>
 <20231122070353.GF5169@atomide.com>
 <20231122081554.GG5169@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122081554.GG5169@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [231122 10:16]:
> * Tony Lindgren <tony@atomide.com> [231122 09:04]:
> > * Tony Lindgren <tony@atomide.com> [700101 02:00]:
> > > -	__add_preferred_console(buf, idx, options, brl_options, true);
> > >  	return 1;
> > 
> > Looks like this can't be dropped yet. We need to keep it for the
> > brl_options. I'll change it to return early if brl_options is NULL.
> 
> Looks like we can drop the parsing from printk :) In console_setup()
> we can call console_opt_save() after _braille_console_setup(), and
> then save also the brl_options for the port.

I noticed we have more issues remaining trying to drop the console
parsing completely from console_setup().

If add_preferred_console() gets called later, register_console() can
try to call try_enable_default_console() before we get around to call
try_enable_preferred_console(), and that may lead to no serial console.

To avoid that, setting console_set_on_cmdline = 1 in console_setup(),
and patching register_console() console to check for the flag helps.
But looks like that leads to bootconsole not getting disabled and
more patching for that is needed.. And of course we'd need to check
the other register_console() callers too, not just 8250..

So I think for now, it's best to just drop the 8250 and sparc quirks
from console_setup(), that already simplifies things in printk a bit :)

And for 8250, we should have serial8250_isa_init_ports() call
add_preferred_console_match() to avoid console getting registered
later on when the hardware specific driver takes over for x86, m68k,
and alpha that define SERIAL_PORT_DFNS.

Regards,

Tony
