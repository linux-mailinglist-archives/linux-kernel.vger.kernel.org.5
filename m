Return-Path: <linux-kernel+bounces-64103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F96853A25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C816F28F13C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C5612CA;
	Tue, 13 Feb 2024 18:45:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA060EF3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849944; cv=none; b=lre71dxAPShje3zi66tZTF6BKn4nnsGFzxK9BsZFMzB0ec5aiQPVQrDX8lxoMGFL0qobsE/y5EpCdG7INDcy1vh+i5Idynfj9OO1mfikIXCSJjh3Qq/0mU45AY5Cwg9faRtMTEzWH1a7InEAObYz5dOFlQw6engffUJQURLEoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849944; c=relaxed/simple;
	bh=tCk5Rp6ufC7ekXhYD/3kjr90yolxWKM1koNMSXSV0dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRUgEIplDqbvtEK9mnIt05n9Ucgc3oa64ga/CGxoOlMgTKGSeQCNy9aZJGIhfGj2PBfqXt2zoraLxUJgpgOuMm9y/8LM31xyVyEMnVRJmNtlId+uOvY6TPU1/M13bv6S9VU8uyX2do+mxUseCN4pILmhpi1AtLBZZ4B7cZxfI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B9081516;
	Tue, 13 Feb 2024 10:46:23 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C89B3F766;
	Tue, 13 Feb 2024 10:45:38 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v9 12/24] x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
Date: Tue, 13 Feb 2024 18:44:26 +0000
Message-Id: <20240213184438.16675-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limbo and overflow code picks a CPU to use from the domain's list
of online CPUs. Work is then scheduled on these CPUs to maintain
the limbo list and any counters that may overflow.

cpumask_any() may pick a CPU that is marked nohz_full, which will
either penalise the work that CPU was dedicated to, or delay the
processing of limbo list or counters that may overflow. Perhaps
indefinitely. Delaying the overflow handling will skew the bandwidth
values calculated by mba_sc, which expects to be called once a second.

Add cpumask_any_housekeeping() as a replacement for cpumask_any()
that prefers housekeeping CPUs. This helper will still return
a nohz_full CPU if that is the only option. The CPU to use is
re-evaluated each time the limbo/overflow work runs. This ensures
the work will move off a nohz_full CPU once a housekeeping CPU is
available.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v3:
 * typos fixed

Changes since v4:
 * Made temporary variables unsigned

Changes since v5:
 * Restructured cpumask_any_housekeeping() to avoid later churn.

Changes since v6:
 * Update mbm_work_cpu/cqm_work_cpu when rescheduling.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 24 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 20 +++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b7b9d9230bef..81f5de916db8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -7,6 +7,7 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
+#include <linux/tick.h>
 
 #include <asm/resctrl.h>
 
@@ -55,6 +56,29 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/**
+ * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
+ *			        aren't marked nohz_full
+ * @mask:	The mask to pick a CPU from.
+ *
+ * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
+ * nohz_full, these are preferred.
+ */
+static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
+{
+	unsigned int cpu, hk_cpu;
+
+	cpu = cpumask_any(mask);
+	if (!tick_nohz_full_cpu(cpu))
+		return cpu;
+
+	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+	if (hk_cpu < nr_cpu_ids)
+		cpu = hk_cpu;
+
+	return cpu;
+}
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 101f1b112d17..38f85e53ca93 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -761,7 +761,6 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
-	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -770,8 +769,11 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	__check_limbo(d, false);
 
-	if (has_busy_rmid(d))
-		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
+	if (has_busy_rmid(d)) {
+		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
+					 delay);
+	}
 
 	mutex_unlock(&rdtgroup_mutex);
 }
@@ -781,7 +783,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
 	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
@@ -791,7 +793,6 @@ void mbm_handle_overflow(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
-	int cpu = smp_processor_id();
 	struct list_head *head;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -815,7 +816,12 @@ void mbm_handle_overflow(struct work_struct *work)
 			update_mba_bw(prgrp, d);
 	}
 
-	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
+	/*
+	 * Re-check for housekeeping CPUs. This allows the overflow handler to
+	 * move off a nohz_full CPU quickly.
+	 */
+	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
@@ -828,7 +834,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		return;
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
 	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
-- 
2.39.2


