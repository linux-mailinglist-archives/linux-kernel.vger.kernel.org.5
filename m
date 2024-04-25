Return-Path: <linux-kernel+bounces-158172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D589A8B1C85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0493A1C212E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36EF6F076;
	Thu, 25 Apr 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J8dx/KIP"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B682C8E;
	Thu, 25 Apr 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032514; cv=fail; b=NWGdDNNKnXxGHJBMtDjdwRMs6RpCZvDtUdqBc2hxgbho1ZofAk7rauEc4xTMwkod3GrL3PKHuzaem1MjHpUeJAQJwYnieXoWxAeoNa/wcFPvO+Jwl4hj/A+eANIdK8ua1n0/Nz19c4RnuFe0PWw7BnMeT56FjBc8omtSXTZOp3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032514; c=relaxed/simple;
	bh=LtDBJFN9mt4Ghp8tKeZFaX6vbLB5XW99XgCcPx3/nXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+fVQ+UV84WL9pTZwNctLWOEyRkjfWJpEjrXBh3kI2VKO8FZHek/NbfP+z62Qe5Q6hM8s2kAvgCQg0WVbsd1GJSx3ELB7D8w89xp91qNA26z9B8Nix/08IRMsl5MLn60i7K4kIxiYoQf3V6c4yzWCztHickaG019SObokYvyvrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J8dx/KIP; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSB0JTTBLDaLd/qQKoY9OPqDXHh4Z0sopHtnAabZ0WZtlclPmNiUE/wIEnO86R2kNumnx6yjbeafGQwoRW4zxFj92L7Iab/9VoMhbPb9hJ5iM+fs2maBCrgWfIf6/8BR/C9/F50ysbfrJLbx1XJkPSvXUe+tnXeecvrlogmoyF/Kww2U+OoyAgJK8uFxY1zJ0UokX7jpj9lmsOs+9YxcZ9R/9zgOy9SVRZeFGD+Mnizy03G6DtRB3/5Yv9a9IHGtsQiKG/8E8aUAbwQbAhl8qqQVVGIyd8H7KndKBqLl+FgIoFewsVfYtbZyG2xh2pHee7Yeaa7I1xN7FTPwqTa3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMBDLDmclriccSsNVlKFKkaYu1FJp1/xBHkw9sBTVmM=;
 b=Lb5Yu5Fk1lfmB/DMMD37DuYfNhQibFEkMOmWkn3IaRKHPE9UX2Uoz7uIzal6ZGaPhR4RvyclGl7YCVAGhMw/+jJ5+PowV2RxjPfwTMo9nnVsMLSxSJqQefVXo7j9GhVRFcsmdPDSZEk45vHEED49WUl5oZN4AI+ny3CdzQMcr9+kl4tWoUOUrnV6G1f9GapdxEdCR2Q9j0kOoTJn9C8pPelqmxT9zRhGIwK4rRmTnu+A2rGljEaletC80+wlQJHMTPWDmSJPkW4wmNbOwHEBDVjOOx4m840Lk2Wuy/ECC3fNZsiMETQqezesyQ6QyPhU6zDHLhNRT9I2/htpXNdZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMBDLDmclriccSsNVlKFKkaYu1FJp1/xBHkw9sBTVmM=;
 b=J8dx/KIPNezgAUrK2P/v+R176VO9LqcZFHfyQgsthHfIZoM6UilgfXWo3WsQz7btKo2V2U2pXsTjK6KEKCy/34gUq45Oz8tZO0P6xHIV9FSzsOGqRC8gp7YEjoNsRH7bV7XdQqbY0xSUl/CjyUsa2gadcveecSBzaJcCazgp2VA=
Received: from CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 08:08:26 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::53) by CH2PR17CA0029.outlook.office365.com
 (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:26 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 3/8] cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
Date: Thu, 25 Apr 2024 16:07:53 +0800
Message-ID: <9b9771e703a0840595f6a871b6956794f3c5a4fe.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: ca88998a-9f50-4732-7bea-08dc64fee2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AqnTEmtbMxUYHUEzpFu0NJznesY04gMMGF665iSQKyuAKGaf2/G/jMIDnFAf?=
 =?us-ascii?Q?UM0GhL2k+LNR0lzTxkmqmJ6fv7o/xu4aspmQrvsaoZM8wid5hUwId+GFsnVq?=
 =?us-ascii?Q?wduWbcCpdlH7hlG3OxCIduD+jLtlOKzV/xzFz1VDNhI0mKeUHE73u79hXANz?=
 =?us-ascii?Q?uTmeiD/VAWz9YlcRWcf/MSOAT1zvCqhg4OEY2WnEN4kkPdL6pQm02kKT3+vz?=
 =?us-ascii?Q?+LLW0Euk0cT0dZ3LUyq4sTZbhYqhsKhspIwgqDuvlsaGfwsQWP8at0PeJVRP?=
 =?us-ascii?Q?dLTIY+TFwRSkgoImXUVl5ld0LWsArL6QhDF/3UAM55qZj3rEF1llppJRZtZV?=
 =?us-ascii?Q?SQQVAKSIFYfR42psCH2MAufp7TemwVx7nSp7mxZlfn/l0pHgfGI63FlaWJ0t?=
 =?us-ascii?Q?i20N3mIsZXdmI3hIMKQ4MC1/AKxjZt+LKKYaMEymrjhLaZzW4NK+mlfqj3RE?=
 =?us-ascii?Q?wkxn+8fds2CI3eWu//eDP4fMnz0pUd20092EtDQMNUjbWh0z2B7JTgXA+dsp?=
 =?us-ascii?Q?fVekETYf3uQheTq6KX0WiNqJfxI+8IcpQSbJF0ohUDnasuDNCZWz/V1q4io7?=
 =?us-ascii?Q?b/678uNUlLu0EvbSXYljwPEe7TrjhveRWW1YjJSTte8vRRI/4s6TuZRRMnb2?=
 =?us-ascii?Q?aZN8R+m4V8rDz3xtqepTD2y1rE0X++KoNnKz2xHeH52zxn2o01sh/POcsxzv?=
 =?us-ascii?Q?R3J6wNzgsTkDhrZfQ8ElcHdjKkN60EKBWjSjpS2opqCp9yv538WxJC2RC1Vp?=
 =?us-ascii?Q?FY5ywBVUtuFLj4/kcg4gLVOJsBvg++6nfp3F7+rTYC7BqH0X8M2FwrlmkuSZ?=
 =?us-ascii?Q?mYtkF+zi4bgoy8vS9VnMGp4foFL1tvZrWXYw/rp/6FVTqLaUGsqYPQhZyC3L?=
 =?us-ascii?Q?yV51ouGorFz2sg20pOzEUqlv7qd4kRaWn99TKJiTiHCsTG7wRPJqYVE1JUF0?=
 =?us-ascii?Q?rPbXJ0ff/bZXMJk0arv3LrzSb7GqR4ckosZWvAJKS0WoZFdGWchxp7U0YFz4?=
 =?us-ascii?Q?gHDT1LpaORGnEQ6v05vOJgPvOGPbYRwfohhxd41AsJMLFqtBCcjzEVTTEfv9?=
 =?us-ascii?Q?ryqLonrvPWEsx/+jUQLMPwZG7AKNBbinHJSv9ucKZHgaMOVxt/SNsE0EtHtk?=
 =?us-ascii?Q?S+HDB1gVqnU2EauBmmZ5iKZK3vxQLlPNZELg2hqdqOCgvz1L5e29Q9+osVIj?=
 =?us-ascii?Q?ovHLahO1iaGqTksSigYzOVvLcX5sDZH9Yuoc18Z+DwzPFA5xF6Qv94MX8ccY?=
 =?us-ascii?Q?kL8K9+qSZD/Q4mW4mPqAvoZm84tKwV1FAz3N9JIrGeSOG9lPjecbahsI0doJ?=
 =?us-ascii?Q?Im2byLZdzFlzZU1PwQBX4bQF5uDmWPK4TVDkwEa5ONd5sjvXyu50aotyAwEM?=
 =?us-ascii?Q?sxjDwMfCouRslns1BamjfWGGniiY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:26.6533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca88998a-9f50-4732-7bea-08dc64fee2b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

Currently the amd_get_{min, max, nominal, lowest_nonlinear}_freq()
helpers computes the values of min_freq, max_freq, nominal_freq and
lowest_nominal_freq respectively afresh from
cppc_get_perf_caps(). This is not necessary as there are fields in
cpudata to cache these values.

To simplify this, add a single helper function named
amd_pstate_init_freq() which computes all these frequencies at once, and
caches it in cpudata.

Use the cached values everywhere else in the code.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Co-developed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 126 ++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 67 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..891fad6f90e1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -606,74 +606,22 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	/* Switch to khz */
-	return cppc_perf.lowest_freq * 1000;
+	return READ_ONCE(cpudata->min_freq);
 }
 
 static int amd_get_max_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-	u32 max_perf, max_freq, nominal_freq, nominal_perf;
-	u64 boost_ratio;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	nominal_freq = cppc_perf.nominal_freq;
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-	max_perf = READ_ONCE(cpudata->highest_perf);
-
-	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
-			      nominal_perf);
-
-	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
-
-	/* Switch to khz */
-	return max_freq * 1000;
+	return READ_ONCE(cpudata->max_freq);
 }
 
 static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return READ_ONCE(cpudata->nominal_freq);
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
-	    nominal_freq, nominal_perf;
-	u64 lowest_nonlinear_ratio;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	nominal_freq = cppc_perf.nominal_freq;
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
-
-	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
-					 nominal_perf);
-
-	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
-
-	/* Switch to khz */
-	return lowest_nonlinear_freq * 1000;
+	return READ_ONCE(cpudata->lowest_nonlinear_freq);
 }
 
 static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
@@ -828,6 +776,53 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
+/**
+ * amd_pstate_init_freq: Initialize the max_freq, min_freq,
+ *                       nominal_freq and lowest_nonlinear_freq for
+ *                       the @cpudata object.
+ *
+ *  Requires: highest_perf, lowest_perf, nominal_perf and
+ *            lowest_nonlinear_perf members of @cpudata to be
+ *            initialized.
+ *
+ *  Returns 0 on success, non-zero value on failure.
+ */
+static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
+{
+	int ret;
+	u32 min_freq;
+	u32 highest_perf, max_freq;
+	u32 nominal_perf, nominal_freq;
+	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
+	u32 boost_ratio, lowest_nonlinear_ratio;
+	struct cppc_perf_caps cppc_perf;
+
+
+	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	min_freq = cppc_perf.lowest_freq * 1000;
+	nominal_freq = cppc_perf.nominal_freq;
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	boost_ratio = div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
+
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
+					 nominal_perf);
+	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
+
+	WRITE_ONCE(cpudata->min_freq, min_freq);
+	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
+	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
+	WRITE_ONCE(cpudata->max_freq, max_freq);
+
+	return 0;
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -855,6 +850,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_freq(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -896,13 +895,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata2;
 	}
 
-	/* Initial processor data capability frequencies */
-	cpudata->max_freq = max_freq;
-	cpudata->min_freq = min_freq;
 	cpudata->max_limit_freq = max_freq;
 	cpudata->min_limit_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
-	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
 
@@ -1317,6 +1311,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_freq(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -1333,12 +1331,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	/* Initial processor data capability frequencies */
-	cpudata->max_freq = max_freq;
-	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
-	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
-
 	policy->driver_data = cpudata;
 
 	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
-- 
2.34.1


