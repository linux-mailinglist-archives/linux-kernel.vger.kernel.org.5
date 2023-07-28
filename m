Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C2766074
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjG1ACn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjG1ACl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2F30FA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aN/PZD88PlKxnnAWKpPNKfderKHCjvFqWgQcXb3T0GI=;
        b=JdVIc2tnGLddF4guSyv+W1fRWkdVCzJxI3lOUsfk5IO3LFAb/v2SVjWVzw7JGpk4hkEbgR
        YMxEkV4bEiy2n9gKVKEyALgwLEEjaI6ldWVsfX/vp0OMn44s5uXmlukHcvmimI0yAIw+JN
        wyXxDa8PwCD5Nie2M85cJLQ9EavtaAVrCxMjQXd6z3k+LOP0EcA8r38BlZVecCk60uKxJu
        6jJMiLjQNV1T9gGOSbzoT+wQEh4bJe+6h08Z9lqMp0Os/+nHuH6C4Iz3rvbasLuHnE8Tnv
        oa3GZq8kiwOoaBRWMtQzYqbYq8V1Fcumb29YD8y1mIPed5oUcZxma6SUZz4nJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aN/PZD88PlKxnnAWKpPNKfderKHCjvFqWgQcXb3T0GI=;
        b=zyrFz+NafiJs7zKAN8tZTy+t4GuTNq+lbyyRYH2GMWuzRAMbvkORDmdJiXI2PriwTnEa1z
        zyqU+VlP3PRz4yBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 2/8] printk: Provide debug_store() for nbcon debugging
Date:   Fri, 28 Jul 2023 02:08:27 +0206
Message-Id: <20230728000233.50887-3-john.ogness@linutronix.de>
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

To debug and validate nbcon ownership transitions, provide a new
macro debug_store() (enabled with DEBUG_NBCON) to log transition
information to the ringbuffer. If enabled, this macro only logs
to the ringbuffer and does not trigger any printing. This is to
avoid triggering recursive printing in the nbcon consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_nbcon.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index bb379a4f6263..f9462b088439 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
@@ -10,6 +10,35 @@
  * the legacy style console_lock mechanism.
  */
 
+/*
+ * Define DEBUG_NBCON to allow for nbcon ownership transitions to be logged
+ * to the ringbuffer. The debug_store() macro only logs to the lockless
+ * ringbuffer and does not trigger any printing.
+ */
+#undef DEBUG_NBCON
+
+#ifdef DEBUG_NBCON
+/* Only write to ringbuffer. */
+int __debug_store(const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vprintk_store(2, 7, NULL, fmt, args);
+	va_end(args);
+
+	return r;
+}
+#define debug_store(cond, fmt, ...)						\
+	do {									\
+		if (cond)							\
+			__debug_store(pr_fmt("DEBUG: " fmt), ##__VA_ARGS__)	\
+	} while (0)
+#else
+#define debug_store(cond, fmt, ...)
+#endif
+
 /**
  * nbcon_state_set - Helper function to set the console state
  * @con:	Console to update
-- 
2.39.2

