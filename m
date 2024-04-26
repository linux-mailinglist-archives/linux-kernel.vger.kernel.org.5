Return-Path: <linux-kernel+bounces-159577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109F8B3088
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A2D1C23288
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABDD13B79F;
	Fri, 26 Apr 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EL//ooao"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CC13A403;
	Fri, 26 Apr 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113331; cv=fail; b=V83R1AmU9JnB5km9KUqAQBo23dFzM5t9JnsLZDOOyl0PJe7+BijNsFVDG4+H6A2vQMOeskmVoA5AOs1uPYT8fKnbad+7vyU1urHL0ZH7CwtalXAnVyy6QbqR1f2KGiUPMHadl4askgPwMB1X34eDO9DM+6scebS5nADYuCkmSXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113331; c=relaxed/simple;
	bh=xEj6liAj6IMhbWAhkHuDsMO4hCwxjqNXMN9NlrsX8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r15pqpOyccz3UrY1sI8pMk5VJ5MutNAcMyTV5kB5lSeUQYWjZVmxgcgRpdhteW7saWt+F5YTU1lTyOquJ2XS1KeeBTNLNsewiAfgqTDEPFd16Mh7/OnJ1GKYGnXVPREaPCzrx1hDuTemPTu8QBsxieGfxyjfoJ4vKUPvpMMthfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EL//ooao; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyEHY+uiZElS7icg18mgQbweho+RbdFd5QQaakVBFZmavIGeUtf2e1QToWBuJ2INaC//9p3k6XCUPNQ2/tfA9NPLh2BZCWll68rM22regNAB9ep2xgtyAjX4Z/YVI9J45mxMfXLV2N8wuE5vu/4RR0ZlMPLAIYYndxZ+mc58b88Z/mLq9j9DJ2x4CCMnhpEjK9w3653FG4QuqrPVoqEOkfmoAmOn+x8ChLDobEKYvDkCeOm0zrI4OZTiOt6yha5pNTx9ls5fVtGWDSgqPMO+oKw7mDPp9jhJ3eeXcRmAZbAP+OU4g1e7f3tYpKqyeQt28hq+4k0hvwNrG0y9O0IUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=Gc5u2Oore8GqKUjCKWsCbk/sy7gKOA1KPFwxnAQEO1ZafNju+JL2dryGztS1Brz91FAK/VOsOX5oI2IxQtshp1EEN59M94seEMtakCRb4gAfVaI37Lsw8OXvX8P7Y5NyFe4SvK6lx0+9TeJ/suKuZwoB/i6pVrCsb/103VznUFgjOfaagmTW4Q43h63YGbr8gDkVPqVx5wEcMFQTuQOUBo8wvtjUdG1J3NUPVp/CIZAE9RVNRuhf8ZjSbCkuYFp18x4vd6BWC1KszkJbdZLj7vS/eyGXa1ahca2U0FQkju2ayD9FLXKtAZg1MUfVoYhJ+PEfvyV6/Z456uRrRLH7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=EL//ooaoZ3KTdicpnwgmqwLhwSqbYVaciiDXVdH2IhNejJfoYns7V9S7FeNubA9cynlCvl2Ky+sfaPsNz7tzK2Fd/mNP7IIg9C6YcN+wnrmc+HSnot+O9UbHoq2DKF+bMh0aecBbsf2f1kMYAkfeciK6IdHdsVHOyHnbqYO97pU=
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 06:35:25 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::fb) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:25 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:22 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 5/6] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Fri, 26 Apr 2024 14:34:48 +0800
Message-ID: <c23d29532a09f9bfd8134eb34f2931b82399b527.1714112854.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714112854.git.perry.yuan@amd.com>
References: <cover.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: f0200f6c-1cf2-42ff-27db-08dc65bb0e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wxF86MDoTt5rtzQXs4xmHnmEQRlew3zbQLSxO8FjNsXVi/7bV/9CczfbRqBM?=
 =?us-ascii?Q?dTYEZSDZ0hHm5ZLO05KK13+L6kIBj3CABcd1I7JzAMCsAHazFCx/gLu/NMHW?=
 =?us-ascii?Q?ldag82AxR59b2WaYpENDtW58MF3XkKS7iYkurZrlxQeEmiCSnf6HgG207WB2?=
 =?us-ascii?Q?/fRyNGqLjx6eyC1pFnBx0qCDu8mumhSXXCc7Gvsb17BIR15b85tyLQFhhGzF?=
 =?us-ascii?Q?+8i7eAmOO0omNRQvn66aoNnKkNtpYIslgDt3dCGWimssEfIqMOhmkIxZ023J?=
 =?us-ascii?Q?RODOSvSaRf1bgrzfO6tMLO1FM5qoSpshZoH+mS/pIjEsP3K40yn5YyDh3DWB?=
 =?us-ascii?Q?lBjjQKVp+V7pIB6hEaTdko6aAFQN48rh9cLVQrRihhPzsy+ZlY01HK2FvZiC?=
 =?us-ascii?Q?dZrKdexP3UEFCdMF82oJmXSsQpp+38z0zstE3VuK6KWMc/a35cRZ5urP04LT?=
 =?us-ascii?Q?Oje5vMct6bTmpE50AACBvSdxQhk7or72Ht8ad+rofL19roOPtYMaHbmG3nNC?=
 =?us-ascii?Q?eVXrJQ1tQ/IybLe3vq/MB1nTjrrTzoVGtxPaq+6Ckt+BJMZAVTDZz7hVirgC?=
 =?us-ascii?Q?yky4yNpKXsvVzdTebJzjKI349nw7QheCxd6Jmw2f4fem9nKp04vdRYvF9Hw8?=
 =?us-ascii?Q?AMRolD6sz624YwPdVduKFeYB9bB5jr11DEblUaulYCb2NgFzpraLZi3G/kEh?=
 =?us-ascii?Q?Z2bIcoFpzJ0dtkkY4uUUh4svzhbRVrFsDSF/BEZYmuXmA2utYfA5516X37cG?=
 =?us-ascii?Q?kd8Vn/rA+C35kzHWKzValH8UzdZ4yN5UheI26veSDosFFCgcxIs8w6nHTXWb?=
 =?us-ascii?Q?Ypn/Q+pgogc78OdIAfGW5YcBSDhEF2axSUFdU3V5jGKJe/NtQc+vvilcfutd?=
 =?us-ascii?Q?5ROTPeOuHulmnNPDDnLh7oOcviFjmN6Zs9qnbOm6P5ZXUhi/w7dv7nJIxhZp?=
 =?us-ascii?Q?fYNixMjfvlhF1Wbc659bJ1oSSWoB2bm9yL0W2dgQZkeXvCB02gBFGDzYc1EP?=
 =?us-ascii?Q?j9XgrjFI8WodmHLgpRuXRfTPaQVT2rsAjH9vPKn8B4jgMWM4gyEdjc2qce8T?=
 =?us-ascii?Q?uvjBFvx0kP6dMot3Wq3VYKOQPonmbkGjgjutIXBsJRn1XEZrJKI6xcvMK3i7?=
 =?us-ascii?Q?41MT/3BrY9ZOsRaxjpEK5cLp42CDdF9P64Vci0FL0lyOMPL5pjjoUp3gnidf?=
 =?us-ascii?Q?Sf2xTZ4UvEvSChygfzdPZaBb/tfEMYj7+a6InsEuSPVSIM/Z/4/Clram9g16?=
 =?us-ascii?Q?IvO30Je8Jovcf2pLRZwI9DYuYJq3NfAxZvWvWPWA1Tz6FSEN6gRnUQ4b4aGf?=
 =?us-ascii?Q?eTCmNLmRd2FcWshFYNzT/XuzT8BBNcLoJOb2sXT4iuiTrf6kNoZykNyBFD+i?=
 =?us-ascii?Q?zuxDJqVgmVyjBQ5dFTy5MsFyZF8e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:25.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0200f6c-1cf2-42ff-27db-08dc65bb0e8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..82fbd01da658 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,17 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this new attribute file which
+        allow user to change all cores frequency boosting state. It supports both
+        ``active``, ``passive`` and ``guided`` mode control with below value write to it.
+
+        "0" Disable Core Performance Boosting
+        "1" Enable  Core Performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


