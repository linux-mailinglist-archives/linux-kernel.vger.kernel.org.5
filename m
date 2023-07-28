Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCB766079
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjG1ADB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjG1ACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E0170D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb4IARB7ZGs0NFGdahNKOcVuwqCsWQdgRW9ky2NkqP0=;
        b=bHC60CvVn0k5V/Ob2wGVruqaoijuC5OhwuGq8OdO28M1v7kmYBNC5Pcqlj112Tv329px04
        xoOv0JbDAZi0d03qVzIOkCpF4WQqlZHC5grMzu3eSIEdETyqjHzI4FFpNF4tAECymfMoU/
        1prM90FTfK0afeyH9Y3/MWGPlJWUQ8RpEzLBEje2JR+Dgnci+X/hzJ6zRCI7/1JSuJ7MnM
        gQS9e8ch2R/Fu0sDtea01twbCChPWz4ci6k472ezTOlD3l01I+CjNir1j30oIDTNLEtWJe
        N8uEgfZ9p79D7fCuV51NoJidOWaApXHLw0GmUz/EpfFxkjiqifa9L1ptEHhEbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb4IARB7ZGs0NFGdahNKOcVuwqCsWQdgRW9ky2NkqP0=;
        b=OClN8Ozq+PUpq9KrNWc9iSN08LxWbFx7BcujZAphNTRhSaICw0IwD2aaHDjeSPsnVeuht6
        4AgtmvM4HAAqv/CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 8/8] printk: nbcon: Add functions for drivers to mark unsafe regions
Date:   Fri, 28 Jul 2023 02:08:33 +0206
Message-Id: <20230728000233.50887-9-john.ogness@linutronix.de>
In-Reply-To: <20230728000233.50887-1-john.ogness@linutronix.de>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For the write_atomic callback, the console driver may have unsafe
regions that need to be appropriately marked. Provide functions
that accept the nbcon_write_context struct to allow for the driver
to enter and exit unsafe regions.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |  4 ++++
 kernel/printk/printk_nbcon.c | 41 +++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3d129b2b70a1..e4ce1015627c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -456,8 +456,12 @@ static inline bool console_is_registered(const struct console *con)
 
 #ifdef CONFIG_PRINTK
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
+extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
+extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
+static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index e1f0e4278ffa..57b7539bbbb2 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
@@ -761,7 +761,6 @@ EXPORT_SYMBOL_GPL(nbcon_can_proceed);
  *
  * Internal helper to avoid duplicated code
  */
-__maybe_unused
 static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
 {
 	struct console *con = ctxt->console;
@@ -787,6 +786,46 @@ static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
 	return true;
 }
 
+/**
+ * nbcon_enter_unsafe - Enter an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if the state is correct. False if ownership was
+ *		handed over or taken.
+ *
+ * When this function returns false then the calling context is no longer
+ * the owner and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ */
+bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	return nbcon_context_update_unsafe(ctxt, true);
+}
+EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
+
+/**
+ * nbcon_exit_unsafe - Exit an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if the state is correct. False if ownership was
+ *		handed over or taken.
+ *
+ * When this function returns false then the calling context is no longer
+ * the owner and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ */
+bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	return nbcon_context_update_unsafe(ctxt, false);
+}
+EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
-- 
2.39.2

