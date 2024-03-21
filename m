Return-Path: <linux-kernel+bounces-110442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B5885F07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A97E1C23569
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562F1420CC;
	Thu, 21 Mar 2024 16:52:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E614198A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039972; cv=none; b=U+vkpROKGig7SqaOypJeyDktxy7ZevHB/Lp7RhhpPG70qudOAef38XVE4efw3oQHwIrrKqYYZ3jXyUnZiCuWewEeScNJa0R1U5mbKStrkOtV+XRiy6++yU6HMqprSB1jaaKEZL1GeGmyqBGdcwUZFOWmraEwMd9RuONyj5Pqkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039972; c=relaxed/simple;
	bh=zYk48L80th1Uc+PitHdpi6dCFH3ryHhZh0lpPEfLO8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvPj/EW3VH/i2mx2HFfb5Uo5rsXU8BQOJyCDWZXjk6qmro84D95Lqtnd1FBnFcfzl0OxsZUuyK7M/p+/HNXneKoDufsOTbpzncTGMGiUj7naIxdFpJuLzU2sW2xMa11QDoAlMee4Dfwm3kxfyPrFOabH3VlOrCp4m4fWyPT+VHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59941007;
	Thu, 21 Mar 2024 09:53:24 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 977CB3F67D;
	Thu, 21 Mar 2024 09:52:47 -0700 (PDT)
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
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 25/31] x86/resctrl: Claim get_domain_from_cpu() for resctrl
Date: Thu, 21 Mar 2024 16:51:00 +0000
Message-Id: <20240321165106.31602-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_domain_from_cpu() is a handy helper that both the arch code and
resctrl need to use. Rename it resctrl_get_domain_from_cpu() so it
gets moved out to /fs, and exported back to the arch code.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 15 +--------------
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 include/linux/resctrl.h                | 19 +++++++++++++++++++
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7cdecd8ac00b..f94ad04023c3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -355,19 +355,6 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
-{
-	struct rdt_domain *d;
-
-	list_for_each_entry(d, &r->domains, list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
 {
 	return resctrl_to_arch_res(r)->num_closid;
@@ -381,7 +368,7 @@ void rdt_ctrl_update(void *arg)
 	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
-	d = get_domain_from_cpu(cpu, r);
+	d = resctrl_get_domain_from_cpu(cpu, r);
 	if (d) {
 		hw_res->msr_update(d, m, r);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e849d4407769..3a3962736061 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -452,7 +452,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 287fb0a5f060..8b316d9acc3b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -676,7 +676,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 	pmbm_data = &dom_mbm->mbm_local[idx];
 
-	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
+	dom_mba = resctrl_get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 702a94fad6db..085fb9c2333a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4165,7 +4165,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 	if (!l3->mon_capable)
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, l3);
+	d = resctrl_get_domain_from_cpu(cpu, l3);
 	if (d) {
 		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 73c111963433..84420253dc05 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,7 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
@@ -273,6 +274,24 @@ static inline u32 resctrl_get_config_index(u32 closid,
 	}
 }
 
+/*
+ * Caller must hold the cpuhp read lock to prevent the struct rdt_domain being
+ * freed.
+ */
+static inline struct rdt_domain *
+resctrl_get_domain_from_cpu(int cpu, struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+
+	list_for_each_entry_rcu(d, &r->domains, list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.2


