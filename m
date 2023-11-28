Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100A7FB001
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjK1CRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1CRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:17:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A82C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701137862; x=1732673862;
  h=from:to:cc:subject:date:message-id;
  bh=Mqlq3K5J8Jb/BL5Z7mobq/CeObw61HVY7DiZkn5SkD4=;
  b=NFwJw+mT4AZ61X8pGv9HBK0XAepZ/Ow23VQ3PpZwVMiRpWqXs5WKjIa2
   Ir5CQJQx8DilmB0VvQ8systftZd1l71tzpI2SIgGoN+XTrEZrMAxfHnHc
   axjosF8pI4eLdd26scOSnMOViamMuPW3kC8n+5zkyw9K4uQsr46oPjuWW
   hR4GU0nwMmkRWXfhYBuFo18yfn29RvMazZp82lwiqse0r8X55u/hZC6GE
   f92zzRotAvKfZRRN90gwHixoV1NcuPeF57oKfjLRSxcbqB5fGC721lAiG
   3jl5GBQd26ljn7++NdcJkGGE3NWv8LEXCn/he/SJJMcQRo75Ff7cuoAqB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="14392210"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="14392210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 18:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744766102"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="744766102"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2023 18:17:35 -0800
From:   Tina Zhang <tina.zhang@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        torvalds@linux-foundation.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH] iommu: Change kconfig around IOMMU_SVA
Date:   Tue, 28 Nov 2023 10:16:35 +0800
Message-Id: <20231128021635.5530-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Linus suggested that the kconfig here is confusing:

https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/

Let's break it into three kconfigs controlling distinct things:

 - CONFIG_IOMMU_MM_DATA controls if the mm_struct has the additional
   fields for the IOMMU. Currently only PASID, but later patches store
   a struct iommu_mm_data *

 - CONFIG_ARCH_HAS_CPU_PASID controls if the arch needs the scheduling bit
   for keeping track of the ENQCMD instruction. x86 will select this if
   IOMMU_SVA is enabled

 - IOMMU_SVA controls if the IOMMU core compiles in the SVA support code
   for iommu driver use and the IOMMU exported API

This way ARM will not enable CONFIG_ARCH_HAS_CPU_PASID

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 arch/Kconfig             | 5 +++++
 arch/x86/Kconfig         | 1 +
 arch/x86/kernel/traps.c  | 2 +-
 drivers/iommu/Kconfig    | 1 +
 include/linux/iommu.h    | 2 +-
 include/linux/mm_types.h | 2 +-
 include/linux/sched.h    | 2 +-
 kernel/fork.c            | 2 +-
 mm/Kconfig               | 3 +++
 mm/init-mm.c             | 2 +-
 10 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..3e49f862670e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -301,6 +301,11 @@ config ARCH_HAS_DMA_CLEAR_UNCACHED
 config ARCH_HAS_CPU_FINALIZE_INIT
 	bool
 
+# The architecture has a per-task state that includes the mm's PASID
+config ARCH_HAS_CPU_PASID
+	bool
+	select IOMMU_MM_DATA
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..68a2ec36a46e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -71,6 +71,7 @@ config X86
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
+	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..2b62dbb3396a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -565,7 +565,7 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
  */
 static bool try_fixup_enqcmd_gp(void)
 {
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_ARCH_HAS_CPU_PASID
 	u32 pasid;
 
 	/*
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 7673bb82945b..9a29d742617e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -160,6 +160,7 @@ config IOMMU_DMA
 
 # Shared Virtual Addressing
 config IOMMU_SVA
+	select IOMMU_MM_DATA
 	bool
 
 config FSL_PAMU
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ec289c1016f5..f16cca7899ec 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1336,7 +1336,7 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 	return false;
 }
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_DATA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = IOMMU_PASID_INVALID;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..41f248608dd9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -938,7 +938,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_DATA
 		u32 pasid;
 #endif
 #ifdef CONFIG_KSM
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..70888a36677b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -954,7 +954,7 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd:1;
 #endif
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_ARCH_HAS_CPU_PASID
 	unsigned			pasid_activated:1;
 #endif
 #ifdef	CONFIG_CPU_SUP_INTEL
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..43fd9bc1a522 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1179,7 +1179,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_ARCH_HAS_CPU_PASID
 	tsk->pasid_activated = 0;
 #endif
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..0143f4d905c9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1270,6 +1270,9 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config IOMMU_MM_DATA
+	bool
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/init-mm.c b/mm/init-mm.c
index cfd367822cdd..c52dc2740a3d 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -44,7 +44,7 @@ struct mm_struct init_mm = {
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_DATA
 	.pasid		= IOMMU_PASID_INVALID,
 #endif
 	INIT_MM_CONTEXT(init_mm)
-- 
2.17.1

