Return-Path: <linux-kernel+bounces-124563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46318919F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A191F26173
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B39153577;
	Fri, 29 Mar 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1cPeZwK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C04153507;
	Fri, 29 Mar 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715415; cv=none; b=GgJc+3SnBqEfBvbcWHytHPXaW5sjrR8SME+WG6JcyDJbhLuB3KV1lU4Dv9bSWtxOHqOqB0Ea7p+47ZUMRjFt8+MkmkNSeshMmrMflEfOOUAEGZwz9S1Wj769WEiXhEqw3WwprD4YdybGMNxhXAcY1AknIFC4EDZ1rJEjroikubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715415; c=relaxed/simple;
	bh=ghWvWuRyBoA+ffzSyeviljL2BGDxZHcPUQhtXe9HSw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN5bWQRe7lMOlSh70nciP3/xwdVLa2B57AmBDpk2T/VEenlcd7CJF02hPTn2MrBBUaH3aHubra/1PaR6YWt2SdgZbgj1zHKdA/DxAfZv9s7EYlxsXfyv6yt8uQ053iBbIwY0Wu+2xBKslfrP8RK0orgXCDQNjqPRnHJijGk4qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1cPeZwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828B3C43390;
	Fri, 29 Mar 2024 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715415;
	bh=ghWvWuRyBoA+ffzSyeviljL2BGDxZHcPUQhtXe9HSw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1cPeZwKtHKuYMdyDU6g14KMiMgGhWTkjWgZuULGO+j2VVyWexiSJisc2nb7g31YJ
	 Thg9GO36HoJ7P+iHtOnpfz6s0VNxQNJWKCcBk0ybLf37tstvE8rEwFrhNSXIrSC0e3
	 LfH2kld9akKRHChEXQRNxIbYJvC3d/mhPtxqS/HiD69i3mM281RP1D3w1xXvc9BpYz
	 aQR7l+XOJPZPpxF3HNhTxTTvzkH1giRKDHV8fI6m3110mZNsQ1Qq3rdLkb5yZ2XY7l
	 Vjyxj+FDvXTwPWbuPmuv6NIGfC8Su2ZfFjNKKB72CAFeFEgxoXQbIn/6CIFFhC6oJ4
	 SKwQH4clKJRKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 12/52] printk: Avoid non-panic CPUs writing to ringbuffer
Date: Fri, 29 Mar 2024 08:28:42 -0400
Message-ID: <20240329122956.3083859-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
 kernel/printk/printk.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9ca10507f7c47..713c14843609c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2274,7 +2274,12 @@ asmlinkage int vprintk_emit(int facility, int level,
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
@@ -2789,8 +2794,6 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
 static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 				    bool is_extended, bool may_suppress)
 {
-	static int panic_console_dropped;
-
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2818,17 +2821,6 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
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


