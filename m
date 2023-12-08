Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F155A809E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573311AbjLHI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:29:00 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6922E171C;
        Fri,  8 Dec 2023 00:29:06 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 0C73A6035A;
        Fri,  8 Dec 2023 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1702024145;
        bh=UvyfqdbltEMmT/d4QMm8n0gCUuXIl0RJbtpBTH/Mcu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGW1PtS6877xWlAfkBFPmmyYoff9/sIjB+d6vgZ8zAhDPDvGeggkaP5A+OfwLrn/q
         AcnjVRARcAnAY5XGpe2nGf09IwhQQQEvSRLMsJvhTZLrdh8T56xQiGl2C1adE6kEM5
         BwVTunrjXlLfbFV6KQHgIryBfytNac4bnG6BYfndlxxB4BVmxgiO0IdMLq/PHXqayY
         UK2PRnzRMMefRAPWhIWmP+SNAomc4s/6ezb3feFqnqhwgvE0y+3FlZC7CamnHEMxw5
         8ppI/8NDGW2yXdRvzipG+x9ZXdEinJSJnjbUP4unG5nP/AFnFB2It0bhNBIB2Ro+s1
         mG92ERpGo7HCw==
Date:   Fri, 8 Dec 2023 10:28:32 +0200
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
Message-ID: <20231208082832.GV5169@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
 <20231205074557.GM5169@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205074557.GM5169@atomide.com>
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
> * Tony Lindgren <tony@atomide.com> [700101 02:00]:
> > We also prepare the serial core to handle the ttyS related quirks done
> > in console_setup() to prepare things for eventually dropping the parsing
> > from console_setup(). This can only happen after further changes to
> > register_console().
> 
> Petr FYI, so for dropping the console_setup() parsing, below is a hack
> patch to see what goes wrong in register_console() if you have some ideas
> on how to handle this.
> 
> We end up with the console device backed up seria8250 instead of ttyS0,
> and earlycon won't get properly disabled. And of course other consoles
> beyond ttyS need to be also considered.

Hmm so the following extra patch seems to fix the issues based on light
testing. But is it safe to assume that if CON_PRINTBUFFER is set we can
disable the bootconsole?

I also noticed that the bootconsole not getting disabled issue is there
also for console=DEVNAME:0.0 usage even before we start dropping handling
in console_setup().

Regards,

Tony

8< ----------------------
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3549,7 +3549,8 @@ void register_console(struct console *newcon)
 	 */
 	con_printk(KERN_INFO, newcon, "enabled\n");
 	if (bootcon_registered &&
-	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
+	    !(newcon->flags & CON_BOOT) &&
+	    (newcon->flags & (CON_CONSDEV | CON_PRINTBUFFER)) &&
 	    !keep_bootcon) {
 		struct hlist_node *tmp;
 
-- 
2.43.0
