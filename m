Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373ED80E4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjLLHmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:42:11 -0500
X-Greylist: delayed 946 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 23:42:16 PST
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FECFBE;
        Mon, 11 Dec 2023 23:42:16 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Sq9B93gsTz1fyVL;
        Tue, 12 Dec 2023 15:25:21 +0800 (CST)
Received: from kwepemm000004.china.huawei.com (unknown [7.193.23.18])
        by mail.maildlp.com (Postfix) with ESMTPS id C5E5B1A017F;
        Tue, 12 Dec 2023 15:26:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 15:26:27 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rafael@kernel.org>
CC:     <beata.michalska@arm.com>, <sumitg@nvidia.com>,
        <ionela.voinescu@arm.com>, <zengheng4@huawei.com>,
        <yang@os.amperecomputing.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy from cpuinfo_cur_freq
Date:   Tue, 12 Dec 2023 15:26:17 +0800
Message-ID: <20231212072617.14756-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many developers found that the cpu current frequency is greater than
the maximum frequency of the platform, please see [1], [2] and [3].

In the scenarios with high memory access pressure, the patch [1] has
proved the significant latency of cpc_read() which is used to obtain
delivered and reference performance counter cause an absurd frequency.
The sampling interval for this counters is very critical and is expected
to be equal. However, the different latency of cpc_read() has a direct
impact on their sampling interval.

This patch adds a interface, cpc_read_arch_counters_on_cpu, to read
delivered and reference performance counter together. According to my
test[4], the discrepancy of cpu current frequency in the scenarios with
high memory access pressure is lower than 0.2% by stress-ng application.

[1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
[2] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
[3] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/

[4] My local test:
The testing platform enable SMT and include 128 logical CPU in total,
and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" for each
physical core on platform during the high memory access pressure from
stress-ng, and the output is as follows:
  0: 2699133     2: 2699942     4: 2698189     6: 2704347
  8: 2704009    10: 2696277    12: 2702016    14: 2701388
 16: 2700358    18: 2696741    20: 2700091    22: 2700122
 24: 2701713    26: 2702025    28: 2699816    30: 2700121
 32: 2700000    34: 2699788    36: 2698884    38: 2699109
 40: 2704494    42: 2698350    44: 2699997    46: 2701023
 48: 2703448    50: 2699501    52: 2700000    54: 2699999
 56: 2702645    58: 2696923    60: 2697718    62: 2700547
 64: 2700313    66: 2700000    68: 2699904    70: 2699259
 72: 2699511    74: 2700644    76: 2702201    78: 2700000
 80: 2700776    82: 2700364    84: 2702674    86: 2700255
 88: 2699886    90: 2700359    92: 2699662    94: 2696188
 96: 2705454    98: 2699260   100: 2701097   102: 2699630
104: 2700463   106: 2698408   108: 2697766   110: 2701181
112: 2699166   114: 2701804   116: 2701907   118: 2701973
120: 2699584   122: 2700474   124: 2700768   126: 2701963

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 arch/arm64/kernel/topology.c | 43 ++++++++++++++++++++++++++++++++++--
 drivers/acpi/cppc_acpi.c     | 22 +++++++++++++++---
 include/acpi/cppc_acpi.h     |  5 +++++
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7d37e458e2f5..c3122154d738 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -299,6 +299,11 @@ core_initcall(init_amu_fie);
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
+struct amu_counters {
+	u64 corecnt;
+	u64 constcnt;
+};
+
 static void cpu_read_corecnt(void *val)
 {
 	/*
@@ -322,8 +327,27 @@ static void cpu_read_constcnt(void *val)
 		      0UL : read_constcnt();
 }
 
+static void cpu_read_amu_counters(void *data)
+{
+	struct amu_counters *cnt = (struct amu_counters *)data;
+
+	/*
+	 * The running time of the this_cpu_has_cap() might have a couple of
+	 * microseconds and is significantly increased to tens of microseconds.
+	 * But AMU core and constant counter need to be read togeter without any
+	 * time interval to reduce the calculation discrepancy using this counters.
+	 */
+	if (this_cpu_has_cap(ARM64_WORKAROUND_2457168)) {
+		cnt->corecnt = read_corecnt();
+		cnt->constcnt = 0;
+	} else {
+		cnt->corecnt = read_corecnt();
+		cnt->constcnt = read_constcnt();
+	}
+}
+
 static inline
-int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
+int counters_read_on_cpu(int cpu, smp_call_func_t func, void *data)
 {
 	/*
 	 * Abort call on counterless CPU or when interrupts are
@@ -335,7 +359,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
 
-	smp_call_function_single(cpu, func, val, 1);
+	smp_call_function_single(cpu, func, data, 1);
 
 	return 0;
 }
@@ -364,6 +388,21 @@ bool cpc_ffh_supported(void)
 	return true;
 }
 
+int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference)
+{
+	struct amu_counters cnts = {0};
+	int ret;
+
+	ret = counters_read_on_cpu(cpu, cpu_read_amu_counters, &cnts);
+	if (ret)
+		return ret;
+
+	*delivered = cnts.corecnt;
+	*reference = cnts.constcnt;
+
+	return 0;
+}
+
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	int ret = -EOPNOTSUPP;
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..f303fabd7cfe 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1299,6 +1299,11 @@ bool cppc_perf_ctrs_in_pcc(void)
 }
 EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
 
+int __weak cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference)
+{
+	return 0;
+}
+
 /**
  * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
  * @cpunum: CPU from which to read counters.
@@ -1313,7 +1318,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		*ref_perf_reg, *ctr_wrap_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
-	u64 delivered, reference, ref_perf, ctr_wrap_time;
+	u64 delivered = 0, reference = 0;
+	u64 ref_perf, ctr_wrap_time;
 	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
@@ -1350,8 +1356,18 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(cpunum, delivered_reg, &delivered);
-	cpc_read(cpunum, reference_reg, &reference);
+	if (cpc_ffh_supported()) {
+		ret = cpc_read_arch_counters_on_cpu(cpunum, &delivered, &reference);
+		if (ret) {
+			pr_debug("read arch counters failed, ret=%d.\n", ret);
+			ret = 0;
+		}
+	}
+	if (!delivered || !reference) {
+		cpc_read(cpunum, delivered_reg, &delivered);
+		cpc_read(cpunum, reference_reg, &reference);
+	}
+
 	cpc_read(cpunum, ref_perf_reg, &ref_perf);
 
 	/*
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6126c977ece0..07d4fd82d499 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -152,6 +152,7 @@ extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
+extern int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
@@ -209,6 +210,10 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -ENOTSUPP;
 }
+static inline int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *reference)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 {
 	return -ENOTSUPP;
-- 
2.33.0

