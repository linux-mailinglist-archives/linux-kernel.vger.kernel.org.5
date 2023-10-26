Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047727D83DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjJZNvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:51:03 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F991B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:51:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b5220ea82cso539778b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698328259; x=1698933059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg6AocFO/lbRQYyoxVEeWxWhMm2rZTnhhrkwgMrP6RQ=;
        b=JukPOS7LsefnKLm5fLc0NrVgyb536NZeAnhRXuFjwU3bhDslyxAAqpEjTpLruDB2Pi
         gQJtvRzWspy4z+uNyNMuRQ8OG/RPZ2lycl3ZYQFbcXNwMeniFB2ET35g9bbqdkY9Btq9
         ciCV1VLgL/uIH6lNE/2uPjrP1g2NeBJBNWDdO+nSHTfhqgFi+zFtgBXb1arzk48hJGBl
         Cne7uypO4wlBKwRn19o9n38aCNd5z2o8lznv3gN93urrCeyB31fWhc6XnXUSOnivK6YU
         yDdqkPoCnAhuGbE6X8S9FRqHyG0HSCfo0qx36GpkMnyW1pXbZrktqbYUYOrURqLgIdOs
         iEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328259; x=1698933059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg6AocFO/lbRQYyoxVEeWxWhMm2rZTnhhrkwgMrP6RQ=;
        b=cDBjHT/hTHESC0nUfqQuSddyqG260m0QjSwb3ckkwDteGo4Gx0+lk0q1Vzpm8CBVcX
         xuUR2NhHfBXfiEE5RfMtUri5DDYFUS9ECeiVe0+WqKY2gwiGOApYkdj/Kby4dJWkPWe1
         1qDMrdKvqFXTceVHiaTetVFGtzNaeud2o63BDd6GsIbNB+cn1+Pehznknnhr5njUfFCo
         0KmyHHmoGDvQc6daxgy/xekl4df97R8w2VWSDpSySNIAFFbqccUpOBjPi7eDBxvaujqN
         xS7rE9DkzNmaOIevJz+6wguM64IlKaAm2/nlMgWWTFWLTbSB/8KDdhb/ui4uFG3byz1n
         7t4Q==
X-Gm-Message-State: AOJu0YzBxQOhuvMewYujMXIdMaMEvvTJY1T3iC27PrRaW5IKPGoXxIuU
        f0YZ8DasFq1UOF9JervyhGAkng==
X-Google-Smtp-Source: AGHT+IHEakn4stiIuYdte2LgZf1zAkQCKOHgBaMMmrHM2HabE+dFqWIWyLFYWVoDo4Jcmuuu5H6DZg==
X-Received: by 2002:a05:6808:4c7:b0:3af:6595:e53 with SMTP id a7-20020a05680804c700b003af65950e53mr19610827oie.13.1698328259713;
        Thu, 26 Oct 2023 06:50:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id 4-20020aca1004000000b003af642cf646sm2771408oiq.37.2023.10.26.06.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:50:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qw0lG-0058I3-CB;
        Thu, 26 Oct 2023 10:50:58 -0300
Date:   Thu, 26 Oct 2023 10:50:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <20231026135058.GW691768@ziepe.ca>
References: <20231018050640.24936-1-tina.zhang@intel.com>
 <ZToUOKSqqI6Bh_03@8bytes.org>
 <20231026122016.GU691768@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026122016.GU691768@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:20:16AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 09:24:40AM +0200, Joerg Roedel wrote:
> > Hi Tina,
> > 
> > On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:
> > > Tina Zhang (5):
> > >   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
> > >   iommu: Add mm_get_enqcmd_pasid() helper function
> > >   mm: Add structure to keep sva information
> > >   iommu: Support mm PASID 1:n with sva domains
> > >   mm: Deprecate pasid field
> > 
> > Thanks for doing this, it all looks reasonable to me. But there is one
> > thing missing which needs to be done before we can move forward with
> > this.
> > 
> > There was a discussion about the Kconfig symbol naming used in
> > mm_struct. Please see the discussion here:
> > 
> > 	https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
> >
> > Please update this patch-set to solve this and I will take the series.
> 
> Lets call it CONFIG_IOMMU_MM_DATA then. It is still pretty nonsensical
> but it speaks to what it does after this series

This is what I came up with:

From ca97b6cb94eadc4066d762aa4c54e7ba9789f3f4 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Thu, 26 Oct 2023 10:43:12 -0300
Subject: [PATCH] iommu: Change kconfig around IOMMU_SVA

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
index 12d51495caec18..35b9fd559bb697 100644
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
index 66bfabae881491..afd9c2dc228bdf 100644
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
index c876f1d36a81a7..2b62dbb3396add 100644
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
index 5cc869db1b79fc..0f9c3f6ae8d32d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -160,6 +160,7 @@ config IOMMU_DMA
 
 # Shared Virtual Addressing
 config IOMMU_SVA
+	select IOMMU_MM_DATA
 	bool
 
 config FSL_PAMU
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8fb1b41b4d1580..0d2e01404c3e50 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1324,7 +1324,7 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 	return false;
 }
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_MM_DATA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = IOMMU_PASID_INVALID;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e608..330f3cd8d5ad97 100644
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
index 77f01ac385f7a5..3ac8e8556c3d93 100644
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
index 3b6d20dfb9a85e..d28f0d4582dcc1 100644
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
index 264a2df5ecf5b9..fee4a15e444b74 100644
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
index cfd367822cdd2e..c52dc2740a3de2 100644
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
2.42.0

