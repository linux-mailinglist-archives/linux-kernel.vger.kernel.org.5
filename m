Return-Path: <linux-kernel+bounces-154706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37E8ADFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171FC1C2262D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE725647B;
	Tue, 23 Apr 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TbzqpFOu"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46055C3E;
	Tue, 23 Apr 2024 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861685; cv=fail; b=BMq7Ns2w0ZFV5wMLDEP+Nx96wp9WtBQxmTtBtXiFN9qybbLOBS45pFFC/ZiCh5NdztEGYBzEemH4bMvqioD+9+jWIrDtm2r6s0CZs2Sf/lL7+/CZzIcE98JfXNXnS0w222HlaIYEIW8hZry54wPI0Gk1t7YMiwB8y2abgKVHIEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861685; c=relaxed/simple;
	bh=Qu5Afz9UWo2+jh55rJU4yf3lDIbdSIZHUcyJ0G4SbeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJ7uYItdArqhGcMXCEI9AvstMO6j6UhUCm0HbckC9QYSEwQzdR7AcsfFza0kpRUVJLTy0vuQaGQXB/Fjc5um2ivyECQQOOBZcvbKH72QL2BeyC/l/gsOSrexzkBWaqFOaATGzYUxvAe7gyVXy4SwIeKxXUdkzeRZy1jZR8bOgrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TbzqpFOu; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr2rVZVMd+ItU4WBuYUH/wiAqs7b7so8DGq+SEUWfRltktBQeGeSBEZwvivD7obKYIX7Jt6uhB2RBYt67cM3kifdG1kaRNoZlYHZR1rpj/RkQ1GRcrcBcnyNAluCBDLvBDjEpCNZGcili6bIQdwX9CaM6u3uver7kazgNSuJWYFM9z6ulNmUiCDV57e/4uvmhPwbt93P0Ie6yUxfRHGtLEob8j0jLhNs8NQh/50VK4nTwCSfRDt2d/avZVQyadreww9gEQWbfS+APKfzp+Kgt8qdgfGU/d5ZEM/uHaAjOqMJqC1pKXODLINGVrrEnbDoQ5tKh9sA77ovir1arFE6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv8mEHJQpoR48nIE/dSM0qcHAwVi2GF1wMpBp1R893s=;
 b=Jz+3EpbaOtTHz89v1M8rtUcUAxTayRL8XTn5vfWa1BukMtcm8aGd4P+Qwa5VTehIhjn3v+4nSnX8jFUSNpYfwRL7tzeqV63qb/YVBnWawA+l77Hz+D3oNek7JjwEsMgO75I9gnGHQ7Q5ocxgRK4yslshnjTdEqoOfwdVxy+wQGnCNSzDgk8E4buVa8qa35ScumzDMcFbxg3tRBqNP1igfMMJs5tvP7qqpxi3YeJJBzRqGzUO19TNQueJRxMQfj5DwyNdH+nydvbHahGzAerJyS2Chxvk0q02zjxon75gBhWEg4MwRAC6P+NxauHzyGXhpEtmkzuw7rnD/31EToqypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv8mEHJQpoR48nIE/dSM0qcHAwVi2GF1wMpBp1R893s=;
 b=TbzqpFOuO00CXEyw6RDILX3f3ptoguTB04SdIKPa3wz3frzONw1Ef8zQacRyyJ+03rWNSMmcGIUWw9y+drIIaooelSkpibsXkGTju4v+0ghqpnec8eqTWAzNFZH2XnkzITBbnlisvqu8a9V4Az4PtTQSp66EXyzzvS11t4qrHmE=
Received: from DS7PR05CA0060.namprd05.prod.outlook.com (2603:10b6:8:2f::13) by
 MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:41:21 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::7d) by DS7PR05CA0060.outlook.office365.com
 (2603:10b6:8:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:15 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Tue, 23 Apr 2024 16:40:54 +0800
Message-ID: <858950a317b7093df72142d227c686290ba9eda5.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a33af9b-a197-4a9c-2bab-08dc63712568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEZ5SqMQj74BDsFNHB3Zu5EdiwWHkP4DFyyJFrzm1HXbIRBulN1JlmFTo6Bm?=
 =?us-ascii?Q?zeZ76yPNQbdaN40g6h0RGcqKOgcEsRHJ3FXqauJ397wt1h38q45H+R66+Boy?=
 =?us-ascii?Q?TfZJeSBBN9FC98vxecCP6NSvHynbror9efHmbs8sSYC93Vb+hN7Re8zVCgae?=
 =?us-ascii?Q?wiEsYeKiw+b5lqN/G5YSEcybc/D+XJIvsjZE+yT9xARxV8CePGlbRII/06eC?=
 =?us-ascii?Q?1kcLgqxcSC1/i7Z3arayEBcYCys3pHdgMo/engSIOWO9pfoCY2IDDewJ9xUr?=
 =?us-ascii?Q?1zyJpF0ziRlP0855U/JH7dYG+2yGo+4preyMAs43dGkrtp1edAxXJGIdM9T9?=
 =?us-ascii?Q?CppR7IC++puENLPLc04TtI8fASWPATt721T2lY+kJQ1g6XEh0Vu6Q3A4++/4?=
 =?us-ascii?Q?emmUv/6pULPvpHI9GDlxdEBbp7Mr+h57ZDIpcoS3yyyTTZyWIB2utCoor5ZR?=
 =?us-ascii?Q?fJYxy7TmzV1m6wjkjKoEZVPtMn4pUPZomoEfxEva9Aa62l5mHgkIjYZVNQRJ?=
 =?us-ascii?Q?Lp/ZGQDGta0DwamCgqEEAfTl0Wljjpdy5N15dS0KQwSa/kzg2BqDXAWf+8pu?=
 =?us-ascii?Q?/l13Dv+jn1+fcDNP+TZssRp1Y3RbX/8Wk7ljv+0ErEWkbr/+Hh6l4Fc8Z/dj?=
 =?us-ascii?Q?oCuHAWwmE6nJ9nTgUNDampfzm+4z8XyVH9jGcX1HVpdtJ0q2/rsYFgxql+on?=
 =?us-ascii?Q?TlMxvAxNBSlvCN5K949Yxb0jVlODy1S4coLp9X1zGTRIEgLgIwyMhDCjUYSm?=
 =?us-ascii?Q?IQkXgPS87X+A6JX6NLz011HZeftyjpjoJ1IvYaCxQmdFSqTCKL1u4botIOUf?=
 =?us-ascii?Q?AqOAQ0hpxi9hdQfsw+qwD48gVecF3aDkA+EydAgcZ5pYdqI7JJG6r9G6bcM8?=
 =?us-ascii?Q?2R58GklRIPgpJ7tkBba/2nSAI4iCqW7DIJM1CD+V8kDU2bRQa18u4qr7Wv7g?=
 =?us-ascii?Q?cI+zBM2ArkfzW+sBbgmqBq0AY5oynstdWmPdH4bIJuuMSO4VL9wwGFyHVm2i?=
 =?us-ascii?Q?TZp2/1wH0PMa18q5+YDiTsWA3azo/NcyvdbScyD607xCNxL/uLGGTs7HYG9I?=
 =?us-ascii?Q?gI+GjPeKW6IFqX/+tzjVmbVwtIoesL9SIU/x5KWfMJzmQ2W4CVAq7Ys5kL6C?=
 =?us-ascii?Q?BZw1v7XFKlrpkyIwaIv4YilYfqRd0qr2R4MVBYgiQWqaYicD7OGvfMZdXxep?=
 =?us-ascii?Q?etoVGVnG42bE2bgu+qdgd7Bu8k8lKf22Q2dEB4U3dLwM3BR1IdjOodQ9nVJh?=
 =?us-ascii?Q?IbQFDQQNh41O2kd7p3YC7QkE58OJ5pdveBT/zqetu/tP9VxEu89ROxbCiXIz?=
 =?us-ascii?Q?4AMD5TOiXqZ+po7VYEpP3O+bELKEG4h6vwp1nF9nVohvT7c4208mWsk7V7LX?=
 =?us-ascii?Q?Og2XRec=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:18.9024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a33af9b-a197-4a9c-2bab-08dc63712568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e72c2b872957..8738a7b3917d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -782,6 +782,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT		25
+#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR			0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..2fc82831bddd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -50,8 +50,6 @@ enum {
 #define AMD_MSR_RANGE		(0x7)
 #define HYGON_MSR_RANGE		(0x7)
 
-#define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
-
 struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
-- 
2.34.1


