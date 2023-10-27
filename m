Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D737D8C71
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjJ0AGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0AGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C96198
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698365163; x=1729901163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aoYQBrauiifaU79nYNLhVzpXpMzU9lIurHIq1aDxU9U=;
  b=Am/4FQ65f3/o01o6B/H4ExBLsUiEryYRbryVF1vkKNP3lYpimNA3xozt
   OySWGdKSpabIyp7epJr/Dql3znXSXm3ntb8NkNEAMeXsOa8h8DjT8xNxe
   XJ5PL4SFWiU2NBfVCSzEAmwotESJ3QSmiir+xbMMq4reNdEyrz/BPMkrp
   Ob+cImbhroV16kgziVEISqUyse8V/BdYLgsSpccqaOPJ60OUroobShFbO
   TjwO9ECFAQnOuaR3YESGETdSVhul6DYLWmhuoFIml7bxHqYPgZxy6D62Y
   GPazdVO+2TuzWZWG0RSHh8aqdgZWDOhwikAYb8zWdakQZRBXKcdTDlZmB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="390535921"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="390535921"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 17:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="883017474"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="883017474"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2023 17:05:59 -0700
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Date:   Fri, 27 Oct 2023 08:05:20 +0800
Message-Id: <20231027000525.1278806-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231027000525.1278806-1-tina.zhang@intel.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index 12d51495caec..35b9fd559bb6 100644
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
index 66bfabae8814..afd9c2dc228b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -72,6 +72,7 @@ config X86
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
index 3199fd54b462..52fa02f1b675 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -156,6 +156,7 @@ config IOMMU_DMA
 
 # Shared Virtual Addressing
 config IOMMU_SVA
+	select IOMMU_MM_DATA
 	bool
 
 config FSL_PAMU
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b5b254e205c6..c1f2b6f9a3d0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1189,7 +1189,7 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 	return false;
 }
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_DATA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = IOMMU_PASID_INVALID;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..330f3cd8d5ad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -881,7 +881,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_DATA
 		u32 pasid;
 #endif
 #ifdef CONFIG_KSM
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..3ac8e8556c3d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -949,7 +949,7 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd:1;
 #endif
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_ARCH_HAS_CPU_PASID
 	unsigned			pasid_activated:1;
 #endif
 #ifdef	CONFIG_CPU_SUP_INTEL
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..d28f0d4582dc 100644
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
index 264a2df5ecf5..fee4a15e444b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1258,6 +1258,9 @@ config LOCK_MM_AND_FIND_VMA
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
2.39.3

