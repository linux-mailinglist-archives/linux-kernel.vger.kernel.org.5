Return-Path: <linux-kernel+bounces-113664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28374889007
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6580AB37BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DF1DD2BC;
	Sun, 24 Mar 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLkkDB18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9A1442F7;
	Sun, 24 Mar 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320657; cv=none; b=slYdNtkZu05BM4Ii+VphTQVkt9PaylzntQzDqnhXjAD/RStFm5UXuFwaZMOwAdUKHmbbDdPyGDTYp+II8sfaARGuLbpw4WSkD+IfX0A59vONqDN27+40K7y8SDA/Ry0eUtjPX4lgLKxAI9qDOxl01qy+YuDYic/JqsOlHcaWWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320657; c=relaxed/simple;
	bh=weL9bKStwrCWZ03fP6/Vywm6N8qOPfvGjjZrxMDFsZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/gDzC1XnrfEmObpTZW0QY8qu2Ygud5TlKngrs95Bzo5lMwWEXK9O6/Ri4IZLmbhRe1Ruig/tuvDj1zk0aHUSXRhF6xO8FrZEykIK+11Hfq2ptJvhDAZVg4irffGvx/iUa3LKx29sd/S8CALiaBPPFWcwbFnaYXwbU5VaxwXILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLkkDB18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CE6C433F1;
	Sun, 24 Mar 2024 22:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320657;
	bh=weL9bKStwrCWZ03fP6/Vywm6N8qOPfvGjjZrxMDFsZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLkkDB18rD9KqXBpk6dFU7jEFe/bCXNvPCGo5f9Ml+NUEOVnDvH6n3WhYFqtooQ24
	 ZucsrfRj0z7zE6US2WuNyBDbPB0e506PqsGwAL3GDAdmdtNr5wusUilOGT7guBkhdM
	 yLM+F3B5TxUXJR7u8Oa6V7WBjLh+3k7JvoebiNC++hiQ55flJ13hcPV6ovvWRtpEdW
	 +lEt6kMFlj1CuX6BXVZV8P6fboE52FGjN19FUFoTsz5qcdBDxZFWI3qpbWkF96o0aY
	 XiVhS8YqxOtrI6zsBA+H57u0iPxiBm4LS3bAKOwji2ZUdbox5kXyDEtqr4lq+fc5Ng
	 wTh9ZFl+U12ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 219/713] printk: Add this_cpu_in_panic()
Date: Sun, 24 Mar 2024 18:39:05 -0400
Message-ID: <20240324224720.1345309-220-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 36652d0f3bf34899e82d31a5fa9e2bdd02fd6381 ]

There is already panic_in_progress() and other_cpu_in_panic(),
but checking if the current CPU is the panic CPU must still be
open coded.

Add this_cpu_in_panic() to complete the set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-8-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Stable-dep-of: b1c4c67a5e90 ("printk: ringbuffer: Skip non-finalized records in panic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/internal.h |  1 +
 kernel/printk/printk.c   | 43 +++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef620..ac2d9750e5f81 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,6 +130,7 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d9420207282ac..b7e50f8438df3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -347,6 +347,29 @@ static bool panic_in_progress(void)
 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
 }
 
+/* Return true if a panic is in progress on the current CPU. */
+bool this_cpu_in_panic(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
+}
+
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool other_cpu_in_panic(void)
+{
+	return (panic_in_progress() && !this_cpu_in_panic());
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2601,26 +2624,6 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Return true if a panic is in progress on a remote CPU.
- *
- * On true, the local CPU should immediately release any printing resources
- * that may be needed by the panic CPU.
- */
-bool other_cpu_in_panic(void)
-{
-	if (!panic_in_progress())
-		return false;
-
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return atomic_read(&panic_cpu) != raw_smp_processor_id();
-}
-
 /**
  * console_lock - block the console subsystem from printing
  *
-- 
2.43.0


