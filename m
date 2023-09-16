Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9517A3235
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjIPTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjIPTUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:20:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA48139
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:20:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694892014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNeRpVHG0OdM83PrKLG+UdCmA4Kb+afHXFf5PMIQJM4=;
        b=gCYaR4mw1DXja+pAMA92dMbugAw9SHgAKPc2kYUM25FN1CZEqzwusMNJr93nQiL6IeE0IX
        MoeeuVgNvWN0iRsq3Z5h+/zhpmrconWi966MoyDVIpwYKG0XXpmoDsaKm1W31N4PoZ2F79
        TX3fthiVRR3A4rodfrJv/MUQLCyEd0qUTTXr8BSxasGwrA6v4ccNh5f7P3HvVVJtVxxtk3
        +jE6MglwAlNMTlNtrhu8V3wYP9FjHUnEFpXOHXlsNfSWUlzDMXecPDFVe/aQKtkrDMIx/k
        cDNkPKKBX0Py7uschF8NXAo7uXZvJrOTd0NCFyZCQsYrwiXJ2XAeei1unhiNlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694892014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNeRpVHG0OdM83PrKLG+UdCmA4Kb+afHXFf5PMIQJM4=;
        b=S/EO2UAWeoajmNz66txZA9K2MtJwOo6svmZtAgn7nGmF20OaZmyszh/K/hi6gnIPn/fo+c
        8n825voFp3YN+vBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 3/8] printk: Make static printk buffers available to nbcon
Date:   Sat, 16 Sep 2023 21:26:02 +0206
Message-Id: <20230916192007.608398-4-john.ogness@linutronix.de>
In-Reply-To: <20230916192007.608398-1-john.ogness@linutronix.de>
References: <20230916192007.608398-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nbcon boot consoles also need printk buffers that are available
very early. Since the nbcon boot consoles will also be serialized
by the console_lock, they can use the same static printk buffers
that the legacy consoles are using.

Make the legacy static printk buffers available outside of printk.c
so they can be used by nbcon.c.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2ca0ab78802c..7199d60bfc25 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,6 +86,8 @@ static inline void nbcon_cleanup(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
 
+extern struct printk_buffers printk_shared_pbufs;
+
 /**
  * struct printk_buffers - Buffers to read/format/output printk messages.
  * @outbuf:	After formatting, contains text to output.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5f372eaceb29..17def3791bc0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2846,6 +2846,13 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	return true;
 }
 
+/*
+ * Used as the printk buffers for non-panic, serialized console printing.
+ * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
+ * Its usage requires the console_lock held.
+ */
+struct printk_buffers printk_shared_pbufs;
+
 /*
  * Print one record for the given console. The record printed is whatever
  * record is the next available record for the given console.
@@ -2863,12 +2870,10 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
  */
 static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
 {
-	static struct printk_buffers pbufs;
-
 	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
-	char *outbuf = &pbufs.outbuf[0];
+	char *outbuf = &printk_shared_pbufs.outbuf[0];
 	struct printk_message pmsg = {
-		.pbufs = &pbufs,
+		.pbufs = &printk_shared_pbufs,
 	};
 	unsigned long flags;
 
-- 
2.39.2

