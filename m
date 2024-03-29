Return-Path: <linux-kernel+bounces-124502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C208918F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80551F2185A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39D140396;
	Fri, 29 Mar 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbpyCQEQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A37140362;
	Fri, 29 Mar 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715248; cv=none; b=lVzNtN/7GPClbMGL5mtau53LALydJp+Wnhr25FqOZxbNepmcBTXLmd0DVNEf/m3RpENTaW/4R2rPnHDaFJ1Ucyg+yOouuAMN4/EojxOCHaeBxn/mo/srKkLMhTsgYq+f4hAwrJ3DJk0Vsv752AiwIECQ7OwAANM5/637eCDIiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715248; c=relaxed/simple;
	bh=OAeN0QcaQFWpAB8YgvTAPxvKI+ywGWLbU1SWwuh4gww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMHAS21HFkNjk8TWYgTdKAWq4j3xJ+koURozotGSy85Ynde6e1lpjd9WCg6qcDE3r8JNafYwA96hUGFN6ieCU1081sXsB19gtsgsmlmUrZoJ309LTn1yhoDMXYt6vn7w3JaOcak1MvFEvrfMyNUzCPOPKnsLZEo1WXzQMUiVd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbpyCQEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3CFC433C7;
	Fri, 29 Mar 2024 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715248;
	bh=OAeN0QcaQFWpAB8YgvTAPxvKI+ywGWLbU1SWwuh4gww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbpyCQEQonor39Zwn6Mwinxb3SEYgDg5VRwnO8R3NWMp2mTvF/K+adSCHzDPoB3pO
	 FCE5IP+MBI6oVj1n0NDIkyt1s5mc/nUvjHAcycj0A5aIGK8vKqLasHfGk+DyXdfJBe
	 CpwZc6x5nvqUkDy6JYLSJ3JTnjI+Hcso1pYGVVH8Et0byCywIeSqNXc84T/s6Q+SLD
	 9F8UULcuVkCy17uEpUeSaSVeatJaXrhdVUnu37JXD9OpqVMbH6B0FbCnQai624aw0D
	 WB7kdBWmufId/lcHS807vYkuVLT2cSwk/uzhncZaKmjH77GQ3xXevwp6sNZvM7Gt6/
	 L0N9hLD1fvCUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 21/68] dump_stack: Do not get cpu_sync for panic CPU
Date: Fri, 29 Mar 2024 08:25:17 -0400
Message-ID: <20240329122652.3082296-21-sashal@kernel.org>
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

[ Upstream commit 7412dc6d55eed6b76180e40ac3601412ebde29bd ]

dump_stack() is called in panic(). If for some reason another CPU
is holding the printk_cpu_sync and is unable to release it, the
panic CPU will be unable to continue and print the stacktrace.

Since non-panic CPUs are not allowed to store new printk messages
anyway, there is no need to synchronize the stacktrace output in
a panic situation.

For the panic CPU, do not get the printk_cpu_sync because it is
not needed and avoids a potential deadlock scenario in panic().

Link: https://lore.kernel.org/lkml/ZcIGKU8sxti38Kok@alley
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-15-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/printk.h   |  2 ++
 kernel/printk/internal.h |  1 -
 lib/dump_stack.c         | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1ed..955e31860095e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -273,6 +273,8 @@ static inline void printk_trigger_flush(void)
 }
 #endif
 
+bool this_cpu_in_panic(void);
+
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ac2d9750e5f81..6c2afee5ef620 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,7 +130,6 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
-bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a7..222c6d6c8281a 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -96,15 +96,25 @@ static void __dump_stack(const char *log_lvl)
  */
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
+	bool in_panic = this_cpu_in_panic();
 	unsigned long flags;
 
 	/*
 	 * Permit this cpu to perform nested stack dumps while serialising
-	 * against other CPUs
+	 * against other CPUs, unless this CPU is in panic.
+	 *
+	 * When in panic, non-panic CPUs are not permitted to store new
+	 * printk messages so there is no need to synchronize the output.
+	 * This avoids potential deadlock in panic() if another CPU is
+	 * holding and unable to release the printk_cpu_sync.
 	 */
-	printk_cpu_sync_get_irqsave(flags);
+	if (!in_panic)
+		printk_cpu_sync_get_irqsave(flags);
+
 	__dump_stack(log_lvl);
-	printk_cpu_sync_put_irqrestore(flags);
+
+	if (!in_panic)
+		printk_cpu_sync_put_irqrestore(flags);
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
-- 
2.43.0


