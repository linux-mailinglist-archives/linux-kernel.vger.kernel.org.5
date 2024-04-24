Return-Path: <linux-kernel+bounces-157335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA18B0FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5CD1F24391
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5116C6A5;
	Wed, 24 Apr 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPPceh0p"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B9224E8;
	Wed, 24 Apr 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976489; cv=fail; b=OcWUQX6iS5qbFhX5yvjenxlnNknN/YB1bKbsbDrk1TeGks8sm0jRpdeF6ewnwsGTA+0AFH6KyISclTRQJL1hgC5S8CENeoGRoVMcuw2qqBpsN8Xf/5KpGFDgBP4aLoxFGhMsIVDASoUV708SG7EiWpwVpxy9fdsDuT82e0Ylf5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976489; c=relaxed/simple;
	bh=lQ8zjGEeBwZJi8RASLYfthfgxZ1OIcIs1U6uxjmBG+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDQpSnDpOxxmuBEZ1StjrUH7/CgOhAJ5sgtuz/FAvmHZMsQ5dosSSS2je9I5t/HZ8dN75TpOJVtr+L6k6GIyDAidowk40vaD1/bXhQYXyBztNz3DQFQn5xpA1OhDgX+hbpCBGPzzJQb+8gLG6iYVrwid5oVROAUxARzgnEJ9WCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPPceh0p; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgtuRiQMdmojxOuWTMGoTe0EFF7UApUTGoEiseFJNlEYD0RcNHP/d/P0B9DJ/tNo9Wxvmp0zkcr5HimwtE5A5Q5bmyOM1x6I+9bwGy13JXSg1K77ap31SsJmQ4yaQWnkaxqan8H41BkWpIrx/i3dskI/tsSpFeulNAqHcdOOnBXCLlDGETWCkSqXc0KmkjDFnTRMaSEmTpANAe3p7wGFxMePocinBTqn8f+Iq1VFiqFP4z/JrHa7MAiVH8thA+Hr1Rb51rgRHWUH+enU7ANeiyJ1/U6d5Ao8oWTCJnaXCz/5KOoGpJJv3EToPaY38xxBjTZ6PMre4iYumuGbq0Ttug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ffz1ZsiwaLMPJbuaw4rUdcCvurrBpw2J+vcM8i71O8=;
 b=GsGuUUE5B0DY31GpUnM23DIT19Wnv9UZHNIB05cFXSicyQHnEnKQs6o3M1fcR+oM+Ee27QfJ/4q6+RcII9WpuCaRxoV/4IfWTrunZFySJSpO59IRAemhgBrK8biFKu1CQcHj9YpIRl7b+ooTJ2zriWgZqLNUyhosuk4Z25jPVW2QN1glqQU9o89iQ2h2vSG0CPPQpPo77zNrnDEUhBiNbk71/ZddnYmhNBKULvA0f4f7j9fdrnQjmJ6lnCW3ctLT9zNnri4l0xheZ9TZhjId0xvflHeiqN26eoFdsUdd7qGH3G6k7Pw83B39IBMEsPMZlKhLnExajT+wNnyATUWCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ffz1ZsiwaLMPJbuaw4rUdcCvurrBpw2J+vcM8i71O8=;
 b=lPPceh0pYFU/pmxVuwAruk0/EGpIMXsASkU+EC2Ub3U/pYP4keeZ525GHDWWtv1Vt00HHFrStHMOqpjvfcQtBkQfw/QMqh8MP+kzw2qrYTJKBq41Olyk/C1eXld8FmM1A0tFumWC52wI++fEo9ABTem+YsiVLo165EQMMm7K7f0=
Received: from CH2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:610:51::13)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 16:34:43 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::d6) by CH2PR15CA0003.outlook.office365.com
 (2603:10b6:610:51::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 16:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 16:34:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 11:34:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 11:34:42 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 11:34:41 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers: remoteproc: xlnx: fix uninitialized tcm mode
Date: Wed, 24 Apr 2024 09:33:45 -0700
Message-ID: <20240424163344.1344304-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d70ab4-4070-4174-8e76-08dc647c720a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6mrPhgJgg9co8oAWGCXt4nQG7TPLRc1ScGX/uEr00FNitjlDEgoAtEeA1B9?=
 =?us-ascii?Q?hLQGnmpoWX4EySpMg+P6+/PeLU6JWgNUKDn0tDQ63AhsxzXo2n6sIeqcjEfm?=
 =?us-ascii?Q?mz56Ouc1LTaE5+tlnl2Qd8POIGQKf+k5X/2coi7KxoveHNUwbXvm6CkvJLsb?=
 =?us-ascii?Q?ivrROsWswF34hHmkbZHRsoBTZNE/LGw7UZe2KB5Vjw1C/GbsH4RJusLzOcSL?=
 =?us-ascii?Q?P2zELueBNivwTXCJNQoIwabCcULI6f7/XxCSkVU9j1a697icOyrb0ZD0Q1Hy?=
 =?us-ascii?Q?yzk5+56doNCeO3GEgxu2qOofNTsAZT7QAD46DOlvAE9zhnCmhd/aFJ3WtVZJ?=
 =?us-ascii?Q?m+Wauo2dOfZX3tEs04xJ99DD5JZl460r5dj4zdOZkK9P0w8siLZkpq/ZO6a+?=
 =?us-ascii?Q?C+YnguoYaCpLJtP4hFwDNTW+uek+2s/EK5B3ffmxKNK72WEnmSMhVvZuV1Gv?=
 =?us-ascii?Q?smdcY4t+t8S/GjD5LUjbBrEYlLzjX6rwpylA73a1d6sa4CRVl64afVSQpwpB?=
 =?us-ascii?Q?hF58ukivq0qBklC2k68E9pM99sxFGnTEorg/EgHA60t4Hi5RYYVNc8B2Ptqi?=
 =?us-ascii?Q?Dgvy/ZHKPTY4MMLBkNqV4/c4GDEOmiiShF5vYTEwH3EGKRkK+YrUU+WAZhgJ?=
 =?us-ascii?Q?N2wO95QsEBtMgDarZFS6xXhdh68VHKnH50z9UwVkNoolgceEXYOHDvgv7/dV?=
 =?us-ascii?Q?eIOb5jlD86JXzwZFpOrmdNteh1x5lj5GKqj+N9JIvabUa+FSGnI4vhN6TIBn?=
 =?us-ascii?Q?GWJ/maxRNc1/pHsSpZa93GjfXHBzeTiCjwPpLoKJ9BxSfrlKbOPQFGpV2lbS?=
 =?us-ascii?Q?iUwD3eP1z+yfViAABiDjuAXgeUv4b6yjws6XgG6z9o5RUbYFslHVmP97cvFE?=
 =?us-ascii?Q?DMrqLc4JHHgmjmSUaiWjJW2M3cD8yHCKsMv58headXi6A3u1TdXNAJ53bSC8?=
 =?us-ascii?Q?72FgmhevtTc76GuTKW1XFPYI2y5bWsJ2hqlwhYPsVx1Tuj+wLDbrnOQE+ZQP?=
 =?us-ascii?Q?iEFAjzXj3LNqrM3sUD7f0YjdL7dnGjcn4SDHuiqWl2L2uoVIRe2HD38RKyyI?=
 =?us-ascii?Q?BS6mB0rJnvfWmN9kdoncv0anWoKUOux9ikv1cN85niGB3R+zP4OSf2Kn4cdf?=
 =?us-ascii?Q?l63NU+5/pKrs20mka28gqo2fJfafGIvG5/rq8fd6AWSV3qB5d9G7usEiSiui?=
 =?us-ascii?Q?Bv+mM+RRhzwB56dPuwm1P/yLY+OQX6nrb8FzuXb87YU9qaDhb/pYfqgfv+CX?=
 =?us-ascii?Q?L3m3s/BwRM7gPS6r+A1dvDTyU05W7Tu0rLNSJnf622otUDoNufdoF5ZiuHF2?=
 =?us-ascii?Q?wyNv/R3H31v9GMZNQNrY/0apLBz0dEo+GE18bNMIf/gAZdVRQUcq6pZh0UT2?=
 =?us-ascii?Q?R/6wovgloLLMDXkABqFAJLJuNKRZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 16:34:43.1159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d70ab4-4070-4174-8e76-08dc647c720a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

Add "else" case for default tcm mode to silent following static check:

zynqmp_r5_cluster_init()
 error: uninitialized symbol 'tcm_mode'.

Fixes: a6b974b40f94 ("drivers: remoteproc: xlnx: Add Versal and Versal-NET support")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index d98940d7ef8f..84243d1dff9f 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -1006,6 +1006,8 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 			tcm_mode = PM_RPU_TCM_COMB;
 		else
 			tcm_mode = PM_RPU_TCM_SPLIT;
+	} else {
+		tcm_mode = PM_RPU_TCM_COMB;
 	}
 
 	/*

base-commit: a49a6c600193e32123e8885515051b34a5d711ff
-- 
2.25.1


