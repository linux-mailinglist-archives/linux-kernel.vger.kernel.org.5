Return-Path: <linux-kernel+bounces-100606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59042879AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC77286FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46A13A27C;
	Tue, 12 Mar 2024 17:34:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31891386A8;
	Tue, 12 Mar 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264876; cv=none; b=WsP4TIhQUAUPpon1ETZ5K9Alyml4tfPHzmcLo02mcYgzXRppqtZfRGYTi/Rr6ZfRj1YPURH0JN7uUWRzfko/G194mti8gh8YdCWE7OQUfuhy25n7pAIe8KKd/Q6GGQm4qQu+CcQkiVH0UIf/pho+g4sywtumxh+3RsxQLmzAEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264876; c=relaxed/simple;
	bh=iLqwf18EKZOrh6tRr8oMD2Wr3+N8+SsfQFey99rtRjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjYcaBAhU/yUgFI4eZuf8H5QBXhbGzB6m2r6q2T6fy5Vr+M0/rOX3d0WybJ5EpRY+mm77lpcJdsajqCwI18Z0I9MbVvhKjHhMzc6kNEE3UL+eAniXhSIK0ZGdWHNoKxPudZLJ1YLjHyZFQws18QljziEvDtoxDdWM1x0S7DVvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7AA215BF;
	Tue, 12 Mar 2024 10:35:11 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C6EE3F762;
	Tue, 12 Mar 2024 10:34:32 -0700 (PDT)
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
	jialong.yang@shingroup.cn
Subject: [PATCH 04/10] perf: Rename PERF_PMU_CAP_NO_INTERRUPT
Date: Tue, 12 Mar 2024 17:34:06 +0000
Message-Id: <0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy@arm.com>
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

The PERF_PMU_CAP_NO_INTERRUPT flag is used by the core solely to
determine whether PMUs can support sampling events or not. It makes
sense to utilise the same capability for non-CPU-affine PMUs which have
no relevant state to sample, but it would be a rather confusing misnomer
when such PMUs do still have interrupts for handling overflows. Let's
rename it to represent what it actually means.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arc/kernel/perf_event.c              | 2 +-
 arch/csky/kernel/perf_event.c             | 2 +-
 arch/powerpc/perf/8xx-pmu.c               | 2 +-
 arch/powerpc/perf/hv-24x7.c               | 2 +-
 arch/powerpc/perf/hv-gpci.c               | 2 +-
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 arch/s390/kernel/perf_cpum_cf.c           | 2 +-
 arch/sh/kernel/perf_event.c               | 2 +-
 arch/x86/events/amd/uncore.c              | 6 +++---
 arch/x86/events/core.c                    | 2 +-
 arch/x86/events/intel/cstate.c            | 6 +++---
 arch/x86/events/msr.c                     | 2 +-
 drivers/fpga/dfl-fme-perf.c               | 2 +-
 drivers/perf/arm_cspmu/arm_cspmu.c        | 2 +-
 drivers/perf/arm_pmu_platform.c           | 2 +-
 drivers/perf/marvell_cn10k_tad_pmu.c      | 2 +-
 drivers/perf/riscv_pmu_sbi.c              | 2 +-
 include/linux/perf_event.h                | 2 +-
 kernel/events/core.c                      | 2 +-
 19 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index adff957962da..cd02cf7904e8 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -819,7 +819,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	}
 
 	if (irq == -1)
-		arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING;
 
 	/*
 	 * perf parser doesn't really like '-' symbol in events name, so let's
diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f18420ce64..c733fb29114f 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1315,7 +1315,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 
 	ret = csky_pmu_request_irq(csky_pmu_handle_irq);
 	if (ret) {
-		csky_pmu.pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		csky_pmu.pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING;
 		pr_notice("[perf] PMU request irq fail!\n");
 	}
 
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 308a2e40d7be..456de23c2ea7 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -181,7 +181,7 @@ static struct pmu mpc8xx_pmu = {
 	.add		= mpc8xx_pmu_add,
 	.del		= mpc8xx_pmu_del,
 	.read		= mpc8xx_pmu_read,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT |
+	.capabilities	= PERF_PMU_CAP_NO_SAMPLING|
 			  PERF_PMU_CAP_NO_NMI,
 };
 
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 057ec2e3451d..74821bb193c1 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1737,7 +1737,7 @@ static int hv_24x7_init(void)
 		return -ENOMEM;
 
 	/* sampling not supported */
-	h_24x7_pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	h_24x7_pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING
 
 	r = create_events_from_catalog(&event_group.attrs,
 				   &event_desc_group.attrs,
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 27f18119fda1..25842f61662c 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -984,7 +984,7 @@ static int hv_gpci_init(void)
 		return r;
 
 	/* sampling not supported */
-	h_gpci_pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	h_gpci_pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
 	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 1a53e048ceb7..6415cdabe403 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -501,7 +501,7 @@ static void papr_scm_pmu_register(struct papr_scm_priv *p)
 	nd_pmu->pmu.add = papr_scm_pmu_add;
 	nd_pmu->pmu.del = papr_scm_pmu_del;
 
-	nd_pmu->pmu.capabilities = PERF_PMU_CAP_NO_INTERRUPT |
+	nd_pmu->pmu.capabilities = PERF_PMU_CAP_NO_SAMPLING |
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	/*updating the cpumask variable */
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 41ed6e0f0a2a..8474aafa2075 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1054,7 +1054,7 @@ static void cpumf_pmu_del(struct perf_event *event, int flags)
 /* Performance monitoring unit for s390x */
 static struct pmu cpumf_pmu = {
 	.task_ctx_nr  = perf_sw_context,
-	.capabilities = PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities = PERF_PMU_CAP_NO_SAMPLING
 	.pmu_enable   = cpumf_pmu_enable,
 	.pmu_disable  = cpumf_pmu_disable,
 	.event_init   = cpumf_pmu_event_init,
diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index 1d2507f22437..4bade9b7d357 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -352,7 +352,7 @@ int register_sh_pmu(struct sh_pmu *_pmu)
 	 * no interrupts, and are therefore unable to do sampling without
 	 * further work and timer assistance.
 	 */
-	pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING
 
 	WARN_ON(_pmu->num_events > MAX_HWEVENTS);
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 5bf03c575812..4220bf556962 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -700,7 +700,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.start		= amd_uncore_start,
 		.stop		= amd_uncore_stop,
 		.read		= amd_uncore_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_SAMPLING,
 		.module		= THIS_MODULE,
 	};
 
@@ -833,7 +833,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.start		= amd_uncore_start,
 		.stop		= amd_uncore_stop,
 		.read		= amd_uncore_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_SAMPLING,
 		.module		= THIS_MODULE,
 	};
 
@@ -958,7 +958,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.start		= amd_uncore_umc_start,
 				.stop		= amd_uncore_stop,
 				.read		= amd_uncore_read,
-				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_SAMPLING,
 				.module		= THIS_MODULE,
 			};
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..20cded91716f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1812,7 +1812,7 @@ static void __init pmu_check_apic(void)
 	 * events (user-space has to fall back and
 	 * sample via a hrtimer based software event):
 	 */
-	pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING
 
 }
 
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4b50a3a9818a..3e4ab89d440c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -530,7 +530,7 @@ static struct pmu cstate_core_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
@@ -545,7 +545,7 @@ static struct pmu cstate_pkg_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
@@ -560,7 +560,7 @@ static struct pmu cstate_module_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_CAP_NO_SAMPLING | PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9e237b30f017..b33c0931d61d 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -296,7 +296,7 @@ static struct pmu pmu_msr = {
 	.start		= msr_event_start,
 	.stop		= msr_event_stop,
 	.read		= msr_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_CAP_NO_SAMPLING | PERF_PMU_CAP_NO_EXCLUDE,
 	.attr_update	= attr_update,
 };
 
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..b5bafea06a55 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -921,7 +921,7 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 	pmu->start =		fme_perf_event_start;
 	pmu->stop =		fme_perf_event_stop;
 	pmu->read =		fme_perf_event_read;
-	pmu->capabilities =	PERF_PMU_CAP_NO_INTERRUPT |
+	pmu->capabilities =	PERF_PMU_CAP_NO_SAMPLING |
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index d408cbb84ed7..32ffea50cd7a 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1186,7 +1186,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 	capabilities = PERF_PMU_CAP_NO_EXCLUDE |
 		       PERF_PMU_CAP_NO_COMMON_EVENTS;
 	if (cspmu->irq == 0)
-		capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		capabilities |= PERF_PMU_CAP_NO_SAMPLING;
 
 	cspmu->pmu = (struct pmu){
 		.task_ctx_nr	= perf_invalid_context,
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 3596db36cbff..e96c003f8555 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -109,7 +109,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	 */
 	if (num_irqs == 0) {
 		dev_warn(dev, "no irqs for PMU, sampling events not supported\n");
-		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING;
 		cpumask_setall(&pmu->supported_cpus);
 		return 0;
 	}
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index bc2d642e87e8..aaedb5715d69 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -318,7 +318,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.module		= THIS_MODULE,
 		.attr_groups	= tad_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_INTERRUPT |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr	= perf_invalid_context,
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..aa562520ecfd 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1049,7 +1049,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	ret = pmu_sbi_setup_irqs(pmu, pdev);
 	if (ret < 0) {
 		pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
-		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_SAMPLING;
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 983201f21dd2..b1fd832ed8bf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -282,7 +282,7 @@ struct perf_event_pmu_context;
 /**
  * pmu::capabilities flags
  */
-#define PERF_PMU_CAP_NO_INTERRUPT		0x0001
+#define PERF_PMU_CAP_NO_SAMPLING		0x0001
 #define PERF_PMU_CAP_NO_NMI			0x0002
 #define PERF_PMU_CAP_AUX_NO_SG			0x0004
 #define PERF_PMU_CAP_EXTENDED_REGS		0x0008
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ad80826c218..892212aae85e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12539,7 +12539,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (is_sampling_event(event)) {
-		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
+		if (event->pmu->capabilities & PERF_PMU_CAP_NO_SAMPLING) {
 			err = -EOPNOTSUPP;
 			goto err_alloc;
 		}
-- 
2.39.2.101.g768bb238c484.dirty


