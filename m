Return-Path: <linux-kernel+bounces-57447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9884D926
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71791F223FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980434CFF;
	Thu,  8 Feb 2024 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jhq/1dEW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECD31759;
	Thu,  8 Feb 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364269; cv=fail; b=Wd6SO2pODrxBUbMV+jYtD2a9AjrRdSRZFlocoyodWE9RH6YiSfd77YyzC+11d8l7BRX5I4VT4W/FnvbEN0OT3WCcWmCme203+VWLFmKi57UxKvQNUgudr0U1CBBjNuW8QiYmSSFtaeD8+O2qjf37VMT5Coqv3zwmFOudaCXlIsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364269; c=relaxed/simple;
	bh=/faDvRJteyXqZPRAcoZKXoQ2KPMAH3/GzFGupp3EFhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDp5/3PQi0S0B6w8o8YE9F4Is+g5C9XvuaOh7t8QH+vY6B0Zy4LLah9d/CW/DXTQUUTw4JUhlpP5l+gjxo5YINHvIwbOIm7sp23PcMDhj+yE9tOijIwBJrI8XxPN/mHoDIaE/1lZE4y1kKr+NLNv3v7kkt28+4AgkvZ1ZtDgYTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jhq/1dEW; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufx9cj1+axwXsScJb1HzRgS6/N3vug7286y8KKmU/MQ2DCdAYdKckwHIB3mO9ILyoyoLkOS4ZjqyeocRJoYKqkzYoIOzW21wsiRSwZHJhKcv9gmUOFNQclXZaMpzor5iaQexQKoWVlwBfCweNKMl19aZxs0SH0Uol34qurxmXKMRzWw6i3uOnnbmhlo+u0+KRhoPZwmRFXpx5M9i6g18KdxKJzCbiiyMhA6Gcog7akzrLp1DLTzB6VBU293Ysn5Fg3Z69GwQRTiwNzNb0zS+6w6VHuUrHHASuQc6OQSjXOJPSmE0Gh7HfDynHefbEQHBmbdwSYIXP/l8UjM8AQFBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=oWdROs7twzKydMBufk91UrcAuFIrVszLq2Dlfxg7b9HCqkORFcdj5nG4pLx1U/Cf68ys1XcHCQF2/w3uI/7uos7BGzdJXKNkvbnE5n5ZLdGRGmLBUv8hBXGKcaiBEHVxkDtlOJKjyVKVLFOMskWDGG0/kJf7iswPekuPASTDaatjZSPquvhSZtj3ifKSY377wz6YGXBwnX6m3SLqwfxoflEzP0xdg5heCVGwAlASJENYtvzWaLT8fW5waGF9JzRdB6ss+IcjpMPSL8MQFjBnKyqB94pS3fIDGjzf8x4g2huHWuVyqkibDGEaXVWyGFAOJX+Z+HH2ARK9FWh5rmYQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=Jhq/1dEWPVpsAbsrDXbQ1WJSCfQiIY/HV7G5apblWEqxGLcLlSvhlahnY0OJMSd2A2y7mRH954KphxEk/IO9QsbNBACKmwvaEmraSiVuzEibky+aJiYzrAPiKN78s/XLh7G0XPH8nW8kxK6yrEghbSq1O+EE99kSscV2izHxsWI=
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 03:51:05 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::c5) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 03:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 8 Feb 2024 03:51:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:51:02 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/6] cppc_acpi: print error message if CPPC is unsupported
Date: Thu, 8 Feb 2024 11:46:32 +0800
Message-ID: <2343f6c652bbcfad9cb462b5fd05fdb49e833e1f.1707363758.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 628327cc-5dd7-4aa3-0c1c-08dc28592d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5PrCQ91vVShGgXeWH44RS3t7exisbm8nEi0HFMxMD1NVmZePcOqIgip9pTNQDBdv/c5KXY4q/DnWnECcYTtXllfC7RxCXr//gZdbAlinptkfjn9Aa1VxkPI+Th8o9j5WgE0QLURN40ZJbpZKANzrfkDwUyePr1l7z9/fFGCpl0svVAhel9UT3zo3ubx8w2Mzy3+69iZgkjKvwy16We6rLksUNe8B9+nzacont8oRYPUCFYE01uxepcIi0jVJdJhYBUmJKZT+pyvj1FQRRFkxnUIExX2Tg9pTgJpptXyBth33OHB9yfoNao3ian+vp11c3Zp8LnP1rjmGzIEpi32SxReheYXPU53nrWuAeW8qoJnqfvjBuKK5wUUCIYTJF7vwJUFuz5/5wLSTyGXcmaIxEyNIaCELrxMs0NsSP3ne8TIwch4jw/z4DaRhRhOskuPWEh0FC9ZM5t4iJpktwzOimfV78uMDrJOtEa1g/4ibEut4DQCRatrKjozKq8hSj+aAwXLpGGmfmpNYeb2L8YbebFqNxRRdQUyEblkbweg11FWBI0MykAF3abCbZZl9YevEiFk03ew6mQEbsoumsK9N64Go71vNieNabBTZKuiyTLM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(36756003)(478600001)(5660300002)(41300700001)(316002)(336012)(356005)(2616005)(15650500001)(426003)(81166007)(16526019)(82740400003)(26005)(8936002)(70206006)(6636002)(4326008)(6666004)(54906003)(2906002)(70586007)(83380400001)(8676002)(44832011)(7696005)(110136005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:51:05.3508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628327cc-5dd7-4aa3-0c1c-08dc28592d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a50e70abdf19..e23a84f4a50a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -679,8 +679,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
+		if (!cpc_supported_by_cpu()) {
+			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
+		}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


