Return-Path: <linux-kernel+bounces-124499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B71B8918F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C37D1C24D51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2A13F423;
	Fri, 29 Mar 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB6yIOLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC413EFE5;
	Fri, 29 Mar 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715243; cv=none; b=t7joQApZWbZWjCigLt8GXN85hIA01a7eXr4yn0boy70aYKTdjUx30I2QXsfVXdqIh/yKcqNVXdqgHn1F3/ch/4QuVAS+NhhHx3zxUlj0YFohRcIyuEOGCCK7PUYtjeaub6i/bnS6kBjbyiSyWn57KpO4DPmKRac5Xkib+MZANF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715243; c=relaxed/simple;
	bh=Wn5WD+2CFhXCxhgEcc1PzJJjaGHw/EsSXxUvY9AwRzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpKuB1BtqCFFMxDMLU5zpok680/5eUX7gQ9b+50Yi1rW7sD+Oz5OSzl8dPT6A+i/kPhhXa2b9ZbAg1w570l5BqeroNMZta0tX1PCjE8MwHLzHlXM3ICP7Xe7kWjh9v4su8khXJSb3z4xi2DdQTXNZ7wMTlHaloVxJ0Szj/7/gVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB6yIOLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CADC43394;
	Fri, 29 Mar 2024 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715243;
	bh=Wn5WD+2CFhXCxhgEcc1PzJJjaGHw/EsSXxUvY9AwRzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lB6yIOLPUfmANZy4FNIbQ6vjEhkf9HhuXQefTFoLPb+CrpQFSnftcw8O225I8bXLj
	 lLcxYPBDIa0zJcmoo3RN+qT96cmbAb8O3UMqKC78umNKkyouLS+C7zd37PWXlkWY3U
	 RoxTRp4kvWIOA0OhSgLZpQjvqtjBl0bch0rHDqNGtDbZMQpP0R2PPkgJPeg6Rb4NjV
	 gJrOa6iG0Sg5zLnkbrpp+wYNFLfoRAe/TvqF8WW20h2ejR7RnYMZux6LpBm1XICn4u
	 /oczNFdVcOo7lgc8e2nHPSzeC3WX9936qkUcoXmJQDRLhnsMx4e3JF1C0vddskXET+
	 KQ507o6EVdoYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 18/68] printk: Add this_cpu_in_panic()
Date: Fri, 29 Mar 2024 08:25:14 -0400
Message-ID: <20240329122652.3082296-18-sashal@kernel.org>
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

[ Upstream commit 36652d0f3bf34899e82d31a5fa9e2bdd02fd6381 ]

There is already panic_in_progress() and other_cpu_in_panic(),
but checking if the current CPU is the panic CPU must still be
open coded.

Add this_cpu_in_panic() to complete the set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-8-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
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
index d9f20d222293b..742fb479b1d60 100644
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
@@ -2600,26 +2623,6 @@ static int console_cpu_notify(unsigned int cpu)
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


