Return-Path: <linux-kernel+bounces-39742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A538E83D59D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70AB8B2340E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686F67754;
	Fri, 26 Jan 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rmVw5GMi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921A66B5E;
	Fri, 26 Jan 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256532; cv=fail; b=kuMr2JAhpyROl16qyPy/09jpHVH1/tiSjZq2ZPiAaPr72PRV3sx3c24IqOKVDueRXFbvXVo4jNOsgG1ZK6WLr/n/fVURCmYcJCNJRkcXLsjhhjBDzEBTFXV+FF1QM5lpAlUmgibS44tJZSqp5rJ1ehJAvvU+DUA5rb26yMWmcVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256532; c=relaxed/simple;
	bh=FQhdeqBABGQevdCOeKTLkYQntoXQSjVMSy2guOjCtEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tz+q4eu1dSbpYMWqw4xWDmUZiOeVfXKVwJMw9T6Tn6HjeVFdMJI9+fNsYDh/Yz81W2yA2L7n4r77fatf/aaBq/9Vk9QrtuLUa/GyF5c9frFQgWk3cHppBcwy4AJVkLRsvnJ00l3ZpYwVxyqHnWvUtF+Kuu0huiDQ/zvaU3Wr9pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rmVw5GMi; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwCCIDE9eh4jt+1YhEahxVaVanfxeUiGZY/WUDbsPT7uyFDyCkmw1NmEIvQxaYItBiJYh3SG5aJo6qj+Uks9RAA+FTEYZ06M/IzuFIJErOc3N55rYm3VuTaSMXrUXL9eRW1z5a6j87AEzyRgK63R4zz18MwN+/MTH0e5eLpgzIi6UTAAJJrD2xgN91BHESELxD0SYM5V1JzJS5IhXO1gkLz2xNsKKNfxrY13Xh9mA0PDl4FepYGYWamTM/tACSL5vCa25BDfrnl+3OzRIMjxxmGDchnooVShMOBEdwYZBme6tKHIh/BkyEpjbgoCXBlzEZDgm6XLuB1fVTgLkv5kKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ4JdInETrt07iGA7sHRatZnkDgbYvAn5F5tTGvZ52Q=;
 b=fl3uVVT2hWm/udFiRlh1RX3HhzRZlxTtrL2EinEUErGF6PjM4Myvv77webjzlQhdDWSw8ZZZuPh3cjF9I9ZpL+YBoLjG1Ot3vtkc7Xrv1EUnIJseNrwnv23NznDxpFVggRNy9GJr1Ayze9U964POh0Qud/4Zjy30L4dsPoBjKhnIkPJmPmo8ILntl8HUydfF34W8ld/nq0EY11MK1bxvv+AR0E6+1kaxJkWvripbHNcXBEwv6MKrKBby8Vfdajmoyu6QwK7X/KjrwFG6c+8boCziaruC6jBY9Q38MpubAOfJKuj5Ltsmh8bxCN1xtlmRue3Cn9YE6A8l5s4+ntwPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ4JdInETrt07iGA7sHRatZnkDgbYvAn5F5tTGvZ52Q=;
 b=rmVw5GMi3nEgbJZIPVKtp0Q/wuq9OxriyMgEoBlCbfK3o5v3nFxLFW8wf9VC7FDTIWsbOWCi1GpKdTqvmt8AqrgUw1HSA9YCwQnPful+E90v9d5VJwNnCt/ybGWtQ0Qdj2xMzU0S/10k385YUe34lvtuVIhBCkHxlxWLgbAiHS4=
Received: from BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39) by
 MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 08:08:49 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::1) by BYAPR01CA0026.outlook.office365.com
 (2603:10b6:a02:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 08:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:08:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:45 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision boost state
Date: Fri, 26 Jan 2024 16:08:05 +0800
Message-ID: <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eea2675-04a7-418e-b15b-08dc1e4606a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V5zK1ierk8sOlVnX9vjIQCtDXg8JiKBCFlugzlneldIl0lttngyG5YpNg3oFak1ZkT5kYxohK8izdXOtLMCuqNaZLYUfu5vgmxqip7YjCIWzUndd+Pj7nMGfYBKXqamYqF75mbwENyUtQOJJyOv+iId6FnHmfkRtYfZZT/jnUAqDXSSkebanacrZi1a6qvI/791m7iCaI3Cqeyhl9gFudk5xnSka5OSPkBtqJhdY2IB52O0rr4kgU18SyF3z/rlLmnHNIDxOyeZV0XBafBIRGzzmvPg/DnX65iWHw4f2ehmhSaewbC334ltGi9JIjkGdivjP75osbRzOmrQdNGh8e/0HYJWK1zEvodhpssqd8Wk1EuEgLJIIcBalRXJjB+ZiE1XER4KydUnzkvt71WV6rLjmEk1xiRMpvblNFJPZEmFbq/LV9eQXseEDXT4WJ1HEsz9V72nDsGbvA7a0xtPiEOuwWYYZ1D8haJpsmk/VAtvYSXBa5l3RuGDgMZvXwDrBCyRZpTx/9ZWjd8bGqEHxdyJc7z6j4UyRFM4zBuy2XYQGcfCyREtsBdcv6ft2s7VnRLb9QSG7m+DitygXjokHE6mH5qB/bEoZINhEvWQYYiZOXMhgIE0fEKtyGAbuEflmu2gEG91waVut+JDvnlB5jzkn+3Xj4cezk7tKvJdJHY61GJP3hsA5sHP7jF+/bDAXuNkP0wvLrkCNjnUPpfJEQiRdfcfV1eFsqirL/g7YUeMmmo9xeyK+LARGARwZDt39Qq/90br8UWAkJK58CTzlGMdESPtGpKStsWwUYTMfgPU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(41300700001)(83380400001)(426003)(4326008)(336012)(26005)(2616005)(7696005)(82740400003)(36860700001)(110136005)(81166007)(44832011)(966005)(8676002)(47076005)(5660300002)(8936002)(16526019)(316002)(2906002)(6666004)(54906003)(6636002)(478600001)(70206006)(70586007)(86362001)(356005)(36756003)(40480700001)(40460700003)(518174003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:08:48.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eea2675-04a7-418e-b15b-08dc1e4606a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

From: Perry Yuan <Perry.Yuan@amd.com>

Add gloal global_params to represent current CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

If core performance boost is disabled while a core is in a boosted P-state,
the core transitions to the highest performance non-boosted P-state,
that is the same as the nominal frequency limit.

Issue: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 46 ++++++++++++++++++++++++++++--------
 include/linux/amd-pstate.h   |  1 -
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8f308f56ade6..0dc9124140d4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,6 +65,19 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 
+/**
+ * struct global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+static struct global_params global;
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -632,18 +645,27 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	return lowest_nonlinear_freq * 1000;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_state, boost_val;
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
+	boost_state = (boost_val >> 25) & 0x1;
+	if (!boost_state) {
+		global.cpb_supported = true;
+		global.cpb_boost = true;
+	} else {
+		global.cpb_supported = false;
+		global.cpb_boost = false;
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -676,6 +698,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -725,7 +750,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1093,6 +1117,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -1143,7 +1170,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..66d939a344b1 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -80,7 +80,6 @@ struct amd_cpudata {
 	struct amd_aperf_mperf prev;
 
 	u64	freq;
-	bool	boost_supported;
 
 	/* EPP feature related attributes*/
 	s16	epp_policy;
-- 
2.34.1


