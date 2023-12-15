Return-Path: <linux-kernel+bounces-1456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A6F814F25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4C11F219AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E34187D;
	Fri, 15 Dec 2023 17:44:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BC782EFA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C34FC15;
	Fri, 15 Dec 2023 09:45:39 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88F0D3F5A1;
	Fri, 15 Dec 2023 09:44:51 -0800 (PST)
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
Subject: [PATCH v8 17/24] x86/resctrl: Move alloc/mon static keys into helpers
Date: Fri, 15 Dec 2023 17:43:36 +0000
Message-Id: <20231215174343.13872-18-james.morse@arm.com>
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

resctrl enables three static keys depending on the features it has enabled.
Another architecture's context switch code may look different, any
static keys that control it should be buried behind helpers.

Move the alloc/mon logic into arch-specific helpers as a preparatory step
for making the rdt_enable_key's status something the arch code decides.

This means other architectures don't have to mirror the static keys.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/resctrl.h         | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 -----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 29c4cc343787..3c9137b6ad4f 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -42,6 +42,26 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
+static inline void resctrl_arch_enable_alloc(void)
+{
+	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+}
+
+static inline void resctrl_arch_disable_alloc(void)
+{
+	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
+}
+
+static inline void resctrl_arch_enable_mon(void)
+{
+	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+}
+
+static inline void resctrl_arch_disable_mon(void)
+{
+	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5ce49503fcd8..68b9beed8e42 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -95,9 +95,6 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct rdt_fs_context, kfc);
 }
 
-DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
-DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
-
 /**
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
@@ -454,8 +451,6 @@ extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
-DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
-
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 646d224c3ac9..8cc5a0937fa8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2673,9 +2673,9 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_psl;
 
 	if (rdt_alloc_capable)
-		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+		resctrl_arch_enable_alloc();
 	if (rdt_mon_capable)
-		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+		resctrl_arch_enable_mon();
 
 	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
@@ -2951,8 +2951,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
-	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
-	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+	resctrl_arch_disable_alloc();
+	resctrl_arch_disable_mon();
 	static_branch_disable_cpuslocked(&rdt_enable_key);
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
-- 
2.20.1


