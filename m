Return-Path: <linux-kernel+bounces-105967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370C87E6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C551C219A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18958381C1;
	Mon, 18 Mar 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="llbUZNTd"
Received: from outbound.mail.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D1381BE;
	Mon, 18 Mar 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756700; cv=fail; b=FgEU5VYrvfe6klOJdRc7C1tZYzH7NAl2S9fUepZcPPcEJZ7+QmgAQSV7a9GLqjq6cVvNAP5SHJOeL37LFrGuWuJEb8vwyyWlHVndbcvlUrrGtFEEgwYJlN6GfmICCpPCqCLzZREbuqlh8hQd3AY4V3lXC3M6aYkiqMVKRr9lE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756700; c=relaxed/simple;
	bh=/Ws93YPfQEKtzmeaXIjFwmKBI9PXsY3tbO6nBDCtKg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haV7GER32m8JrpJ3B5qUgrEwxhRmWF+KiMkBA6iqCyE8yO2H4dIpdB9KqrGAfFb6uv8mQoIBhmQyzPIXEnQZTsqaL4L2f1GCshTr30iYN/8nQulTVpEoUOu8jjNCl1A2MzVJz6/21TXZFvzE8CerJCT0Q/ua4I1BEXv6GMu1wEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=llbUZNTd; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS5HqI+DzxVeZWgTV3ZyPzipjQzrd0dbtFZHFIXMLHb2B/G+MZj7aMCkbWMH3k4pSFgG464vrmfUwibE09WOAEBl+fkZCuLxvaoWZD5D4Oq6UYvLAhWWdexZOFsGT0JthXj1gjhzAWAtS/2sB5TzZJVRXoAvlORFyZ30mSkjjScuiqVYWLFYBrauobm4rxEstz914nTmcpmSHPXutsW/RhzTrr9wTapuPUPn2atTc91e6dc/AlRc6SrKHWBNaKbBWfZIYaOPCTeXwZ8RAYq+WlSG4Pzh+OrfHeaqN7lfuBxPtO6EIROTn37SR7ouqBMeX9xYK+I/Jk8jkA6TkjukqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbk054G3uTAd40lzenfkFawnSHZZ9Uc9Lt8FKpIt+8=;
 b=QLeNgAVa+65tL1JWH7EtCL8WaKMwlBfCVtXw3namaldZ35Vt45bMlx6nmT35aJdJ1v02Jy9twaSB24TtR1HTSEu3joM16u8N72MKT3hjR30V0pGgh5O88+GtYUpLZ9hSeAukCZRb3NBIYiSuqr6xKA8iSzWtAGMKrKTI30rYKBNIlmjUwBdFgdjImKE7ezZ/DKYOdPsYxfR3mWi1pP3DLbd66G18kj/rstbMQKn2L8kR9AsQLVEI8DrsqGQTnxlR++2EYqlMEYQEangcpJAqXCZuJ2AYecXG1FZEX+ScT2kVJFuZ+4KqU2dxUvI8A+SguqNSoMGYtVOLhfnrKsq2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBbk054G3uTAd40lzenfkFawnSHZZ9Uc9Lt8FKpIt+8=;
 b=llbUZNTd161K0bL2TrdLwALzn/6tmrSt6hUf2ztBmANGlECzYtVt836IH6PJU5g2Kh7WIrTlkpESAJGTkIs5shHpAIIltTiM8G7/IS1QIYEVN74e1Hg0Fq5Z5J1297txwtHmg7CxG5gv8rxMyoN3JpIAYg1m00jvaANl+NenfTQ=
Received: from CY5PR15CA0171.namprd15.prod.outlook.com (2603:10b6:930:81::17)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 10:11:34 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::b8) by CY5PR15CA0171.outlook.office365.com
 (2603:10b6:930:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:33 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:30 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Mon, 18 Mar 2024 18:11:08 +0800
Message-ID: <8e617be2b0eef88781973e16a98aac6a4a08d664.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 812d02d9-4d94-4256-d0ba-08dc4733c9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s3KMPpKITetCKNEmAlQSlTAvHLj52R1pd2k96ZtKS5PiKQ6WP6h0NRQao+TaNcNj6n04Oc8joiZiWUdDWSzyNwAiOTIyncXLT675Mm2GrhJsx6M4AEJBDtOjaHaRcA9d/U6NGPop4mJiJqPgjgvB03lYxPJBCDHSPVanPULaQ1wVpEonTa6AlNnX6ST59v1n/2S2bI9JRnKDMheYH1XaLaYLD7FSZcVOFN9BwQZ6Sw5164gFI9uXNmPk6+aTN7LWNGvgzva08r+EjPqCC/lpvcRPkPhn1LRoEryoNocmEAaJB4Ry0NG1OaU8nOMMY+jyLTK4wqNHRk+9Ufbp+Yobyon60QcwFr9hQbYFjbPago0SSZUXPWh2ENPMU8xas2H+EiVx1wRWZzQi+gBliLInyFgHmTBNQmMMDkW6JZiVOGm0cQeW3Pi6mFzRcG/jNuc9J8LnyfNBoFKr6SLXh7DPJ5t1b9dA7BQ5XhIJBrjGes+sCFqiLl1YfwHzSPuZjvib1C9tJh61fEEyEjaxrByVO3y/3SG7QrvK3wWawY2bOfmJlY/XaJQU4NECNI/BLMJSAHWduusYAamd1KlaO//YEFD5SYj+iY1LHvgOO23P8b2+1Os/CBJOeEYd7WT6JX/Yr5eCNQazxMA2TSNqpJigg9FGUe4TP0YD+/YNw6aPWVWhSpKPawGr0arUw8ayI3kj3FCAWBoIF/eyT6TdE52kZLX2dhE9fUJEjmy+BvncZGYFj3O8MFoMQSHJMr01JDV7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:33.6105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d02d9-4d94-4256-d0ba-08dc4733c9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 05956bd8bacf..41503647192e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -775,6 +775,8 @@
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


