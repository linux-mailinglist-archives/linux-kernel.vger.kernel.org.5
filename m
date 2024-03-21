Return-Path: <linux-kernel+bounces-110447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD8F885F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BEA284028
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6C143C6C;
	Thu, 21 Mar 2024 16:53:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C97143C5B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039988; cv=none; b=oq4W9qqX3izqtc+JAy+ZQZC9duT1szeD2RHDqgHpCOztZMvWHqXtmX94t4lPKoNFV2xXRjQfiSs5EE6qk1THbnVFjMz/VbJ+vXsqT1/jPx8dEsZUepzGCvBn1hujb9E/Pd9XrNf2JZ9U0ycqd9v6JrYz2b+aJ66/EpUMK4ntNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039988; c=relaxed/simple;
	bh=uN/oLY3JOvVXzT2EgdfCWvMJl7p/P8HSCQ/NUtseHAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmwtzwUc1bpPzQxy62HnlyYLV29wc0Jdtk8c3ncEgApN7UsA+J/lr0RPVE7XQARvDtbOP3eJqT3aExVJ1u3hp+GdYGwjbDoadjp+Fh4EUKWz5O7UuDLW1UfYJVXJNfC0mTRDSTl++elx2Q0PN1roNlaPmiu9q49hJD8YRFwRkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 056FF168F;
	Thu, 21 Mar 2024 09:53:41 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD9F3F67D;
	Thu, 21 Mar 2024 09:53:03 -0700 (PDT)
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
Subject: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
Date: Thu, 21 Mar 2024 16:51:05 +0000
Message-Id: <20240321165106.31602-31-james.morse@arm.com>
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

Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
on definitions in x86's internal.h.

Move definitions in internal.h that need to be shared between the
filesystem and architecture code to header files that fs/resctrl can
include.

Doing this separately means the filesystem code only moves between files
of the same name, instead of having these changes mixed in too.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         |  3 +++
 arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++
 arch/x86/kernel/cpu/resctrl/internal.h | 36 --------------------------
 include/linux/resctrl.h                |  3 +++
 include/linux/resctrl_types.h          | 30 +++++++++++++++++++++
 5 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 491342f56811..746431c66fc4 100644
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
index 56218193a8ba..0f7e3f10941b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -15,12 +15,6 @@
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
 
-#define CQM_LIMBOCHECK_INTERVAL	1000
-
-#define MBM_CNTR_WIDTH_BASE		24
-#define MBM_OVERFLOW_INTERVAL		1000
-#define MAX_MBA_BW			100u
-#define MBA_IS_LINEAR			0x4
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
@@ -210,29 +204,6 @@ struct rdtgroup {
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
 
@@ -370,13 +341,6 @@ static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
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
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f786ffceeda3..00cc0457af50 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -41,6 +41,9 @@ int proc_resctrl_show(struct seq_file *m,
  */
 #define RESCTRL_MAX_CBM			32
 
+extern unsigned int resctrl_rmid_realloc_limit;
+extern unsigned int resctrl_rmid_realloc_threshold;
+
 /**
  * struct pseudo_lock_region - pseudo-lock region information
  * @s:			Resctrl schema for the resource to which this
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
2.39.2


