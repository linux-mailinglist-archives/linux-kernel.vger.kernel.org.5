Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF405804B52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjLEHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:46:24 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C43CA;
        Mon,  4 Dec 2023 23:46:30 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 4FB4160354;
        Tue,  5 Dec 2023 07:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701762390;
        bh=rT0e7HunZB9SC79QqVKxOFK0aB1vcmVtURjGalaiBlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBJQwVQt5H27jqp5h0AMKs9ZtsUXCzVY7sCy5tAZUBZ82KR5Sz6FyqL/rFxkvTaIE
         hJIdG86UKYPt4Nz4wdacDHN5MXY9ODDUKZOM9M7r71Q0LXOZKZL1uLs6vG+aZPggbo
         w+LFuUsxTQZg68JCMf8UGvui8BvWHElcuqqv7ka1zRhg6hvSnnutAY4Dd/XjcPfVsl
         mSIhJu9JkgHHmdOfV8h0zf2b4ml3NOlC/LAQWuIuSsi4Jn+0l6BKtj+rdUe4x7+qri
         Mpqw9B4jotbyiabAd3PVztZK4hhrdSmn9Xm3evuUb68o118jz0yeerZ68qkgDYPi9V
         +WZ2rZkFyXCjA==
Date:   Tue, 5 Dec 2023 09:45:57 +0200
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
Subject: Re: [PATCH v4 0/4] Add support for DEVNAME:0.0 style hardware based
 addressing
Message-ID: <20231205074557.GM5169@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205073255.20562-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [700101 02:00]:
> We also prepare the serial core to handle the ttyS related quirks done
> in console_setup() to prepare things for eventually dropping the parsing
> from console_setup(). This can only happen after further changes to
> register_console().

Petr FYI, so for dropping the console_setup() parsing, below is a hack
patch to see what goes wrong in register_console() if you have some ideas
on how to handle this.

We end up with the console device backed up seria8250 instead of ttyS0,
and earlycon won't get properly disabled. And of course other consoles
beyond ttyS need to be also considered.

Regards,

Tony

8< ----------------------
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2438,9 +2438,7 @@ __setup("console_msg_format=", console_msg_format_setup);
  */
 static int __init console_setup(char *str)
 {
-	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
-	int idx;
+	char *brl_options = NULL;
 
 	/*
 	 * console="" or console=null have been suggested as a way to
@@ -2459,32 +2457,9 @@ static int __init console_setup(char *str)
 	if (console_opt_save(str, brl_options))
 		return 1;
 
-	/*
-	 * Decode str into name, index, options.
-	 */
-	if (str[0] >= '0' && str[0] <= '9') {
-		strcpy(buf, "ttyS");
-		strncpy(buf + 4, str, sizeof(buf) - 5);
-	} else {
-		strncpy(buf, str, sizeof(buf) - 1);
-	}
-	buf[sizeof(buf) - 1] = 0;
-	options = strchr(str, ',');
-	if (options)
-		*(options++) = 0;
-#ifdef __sparc__
-	if (!strcmp(str, "ttya"))
-		strcpy(buf, "ttyS0");
-	if (!strcmp(str, "ttyb"))
-		strcpy(buf, "ttyS1");
-#endif
-	for (s = buf; *s; s++)
-		if (isdigit(*s) || *s == ',')
-			break;
-	idx = simple_strtoul(s, NULL, 10);
-	*s = 0;
+	/* Indicate register_console() a console was specified */
+	console_set_on_cmdline = 1;
 
-	__add_preferred_console(buf, idx, options, brl_options, true);
 	return 1;
 }
 __setup("console=", console_setup);
@@ -3476,7 +3451,7 @@ void register_console(struct console *newcon)
 	 * Note that a console with tty binding will have CON_CONSDEV
 	 * flag set and will be first in the list.
 	 */
-	if (preferred_console < 0) {
+	if (preferred_console < 0 && !console_set_on_cmdline) {
 		if (hlist_empty(&console_list) || !console_first()->device ||
 		    console_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
