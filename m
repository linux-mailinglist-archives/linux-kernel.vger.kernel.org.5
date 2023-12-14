Return-Path: <linux-kernel+bounces-157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB1813CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088561C21D38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A203C7947E;
	Thu, 14 Dec 2023 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yErQmSVa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDrnk0pC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54866E58B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oXCn644qxpD8FMpAqd87EWn4tyrdJdGrCu1+KrDVIM=;
	b=yErQmSVaMfHU6Ut0SEf2M9UrFhXD9j0kjQV3rjWR+rqsZaRuPnqIGH+/+FYhiB7Htqqb29
	yxaTR7aEz/PPEAxvz2mSUJvMHkZGYz8RpgI4rAcnaUowr3ErKV0ABZpqnGVn7dz6R7zShG
	fqGLTasMEoAFZm7wtYSBs+AFqqs3nSn1KR8FnPxDNIY+vNTVBoMEFc1R5swNBo7n6TrQa1
	MV86Wenak/8A6p4+FLFqBC8T3JbzuLCYF1MjRQDb0Z/zk8QBH3vkCOm3Ak7C+Q2M4kK9hj
	6AYcNCsjG+jnCZ9RzJBFI5+EhKjf2YMkl3Gdf6N5KBS9d+HS8zrSZZ2FjXk0WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oXCn644qxpD8FMpAqd87EWn4tyrdJdGrCu1+KrDVIM=;
	b=dDrnk0pCjG5yxf/tj6SXs8Ji2aYRRfbnhY4f4NyzYMRs3Z1mUilD+Qi2DKWl2C+h99oUHp
	Y9t649zENTvgbxBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v3 14/14] panic: Flush kernel log buffer at the end
Date: Thu, 14 Dec 2023 22:48:01 +0106
Message-Id: <20231214214201.499426-15-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the kernel crashes in a context where printk() calls always
defer printing (such as in NMI or inside a printk_safe section)
then the final panic messages will be deferred to irq_work. But
if irq_work is not available, the messages will not get printed
unless explicitly flushed. The result is that the final
"end Kernel panic" banner does not get printed.

Add one final flush after the last printk() call to make sure
the final panic messages make it out as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/panic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2807639aab51..f22d8f33ea14 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -446,6 +446,14 @@ void panic(const char *fmt, ...)
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
+
+	/*
+	 * The final messages may not have been printed if in a context that
+	 * defers printing (such as NMI) and irq_work is not available.
+	 * Explicitly flush the kernel log buffer one last time.
+	 */
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
-- 
2.39.2


