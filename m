Return-Path: <linux-kernel+bounces-51624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD5848D6E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D9228306C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106B224DE;
	Sun,  4 Feb 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOSG6dcm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A1F22314;
	Sun,  4 Feb 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048801; cv=fail; b=Ut9R9QTgRMHFy0EKXqBGIHnr8OSffBXXHY9HqQ30eDM4Pihe7dPcKvhXigfOg/REQy5ChL+w3rLJDShGbYrso7KF20D5xfC663Qvxq+VaOzA+iJ4UJjh2MY3NVtSkgSLXZNVH9gRyUQxMjcLIYED4klaMFKPL5Q184py/Hf8VxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048801; c=relaxed/simple;
	bh=6H19wzE8cNLuougZk13HeNichmIG5PrRuTrD629ah9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzZ4S40t1K0aePIsDfx1TlSDCC8/whZZs0tn49fRkw8bU2q9RB6p0RtZyvyF6Exa5650eQDT5Qna9qIcQVAZCTK5GwHvPw4gHipqYzpPAgR422xlsU+c11H5zK2PiBAzXtRq44vQuv5UC9W8ADso8fsUn9keo757bo5iumac6wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOSG6dcm; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncNr9MJGtDPGrN/ZjOLSs44lbznk/ykanN62nrGncFQZHVqc9/DcQdUVjWemk8ktsPaRXBPtV5a4H2dVHBjBF/M/GTKi1wtnlg2yF9gdcLHT5MvAh1hJIcBKq7qw6rhUKPwyVGfkrjGV1g3QMBVj4KQr73IMeKgz+5IUZLaKjAVPptz9gVE1uM+EcMM6/M0q9lCSn7eLbu96A21C6NaD3ofmWquMWchPwdKHrt1hvVkPSMPaq3Dma/uwy1mKYeTEipejl8Kmjz1kYrvNfohCVl1m0vhpztRBqw9Lp51sFW7yc2XC6IIeEqJTRNSGDz72hyMxS3ONB2+pZBGroe1/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UDi4yuSQkHg9RflKkBhqZ9SVi5rwVLhbSEtUYV8v8w=;
 b=fU6Wnx65LY0/KbrfnHiIvjThqypQcre+d8bS25oT9LtxvT4eXiWDMrY0Gz2BmY/10mgYcAJ8M8wn+QGLS/ECXv/cEqjgf9lZjHYN2lGhmqwxCfZB6pQdvqWkdYhw2x4aUf3bo6+4UiLMsXKi9JGGj9VzgfRHhXPg5vv7fUBhAssUsyyCg7qS5UHaFZjrDgnWniuJPAvDHeIP4PY61Bl29icDMAzqlt9WduTUD6eK3zfZz+R0i+NCRlX74gI3S196kIXaOOBbqLYJST9RxdoeJ527NCBhgPF/S1tBfOqgTllj0mI85yEXiY4EHCw11/3i74LmdH68kHzIO0J/c2we3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UDi4yuSQkHg9RflKkBhqZ9SVi5rwVLhbSEtUYV8v8w=;
 b=FOSG6dcmOud/69kHzMxvf84X2/Uaxs+gb/y2A3uGoEjhPx684YVlSr0HTt0vc1xfkn0h3/EyZ4Tn1wr5nenFmpK4gwogn3dZESx2stjXHCtSDuuwhn+DpKCc+aep41hN9Cws7SetDGRVeAws5lyD+opdgFkvUPdWPCFOphlPAqM=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 12:13:16 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::de) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:12 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] cpufreq: amd-pstate: initialize new core precision boost state
Date: Sun, 4 Feb 2024 20:12:52 +0800
Message-ID: <51d8381943c3cfa7841775b02a414355f6baa20c.1707047943.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707047943.git.perry.yuan@amd.com>
References: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3939e072-265f-41c0-4248-08dc257aaa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vZjUvKWwh8eJ4VLlmU8vP5RCRiOkM/LMy7jSxhc32eWaoyFMD90XoWO7dR9p2nu0midQNm3DDzFmjqpioriP2s3hnSDz3l8gb2nqAwdvBdHCw1a/RDU95wOK2mPtnuUZVQN5XIP24MX4TG+YQqW0p+wbop0Km7e0FlIjNWLSHLX4SVREuJEB0zaA0ZqvkgxPht9Dp5HVHLwSERJHutRRwUQZC88/3ovNtXlqWVAW+cFFfqeS3YW0shu9FMfUvCJ1Hu/wbmoSol7EYWiB0wQNGLKJGaslpN9mF7DuMSCDq8i8/uVzSLZKfQOQy9NBX/Nh28/J+5VUUsxsQxKMOXa2peXC3DCqKF+NKNytTU7Tue6xwm/1iERd7DH7BzWBsWrpp08EiFyx1bsHWS2DfCcLtzj9MUl6fldyYu0zwWCg6m+tovDu+dqrXN4azX1fLEcmi/vDJlKr2uK4zlPl2hc3RgdRPJ/KsaId/mbejsq8zp8NYAWyEA3UHC1wytMhqNEMjvy0nb9Y/wpts3INOyc8lcrK38WOoNuay2cfb1XawAzKvQehfhpZSCzUAHfrTd0SuUi4IwuIGcBuIGgB3IScmMTCouZHSeYt37n8A/CFrIgEwvt7VH8vE5IrU+gojziGvLh+S23zZRFE0mXPUYbWhc2cLuKaiJldxsnIwELGlFlQdXdTuQhwGxaxhFEn75ORZ0F3KRunA0IgfcJAhHdpmV56ImM91o/piWHePpRSBHj5h1Drsm6tON6onnY/6nxYwrZ75wTA4kpyg6MLHyxobzzbnwFg58JRk4YeJp/E3t8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(478600001)(47076005)(26005)(83380400001)(16526019)(2616005)(336012)(426003)(356005)(82740400003)(81166007)(36860700001)(8676002)(8936002)(4326008)(110136005)(70586007)(316002)(6636002)(5660300002)(54906003)(2906002)(70206006)(44832011)(6666004)(7696005)(966005)(36756003)(86362001)(41300700001)(40460700003)(40480700001)(518174003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:15.7248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3939e072-265f-41c0-4248-08dc257aaa92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

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
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 61 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..921324ab9580 100644
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
@@ -632,43 +645,21 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	return lowest_nonlinear_freq * 1000;
 }
 
-static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 boost_val;
 	int ret;
 
-	if (!cpudata->boost_supported) {
-		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
-	}
-
-	if (state)
-		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq;
-
-	policy->max = policy->cpuinfo.max_freq;
-
-	ret = freq_qos_update_request(&cpudata->req[1],
-				      policy->cpuinfo.max_freq);
-	if (ret < 0)
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
 		return ret;
+	}
 
-	return 0;
-}
-
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
-{
-	u32 highest_perf, nominal_perf;
-
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	if (highest_perf <= nominal_perf)
-		return;
+	global.cpb_supported = !((boost_val >> 25) & 0x1);
+	global.cpb_boost = global.cpb_supported;
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -701,6 +692,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -750,7 +744,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1118,6 +1111,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -1168,7 +1164,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
-- 
2.34.1


