Return-Path: <linux-kernel+bounces-1449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1DF814F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638311C245ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3149F98;
	Fri, 15 Dec 2023 17:44:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500149F6D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4603F1063;
	Fri, 15 Dec 2023 09:45:18 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55FA73F5A1;
	Fri, 15 Dec 2023 09:44:30 -0800 (PST)
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
Subject: [PATCH v8 10/24] x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid
Date: Fri, 15 Dec 2023 17:43:29 +0000
Message-Id: <20231215174343.13872-11-james.morse@arm.com>
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

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
used for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Instead of allocating the first free CLOSID, on architectures where
CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
closid_num_dirty_rmid[] to find the cleanest CLOSID.

The CLOSID found is returned to closid_alloc() for the free list
to be updated.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v4:
 * Dropped stale section from comment

Changes since v5:
 * Renamed some variables.

Changes since v7:
 * Made comments over closid_num_dirty_rmid() not a kdoc comment.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 47 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++---
 3 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2f1d4f141dab..521afa016b05 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -568,5 +568,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+bool closid_allocated(unsigned int closid);
+int resctrl_find_cleanest_closid(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 6dfc68c800c8..fdbef88ff39b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -50,7 +50,7 @@ struct rmid_entry {
  */
 static LIST_HEAD(rmid_free_lru);
 
-/**
+/*
  * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
  *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
  *     Indexed by CLOSID. Protected by rdtgroup_mutex.
@@ -386,6 +386,51 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
 	return ERR_PTR(-ENOSPC);
 }
 
+/**
+ * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
+ *                                  RMID are clean, or the CLOSID that has
+ *                                  the most clean RMID.
+ *
+ * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
+ * may not be able to allocate clean RMID. To avoid this the allocator will
+ * choose the CLOSID with the most clean RMID.
+ *
+ * When the CLOSID and RMID are independent numbers, the first free CLOSID will
+ * be returned.
+ */
+int resctrl_find_cleanest_closid(void)
+{
+	u32 cleanest_closid = ~0;
+	int i = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		return -EIO;
+
+	for (i = 0; i < closids_supported(); i++) {
+		int num_dirty;
+
+		if (closid_allocated(i))
+			continue;
+
+		num_dirty = closid_num_dirty_rmid[i];
+		if (num_dirty == 0)
+			return i;
+
+		if (cleanest_closid == ~0)
+			cleanest_closid = i;
+
+		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
+			cleanest_closid = i;
+	}
+
+	if (cleanest_closid == ~0)
+		return -ENOSPC;
+
+	return cleanest_closid;
+}
+
 /*
  * For MPAM the RMID value is not unique, and has to be considered with
  * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f6b52415ca3d..00f830f729b3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -137,13 +137,22 @@ static void closid_init(void)
 
 static int closid_alloc(void)
 {
-	u32 closid = ffs(closid_free_map);
+	int cleanest_closid;
+	u32 closid;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (closid == 0)
-		return -ENOSPC;
-	closid--;
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		cleanest_closid = resctrl_find_cleanest_closid();
+		if (cleanest_closid < 0)
+			return cleanest_closid;
+		closid = cleanest_closid;
+	} else {
+		closid = ffs(closid_free_map);
+		if (closid == 0)
+			return -ENOSPC;
+		closid--;
+	}
 	__clear_bit(closid, &closid_free_map);
 
 	return closid;
@@ -163,7 +172,7 @@ void closid_free(int closid)
  * Return: true if @closid is currently associated with a resource group,
  * false if @closid is free
  */
-static bool closid_allocated(unsigned int closid)
+bool closid_allocated(unsigned int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-- 
2.20.1


