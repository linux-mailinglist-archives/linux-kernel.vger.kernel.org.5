Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4ED7A88FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjITPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjITPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:52:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032EA3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:52:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695225168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RiToQxeJYRNFsLus3AGdgJigY3Zsm0XtXndlOR433v4=;
        b=hZzpfqlTsGHjMNsLOX11qxft14ghonOKPS1ASHK8MOZj6Bm0N9bAaZk2ilWQUMjItJnZSm
        lDM469p5C5RFvqdm011M7zqGR4Pid/NL0cam5zUndBgaKCRog6yjVgzHxAxbagOqGTDinB
        RPZSaphBXR/+OZf5TQ4b9yflgMcwu5nn42Sog8G0wq00hla2Roe50cImPXnKlyw/t5pIB5
        h10gxIxOhEO/FQMiFbJyTcOzaf64NkcWd84MhHnNgx6toryXeifWolyTI6YzD/Hr1lNhsS
        sVi1kdQdWZg1cXQE9YOMfjGX1CRjksnBlxnyl98C6dEGndeoeLPzTXmdHm2RmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695225168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RiToQxeJYRNFsLus3AGdgJigY3Zsm0XtXndlOR433v4=;
        b=k0iGd7BEEgYfQcGIWKBPEk5kEL/c2Gn/pBCPkAac0tfEGQtX1ExB1839tn2JuSGH0d29Yn
        2Yl7QRdupNP7ajAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH printk v1] printk: fix illegal pbufs access for !CONFIG_PRINTK
Date:   Wed, 20 Sep 2023 17:58:38 +0206
Message-Id: <20230920155238.670439-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PRINTK is not set, PRINTK_MESSAGE_MAX is 0. This
leads to a zero-sized array @outbuf in @printk_shared_pbufs. In
console_flush_all() a pointer to the first element of the array
is assigned with:

   char *outbuf = &printk_shared_pbufs.outbuf[0];

For !CONFIG_PRINTK this leads to a compiler warning:

   warning: array subscript 0 is outside array bounds of
   'char[0]' [-Warray-bounds]

This is not really dangerous because printk_get_next_message()
always returns false for !CONFIG_PRINTK, which leads to @outbuf
never being used. However, it makes no sense to even compile
these functions for !CONFIG_PRINTK.

Extend the existing '#ifdef CONFIG_PRINTK' block to contain
the formatting and emitting functions since these have no
purpose in !CONFIG_PRINTK. This also allows removing several
more !CONFIG_PRINTK dummies as well as moving
@suppress_panic_printk into a CONFIG_PRINTK block.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309201724.M9BMAQIh-lkp@intel.com/
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 44 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 778359b21761..7f40d9122caa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -102,12 +102,6 @@ DEFINE_STATIC_SRCU(console_srcu);
  */
 int __read_mostly suppress_printk;
 
-/*
- * During panic, heavy printk by other CPUs can delay the
- * panic and risk deadlock on console resources.
- */
-static int __read_mostly suppress_panic_printk;
-
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -445,6 +439,12 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
+/*
+ * During panic, heavy printk by other CPUs can delay the
+ * panic and risk deadlock on console resources.
+ */
+static int __read_mostly suppress_panic_printk;
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -2346,22 +2346,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static size_t record_print_text(const struct printk_record *r,
-				bool syslog, bool time)
-{
-	return 0;
-}
-static ssize_t info_print_ext_header(char *buf, size_t size,
-				     struct printk_info *info)
-{
-	return 0;
-}
-static ssize_t msg_print_ext_body(char *buf, size_t size,
-				  char *text, size_t text_len,
-				  struct dev_printk_info *dev_info) { return 0; }
-static void console_lock_spinning_enable(void) { }
-static int console_lock_spinning_disable_and_check(int cookie) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
@@ -2715,6 +2699,8 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+#ifdef CONFIG_PRINTK
+
 /*
  * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
  * is achieved by shifting the existing message over and inserting the dropped
@@ -2729,7 +2715,6 @@ static void __console_unlock(void)
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-#ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
@@ -2761,9 +2746,6 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 	memcpy(outbuf, scratchbuf, len);
 	pmsg->outbuf_len += len;
 }
-#else
-#define console_prepend_dropped(pmsg, dropped)
-#endif /* CONFIG_PRINTK */
 
 /*
  * Read and format the specified record (or a later record if the specified
@@ -2921,6 +2903,16 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	return true;
 }
 
+#else
+
+static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
+{
+	*handover = false;
+	return false;
+}
+
+#endif /* CONFIG_PRINTK */
+
 /*
  * Print out all remaining records to all consoles.
  *

base-commit: 9757acd0a700ba4a0d16dde4ba820eb052aba1a7
-- 
2.39.2

