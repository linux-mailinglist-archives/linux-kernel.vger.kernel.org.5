Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D797C5806
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjJKP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjJKP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:26:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5355798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:26:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B0E2D21870;
        Wed, 11 Oct 2023 15:26:08 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D7A92C710;
        Wed, 11 Oct 2023 15:26:07 +0000 (UTC)
Date:   Wed, 11 Oct 2023 17:26:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Check valid console index for preferred
 console
Message-ID: <ZSa-j7p-icBvOANN@alley>
References: <20231011074330.14487-1-tony@atomide.com>
 <2023101131-maroon-stubborn-1364@gregkh>
 <20231011091803.GC34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011091803.GC34982@atomide.com>
X-Spamd-Bar: +++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [23.60 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[6];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+]
X-Spam-Score: 23.60
X-Rspamd-Queue-Id: B0E2D21870
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-11 12:18:03, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231011 07:53]:
> > On Wed, Oct 11, 2023 at 10:43:25AM +0300, Tony Lindgren wrote:
> > > Let's check for valid console index values to avoid bogus console index
> > > numbers from kernel command line. While struct console uses short for
> > > index, and negative index values are used by some device drivers, we do
> > > not want to allow negative values for preferred console.
> > 
> > What drivers use a negative index for the console?
> 
> This is based on grepping with $ git grep "co->index =" drivers/tty/
> 
> Not sure what all might be stopping making struct console index unsigned.

The value -1 is used for initializing struct console, see:

$> git grep -A10 "struct console.*=" | \
   grep -e "struct console" -e index | \
   grep -B1 index
[...]
drivers/tty/serial/8250/8250_core.c:static struct console univ8250_console = {
drivers/tty/serial/8250/8250_core.c-    .index          = -1,
[...]
drivers/tty/serial/imx.c:static struct console imx_uart_console = {
drivers/tty/serial/imx.c-       .index          = -1,
drivers/tty/serial/ip22zilog.c:static struct console ip22zilog_console = {
drivers/tty/serial/ip22zilog.c- .index  =       -1,
drivers/tty/serial/kgdb_nmi.c:static struct console kgdb_nmi_console = {
drivers/tty/serial/kgdb_nmi.c-  .index  = -1,
drivers/tty/serial/lantiq.c:static struct console lqasc_console = {
drivers/tty/serial/lantiq.c-    .index =        -1,
drivers/tty/serial/liteuart.c:static struct console liteuart_console = {
drivers/tty/serial/liteuart.c-  .index = -1,
drivers/tty/serial/lpc32xx_hs.c:static struct console lpc32xx_hsuart_console = {
drivers/tty/serial/lpc32xx_hs.c-        .index          = -1,
drivers/tty/serial/ma35d1_serial.c:static struct console ma35d1serial_console = {
drivers/tty/serial/ma35d1_serial.c-     .index   = -1,
drivers/tty/serial/mcf.c:static struct console mcf_console = {
drivers/tty/serial/mcf.c-       .index          = -1,
[...]

It means that the index still has be get assigned. For example, it is
used here:

static int try_enable_preferred_console(struct console *newcon,
					bool user_specified)
{
[...]
			if (newcon->index < 0)
				newcon->index = c->index;
[...]


Resume:

1. We must either keep signed short in struct console or
   use another check for non-yet assigned index.

2. We should fix the commit message and the comment. We should
   explain that negative value is used in struct console
   to distinguish a non-yet-registered/assigned index/port.

Best Regards,
Petr
