Return-Path: <linux-kernel+bounces-57445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0484D923
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AB11C233D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FED2E85E;
	Thu,  8 Feb 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QhSowdYi"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63342E632;
	Thu,  8 Feb 2024 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364266; cv=fail; b=A8sauSlNQLef5i5imoIXbn++P4NxKKGDgrlJpIpG1Z8JTa6oh9MQoHI42oa0AjuMN0WkVKBCk1u7LkB4wzpDvJlAys9ejYShiTCscX8sd4ZO/nzwrzv5k1ezvBvS2Dz94K9churzpL98JW9cxgjYaSw1E57Uyxy/23s3PP7UF2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364266; c=relaxed/simple;
	bh=i0/3Y1RcrmO1kxZ8mQEqBybxtj69hjageTPfY0V6nOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6XdLlbbV2Ei97Xc0eCsUCQOtGhdnhU1OZurwbPymgXVsjqb2HBGSwQgubTH2OClYZLfqftQrwyiJBAo3Ps4HWn2MZpxwsNj055ZAM39HusqwHr6afzeRucW6cabsCev+7LXiWaKFo+W0sHXAwbVM6wZ1CmhErA8vzNraDJ5kcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QhSowdYi; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7/i6advmWLZQcYn86kKb1iFOvQvacEx6YEniaLq37pJ6hV7KwasuPVIG+EMu30PeFljReZOKhX4RCwCMLbXKOHFri4lvEZDaUaSQ+rHRtOnpqQZVc2+YugUw7ixxdE6jQJjnkjEKqxaZGIvhgCA2wyzQSPZWM1hxjqYLYX0dZNHBurQbNthJGOcX3X0q+0a9z0dyVb1jsbQmkiSAMncgA8t2fL+olTXgkP1/Nyl8xTwkz0xaVrJkI6cd/Ml+ic/aLwUPEjHJflAxEGWaTN9StT72fF2e1Ke/Zg4gO3FvRczrhXXfNMXtrFVLbW3TUNGNzDreYQIHnrsWfdLmKccqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=XLxAFR85aQZIQl8pd6QQAiPnTl8LQXqbwRh2UIedlhtviF2bLhEtHl9lgWLXJzy6xUAPwl5dEq4IU5nzWiarKZYfwgVJKzjRxDimLImxrAHhcyZaEhmmyUrnOIK/ZUbWxR5zR4qd2RtTn/5/Dv/wIiPYnJtwzsQEYyftjYO7hhS/nf20YS9hF4Bpd4rDmRpkvqINdO8Q14bu/dLjZGk2cutpn+NiiK9dRbZQUhiJdSjB0GO6NQdYjphNlQxR9OQ5Wh8skDI0Y1FeidGHtdhTZB122NkkT/iy1bJHROnFdlr8ugodVH/04DuxTaI9dCB94NxZFKRonXI0YsvZN9hOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=QhSowdYi6zCm+aGMaay8ZWAmRvjFXNB9aZ7iwYMjty9RsIY7RZmiUZquuJbGkCRvh/09Zz2kpYnGK5Sg/DzhKuprItxf6lQ1onxpJOw88++sdFvCtECmnx6xQ/+PAH0f/nshYOX8SqEGRoAcajOCWyGw1SKnZM9fn/NAI+o/3wE=
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 03:50:59 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::d6) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 03:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 8 Feb 2024 03:50:59 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:50:55 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Thu, 8 Feb 2024 11:46:30 +0800
Message-ID: <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1707363758.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 459b2eac-697b-40cb-0981-08dc28592965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kbWdOg56A5UfejTeRMiHLG0OdfuX4Ti716WkQE4qGTod1j2GEzCUUGuHMlMvOFD2EXMPqko9Ry+WkWXmKLhPZ2ZKbvcBEjmKfyK29K+G5CsTnHUutqB9C+uMS5ZtdUH21SlYZ1ThHbX4ubTv3xeCab7mTKcKVXi8b3Ko0WCTmruZrYnZyey4iZnXdBtZIwcYiI/5R8+OLy6eDs6ARHS014Wm74VzNRddhGz8SkE2jBgQtMEjEJstkGk6TuHVPA6TJE4jBJDg9FHJXX5NM7V3/Ds7RTJRoCtxDvu4FUUWBp/hYZk2ObXgyPM3fZxOlGNG6UTy8ZdDKaqj9mHKcbmvFNsfsoyxBxHJBZZWW5DUuZa4aOyhqzC+VaW+WEcMVLx7VNeOIAs6FunEtw815CjYkkYYaRG3sXb8KuV+uJIpmXfdG4g06qYObSXD+L8lx44KO0aotbSto9H9KSUXKqrvW0xOQRbbTIvTTIM55W0I2SELmNVKwJ3d6c8Yczx0gqB657U36HLF/R9KelE3oj+DRVBYkYVB1P4HY1rrX7C80balMmnHuaYh/OD59qU/v9jR8TqRGFszcGmuSJtrjaTtVf5xXXpGoBdx85HwFOsmi88=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(86362001)(41300700001)(478600001)(16526019)(336012)(36756003)(7696005)(426003)(2616005)(356005)(81166007)(6636002)(83380400001)(82740400003)(26005)(6666004)(2906002)(70206006)(4326008)(110136005)(44832011)(54906003)(5660300002)(70586007)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:50:59.0986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459b2eac-697b-40cb-0981-08dc28592965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

Optimizes the process of retrieving the nominal frequency by utilizing
'cpudata->nominal_freq' instead of repeatedly accessing the cppc_acpi interface.

To enhance efficiency and reduce the CPU load, shifted to using
'cpudata->nominal_freq'. It allows for the nominal frequency to be accessed
directly from the cached data in 'cpudata' of each CPU.
It will also slightly reduce the frequency change latency while using pstate
driver passive mode.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ac7faa98a450..ea8681ea3bad 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -619,7 +619,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
@@ -654,7 +654,7 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
@@ -848,13 +848,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -893,7 +894,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	cpudata->min_freq = min_freq;
 	cpudata->max_limit_freq = max_freq;
 	cpudata->min_limit_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
@@ -1310,12 +1310,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
+				min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1328,7 +1329,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
-- 
2.34.1


