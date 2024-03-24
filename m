Return-Path: <linux-kernel+bounces-116301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46973889E17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AF11F372EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F728FA97;
	Mon, 25 Mar 2024 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltMYaorK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DD5D480;
	Sun, 24 Mar 2024 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324192; cv=none; b=cnYfd2xYl5jLEbMcRuHK9Pau7smtkuWQOy2dSLw1piJ5ZYsCyJD/ResnpoHAyXLjCROG8xK1si4xVNvkvis8gC4XkVDNBhBtlUQ0M0eqOb2rn0uFDUvkOh083eO6f9e7Hgq9LNfJjhABKBo+hEii0ff42o3Mq+fsme9v1FsFsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324192; c=relaxed/simple;
	bh=J43lLRphZYRRohaPDHmf5QhVkZ5bdqjpLcGmwgnUCQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unPiY8g5fdxh3ZruAPYpj95uBuWT3vJMnGU7fyJ9t+l5a9NWz2U0y7fGdsVs+PCwY2WuNAy9KSXUBPb+hMjT9Xpg0FjXF9lvEouY0T5tlnnuJFYYwpKj5s9xChWht79Y//vw24mNS1uqnNRM3azpY9zVfFQUbW7yZZjfuSb4g7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltMYaorK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81952C43390;
	Sun, 24 Mar 2024 23:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324190;
	bh=J43lLRphZYRRohaPDHmf5QhVkZ5bdqjpLcGmwgnUCQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltMYaorKXHG1JD5EW95e1XhsCl2sm960PV5Z7wqV0FUOx1Pq5zNwLxxAN98s9cWOP
	 BcCnVV/q1x6JR9EHo+LOFromr1egmOjwle+e9N6buLiAa9EvPKcDd4L3w43AINbCau
	 V76HQxR1lQVbEjD7u3Z4sTWttpTMAb7xH9/rLDtQuXtV4Rkgn54/5FP5PTs38n3Mxa
	 ivPCEIqbtF/RCRGvQ7676nnQMq6axpc73bE1NyHnMux7k4e5RW7PdgvhqEtUtfaZva
	 GPXsi8tE/DRmqMN66TPobjZ5moWtoiYkmhEu1358pnkrY+8hz9mPguvbGxtRcggRRV
	 br1HclUCQgZ+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 179/183] rcu: add a helper to report consolidated flavor QS
Date: Sun, 24 Mar 2024 19:46:32 -0400
Message-ID: <20240324234638.1355609-180-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 1a77557d48cff187a169c2aec01c0dd78a5e7e50 ]

When under heavy load, network processing can run CPU-bound for many
tens of seconds. Even in preemptible kernels (non-RT kernel), this can
block RCU Tasks grace periods, which can cause trace-event removal to
take more than a minute, which is unacceptably long.

This commit therefore creates a new helper function that passes through
both RCU and RCU-Tasks quiescent states every 100 milliseconds. This
hard-coded value suffices for current workloads.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/r/90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 00bf63122459 ("bpf: report RCU QS in cpumap kthread")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c75b38ba4a728..bc4b5c905a602 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -164,6 +164,37 @@ do { \
 	cond_resched(); \
 } while (0)
 
+/**
+ * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
+ * @old_ts: jiffies at start of processing.
+ *
+ * This helper is for long-running softirq handlers, such as NAPI threads in
+ * networking. The caller should initialize the variable passed in as @old_ts
+ * at the beginning of the softirq handler. When invoked frequently, this macro
+ * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
+ * provide both RCU and RCU-Tasks quiescent states. Note that this macro
+ * modifies its old_ts argument.
+ *
+ * Because regions of code that have disabled softirq act as RCU read-side
+ * critical sections, this macro should be invoked with softirq (and
+ * preemption) enabled.
+ *
+ * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
+ * have more chance to invoke schedule() calls and provide necessary quiescent
+ * states. As a contrast, calling cond_resched() only won't achieve the same
+ * effect because cond_resched() does not provide RCU-Tasks quiescent states.
+ */
+#define rcu_softirq_qs_periodic(old_ts) \
+do { \
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
+	    time_after(jiffies, (old_ts) + HZ / 10)) { \
+		preempt_disable(); \
+		rcu_softirq_qs(); \
+		preempt_enable(); \
+		(old_ts) = jiffies; \
+	} \
+} while (0)
+
 /*
  * Infrastructure to implement the synchronize_() primitives in
  * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
-- 
2.43.0


