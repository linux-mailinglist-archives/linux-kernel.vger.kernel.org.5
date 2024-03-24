Return-Path: <linux-kernel+bounces-113594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D99888592
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F995285118
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE21CCE43;
	Sun, 24 Mar 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2LKT3Qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993F1CCE26;
	Sun, 24 Mar 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320397; cv=none; b=ATMHDc3VCAJb5Pd1qkLNi91Q9KdozhSbGC+F8l5zBb6E3xA0XrvPEO3JPzFk9QBWfYi40LNFB23xkAUwWI8wjl2Hy3vlbKsSEg3ImcIAq3nMu7UuoDf/DXhRAMG3IhrJ4uuAV5NsiW6Mt9M9/vRYFOD2HYqsrVLQpTEGBJ0W/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320397; c=relaxed/simple;
	bh=Km4ENcWFfQoMIJIZTdNgW7E+woHN8o8HNtOCGwvqt14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRt0GHjpXflp7s7Lgo/KBV6PYtC9n6zO+F191Uf+3fT9c15fEoImTDSPNzfQ1YiCSmMP2dDWSpwP3RSEHNU5O2bqWrbM2xFaa76Z8Gr7e6OHTmUGjS3cWtJfuP8S6+eiw2o8w7A/3dAXGps/WkEInyZKLZT3OGCgSKNHuKRyK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2LKT3Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947AC43399;
	Sun, 24 Mar 2024 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320397;
	bh=Km4ENcWFfQoMIJIZTdNgW7E+woHN8o8HNtOCGwvqt14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2LKT3QoGf6V5M6tK00uCuKF3PgmFu4lmm6jec3sDKPo4hFHSjpJK6QyMcfdlRFIS
	 QOwh7ECYQUnVB4cx71j0BHzGqudS5eP4SEuilm9JKwIuIfbAkPRL1GSPN0Qe3S2Q9u
	 i/ToD9Ruc6wCfuhob5kyDmNSj/WygxRtQHRzLLLALYEEh8zo7eEqowTk7MqnMq9smb
	 ikTB0kt9bhSD0tZQ3n7UoDucrkJqPUaljsbrM/+4MtazBnjyAndaGd8GLpFhJcVvFW
	 XGEmtIrj/+l2TeI4gZphFUa2bB03SgYyKxh1oPYW9biNmfO1/EM4GOba1eqNXPebr8
	 E6ntaegxhzjQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 703/715] rcu: add a helper to report consolidated flavor QS
Date: Sun, 24 Mar 2024 18:34:42 -0400
Message-ID: <20240324223455.1342824-704-sashal@kernel.org>
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
index 0746b1b0b6639..9d69e4bd6f0a8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -247,6 +247,37 @@ do { \
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


