Return-Path: <linux-kernel+bounces-114467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B30888AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D0B1F25F96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079017C646;
	Sun, 24 Mar 2024 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNyuK8IZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BC156C5B;
	Sun, 24 Mar 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321898; cv=none; b=QioecpSqnINFHIAYhhxEeiRvtyip8oNSX6fCuiTO0swK1kynaBndmGNwfa6eJmxJdf9KyQzckfu1Oq2VSpAw6kQ16rePw1AyahDCDEaDfm8HTRLM5VPkljYGwGQ8620bhsjTUliA4tJB2fQJI1MuHhq4nLJLAcomVSNAfcjNscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321898; c=relaxed/simple;
	bh=Hu+ax5wSak1Lm1AsnCUL7UUmvAU1Wb0Gj04ZedWy7Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDF/StWbGRDViGBAzGO+pFi29xop3UkstltoCARFLBrRPEJ8NiN1RNDcOb7xpEKslCzv189NlViQtPibjllHqAnRa8TTyhqRmvcz5lXpXNZigmEu9fA0q6r4hE+InDMpqt5+hK74SLsopv+B65KlKs3+0TBJgIyhXH1aO/g1BTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNyuK8IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D6AC433C7;
	Sun, 24 Mar 2024 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321897;
	bh=Hu+ax5wSak1Lm1AsnCUL7UUmvAU1Wb0Gj04ZedWy7Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNyuK8IZSMS2YZEZAm+Hu6CrayuPcFIGoDSK11Yjihp4bRIaYfMn/Ey5dafXu2suj
	 SlMj/MpsO2xNgqQi4mBhDnKmUs5q/2xrQFeg+N+4pUi+P1qYN7oRJfSILEecCXiAWs
	 m5Wc69IYfmnc+6/8fYfqMSuGr45a3Rq2BdKYopG9wYFaud9R2pQo5lvISIW79p122d
	 g4XrG8ifEtU8224NaBUv3dt2xPITnnmAxkD9zxMpN5I234hyvc0Ynpy26+GQYdjguR
	 ed2w0DliwLrdV+IrB9ivbX8MA7/0UGadt4UWzpzTWEGW013DxXMsaiWjQ90+JhtDn6
	 JL/HpK/p3RD6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 626/638] rcu: add a helper to report consolidated flavor QS
Date: Sun, 24 Mar 2024 19:01:03 -0400
Message-ID: <20240324230116.1348576-627-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
Stable-dep-of: d6dbbb11247c ("net: report RCU QS on threaded NAPI repolling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44aab5c0bd2c1..9ad656b28847f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -252,6 +252,37 @@ do { \
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


