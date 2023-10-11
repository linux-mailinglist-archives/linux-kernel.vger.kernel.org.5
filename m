Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F157C58FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjJKQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjJKQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:17:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8B40B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:17:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CC56080E1;
        Wed, 11 Oct 2023 16:17:14 +0000 (UTC)
Date:   Wed, 11 Oct 2023 19:17:13 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Check valid console index for preferred
 console
Message-ID: <20231011161713.GE34982@atomide.com>
References: <20231011074330.14487-1-tony@atomide.com>
 <2023101131-maroon-stubborn-1364@gregkh>
 <20231011091803.GC34982@atomide.com>
 <ZSa-j7p-icBvOANN@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSa-j7p-icBvOANN@alley>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Petr Mladek <pmladek@suse.com> [231011 15:26]:
> On Wed 2023-10-11 12:18:03, Tony Lindgren wrote:
> > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231011 07:53]:
> > > On Wed, Oct 11, 2023 at 10:43:25AM +0300, Tony Lindgren wrote:
> > > > Let's check for valid console index values to avoid bogus console index
> > > > numbers from kernel command line. While struct console uses short for
> > > > index, and negative index values are used by some device drivers, we do
> > > > not want to allow negative values for preferred console.
> > > 
> > > What drivers use a negative index for the console?
> > 
> > This is based on grepping with $ git grep "co->index =" drivers/tty/
> > 
> > Not sure what all might be stopping making struct console index unsigned.
> 
> The value -1 is used for initializing struct console, see:
> 
> $> git grep -A10 "struct console.*=" | \
>    grep -e "struct console" -e index | \
>    grep -B1 index
> [...]
> drivers/tty/serial/8250/8250_core.c:static struct console univ8250_console = {
> drivers/tty/serial/8250/8250_core.c-    .index          = -1,
> [...]
> drivers/tty/serial/imx.c:static struct console imx_uart_console = {
> drivers/tty/serial/imx.c-       .index          = -1,
> drivers/tty/serial/ip22zilog.c:static struct console ip22zilog_console = {
> drivers/tty/serial/ip22zilog.c- .index  =       -1,
> drivers/tty/serial/kgdb_nmi.c:static struct console kgdb_nmi_console = {
> drivers/tty/serial/kgdb_nmi.c-  .index  = -1,
> drivers/tty/serial/lantiq.c:static struct console lqasc_console = {
> drivers/tty/serial/lantiq.c-    .index =        -1,
> drivers/tty/serial/liteuart.c:static struct console liteuart_console = {
> drivers/tty/serial/liteuart.c-  .index = -1,
> drivers/tty/serial/lpc32xx_hs.c:static struct console lpc32xx_hsuart_console = {
> drivers/tty/serial/lpc32xx_hs.c-        .index          = -1,
> drivers/tty/serial/ma35d1_serial.c:static struct console ma35d1serial_console = {
> drivers/tty/serial/ma35d1_serial.c-     .index   = -1,
> drivers/tty/serial/mcf.c:static struct console mcf_console = {
> drivers/tty/serial/mcf.c-       .index          = -1,
> [...]
> 
> It means that the index still has be get assigned. For example, it is
> used here:
> 
> static int try_enable_preferred_console(struct console *newcon,
> 					bool user_specified)
> {
> [...]
> 			if (newcon->index < 0)
> 				newcon->index = c->index;
> [...]

OK

> Resume:
> 
> 1. We must either keep signed short in struct console or
>    use another check for non-yet assigned index.

OK thanks for clarifying the usage for it.

> 2. We should fix the commit message and the comment. We should
>    explain that negative value is used in struct console
>    to distinguish a non-yet-registered/assigned index/port.

I'll send v3 patches tomorrow with updated commit message and comments.

Thanks,

Tony
