Return-Path: <linux-kernel+bounces-49518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C080C846B60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50D81C2720E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D5612D6;
	Fri,  2 Feb 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xXSyPeRj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62E612ED;
	Fri,  2 Feb 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864188; cv=fail; b=dXtzEQySRempu8XpPNJI/mG2rImqoGIwM3t0MaHyoL7Hu2o72TTcSEVe3CxMkxLheJ54IWSqPtfCDdNB+rKF2HAhtRPDC/XBQphf9L8vZpCzOtCUwLgoQUY/R0n+uuJi3NQB+QrEYPYj11QddlmR7VyOeQTwqM6sfhYUcLK+o3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864188; c=relaxed/simple;
	bh=i0/3Y1RcrmO1kxZ8mQEqBybxtj69hjageTPfY0V6nOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0s3aS+p8VnW4RdEcAVdxWw/JvQJt5RfOv1ky2aH7ZYow/bBCvLtsVTtO15cAEmPciYS4susnqYL4w6t8MGpFIs+Bbl4yXKoDH+TCkdD18/ZGWBXTez0Q+gxY7I/eMhSfRsv4iwsEBOqA6xI/YdOx4f7f/1Wyir+moiorDG/DNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xXSyPeRj; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htJLvvyCI1rHzSmolc1UoI1Jd5MYMdVMolmdIM3lEoq5UT6hCyGhb7iK4PaucykK4pjzKVQIyZuWhu4mjStmGm9VzSSLvGjD2Nwecl8vDRJg7e+YrnqZVmbxY9kAqR9CCosgC5TfTzVCVKdeUeosxQtzpZSRpjdTr4VSU3BelEmGH7RhJaFOHe4aNLuCistfrgGenIz0b+ohQ6ZJmOsMAfBIgbdIdO2uuOJrCmbpLAJ/oqJ8bt85tIBukzlwuqHoQPenv4k9dQKaQXhzA4Ac9F2YqARLT8AxX2PR4jcuMN0DFLrgl9aRP0zUMvH8IFg356zuJL6kQ5Rj/bJZAGLbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=EthjvfMX/z+9raS9vtMBJnbDb7VB1UQp1xpleUfIWaGLYvFsXJELXhChb/7GavrO1ewQexHqW0AZa90WebtJMD4Ok6pZhpuEdvYD0bZHQ3uHQToZ4knPNUjjf9dh5+j4nUeMFm4pm3vgXoP9s1C9MAbvCzwc103XwSwDSfWURpVDCMTaW2ROzP4yNQwAPh5ojI4MVPjjKCBQ5nqignNwGQ1WIWWogt7twipRu+pnvpy+I927QGIk8tVpSDE5Dzn2ZnNuLDDUyI2vOoANrGZ5CTqSBdRLDb3wimQMh0z9+BQXqTMg6/JXsCLUeoUUEl4abQ5tQaou1j228OSsKew4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=xXSyPeRj70khFRE/7YBpA4ZljpmODB8Npiyz69bvF9UpqMWVz47wYu3lasQDn71ciuPW4AMQtCITwww1kN5GJUVcVOPwSY0kuQUwLLFp+dRbveAWll4nLstAl1aeYEu3b64ITYfunh5lD8RmuyW2MyrIrt5beOIZdhb0AvGGRSs=
Received: from DM6PR07CA0106.namprd07.prod.outlook.com (2603:10b6:5:330::15)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Fri, 2 Feb
 2024 08:56:23 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::79) by DM6PR07CA0106.outlook.office365.com
 (2603:10b6:5:330::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:23 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:19 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Fri, 2 Feb 2024 16:55:35 +0800
Message-ID: <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706863981.git.perry.yuan@amd.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 23727953-b87a-4618-a81e-08dc23ccd543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qiqWOAG/tFEezFLW33IPkeDGxQtnJHIbzzlxaC12271EKNyI6NKchy6pBiIXGlsfgb8GU0GDN/DhLO01pPKs5nXddVm3e+eBCLoNCfIs8FkQJunOKmB6A7o+dQWr3f5Cr4CiBG8N4TeOPOqtsDwtUoLGRnGgYQ3urQ1s8VfvBDcr1J6ndB0EVbCF+jz9LkqYF2zdqaMS9csnyciMQ073Cb4lWwqn6C26BkdbvsueLEu7jeMP6F4q2jKogWrav1PRtdMtn5JJMEMc1Z71Q2H46gNsYG5q6/IP443jL4aV65uCx3e4X0kA0ETrnnOxwsmQYtyQcQ0JoVHXwI0dUM7cM4dzXRPwTJ668X1UYbWVGvwzpF7g2TdLuEw669RF/EBLTdVTB/i3+LLnCWfdDdpKB/+MY48PXzvnF2xpd2XNCcylLvXT/k0LMnszDvyZBX58e2yRdSQG7fnzu/ZKz/GXbHh02r4s/hfUDTeW5XiYcPnvwIHE1VefmGtwvRwF7PXlI65wNADLBpviQx8MmccVgZDgFxL7ZhVkYmW4/wBo14CDMsjbemNBz0KyYp3fdRGwkGmWt0cM8Lll5Uqs3o7+FrSalOgj/TvaqStnh6L146Yebhqk24AyPp81rqmIUdpzQ8EyAjiBJUJxJW/O5mRLkhoutppoiwsWMfp0Jbg2hmpLxeiNej+EJXiHAclyBMkXB3hVrNkW/CpMrLNBqeK2PaRdXatgF0nDxEKGMwmVy+2dIgs+XpwwgbFQ7ElAeUvDbpLDmjboWwyyEeW7yhq36Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(2906002)(478600001)(5660300002)(44832011)(356005)(83380400001)(54906003)(70586007)(70206006)(8676002)(8936002)(316002)(36756003)(47076005)(110136005)(6636002)(4326008)(86362001)(7696005)(6666004)(336012)(2616005)(41300700001)(426003)(26005)(16526019)(81166007)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:23.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23727953-b87a-4618-a81e-08dc23ccd543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

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


