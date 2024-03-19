Return-Path: <linux-kernel+bounces-107241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E03C87F9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711FFB22103
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976C7E0E4;
	Tue, 19 Mar 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="43cb87ov"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB67D408;
	Tue, 19 Mar 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836962; cv=fail; b=aeJLQH0CfjJiQCXx3RPPyODbRRX/j7NG0A166uA8csA5ThqMlzzX00YMBTS4pUVpJwwM8G62mQ7ypd42D3/RWEjT4mllixa71DDn+2jHQmYFVRD2hQ1brb8lcyqI7TYCe1JBVRZqVvQkwn+Etc4LtDNxNN4ztvHF/b33c35ihz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836962; c=relaxed/simple;
	bh=JNV2VfP7lReEsKy/l/b+0YHno3wh9LfG5z2IoTRHnjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9qfwSpuTh6bqz1JXUv19xnJXlTx/ys/2adU7gKwU9H6CcJnTD84Jkld2HwlYnLNu0puMGKMVFR8+sYaohW7A4Ku9kdn82vruh1adS6Up/tYzALrpXmMpQJnMiZV5ohL/vgzrMDQOCn3Ca5zensiDoQ0Hy77OkEGO2pnCdGucG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=43cb87ov; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3aQmqdHP4vdJhvQk6otuQuuamCbZW2Ej+pjJ9b50VvQ2GoezC9p2bEj2tPyHk2G934PDFcLhnga6jSYLGVmAulp1U9uTjTjOGT0kJxVc1QPMtEIJ83j/v8xKAusuzuBEoIB4IUdmGHNnujRNRl/4xX0cOccn9Euv5HPpB1wOBhIulM5zHaI0aP1fa8+Un7+eLhD6oa8ibAjlxeMotSwF03k6rGRwarJhKE+NTBXb1dXTavHPivHB4ICm3xQu2UFWUavA7nsCEsyL+S8xoCNktPRk8JdKUSqDXDOMmv9Nw/NNaul5lXMhFwY4o3J4N9dkS4e+VdpF9qbrfEuAmHI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8kuWIe7voFKKfhnU8ec+BOfNJ4iXjJUGKRH/wzWN7g=;
 b=HLt1VMKUbevHThZbEhrf7eTypid3/3QxmUJ5ZiCn4XKnfz9dLUBdMGRIOkHTteO05t2ZfGipmcGbWYdtWIEw/8AQ77xGk0zUdRXed+NfVBzKxZ3sBiyW1g5U0j2gdBRY0xk7+DqbZSNAk7DwdO7nKyZuExL8d7kjFAtfOKOPmiwF2gq1e0+u5NaC+EaKNmHmUxMC/piFC3Ll6ZshV5CUBdesJ+zrnHwPkpsbr4H37w10pDhTd6J+wgELshBbqLqynoRWpp53mKJSSOMoMScRMdv6tOywjHNu1pKaaUMuqqJreqIRVjFPUGiIlUj1vItcWkrJp5nPR/vC6oiHxhWdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8kuWIe7voFKKfhnU8ec+BOfNJ4iXjJUGKRH/wzWN7g=;
 b=43cb87ov2hYGl3mp4zzVEKWmtY8LM9YxFXzl7yfvF8/AxM4K6D7NDDr1I3VxLFt/mEDr5m6d1cebW6ieNbI+ahv9QvmyGdOtAqrv4+YiETp3/6gkMBpxLHhkrsvA7FNlBJ/09ZBPLgLvr1icE+sb8jOHy8BLdNK2u0F8p2Vg7g0=
Received: from BYAPR06CA0005.namprd06.prod.outlook.com (2603:10b6:a03:d4::18)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:29:18 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::82) by BYAPR06CA0005.outlook.office365.com
 (2603:10b6:a03:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:13 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/8] cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Date: Tue, 19 Mar 2024 16:28:39 +0800
Message-ID: <a7fafd1a6af77329e943403705c10e3c141864e0.1710836407.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eafdc2-8662-4d45-33a9-08dc47eeab53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DMAUvVusi9wfu+bln0rhjco2EaLO2bk/crGYWqV+OKxNHziMnbzUCsJf/FgFKFe3rvAdToRaZUHldUrblwG+IcTCl+QVb7DtcTkWUwPfeRfpRJx2pyoONSqHDnndG3topBPbEtAUjZIpg+gJSN6KSWidrjZ3HSB1BUnwnuhUI3gkvWH2s7rrjyUWFB2Ao68z8seHz5ZtH2AVWppRB/n7Kn9tdq7Wc2cMCS7bH53a2l39/l4FniosbrzrUH8evUjxZsUHp3ExkGIaYJyT2DyPBQiH9WTPtdMQv5Pbf/WQlJnp8Rcgm7K+TphuGtckAO390K3U0qUIpZf1SztGd3CAnNpTkQufyOviGQcnUO5FrcWDooCQTB0JM/Wv76LqwQzZFwW8XXNT+TrCwzvJwzjYdatXXu6CVL/0Wy/kH3Iq4QPoSDMrYJuHiRwLNHTvDZqcy0UWGVUnURYuEa6ZFCLokOE3HZOYhf69fdI3erHKPxxTKacK6nKTvWigIEH475K2K1MD5uriu+OsDbD2Jsyexw/kdawUb9iipbVbEinvXWzOgFgYMB4NLibKARdtmI965p1iDlcdfR6TEOokF4eILoyfIfixquDSS8boKF2plHhWsUFCVOgP2qMnK/1zvmm+7NTFuza1YkXWc45fn4Ev8TFA6M8tMXPPY/Ziz5/Li3j5VMPreUI5iM1omz+j6JyFJXu5sbh49B1bOJC+0H0V5lJNW5LTsSzMtHz5Ao2sln2YGf22CDRQIGv5JaRUQuU4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:18.0819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eafdc2-8662-4d45-33a9-08dc47eeab53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.

There is no loss in readability in replacing their invocations by
accesses to the corresponding members of cpudata.

Do so and remove these helper functions.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
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


