Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3001D758D52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGSFtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSFtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:49:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A9161BF5;
        Tue, 18 Jul 2023 22:49:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9F07D80AA;
        Wed, 19 Jul 2023 05:49:31 +0000 (UTC)
Date:   Wed, 19 Jul 2023 08:49:30 +0300
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
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add support for dev_name:0.0 naming for
 kernel console
Message-ID: <20230719054930.GK5194@atomide.com>
References: <20230719051525.46494-1-tony@atomide.com>
 <35758c24-1543-6f96-7957-b371dc94e59d@kernel.org>
 <20230719052811.GH5194@atomide.com>
 <87431096-e883-c90d-853e-44a463c0e8f2@kernel.org>
 <20230719053220.GI5194@atomide.com>
 <c0061557-1dc7-0442-b5e0-3e528d0bebb1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0061557-1dc7-0442-b5e0-3e528d0bebb1@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230719 05:36]:
> On 19. 07. 23, 7:32, Tony Lindgren wrote:
> > * Jiri Slaby <jirislaby@kernel.org> [230719 05:29]:
> > > On 19. 07. 23, 7:28, Tony Lindgren wrote:
> > > > * Jiri Slaby <jirislaby@kernel.org> [230719 05:25]:
> > > > > On 19. 07. 23, 7:15, Tony Lindgren wrote:
> > > > > > +/*
> > > > > > + * Add preferred console if configured on kernel command line with naming
> > > > > > + * "console=dev_name:0.0".
> > > > > > + */
> > > > > > +static int serial_core_add_preferred_console(struct uart_driver *drv,
> > > > > > +					     struct uart_port *port)
> > > > > > +{
> > > > > > +	char *port_match, *opt, *name;
> > > > > > +	int len, ret = 0;
> > > > > > +
> > > > > > +	port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
> > > > > > +			       dev_name(port->dev), port->ctrl_id,
> > > > > > +			       port->port_id);
> > > > > > +	if (!port_match)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	opt = strstr(saved_command_line, port_match);
> > > > > > +	if (!opt)
> > > > > > +		goto free_port_match;
> > > > > > +
> > > > > > +	len = strlen(port_match);
> > > > > > +
> > > > > > +	if (strlen(opt) > len + 1 && opt[len] == ',')
> > > > > > +		opt += len + 1;
> > > > > > +	else
> > > > > > +		opt = NULL;
> > > > > > +
> > > > > > +	name = kstrdup(drv->dev_name, GFP_KERNEL);
> > > > > 
> > > > > Why do you dup the name here?
> > > > 
> > > > I was getting ignoring const warning, but maybe the right solution is
> > > > to just use const char *name here.. Let me check.
> > > 
> > > So fix add_preferred_console() instead ;).
> > 
> > Let's see what kind of trouble changing it to use const char *name
> > might be.
> 
> I don't see any, the string is copied internally. So it should be
> straightforward. Actually all three parameters of __add_preferred_console()
> should be const, IMO. But that involves changing struct console_cmdline. But
> that should be straightforward too.

Yeah I'll send a patch for that.

> Aside from that, why do you parse saved_command_line on your own? Instead of
> using setup() or other commonly used mechanisms for command line handling?

Hmm that might be easier yeah :)

Regards,

Tony
