Return-Path: <linux-kernel+bounces-160237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DC8B3ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7556D1C21857
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250B16EC0B;
	Fri, 26 Apr 2024 15:10:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE816F27E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144213; cv=none; b=Kpc4+aLbzdxvhMphI8pEhz7xd/BOdYQXvQSOu7K3JCL4IeLVhHR43wZNEpIHNcr85HvespnRfGN52pSySeRL9sTNfjRPll/01LwXgWGzJTocO92v9qhqD3e/v4fIj4Y/r3N/NOvsCo+cmKSZ/g+dWo93vfMLbObRwf4Aqfg5xJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144213; c=relaxed/simple;
	bh=3CQjFq3Kxl4J3FXEGI61L0tlwo5ylxs29Vx+oBx4OTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sv8vEzZdJRr8jrQ6gPBqS3vFuCoEwuUX3n1sM+KoqHSGpbKHw8Tv8wK3/84rwadvQTN2//JWXqYNi8epk7VNSIN3p7WLTzVIeOZVbq3vEkoFL7nu4D8om2Tie6IKL6wqgvtN6ChAJcu5vp8EIuqNYV4BnZcjtQl1V7U9zMJeBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DF21682;
	Fri, 26 Apr 2024 08:10:39 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84BC43F73F;
	Fri, 26 Apr 2024 08:10:08 -0700 (PDT)
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
Subject: [PATCH v2 19/35] x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
Date: Fri, 26 Apr 2024 16:08:48 +0100
Message-Id: <20240426150904.8854-19-Dave.Martin@arm.com>
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
index c69241447cc2..a0b911f4f193 100644
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
2.34.1


