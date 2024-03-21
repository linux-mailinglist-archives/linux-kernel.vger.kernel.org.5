Return-Path: <linux-kernel+bounces-110422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5E885EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987C91C21D22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E134139588;
	Thu, 21 Mar 2024 16:51:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A358139579
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039911; cv=none; b=qxwmX5+MCYIZ8rGcLZbunTbS84ommJ9mNMjo9fr8hd2AYmiyOkjxCENFXirETGB2qnNy+Ws5amyj6xCTqGDtie//MkwgbHnyFQ8dEipyk1qMYZn2Opt0xTgX+BUyiBpoJ2PmAv1npvxOLWE6mgRS0g9vnog4NyMeA4kkoAcQPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039911; c=relaxed/simple;
	bh=5w+JNJyOYRaWpWJB2SC1m6D4Ky4uBiczPuWcI4IQlyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twmwqEVRJwRlQlwGj5U0Vfi3ZLl6mYeZqAU2L0RE3MGFHakszSGjVi5F6l2MyHaACr9hSaUBg8Idf6Z17VKgUl6ImmXoj044yyDi8b52J5cji/mRGU2DfIAQR4OV2LNszi3T9EdkJ8isCarhvxcwvZiV/UNJCLTXaPw/qqKvPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 373E41007;
	Thu, 21 Mar 2024 09:52:23 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED3D03F67D;
	Thu, 21 Mar 2024 09:51:45 -0700 (PDT)
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
Subject: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
Date: Thu, 21 Mar 2024 16:50:41 +0000
Message-Id: <20240321165106.31602-7-james.morse@arm.com>
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

rdtgroup_init() needs exporting so that arch code can call it once
it lives in core code. As this is one of the few functions we export,
rename it to have the resctrl in the name. The same goes for the exit
call.

x86's arch code init functions for RDT are renamed to have an arch
prefix to make it clear these are part of the architecture code.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                |  3 +++
 4 files changed, 13 insertions(+), 13 deletions(-)

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
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 18f097fce51e..1a49c9918f8d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4116,14 +4116,14 @@ void resctrl_offline_cpu(unsigned int cpu)
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
 
@@ -4171,7 +4171,7 @@ int __init rdtgroup_init(void)
 	return ret;
 }
 
-void __exit rdtgroup_exit(void)
+void __exit resctrl_exit(void)
 {
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2b79e4159507..f6a4b75f8122 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -325,4 +325,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int __init resctrl_init(void);
+void __exit resctrl_exit(void);
+
 #endif /* _RESCTRL_H */
-- 
2.39.2


