Return-Path: <linux-kernel+bounces-154709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E378ADFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC89281E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE04206B;
	Tue, 23 Apr 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EkOnoyW2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102958AB8;
	Tue, 23 Apr 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861694; cv=fail; b=eWDKt6hsIrb5LmP2T/fPvdSxFqkwIP18ouaon1sNTNESNJ5HEbIhBPmngOQf5GaJ7cE+/roo4Gb7z//H7lWL6HefahqqEzoC4jE0MlOfFonjemsjdNJzM2I0DYKxMyyP3oeJ9ib7TwdiMwZqq6FEwEpRvM8saoAq0+5FMFTF+cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861694; c=relaxed/simple;
	bh=7lCM0ord5pkHnRpNvKxdV2TKbBldYbqEX2/0Y/Qmt2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU82T4mD/XcgHeen2H94MeOpVIhHKrY/Ci2MFaMb6YPenuiqSc+V+ziAmE7KyIucN/H+9m+Q5K9LY84OuCVigdKonDnwwkT8io57XoiOOz0lcybMXYz7j4e3UhxkHUQKwkYhb3jQI57BhXGKMVUXb1jKcvxbkIDT+bSzDinuvaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EkOnoyW2; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyaWamtGYdVsoyJXg2gT//0cSIFlBpgFnvnHUZe+jVOh7sncWfHCwe/CJc17nJqo2hfw7UHYJ5xDkT4hJp0LU2sZWE3M9YrCooLYgzkMMsJ0fUCo0cTjWM8Cz1ON5mt3bySpntRPx6OyE/m3ae+w3iKf1gmHtaVCBQPwdPzT3X9huE60koNLq9S/RQPrCGmGyAIj/9ZLWc4u3hIXKi6Rp8RDUaHIl2yKLO4RCEGx+e+VV5ysrBM9biC9p9JU0/N1cUukEW+fW//qu1SG3ZspiepmXS3FmnnCVhehGLVRBwz8k4vGG3/BOIV3OOsGhksTBtRhZOmoLbhL7sePl3BjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LjjGJRBlOv2xyXLRRRrBuI+cesNE1MOHMAnKjD+Iec=;
 b=mP8aYMKuhoR5g88tIR9yAcNowy5ji+Jr0qRjuimj8GD6xXwZDNQ67xzvO+M5uYlLKfONO6+5AvX5xN+1p6BLADR1Kmkh4bNfc982DCFY5Pr8BgQASpM/6uGDaxyMGF6bzpK3Y4Eo8st5KXGXjJ5D29wAfpeHjEDqZzs8jXJVfz/CzpffTYQ3UjIqhPp3y09XL78tp9dNtFKCnXYUj6J/o/OgWmK4XTU5+Q1kt/96LxDz8BMOHNMorCpcI72AsEIa9jVqkwNR1QH4ZnZN9FW20NBlmlSvGp4kT1Twbf4oSIvHtJfgZRp33q5pMtuiEWSkl9KJH4B39EPfgvT3hNv87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LjjGJRBlOv2xyXLRRRrBuI+cesNE1MOHMAnKjD+Iec=;
 b=EkOnoyW2KC6gTLl7Nv3dcbAP2LsZfDt+v+g7ZdRiKg0ikDaBn3FCBp4NFCVMWpCGJ5SrAEuCkvGZHmlI89guyz9rAdaV/fmN/m74Mo1VBa6WA4u6v6m36fJ1z1C8sQVVwy2kMg6mYO0DjrE0KMA4AgYmKKPeIfRO1BZ/6WMqbsY=
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:41:30 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::27) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:29 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:26 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/6] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Tue, 23 Apr 2024 16:40:57 +0800
Message-ID: <3548a1e1056d9d08286da8ca1c68da23c6672ee3.1713861200.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713861200.git.perry.yuan@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bd85e5-33ed-402a-1fb8-08dc63712be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yr+Z/N/kaUYWLRRumcdLxahOR+02CPw3lHHYiDbuLl14eFmuRdEWW3If1cR/?=
 =?us-ascii?Q?dI+H9ejefE4XIGxl4BfD5QLFujc139MlEH5eqgKFCX0g1P94zjZo0uUhp+My?=
 =?us-ascii?Q?3hHpnuTydkr8i1age4hvt/1n5hrTjpDAa0NZVRLf30uu5RuyJ6zhW+ZhqADs?=
 =?us-ascii?Q?ACgcym9ZiyJVx6jn3uli0KTH3mmec2R+gtvbzCKIDlzIZPXXQTlsqDwgfgzv?=
 =?us-ascii?Q?lD2BEuRDH02kfPpiJfd8SZYV+bc0cCQBqcy7GV7DhACSgwubdxpYPQaS/A/v?=
 =?us-ascii?Q?S5ZJ4H3q2xNoc0AZmnXUh2bk4KhJGEDJfqiPwhyHiwJIT4AL6UoHyUPiUD2F?=
 =?us-ascii?Q?j7s6fLu+fTXlBdVSqoUhpUr5Vzd4/pW2xnwqvNqnGslUs1GWOjbMgaK8RxJM?=
 =?us-ascii?Q?fiOB9LXLHnhNLBViQr4YaQZyGgNQUuVRcEXe+Hgm7ddVf1bsT1tOI9+kuk3p?=
 =?us-ascii?Q?Ncd66XwFBS7XrGkT+fp/jY8J16xSnBdB3S5kcjeJTx2qXPSI03LD1yHWpp8A?=
 =?us-ascii?Q?jywD/t5r/s4OMh6Oxnpi+e/pMkNhxXvC4Z+o5pd6J/BzMbNAzBBgViCTCSCL?=
 =?us-ascii?Q?8AxkXYY4tFYHVgncieRSeRs79zz7mwuY0w5hX/dVeuwYgQ09ugv3T5/brHcx?=
 =?us-ascii?Q?snGagVw46SJuyy/2IiBxIifBjNW8y3w0hFrPyoCxTNS9ePThRcKb6AuZHyea?=
 =?us-ascii?Q?zxEsCkJcgJ0gBkDPviV30+wMj3xolDvs0FHB5FEEw6qrZQsPsUY1pUyBYp93?=
 =?us-ascii?Q?2sL4w+rGoYjXv2ri+6lwkRhBPxnNNXbmauh+sB7YfdKCqEzDYsTW37ePL9iK?=
 =?us-ascii?Q?ZXYfiGHpMkPgIDBt8tEeLqpSGCgvC7pNah/M7VVwUjxZatU5SuOAuqzYaInB?=
 =?us-ascii?Q?HNzm2SCVzH6TbLY98/qFjWsFI5+WrotZZ5ZTi8wsTaaxswGe+t7U36GToVV0?=
 =?us-ascii?Q?7uH4AIo46zpz56e1KsQOJVgaG5Tfpth+9SCRBhEvZYa/Iqe134kiTXRSuDZh?=
 =?us-ascii?Q?szc4aK53/8Ieluo1ADg40W2jeNODITHvpOJzT7Dbncc5NtCggPI5+s2XI+gu?=
 =?us-ascii?Q?6VHob/LNBXBJtlwg6mNl5PgpaZ2m+o9kdiq/8sFBTo3byCDOyQX83XfandHW?=
 =?us-ascii?Q?tSa42Zv/Aoy1Cve/eQdTElzLxb3w0NWAxvOQK1hBgL5yZVfMlFL3zNIV0BY2?=
 =?us-ascii?Q?f8KCyNdsQecrjLWkaeldmxYVObJ1AQ2fN4Y4bHxpOAy/l2blClc4wkhCKn1V?=
 =?us-ascii?Q?HILtK2kKeYu45xO0gZKiu0B9mm0ylPNHl6Hckt8LDQK4bMDxHWOVu3nOr7ph?=
 =?us-ascii?Q?7207hGjA4DNIQUC7sLE4qFaAPNoP78uKdNhdwpCQxqlMM9U0p40MVsP7Ert2?=
 =?us-ascii?Q?tUyt1gkKdRx21X/RR34Mpr7ZlNXV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:29.7549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bd85e5-33ed-402a-1fb8-08dc63712be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here we need to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 49eeb38fcf20..22e5b84dbe28 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,6 +476,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -495,6 +496,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


