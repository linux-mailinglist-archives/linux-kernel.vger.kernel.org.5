Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468E7E2EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjKFVIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjKFVHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50586D76
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxMWmZFtd/CI8sGJ7jbK846Sk0z3M0dHtiMNHUYVwDo=;
        b=F0nq+NlshhqBwgbmYAQfswiQz1RQAekjo/Mj/fxavpN1DopPZNz/2sjwVY+hqrvI9r1JCk
        +np2lvriNUf+PawEEI0BpgJmRpqxTGFldaw4+HdZPFHLhiHrDWaTn5xvr2xFwzcQEDTwoc
        AhNz/uO0JWi24Ms1qCAp8bkn7Yl/c/yP03rOGNVJBJmPsRd4p2OlE3PMzswZ7Rytz0NUSK
        m9hQGkFvrCwZ5WjTMjKd/4QOpmp27u8ZRmWAd9B58+vu0oWwSVpu8BzFTf1SuOYyJpTTgN
        eC4c4BiDYXkfrY+d3N97JKLFSxcEbi3MtJ8izxxdpix+zVUHLZfPI2btd3eUDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxMWmZFtd/CI8sGJ7jbK846Sk0z3M0dHtiMNHUYVwDo=;
        b=iIknmtgfSg2FSpw6KP51q6sFYxkf9/F1c/JoIp+Uru1hpwxLGCMX8xzDQ6iLDQTjOTKDJu
        ciQ+0OUj30ky+6CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 9/9] printk: Avoid non-panic CPUs flooding ringbuffer
Date:   Mon,  6 Nov 2023 22:13:30 +0106
Message-Id: <20231106210730.115192-10-john.ogness@linutronix.de>
In-Reply-To: <20231106210730.115192-1-john.ogness@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 13fb0f74d702 ("printk: Avoid livelock with heavy printk
during panic") introduced a mechanism to silence non-panic CPUs
if too many messages are being dropped. Aside from trying to
workaround the livelock bugs of legacy consoles, it was also
intended to avoid losing panic messages. However, if non-panic
CPUs are flooding the ringbuffer, then reacting to dropped
messages is too late.

To avoid losing panic CPU messages, the tracking needs to occur
when non-panic CPUs are storing messages. If non-panic CPUs have
filled approximately 1/4 the ringbuffer, they need to be
silenced to ensure the ringbuffer has ample space available for
the panic CPU messages.

Rather than trying to come up with an accurate heuristic to
measure the size used by non-panic CPUs, simply restrict them
to 1/4 the possible ringbuffer descriptors. In practice this
will end up being around 1/3 the ringbuffer size, which still
leaves ample space for the panic CPU messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cb99c854a648..9ac7d50c2f18 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2315,6 +2315,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
+	static atomic_t panic_noise_count = ATOMIC_INIT(0);
+
 	int printed_len;
 	bool in_sched = false;
 
@@ -2322,8 +2324,22 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
-		return 0;
+	if (other_cpu_in_panic()) {
+		if (unlikely(suppress_panic_printk))
+			return 0;
+
+		/*
+		 * The messages on the panic CPU are the most important. If
+		 * non-panic CPUs are generating many messages, the panic
+		 * messages could get lost. Limit the number of non-panic
+		 * messages to approximately 1/4 of the ringbuffer.
+		 */
+		if (atomic_inc_return_relaxed(&panic_noise_count) >
+		    (1 << (prb->desc_ring.count_bits - 2))) {
+			suppress_panic_printk = 1;
+			return 0;
+		}
+	}
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
@@ -2799,8 +2815,6 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_suppress)
 {
-	static int panic_console_dropped;
-
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2828,17 +2842,6 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 
-	/*
-	 * Check for dropped messages in panic here so that printk
-	 * suppression can occur as early as possible if necessary.
-	 */
-	if (pmsg->dropped &&
-	    panic_in_progress() &&
-	    panic_console_dropped++ > 10) {
-		suppress_panic_printk = 1;
-		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
-	}
-
 	/* Skip record that has level above the console loglevel. */
 	if (may_suppress && suppress_message_printing(r.info->level))
 		goto out;
-- 
2.39.2

