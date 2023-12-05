Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFDB804B35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjLEHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjLEHeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:34:17 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B72188;
        Mon,  4 Dec 2023 23:34:23 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 7431C60354;
        Tue,  5 Dec 2023 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701761662;
        bh=4xP9cJSfauOpucthPnTkf58g4HcyVjB8aEQlHWQSQnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbT9QWaEYFQLKrxaTbjS4aBKV0kxVM1AE//mdrOCn2xvsSTY+ec36le42LxOTqzfL
         hdBZx6Qs151OA27uuifHl0cbtcFYqyZ5Qn56Thmg6gv8/hnez9iX0mGniY+1bU+5Bz
         PmeuJDdQV14RAeQIxGjrPLUm8JDr7pn6Gi3u7WsGPoN2qoAQ6XAbhi9O/lGOJ3oEIU
         1+C1yEHLF9P0osH1T4yCNF7D9NeivQRcM3kmLl409vRoorenFTPzpfvIr7Qi6XUF8I
         dqEHYpglGEei3u8/1pTL94Qk9ZGU4yjKseUf83bq4dSw7OfSnOKqWkRHge6B3GTWwW
         KzVY5nHkClNHQ==
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
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v4 1/4] printk: Save console options for add_preferred_console_match()
Date:   Tue,  5 Dec 2023 09:32:33 +0200
Message-ID: <20231205073255.20562-2-tony@atomide.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205073255.20562-1-tony@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver subsystems may need to translate the preferred console name to the
character device name used. We already do some of this in console_setup()
with a few hardcoded names, but that does not scale well.

The console options are parsed early in console_setup(), and the consoles
are added with __add_preferred_console(). At this point we don't know much
about the character device names and device drivers getting probed.

To allow drivers subsystems to set up a preferred console, let's save the
kernel command line console options. To add a preferred console from a
driver subsystem with optional character device name translation, let's
add a new function add_preferred_console_match().

This allows the serial core layer to support console=DEVNAME:0.0 style
hardware based addressing in addition to the current console=ttyS0 style
naming. And we can start moving console_setup() character device parsing
to the driver subsystem specific code.

We use a separate array from the console_cmdline array as the character
device name and index may be unknown at the console_setup() time. And
eventually there's no need to call __add_preferred_console() until the
character device name and index are known.

Adding the console name in addition to the character device name, and a
flag for an added console, could be added to the struct console_cmdline.
And the console_cmdline array handling could be modified accordingly. But
that complicates things compared saving the console options, and then
adding the consoles when the subsystems handling the consoles are ready.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/linux/printk.h          |   3 +
 kernel/printk/Makefile          |   2 +-
 kernel/printk/conopt.c          | 128 ++++++++++++++++++++++++++++++++
 kernel/printk/console_cmdline.h |   6 ++
 kernel/printk/printk.c          |  14 +++-
 5 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 kernel/printk/conopt.c

diff --git a/include/linux/printk.h b/include/linux/printk.h
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -60,6 +60,9 @@ static inline const char *printk_skip_headers(const char *buffer)
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
 #define CONSOLE_LOGLEVEL_QUIET	 CONFIG_CONSOLE_LOGLEVEL_QUIET
 
+int add_preferred_console_match(const char *match, const char *name,
+				const short idx);
+
 extern int console_printk[];
 
 #define console_loglevel (console_printk[0])
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y	= printk.o
+obj-y	= printk.o conopt.o
 obj-$(CONFIG_PRINTK)	+= printk_safe.o nbcon.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
 obj-$(CONFIG_PRINTK_INDEX)	+= index.o
diff --git a/kernel/printk/conopt.c b/kernel/printk/conopt.c
new file mode 100644
--- /dev/null
+++ b/kernel/printk/conopt.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel command line console options for hardware based addressing
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Author: Tony Lindgren <tony@atomide.com>
+ */
+
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/errno.h>
+
+#include "console_cmdline.h"
+
+/*
+ * Allow longer DEVNAME:0.0 style console naming such as abcd0000.serial:0.0
+ * in addition to the legacy ttyS0 style naming.
+ */
+#define CONSOLE_NAME_MAX	32
+
+#define CONSOLE_OPT_MAX		16
+#define CONSOLE_BRL_OPT_MAX	16
+
+struct console_option {
+	char name[CONSOLE_NAME_MAX];
+	char opt[CONSOLE_OPT_MAX];
+	char brl_opt[CONSOLE_BRL_OPT_MAX];
+};
+
+/* Updated only at console_setup() time, no locking needed */
+static struct console_option conopt[MAX_CMDLINECONSOLES];
+
+/**
+ * console_opt_save - Saves kernel command line console option for driver use
+ * @str: Kernel command line console name and option
+ * @brl_opt: Braille console options
+ *
+ * Saves a kernel command line console option for driver subsystems to use for
+ * adding a preferred console during init. Called from console_setup() only.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int __init console_opt_save(const char *str, const char *brl_opt)
+{
+	struct console_option *con;
+	const char *opt = NULL;
+	size_t namelen, optlen;
+	int i;
+
+	namelen = strcspn(str, ",");
+	if (!namelen)
+		return -EINVAL;
+
+	optlen = strlen(str) - namelen;
+	if (optlen > 1)
+		opt = str + namelen + 1;
+
+	if (namelen >= CONSOLE_NAME_MAX || optlen >= CONSOLE_OPT_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < MAX_CMDLINECONSOLES; i++) {
+		con = &conopt[i];
+
+		if (con->name[0]) {
+			if (!strncmp(str, con->name, namelen))
+				return 0;
+			continue;
+		}
+
+		strscpy(con->name, str, namelen + 1);
+		if (opt)
+			strscpy(con->opt, opt, optlen + 1);
+
+		if (brl_opt)
+			strscpy(con->brl_opt, brl_opt, CONSOLE_BRL_OPT_MAX);
+
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static struct console_option *console_opt_find(const char *name)
+{
+	struct console_option *con;
+	int i;
+
+	for (i = 0; i < MAX_CMDLINECONSOLES; i++) {
+		con = &conopt[i];
+		if (!strcmp(name, con->name))
+			return con;
+	}
+
+	return NULL;
+}
+
+/**
+ * add_preferred_console_match - Adds a preferred console if a match is found
+ * @match: Expected console on kernel command line, such as console=DEVNAME:0.0
+ * @name: Name of the console character device to add such as ttyS
+ * @idx: Index for the console
+ *
+ * Allows driver subsystems to add a console after translating the command
+ * line name to the character device name used for the console. Options are
+ * added automatically based on the kernel command line. Duplicate preferred
+ * consoles are ignored by __add_preferred_console().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int add_preferred_console_match(const char *match, const char *name,
+				const short idx)
+{
+	struct console_option *con;
+
+	if (!match || !strlen(match) || !name || !strlen(name) ||
+	    idx < 0)
+		return -EINVAL;
+
+	con = console_opt_find(match);
+	if (!con)
+		return -ENOENT;
+
+	console_opt_add_preferred_console(name, idx, con->opt, con->brl_opt);
+
+	return 0;
+}
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -2,6 +2,12 @@
 #ifndef _CONSOLE_CMDLINE_H
 #define _CONSOLE_CMDLINE_H
 
+#define MAX_CMDLINECONSOLES 8
+
+int console_opt_save(const char *str, const char *brl_opt);
+int console_opt_add_preferred_console(const char *name, const short idx,
+				      char *options, char *brl_options);
+
 struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -360,9 +360,6 @@ static int console_locked;
 /*
  *	Array of consoles built from command line options (console=)
  */
-
-#define MAX_CMDLINECONSOLES 8
-
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
@@ -2458,6 +2455,10 @@ static int __init console_setup(char *str)
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
+	/* Save the console for driver subsystem use */
+	if (console_opt_save(str, brl_options))
+		return 1;
+
 	/*
 	 * Decode str into name, index, options.
 	 */
@@ -2488,6 +2489,13 @@ static int __init console_setup(char *str)
 }
 __setup("console=", console_setup);
 
+/* Only called from add_preferred_console_match() */
+int console_opt_add_preferred_console(const char *name, const short idx,
+				      char *options, char *brl_options)
+{
+	return __add_preferred_console(name, idx, options, brl_options, true);
+}
+
 /**
  * add_preferred_console - add a device to the list of preferred consoles.
  * @name: device name
-- 
2.43.0
