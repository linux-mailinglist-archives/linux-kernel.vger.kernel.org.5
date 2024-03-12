Return-Path: <linux-kernel+bounces-100611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB7879AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480101C20AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04421139562;
	Tue, 12 Mar 2024 17:34:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8513B2B9;
	Tue, 12 Mar 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264889; cv=none; b=GXCoNzaJDfZh5ERZp2RGyyy2820JevHtbv2zsqNspUQxJ59U/f8/ss+WFR5s1J9htAWHutF8LOGrtXw5cZG3zXk0TOdrJ/+d3r+NjP6+uHIr/yF+FLDluuMsHjFpBLdwRJ8T6+kkxzWqf+4HS1+6gm5ckVXMgH91zOEsDz11NfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264889; c=relaxed/simple;
	bh=ly3HaBe9vtMk2jYPDMggchPOQ6u0+eGXSzfzFKjbauA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQLcxvTOmf+LY2Z2311zu7lq1TOxfAn4ImleXslamH92rXvuD0Fr94kAeVz5XS90IqtSs/o7D/PGnLxLFaIRdwgyAuwIncOin1uiggi3UPTXxoi0mOyvdP78nGgBvv61ofUrPT8PLMg2rFL+2viMT0za3RdNiHFRoZH84vg+Fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 209621570;
	Tue, 12 Mar 2024 10:35:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 882003F762;
	Tue, 12 Mar 2024 10:34:44 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 09/10] x86: Use common uncore PMU capabilities
Date: Tue, 12 Mar 2024 17:34:11 +0000
Message-Id: <8a92d8b76ab0658919cd58515f68ed30c805e070.1710257512.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
References: <cover.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the x86 uncore PMU drivers over to the new common capabilities,
allowing to remove all the checks that perf core now takes care of.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/x86/events/amd/iommu.c        | 17 +----------------
 arch/x86/events/amd/power.c        | 10 +---------
 arch/x86/events/amd/uncore.c       | 12 +++---------
 arch/x86/events/intel/cstate.c     | 16 +++-------------
 arch/x86/events/intel/uncore.c     | 11 +----------
 arch/x86/events/intel/uncore_snb.c | 20 +++-----------------
 arch/x86/events/msr.c              |  9 +--------
 arch/x86/events/rapl.c             |  9 +--------
 8 files changed, 14 insertions(+), 90 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b15f7b950d2e..dd4cabb40865 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -207,21 +207,6 @@ static int perf_iommu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	/* test the event attr type check for PMU enumeration */
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	/*
-	 * IOMMU counters are shared across all cores.
-	 * Therefore, it does not support per-process mode.
-	 * Also, it does not support event sampling mode.
-	 */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	/* update the hw_perf_event struct with the iommu config data */
 	hwc->conf  = event->attr.config;
 	hwc->conf1 = event->attr.config1;
@@ -412,7 +397,7 @@ static const struct pmu iommu_pmu __initconst = {
 	.read		= perf_iommu_read,
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_iommu_attr_groups,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 };
 
 static __init int init_one_iommu(unsigned int idx)
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 37d5b380516e..d528517df93e 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -124,14 +124,6 @@ static int pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & AMD_POWER_EVENT_MASK;
 
-	/* Only look at AMD power events. */
-	if (event->attr.type != pmu_class.type)
-		return -ENOENT;
-
-	/* Unsupported modes and filters. */
-	if (event->attr.sample_period)
-		return -EINVAL;
-
 	if (cfg != AMD_POWER_EVENTSEL_PKG)
 		return -EINVAL;
 
@@ -212,7 +204,7 @@ static struct pmu pmu_class = {
 	.start		= pmu_event_start,
 	.stop		= pmu_event_stop,
 	.read		= pmu_event_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 	.module		= THIS_MODULE,
 };
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4220bf556962..6e97ee4ccf4d 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -209,12 +209,6 @@ static int amd_uncore_event_init(struct perf_event *event)
 	struct amd_uncore_ctx *ctx;
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	pmu = event_to_amd_uncore_pmu(event);
 	ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	if (!ctx)
@@ -700,7 +694,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.start		= amd_uncore_start,
 		.stop		= amd_uncore_stop,
 		.read		= amd_uncore_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_SAMPLING,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 		.module		= THIS_MODULE,
 	};
 
@@ -833,7 +827,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.start		= amd_uncore_start,
 		.stop		= amd_uncore_stop,
 		.read		= amd_uncore_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_SAMPLING,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 		.module		= THIS_MODULE,
 	};
 
@@ -958,7 +952,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.start		= amd_uncore_umc_start,
 				.stop		= amd_uncore_stop,
 				.read		= amd_uncore_read,
-				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_SAMPLING,
+				.capabilities	= PERF_PMU_UNCORE_CAPS,
 				.module		= THIS_MODULE,
 			};
 
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 3e4ab89d440c..58d6e5b483c5 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -319,16 +319,6 @@ static int cstate_pmu_event_init(struct perf_event *event)
 	u64 cfg = event->attr.config;
 	int cpu;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	/* unsupported modes and filters */
-	if (event->attr.sample_period) /* no sampling */
-		return -EINVAL;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	if (event->pmu == &cstate_core_pmu) {
 		if (cfg >= PERF_CSTATE_CORE_EVENT_MAX)
 			return -EINVAL;
@@ -530,7 +520,7 @@ static struct pmu cstate_core_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 	.module		= THIS_MODULE,
 };
 
@@ -545,7 +535,7 @@ static struct pmu cstate_pkg_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 	.module		= THIS_MODULE,
 };
 
@@ -560,7 +550,7 @@ static struct pmu cstate_module_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_SAMPLING | PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 	.module		= THIS_MODULE,
 };
 
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7927c0b832fa..031d5aff297a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -736,24 +736,15 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/* Sampling not supported yet */
-	if (hwc->sample_period)
-		return -EINVAL;
-
 	/*
 	 * Place all uncore events for a particular physical package
 	 * onto a single cpu
 	 */
-	if (event->cpu < 0)
-		return -EINVAL;
 	box = uncore_pmu_to_box(pmu, event->cpu);
 	if (!box || box->cpu < 0)
 		return -EINVAL;
@@ -919,7 +910,7 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 			.stop		= uncore_pmu_event_stop,
 			.read		= uncore_pmu_event_read,
 			.module		= THIS_MODULE,
-			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			.capabilities	= PERF_PMU_UNCORE_CAPS,
 			.attr_update	= pmu->type->attr_update,
 		};
 	} else {
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 7fd4334e12a1..2af53e3f16c1 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -876,33 +876,19 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 	u64 cfg = event->attr.config & SNB_UNCORE_PCI_IMC_EVENT_MASK;
 	int idx, base;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/* Sampling not supported yet */
-	if (hwc->sample_period)
-		return -EINVAL;
-
-	/* unsupported modes and filters */
-	if (event->attr.sample_period) /* no sampling */
+	/* check only supported bits are set */
+	if (event->attr.config & ~SNB_UNCORE_PCI_IMC_EVENT_MASK)
 		return -EINVAL;
 
 	/*
 	 * Place all uncore events for a particular physical package
 	 * onto a single cpu
 	 */
-	if (event->cpu < 0)
-		return -EINVAL;
-
-	/* check only supported bits are set */
-	if (event->attr.config & ~SNB_UNCORE_PCI_IMC_EVENT_MASK)
-		return -EINVAL;
-
 	box = uncore_pmu_to_box(pmu, event->cpu);
 	if (!box || box->cpu < 0)
 		return -EINVAL;
@@ -1013,7 +999,7 @@ static struct pmu snb_uncore_imc_pmu = {
 	.start		= uncore_pmu_event_start,
 	.stop		= uncore_pmu_event_stop,
 	.read		= uncore_pmu_event_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 };
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index b33c0931d61d..af8dd83aca48 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -204,13 +204,6 @@ static int msr_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	/* unsupported modes and filters */
-	if (event->attr.sample_period) /* no sampling */
-		return -EINVAL;
-
 	if (cfg >= PERF_MSR_EVENT_MAX)
 		return -EINVAL;
 
@@ -296,7 +289,7 @@ static struct pmu pmu_msr = {
 	.start		= msr_event_start,
 	.stop		= msr_event_stop,
 	.read		= msr_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_SAMPLING | PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_UNCORE_CAPS,
 	.attr_update	= attr_update,
 };
 
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8d98d468b976..34b054970c3d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -328,17 +328,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	int bit, ret = 0;
 	struct rapl_pmu *pmu;
 
-	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
-		return -ENOENT;
-
 	/* check only supported bits are set */
 	if (event->attr.config & ~RAPL_EVENT_MASK)
 		return -EINVAL;
 
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
 	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
@@ -693,7 +686,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
-	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	rapl_pmus->pmu.capabilities	= PERF_PMU_UNCORE_CAPS;
 	return 0;
 }
 
-- 
2.39.2.101.g768bb238c484.dirty


