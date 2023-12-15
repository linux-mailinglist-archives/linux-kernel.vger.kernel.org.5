Return-Path: <linux-kernel+bounces-1446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F9814F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713AB1F244AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9BB47F54;
	Fri, 15 Dec 2023 17:44:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C54653A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3336EC15;
	Fri, 15 Dec 2023 09:45:09 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40E443F5A1;
	Fri, 15 Dec 2023 09:44:21 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v8 07/24] x86/resctrl: Allow RMID allocation to be scoped by CLOSID
Date: Fri, 15 Dec 2023 17:43:26 +0000
Message-Id: <20231215174343.13872-8-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPAMs RMID values are not unique unless the CLOSID is considered as well.

alloc_rmid() expects the RMID to be an independent number.

Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
allocating. If the CLOSID is not relevant to the index, this ends up
comparing the free RMID with itself, and the first free entry will be
used. With MPAM the CLOSID is included in the index, so this becomes a
walk of the free RMID entries, until one that matches the supplied
CLOSID is found.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v2;
 * Rephrased comment in resctrl_find_free_rmid() to describe this in terms of
   list_entry_first()
 * Rephrased comment above alloc_rmid()

Changes since v3:
 * Flipped conditions in alloc_rmid()

Changes since v4:
 * Typo in comment

Changes since v5:
 * Reworded two comments.

Changes since v6:
 * Fixed a typo and some whitespace.
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 43 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 97ec24f91ac4..2f1d4f141dab 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -545,7 +545,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
-int alloc_rmid(void);
+int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d623031def4c..1f371b108a74 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -344,24 +344,49 @@ bool has_busy_rmid(struct rdt_domain *d)
 	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
 }
 
+static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
+{
+	struct rmid_entry *itr;
+	u32 itr_idx, cmp_idx;
+
+	if (list_empty(&rmid_free_lru))
+		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
+
+	list_for_each_entry(itr, &rmid_free_lru, list) {
+		/*
+		 * Get the index of this free RMID, and the index it would need
+		 * to be if it were used with this CLOSID.
+		 * If the CLOSID is irrelevant on this architecture, the two
+		 * index values are always the same on every entry and thus the
+		 * very first entry will be returned.
+		 */
+		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
+		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
+
+		if (itr_idx == cmp_idx)
+			return itr;
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
 /*
- * As of now the RMIDs allocation is global.
- * However we keep track of which packages the RMIDs
- * are used to optimize the limbo list management.
+ * For MPAM the RMID value is not unique, and has to be considered with
+ * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
+ * allows all domains to be managed by a single free list.
+ * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
  */
-int alloc_rmid(void)
+int alloc_rmid(u32 closid)
 {
 	struct rmid_entry *entry;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (list_empty(&rmid_free_lru))
-		return rmid_limbo_count ? -EBUSY : -ENOSPC;
+	entry = resctrl_find_free_rmid(closid);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
 
-	entry = list_first_entry(&rmid_free_lru,
-				 struct rmid_entry, list);
 	list_del(&entry->list);
-
 	return entry->rmid;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 65bee6f11015..d8f44113ed1f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -777,7 +777,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 	int ret;
 
 	if (rdt_mon_capable) {
-		ret = alloc_rmid();
+		ret = alloc_rmid(rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Out of RMIDs\n");
 			return ret;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 351b74670673..12a557c96100 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3300,7 +3300,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	if (!rdt_mon_capable)
 		return 0;
 
-	ret = alloc_rmid();
+	ret = alloc_rmid(rdtgrp->closid);
 	if (ret < 0) {
 		rdt_last_cmd_puts("Out of RMIDs\n");
 		return ret;
-- 
2.20.1


