Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76E7C65C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbjJLGnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbjJLGnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:43:11 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D36CFBE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:43:09 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 44A428107;
        Thu, 12 Oct 2023 06:43:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] printk: Constify name for add_preferred_console()
Date:   Thu, 12 Oct 2023 09:42:57 +0300
Message-ID: <20231012064300.50221-2-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012064300.50221-1-tony@atomide.com>
References: <20231012064300.50221-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While adding a preferred console handling for serial_core for serial port
hardware based device addressing, Jiri suggested we constify name for
add_preferred_console(). The name gets copied anyways. This allows serial
core to add a preferred console using serial drv->dev_name without copying
it.

Note that constifying options causes changes all over the place because of
struct console for match().

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v2:

- Rebase after fixing patch 1/2 the const char *name mismerge

Changes since v1:

- Updated to apply on the const short idx change

- Separated out of the serial core related patches, the serial core
  changes still need some more changes for preferred console usage

- Added Reviewed-by from Petr from the serial core thread

---
 include/linux/console.h | 2 +-
 kernel/printk/printk.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -340,7 +340,7 @@ enum con_flush_mode {
 	CONSOLE_REPLAY_ALL,
 };
 
-extern int add_preferred_console(char *name, const short idx, char *options);
+extern int add_preferred_console(const char *name, const short idx, char *options);
 extern void console_force_preferred_locked(struct console *con);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2404,7 +2404,7 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
-static int __add_preferred_console(char *name, const short idx, char *options,
+static int __add_preferred_console(const char *name, const short idx, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
@@ -2521,7 +2521,7 @@ __setup("console=", console_setup);
  * commonly to provide a default console (ie from PROM variables) when
  * the user has not supplied one.
  */
-int add_preferred_console(char *name, const short idx, char *options)
+int add_preferred_console(const char *name, const short idx, char *options)
 {
 	return __add_preferred_console(name, idx, options, NULL, false);
 }
-- 
2.42.0
