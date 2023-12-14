Return-Path: <linux-kernel+bounces-156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D42F813CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BAA281936
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A279481;
	Thu, 14 Dec 2023 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IczEGKqF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZ/nLN6F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1496E58E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4rvWoxnqgzEuAgNoYI/eGkAegsSWbGumqPznFMqF+U=;
	b=IczEGKqFD1oy+Qg8z9W3ASm1EtJPsy0YWe3mtabbGGlNNi+1YViu93FrmJd/s0YY/mjwVv
	IbjcDUoXwTMgDkjFvNEIMdAs3d2wRqq22t6BgChFhGJ/ipARopaROpvgZbQQiFta1P8oJ3
	86G1akAsb0XQkl/xgOrcdboEkLI2tqDe+uIrsXsYhlxxKS+ThW6/LpoDksG4VC/MqlZeMW
	lUvFe1M6o66t4WVMSlikkgtaooz6ztl0xuVce+klfEvFeuvHqjDK68JtT5J63BuDEKsDO1
	KeC3A2M09eVmkhhXjlCuT9ICK97N/q7lGJ4YzNcUFyHFIQPCKx9EIv1XvRbakA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4rvWoxnqgzEuAgNoYI/eGkAegsSWbGumqPznFMqF+U=;
	b=EZ/nLN6FZnFW+QHK6HtPkCdu30khYWm1kLAFdRJgMDfIsfceHUVNIecPc9cscZ9BaccODt
	phCyLhtqdyFnt1Ag==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 13/14] printk: Avoid non-panic CPUs writing to ringbuffer
Date: Thu, 14 Dec 2023 22:48:00 +0106
Message-Id: <20231214214201.499426-14-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 13fb0f74d702 ("printk: Avoid livelock with heavy printk
during panic") introduced a mechanism to silence non-panic CPUs
if too many messages are being dropped. Aside from trying to
workaround the livelock bugs of legacy consoles, it was also
intended to avoid losing panic messages. However, if non-panic
CPUs are writing to the ringbuffer, then reacting to dropped
messages is too late.

To avoid losing panic CPU messages, silence non-panic CPUs
immediately on panic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cb99c854a648..1685a71f3f71 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -462,12 +462,6 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
-/*
- * During panic, heavy printk by other CPUs can delay the
- * panic and risk deadlock on console resources.
- */
-static int __read_mostly suppress_panic_printk;
-
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -2322,7 +2316,12 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
+	/*
+	 * The messages on the panic CPU are the most important. If
+	 * non-panic CPUs are generating any messages, they will be
+	 * silently dropped.
+	 */
+	if (other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
@@ -2799,8 +2798,6 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_suppress)
 {
-	static int panic_console_dropped;
-
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2828,17 +2825,6 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
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


