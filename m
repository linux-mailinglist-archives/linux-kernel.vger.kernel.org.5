Return-Path: <linux-kernel+bounces-120709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAC188DBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59A8299CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92194F1FB;
	Wed, 27 Mar 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="CA0dYUg3"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EE52F8D;
	Wed, 27 Mar 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537320; cv=none; b=JNX585dxn1/aPhaBmZKuLRtzdUt9L9UdmPh65niJe5grE8HBQLpaYjzEKILG1y31hp89mLZKftvNCMpSkeG/8OliVO+hnBFCftG2/fNx5d3yiexwfJCEamg95Cdwm6qL/T0wn1/IRsyAnGRtE2ke7CqmAX8PUk3Ql6ni1J7/ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537320; c=relaxed/simple;
	bh=mvzC3zJ36JM//DA+DACooA2x2bGYxkLRQfyMbLITm/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBeD9R/b40L66ElScTZdzB9p4DUUSKEV/Y0XEo0txaGNIHtb1vwU+Rw0J85HbWGTgT9nR7vSDIrjGpw7b3Zz0SaLcSigLoF4/qJIrf6ieHXdTyymEHZc8EIJ2UXPeuyXKhwL1+Qhi7x1Y2oR4vAlbsR0E87ch/jrejjAlCQEuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=CA0dYUg3; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9776F6088D;
	Wed, 27 Mar 2024 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537315;
	bh=mvzC3zJ36JM//DA+DACooA2x2bGYxkLRQfyMbLITm/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CA0dYUg3biS+q1OX6qK1hkWT+3mhtWw2cOyavcwJImJMRWYDTeZlTHtHEPtZNmq1v
	 nNxbykDaufV+z+poE9/vLepveY3UMOYZHSJYMNyY1pQW1dCtt9Jw3As9nLWtT/BDvL
	 x0hUvFYZOA44RocFU7LKdrmYl9upj60E85uvmSd7UIWKXRPZWIkz6NfgIhiIVNGHCG
	 hDSpf9ax0jrBvwKM9aESAF6ek7t0LIYQE+fmD5w8Or7h8wjf6LunVsVDeSLu7G8DFf
	 Dm0byh5HZVXFnEojkiVGYbLYWXCYW18gvq0VOFkBHop+Zv17OoodI3PdMNFYPVLm3i
	 5tqwOzv1jaaYA==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 1/7] printk: Save console options for add_preferred_console_match()
Date: Wed, 27 Mar 2024 12:59:35 +0200
Message-ID: <20240327110021.59793-2-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327110021.59793-1-tony@atomide.com>
References: <20240327110021.59793-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver subsystems may need to translate the preferred console name to the
character device name used. We already do some of this in console_setup()
with a few hardcoded names, but that does not scale well.

The console options are parsed early in console_setup(), and the consoles
are added with __add_preferred_console(). At this point we don't know much
about the character device names and device drivers getting probed.

To allow driver subsystems to set up a preferred console, let's save the
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
subsystem is ready to handle the console.

Adding the console name in addition to the character device name, and a
flag for an added console, could be added to the struct console_cmdline.
And the console_cmdline array handling could be modified accordingly. But
that complicates things compared saving the console options, and then
adding the consoles when the subsystems handling the consoles are ready.

Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/linux/printk.h          |   3 +
 kernel/printk/Makefile          |   2 +-
 kernel/printk/conopt.c          | 146 ++++++++++++++++++++++++++++++++
 kernel/printk/console_cmdline.h |   6 ++
 kernel/printk/printk.c          |  14 ++-
 5 files changed, 167 insertions(+), 4 deletions(-)
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
@@ -0,0 +1,146 @@
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
+#include <linux/types.h>
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
+	u8 has_brl_opt:1;
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
+	size_t namelen, optlen;
+	const char *opt;
+	int i;
+
+	namelen = strcspn(str, ",");
+	if (namelen == 0 || namelen >= CONSOLE_NAME_MAX)
+		return -EINVAL;
+
+	opt = str + namelen;
+	if (*opt == ',')
+		opt++;
+
+	optlen = strlen(opt);
+	if (optlen >= CONSOLE_OPT_MAX)
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
+		/*
+		 * The name isn't terminated, only opt is. Empty opt is fine,
+		 * but brl_opt can be either empty or NULL. For more info, see
+		 * _braille_console_setup().
+		 */
+		strscpy(con->name, str, namelen + 1);
+		strscpy(con->opt, opt, CONSOLE_OPT_MAX);
+		if (brl_opt) {
+			strscpy(con->brl_opt, brl_opt, CONSOLE_BRL_OPT_MAX);
+			con->has_brl_opt = 1;
+		}
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
+	char *brl_opt = NULL;
+
+	if (!match || !strlen(match) || !name || !strlen(name) ||
+	    idx < 0)
+		return -EINVAL;
+
+	con = console_opt_find(match);
+	if (!con)
+		return -ENOENT;
+
+	/*
+	 * See __add_preferred_console(). It checks for NULL brl_options to set
+	 * the preferred_console flag. Empty brl_opt instead of NULL leads into
+	 * the preferred_console flag not set, and CON_CONSDEV not being set,
+	 * and the boot console won't get disabled at the end of console_setup().
+	 */
+	if (con->has_brl_opt)
+		brl_opt = con->brl_opt;
+
+	console_opt_add_preferred_console(name, idx, con->opt, brl_opt);
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
@@ -383,9 +383,6 @@ static int console_locked;
 /*
  *	Array of consoles built from command line options (console=)
  */
-
-#define MAX_CMDLINECONSOLES 8
-
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
@@ -2497,6 +2494,10 @@ static int __init console_setup(char *str)
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
+	/* Save the console for driver subsystem use */
+	if (console_opt_save(str, brl_options))
+		return 1;
+
 	/*
 	 * Decode str into name, index, options.
 	 */
@@ -2527,6 +2528,13 @@ static int __init console_setup(char *str)
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
2.44.0

