Return-Path: <linux-kernel+bounces-154646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB38ADF14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38971C22DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07B56B91;
	Tue, 23 Apr 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rYxJTddu"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01C54BFE;
	Tue, 23 Apr 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859144; cv=fail; b=DFjl0saH0HxJwGGikBS4VmcKGlB9hOnM8X6dE6PV6RJPZR5JSPgVajEkfiwNEKScII0mZpzSNBTB6NjHirNtT0IvD7icUT4UEnZcdY156Ku7/J0B5x+Zd7EwE1P0xHpegdmducVVIgmqmCxXPlcU/qfptC1sTkFZWEz6JBaVPpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859144; c=relaxed/simple;
	bh=OLudeT+1gijlMUi7TFfWkAzoR9bs8ojKSeLEe4FVrk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJst2oNIlrZzwrGwL99lv3q7iIfQsEXdPg/dO+++kopgrue6IeD+eGOPM++mgHBysyR3nH12sxhmHmgxRF7LOs9FM4l6J2PQFiyudA/rxlVKyj3PjJFeETvG+1GfwdxE9rzXhoGfEoWKFCGpt/XxGoZAVH81d25rouq3A0NdtSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rYxJTddu; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3sMrbUobNQnfSVIZJA3Qw6PDYiTXG9iHoSKGu0qJakyQlqR/vyPM9+loVI3SDKoTUBe4XdRRuUiSTu5/+IjuYJXpQmZqnFUYVM5sMi9EDrwgOqNrZr9Yyo2fUcKPYl3ghuHvkep33vNxLDfgbCKOel7jnA8lIKgAAkILil73giPU49WU1PdlLv7pPb68jFDPCWugGz5PzMBF1qD5uOrh4v0zeeG+1njMd+UfCAXnQcoTyHJaWPiW+efOBhl4f4evakB1elpCbL64wF69iFq90YqC0qIfVlRroDPoUMsbNr+EYiiZ3HgwGx2mja3PBDwlqx1V2MtJEeMkKUWYpqG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+TC2KATw7Hqz4WMVGydK+FfXr1FbAtVbdW2gRVy1Mw=;
 b=Miyoply3gTq5ALkBIHllc5SJeQkPIGPzrcaU9MHBJAdjwXCTKoL/eY1ltDgm0AihJ9UQuQeWRUAO8lnwrYQadMxitdPQRDt8aq07nplqABGu0NpiEgTLX+ShCbBV7qaUoZc/50vVvIpCJS73jhNDLOs8L4hYwT9wz4yCug3AIlx89BXVnPrmfuc4Rdch/RSyWqtknEEb/1xVL+aERRlnC7/cSj3vOWW3fyTfXqewzVzMxWo2yWGG0Z+NuBR9y6piQjY5lyIciUInOp5qKenMcFeS3xYJHY2UkSKZcXrzZIz/dN/rhmAD2zmUxfXq9PkiqtlR0c5mC/lR7RDFONDIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+TC2KATw7Hqz4WMVGydK+FfXr1FbAtVbdW2gRVy1Mw=;
 b=rYxJTddu4m+CVSq/txKJFKHY3XH51H3wYy/sF+vkjYTxXh+UiZTP5ZEbIsg8Nxf/ZfYQYxG1Vp+Ud00MX9jJ8HwOnxbIyJ1p1vIkVj4h+lOC22fERzxo//B4/EA9ncPwl+r+fMgFFqZ2TJLeBTL8ekEzoEItWN4nHRlLhAkTW2w=
Received: from CH0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:610:75::23)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:59:00 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::1c) by CH0PR04CA0108.outlook.office365.com
 (2603:10b6:610:75::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 07:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:59:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:55 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 5/8] cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
Date: Tue, 23 Apr 2024 15:58:21 +0800
Message-ID: <6f016bc90debb6fb590db105c32ac9456c6ce490.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ede79f-8af4-4dc1-7295-08dc636b3c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhzQIVfrcVUNv9A/xIyNA4MAzXg1BYfCFZKGzXnZKQFqtvv017o3nmNR78hT?=
 =?us-ascii?Q?KXKgpTEWgpAFVgC7kNzsfNhlcRfcgENx8rNaQEBFL7TDpZ7WY9oM5ezfWteC?=
 =?us-ascii?Q?neAXl28alEGvEmQYnSPnuJr2zAiM6VMFeAyik45iwljr3dt/0fx4u6djaMIp?=
 =?us-ascii?Q?52ozIxlg8Bo/s69fysYEj1kNHCD9sywWDskRQ6qRHn3DpcfuXYO4zWEu1PY4?=
 =?us-ascii?Q?ZuCaRUgoZ3fDocV4aBw3q1cvwprqbDy1VlX+HkMSgppFjHDsjat+xmDCuf9A?=
 =?us-ascii?Q?zWRFzwnMc+TuNITPyydOcGOmZ3JYdDaRTmXBHm5xybzs+jhWvHopK8HP/mKD?=
 =?us-ascii?Q?n176/pxp5cNwFmYuLrAtHE/PtK1Y/oEGhPh5t74Hxpj8VBSUDAId9k0Kgmkh?=
 =?us-ascii?Q?IPBq7kY6SNFSZyzEkmUYWgn15Q8BBYA60fGTPKYdNxqKUkQVOZh6T0rF/NY8?=
 =?us-ascii?Q?jwBXVC40OAKIUjN+6z1cJWmb7P4xned3j5M9+a0VSzANFeXJjHWU60Bt960R?=
 =?us-ascii?Q?ODZ/2IUwotQpvNTlw/t5VMnnT8x21IX7P1/+thX/CdHiqf8ar0/7/MGXoqxQ?=
 =?us-ascii?Q?NOnP1l7dH6DRoH3dZA468A/KdSZS/RrYPUs64ZDkQlYYhVBqWzt9Pqtw2UKU?=
 =?us-ascii?Q?EohGTAfQ6Ki4dmYRG7OMGy1N2lOrg1kDdsixeoJ6K74bqCgI/CrVtunqzYW/?=
 =?us-ascii?Q?1UfWa+XmTscbZzIzC9CWR++IsQgm4DaadEv3CnHjJdMgyRPQtZm/YjU2P+YZ?=
 =?us-ascii?Q?+N+1+t2govcLAoWMPX3ggCXV15Mv3YYX9XN7O8vkroLM8qRs6HDkB5seoFU9?=
 =?us-ascii?Q?hbV41HnYvNkciFyECrKunwSzaIEWtM3wgfejaGY4AcG2rsWnZ+8/9rOzkXbt?=
 =?us-ascii?Q?6Nad4SiJLSO0iyUHvFJwcVESwSSeWiPGx7IIF4TFKApFz0WVDDXNQWaGfPqt?=
 =?us-ascii?Q?4qGD9OgkKyigGYPbNYmzzHVoEb43WrzTE7cCoIkiusa2jrrqFaz6h0Nb1QVW?=
 =?us-ascii?Q?XsEBDZrvEBIMnj4O6Vw8r1+sLricJA1RIMWqi7PMlK56qpdTovEZzdOW1DoE?=
 =?us-ascii?Q?Ud4xzi6T+gh8Pbjo3UQb9twYzYfqWI8fkhp0gp0r36ZgPkh8w7slehPNFxYr?=
 =?us-ascii?Q?gXH6VfkNNzBtmnCRlcbmf72Oq7XHrPi2JasXCf+QAY2ur/uMWB07L+Ya5V9I?=
 =?us-ascii?Q?Ck0uM0wXnV9WNFgX49D2e18Jgz9NpCbcbzP0a7wvdmnd1opKcOqjU2gHQ6Zv?=
 =?us-ascii?Q?4+AuvXTW01jDoKf4CEAMbPbCqoEFnIg46XZgTEitF/2gnfH8ycwychkJyt+E?=
 =?us-ascii?Q?fjDT+nrkT2+XePMXibjb1Zivb+zubWQFwx7bw+xL33ZCNuXsOYph2eWAy1gf?=
 =?us-ascii?Q?M+YveF4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:59:00.0880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ede79f-8af4-4dc1-7295-08dc636b3c25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356

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


