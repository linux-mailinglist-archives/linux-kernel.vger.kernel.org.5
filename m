Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8756E79CF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjILLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjILLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:04:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E190A9F;
        Tue, 12 Sep 2023 04:04:14 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3BF168106;
        Tue, 12 Sep 2023 11:04:12 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 1/3] printk: Constify name for add_preferred_console()
Date:   Tue, 12 Sep 2023 14:03:43 +0300
Message-ID: <20230912110350.14482-2-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912110350.14482-1-tony@atomide.com>
References: <20230912110350.14482-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While adding a preferred console handling for serial_core for serial port
hardware based device addressing, Jiri suggested we constify name for
add_preferred_console(). The gets copied anyways. This allows serial core
to add a preferred console using serial drv->dev_name without copying it.

Note that constifying options causes changes all over the place because of
struct console for match().

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/linux/console.h | 2 +-
 kernel/printk/printk.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -337,7 +337,7 @@ enum con_flush_mode {
 	CONSOLE_REPLAY_ALL,
 };
 
-extern int add_preferred_console(char *name, int idx, char *options);
+extern int add_preferred_console(const char *name, int idx, char *options);
 extern void console_force_preferred_locked(struct console *con);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2400,7 +2400,7 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
-static int __add_preferred_console(char *name, int idx, char *options,
+static int __add_preferred_console(const char *name, int idx, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
@@ -2509,7 +2509,7 @@ __setup("console=", console_setup);
  * commonly to provide a default console (ie from PROM variables) when
  * the user has not supplied one.
  */
-int add_preferred_console(char *name, int idx, char *options)
+int add_preferred_console(const char *name, int idx, char *options)
 {
 	return __add_preferred_console(name, idx, options, NULL, false);
 }
-- 
2.42.0
