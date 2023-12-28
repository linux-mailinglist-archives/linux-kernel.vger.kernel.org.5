Return-Path: <linux-kernel+bounces-12502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99681F5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD83E1F22EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7167464;
	Thu, 28 Dec 2023 07:57:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E76FC7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1703750236-086e230f2709020001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id sBOAnftlcQh0sFp9 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 28 Dec 2023 15:57:16 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Dec
 2023 15:57:16 +0800
Received: from tony.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Dec
 2023 15:57:13 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <peterz@infradead.org>,
	<j.granados@samsung.com>, <TonyWWang-oc@zhaoxin.com>,
	<ricardo.neri-calderon@linux.intel.com>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<LindaChai@zhaoxin.com>
Subject: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for Zhaoxin CPUs
Date: Thu, 28 Dec 2023 15:57:05 +0800
X-ASG-Orig-Subj: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for Zhaoxin CPUs
Message-ID: <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1703750236
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3579
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118664
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

For Zhaoxin CPUs, the cores' highest frequencies may be different, which
means that cores may run at different max frequencies,

According to ACPI-spec6 chapter 8.4.7, the per-core highest frequency
value can be obtained via cppc.

The core with the higher frequency have better performance, which can be
called as preferred core. And better performance can be achieved by
making the scheduler to run tasks on these preferred cores.

The cpufreq driver can use the highest frequency value as the prioriy of
core to make the scheduler try to get better performace. More specifically,
in the acpi-cpufreq driver use cppc_get_highest_perf() to get highest
frequency value of each core, use sched_set_itmt_core_prio() to set
highest frequency value as core priority, and use sched_set_itmt_support()
provided by ITMT to tell the scheduler to favor on the preferred cores.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..f4c1ff9e4bb0 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -663,8 +663,56 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
 }
+
+/* The work item is needed to avoid CPU hotplug locking issues */
+static void sched_itmt_work_fn(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+
+static DECLARE_WORK(sched_itmt_work, sched_itmt_work_fn);
+
+static void set_itmt_prio(int cpu)
+{
+	static bool cppc_highest_perf_diff;
+	static struct cpumask core_prior_mask;
+	u64 highest_perf;
+	static u64 max_highest_perf = 0, min_highest_perf = U64_MAX;
+	int ret;
+
+	ret = cppc_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	sched_set_itmt_core_prio(highest_perf, cpu);
+	cpumask_set_cpu(cpu, &core_prior_mask);
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
+			cppc_highest_perf_diff = true;
+		}
+	}
+
+	if (cppc_highest_perf_diff && cpumask_equal(&core_prior_mask, cpu_online_mask)) {
+		pr_debug("queue a work to set itmt enabled\n");
+		schedule_work(&sched_itmt_work);
+	}
+}
 #else
 static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
+static void set_itmt_prio(int cpu) { }
 #endif
 
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
@@ -677,7 +725,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int valid_states = 0;
 	unsigned int result = 0;
 	u64 max_boost_ratio;
-	unsigned int i;
+	unsigned int i, j;
 #ifdef CONFIG_SMP
 	static int blacklisted;
 #endif
@@ -742,6 +790,12 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 #endif
 
+	if (c->x86_vendor == X86_VENDOR_CENTAUR || c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		for_each_cpu(j, policy->cpus) {
+			set_itmt_prio(j);
+		}
+	}
+
 	/* capability check */
 	if (perf->state_count <= 1) {
 		pr_debug("No P-States\n");
-- 
2.25.1


