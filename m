Return-Path: <linux-kernel+bounces-105911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5BC87E64C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7BB218A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A4374EB;
	Mon, 18 Mar 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T/xwNtQl"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35067364AB;
	Mon, 18 Mar 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755348; cv=fail; b=lsSVRX++SucmHhnu3JoYmgq7kpQg6iRrxTszMhQu+4oVm1xckkKSqel1VcRidgvQM/sKXmDIwWhcSsKLACs7wLDaw6Wf4plDNbdIaLp/fFlFaVBxOmQwPLUboYO0yiPRmj2ib1agbDOoip/NUyQx6aHO1E2r3+7kgPz0JeHVOjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755348; c=relaxed/simple;
	bh=TDAJbCsL57P9fRFTdJTSK/LKTJriCI5VlN+gDwTLAGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLsiqAXj6T9RKn3WiMkEdOmk//xSzwpZpGbhc1uqeFw+wKu4roICc/XXljzsNP116e74i/VLX9vZeoc5zTMeMlMtjz3UUkktZRLFGRbWJ+6WGvmvIBrNaCuC2I3zs1B8jUS5rmkIpttepWBmFV3ogTbiwsDpK7JCm5ejmNYMXMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T/xwNtQl; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7OFAwzzVitCffn8/hUfIsNoZeFxU4aDUQs8q3JOl23y0A/guNRCQC6rsJsz3RbIfxUmgXWOlLlnNuNHEXGn5Dii/uHlJE9T/5pr5ih6xix1YLS4Fl5Dxg4PYgy+QLk4f01d+IC+52Zlb1ps6ZdTu5A8JyN9xKpgx6FHzSSIg8+HgnDBWjlsQ1COiia3tAD2khSRbkUn1wlA82Ld9U/T42rI7g8FxHXlixIIL82QvhDzGKZFirwbM+r9qf5isc/8pCrjZiUrnHc4//Kuj45RMqu181/t1u/R6jcq9MmhZyOmGlSHycIEsM01vbqoQCdomvgzsMtG1B4yxenxCVNEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHtQBdqlY42oFMXHB4mQbLlmfetVZpy6Pc5nXAGt7GE=;
 b=Au2bNQLQa6Bd+L1sHe2uQSvQMkACA8Mf+QZ0pzX1mFnkYH0oB4VUvg7L96NxKd5DVtbmSZZCZQHEL80Yk3s5RDlwxfaMZv/oUnmZfx10E979LYy16S7sbTWCOfH9/QRrMEmJP0b7eQI9ygdecKhdy85XqowMrirBQ3vcvMl2Xrulfh8g3kVre/isBSAyjj2OzpUnStOjLkoL2qtfyC8N52N4T7n+S9OagIAaxmAkeAYv8+Q4Q2MhqPZnlzvKuLMz7nMckHBz4VRkWOJCMugfKsN0ku2zirjNpBHKDow3zzRpHELCh1ajydyLPLnKkOhWEN5fsp2fHzkymK67fouZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHtQBdqlY42oFMXHB4mQbLlmfetVZpy6Pc5nXAGt7GE=;
 b=T/xwNtQldgkrSY0n/JKtyyYV5Bu8SsEOoXuWcT5fP0UHTbCeDmoVyzX1hBScP/Yjd0Y4wURtxEyY95pLLtM5R+sEZ/qsAy6EhrDBMCRJ9JfzXMDdWanRasM7bsk0uCugycz/DI8QMZxFGARg64VLD2/uhK6zGLP5ut5uZI+0jzE=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 09:49:04 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::cf) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 09:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:49:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:49:00 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/8] cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Date: Mon, 18 Mar 2024 17:48:23 +0800
Message-ID: <d9fe75ae9ba3893061c01fcaccd93f2915b09a35.1710754409.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: d99587ea-bbe0-40bd-45a8-08dc4730a550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UVImm53ahxpUe4noQJF6gFRtyDyKOnpwqb56+5jn1UcVgAf+PlTDeBj6xQLiv8P/N7YSx5pYA0TMSUd5lmyf98WTvtP1YN4eE1dbs4KGiAw+K47aXkP88b1ii+qLOu1XK4u4uUpxvSwjBAJWSs/hp/HJH8GEAY1kiXvpIM73BxqLnGQhcZyD4uDuOyCVXgZVdky9Uny+iobo9sJ1YmjBTNxpjdvr/HuDPE9Hl+oWGintc0GYcmRqrYsdKCW4IajMWUoNLgpUXTdz5Pe6U3ox4lr8s4QdBpNOvCKooNJ8pSTX0b7I1gPVAAHyzECnFUHBVqLjPIWA98nj/tEPU6uFbPXelAFwSbloF3HEJ1xxz/ebnBN5M15svOgzVrmf+lj6uXqJzaBko+FfcdBje4k0NIe5JPso/5Iwa0NpdIlpAOGSwjGsiV9zYbBwu9tmOzfK/zvHo90Z/7/Lls44GDf08HV7dq5pYfUMru735xHNqba3XWVv/5uh/14+535SUwkSiRmrPKoPjYtlUxGLzIUHoF0TIy2k7dsstbnmpN8VThpoIi4tN1EklIq/QdHA4EnRzaLj4P+CYnCOgevXTnc1a2Py/abkWVTmgCzyKePQnKN3fPlenSp4CMZ+uyQsFp/fNkLXU+3blmY0CDeZY3UJ1e1XVTu/vjmDb+PLVZiHTGf5gwWaYdcKTKZLkq4fJpR4McbyY/wzGUd2Hjpwxi3+wO/p+v3X1hQ4KUXdZp6VncAbDdMTASQzWTYZyulKyy+X
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:49:03.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99587ea-bbe0-40bd-45a8-08dc4730a550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.

There is no loss in readability in replacing their invocations by
accesses to the corresponding members of cpudata.

Do so and remove these helper functions.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 +++++++++---------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ba1baa6733e6..132330b4942f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -604,26 +604,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	cpufreq_cpu_put(policy);
 }
 
-static int amd_get_min_freq(struct amd_cpudata *cpudata)
-{
-	return READ_ONCE(cpudata->min_freq);
-}
-
-static int amd_get_max_freq(struct amd_cpudata *cpudata)
-{
-	return READ_ONCE(cpudata->max_freq);
-}
-
-static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
-{
-	return READ_ONCE(cpudata->nominal_freq);
-}
-
-static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-{
-	return READ_ONCE(cpudata->lowest_nonlinear_freq);
-}
-
 static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -854,10 +834,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
-	nominal_freq = amd_get_nominal_freq(cpudata);
-	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
+	min_freq = READ_ONCE(cpudata->min_freq);
+	max_freq = READ_ONCE(cpudata->max_freq);
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
+	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 
 	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
 		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
@@ -960,7 +940,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	int max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	max_freq = amd_get_max_freq(cpudata);
+	max_freq = READ_ONCE(cpudata->max_freq);
 	if (max_freq < 0)
 		return max_freq;
 
@@ -973,7 +953,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	int freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	freq = amd_get_lowest_nonlinear_freq(cpudata);
+	freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 	if (freq < 0)
 		return freq;
 
@@ -1315,10 +1295,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
-	nominal_freq = amd_get_nominal_freq(cpudata);
-	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
+	min_freq = READ_ONCE(cpudata->min_freq);
+	max_freq = READ_ONCE(cpudata->max_freq);
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
+	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
 		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
 				min_freq, max_freq);
-- 
2.34.1


