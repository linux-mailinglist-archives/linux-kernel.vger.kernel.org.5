Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA27655DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjG0OYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjG0OYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:24:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF530D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:24:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so812602e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690467870; x=1691072670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MKFqCwYK7bNxNWkoizVyevtJvJbU46+II0XaU6/CZ0=;
        b=X61qUwJyyykphHIAIi1WKk/tAdLA2FSpCqX0KSlUU9KsSCCu9RjktcxQvRb5xcOLrt
         ISLtdaab8kgPrMHdsul09uxeWuYYOetuyuIPSEYcirMqnIQMvgziSN6qc5q64bcYG3+Q
         LrIfQQ2+aLW1w80FshCnCACPnvjxy1bwne2Wh0Di36CfPMfYh3UkYRj/5dawLFLikqZt
         CQfwvEAzHiqxXxIHC5DOxvma9HMef7j9TGsDcm4nJP3EcVj2WaV2n6TKFc4TBbaqPeX3
         CKABPXiovlkQEnbJ1X3DRll8voLgUXTZ0VmdVvXinZr3PUG8B6hny9OJlDOh1VsW2o+b
         qoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467870; x=1691072670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MKFqCwYK7bNxNWkoizVyevtJvJbU46+II0XaU6/CZ0=;
        b=MAQ2KekmC4SzLw7HTbSkk85FKCK7mVdRjlmtknIm3w/f746Ne4joBS8qS8rBmOXXVz
         AtXAVaNvz1JldyvDb/dgZktWtXRawA06BeVjanWM714H5YrSGvoR5ZLo2u4SD9FBVRvN
         ngbJ1q33otEvZSnRkFYDhXuyrZKh1EV4GIfv8ws807ba6uvdo5HCFhyHJ5xC0bkIGqD9
         IL1bXgIpQK757oiHtCnglqHBKRvCC7DGoVeCfOmvV+P2M09LMSMuFbxkXBDfsjToyNsP
         ov+/InAk1Gr4pkIdHpklHNLzsNnsm4P7hldVAh0JbB1ilBLq9SE72C4W+co8rH6muIMg
         8yYg==
X-Gm-Message-State: ABy/qLbh6cPiJu7VDAYbgQLhvuZrMdczL4tf3tWhx4Kvk0fTOgr4s7ao
        Vf/7AN/clYUK6tczcO/9BfkuXw==
X-Google-Smtp-Source: APBJJlEAt8bzPtkq8O3QO3lDA4NFSnCYAQHjqbCpaUJ5NYpQiPRBbEUE14WOPh7ufFbxrsbRpZ4BXg==
X-Received: by 2002:a05:6512:3e29:b0:4fb:896d:bd70 with SMTP id i41-20020a0565123e2900b004fb896dbd70mr2423247lfv.46.1690467869612;
        Thu, 27 Jul 2023 07:24:29 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c044f00b003fbb1a9586esm4842405wmb.15.2023.07.27.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:24:29 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 07/10] drivers: perf: Implement perf event mmap support in the SBI backend
Date:   Thu, 27 Jul 2023 16:14:25 +0200
Message-Id: <20230727141428.962286-8-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727141428.962286-1-alexghiti@rivosinc.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to unconditionnally expose the cycle and instret csrs to
userspace, which gives rise to security concerns.

So now we only allow access to hw counters from userspace through the perf
framework which will handle context switches, per-task events...etc. A
sysctl allows to revert the behaviour to the legacy mode so that userspace
applications which are not ready for this change do not break.

But the default value is to allow userspace only through perf: this will
break userspace applications which rely on direct access to rdcycle.
This choice was made for security reasons [1][2]: most of the applications
which use rdcycle can instead use rdtime to count the elapsed time.

[1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=1
[2] https://www.youtube.com/watch?v=3-c4C_L2PRQ&ab_channel=IEEESymposiumonSecurityandPrivacy

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/perf/riscv_pmu.c     |  10 +-
 drivers/perf/riscv_pmu_sbi.c | 192 +++++++++++++++++++++++++++++++++--
 2 files changed, 195 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 432ad2e80ce3..80c052e93f9e 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -38,7 +38,15 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_short = 0;
 	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
 
-	userpg->pmc_width = 64;
+#ifdef CONFIG_RISCV_PMU
+	/*
+	 * The counters are 64-bit but the priv spec doesn't mandate all the
+	 * bits to be implemented: that's why, counter width can vary based on
+	 * the cpu vendor.
+	 */
+	if (userpg->cap_user_rdpmc)
+		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(event->hw.idx) + 1;
+#endif
 
 	do {
 		rd = sched_clock_read_begin(&seq);
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 760eb2afcf82..9a51053b1f99 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -24,6 +24,14 @@
 #include <asm/sbi.h>
 #include <asm/hwcap.h>
 
+#define SYSCTL_NO_USER_ACCESS	0
+#define SYSCTL_USER_ACCESS	1
+#define SYSCTL_LEGACY		2
+
+#define PERF_EVENT_FLAG_NO_USER_ACCESS	BIT(SYSCTL_NO_USER_ACCESS)
+#define PERF_EVENT_FLAG_USER_ACCESS	BIT(SYSCTL_USER_ACCESS)
+#define PERF_EVENT_FLAG_LEGACY		BIT(SYSCTL_LEGACY)
+
 PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:63");
 
@@ -43,6 +51,9 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
 	NULL,
 };
 
+/* Allow user mode access by default */
+static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
+
 /*
  * RISC-V doesn't have heterogeneous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
@@ -301,6 +312,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
 }
 EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
 
+static uint8_t pmu_sbi_csr_index(struct perf_event *event)
+{
+	return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
+}
+
 static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
 {
 	unsigned long cflags = 0;
@@ -329,18 +345,34 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
 	struct sbiret ret;
 	int idx;
-	uint64_t cbase = 0;
+	uint64_t cbase = 0, cmask = rvpmu->cmask;
 	unsigned long cflags = 0;
 
 	cflags = pmu_sbi_get_filter_flags(event);
+
+	/*
+	 * In legacy mode, we have to force the fixed counters for those events
+	 * but not in the user access mode as we want to use the other counters
+	 * that support sampling/filtering.
+	 */
+	if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
+		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
+			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
+			cmask = 1;
+		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
+			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
+			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
+		}
+	}
+
 	/* retrieve the available counter index */
 #if defined(CONFIG_32BIT)
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
-			rvpmu->cmask, cflags, hwc->event_base, hwc->config,
+			cmask, cflags, hwc->event_base, hwc->config,
 			hwc->config >> 32);
 #else
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
-			rvpmu->cmask, cflags, hwc->event_base, hwc->config, 0);
+			cmask, cflags, hwc->event_base, hwc->config, 0);
 #endif
 	if (ret.error) {
 		pr_debug("Not able to find a counter for event %lx config %llx\n",
@@ -474,6 +506,22 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 	return val;
 }
 
+static void pmu_sbi_set_scounteren(void *arg)
+{
+	struct perf_event *event = (struct perf_event *)arg;
+
+	csr_write(CSR_SCOUNTEREN,
+		  csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
+}
+
+static void pmu_sbi_reset_scounteren(void *arg)
+{
+	struct perf_event *event = (struct perf_event *)arg;
+
+	csr_write(CSR_SCOUNTEREN,
+		  csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
+}
+
 static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 {
 	struct sbiret ret;
@@ -490,6 +538,10 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
 		pr_err("Starting counter idx %d failed with error %d\n",
 			hwc->idx, sbi_err_map_linux_errno(ret.error));
+
+	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
+	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		pmu_sbi_set_scounteren((void *)event);
 }
 
 static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
@@ -497,6 +549,10 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 	struct sbiret ret;
 	struct hw_perf_event *hwc = &event->hw;
 
+	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
+	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		pmu_sbi_reset_scounteren((void *)event);
+
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
 		flag != SBI_PMU_STOP_FLAG_RESET)
@@ -704,10 +760,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 
 	/*
-	 * Enable the access for CYCLE, TIME, and INSTRET CSRs from userspace,
-	 * as is necessary to maintain uABI compatibility.
+	 * We keep enabling userspace access to CYCLE, TIME and INSTRET via the
+	 * legacy option but that will be removed in the future.
 	 */
-	csr_write(CSR_SCOUNTEREN, 0x7);
+	if (sysctl_perf_user_access == SYSCTL_LEGACY)
+		csr_write(CSR_SCOUNTEREN, 0x7);
+	else
+		csr_write(CSR_SCOUNTEREN, 0x2);
 
 	/* Stop all the counters so that they can be enabled from perf */
 	pmu_sbi_stop_all(pmu);
@@ -838,6 +897,121 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
 
+static void pmu_sbi_event_init(struct perf_event *event)
+{
+	/*
+	 * The permissions are set at event_init so that we do not depend
+	 * on the sysctl value that can change.
+	 */
+	if (sysctl_perf_user_access == SYSCTL_NO_USER_ACCESS)
+		event->hw.flags |= PERF_EVENT_FLAG_NO_USER_ACCESS;
+	else if (sysctl_perf_user_access == SYSCTL_USER_ACCESS)
+		event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
+	else
+		event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
+}
+
+static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
+		return;
+
+	if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
+		if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
+		    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS) {
+			return;
+		}
+	}
+
+	/*
+	 * The user mmapped the event to directly access it: this is where
+	 * we determine based on sysctl_perf_user_access if we grant userspace
+	 * the direct access to this event. That means that within the same
+	 * task, some events may be directly accessible and some other may not,
+	 * if the user changes the value of sysctl_perf_user_accesss in the
+	 * meantime.
+	 */
+
+	event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
+
+	/*
+	 * We must enable userspace access *before* advertising in the user page
+	 * that it is possible to do so to avoid any race.
+	 * And we must notify all cpus here because threads that currently run
+	 * on other cpus will try to directly access the counter too without
+	 * calling pmu_sbi_ctr_start.
+	 */
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
+		on_each_cpu_mask(mm_cpumask(mm),
+				 pmu_sbi_set_scounteren, (void *)event, 1);
+}
+
+static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
+		return;
+
+	if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
+		if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
+		    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS) {
+			return;
+		}
+	}
+
+	/*
+	 * Here we can directly remove user access since the user does not have
+	 * access to the user page anymore so we avoid the racy window where the
+	 * user could have read cap_user_rdpmc to true right before we disable
+	 * it.
+	 */
+	event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
+
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
+		on_each_cpu_mask(mm_cpumask(mm),
+				 pmu_sbi_reset_scounteren, (void *)event, 1);
+}
+
+static void riscv_pmu_update_counter_access(void *info)
+{
+	if (sysctl_perf_user_access == SYSCTL_LEGACY)
+		csr_write(CSR_SCOUNTEREN, 0x7);
+	else
+		csr_write(CSR_SCOUNTEREN, 0x2);
+}
+
+static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
+					      int write, void *buffer,
+					      size_t *lenp, loff_t *ppos)
+{
+	int prev = sysctl_perf_user_access;
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	/*
+	 * Test against the previous value since we clear SCOUNTEREN when
+	 * sysctl_perf_user_access is set to SYSCTL_USER_ACCESS, but we should
+	 * not do that if that was already the case.
+	 */
+	if (ret || !write || prev == sysctl_perf_user_access)
+		return ret;
+
+	on_each_cpu(riscv_pmu_update_counter_access, NULL, 1);
+
+	return 0;
+}
+
+static struct ctl_table sbi_pmu_sysctl_table[] = {
+	{
+		.procname       = "perf_user_access",
+		.data		= &sysctl_perf_user_access,
+		.maxlen		= sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= riscv_pmu_proc_user_access_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{ }
+};
+
 static int pmu_sbi_device_probe(struct platform_device *pdev)
 {
 	struct riscv_pmu *pmu = NULL;
@@ -881,6 +1055,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	pmu->ctr_get_width = pmu_sbi_ctr_get_width;
 	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
 	pmu->ctr_read = pmu_sbi_ctr_read;
+	pmu->event_init = pmu_sbi_event_init;
+	pmu->event_mapped = pmu_sbi_event_mapped;
+	pmu->event_unmapped = pmu_sbi_event_unmapped;
+	pmu->csr_index = pmu_sbi_csr_index;
 
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 	if (ret)
@@ -894,6 +1072,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unregister;
 
+	register_sysctl("kernel", sbi_pmu_sysctl_table);
+
 	return 0;
 
 out_unregister:
-- 
2.39.2

