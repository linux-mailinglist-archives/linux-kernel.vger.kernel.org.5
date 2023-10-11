Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4597C4CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjJKIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbjJKHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:43:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70330AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:43:49 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C181480E1;
        Wed, 11 Oct 2023 07:43:47 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 2/2] printk: Constify name for add_preferred_console()
Date:   Wed, 11 Oct 2023 10:43:26 +0300
Message-ID: <20231011074330.14487-2-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011074330.14487-1-tony@atomide.com>
References: <20231011074330.14487-1-tony@atomide.com>
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

Changes since v1:

- Updated to apply on the const short idx change

- Separated out of the serial core related patches, the serial core
  changes still need some more changes for preferred console usage

- Added Reviewed-by from Petr from the serial core thread

---
 include/linux/console.h | 2 +-
 kernel/printk/printk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
@@ -2520,7 +2520,7 @@ __setup("console=", console_setup);
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
