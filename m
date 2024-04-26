Return-Path: <linux-kernel+bounces-159579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEDC8B308D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D4928781E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A49A13BC28;
	Fri, 26 Apr 2024 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHOpU8C1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783F13BACE;
	Fri, 26 Apr 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113336; cv=fail; b=hUBaV7iNhiGPSF2l91qHWwp94hI6A/6RA5rOD/mrKO66vJofQJ2dE3qNusYY2XQ/LNQjKIHMOkTc++JscpbX9z48wgOCr3vXJI4QeBsd2tjQSnme1TCJ+xDPWU8AgBRPmtuXMtHqwYOUFDWUMcUyJMi3xA4hHYvbqOBCaxbBy4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113336; c=relaxed/simple;
	bh=oEJ1aIAtGosrFyk4IqINDU+8CxFIH3iJUhgfurIlJY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxkYUTfQmTaArfbyZSDouKRMj1WCEFgetzUya+2OVTQyt3p1ySKZ7DnqVkWz0EfvPBZmLiVGXxRyz4d2FlS7V71Fijtj2F4IkSOjBsu/SSJ+vJw0PBjqb1Ko8DwKSsNUEhOq9NdIgGyyYlhj9r3iTHjx5+mZK9QD3fxrD+95QYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHOpU8C1; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3EM8yAXjWfZiVicLJ6cs9/7TzHX20fxmBsnR7/fzKp0TVyRB3ipXt3wH8PJvj40mLcRrLreNiJsqrQoIEhLVU48Wg/+kCUHqCQLUr1PeHLk2kXlTNUJ5CBbDKW4JJqVRtTfA11bDRucVIOXvfQ9XLrLHDzaF9DXlacJ6FVnUf3FtE3TLSTYaLhyN0QaTbDpCMybnW0w1vGO805CESJcf49HXsUZMwioJ6LKP8R2Y24J8jOvNNzJ4b6rsUAvge3JuuYaTAXLEu67PlDAHhYCPlxEWpMzr40zFte1Uc5nJvNpywyvbwVOk0c+E+xDCy/Yi2ja5s3rUzgkVYfCsNkJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq+BXGQldt6vAGnrN13zwfmUSkeLFSTbaIEjid2Iko8=;
 b=gMj45cLH70VXrvTuFE9pZS4oQ/0Fclkr1MgwH6d6BoHrk7UEZUlRiK0xbaygzJzCVALQ0MbKlW0j53B+06gaXUtsZSmGtbb5P+VwNv0v160AspZ6AF4SLWLeIuaQRMK8GWvUUrnsb1j0nDubP1J/8hA4msfFEAQoPCDLEs3+ue4Ki3dm+BPcPvqP4gBrJ8IcGMRdCW8NpWL8sYsJlcn6f7PvyxkBqJ7hv4c19l0C35orecw8ipluqPWYWFKstUOfBXJU+Xe6af7GpdegaHokBYloAKunPVhNQnOzpxMqM5Esks9C37pv8lxAQx2dTbES6sUwFXIGHjNMRIck6AANrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq+BXGQldt6vAGnrN13zwfmUSkeLFSTbaIEjid2Iko8=;
 b=KHOpU8C1xJnELioWXH5BN9IiJleHP+TZqS4I+bAmzK7ArN47hXf/yfpodBlVOGjXdO0eJ/zCF20pepuqOL/i2lGOh7bmx6d3Ne744GZpdMpGkTPZQ6S22RX77/vujWO0R3TPBEaWsVdsZ+601ZU8N6ttie4uC7Xhjr1xQEbcBtg=
Received: from CH0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:610:77::26)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 06:35:12 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::70) by CH0PR04CA0051.outlook.office365.com
 (2603:10b6:610:77::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.30 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:09 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Fri, 26 Apr 2024 14:34:44 +0800
Message-ID: <d90c7b51b3bf987b6f47ef96f09d21f17580e11a.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccfa2f7-21f3-4b2e-59b3-08dc65bb06cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?heV+G7mL/a1IUxxgGMA5GlnOTplq+DdNkD3RJdW3aPkfo/38bDJ5PSNfL/FH?=
 =?us-ascii?Q?YwDT8nUD1o/HhgQztxBFSG+hVDR9U/GJiKZv47u+Tc1pmPwGvsJlBbAzYWfB?=
 =?us-ascii?Q?HW/2Xxo9DWRw0tdN0Esacc1bgEp0L9Nj4UJhYVh+FjSYuQa64GJITofw3e51?=
 =?us-ascii?Q?ySE6DRlTITHmebAQth6NDGAXkHeIyaGgTftUzEo1r5AeLf7Zy15cBv5fmdSW?=
 =?us-ascii?Q?xADAL6b808fEyrAqrtLV0ftZbhJj+F8g6/tSqTqVIsHrtMrfG/Dk6tDdGxrd?=
 =?us-ascii?Q?yJFBqZKlXSyT8Cw9FrQGCYuEWbW+SFtcB2hXMHqBx/JqgRyknxm+/Lw9Cfay?=
 =?us-ascii?Q?hiUt/6sYPU4qMvbqJH7qao4pHpFGD7TqzjdsrwStcmeih2M4mo9tWAlBv7LA?=
 =?us-ascii?Q?TcChWuPjD/rw7DcZ2lW8m90DTpAVOEVj/UfSHm6r+K/J9s9CcENzURgbsQeM?=
 =?us-ascii?Q?Zf3v9gdoOej7sTJV8nMywzwIAAFl6q7YbEt+kEFPGrfEMH/pwJETZrp1blzj?=
 =?us-ascii?Q?ehKRCuYLiDQMkzu5g4TXQx2Ov/XK28ZWfqn4LUqpLxdxG66ynrmu9+sT5TxE?=
 =?us-ascii?Q?nXyEEwdgYptSgPe9mn0/TYogQcbFspH3LSUIVQFCZJRrY2U3yhDB2exEHS+F?=
 =?us-ascii?Q?ltB3YvkENVHQig/UWqPCGVqyyMxafU0MpJgN9/WltO5PjCar+sW5IX20MH3U?=
 =?us-ascii?Q?eGNR9a92vGJKEoS9/qSoTZu3fUsEek8rRRzRM5v8nfBas9ViQ1/tU6UHy+xF?=
 =?us-ascii?Q?4ki19r6US9DR9uV34GEwUpxnyOKmuFe7c7vrKjSgTzKAticZA6uOgOUJPh1w?=
 =?us-ascii?Q?ggy/1oe/KRDawFwTyRQB1WOeBZVeOev7dwuYZfCqsZcj/+5EuvIPz3FHvymE?=
 =?us-ascii?Q?d/EkDQEnkzxeL+PpfQ/8aYDKdu05YCGz3EFbUzWHEl1Wr02iNXkb5yhA+H/p?=
 =?us-ascii?Q?FQk/1ne+XFwoGcdccmCort5tljVi4gfniADNxscneAALN8/2cNxrv4D9ZnzC?=
 =?us-ascii?Q?PotqMb9dBIHWZwaIrdQ7bmZKV3AvzbKMn0PTqRXf1KcajC5aOn8r4tQtTl7q?=
 =?us-ascii?Q?t5GGTex1LUoVl05g1sA0rtF+wB4zmrlw32ryyEpUukp3WTUAGLLmKKtSw1L9?=
 =?us-ascii?Q?CUp2ihUvQEGTgohqcBWGbSdeYVIF4TjGaM7lwsLlTDyehN/uu77tg3FBsw8J?=
 =?us-ascii?Q?gH7Gv9oOBxPFloW4JWIgplFkMdBJOU4DIkG6lUMe2iPLxZNI09AEX1D2+w1l?=
 =?us-ascii?Q?lboQ6gD3kYG0G5HoHb7UdbeUe8V44h2o1k2FjnfLnqSYlur8o3mzrome+2JI?=
 =?us-ascii?Q?VJDJW/RMFihHazUz/rBaYUvJUdrDLXo8e00AM17jNNlfAfH8LO9j0bcJGA/m?=
 =?us-ascii?Q?hnu7O6E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:12.6553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccfa2f7-21f3-4b2e-59b3-08dc65bb06cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Huang Rui <ray.huang@amd.com>
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


