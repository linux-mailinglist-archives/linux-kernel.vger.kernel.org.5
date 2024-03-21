Return-Path: <linux-kernel+bounces-110420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A75885EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06111C20CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18061386C0;
	Thu, 21 Mar 2024 16:51:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1F1386A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039904; cv=none; b=gLpGk+OqfFULUQ2hPDqYX3Kxu8KyzrRfJikLQZHxZttkcuOJyzGvQxFB1nfbSo42Qs7I9NAXUpFyQ2A2KX3nrXzvbB9u6v6hsPe65f8o4u2MkvI5K85Xrs3KsxM2okZjGcuWZKODKSUGjq080IwMUqR+az4bgJUtiz/84ShFJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039904; c=relaxed/simple;
	bh=hu9mtLJGF/MyobQYIaeWa1a64zsBcn1pF6EnLBJKSxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3nat7UNsFOHg++r7pnBhYpVXBGvNdpjy0HOwYaGjovCI7a7TYlhZzQ/0eBuczFbTOmalrsgFNFwheSNY/Bh0MLopCbzQI7O1X+gRumuJtf9S941vIKABclRG+ouOcGDxEOaXb+ScqzXflSZCNNzPGE8gnUo/bKfrrORYgkY9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD6E1063;
	Thu, 21 Mar 2024 09:52:16 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C60A3F67D;
	Thu, 21 Mar 2024 09:51:39 -0700 (PDT)
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
Subject: [PATCH v1 04/31] x86/resctrl: Add helper for setting CPU default properties
Date: Thu, 21 Mar 2024 16:50:39 +0000
Message-Id: <20240321165106.31602-5-james.morse@arm.com>
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

rdtgroup_rmdir_ctrl() and rdtgroup_rmdir_mon() set the per-CPU
pqr_state for CPUs that were part of the rmdir()'d group.

Another architecture might not have a 'pqr_state', its hardware may
need the values in a different format. MPAM's equivalent of RMID values
are not unique, and always need the CLOSID to be provided too.

There is only one caller that modifies a single value,
(rdtgroup_rmdir_mon()). MPAM always needs both CLOSID and RMID
for the hardware value as these are written to the same system
register.

As rdtgroup_rmdir_mon() has the CLOSID on hand, only provide a
helper to set both values. These values are read by
__resctrl_sched_in(), but may be written by a different CPU without
any locking, add READ/WRTE_ONCE() to avoid torn values.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 14 +++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 12dbd2588ca7..f61382258743 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -4,8 +4,9 @@
 
 #ifdef CONFIG_X86_CPU_RESCTRL
 
-#include <linux/sched.h>
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * This value can never be a valid CLOSID, and is used when mapping a
@@ -96,8 +97,8 @@ static inline void resctrl_arch_disable_mon(void)
 static inline void __resctrl_sched_in(struct task_struct *tsk)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
-	u32 closid = state->default_closid;
-	u32 rmid = state->default_rmid;
+	u32 closid = READ_ONCE(state->default_closid);
+	u32 rmid = READ_ONCE(state->default_rmid);
 	u32 tmp;
 
 	/*
@@ -132,6 +133,13 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
+static inline void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid,
+							    u32 rmid)
+{
+	WRITE_ONCE(per_cpu(pqr_state.default_closid, cpu), closid);
+	WRITE_ONCE(per_cpu(pqr_state.default_rmid, cpu), rmid);
+}
+
 static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
 						u32 closid, u32 rmid)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 45372b6a6215..5d2c1ce5b6b1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3623,14 +3623,18 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
 	/* Update per cpu rmid of the moved CPUs first */
+	closid = rdtgrp->closid;
+	rmid = prdtgrp->mon.rmid;
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
+
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
 	 * task running on them.
@@ -3663,6 +3667,7 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 
 static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the default group */
@@ -3673,10 +3678,10 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
 	/* Update per cpu closid and rmid of the moved CPUs first */
-	for_each_cpu(cpu, &rdtgrp->cpu_mask) {
-		per_cpu(pqr_state.default_closid, cpu) = rdtgroup_default.closid;
-		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
-	}
+	closid = rdtgroup_default.closid;
+	rmid = rdtgroup_default.mon.rmid;
+	for_each_cpu(cpu, &rdtgrp->cpu_mask)
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
 
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
-- 
2.39.2


