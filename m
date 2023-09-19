Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892707A6F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjISXJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjISXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691EC0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6s92XPeyfqns55O5jTkIEvWDYrDl5XhKnlZmE2CK28=;
        b=TCq9eqDsqo0un0UaFjxqttMu3RMPLZSB9CkxIOG/WIB5Drk8kKi0ikcoiJBqHLTUpifdkI
        y6bgwn/oAdNbCUmZeKACu8985q0G8FXdjbEPDHBMXyYlTEv/dfjTI6kenyvqJ25pObxl+z
        ZRhSg/3Oo4GQaK8ri+kjLy8s6eKaDfP62yATQQfw4Bu2M4HbBRBuf57R/9qqClcRQI6RdP
        6mZ1xACNUaiyDBNWBez3re4R6fjn3lMgh8pgaeSVMvvgXbLY2j5mE8EmZqPJMp39wcY1yK
        XqT55KfMlDR8MWRSmdJH0EPGk9ZIcqKFZVPOAZOavzohrwPsIW4BwiaJfF5Oug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6s92XPeyfqns55O5jTkIEvWDYrDl5XhKnlZmE2CK28=;
        b=aJOnXX1y9yMgTN5DhG/zR/7w8B9ntRqWNcINCTcBXeIXy2+O++8ZkJliBJGSN9OC6I+Edo
        trSa+VAvG/mokAAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 01/11] printk: Make console_is_usable() available to nbcon
Date:   Wed, 20 Sep 2023 01:14:46 +0206
Message-Id: <20230919230856.661435-2-john.ogness@linutronix.de>
In-Reply-To: <20230919230856.661435-1-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move console_is_usable() as-is into internal.h so that it can
be used by nbcon printing functions as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 32 ++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 30 ------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..6e8c1b02adae 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -78,6 +78,36 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_srcu_read_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	short flags = console_srcu_read_flags(con);
+
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -99,6 +129,8 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
+static inline bool console_is_usable(struct console *con) { return false; }
+
 #endif /* CONFIG_PRINTK */
 
 extern struct printk_buffers printk_shared_pbufs;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 778359b21761..b6cfae75a574 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2679,36 +2679,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
- */
-static inline bool console_is_usable(struct console *con)
-{
-	short flags = console_srcu_read_flags(con);
-
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (!con->write)
-		return false;
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 static void __console_unlock(void)
 {
 	console_locked = 0;
-- 
2.39.2

