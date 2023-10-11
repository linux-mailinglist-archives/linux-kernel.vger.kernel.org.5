Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868D27C4CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjJKHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjJKHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:43:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B48DE9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:43:43 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6203480E1;
        Wed, 11 Oct 2023 07:43:42 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] printk: Check valid console index for preferred console
Date:   Wed, 11 Oct 2023 10:43:25 +0300
Message-ID: <20231011074330.14487-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check for valid console index values to avoid bogus console index
numbers from kernel command line. While struct console uses short for
index, and negative index values are used by some device drivers, we do
not want to allow negative values for preferred console.

Let's change the idx to short to match struct console, and return an error
on negative values. And let's also constify idx while at it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:

- Use const short idx and return an error on negative values

---
 include/linux/console.h |  2 +-
 kernel/printk/printk.c  | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

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
@@ -2404,12 +2404,19 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
-static int __add_preferred_console(char *name, int idx, char *options,
+static int __add_preferred_console(const char *name, const short idx, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
 
+	/*
+	 * Negative struct console index may be valid for drivers in some cases,
+	 * but negative index is not valid for a preferred console.
+	 */
+	if (idx < 0)
+		return -EINVAL;
+
 	/*
 	 *	See if this tty is not yet registered, and
 	 *	if we have a slot free.
@@ -2513,7 +2520,7 @@ __setup("console=", console_setup);
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
