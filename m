Return-Path: <linux-kernel+bounces-104023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF587C800
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9381F22DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73EE556;
	Fri, 15 Mar 2024 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16HsZVn8"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADFD29B;
	Fri, 15 Mar 2024 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473968; cv=fail; b=VOLP3D4lv1VTmxe/Fq13UJMWXbg1iNSnrr42eQYLr+T/9Iej+F8Y6F6cPBcGU6HvjaerQoYo/zgJNu99tRIa6Edql0w14uve1+ApcbNQJqihKhtb4RZAb8bQBuQDaXl2i+UVBHnrSr5jIe3Kdtvey/p9AdxZOVTK/vxlrPjW7p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473968; c=relaxed/simple;
	bh=/Ws93YPfQEKtzmeaXIjFwmKBI9PXsY3tbO6nBDCtKg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/CJCzXvGcdFLVQd7d3GOutYdGcXSuOglLziaSXKw/Jq5nuXynHGBR4nSB9g2kT47hAPLmoCfW6tJvRcckt+W6uoXg2LhTLLpzuS42rvxaUuOKCOGeqJUPeCKEz8pwW3iiHPRDy17/UotP4jTMqnW5FfFa57YZGBv4I8iWjsUAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16HsZVn8; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5/P6d2uAUk0Gb3oytZSU1JMkoCXQY+eHXnDXrRKlIFN8y3PIzWyGn8Y69z/hK4yvnH4HWzT0AXEo8014R4DSl2ZQCZ/WGM2JsEnW9/IvxiAKBOwaeRb8o7+3m1kvoGFWswATNPqFHMLgPpwIrB/RMmRgzBBAHC2NAHJJjE0LUW0219kRaLoj++BXi04HimBY5NFJFOS6jRAWTFK0Fth8DoFg4htXq0gEnwR8bvC6VlDC9JZRqCWMFIgSDX5RtA2A5ZhyLsiJmZTxyzElFnPpPEosRHVraiFduiBqse78HN88Wq7uClfV6UPMS9aRQaSywm/48gv7M0URfjqJVOLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbk054G3uTAd40lzenfkFawnSHZZ9Uc9Lt8FKpIt+8=;
 b=R3B6RSAG+pcO0kdA1AUnZB23hiWSO2aLlD5FvLH53KHqcNIE5xiv4vORRfHM+gEkqCzlL4NnEbFgOeDTEbr4CqRVYws0pChQbGl2oxL4G/h4yFdQudkrLq0UkH2Xxf0Q58tDGHPtZXEZlu6yI3o//LPweBjAqSMRTB6q/U31VpCqGTM2bwQS4VxcDZpHjf1vYcaviLCVrIrnpYSqriVswIeJU0fq4tUbJxqSR993FPcSdgkqfsG33cQ083hj6OeqwZqPQD01jcoiZ34lm2nETPu5apfK+8fZ72z2c246p7F0UxXPd6rEehQGyDN0teYCz+u4P089dGl3kX7JB5yqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBbk054G3uTAd40lzenfkFawnSHZZ9Uc9Lt8FKpIt+8=;
 b=16HsZVn8OdBAzihZeuIO+3LFyw/NzXJx7lZpTeniGf+3ATabBbP4YVnbHVXNVlC41H9XG9V4IcoQFsnD4UoaCpjYingmSnsGXL2+xgyQggssOf/p5aFV6t9uaZKkkaQB5j1r1YjsvD+N4E9ji9Ozv8C+dD7CrYz7cvTWp5uxliw=
Received: from DS7PR05CA0073.namprd05.prod.outlook.com (2603:10b6:8:57::27) by
 SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 03:39:21 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::6b) by DS7PR05CA0073.outlook.office365.com
 (2603:10b6:8:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:38:43 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/8] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Fri, 15 Mar 2024 11:38:02 +0800
Message-ID: <ff860fd69e257199ef799042d257008a19e935cf.1710473712.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: f4391eb5-81ad-4549-002d-08dc44a1805d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a233nHzdPYlanzny9jV5Xztchm1wVRLZYxypgsnoxf6VBTNIgcWNqmmCg3W7VjIUe+mwEDC+kmQKhbLSPqk/27nk3rNt+bhbwKG95Yv3jqU6+93LfJ75VQLOQ9qFeW9sQrYBz7iralAFngGPMRCbEEtJfXlpDiu2hKrk39Hr4ysg4m0IpDvYrMvlXgGxgZLho5Vyo5OcykCanLegy8LwXgvZ5rZop5fBavGailqbBuwGnaUCMxa5WjyR/0Q8Q6dcwJUmB4/w8gD+UcpzYk/IltI4Td3esvHDsFnVT7+QpC8xDkv2890Xi2c+iPptZvU/0BLXtyG9Gui4ZDLEZfIUsDsY4THvHT39UnnCzN9N+Z/TDluKro/F6YP8FfRyUID+x5Uo+aRKOjNe8VKa7x1UH1EDcU72JrX7V5wyTdd1rfjQCm+GP8anMN8hHUmDi36+iLn9NiyEN+fEVBMswWNVFhH0cKQWhC0ZkI8Yqwqzkomnfuebpv68aG3vQOSbUV5pFE47EhJ66h14HjYpK/5KgvMo7EKI0tEnBMzRTNR6avRXzWnMKHkZfETVqrocDFI7n9I2akRA6ahFP1lQ7iwxlwQttCbdHZbi2Um0v0KsMwDkyAGW4P2BcdYF3s0wCbcGMfX0vvWGHUyQCCiSkmyskX0yvNHqdnMi3afUH6YyyOJEUL79MysJp8PvpFg4XRISQyurhR3Z+w2V7HlNX5JxicBQ9k+23o0ihii+H2q8aAjhfisrht3QMx9vVpMcjK4r
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:21.3144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4391eb5-81ad-4549-002d-08dc44a1805d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313

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


