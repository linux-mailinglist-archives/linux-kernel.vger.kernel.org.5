Return-Path: <linux-kernel+bounces-124500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170D8918F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F7D1C24778
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626313F45A;
	Fri, 29 Mar 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1Dms+NB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387C13F43E;
	Fri, 29 Mar 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715245; cv=none; b=mnMk7EpICEVwnOfh0LbBDZ1bewudtZixHugDXUcOJQm6Xms6HyEFXROSxjbRwzZlY4NUUyDKy6HC0X/5xC+j8IPj9IpSrM/Su5AaUiWmcSZBbQ8XnbyQUtASliK4s353YZvuc9j7UUxCMS06zFZfizQxwm6ZQY1iEkkxFWElYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715245; c=relaxed/simple;
	bh=qH4wBsJJjj8SlxCCkzXzWl5dgUByJwVQ9Ltc3P2cF8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYfdpfcUo7zhl63y4ZHr7j88FIKASaVfmX+tEGWxPSERJgSDXbzFZX3BqzVl1S7uRgK+ghRr4fEzDw2XYnWvvWImIuuq2qAZy/UXPafck/U5yvOaSlkK1dWVnQyBuxbrZqW2TKe/AKvJ2PQXl3yBJKhydwfQbZaFrsB/AmFfVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1Dms+NB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA2CC433C7;
	Fri, 29 Mar 2024 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715244;
	bh=qH4wBsJJjj8SlxCCkzXzWl5dgUByJwVQ9Ltc3P2cF8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1Dms+NBNx1bEWOHhXp6ltUiV6dYRV+0HHYYSp3gSUX+40S8wnG905uFUnqej5dLw
	 58CIyo5NibgK9mqqt5VTU8lSDVsCYQppOlsWmPNwkJdZjEe9wCZPJ715qFgp+QfLbS
	 1DtlzUn7oaLFQAZ5IM0cb6Ay6BdKzRr51p0UtrYpPo4O9/UK4fyWdk0w5cynZqc9Bf
	 wjMCEZ81uRaeOAhK/MLY3eU15uipNrldw2ZrbCG7N6ho34cSJ5W9cg8EP6V+NKtXFJ
	 MYLXmVhSMQq61ez5je1oiqPW2eTAdFmBJvSDxtr8k+VRklHWw3AanRSYqf4ydlec8+
	 OlYEZ4IZyYSxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 19/68] printk: Avoid non-panic CPUs writing to ringbuffer
Date: Fri, 29 Mar 2024 08:25:15 -0400
Message-ID: <20240329122652.3082296-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 779dbc2e78d746250f07c463e13ac603b349f6f3 ]

Commit 13fb0f74d702 ("printk: Avoid livelock with heavy printk
during panic") introduced a mechanism to silence non-panic CPUs
if too many messages are being dropped. Aside from trying to
workaround the livelock bugs of legacy consoles, it was also
intended to avoid losing panic messages. However, if non-panic
CPUs are writing to the ringbuffer, then reacting to dropped
messages is too late.

Another motivation is that non-finalized messages already might
be skipped in panic(). In other words, random messages from
non-panic CPUs might already get lost. It is better to ignore
all to avoid confusion.

To avoid losing panic CPU messages, silence non-panic CPUs
immediately on panic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-13-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 742fb479b1d60..336c092632f4e 100644
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
@@ -2293,7 +2287,12 @@ asmlinkage int vprintk_emit(int facility, int level,
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
@@ -2778,8 +2777,6 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_suppress)
 {
-	static int panic_console_dropped;
-
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2807,17 +2804,6 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
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
2.43.0


