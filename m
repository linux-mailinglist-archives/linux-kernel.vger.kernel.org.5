Return-Path: <linux-kernel+bounces-158173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80538B1C87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E5B1F228B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814584A39;
	Thu, 25 Apr 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IepBjWZV"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258B82D9D;
	Thu, 25 Apr 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032515; cv=fail; b=aIMOrYWgFUn1bVabPSqGxsBngX9yJunGNmaFDRED+cQRWnSJ00yg/bjPFfr2g7sFIYOWibiz9tic7mcrstgZCif8BaTslU9JrAcQykrKLmjmWDSrU91HSWLvWGrR8pssFMrpppZpF4R5nJa9c2ezhmvV4BwZsfo7hzI7U8Pk2i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032515; c=relaxed/simple;
	bh=GOEylsnGtnQnASO5apgdHql6QhHuHp5kmw/FAiy/xSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVcqmSklF8dFcukIkMxP/czKjukoOWhry/JE+vULyUjSN8hB8MH474vmiQFkqhfklrsPRZUI6QC6XZBNssIAWUWFyYB77dBcglA98lgDXplUHPJs3CFCMhKrkOvxsyhY1nmB14QGR/ZySn1bxHM3rzldhU/vC92IAc8TGiGZuoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IepBjWZV; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOs68A+LBjiaP3EyfJGXJmMFKPDE0VUSaNdd6fsBpol48Z4q7yy0Ek7Lxz0GqfhjAN0eL/Wkga5H3aFSNQyujgRHyzkW3q/DJLfHqLj/V60dgO4qTEpegAScGdcmmXVDCSYzkBjbihnOEDREGHJ1FidI2A43BaBDhTUyUwQkZ2yIRlbrWB/0CGpGor7ZNDr48/yb6KYG5XVrLeupYSQuR2Y3U9Y9HKNZgcBA7cg9XSPomdNH0Mfa209xkAP09poXeaDFd1PrGQ1erlhfuSvqSmsj4M0kPqmzjnMpSru7LPZG2nMS5/AO/dfdCM3ExGajrsIIfhTjO0Ja3KV+J/Wg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWFXVGCIXk3NQuI7JxRsnYQ5oZtrEZj2oetcQrcIfN0=;
 b=INAAivUfi/WRxhL+zbnm61V+5hDybw212E32LQ7CF5BOLExqLCEYswdxXASsrMWQIAHxbuaNQpkisvnIvsSF95jywD77EPqiHeq5b5eJvWbQMMQKPH59VUgfzE3nyIMM0laNjEr6QJZUZzvY4unX1F6q4Mzrzcfh74s6EOhc9b538187F9DkNcnBkpZNWvR9k+yLUQIBq5wDjsGh86Een1To9+KGb+BcudygP+1Q/dXUUHsBwHIyUidbJ71SAn7UWrEPljS7UR3zyrzQ+e8TUOF1LG1jE6PgiOncZqdcrNVnVZwL4XUiKMBndAGMV3+85Fzj/SrgNIuE0NtygfwowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWFXVGCIXk3NQuI7JxRsnYQ5oZtrEZj2oetcQrcIfN0=;
 b=IepBjWZVfE4HQJrCdBiU2hlpmb0MtZiGT/X//Ed2jYrNjHw467Sqx6FtGjmAa71Y65UQTAbzrqibRmhdg/iq+N8748b0yNTebxdDPPvKRDCS3nn+pSPKz3CVdwjsJirnhgEanaACRN/X9wxuIYg5VfzKqAJhZZ9MBhdKVpnWg6c=
Received: from CH2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:610:53::13)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:08:31 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::b) by CH2PR17CA0003.outlook.office365.com
 (2603:10b6:610:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:25 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 4/8] cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Date: Thu, 25 Apr 2024 16:07:54 +0800
Message-ID: <23ef36cc03ff5579dbb2d9318ed8cdf4346924ee.1714032153.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714032153.git.perry.yuan@amd.com>
References: <cover.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1e3af3-e3f3-4215-bd5c-08dc64fee561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7BF9hN0FOl6ImOGHYIkDpDuKuja+5bMrDW/mLIWXxm7uWuTYIraGhN1IPie?=
 =?us-ascii?Q?ysOht+7cnKDKj6/tamkUDuifjHGxk+Rr5xE96J3V+bYwbaSdqylomVbGieOJ?=
 =?us-ascii?Q?e0t7WSTMlyzw7WpRhe6AL3xZ5Sg810VjwEdTqswEJuvQfT5ezrY3mEOI/E6f?=
 =?us-ascii?Q?7h922eiNA6nBbSN5e96rG7SNQ2AYM9RyHkmQPVvomga0DBRR3KaQRUsHwjaU?=
 =?us-ascii?Q?ZyKBcAUHRHD1pOjP/atIaMHqXOTvMQKbfoc9UaTWSYmfdQXcW2WNoCb4Iw6s?=
 =?us-ascii?Q?qoh3au1vKUhdB/k0UPa1RSk9SzYn56gmbYJWjHHIVygPocq62itjB827+peL?=
 =?us-ascii?Q?UbLQH9ADJD4gJpZ5702IdZ4uwqy6kMzuyzP1jfyC6FaEuj83qZMVEU2uyxus?=
 =?us-ascii?Q?NzBDT4MkOQqPSA0bd3G1QKUxf1n3IVkiDrs+MB+0xBTvuoqSW+s1Wx4fbu4+?=
 =?us-ascii?Q?pqbNErhi3eD6ktBQDcIl5Pd4kIo+OUKm9W1DosUyvU0EgOKNL0vXiceLqZ0y?=
 =?us-ascii?Q?iquz2wMZfk5y2Yyd0a6rqFiabvWbur6B5sVLNjosCd1wG9NVYBT8liPEWXyP?=
 =?us-ascii?Q?w8zGbyfByh0Ro7bAKSYYjOXJ/C5P3UWUvUnULBoONq7dEPkGos9dP9DK90uk?=
 =?us-ascii?Q?aMd4q2K/LcJjZzt3CKkiphjNSbUZe82/uGCcYjcXmbQPhFTj3Phm5b10IFRk?=
 =?us-ascii?Q?Si2HPq2dicKMXWhZQRRPMQ/kx7tHssVFogDqv98tt6dmB7yyxtX/FF8SqlzL?=
 =?us-ascii?Q?vi5F8QIo6F/b5TrTP1i81kmbMOI0aLkk6SKMpCGxbDxNZOpl+4NDoG0el8+M?=
 =?us-ascii?Q?+7j7CMTUFNriSyaz2QzMxiUeslFURIdcoTZDhOY5imkxtyBUHLSbnP/MauXj?=
 =?us-ascii?Q?hISHe4ehBb3I2DwYL/TX8rPGH0ryXn91ZbeM7omG50+bTyLGJqXmp9uCGZW6?=
 =?us-ascii?Q?rhiQA90rY71OcUFL7R582rP0zgPlp3E2H7EZpLSKpzLa4UenSYzKqhCip/YK?=
 =?us-ascii?Q?xEZ17qUIuHAqDFxBZvpBVDpB1a8kygOmreWNJCNQctWcnu1ZVEyRS/DlP5Zx?=
 =?us-ascii?Q?3Hdh1fMi769yZZT4EPA/QN0D/LKr23iUkcErg+kVoYPtKfGA5e4Ah3/9lcqD?=
 =?us-ascii?Q?wwxS5ago5OLMGP7BpiCZbHxY5SEDkqKUbFYjsrz7DhHevo3lbdqJgJmaYz2L?=
 =?us-ascii?Q?m342Rrp0xZSnmdWgfFcgMqY6YAfUHThNwWLngaY3Br9C6tA90JvMvqX5QbrA?=
 =?us-ascii?Q?VtsVkVSYNDUgKFFBeL+6efgLisdvbsIc8cWtVibneTwHOZY8ZhoDukn1EKIr?=
 =?us-ascii?Q?gQMCrgMwl66EYEouvG5PG3Gwbu2PVN22iWLT+axEW9QIA7Krho2kpWMl4caG?=
 =?us-ascii?Q?MS2+YpUna58oztJfXl9WyoBIFh+b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:31.2001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1e3af3-e3f3-4215-bd5c-08dc64fee561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

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


