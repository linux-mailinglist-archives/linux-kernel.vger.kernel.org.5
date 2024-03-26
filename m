Return-Path: <linux-kernel+bounces-119639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E1488CB72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B737B1C656D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A24CE09;
	Tue, 26 Mar 2024 18:01:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2A1F934;
	Tue, 26 Mar 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476063; cv=none; b=KutLV6XD2bjdWAKIMnXBarBjL8RIeaYcsNIZnkyo/t8MyhacOJcW35Ciy2T4uUH1NVBpG6hGG+mm950JGSLT1NjSP6JzKWJR6zC0aPjsIJ7Ej1nlYSC+PBlqJpEB6Nu5xeDv+FNFGiMJUPT/Mnlw/QsvDT8dENL/tLfCGgm6XdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476063; c=relaxed/simple;
	bh=J+s6fDz4tfmoWA+aY/9bdkTwSJ8H/Gq1EfnRBneA0OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMA/7D1NMbN0l4prWX56+q6FT+cOCs0UceNZrK191ke62BqPrZpQnjJ5fV9F0hR7zVkq1065hlHSelfPpKaAwrwlW6cBOw3y8vNdYAD4jmiIIOug/YLGvHGx8JdasNl3H9Y40cbachc5C/Lkhh56SXDo1ahSHxFC0Z6+IUmJv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8981D2F4;
	Tue, 26 Mar 2024 11:01:34 -0700 (PDT)
Received: from e133047.arm.com (unknown [10.57.81.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8ECD23F64C;
	Tue, 26 Mar 2024 11:00:59 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	mingo@redhat.com,
	rafael@kernel.org,
	dietmar.eggemann@arm.com,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/uclamp: Fix iowait boost UCLAMP_MAX escape
Date: Tue, 26 Mar 2024 18:00:54 +0000
Message-Id: <20240326180054.487388-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task, regardless of UCLAMP_MAX value, was previously allowed to
build up the sg_cpu->iowait boost up to SCHED_CAPACITY_SCALE when
enqueued. Since the boost was only uclamped when applied this led
to sugov iowait boosting the rq while the task is dequeued.

The fix introduced by
commit d37aee9018e6 ("sched/uclamp: Fix iowait boost escaping uclamp restriction")
added the uclamp check before the boost is applied. Unfortunately
that is insufficient, as the iowait_boost may be built up purely by
a task with UCLAMP_MAX task, but since this task is in_iowait often,
the clamps are no longer active during the in_iowait periods.
So another task (let's say with low utilization) may immediately
receive the iowait_boost value previously built up under UCLAMP_MAX
restrictions.

The issue is less prevalent than the above might suggest, since if
the dequeuing of the UCLAMP_MAX set task will turn the cpu idle the
previous UCLAMP_MAX value is preserved by uclamp_idle_value().
Nonetheless anything being enqueued on the rq during the in_iowait
phase will falsely receive the iowait_boost.

Can be observed with a basic single-threaded benchmark running with
UCLAMP_MAX of 0, the iowait_boost is then triggered by the occasional
kworker.

Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 36 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..bfd79762b28d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -205,6 +205,25 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
 
+/**
+ * sugov_iowait_clamp() - Clamp the boost with UCLAMP_MAX
+ * @sg_cpu: the sugov data for the CPU
+ * @boost: the requested new boost
+ *
+ * Clamps the iowait boost according to the rq's UCLAMP_MAX restriction.
+ */
+static void sugov_iowait_clamp(struct sugov_cpu *sg_cpu, unsigned int boost)
+{
+#if CONFIG_UCLAMP_TASK
+	unsigned int boost_scaled = (boost *
+		arch_scale_cpu_capacity(sg_cpu->cpu)) >> SCHED_CAPACITY_SHIFT;
+
+	if (uclamp_rq_get(cpu_rq(sg_cpu->cpu), UCLAMP_MAX) < boost_scaled)
+		return;
+#endif
+	sg_cpu->iowait_boost = boost;
+	sg_cpu->iowait_boost_pending = true;
+}
 /**
  * sugov_iowait_reset() - Reset the IO boost status of a CPU.
  * @sg_cpu: the sugov data for the CPU to boost
@@ -225,8 +244,8 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 	if (delta_ns <= TICK_NSEC)
 		return false;
 
-	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
-	sg_cpu->iowait_boost_pending = set_iowait_boost;
+	if (set_iowait_boost)
+		sugov_iowait_clamp(sg_cpu, IOWAIT_BOOST_MIN);
 
 	return true;
 }
@@ -249,6 +268,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned int flags)
 {
 	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+	unsigned int iowait_boost;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sg_cpu->iowait_boost &&
@@ -262,17 +282,17 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 	/* Ensure boost doubles only one time at each request */
 	if (sg_cpu->iowait_boost_pending)
 		return;
-	sg_cpu->iowait_boost_pending = true;
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
-		sg_cpu->iowait_boost =
-			min_t(unsigned int, sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
-		return;
+		iowait_boost = min_t(unsigned int, sg_cpu->iowait_boost << 1,
+				SCHED_CAPACITY_SCALE);
+	} else {
+		/* First wakeup after IO: start with minimum boost */
+		iowait_boost = IOWAIT_BOOST_MIN;
 	}
 
-	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
+	sugov_iowait_clamp(sg_cpu, iowait_boost);
 }
 
 /**
-- 
2.34.1


