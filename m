Return-Path: <linux-kernel+bounces-158174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB088B1C89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB752851B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1A284DF3;
	Thu, 25 Apr 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e8NpAdZr"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A484A3E;
	Thu, 25 Apr 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032518; cv=fail; b=T7lI5myXlX40bfGx++t1wexGyFoS4dN1FNx7LH7tk4F4noBwQ3dgzFxafncrCo3I/D5DSVsIIhtVCFIYC9aZs8ze8WiMRnAIgxCvK3BGUXNDiu4nrpX9/P1vSxGkoCaxourHtNAM4Ks0sw4axYcU8WhGcQI/GHMDEhY+gc4qo3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032518; c=relaxed/simple;
	bh=OLudeT+1gijlMUi7TFfWkAzoR9bs8ojKSeLEe4FVrk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bROPomh+EUUe119/mBSpjn7wBvWsCO+R0sP59Q6400eQmlK7ZFO4z0OPDsvZNL2KSOYFF4u4SvzW600hwgCX8vLKRU2SV+JU6ovNM+tip8v2hC9a+LvRXODoZ+0tlel5ZIcLcnVCMu9WhZqm1Zr8sBC7PyWbnaqp7FK3B9JrzCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e8NpAdZr; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgfvIx/HDdokr6AT9RKsdOQjDvQDSf3W/nwaPcIhUNF3n6zNzTgNxzKPL6k+BgbUF4AW9opF+s2jeaNj3KJbeqi4wy63w1b6v7ZfcVw2Zpio0UWVk2yrpwsM1ZkKGbuVk8CIA+3jrXVA0ACGKmUy0gAlyqz8PyHbUZb2p6HMg0SvE2PhIBf8zPqk99y1pEDAFDqbk34W8BvxgeT57vCznTA5DvDXBATyedbjqaZa7+j/4GpWb5FsRSWRaBJp6gz+SB0mNfUKAI0Bftp9OyxQHOu2Sg4bpEG+vexyxEevY+/lkPubSO5201qT6oLUz6CrtFI2JkCtRCPJE+PGBvLr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+TC2KATw7Hqz4WMVGydK+FfXr1FbAtVbdW2gRVy1Mw=;
 b=VVXafo2+T5inzMQSoi/px7ax23RyBNYi0Im8zWfuH03j8Cf7BbZJCuxFh+tNnM70iopfB2GyL2NaWAKsAIfWIMgWfOqVy4slu8hHTIblcMtbYcO0wzRg4dd7pZocM5cwRQGjvtn4umbQXO8THef4Ik23gHyGHdSACzhw1MxKsgaeWyTsDWhmUjZ6Il6jWFOUPlxps+MoYVnWGm5zWsbK3jfym9Qm7K/J+i681JmNQJo9gabsa8FZ5d4w4aU/ermtVeX/kIez+HY/9QcQoD9yTd9GGqXnV5ERL9ou9/yb7IBfVXcovZXENCiAZBKfWhnCaT8LRd7E+2g+/291aNLdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+TC2KATw7Hqz4WMVGydK+FfXr1FbAtVbdW2gRVy1Mw=;
 b=e8NpAdZrfgvB5q1WL//F+quyHLJmSyzd1QHjNE12d4FErnEEchPTORoxT3QF2aBWTwPFzKLMiPklO3j67G1XAs3OmtLuf+2XtEB56c30nNEGrjWt2ZtJI4uu7UF8AgC2Ef+dczRpcDiXO50r/JDHB1mp8Df5LmYBBhrWQTI5QT8=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:08:33 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::a9) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:33 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:28 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 5/8] cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
Date: Thu, 25 Apr 2024 16:07:55 +0800
Message-ID: <fdf908820982dc09660f499ee7263150f9d77560.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c93b5d-4fb4-4c93-74ae-08dc64fee67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPUiBRxo82u2FOOR5ndpDKzGqiTXM5gBnCmSALBHx/4HtwXhpZd+kQuQPoP4?=
 =?us-ascii?Q?33f1rEOrJLn816h8vDa9/+XEt23dCO0hcmiKWIlKSxdDLh+sqRcnBINNLyDg?=
 =?us-ascii?Q?1W+oE/DEcXL+SFWN0WBYymITy4pVtGzlzjWq/lwIc3j4zs6tSRYWlccVmxST?=
 =?us-ascii?Q?R/1VCZ6vXEGgHP+05lAO1KOtGA9k7fzBYp72gareW/+TvoQU1g29jc9WzgyJ?=
 =?us-ascii?Q?UkNTxnQDTkjt0xKqgtg7FgIQAYhKcVMZM0ZzWDeebbdzE5Y+V9h/pJf0FT7M?=
 =?us-ascii?Q?22zO8fWp45EiP3eFrzXyfYA8sTQFkxyBKNezngybWHjyamW3dhYb7s2+ilUH?=
 =?us-ascii?Q?dpwkzYDS3EfalACfrC4rz6dExhK0LgtGJnqddcBvBj5q+Mgp3/PTm2PSQ29V?=
 =?us-ascii?Q?97fvd6ytTSX6Mq5NsTM/aPTTSOCCtLZtz7YFDILhVAGvKIea8w71L+KAOlS8?=
 =?us-ascii?Q?duni5iJELzPUzFpV36AdhvrkTevxK+i8uVWaVHOKFdtS467DGJff11+aJtaF?=
 =?us-ascii?Q?wRyNSbZK854x4s8ICH8J127bkq47L3I6FncNpUc4zILIXwR0mrwTM93CocDD?=
 =?us-ascii?Q?2fcm5gFT2kLJ4tojmw9NW/NC1HXr1kvAgCXPjVH1DEVA3xW+/dueNnYM2wu2?=
 =?us-ascii?Q?/SVIs6T7azwgkk8/SXJg5ZpmDT0xPuD5E2gJYEQvpBQCW+myO0fUsR5Q3SR7?=
 =?us-ascii?Q?RRLCW1bg6v0zyayua37q9pD7qrBAX1jEguNEcX0HFXt54cIGp+IiagWqDivC?=
 =?us-ascii?Q?AgLQqU+Q2HltPRuXOCdWnPyvCv1scF9iG0jZn42MTQiBLfLxIx3IvaPLxgn1?=
 =?us-ascii?Q?jjWRgg8/raxVK/OiFOOnlhz1lF7h3vlKK7LQgbxf/QYOSMAOyRoItsNdtdrs?=
 =?us-ascii?Q?GjWjoQQDnGzJD1JpAWVk6ommqtVvuEDtgYqauS86/eeLTRh/X/slkaiJwCds?=
 =?us-ascii?Q?2/kyu/BETqdgjOYLrvxpyjt+7cU7h2FNc21sRKrcs4akKAXkvGMpuAEe815L?=
 =?us-ascii?Q?V6PmLCLFzlu6AH/v9JjVUOG958lkJMGZmPJS81nziv2y+UleDTUQiP0TofYO?=
 =?us-ascii?Q?PPOXGDC5oEngPi1AvR5jkXShvNSZrxPNF6kHky1l+8QQ70PrCU24m8Xe0F2h?=
 =?us-ascii?Q?oHB+1bewVhb1Xeq95kEbz+fB5eZeQHsWJquBnAiLk2vyi1/FbBcoVzPEZegc?=
 =?us-ascii?Q?cNvzU7mlhYQlXNdvj0Y00GaGUG1n2IpRjTc6mVd1Pa4afcpLqSJRLi3UThIt?=
 =?us-ascii?Q?RUoQzPDtklTLcgWSSZIsnOb/tzsXcDBO5Abe2PvpkPGBlQL83u1h9oELQJEf?=
 =?us-ascii?Q?Jxj58/lM4WYHaDwvmchUwv5/NhpkK1+GCtlUSY1oBa5Bm7zO6quKb16eQvM+?=
 =?us-ascii?Q?R0IDNW8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:33.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c93b5d-4fb4-4c93-74ae-08dc64fee67d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109

The amd-pstate driver cannot work when the min_freq, nominal_freq or
the max_freq is zero. When this happens it is prudent to error out
early on rather than waiting failing at the time of the governor
initialization.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3836d62b54ef..960fead0b83e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -839,9 +839,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq <= 0 || max_freq <= 0 ||
+	    nominal_freq <= 0 || min_freq > max_freq) {
+		dev_err(dev,
+			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1299,9 +1301,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq <= 0 || max_freq <= 0 ||
+	    nominal_freq <= 0 || min_freq > max_freq) {
+		dev_err(dev,
+			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
-- 
2.34.1


