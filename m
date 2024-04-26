Return-Path: <linux-kernel+bounces-160252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07818B3AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22184B26007
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEB176FA7;
	Fri, 26 Apr 2024 15:10:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB85175541
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144258; cv=none; b=pLTUsknPsTstYaOZiHphFaTMCT+TevhVUf1LoBEEQIuug4HheH3AlSFDdDVMgPMkVV21Mzw9x1mHCQFozFmeZVz/xODKOvEsAZ4y5Re+renyVeU4ZR4CxlnVG6eypV06x97IJB499XU3WcpdumWlt7OcsStPR3ao74sofCbqdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144258; c=relaxed/simple;
	bh=eqo9pDDGltWBh/jbE5OxwbESAse+eEPKEfKd/1qke4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dslOfQ8zRWM1qCcnIu9AovOGBQLuB9zgyLyHrfrthR+ZiAxElOSj6oUByXvJnDh4yaX+tenWH/lN4DqURPQ1xUWvalXXDBc1Julh1SLQBJrVJL6KKhDNj2m2yd1YOoK3hAX3g3t9BtN7Lbs+pzhGJIw0zYLgNQ2PWjVn8w3ryhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0AE01007;
	Fri, 26 Apr 2024 08:11:23 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE3F3F73F;
	Fri, 26 Apr 2024 08:10:52 -0700 (PDT)
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
Subject: [PATCH v2 33/35] x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
Date: Fri, 26 Apr 2024 16:09:02 +0100
Message-Id: <20240426150904.8854-33-Dave.Martin@arm.com>
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

Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
on definitions in x86's internal.h.

Move definitions in internal.h that need to be shared between the
filesystem and architecture code to header files that fs/resctrl can
include.

Doing this separately means the filesystem code only moves between files
of the same name, instead of having these changes mixed in too.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

FYI: James Morse (et al.):

 * This patch needs review to see how many of the x86-specific
   definitions really ought to be exported...

 * The resctrl_types.h header should have a comment explaining its
   content and purpose (once we have that nailed down).

Changes in v2:

 * Revert apparently unintentional duplication of a couple of variable
   declarations in <linux/resctrl.h>.

   No functional change.
---
 arch/x86/include/asm/resctrl.h         |  3 +++
 arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++
 arch/x86/kernel/cpu/resctrl/internal.h | 36 --------------------------
 include/linux/resctrl_types.h          | 30 +++++++++++++++++++++
 4 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index a8bc1d68f889..506ecd04788b 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -218,6 +218,9 @@ int resctrl_arch_measure_l2_residency(void *_plr);
 int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
+
 #else
 
 static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f94ad04023c3..c0fb2e22e110 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -306,6 +306,11 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].cdp_enabled;
+}
+
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3707f5ccfeda..e4244e771ef6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -14,12 +14,6 @@
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
 
-#define CQM_LIMBOCHECK_INTERVAL	1000
-
-#define MBM_CNTR_WIDTH_BASE		24
-#define MBM_OVERFLOW_INTERVAL		1000
-#define MAX_MBA_BW			100u
-#define MBA_IS_LINEAR			0x4
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
@@ -209,29 +203,6 @@ struct rdtgroup {
 	struct pseudo_lock_region	*plr;
 };
 
-/* rdtgroup.flags */
-#define	RDT_DELETED		1
-
-/* rftype.flags */
-#define RFTYPE_FLAGS_CPUS_LIST	1
-
-/*
- * Define the file type flags for base and info directories.
- */
-#define RFTYPE_INFO			BIT(0)
-#define RFTYPE_BASE			BIT(1)
-#define RFTYPE_CTRL			BIT(4)
-#define RFTYPE_MON			BIT(5)
-#define RFTYPE_TOP			BIT(6)
-#define RFTYPE_RES_CACHE		BIT(8)
-#define RFTYPE_RES_MB			BIT(9)
-#define RFTYPE_DEBUG			BIT(10)
-#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
-#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
-#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
-#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
-#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
-
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
 
@@ -369,13 +340,6 @@ static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 	return &hw_res->r_resctrl;
 }
 
-static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
-{
-	return rdt_resources_all[l].cdp_enabled;
-}
-
-int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
-
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 4788bd95dac6..fe0b10b589c0 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -7,6 +7,36 @@
 #ifndef __LINUX_RESCTRL_TYPES_H
 #define __LINUX_RESCTRL_TYPES_H
 
+#define CQM_LIMBOCHECK_INTERVAL	1000
+
+#define MBM_CNTR_WIDTH_BASE		24
+#define MBM_OVERFLOW_INTERVAL		1000
+#define MAX_MBA_BW			100u
+#define MBA_IS_LINEAR			0x4
+
+/* rdtgroup.flags */
+#define	RDT_DELETED		1
+
+/* rftype.flags */
+#define RFTYPE_FLAGS_CPUS_LIST	1
+
+/*
+ * Define the file type flags for base and info directories.
+ */
+#define RFTYPE_INFO			BIT(0)
+#define RFTYPE_BASE			BIT(1)
+#define RFTYPE_CTRL			BIT(4)
+#define RFTYPE_MON			BIT(5)
+#define RFTYPE_TOP			BIT(6)
+#define RFTYPE_RES_CACHE		BIT(8)
+#define RFTYPE_RES_MB			BIT(9)
+#define RFTYPE_DEBUG			BIT(10)
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
+
 /* Reads to Local DRAM Memory */
 #define READS_TO_LOCAL_MEM		BIT(0)
 
-- 
2.34.1


