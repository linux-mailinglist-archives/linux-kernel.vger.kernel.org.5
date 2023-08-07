Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D2E771C16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHGINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHGIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:12:59 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82631708
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:12:53 -0700 (PDT)
X-ASG-Debug-ID: 1691395968-086e23186c103a0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id iucwwu9ktQWASxuh (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 07 Aug 2023 16:12:48 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 7 Aug
 2023 16:12:47 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 7 Aug
 2023 16:12:46 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>, <LindaChai@zhaoxin.com>
Subject: [PATCH] cpufreq: ACPI: add ITMT support when CPPC enabled
Date:   Mon, 7 Aug 2023 16:12:48 +0800
X-ASG-Orig-Subj: [PATCH] cpufreq: ACPI: add ITMT support when CPPC enabled
Message-ID: <20230807081248.4745-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1691395968
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3567
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112427
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _CPC method can get per-core highest frequency.
The highest frequency may varies between cores which mean cores can
running at different max frequency, so can use it as a core priority
and give a hint to scheduler in order to put critical task to the
higher priority core.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 59 ++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b2f05d27167e..5733323e04ac 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -628,28 +628,35 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-static u64 get_max_boost_ratio(unsigned int cpu)
+static void cpufreq_get_core_perf(int cpu, u64 *highest_perf, u64 *nominal_perf)
 {
 	struct cppc_perf_caps perf_caps;
-	u64 highest_perf, nominal_perf;
 	int ret;
 
 	if (acpi_pstate_strict)
-		return 0;
+		return;
 
 	ret = cppc_get_perf_caps(cpu, &perf_caps);
 	if (ret) {
 		pr_debug("CPU%d: Unable to get performance capabilities (%d)\n",
 			 cpu, ret);
-		return 0;
+		return;
 	}
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		highest_perf = amd_get_highest_perf();
+		*highest_perf = amd_get_highest_perf();
 	else
-		highest_perf = perf_caps.highest_perf;
+		*highest_perf = perf_caps.highest_perf;
+
+	*nominal_perf = perf_caps.nominal_perf;
+	return;
+}
 
-	nominal_perf = perf_caps.nominal_perf;
+static u64 get_max_boost_ratio(unsigned int cpu)
+{
+	u64 highest_perf, nominal_perf;
+
+	cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
@@ -663,8 +670,44 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
 }
+
+static void cpufreq_sched_itmt_work_fn(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+
+static DECLARE_WORK(sched_itmt_work, cpufreq_sched_itmt_work_fn);
+
+static void cpufreq_set_itmt_prio(int cpu)
+{
+	u64 highest_perf, nominal_perf;
+	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
+
+	cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
+
+	sched_set_itmt_core_prio(highest_perf, cpu);
+
+	if (max_highest_perf <= min_highest_perf) {
+		if (highest_perf > max_highest_perf)
+			max_highest_perf = highest_perf;
+
+		if (highest_perf < min_highest_perf)
+			min_highest_perf = highest_perf;
+
+		if (max_highest_perf > min_highest_perf) {
+			/*
+			 * This code can be run during CPU online under the
+			 * CPU hotplug locks, so sched_set_itmt_support()
+			 * cannot be called from here.  Queue up a work item
+			 * to invoke it.
+			 */
+			schedule_work(&sched_itmt_work);
+		}
+	}
+}
 #else
 static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
+static void cpufreq_set_itmt_prio(int cpu) { return; }
 #endif
 
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
@@ -870,6 +913,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* notify BIOS that we exist */
 	acpi_processor_notify_smm(THIS_MODULE);
 
+	cpufreq_set_itmt_prio(cpu);
+
 	pr_debug("CPU%u - ACPI performance management activated.\n", cpu);
 	for (i = 0; i < perf->state_count; i++)
 		pr_debug("     %cP%d: %d MHz, %d mW, %d uS\n",
-- 
2.17.1

