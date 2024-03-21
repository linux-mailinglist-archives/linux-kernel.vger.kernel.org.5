Return-Path: <linux-kernel+bounces-110445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876F885F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399FA1C22A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42B142912;
	Thu, 21 Mar 2024 16:53:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B95142902
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039982; cv=none; b=sG8kEELGCpiVncQOovyG4hIIKVGHFGCNJ9vMlPBeanfKamI8+/n2vb1W0UymqhtG8cm8DajkE1t9mEw47LaadVBlwJfTFl+MGV8/vdyQ0UZ1EDlU7jbODluX+BPXQaeS8YHSBsdFzFnly86+UI4RHKXB32M47nuMW925I8sQNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039982; c=relaxed/simple;
	bh=T88a3dvbF49aC2qKu/i0t9netSqmUU/dw4wLFshprXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i82uCTM7NP/JZjejSdwRExjOAeOZ53oxRX0SYRLua3DxEA/Svd9t9RMYtoAd8gH6baxUVHq6m+RkRqMZpYFLF34Qh7Dp4sKr/e6YePTeDGaa0SgXkXtNWVAPb+WnXkPv5jkrZyVC8QwzXmYRK437EAcNkcvV/iu8rBLlFpfLgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BECF1007;
	Thu, 21 Mar 2024 09:53:34 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CB9B3F67D;
	Thu, 21 Mar 2024 09:52:57 -0700 (PDT)
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
Subject: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted symbols
Date: Thu, 21 Mar 2024 16:51:03 +0000
Message-Id: <20240321165106.31602-29-james.morse@arm.com>
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

Because ARM's MPAM controls are probed using MMIO, resctrl can't be
initialised until enough CPUs are online to have determined the
system-wide supported num_closid. Arm64 also supports 'late onlined
secondaries', where only a subset of CPUs are online during boot.

These two combine to mean the MPAM driver may not be able to initialise
resctrl until user-space has brought 'enough' CPUs online.

To allow MPAM to initialise resctrl after __init text has been free'd,
remove all the __init markings from resctrl.

The existing __exit markings cause these functions to be removed by the
linker as it has never been possible to build resctrl as a module. MPAM
has an error interrupt which causes the driver to reset and disable
itself. Remove the __exit markings to allow the MPAM driver to tear down
resctrl when an error occurs.

Signed-off-by: James Morse <james.morse@arm.com>
---
If 'late onlined secondaries' is an alien concept, I can add a worked
example to the commit message:
If a system has two L3 caches, but during boot only CPU-0 is online,
then no CPU is able to probe the features of the second L3 cache.
It's not until user-space brings other CPUs online that the MPAM
driver can finally get a glimpse of all the hardware to determine
what properties the system has.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 include/linux/resctrl.h                | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3a3962736061..56218193a8ba 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -457,7 +457,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit resctrl_mon_resource_exit(void);
+void resctrl_mon_resource_exit(void);
 bool rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8b316d9acc3b..7e6fca138cb7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -954,7 +954,7 @@ static int dom_data_init(struct rdt_resource *r)
 	return err;
 }
 
-static void __exit dom_data_exit(struct rdt_resource *r)
+static void dom_data_exit(struct rdt_resource *r)
 {
 	if (!r->mon_capable)
 		return;
@@ -1076,7 +1076,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
-void __exit resctrl_mon_resource_exit(void)
+void resctrl_mon_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 218aebd6387f..1425a33d201d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2069,7 +2069,7 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-static void __init thread_throttle_mode_init(void)
+static void thread_throttle_mode_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	struct rftype *rft;
@@ -3997,7 +3997,7 @@ static void rdtgroup_destroy_root(void)
 	rdtgroup_default.kn = NULL;
 }
 
-static void __init rdtgroup_setup_default(void)
+static void rdtgroup_setup_default(void)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -4190,7 +4190,7 @@ void resctrl_offline_cpu(unsigned int cpu)
  *
  * Return: 0 on success or -errno
  */
-int __init resctrl_init(void)
+int resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4244,7 +4244,7 @@ int __init resctrl_init(void)
 	return ret;
 }
 
-void __exit resctrl_exit(void)
+void resctrl_exit(void)
 {
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f463fb949677..5da55e58f229 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -393,7 +393,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-int __init resctrl_init(void);
-void __exit resctrl_exit(void);
+int resctrl_init(void);
+void resctrl_exit(void);
 
 #endif /* _RESCTRL_H */
-- 
2.39.2


