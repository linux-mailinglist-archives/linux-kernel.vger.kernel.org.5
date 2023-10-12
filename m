Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B97C65C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbjJLGnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbjJLGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:43:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1A6ECC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:43:05 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7663F80A3;
        Thu, 12 Oct 2023 06:43:04 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] printk: Check valid console index for preferred console
Date:   Thu, 12 Oct 2023 09:42:56 +0300
Message-ID: <20231012064300.50221-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check for valid console index values for preferred console to avoid
bogus console index numbers from kernel command line.

Let's also return an error for negative index numbers for the preferred
console. Unlike for device drivers, a negative index is not valid for the
preferred console.

Let's also constify idx while at it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v2:

- Fix a mismerge for const char *name while changing the patch
  order as noted by Jiri

- Clarify patch description and code comments for struct console
  negative index usage as noted by Petr

Changes since v1:

- Use const short idx and return an error on negative values

---
 include/linux/console.h |  2 +-
 kernel/printk/printk.c  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -340,7 +340,7 @@ enum con_flush_mode {
 	CONSOLE_REPLAY_ALL,
 };
 
-extern int add_preferred_console(char *name, int idx, char *options);
+extern int add_preferred_console(char *name, const short idx, char *options);
 extern void console_force_preferred_locked(struct console *con);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2404,12 +2404,20 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
-static int __add_preferred_console(char *name, int idx, char *options,
+static int __add_preferred_console(char *name, const short idx, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
 
+	/*
+	 * We use a signed short index for struct console for device drivers to
+	 * indicate a not yet assigned index or port. However, a negative index
+	 * value is not valid for preferred console.
+	 */
+	if (idx < 0)
+		return -EINVAL;
+
 	/*
 	 *	See if this tty is not yet registered, and
 	 *	if we have a slot free.
@@ -2513,7 +2521,7 @@ __setup("console=", console_setup);
  * commonly to provide a default console (ie from PROM variables) when
  * the user has not supplied one.
  */
-int add_preferred_console(char *name, int idx, char *options)
+int add_preferred_console(char *name, const short idx, char *options)
 {
 	return __add_preferred_console(name, idx, options, NULL, false);
 }
-- 
2.42.0
