Return-Path: <linux-kernel+bounces-116434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE388A014
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C2AB4152D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B67177A93;
	Mon, 25 Mar 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="46kB2EqH"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286E3913FF;
	Mon, 25 Mar 2024 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335866; cv=fail; b=OHuh7o7zmJC43wFNzLGrTTp0qodOVVc+xOe2XmV0VkvocK+M9VGeZ/h4vHQtmoJ/EHwj9KJkU2gZrZNcH3mvea/t5KmDCb/5qGUJ5vhYejuiaWniqyskLVIhM0eYpaQIVWwjTuXGSa1pMXSYnyqVP4lHc25maYFAMaQ759dCenI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335866; c=relaxed/simple;
	bh=NSbpme1T8MOtsY1RLqWQ67dSJJSvZY8kuwkXKOGThws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCX//7juerkl3Ia5hWJnogikc8maOP+aMf9l+t3M1w55shBBtf56Huv8VsHHi5asEXF705W5JV20aPJvJXa+Jx+/IZhrXE/D9jE2kQslL83zlbgv4P5pgN3IF5JICv9bgLEAM5WluEYulKq6rMs0yrv/FtiCgUbSSRokf4xPk3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=46kB2EqH; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+C5/Ba7IJmcxfYnzuEVqlcHImSx4fkG/SxLGSiDH0CbQ1/HXHE6q0+774e1OeYhBkLnEEc2+BOt8x5kcSO9YXlWfM/5021hTuQMmdAeHWfnPFaTIxK6DvlZUx9MQULYoJiJHo6PBRxa5KoACn9AoG/kFwfBDwGE2w7L4Lh6pyrAZohX+P2eWKlO4JQSLcuZMUh6hfBUHn/YjWW78fITtX8IFJHLW3D6RSvWkfXUkJ+8/CZ+3BlaXj/V7wH6jeJDhnuwA2hh2WXLNvy8GSevOVuPCSyFTeiC42Dg9pjqRO7YmFS8S/rIFPe7BNc2+DhWjLBePvfsA6ab9dTdR7f1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWZwfqXIFikTKndf3BuvlpfOFL6BIiF6IyUmyHI09G4=;
 b=VijMrsDccHg1E1+rg7pmLZpE+kWlGTT+EpbQ/PuAu14W6oNAEcCjtBojDQdNPTcbHvl3vjq9ZueMNg6T/D/mlxN6EfgjMTc79vMwB1+mQdbcezoBTTadrN8zlqXP8OrzdueQFRtLjX/PcOk4xsigMx4Oq0VVZRqdZQEVguCrnk1G1mU2ZU6CgqSaudf8BWqGovHnnwWTbh3SkkLBhJlU0jbgEOQ40VYUkfKAPEKv/2Y/fA8gvKsbQ9CDtqe9DvF6UjTb2kxU8PfOzvS8wbnL4hN7gg3MkKvjy2SKueyBIQ2RarirSwpnR4oRaljSyS0U9sv/1HKHaQUdfJuL2hCqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWZwfqXIFikTKndf3BuvlpfOFL6BIiF6IyUmyHI09G4=;
 b=46kB2EqHDVMyLSanqut60JaxW+QMWYkw1tlmn3QURV/dYcGbXPY2VEAeNB4z8XNTVGiFoMr7xWVGSx3wVlrBVIvhKvt8l8ODA1qnkNg3LHUpM/kmaowUfgQT0yjOyQiEhtFVfguOTd7YHs6QYiJ3dEgSI7HNeEaKm0vZBQxN0KU=
Received: from CY8PR12CA0064.namprd12.prod.outlook.com (2603:10b6:930:4c::10)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:18 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::27) by CY8PR12CA0064.outlook.office365.com
 (2603:10b6:930:4c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:14 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 4/8] cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Date: Mon, 25 Mar 2024 11:03:24 +0800
Message-ID: <c80c43cb72f7f9264edc21636d457c32d21de214.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9d63ad-8a40-4a35-8350-08dc4c784316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yWQK7DABz5fTEcJHUr+QteLiESvLT4sL94L04Joy9uiFBsAw2Ytt+xymNnbXbDuceZp/JJan7YlWcncpxS1jPXc90YJ+HH8zl/QHUGuaHwcNfUftYgUX5WTi0ZC3r1MIaXQh3dHWmJWdSNsHoYOzP2GRbQHz4FwHFhpiWJ5HPaG4Tq/4BcrgF4ZLzMhRk8x+FL8RG/MY3C6KAPwAcNPLlXvwwIl8WHtywCFkrpyyh/j2ceOWOQsxM1Zvrx3ArHa+vp1O00QvV1iTolD9wD9l7soFZ6pq5k8r/b9CPz86vilhEsJQeeYEdbgcmZksb7lQ0tn5tam7809dNXAc+znUz2mreo9quXmWs3NvV/IR45KKe5LHzVKmjFyNQs2HV1UYNYCTaYZhzNDGYlFyS2iO1QBagZlcLiR5HN9PGQm2sZlEZXLXiEMhKgp+cOLiTcRELHglZVi2IWeBWY6vArapnem1UHErB8pFP/yqS3bcY/UmyLbwtzUfHM5hJZkfBkc4iWXjopPzYkTVm2Z4KrqVDiu8+YPd1R7PX6lsAvj3gkng0qPWOi6aaIihBJ0JpEi6RpcGp8DqF8p0Jdx2jTHUiSDB76jbbHx6UBidz0ZC40LIkxWVRKs3EjRR6exp6ErOw3ZRyYYsNjQdaiSjsrrX9MIZepcVsjJ/fpzWVwjdPPZHby7fY6WnD96HVnGljW0tP0p/PFByLSqQbPikbmSnMj70qgflIGRxtdH9e1zXL4ASZNghQyZcY1xUjTdLJm3x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:18.4165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9d63ad-8a40-4a35-8350-08dc4c784316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.

There is no loss in readability in replacing their invocations by
accesses to the corresponding members of cpudata.

Do so and remove these helper functions.

Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
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


