Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3697DB614
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjJ3JYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJ3JYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:24:48 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E7C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=f71kb40JMN6BLPnCWSZ1cPNxqIlMRwG76WxcbNmWQb8=; b=ZDWVUwZpgNaxZALcQS9fYTrhhn
        ZIGKXEgQeG0VehZP4nhtqTCz8NBOOWMF70lRJwpiFdqcICzQ1Dr/WyJh4ZI9zJ7b/CCCQSvZS8+Cj
        a7qmGCVnz0WRe8kRs5gbcyz80XffaOBuWhqTt/ZDkroAvbZkWqkn/VqTXwGkofgaiXWlmKgv3Qtu2
        iRldNdZ/wsJoMQLnjtymwXjiwjsih9Zvf2OHn1Kp5CTjhaEy4SgxjiHdBLiK+vbq6Uf12o+atxOcM
        KMNqFA2VQP20kDHxxSZ0RgU+i5i6vjNYYBvZdWZbmkp0vp5fnG6KS1lFTBk0wE/QsGuSGD7NWk5L7
        fPxkC4Sw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qxOVn-000GoV-GG; Mon, 30 Oct 2023 10:24:43 +0100
Received: from [185.17.218.86] (helo=rap..)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qxOVn-000DPP-4A; Mon, 30 Oct 2023 10:24:43 +0100
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/2] printk: export pr_flush()
Date:   Mon, 30 Oct 2023 10:24:31 +0100
Message-ID: <20231030092432.3434623-1-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27077/Mon Oct 30 08:39:55 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printk users might want to assure whatever printed has reached its
destination before continuing. E.g. during the shutdown-procedure, where
printk-buffers aren't necessarily emptied before the system goes down.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 include/linux/printk.h | 5 +++++
 kernel/printk/printk.c | 4 +---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..a2a33494c222 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +272,10 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b3af1529778..dc1d2c880eb0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2336,7 +2336,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2365,7 +2364,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(int cookie) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -3813,7 +3811,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
-- 
2.42.0

