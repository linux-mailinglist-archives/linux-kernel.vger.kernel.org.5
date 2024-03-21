Return-Path: <linux-kernel+bounces-110436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBE885F02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E81C20627
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57F13F430;
	Thu, 21 Mar 2024 16:52:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD113F428
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039953; cv=none; b=kuK8ZDcYVsblmB3D8Rvj1L0ga5S0Il1MteJsHXe9fjkh4q0yJ71vgeARNlEOXudJIgOZDITvG9Ut103LR+eCFo+lCxyIABki1h0yXOzV/QfSx/gqebMUNXxShNMlDhbEzqgy65i+XriF01FRy9y7AfUSqcpSgHc3WbVlW7K8Yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039953; c=relaxed/simple;
	bh=C6xXh+wwTeBnclsu7Sb4YLHjfN3HGijN3h/ze9nWcZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPyZpeDUrHyXcW7eeboUOJAaNi98DETbeArUoMCIKVs2A1KpkyVx7D/RkkaLYkjdGiny/0sA400PPI3O7bIU+fyLvNLINmYu/X6cJzN+ZNrfgRl1pGzBnb3/l5y1AArkbXZoTdcpPJZLuQvykLNz4wahTPCkj9tUfs93uI5NEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CE2D1007;
	Thu, 21 Mar 2024 09:53:05 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EED53F67D;
	Thu, 21 Mar 2024 09:52:28 -0700 (PDT)
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
Subject: [PATCH v1 19/31] x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
Date: Thu, 21 Mar 2024 16:50:54 +0000
Message-Id: <20240321165106.31602-20-james.morse@arm.com>
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

resctrl's pseudo lock has some copy-to-cache and measurement
functions that are micro-architecture specific. pseudo_lock_fn()
is not at all portable. Label these 'resctrl_arch_' so they stay
under /arch/x86.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h            |  5 ++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 36 ++++++++++++-----------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 50407e83d0ca..a88af68f9fe2 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -211,6 +211,11 @@ static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid
 static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
 					     void *ctx) { };
 
+u64 resctrl_arch_get_prefetch_disable_bits(void);
+int resctrl_arch_pseudo_lock_fn(void *_rdtgrp);
+int resctrl_arch_measure_cycles_lat_fn(void *_plr);
+int resctrl_arch_measure_l2_residency(void *_plr);
+int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index f2315a50ea4f..856beb6f668b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -62,7 +62,8 @@ static const struct class pseudo_lock_class = {
 };
 
 /**
- * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ * resctrl_arch_get_prefetch_disable_bits - prefetch disable bits of supported
+ *                                          platforms
  * @void: It takes no parameters.
  *
  * Capture the list of platforms that have been validated to support
@@ -76,13 +77,13 @@ static const struct class pseudo_lock_class = {
  * in the SDM.
  *
  * When adding a platform here also add support for its cache events to
- * measure_cycles_perf_fn()
+ * resctrl_arch_measure_l*_residency()
  *
  * Return:
  * If platform is supported, the bits to disable hardware prefetchers, 0
  * if platform is not supported.
  */
-static u64 get_prefetch_disable_bits(void)
+u64 resctrl_arch_get_prefetch_disable_bits(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86 != 6)
@@ -410,7 +411,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 }
 
 /**
- * pseudo_lock_fn - Load kernel memory into cache
+ * resctrl_arch_pseudo_lock_fn - Load kernel memory into cache
  * @_rdtgrp: resource group to which pseudo-lock region belongs
  *
  * This is the core pseudo-locking flow.
@@ -428,7 +429,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
  *
  * Return: 0. Waiter on waitqueue will be woken on completion.
  */
-static int pseudo_lock_fn(void *_rdtgrp)
+int resctrl_arch_pseudo_lock_fn(void *_rdtgrp)
 {
 	struct rdtgroup *rdtgrp = _rdtgrp;
 	struct pseudo_lock_region *plr = rdtgrp->plr;
@@ -714,7 +715,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * Not knowing the bits to disable prefetching implies that this
 	 * platform does not support Cache Pseudo-Locking.
 	 */
-	prefetch_disable_bits = get_prefetch_disable_bits();
+	prefetch_disable_bits = resctrl_arch_get_prefetch_disable_bits();
 	if (prefetch_disable_bits == 0) {
 		rdt_last_cmd_puts("Pseudo-locking not supported\n");
 		return -EINVAL;
@@ -879,7 +880,8 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 }
 
 /**
- * measure_cycles_lat_fn - Measure cycle latency to read pseudo-locked memory
+ * resctrl_arch_measure_cycles_lat_fn - Measure cycle latency to read
+ *                                      pseudo-locked memory
  * @_plr: pseudo-lock region to measure
  *
  * There is no deterministic way to test if a memory region is cached. One
@@ -892,7 +894,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
  *
  * Return: 0. Waiter on waitqueue will be woken on completion.
  */
-static int measure_cycles_lat_fn(void *_plr)
+int resctrl_arch_measure_cycles_lat_fn(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	u32 saved_low, saved_high;
@@ -1076,7 +1078,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	return 0;
 }
 
-static int measure_l2_residency(void *_plr)
+int resctrl_arch_measure_l2_residency(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	struct residency_counts counts = {0};
@@ -1114,7 +1116,7 @@ static int measure_l2_residency(void *_plr)
 	return 0;
 }
 
-static int measure_l3_residency(void *_plr)
+int resctrl_arch_measure_l3_residency(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	struct residency_counts counts = {0};
@@ -1212,18 +1214,18 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 	plr->cpu = cpu;
 
 	if (sel == 1)
-		thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
-						cpu_to_node(cpu),
+		thread = kthread_create_on_node(resctrl_arch_measure_cycles_lat_fn,
+						plr, cpu_to_node(cpu),
 						"pseudo_lock_measure/%u",
 						cpu);
 	else if (sel == 2)
-		thread = kthread_create_on_node(measure_l2_residency, plr,
-						cpu_to_node(cpu),
+		thread = kthread_create_on_node(resctrl_arch_measure_l2_residency,
+						plr, cpu_to_node(cpu),
 						"pseudo_lock_measure/%u",
 						cpu);
 	else if (sel == 3)
-		thread = kthread_create_on_node(measure_l3_residency, plr,
-						cpu_to_node(cpu),
+		thread = kthread_create_on_node(resctrl_arch_measure_l3_residency,
+						plr, cpu_to_node(cpu),
 						"pseudo_lock_measure/%u",
 						cpu);
 	else
@@ -1322,7 +1324,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	plr->thread_done = 0;
 
-	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
+	thread = kthread_create_on_node(resctrl_arch_pseudo_lock_fn, rdtgrp,
 					cpu_to_node(plr->cpu),
 					"pseudo_lock/%u", plr->cpu);
 	if (IS_ERR(thread)) {
-- 
2.39.2


