Return-Path: <linux-kernel+bounces-105968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861B87E6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827B6B224F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033938DEF;
	Mon, 18 Mar 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oSQNbFGn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E2381D2;
	Mon, 18 Mar 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756701; cv=fail; b=WZeM7QXNOSZM0tMRHYVSRjgscqF6I4G5zoWsQqpLRnr5d5RpumZh8Vh70wkGqZNZSObvV5xY115GNsr66byHIj3X8GIFP8/iIe9HBO2DlKLc45s8ms8EJ1KRz40hbb3QheWel3YZxCXeihA+nCOYK4lgGq0ARvhRVe4OUsC5HGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756701; c=relaxed/simple;
	bh=hIgkKPGWKmHXc+BKPCad2ibEcDx3MTToS1XTi/GgqfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7f60wXxK++gjKt6hGflPZdtchdMER1LIfa2OIv5/OZPtV932x6BR8orLnYmUeUpJTKt/wotJ7FJYGgWlqrBmTjQ2TpLwZdbB6xlZMD1FkKkQTAoXUs2edHp8nN/EcIpzVdGaZ7jpZ0u0nnGEBYRPC8RR1GUohMd0X2/lL4EvYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oSQNbFGn; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkQ7PMeAny9sxmrvK0E6Xa3Pg/tGMinpU1/OOFFw8p17OpGuBL6iK4FPvyh2U4OKfCIo8D+2G+fnCR5DAMGnUQfDWcHk2hGXVjIL5Xq8N51Hv8OQu2Itb293urUDIPa+6F6zvXi3laxW07yC1ZBHe++G6mU8I4jESV3kxD0YL2daqVt/0ha38mTCb+dBaABfjp06qV2oqXyeTm0+w/bn2Lu0gsfzfhv4xhRo/JoJ9v5BxkjsTsCce4vMGySFMDlx8M1U4hY27PIcFX22HxXyXpvzosBu6W0Wcv6XiNcEiKy4ZmSfx/hDyDwVpxtIMxIAWLWfncrFazH2hYHab52Mlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMs0KvCpm4U0E+rO8pCfFaT8EYmEqu7q3795v0kApnQ=;
 b=jEb/CjI20N2i0K6bZeT1+fpjWowML9h+rBE50+Dx0oI7K9vCRjV0EDk7XJL6etY7lhMzVB5eQdaRLyD6qxylpdNYmdqTaFZTmSCSBNmWlZrdW4Ql9UbwpTTSkdiKdIHu/BjmzXKPZuse9IGsWmuZzDnO+nR1hYgsIfYE1p/lNqoTsRQGjtKl3hg7DNvSeCTJ7bAit8p62ik3grv6vWNrB8A3EbIrW6Yn1Hofli5W2ii7WZsICNk3ubQY6p2NgveFvzphG86ObTQI04Ehip5TKdMJQqmC4HX7FIW2E2jt/F8mjoTo5nRNZnU4sOH+M16pJfv/OWp698zR+ewSFKhjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMs0KvCpm4U0E+rO8pCfFaT8EYmEqu7q3795v0kApnQ=;
 b=oSQNbFGnPKSNaJ6+NYDJmYM+1wURCvKu+wF45eYqqGo07xV3MEtfBFFqYZGbrX+UcXZGjcdm6LGZFQPpiGRovRn7rA5OHyFOS+N0oaf1bKLPRGTTnxHjM9hN0Wa7gQfNBBRYgV1uQUxi6f+ItddLZbNG0hSDDdM2lO2BVD8SZ8g=
Received: from CY5PR15CA0185.namprd15.prod.outlook.com (2603:10b6:930:81::24)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:11:37 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::99) by CY5PR15CA0185.outlook.office365.com
 (2603:10b6:930:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:37 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:33 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/6] cpufreq: amd-pstate: initialize new core precision boost state
Date: Mon, 18 Mar 2024 18:11:09 +0800
Message-ID: <f43f48b02d42a651028f0c4690caa6e953e8bf45.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: c76b125a-38da-4c3e-4125-08dc4733cc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HRgioViBYGVnmG0VhC8K28h0JYfkCFabTc0iAy9jiDe4e8Onnw4QoO4pRylFSpwS3nfUjVLS2bYRceHZLE5COTg8qkhOyObYoPpijkkIkToAzno6hViwpS1thxSN17pNRdb0/DQO6B7H6+GwnrdawJtneIP1b8ivpQ1D5A5uJ47DSu9EcoFDL0Bgu6s2C6Wxz+Ohij6iJtTS+CfSjee/Z8WqajsUnbjRcnHSeMjZ8VUb0EW3zw9UfnPuZ076qgdtIXqwzA61mhNIiLRzInEUJWNnpG7zCDyJX2pXgK5g0Mb6HC/AGy1PjWSydvmNRSqP48KxIvOEnUvpvksgcGbBpGd+EIhsDndzRS9iq/3+HNAAaqNcbblmD4LznNmZHvJFQSTTYO+FG/Xbc3wVMdiDZiF/FGoHaOV+QhU2+Y0Mcng619msbBZKxKvUQiplYX3tOSOyOqUXPDVrx6+8VbCIQcVlrFNjz+Xkj7ab3g81H4No4ehqHnnvhkK85pYGxc0bnOK52isBpgxwjfToUW+G60orT3SXZQWs4DjKDk5kkTGoBE0Oyrl5iIg1Y85aktla/Szqe34PCK+yLje8Or8DLMVm87mXUgmoB8PUV0+h9TSqdxWB8KgWwLLt2AmIc6oh1OOwuq2rnoQUL809G7KLVGGipQmE8aR8VaHMawKCU9sAeKsCQdB94OE5bdrLA4zQ6G1lr4/fUedcRC/dIUv1JA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:37.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76b125a-38da-4c3e-4125-08dc4733cc11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

From: Perry Yuan <Perry.Yuan@amd.com>

Add gloal global_params to represent current CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

If core performance boost is disabled while a core is in a boosted P-state,
the core transitions to the highest performance non-boosted P-state,
that is the same as the nominal frequency limit.

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 13 ++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 59a2db225d98..81787f83c906 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,6 +68,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -665,18 +667,27 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		return ret;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+
+	if (amd_pstate_global_params.cpb_supported) {
+		cpudata->boost_supported = true;
+		current_pstate_driver->boost_enabled = true;
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -900,6 +911,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -956,7 +972,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1363,6 +1378,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1417,7 +1437,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 6b832153a126..c5e41de65f70 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -134,4 +134,17 @@ struct quirk_entry {
 	u32 lowest_freq;
 };
 
+/**
+ * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct amd_pstate_global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+extern struct amd_pstate_global_params amd_pstate_global_params;
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


