Return-Path: <linux-kernel+bounces-51404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E4848ADB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D29A1C21791
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D18A947;
	Sun,  4 Feb 2024 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VwhJumqa"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A288C02;
	Sun,  4 Feb 2024 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017205; cv=fail; b=dqskSawkE9lObd1cIETDoDv6WNlSAfAiYL4WXODM8ps8J4rqEJlzPEW3Ly8/3lEghlPC/76ifGEpIbEIN+wDPdLZdQVSZsUXwkyQyXx4+0iBsItKrQ8uhDJEAmMh0YbOCDwnS9v9CK3Iz0lmQLaxkOzETj7vV5s0NJ2KiUXSbYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017205; c=relaxed/simple;
	bh=i0/3Y1RcrmO1kxZ8mQEqBybxtj69hjageTPfY0V6nOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb2VBDmWPsbiQ6f8lmJNg0jbEAo4ikPHjzrsDVpVIMSJvf8N5Z9XVPbejDl+rqMICuCEjTC7Mzplkc/72dhRrfhI/+UyE9/z0UxE5mJT9QFdUk0u9/QiJYRneDQPtoxexOil5NncCNmIX0/KsP+Xt9nC32EI2OycYrmkxYz1KjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VwhJumqa; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNc/0AXRZNek2byvBKgSFd0HujkofzrQeafuX+/FQfXo5btpekqtX/Enutz6TS8nU0y8OrZ0pAnxlslVw7a22/YfjgSC/gsbGZGSpi9hc5JbIq0BVCrDKxluy2cq56jaiPSU6lpeUQm3xEdykJHJpJIn+Z+Fh1fAcx8cEEvpXYODBFAWsKMVSkoOCfgjNKmvNfVEwSnApFp6MCCwSvo2ZodXynh9Ivy5yQBnBQpdrb9ZNPBGh5cQHiDaPLdYYP/r5sTuMVtmFyZIw1fvGUxkwYoovjaoz8o+yqZR6UJiuqK+vRrAgmKovwCGlKQIybouczzTksu4F0UWmj+WE3djMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=O6lXnlIliwP6Zp7ZbFq0t0vim1Md96LHXA0cTFtQLEVM9BypO3MZW9v69KWz0KoB42eu6azpdyJIKWA0JuIl/Kio8QKT5GD3Y5N+81yRBktp7kRU4+2qDwoCULEJ8c0KEP7wPsNX+8HwsurWx1NVdyKM94HqSvMZbcX0pOCxT+IG8YdvZodvuGqYf/ZnGCr/UKguvnIEcPpAs+U29br+9w5exGibp+OzT7eIgil4R1TrmKIq3Xqm3x0BPz2PTv2ffXTDjNi1aNuApcp5+lTF+ZbmorB8zknC/N8QuAnOIJXe9U2wDZiw6oargU/jceZZXpkdrPEOA22OFJqaLScHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=VwhJumqaS3U2awgnl9gBZE2Sojsr2zg7cnE2w/MPc7gaD2vYPwSsAIFwluLBrT9oGU/Dz1tD92bZWGNuIiJbv8ujTugtR4tcwKXpD9DO1MO0ZPpZ+u/bWDvIK7c0NMMekd5kKLoZm6hjSMtjVfhaD4ydD9OsemJFFufzX5c7NlM=
Received: from CY5PR15CA0172.namprd15.prod.outlook.com (2603:10b6:930:81::15)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 03:26:39 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::90) by CY5PR15CA0172.outlook.office365.com
 (2603:10b6:930:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.32 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Sun, 4 Feb 2024 03:26:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:35 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Sun, 4 Feb 2024 11:26:11 +0800
Message-ID: <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1707016927.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707016927.git.perry.yuan@amd.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6b2fca-9b2e-4716-08f2-08dc253119b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TIXQ/c6IKK96ITEHPP/fPMgbEtECWh0jDBP9Wf2qyqI5vi86mqGTw7YzhUbJgUMMVCvR9Tx0rAFsaPkzKAUI/aKvIFL8fqUi1cRpVDX1y8zmbQqpBSL43oIovqGTeyKuAjBUuK3pI2kU58uXRbhT9JYVYbrTfn9fT8b5r7gTqVCHyN501b4waQVCjdAXYPHIrwrhz5QaRv/enBJ5ejf7p3ZTX0SCqUalfuRkgNcGc9lKJFfx+DTS5lBlXNSbiccCaCIRb/92ya/FTpvQiz4lJK6GLxdRaYDeytwhgjyTB3vJvkyKwM6pw7ETiMXkQ/4lOIW/B0NfaY8aUVq/4PxrIiZur9PTlKAH2z8rVOPEaVwyrHcKAzm9tsgEOzYUY1j/vAtxyjU+WYhYWsvPg7DaDkHPmvm4OdRI5q/dpMVaJPZS9LB4BQG7Z929260juzx11qHhHj8CRqGrebNYKcyczSLYBLoUcM1WS5Tj10NLeC1a5Apy1HiVXxG4TRCIpB1yitzHO7rGnOBTrLmhcLKNsTHcHTk42AmMr1OJMJUfsRPgZo+b1Ki1peXmIErIMWRhq6bj57O8dRgLty7sLJSWJ2vDhGVegoEIsO02B5tncAz281KA48bpYI+n8W99daSeCFyQK5e5bGJ3JStYvypjF7cw+1BB+9kuef/Lg9gsqDeEx9BRbJLH8S5/nMxlpu6kwHcg84+X6bmh3oJncA4bdx1l09JpljoEfhppeEdSdKoXLXKsP1v2LpRX0R5ROSUIzB7CY53uZXU6tGYNE/yn5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(26005)(70206006)(7696005)(6666004)(47076005)(2616005)(336012)(426003)(16526019)(44832011)(4326008)(8676002)(8936002)(5660300002)(2906002)(86362001)(70586007)(478600001)(110136005)(316002)(54906003)(83380400001)(6636002)(81166007)(82740400003)(356005)(36860700001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:39.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6b2fca-9b2e-4716-08f2-08dc253119b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

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


