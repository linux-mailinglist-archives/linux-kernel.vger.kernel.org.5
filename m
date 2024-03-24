Return-Path: <linux-kernel+bounces-113049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F41888110
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371791F2369A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC56142914;
	Sun, 24 Mar 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4HjjQ0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C381428FD;
	Sun, 24 Mar 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319858; cv=none; b=sYo8pMDyayr56mczOgRqUEuMsRsf+wbQ/yEhtmTAURwu6PqnBDQOpWzYVY8zxdvrhGqhDa76OB6y4eSOI6inrN/JKFveLhvyBQ54I4yChgd2mfOi/WTA+TTkFqdCFqgh+JEUaMi48uAHVWVrDcAiRgVxRYZiEd+RGOZqHvLM5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319858; c=relaxed/simple;
	bh=weL9bKStwrCWZ03fP6/Vywm6N8qOPfvGjjZrxMDFsZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOwhsYnPh5Bsb3CKvfpvHYDoJeAXiV6ahvUFq3ypTzm9KXfQsCuvHpAP2HG7mlIdE9CJhVQjWZb17F1xnygs0z8Mr3dwvHNY/qVbNDV6tr7tvipbadGZicku8EROhJgpkvd9Jujxtr7xzG4MNJnhyq6DNFNeqscDHhcTjdcIlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4HjjQ0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A9C43390;
	Sun, 24 Mar 2024 22:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319858;
	bh=weL9bKStwrCWZ03fP6/Vywm6N8qOPfvGjjZrxMDFsZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4HjjQ0dl4JX8oFdGVPcOI2ak5lPMj2F5hRI5UBp88uxu9e6IRetd7gTNONxmWFjN
	 JmfgR6aYyY0xn04LQmBMy0JxRMJL0B5O48RFGzL/oc8USFapTs7Sxo86FTHDlQRLnD
	 SC2Lw8T9u1k4+xtA2aYzNk7pL4J6sCAF/mDbX2v6veDCSJa6+Zc6HNWIau4dIq+xfc
	 1WK3qbVRMM1Uwj4mjPEOZElXA5sKPbRwXJ99UR4iM9vRJPBKsagiBOS116ludvm5mp
	 nDzXBNRJ7ZF143iPL2D7stPkz/BGL5XIHZUGM5r2/YQpuUS2GhrYrIWRM5BcZL8/sQ
	 OK0C3UPp13PrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 162/715] printk: Add this_cpu_in_panic()
Date: Sun, 24 Mar 2024 18:25:41 -0400
Message-ID: <20240324223455.1342824-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


