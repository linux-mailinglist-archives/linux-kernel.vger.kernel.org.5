Return-Path: <linux-kernel+bounces-1457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD9814F26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F8628A4C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942C5638A;
	Fri, 15 Dec 2023 17:45:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8841866
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 823051063;
	Fri, 15 Dec 2023 09:45:42 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EBD53F5A1;
	Fri, 15 Dec 2023 09:44:54 -0800 (PST)
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
Subject: [PATCH v8 18/24] x86/resctrl: Make rdt_enable_key the arch's decision to switch
Date: Fri, 15 Dec 2023 17:43:37 +0000
Message-Id: <20231215174343.13872-19-james.morse@arm.com>
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

rdt_enable_key is switched when resctrl is mounted. It was also previously
used to prevent a second mount of the filesystem.

Any other architecture that wants to support resctrl has to provide
identical static keys.

Now that there are helpers for enabling and disabling the alloc/mon keys,
resctrl doesn't need to switch this extra key, it can be done by the arch
code. Use the static-key increment and decrement helpers, and change
resctrl to ensure the calls are balanced.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/resctrl.h         |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 3c9137b6ad4f..b74aa34dc9e8 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -45,21 +45,25 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 static inline void resctrl_arch_enable_alloc(void)
 {
 	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_disable_alloc(void)
 {
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_enable_mon(void)
 {
 	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_disable_mon(void)
 {
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8cc5a0937fa8..74a8494a0c91 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2677,10 +2677,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable) {
-		static_branch_enable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable || rdt_mon_capable)
 		resctrl_mounted = true;
-	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2951,9 +2949,10 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
-	resctrl_arch_disable_alloc();
-	resctrl_arch_disable_mon();
-	static_branch_disable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable)
+		resctrl_arch_disable_alloc();
+	if (rdt_mon_capable)
+		resctrl_arch_disable_mon();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.20.1


