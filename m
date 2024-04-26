Return-Path: <linux-kernel+bounces-160222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CF8B3AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C631F25A33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B971C1514CC;
	Fri, 26 Apr 2024 15:09:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995414F109
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144172; cv=none; b=Zu7j11vFhn+mFuHy/QL2i0KwvJIBQ269c3lzMF5wb+hlhGT2fxEHyLbkqVFt/X2Y3Rxt3No7gKGVjfHXfMmtYyU7PRhl7IM1N351ZjWSItzQUScydcfzmX/DzKUEYMxlmWaJcPvQE4w3fXD9GYASM51S0MWKrvc33E4HXbyW/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144172; c=relaxed/simple;
	bh=mQUMIAjQMLXinjyRmnPXcCSGpXSuxeEhQHIkgwgjvvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUHIDwSE2odk9QRG8w0rU9tFUVIdZQy2Vtsu2+/PMqyE4yjkJjLokek+z3QZnVlizCxXZR7XC30N225vmKeKsS3r7kX87FvQTx/F04pigOd3ayOrXk/RhOUpvLwpwL5GrO1Yh13GvkX6LBEsljOeoXfCOMvgKIUb9eQRRiv2+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B58168F;
	Fri, 26 Apr 2024 08:09:58 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91F8B3F73F;
	Fri, 26 Apr 2024 08:09:27 -0700 (PDT)
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
Subject: [PATCH v2 06/35] x86/resctrl: Export resctrl fs's init function
Date: Fri, 26 Apr 2024 16:08:35 +0100
Message-Id: <20240426150904.8854-6-Dave.Martin@arm.com>
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

rdtgroup_init() needs exporting so that arch code can call it once
it lives in core code. As this is one of the few functions exported,
rename it to have "resctrl" in the name. The same goes for the exit
call.

x86's arch code init functions for RDT are renamed to have an arch
prefix to make it clear these are part of the architecture code.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * Rename stale rdtgroup_init() to resctrl_init() in
   arch/x86/kernel/cpu/resctrl/monitor.c comments.

   No functional change.

 * [Commit message only] Minor rewording to avoid "impersonating code".

 * [Commit message only] Typo fix:
   s/to have the resctrl/to have resctrl/ in commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                |  3 +++
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d07eff7d6750..b4e7d655e242 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -938,7 +938,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 	}
 }
 
-static int __init resctrl_late_init(void)
+static int __init resctrl_arch_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -963,7 +963,7 @@ static int __init resctrl_late_init(void)
 	if (state < 0)
 		return state;
 
-	ret = rdtgroup_init();
+	ret = resctrl_init();
 	if (ret) {
 		cpuhp_remove_state(state);
 		return ret;
@@ -979,18 +979,18 @@ static int __init resctrl_late_init(void)
 	return 0;
 }
 
-late_initcall(resctrl_late_init);
+late_initcall(resctrl_arch_late_init);
 
-static void __exit resctrl_exit(void)
+static void __exit resctrl_arch_exit(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	cpuhp_remove_state(rdt_online);
 
-	rdtgroup_exit();
+	resctrl_exit();
 
 	if (r->mon_capable)
 		rdt_put_mon_l3_config();
 }
 
-__exitcall(resctrl_exit);
+__exitcall(resctrl_arch_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9048bd32e86f..7c073298aabf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -300,9 +300,6 @@ extern struct list_head rdt_all_groups;
 
 extern int max_name_width, max_data_width;
 
-int __init rdtgroup_init(void);
-void __exit rdtgroup_exit(void);
-
 /**
  * struct rftype - describe each file in the resctrl file system
  * @name:	File name
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 06565153ceb2..9f2fafcf78f1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -941,7 +941,7 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in rdtgroup_init().
+	 * control group, which will be setup later in resctrl_init().
 	 */
 	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 871b59c2c886..997f31ee5de4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4118,14 +4118,14 @@ void resctrl_offline_cpu(unsigned int cpu)
 }
 
 /*
- * rdtgroup_init - rdtgroup initialization
+ * resctrl_init - resctrl filesystem initialization
  *
  * Setup resctrl file system including set up root, create mount point,
- * register rdtgroup filesystem, and initialize files under root directory.
+ * register resctrl filesystem, and initialize files under root directory.
  *
  * Return: 0 on success or -errno
  */
-int __init rdtgroup_init(void)
+int __init resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4173,7 +4173,7 @@ int __init rdtgroup_init(void)
 	return ret;
 }
 
-void __exit rdtgroup_exit(void)
+void __exit resctrl_exit(void)
 {
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index bf736ec22f71..de0297f6167a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -336,4 +336,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int __init resctrl_init(void);
+void __exit resctrl_exit(void);
+
 #endif /* _RESCTRL_H */
-- 
2.34.1


