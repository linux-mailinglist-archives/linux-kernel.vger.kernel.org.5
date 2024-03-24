Return-Path: <linux-kernel+bounces-116224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E31889DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA82A75C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25C3BFFCC;
	Mon, 25 Mar 2024 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgjx785v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1A131BB0;
	Sun, 24 Mar 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323856; cv=none; b=LzBA0wEQNjOJmki4BZRq4+F64+UQnCFJmxIt6mcy53wOYxPYJqblgY9ZAXwy6MhtYCAuIn+nVtiSfPWQzpd538K83WRhe/V0poHtockUxAC6kygpa2QD4peQRniVvPxnu6ajAhCto03I+xlBRI7w6XoOj/vdhy2YHkKGJj5J7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323856; c=relaxed/simple;
	bh=aNG0AjZbig5Qhr6LXBT/gr9Q8gDY446a7r6lLHDmZX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggFIOGbuy2FKr7Z8fzzQ3UGYhtpjZ1dDW+e/4aI5EC2MPT5XwmjhdHQHrN7KMyOHTdek9BSWjle57urhHn4O2jJqJLHtsr+L7nkeiKo8wtrBdNWa9RFhVakeFGVJBKJnMqbXiTAuhvXJ189pCeKXQ8lvjMTRSx/4bSRGDzJrVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgjx785v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCB4C433F1;
	Sun, 24 Mar 2024 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323856;
	bh=aNG0AjZbig5Qhr6LXBT/gr9Q8gDY446a7r6lLHDmZX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgjx785vJc1cINWdWF/44Aa5/jkdUjSYf2bCD16mgplhFgrn6WHv4JK1gBkPOyXk7
	 EMFRHqZTvHj9wtCJPqKV9Qv7Z1CIfIsmz1wuiysm4EgE388rO7obPqX+rBFwzwu+DJ
	 UK1uJR6ND/S9ucwKFTiCVBVv+r7CVTix2byeRPEVTBJWwJ22DqpZGtNGnlkftgQBEN
	 l5Z3zjwrTSZ5A/KSO1hYTxj8H+NCg2DcRAUqwEeEWLvBDKw/Hc4tunYZ1vbBi2KoVD
	 I/6abJs3+y0YOIIDt2W/KLKCCd6WKhqO+ENrAgNX5dBbL6olWaN9IScPrSgvlfMpvW
	 mQuakyEE2CcfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 234/238] rcu: add a helper to report consolidated flavor QS
Date: Sun, 24 Mar 2024 19:40:22 -0400
Message-ID: <20240324234027.1354210-235-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 0122c03da24af..9db6710e6ee7b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -226,6 +226,37 @@ do { \
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


