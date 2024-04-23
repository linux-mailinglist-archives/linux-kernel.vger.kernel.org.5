Return-Path: <linux-kernel+bounces-154644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9658ADF10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D6F1C22CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E455578A;
	Tue, 23 Apr 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHQAuteh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1654BFE;
	Tue, 23 Apr 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859137; cv=fail; b=UZEW+CqShpuys/X5aUyDOxctOxuBa3e+PML48EhDgvFEy1bxwaSfmIF8PMuO1WRos3MwJabgPP0vJuijqFRBKlhBUbb2585nCEvGrDaD7KugYBQ75N3tvq8B/bnouO4QHrBhrji28Tx2zaLdlWrD1swqW4zIAo8frqSgdYcAoRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859137; c=relaxed/simple;
	bh=LtDBJFN9mt4Ghp8tKeZFaX6vbLB5XW99XgCcPx3/nXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6UUfb3VOXqkUIncJCJhS5e1DaVTwv4Gkcdou1D45rdt75r+zNIXxKNozmyx3k/bRtlk6ILEszCgXHIot+6kCrNecqVj0It0tMF3ALCY7pSffsGEJ80IRelCKsY5nTUx2VtMTbrAa97tSQhKDEOTARq9VBYALSeav3JvSRcL0XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHQAuteh; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkpkdW7XKabDg6RGSr7R+sshsD7/0J+jbbzNtOQQfaTSI2Vl9CVK19fhPGdobLDA++6sTIN13rawUwOfVOuOVO6zE7Lsw5a3+75PQZt5P2G4hDgGenHbYYMyMQLhhauvSFzJ8lcioqgH9qF8w5gTcdxEWCha/Yjihf8XL/3FUzfEj1bWhnJddsWIH9ZTmto06zxn5vq1sk7a80mUTE/zsXCEhdUpWZzH345qyvjHT65piyQ6lNtIdP7edv4bjlU58gEZR2r1d4v5IOXhnnk95BjC2UmpeIi5pri7ODWqzs3khcmmlEPa0dMM7B6f0p+FG3pzfBzecCdwPPgaWvFtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMBDLDmclriccSsNVlKFKkaYu1FJp1/xBHkw9sBTVmM=;
 b=jLYoyRFPiOJ8SwGm2j0cqhTSaujjJ8iBOB+CaNOIDVnhmKngaDL0Qfk+k8DcUcxbOUCD3klVKXz+wy0po3qE6gpohocgrbezROeQLgdehSlRJjB+QMx+T8Trr7tvUKw0O6TOVqAdwDD0PnnFUqjSlw/y05HE7uyz2SEPxk646yfbxKU4Sr2lbePsVd/mIqjh5sTniCzIG7OzNuc2mYauK2maKytiZ+amKUCdBouQIDSpGJZbtmWY53Dq6B4igUdgCPJbdvEp2bR+tITzs1bO/IV6o4OsvyYjFEHtvTwEAsdSJz4if2G2OXVCGLZkOSV8QmSu+vTDExX+dB8pZoHSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMBDLDmclriccSsNVlKFKkaYu1FJp1/xBHkw9sBTVmM=;
 b=NHQAutehy3mlWr2uJkbTZQtjl3cGjJI1r/S3+i3eahsYHQ9RuSl7eHr84rW3nswc+1yqagamZLtBUYQ/+asBmItMyBQn78UgzUI0Ffk0Ydvr5ObSjKmnef1DpduDoeg0SdZNyFUR74QQuIVfBEGMJojQ+GOyM4Pxe7wLRfjAyuc=
Received: from CH0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:610:e7::32)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:58:52 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::9a) by CH0PR03CA0237.outlook.office365.com
 (2603:10b6:610:e7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Tue, 23 Apr 2024 07:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:58:52 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:48 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 3/8] cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
Date: Tue, 23 Apr 2024 15:58:19 +0800
Message-ID: <0a8c3ba26e0631e47189c22bc9b9596554461360.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0655a21d-57af-4c4f-a866-08dc636b37ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09tHmLwpWrNjIa/0+vxL+cemZ6TI5i4444zZtAxYOKuLsTda2xvmaBBnJ/qM?=
 =?us-ascii?Q?Bbj2/IZOGJTUmlB2Bsumx439GQ3wREuHKeUB5FdB9n/BxORDGTWtzhh+Do1l?=
 =?us-ascii?Q?ZHGz+vK5PhrRWSJFSJqHAzJeeiXjtB5jPU87/F7xv1ZFTNyY2oiPtCmxq8bd?=
 =?us-ascii?Q?r3LmDAud3hNawMSwiKiBA92i7//wYFG+F0QwyJ9nvqOBQEIwTJZee1CwJgg1?=
 =?us-ascii?Q?wf6w9vtoXKGK09XVK6FhiC4xGSYsse1L8YqOd5WLK5dHjJRzFB/l+RScBynU?=
 =?us-ascii?Q?R8eVqUiuQOAGHb6XeCIwXGHql/8RuOSap56vjVnh9X/nHoTQFIKwb1xiv/7Q?=
 =?us-ascii?Q?GIOITqXbZezruN1T1MHTarPlaB4w6MbpP393wpHywhpjwt2THZgSBW3Ysgv1?=
 =?us-ascii?Q?FxuFO0L05IzlGSpSdJqnPRjXHiWIVZCswoIfAZXPIvtvGEaggp85F10Agd80?=
 =?us-ascii?Q?fdXKMT1z0TWfWrIZQ0x75IV+nVH0YoNySvPUamLKnVCLXanPsXZEUM6Yix1W?=
 =?us-ascii?Q?9CONnW90PMJyC1nyl1z2CsBAkugN95fd9YIL1PBa8nHmVgHTjgAF1MG+CcG3?=
 =?us-ascii?Q?5pne2bfd2wR5qjCWMyGzPLAM5TXNquTl6asPqBgk7u53uVelNk9YDnfq7nj7?=
 =?us-ascii?Q?80IFRZS76k5ZbzkKiq6syD7+7IzdSR0XKf/zqEmn2DBxRJxaWVhrsLHjBIDT?=
 =?us-ascii?Q?CEut4n5MpImPMsajwix5HEdIjY8jTApWbfBGB9OZmaieAWKdfx/uMQMkfXk3?=
 =?us-ascii?Q?tveFJiR4nBkBsBxGk+Z4YU42nPEDRkCHv3Bt+x3JJJ/06Lm2MpgzlT4wGisg?=
 =?us-ascii?Q?ZZz69mMblLIXm/xAgV6Vtkd2w8hTMr0M1+0SedmtS6uTNQxvwaFLw0Oh7WGi?=
 =?us-ascii?Q?2ypJJTOOIgKJ8KQ0Rxyj7YWPy8HZ6G9tCsA/66j0Bt9dMP5SXj9hqTBbyw/+?=
 =?us-ascii?Q?13bCZTDNfKAwGTbVIoweKIU3Rf+bC3Y4bQlXkkOz4XfbOzcqTKJRaDFmf+Ym?=
 =?us-ascii?Q?XBShWgcgq6blEhlOoMKKYIRlVP/350JVi/hvTJWzqgYD+utsFeI/e3YpKi+N?=
 =?us-ascii?Q?+tLNiSEx4szdMSHzxAR/pql9C4ZWHAT3ARaL/YVqpvw3PWEp0BNY6jBQyCZ2?=
 =?us-ascii?Q?aRdvtdjh2mphS+F4PC97ds6n0IupqwKNipUlAzqJuxQuFfA3MlwwvlyIscdp?=
 =?us-ascii?Q?pA07soOE3xTSvUTBoqV6BctuBo99f5qwku3DbJbmbVj9D6BVqEUsLR9JIz+m?=
 =?us-ascii?Q?5VNtGVTDRihROohDSLjYGCWTUe2wZ6xVM52T0r1nxIcM6H5F1/jJvChxTZJb?=
 =?us-ascii?Q?rgizGeyfDhYpei5g1sa8/gLqr4DFQ+JYZHyZhoVGSp642dWXvrIrLKW8JF9p?=
 =?us-ascii?Q?utz5OUyC0T5oDjHeDBsocDImzLdc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:58:52.6773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0655a21d-57af-4c4f-a866-08dc636b37ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723

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


