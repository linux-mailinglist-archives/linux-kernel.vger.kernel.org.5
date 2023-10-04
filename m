Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C547B7BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbjJDJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjJDJVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:21:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DED7C9E;
        Wed,  4 Oct 2023 02:21:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2FD4780BD;
        Wed,  4 Oct 2023 09:21:33 +0000 (UTC)
Date:   Wed, 4 Oct 2023 12:21:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Check for valid console index
Message-ID: <20231004092131.GG34982@atomide.com>
References: <20231004085511.42645-1-tony@atomide.com>
 <1fc2dc1d-33f2-6d65-6bdb-d4c7421cbc57@linux.intel.com>
 <20231004090859.GF34982@atomide.com>
 <375d54d0-f874-92d5-91c5-c7ff2b33daff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <375d54d0-f874-92d5-91c5-c7ff2b33daff@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [231004 09:13]:
> On Wed, 4 Oct 2023, Tony Lindgren wrote:
> 
> > * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [231004 09:05]:
> > > On Wed, 4 Oct 2023, Tony Lindgren wrote:
> > > 
> > > > Let's not allow negative numbers for console index.
> > > > 
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > > > --- a/drivers/tty/serial/8250/8250_core.c
> > > > +++ b/drivers/tty/serial/8250/8250_core.c
> > > > @@ -611,7 +611,7 @@ static int univ8250_console_setup(struct console *co, char *options)
> > > >  	 * if so, search for the first available port that does have
> > > >  	 * console support.
> > > >  	 */
> > > > -	if (co->index >= UART_NR)
> > > > +	if (co->index < 0 || co->index >= UART_NR)
> > > >  		co->index = 0;
> > > 
> > > The inconsistencies how different serial drivers handle this situation 
> > > seem staggering. Perhaps there should be some effort to make the behavior
> > > uniform across them?
> > 
> > Hmm yeah we should just have them all check for co->index < 0.
> 
> Right but it's only about that, some return -Exx codes (more than one -Exx 
> variant) and some do assign just 0 like here.

What do you have in mind then? They should all assume co->index < 0 is an
invalid console index still, right :)

Regards,

Tony
