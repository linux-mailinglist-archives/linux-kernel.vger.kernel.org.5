Return-Path: <linux-kernel+bounces-160220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF378B3AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D71B25720
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB514C593;
	Fri, 26 Apr 2024 15:09:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCCB14A636
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144166; cv=none; b=r6W+TevwqTKYoS49JqIxt1MGwDPS5w4ncNPaghSOmYt8fUh57O1YLltdHn6OYPFlSuXuZMtNwoM66E+HXwKp+eZ92MOTOUoiQf31ECW6QWdWXDV7PwH6DvwClh1daW5iXM9fLqYfSgdLAJrghyQj09moGBN0CW0pRaCfw09ngfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144166; c=relaxed/simple;
	bh=B45DNE5jVciRITycfR1j4r6df7VAf6oBaA+5UtSAlSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNn0FAdAQ09EOok5GZ5HhiR8CbV3TtXl0vsdPug2bMrMNZEQsV21YX5BxV4dRhn9uoaJtO4OPM3apq9i/yPOs2sDzDL4YSoH/TrrHMFdVqlaIyu9e8HBrs07EUh7im+nZs52QuTp7SjYRvX5r8l3OS8Fka8yJOsWVPWXHFtbQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496FC1682;
	Fri, 26 Apr 2024 08:09:52 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 662C43F73F;
	Fri, 26 Apr 2024 08:09:21 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 04/35] x86/resctrl: Add helper for setting CPU default properties
Date: Fri, 26 Apr 2024 16:08:33 +0100
Message-Id: <20240426150904.8854-4-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

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
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * In rdtgroup_rmdir_mon(), (re)set CPU default closid based on the
   parent control group, to avoid the appearance of referencing
   something that we're in the process of destroying (even if it
   doesn't make a difference because the victim mon group necessarily
   has the same closid as the parent control group).

   Update comment to match.

   No (intentional) functional change.
---
 arch/x86/include/asm/resctrl.h         | 14 +++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 20 ++++++++++++++------
 2 files changed, 25 insertions(+), 9 deletions(-)

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
index 47234562a1dd..98c051ac848d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3624,14 +3624,21 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
-	/* Update per cpu rmid of the moved CPUs first */
+	/*
+	 * Update per cpu closid/rmid of the moved CPUs first.
+	 * Note: the closid will not change, but the arch code still needs it.
+	 */
+	closid = prdtgrp->closid;
+	rmid = prdtgrp->mon.rmid;
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
+
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
 	 * task running on them.
@@ -3664,6 +3671,7 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 
 static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the default group */
@@ -3674,10 +3682,10 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
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
2.34.1


