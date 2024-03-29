Return-Path: <linux-kernel+bounces-124823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77AC891CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E181F26142
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BC1B04BD;
	Fri, 29 Mar 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmY+Ms5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE261B04A7;
	Fri, 29 Mar 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716235; cv=none; b=BURatPvR/8OhDOtqQh7il45DRWcnkNKGYTKx4Fn+zV8iZxiM1o8tZGR25iS2J8OI1dzTQC1nmJjRC8AFxhbVDEx+yqaOJoozmBU8MRIzyH+4bOW5fQWX0LaMsKMOHLMnrvI11UUK+8GwEIN2Pz8aAlgzqk8l3/5aZFeaj3060oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716235; c=relaxed/simple;
	bh=ghWvWuRyBoA+ffzSyeviljL2BGDxZHcPUQhtXe9HSw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhWcMj24C1kad7XP7Zin4s+rM9TL9fX8YLYEOZ54bvJWIzASCP1Ow1PJgbR9ehiyPIb9Q54axq+BpxqJuhL8i5UHrzKIL4koAz9rkAlxLpaGaz9wBcncKfxSh+Z0owyRKloHUBQ8qaAPg3D91biz3nxwMwQBoVG0MgIiw6wreiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmY+Ms5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C898CC433C7;
	Fri, 29 Mar 2024 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716234;
	bh=ghWvWuRyBoA+ffzSyeviljL2BGDxZHcPUQhtXe9HSw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmY+Ms5NM5C657IDXkRk2gjLSOLtSCG7DhMUiPjtryfBkP2s1JX30dlkmaueOd+Um
	 MazlmRjYUBGD+2HGukIos6xB0bFODxel0yiWts6VUzhHkIPlunKOQUjaDBxq2yDf3F
	 oFq1AWGd2AmH7tkA2Wbx7gelEk+A1uQUR1ZpWunAgMb/5myGw56RXIrceZTwkXwQVx
	 V1ZYfgFdNFxCtSTTBY8HSBsOePmaNuflzygdMrTOKYr8j90Pt5neVMYONVv9qMbtOJ
	 251itTByKfK2C4JPsR42VB5gxc3NTfuaDbeoPAiwyNHn8tRw6mWYO6O/g2zW2lgt2C
	 n1FOS4lFLSsIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 14/75] printk: Avoid non-panic CPUs writing to ringbuffer
Date: Fri, 29 Mar 2024 08:41:55 -0400
Message-ID: <20240329124330.3089520-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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


