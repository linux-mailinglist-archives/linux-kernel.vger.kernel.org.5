Return-Path: <linux-kernel+bounces-154645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57B8ADF12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453602873D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2BC56451;
	Tue, 23 Apr 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fnk/9LoD"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4955C29;
	Tue, 23 Apr 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859141; cv=fail; b=aswbWNizotscGzP6yk6bRuk1KswLqM4aKmsCj6ZqnNl2LcQmShIc8eKheKpAg1zmpO5BDzfGP3r80avhI2kBQRYDtsUVCEmxLZHUH2VCzD2TBlH7Bh7dJzopd/tP3c0x9jPDdkoHIbmQawZDRdNj+Hj/10mT5ZsIKN5M+RVPL+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859141; c=relaxed/simple;
	bh=GOEylsnGtnQnASO5apgdHql6QhHuHp5kmw/FAiy/xSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1PnmujNtgOy6fWyajnVb/zt+4vFQ8u4n+WXemjrTiPE9/YJeSN6mL49W1OB2EbzSTUYU181mAtFeJY9dzQOielKTq36JEUbCwK0aPERkl4SOBsi44gyCZw1X6ck+wEI3rRbNixA5nVb9Wk8LDAbfCY5Qip302GMiCdoBlSfXS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fnk/9LoD; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMt/6t6kqH5tX2JpP58tJUZcOjJBJugvBBihqgJaI/flhxpaRptSMLzBUXfCpNs9liTVRCbvU6FelB1Z5jmIiqwL6C/EBij8ZpXvkAc1t1Gb4HSdcs5isMUQeenJFuHJNZNoj6fXMGC/wwzGlU08vljAZ5+UD4bX/OEgUosd7GVkUrmhMTQGUcILgLnKnbY/nfqAhX2QjpJJJU9utt/krPZWEvMrs07iGd3+/iU3gCZ/oQj6E+ACqmnDqmP99OYcqhyvAa4xa16minspqx1jUPhtDatfj0YRX1HZFV+hePw+HelWQsb/3nnIsnjeo/MWddQhSSJxcCu6BA5ofXXUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWFXVGCIXk3NQuI7JxRsnYQ5oZtrEZj2oetcQrcIfN0=;
 b=LPTp5xgfdXJs/2lspMUKlt81lWh/xivZZ/35d8EK/HE+CbE3YMI9NpKvpbDT15ISv5/vEA3n/3WeIeXraIlUOtPxcqE/3kNnPa/kezkK05wXq/IBA7aNMc2lRmE0WIRswZkrxFQjP2koNdx7s9Q8S3MGG7h0fjPTg6qd8Uj/6FBLBvW/RfDB1AAVSrZf4hc9E1EOVjF+H86tQBqMLRg/3IVhn6SJlrZbQXaIhtzS/OjE0MmI852d+F0Tdm3mcgbpzWgc6GDhlvKLzo8FgTOAVWM0JsVJiYO3vVZSnx0YuFLC3cfSQFlPdTxMxnhHfMfjJnth3/X9SIIqhDhUjsl5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWFXVGCIXk3NQuI7JxRsnYQ5oZtrEZj2oetcQrcIfN0=;
 b=fnk/9LoDzL6JK84n3QZsqwwH89puy3dA4WNJ2lAd/o09S43vgMUTsIDybAIcGTuS2BAJiRmXezrQH+SY7ItOA0a0LmIT8Fznl6xsqsaFATy6bm7hmt6ZO6+dB3cUZjVD8B24BfaxJhZZ/IG42DpwijjJhGo9qUMNLyRpIIFkK5k=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:58:56 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::fa) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 07:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:58:55 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:52 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 4/8] cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Date: Tue, 23 Apr 2024 15:58:20 +0800
Message-ID: <b5f879afc707249652c2c65a08a95a38404e7a59.1713858800.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713858800.git.perry.yuan@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 79aa5896-c356-4ff5-fb64-08dc636b39a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XHCdHpUL4sMjc7tRksZyRjrAXTp4T3FGft91lwyGtxFnTOrWwHCz/iYhAHrj?=
 =?us-ascii?Q?PnP+prNb0kNbM49zR468P9gTxXV2QBrZU0EGEP076ukFkk0uQcRC+ZKMDpr1?=
 =?us-ascii?Q?SPqsPxCCYEuYTYJadAdVHU4nR3s+a7N9KSg/3v2IB1pUMCPFRPXwumrL3H7h?=
 =?us-ascii?Q?/cXaFbmSx4oMtenztsA/xmnvYUWW/h9NVMMEGJ9x3Dmc7CqYbqEMXFQ18R2a?=
 =?us-ascii?Q?iKZWk9ybGUHhpp44E/dljIyQKi8XXJoBVs/a+0g4itMs/A75DOLGtEk6G019?=
 =?us-ascii?Q?2llDl2Vsgvd5b00YClgL1GKo8+Or4GWz6OBl+b7PNbbeFrnqrvoQ7LO2ChP8?=
 =?us-ascii?Q?A1Ui42+4CcCERjfU3NEaJOMlFwQPagBOTwEW8c9ZUCRCFc/RvrKiZqBO95UA?=
 =?us-ascii?Q?p7ZBnUQ1KohQnVbc/UWNIjZQPxT/Lp4PYjrKuknOBQY/V717ZWkK81e+JbfZ?=
 =?us-ascii?Q?DWDy9BIqr/HZX1szil2avUXViUUYtlbtMFDpKmZ9xUglcpHDSMEMiCQUk8/I?=
 =?us-ascii?Q?ydQyPhz/Mbi37sK4gRAONiYK12grShFTYa3MlJhtkktGAwkqw7Q2LLkwVmj5?=
 =?us-ascii?Q?6udPBUqGByU0FNqzS+TLjEyqzMtgXE1+nyv/UoK4S1SRC8WbUzI7MztiTWdP?=
 =?us-ascii?Q?na70ybpb6C2iqw4WkIg82TXHJ4WbbTBFqSh87CdryG/oByHBYMCWCSpo831H?=
 =?us-ascii?Q?2vWbXAanvpqBVPieJ8NuUutz0sbIywStRkmDERXb9B8ruBuFqaVwHxxa0R3J?=
 =?us-ascii?Q?gu+NR0rZ8YU59Fn/Zv3lq6ssSGIY+BD0w0rEkrb/8piz21lt4GVL97Lr66zx?=
 =?us-ascii?Q?SExkOIFgTcjBwEj9LEVmZALp/uN0C/sDC7McX16RJkiO99CsxM23quzuAilt?=
 =?us-ascii?Q?93rJTNXmBIYlkvia6S6vyRdLM0EoiT6ZpWrCMfOl8jQyPc/4fFGWxo+1pKQV?=
 =?us-ascii?Q?eDtEzKCHOTKpGCN7OUyb9W1MA9GTVz5+aTm/ZQCEA9ebUvHw7rN6ZbHUHMAS?=
 =?us-ascii?Q?pHPFuIwd5/GPOg3Iv0zQLq50j5RU5R6U6OGijc0Jqf4G3Fi8IAKg1mijmW2E?=
 =?us-ascii?Q?dFvCGFmrTIaB+YI7azACyqWjZNvyRCmfU2EeiLf6tPDdyvoNH/NOrsX+p8Dh?=
 =?us-ascii?Q?Peg47BAh/4cauNkROzwZD7k82wd6sbYxGuq7kpJbiXy6+QhKhZzQGiuMn/2B?=
 =?us-ascii?Q?i4TSox25zMqP/YnCuhNEwyq5Q4kvcxsLKoKLpo43ZyZWpCl/xzchtvpu4wCr?=
 =?us-ascii?Q?foWtIcPXNMWhVHEFbNp9ahkugZW4fjxzJUIbpYFCVcgP2zBun6NsdkAAuQbs?=
 =?us-ascii?Q?4pXJaX4CQN2RkjG9wvoBGf7fDJfNpNWE+7MJXm15EzQnEjmnfgafFrQQGNsW?=
 =?us-ascii?Q?36QOvaWLr/Mm7itUPsaL3ysFbnED?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:58:55.9169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aa5896-c356-4ff5-fb64-08dc636b39a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.

There is no loss in readability in replacing their invocations by
accesses to the corresponding members of cpudata.

Do so and remove these helper functions.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 +++++++++---------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 891fad6f90e1..3836d62b54ef 100644
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


