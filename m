Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92D7EEC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjKQGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:39:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275AD50;
        Thu, 16 Nov 2023 22:39:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6aunRcmsvedwmJFjmQI9qnyLIggSCnfBICL7drDbHK7VJYR+PqMnFQN55s1J+5SON6NPAK6SshZpCd0GT6Z3ZMYNOMogH4GY2svH82Xmkj1w0FCbCGB/mrztI7ABmkUYH3fSZcy1Wo6uY/LfrK0FZh+/z0772zBXqX8KpSy8Ngync/5uuyGioje0jD75fNQyA/L3sGhi0gVrwPL6HMSbvVVMbamq2NCnmOlpDoapMFs50ObiuNKKmbL7Ej3rs15jvirIEI4lZ7q1O0HpI5rCiaCu8szD1LnIluabMyLymCeIPNqLcKFYw/HMEfoBeFeZqRyB7Xbe2sUv834Q5MGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Oa4rnZprkhnD/Mi5QpLAGGDsW2julIJJOSWgoldDbs=;
 b=IfLjFezCV3LLVUq84mgr4d9yhPO1j7S1aA/YRHb30Grwico1ID7jW9qVvc+15OjyPvIZzTh54l+GHU7ZiKdfiNyj1iA4fWS6QzFRTCtNf3HRJOFWFSI/67vRs+EeEyH9TOuIvjdw0ovIC1ZJGaC8LbRCxCQjcY6F3I5hrXrcQ80vDjJ6cLILQjPOI4W11iFx1qDVsZ6nKiHNSMCSWdfrgWacxDZVdCUL+ZygqDqfz/b4lcIr6zdi95iEHYI7i2Q4TUvbjqntnZ2Xbbfp+rdAazN9tDsdiSGHGJWNpij57HWLii/eMbaFdCbaqkbc89KnZvNxfU9+7ELTaQY2W/L3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oa4rnZprkhnD/Mi5QpLAGGDsW2julIJJOSWgoldDbs=;
 b=Ki7XTzKUr9sy58lmtLaGZvoXMRc9kSjKFP6nQD4fgtS61miFSadeSDD9UCOft4Em0vRp8AAsYpx7r72XWImd1Xaz9iaC1as1OsVwoA3m2LOQH0t3kWLdYl6LIyB3q/OR1I+gbNZ+fvU8jnaDkJHjDnlhVyVxkyJKmxQjiT/F6lQ=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 06:38:58 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::97) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 06:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.8 via Frontend Transport; Fri, 17 Nov 2023 06:38:57 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 00:38:54 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perry.yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update
Date:   Fri, 17 Nov 2023 06:38:39 +0000
Message-ID: <20231117063839.17465-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b60189c-1c06-48f7-c3bb-08dbe737e087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dn8AkuKDQA6KmujvTM+TvwQjlAnBXJ/ZOXdWL4RFgKQBLHrGHcEBmmTuZJH59985f4cc2Jujy4vtDBNNmQR4vO1Sao2YS21j33DWxO8E4aFPO4F3519gSuqQIBxQ1FdRRr/g1kdfjnHOrVRf8jOeQpYX6yAv6YG27MtAZLbHxXdYANHqgm6I0CkhsGMhfPGsuPdfsOTLMnxQdg3L7h0t/k6b2xAhB5/N2t0liY6+fk5m/dkKI5RU5he7qIp7H8Eyic1ffQpZz0w1+tgjs9yS4jWJkYe9HILR8N7MzHdMQy8aAbA73UHlfMgG5VZL3G3HWe7Ccb0BFmxDgp/NNPZvM3GTpqAm3alimY8K6N4y4qMdgsKUszYKx7po4pUWCTlHH6ki80crzm/EBqVaQElE3L1z21pl/IHCHU74V461mmMKcBmNonGCYUkM+DZQIZ3Ut/ZAPRlo/POp8x2F2/rmgLE+WdFlNPYjuli/mueRcvBrqu2IxJJHvCwqphI33Nx17jr4IcpIjHSyfsGYvNiqnzabZt1HDw2L44a0St3cT2Y1lIKp9NUg7yeIRksNB3F3Xu5U1WjHl2W55RUwghDwhyromh25bwnkdPeVsgK8tdrCbSo/8K+vTr2yHbhMyLo5KSeCZIg9rwLpYT8Gfdh4AKP+X7KP9olM9MAgxNd6VDArhN7KonEUcatuKvCBHCXiTQHkcgKgeOTjkagICiawjMDqw6whyXCI8ovSuf/KL0zxIN/y80HdIb8AoAVjKnWNIzth6473HupyhiLY972ZWC6mRJPdE1ZBTqgDU5mgeGE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(16526019)(40460700003)(81166007)(70206006)(70586007)(110136005)(54906003)(1076003)(356005)(36756003)(86362001)(82740400003)(83380400001)(36860700001)(26005)(7696005)(336012)(426003)(2616005)(6666004)(2906002)(478600001)(316002)(44832011)(8676002)(47076005)(5660300002)(4326008)(8936002)(41300700001)(15650500001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 06:38:57.7549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b60189c-1c06-48f7-c3bb-08dbe737e087
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When amd_pstate is running, writing to scaling_min_freq and
scaling_max_freq has no effect. These values are only passed to the
policy level, but not to the platform level. This means that the
platform does not know about the frequency limits set by the user. To
fix this, update the min_perf and max_perf values at the platform level
whenever the user changes the scaling_min_freq and scaling_max_freq
values.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
Changelog:
v1 -> v2:
- Rebase
- Pick up ack from Ray
- Add fixes tag

 drivers/cpufreq/amd-pstate.c | 60 ++++++++++++++++++++++++++++--------
 include/linux/amd-pstate.h   |  4 +++
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..4839cdd2715e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,11 +307,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
-
+	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	return 0;
 }
 
@@ -329,11 +329,12 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -432,6 +433,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
@@ -470,6 +475,22 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
+{
+	u32 max_limit_perf, min_limit_perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
+	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
+
+	return 0;
+}
+
 static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 				  unsigned int target_freq, bool fast_switch)
 {
@@ -480,6 +501,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!cpudata->max_freq)
 		return -ENODEV;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
@@ -532,6 +556,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	unsigned int target_freq;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	max_freq = READ_ONCE(cpudata->max_freq);
@@ -745,6 +773,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
+	cpudata->max_limit_freq = max_freq;
+	cpudata->min_limit_freq = min_freq;
 	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
@@ -1183,16 +1213,25 @@ static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_init(unsigned int cpu)
+static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
+	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
 	u64 value;
 	s16 epp;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
@@ -1210,9 +1249,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	if (cpudata->epp_policy == cpudata->policy)
-		goto skip_epp;
-
 	cpudata->epp_policy = cpudata->policy;
 
 	/* Get BIOS pre-defined epp value */
@@ -1222,7 +1258,7 @@ static void amd_pstate_epp_init(unsigned int cpu)
 		 * This return value can only be negative for shared_memory
 		 * systems where EPP register read/write not supported.
 		 */
-		goto skip_epp;
+		return;
 	}
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1236,8 +1272,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	amd_pstate_set_epp(cpudata, epp);
-skip_epp:
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1252,7 +1286,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
-	amd_pstate_epp_init(policy->cpu);
+	amd_pstate_epp_update_limit(policy);
 
 	return 0;
 }
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..6ad02ad9c7b4 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,10 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     min_limit_perf;
+	u32     max_limit_perf;
+	u32     min_limit_freq;
+	u32     max_limit_freq;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

