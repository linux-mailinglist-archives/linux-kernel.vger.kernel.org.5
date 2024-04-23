Return-Path: <linux-kernel+bounces-154711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867C8AE001
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F2E1F22791
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D25D903;
	Tue, 23 Apr 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+KSOM5C"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C45A7AE;
	Tue, 23 Apr 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861700; cv=fail; b=XRKWzjNkNwbPjl8NJeQUDix77JYgCU++VZR4AgFNB5V54LpenM02iIKivGSTfsqzbEJQ0THubmrPUrl6ElRjKNBDA6sK6JcSjn4hw1ERp+PEZbSURSpq+x/YnAZFHJuscej0F7pEMvcRFEo/8ZarTORLSLAjHKIouBf0VQTUoKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861700; c=relaxed/simple;
	bh=W+dCh9C8EntywcvXhSubkaBnZJJuzKjsF7idcfLgto4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9KAApiNdPbmRLNCIn4XkR7gsyZBWNUuZ6dMU2YdMHrLGsddMFFA3vPXKPbeOsDM4jGsKp0O8L9SdxU6OmIbohPqvasyidAP43saTKcgaNdAMEyWYka/X/wt/uQ/68ZwWLGeXTCYY/r2/xx1dvQyjDdPQBWirXqUsHtNc/OxCxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+KSOM5C; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7R3DOjUP5jAzpsGHKefq1Gi1i4B6M7abT5WlyJHGP7jmbSA+BKs8HL3AF3Yta3ZVJ5Stxo2HU6i3VjG1G7D8w25STpgFd3g1CqeHuzJhtsYnh8yVkVxZk6WkIAuRs08CpeNvg+OlXnPaaNCQ6/e6SSoM7cu3caS4DB9iBAArQroTn51+jK+7Gx4tPsClFwgJ1H9GEMpYBqvPzsXLylkLg3M9O/bWDbqvS68Qs1leqjKJA+hrApv0GiCuxbaHQHlxN00LkjO4qFtjZuZaJBG8y+Lxi0fqYvYe/r9kC2sGpZoc4QGCKJmwJRfjrfN9xbQY4uPWmRXeIITsIRyvC6+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8EDLYk3NSyioGPjxU+pIEAuL4I7f4cRvkuByN872I4=;
 b=BxRukI8hoytJE81wLIUezbWpiDldJmLaVVQennyPJR5RiKqe3oZUO9nG3OOSJeHMoraVkTip8jO7pN3ijvPw9ZZjUhACw80lnEuKW9RIp/Pu1vUoaKiYoYbKz6JaKD2mGFJHqljdMGg+su03YMjS9LMhp4DsQW0hjfd8bYoScI5N1McqgVsdkhKRT/Bt/OYnYlHmTvOhOT1XYCl3P0zx5zbobc5T7mxyWzNiJLUstEG0vU5RCHWMS3B7XHryNIrbV/WRCdKJge5jqO3ylPHY1/gmu6/WjgoLKJTCrf2tNN2VPSusC8Hnkah6LTCVW0inhxSWq7UV8z8ksHYNNHbUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8EDLYk3NSyioGPjxU+pIEAuL4I7f4cRvkuByN872I4=;
 b=B+KSOM5CBTa9RbUWqm9sBKOTxjYgfGkMdWanUIcMqgr+hw3HzefRSpAVZXGsmZfg0zf9XdnL0OCEn1hu6ACHKv8y0ZBwGhhMpW/odL315+ARU7kwjqNWtmjrAKbeGR1nwKnyh+z21EPsbKYHOU3fdUlQ1fyeYLxWu+3h+mhaqp4=
Received: from DM6PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:100::34)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:41:36 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::c7) by DM6PR03CA0057.outlook.office365.com
 (2603:10b6:5:100::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:32 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 6/6] cpufreq: amd-pstate-ut: support new cpb boost control interface
Date: Tue, 23 Apr 2024 16:40:59 +0800
Message-ID: <fff9a75f745ef10a4e7e9b0a9b383655ebb0cfd1.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: e2958de3-5bae-4203-e5db-08dc63712ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y0zhh1idaBn1Tj+XkXOXAh2s4RcMC6WLC5TixD+5EhvZsxk61IW59FbITLDm?=
 =?us-ascii?Q?4bDcTJl/vbtWatFHV5153V7jtOQPHXCvJw5/5MmbcCmRLZELRZOCUg6ficO1?=
 =?us-ascii?Q?Uzdy7ab4vcI+oe09JOvm3yFj6BwNzVBBWGHJ5a+KQmnsy/XKzQ5YKt5lvZm1?=
 =?us-ascii?Q?MV7/fPAJFuoK3YwWaOwh8/ERGwx2jB/qsYTovk90a/SEfeDhUMsOEID9n++n?=
 =?us-ascii?Q?uJIRmR6ez6b0nOOGMkdoK3ypIEVLJZT5W02r6pznhhG/V5ke4HGBWIj/fkz0?=
 =?us-ascii?Q?7KLn5+es3jYL9DPoap6hd2Xmfrz9wUubGWLnjNQnnOZOCK67sPRsSN66ncqH?=
 =?us-ascii?Q?biNc/5D9AxbmpsQyArQoe1ycGU6B5MfU/yPhLYM0r8i+k6UTJGibogbWBxMQ?=
 =?us-ascii?Q?4NYWDuhSnB6o3B0uIer3SsaHdMcIoqmkIKav8hD/s6pCg84p2SVPrpy76wfK?=
 =?us-ascii?Q?Iq4td0AlhyLJ5mYmhglo11bnplZsE7rf7T8qkj9+vyJOqMJMDR2P+h3v1Pej?=
 =?us-ascii?Q?OJoSjThi/qQRbzCOmLO/6R5WtGO54iWtyQnwrlOpH6uuz/SrIDqc5jPNDkaM?=
 =?us-ascii?Q?LBVJsRXESOUrUp/1F29fciRWlic6e5dxcG1Wc4OGXeYJmJvkCEcExO8QNojQ?=
 =?us-ascii?Q?HkHjhbPOxSjgVZDAJBfRFcVH3/kiBBR2XQG7sskXAePPDLydiwqeTvdAd+fk?=
 =?us-ascii?Q?52+5Z7ZCGO5R33cNRpQDWNUS9D4bwFQHH1tGAxQi4pQQJlnuLCq/6Lx+qLK7?=
 =?us-ascii?Q?XHC/abNNOSJXBfedNLspH/eivm817YcfzhDpAXyFJU+1Z4qIj13Al9uXTJYd?=
 =?us-ascii?Q?Sy9d18iiiU9WiBzpd48gxCfASbtkmCtf6qpl33WrskTiUQv3TnkD4xiBT+1A?=
 =?us-ascii?Q?YRRQaxoHZLfyohB1SoLTZAcgiAtbTC6c2st7tbAX8h+KDHh5qQ5Ep/5w6HjR?=
 =?us-ascii?Q?CToGHnvmGkvnGgp47FU+g5oA4gN94iRrbLJHdUdaGoPwXsJqFmU6SiM2n+cJ?=
 =?us-ascii?Q?OE4xKRyHjvs50zVxR4eYtWmQQN4V5Kx4J/wUqJd78s0sHIuGYoXCHxclawNI?=
 =?us-ascii?Q?HxMOmbkKduGWIUwIuqAaEoziC1n9luyspdNKk/mpSysXLFQKHzdquQiybB5W?=
 =?us-ascii?Q?puwpC48fyVJ1quZaJS2hEDutonL/e9YAiUnsUg0nxK0s5ZvGB49e/RVD0vtU?=
 =?us-ascii?Q?zxrnMuGviIhSQgfYKepCP5opsNgDQWOTAijdaPxAY7f4V6nAQdc3Av7MC+pX?=
 =?us-ascii?Q?3EkY+JWQUDYynEUce1txJBUscWXP/JoTisMM1S9Z9xh61iyQoBKjmIY6au7v?=
 =?us-ascii?Q?ao6lZ6hSRQFY4U3Q0ndHBbX0bGBFAMOw8tJ4yCaIBLKyaOtkdaZ/UdtWKyFo?=
 =?us-ascii?Q?8DrHq4rSqJ5TJ0Z3x9dzkOJR5AEz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:36.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2958de3-5bae-4203-e5db-08dc63712ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

As the new CPB boost control is enabled, pstate unit test needs to remove
legacy `boost_supported` check and start to use new CPB boost control
interface `amd_pstate_global_params.cpb_boost`.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..b3601b0e6dd3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-- 
2.34.1


