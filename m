Return-Path: <linux-kernel+bounces-54313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ECF84AD95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5ED1F24B77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305487CF0F;
	Tue,  6 Feb 2024 04:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vu2TjO2N"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB987C0A4;
	Tue,  6 Feb 2024 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194108; cv=fail; b=NwYPzpJdsiD2yxIfPKIqYi/xg2zdZIrja+Jup4zcHc9lq/3KYd5d+prPbSw7eGqO2TkLPtGrnT+QiP2HbtNT1DHa1OQuy+/mIXwm3j681lzxzVcbAk2XZvQVcEQAk2goIT9jEclnUGiu6XFlerBcuqw7WThCzERK/jRoR0tlYik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194108; c=relaxed/simple;
	bh=i0/3Y1RcrmO1kxZ8mQEqBybxtj69hjageTPfY0V6nOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jckYEpEF4ie7OT005Sl8y+7pKPxvy7fXADSDBz8O7gBfnD0LenG0Q0WjEGiBgiXy0lubfZpT89pGC6Rf0bwS+thvUmhNOMJv6J8C9ZcM2M/LyDs3OKOIimEi8+5RZHy8Bui3hZaqpxSq/Gyhx+VBc0786saxIi/vZ2ztkMvyg14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vu2TjO2N; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbxir7c0d4nAuIOKhxcHp0v4eriIMT8fMbaDst1zS87CoVtsj6p6VwSwgG+qJMzY5DnAG0ng/sK05prWkb6JoKoIjsDO0cP9RZu9f1vwrs9Xo4m4EuGU0v77146HfqX0/s5m7GGhuQSUgQQkCiVC0xBOnS4CupcKVHhxG30aL3ZwqKCJW/SJWoK6rM7ZvngeN0sD1ubYP6AapsRBztCdfKsadcRB7QEmd+bZawnJpRVGMe76DCnmsYi7H3PmMpDkpAlHT5Bj4TbLPOg1er37Jo2TWQgf4RmGgNfBDREmZxoHJ/ul9AXPrOD9cw8iYYFCYQrN91/obn7rzvhysrMxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=a6OOAoakK8M4dZDVlCynV35ZAuORwVbZIHJ+MnJt4/+ARdnbyWHfNQxDCr6SQMM0DNvONC8a3XuBNfemnxCqgVTTgJN7ETuehgufNhZfXGJ/nMvGxLts5f3Y1YSVIzvmJNoh+eYMeO1Cww4B2nLbRj22KdfiIiVdraD3W2VL7uaNeIjoXU/cvKpcXZeMZjv/0QGXTNiEWI/r7PNxn2JFY1J34SfRrr1i0qXRflWnRO0wn0iwDXKB+Y3PCfUDZjsJvJjFG5XzjeZg0dI8j4P2z26cBEAgfu1ylW8C+8dVhceQcKrewGjJaIVtlmvZLP0FzYgnrER3XRpI7EIBpRWMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=vu2TjO2NkQjyV97BpZ8LrAjfXSAhFd9w5oW300y/KnXCFp0GWqe1J4qC/Wjs2NEN3lZlorSJS+PMXqOz/haatc+3L0n7EM/GsytjL+whoUodvbJibvThE/p2aCX+P1Oeo1iSmwrf59uJ9KdlWVzHmN24F5aslJdm/lWPJmCVlEQ=
Received: from BN9PR03CA0320.namprd03.prod.outlook.com (2603:10b6:408:112::25)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.11; Tue, 6 Feb 2024 04:35:04 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::18) by BN9PR03CA0320.outlook.office365.com
 (2603:10b6:408:112::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:35:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:34:59 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Tue, 6 Feb 2024 12:33:56 +0800
Message-ID: <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1707193566.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707193566.git.perry.yuan@amd.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: bcba361d-0d50-480f-8b7a-08dc26ccfcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/04dHBIbwP7TO1rf98sovBySimeBPJ0JbdekWIMYcMqNiHuYSStcWykIKyiQ0RmsQ5ViDUnSOKUetYI5FqHKdVkzut0YZzHNpnAL244DG2tsFzz4XABs59mUjroscz7vjzm3iknB/FJBPk+06wrrRjehIHylRXbSwdlA5wRKe6RjYSnXHKCkwE9oxMwQCVR171EOG4KZYXPuUYj5r9uYB/IdbiCz3aiffDHgEgSFDog+E47jTYYd7Q9mhSeBskVtoPfurtvUwyDd/q3LgWGRyYOIwPTusYVmNh6ml1EqwFssJUV07dMEq2uJ2MFV2RsUCUeQHujfs0XZfH9CUfcAghu8ZE6bvjUQejAmjHmuqnc6d3VGSa136/dAyhQUEZ4GLPTs8h8nr6qMCsYMvyGxyJ4O13K3lcRIME7vqYBqe8vgNfy/0KlpfU3Z3n1I1w7FiCb75mMz05wXKeXDzF68PbaUeplVRlhUBKIqCKFE8ZgvA2vIqmKwWmrn/wvczGKlMwSN0EdMENMsZoQ9bQGb1sXvNNjPDRaBD3RNMrjIMq0FGxecVWNowm8Iyb6R4OVQM9Nzi18o3+tEukC/xGjndTVB+Skbggl7HLOqznwkOJSlxDcTgtZSOS34MYfcqx9KKiO8P5q3tLyvwrZ2A0PDiENveg040ys5OByDYcWX10Dup6rvMBe0rI7JmzrXnGxOwJaZWLSJZPZifUDVuP/dpmMC5jQHqTLAMKIObLRB+Q5ydYtyI2QYqtfaTc8AeXqr+UcgBeIwTAnqfPD8Ch60aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(26005)(2616005)(7696005)(83380400001)(6666004)(426003)(86362001)(81166007)(41300700001)(36860700001)(82740400003)(356005)(336012)(16526019)(47076005)(478600001)(8936002)(4326008)(8676002)(40460700003)(40480700001)(5660300002)(70206006)(316002)(44832011)(70586007)(110136005)(2906002)(54906003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:35:03.6033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba361d-0d50-480f-8b7a-08dc26ccfcce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

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


