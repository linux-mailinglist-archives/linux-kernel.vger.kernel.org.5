Return-Path: <linux-kernel+bounces-106674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3687F1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3831F22162
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6A5A0FB;
	Mon, 18 Mar 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgG8mq4M"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92359B49;
	Mon, 18 Mar 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796179; cv=fail; b=XUQwyGNsbnHgZtiuxigvaopgovcqkquHc5XR8iP2Mt6Pd4Y38Vi28mHMbnrEMsjzRTQxWC0kmIRPaRPNZIH4h1Y5XuPZKSE9cmjWc/um507GB+92yCG0+jQvW7y+1GlgU1R3Mp7GrMM4gbyQm8VnTkar6syCI3f6ZTOicOGx4ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796179; c=relaxed/simple;
	bh=nk1BgPKRoO5icOGB2FzyrMY0rbvumy19SCcLeZeu6R0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5Bj8O/RkqiXribuTwdZcghCOjv39+rPor0pnmqwLMJnQp6cPZuqv1GpSp/bsCAF9yJlVahCXHBLSb/COPwL/R73ZHsiRPKdQKTQ3olt7s0bg/ADrp6ozO0gx9JfYs0PKq7pEwLzqOzXTuAY1eNzEPzit6zospTX0ZYQkBXCKEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgG8mq4M; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZLKaYZW+LlCtFa7/XKNXTMywBi5EUc0EbvKutYOzX8DlhOU4nO8jPX+v3W9z6CLha8YSzldapaxApCHz/ijoqNLbYD1hW7FbFXmF4l91qJYlXXMSw9GsMbVmXeMHFURfr07QYpS8dB3s2OsLiuJshLDPDk42c+psu44J5/Q3CW89dt1XpW+CLAkb+PO5k3MohFHQLp5HQlWJcFpv7CblM3rH3OVb/Nj2m40FnmEJtrGjZSorqlfLYGIwXl4nSHKWV0dZ7RfT3KKXibeHBvrvUOHFlfDX+58mfMTZvEKFlANFZE2bjrAN+07QmoqlvFHS8LmTovt9QTddSOxJOScEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoLFzG2MgkwNippgJ7PxCr/qYu5ZBNIIQFdlZpjxFkA=;
 b=V3IB7Y/XDfeVttTNPmgndsf48A7Appn/pA6jtyqgryq2F3qmDudoIS2zMcKwAeyy0QAF3MhGZm9RbnmY7mRLVP8B6gtEYWMIeEAN9WDqh7mxQRf1Jj5Fk373ew5vqJsWnqxDDUX7oT8Rm8kJ1nj5FpRgjJCMy32B3gknt6pcKAIr+CtsX0degTL3yp1VfbtW/LsdFVqBYS3rBm81x7YvGwLixv5a8FQ9x+0RcUkaAPqtgGd7uuMriQj66VjLLl3cNFb1ykZhaSz0VM9T0b6nskqzF2cHqSfjwMiQ2NmiX5FsuDPvL2MFCKs8Xp2ptSG8IvlwQmlGPBjPfHVnL7WO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoLFzG2MgkwNippgJ7PxCr/qYu5ZBNIIQFdlZpjxFkA=;
 b=EgG8mq4Mkup8N/xeRSAqbtSrOJe0S3WiwxrUVvH9yUOq1y4NHSGXFsx5aS1tu+V2TXB1V9ykzscDiezoSqj7Rx1i1OUZUsIZNKvXLrmswdYVVVGtQUmzhMI1QJ3bL9FmTIZpLZUDx+YUCjWU/N/X90il36+s5wRXDvCWAWl/CbI=
Received: from CY5PR14CA0004.namprd14.prod.outlook.com (2603:10b6:930:2::35)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Mon, 18 Mar 2024 21:09:35 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::2f) by CY5PR14CA0004.outlook.office365.com
 (2603:10b6:930:2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 21:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 21:09:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 16:09:31 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Mon, 18 Mar 2024 22:09:01 +0100
Message-ID: <20240318210904.2188120-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318210904.2188120-1-rrichter@amd.com>
References: <20240318210904.2188120-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8b7dc5-f2bb-4a63-30e8-08dc478fb697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fgJPezWcYsTG+5qhcaJfwHCSEQmQxt1liuaR73Ydb09cJWvHYONyP6JS5twb2dM+2GHz5RzU22kVmK37zSMFZoCuGfDL+SexwZfhva85V1SxZymV5PZONQmLh1fETG5U0VX/gZwA8E8U76bDpYiJPyrJZkX9EDM9FEvIk9WTKcz8LrfZCHHKtga6Qb42YXKX0kf0gF7wbxrYjTvH9kvGTZFWOBUNrnRUEbNoajXpwGT0SX9e8d/dROrBFJYWkdKlPEeStdlHB145Kr1zoyOU4gBDS64hnGjyL6zwUsTDzeRFdQlXIE4GrlkuIw/NrMejE9qoC9A7/HoWTIy85CaUXKvGawRaSszksSLbu/jMa4DcEBo/ezHaWNT9pIXeNeoE/qbFwFYBM+NKt6Odvd3OjUq0CrgDa6gR7r9SySuXmA8MV+xGN137TlPemJJ3lklpT25pwLIqSFhjVOg3hB6jFOwhCuGHBzmSAh1G75tuRNSTwQ2qKsVAWg0PfTEEUZyT/Fh9uay2Cf240qMxOdvi3nov4eBPvs2dAA66NecBAH2I2VOksOQ36VE/rnZe98M2QZK4bNlqNcg7DWwcEgdfTr8PEsEzSpSDeTUPoiG0syCKzALn5ZuSrPkEJFKeNTm2puee7S4+dJYOYvSAl6Euw9MWA7s418PV03ZdZ77coZZKGQBhPEnNCI4b1m+I8UYRQzHTFj6SfyPJN/7ZgLx5E9LEjFhgugL7VG1J8+BipaaWeTR5Etqwoj0q85Vd71KP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:09:34.7333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8b7dc5-f2bb-4a63-30e8-08dc478fb697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

With kconfig option NUMA_KEEP_MEMINFO disabled the SRAT lookup done
with numa_fill_memblks() fails returning NUMA_NO_MEMBLK (-1). An
existing SRAT memory range cannot be found for a CFMWS address range.
This causes the addition of a duplicate numa_memblk with a different
node id and a subsequent page fault and kernel crash during boot.

Note that the issue was initially introduced with [1]. But since
phys_to_target_node() was originally used that returned the valid node
0, an additional numa_memblk was not added. Though, the node id was
wrong too.

Fix this by enabling NUMA_KEEP_MEMINFO for x86 with ACPI and NUMA
enabled.

[1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Cc: Derick Marks <derick.w.marks@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index 849c2bd820b9..2f4ac6ac6768 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -3,6 +3,7 @@ config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
 	depends on (X86 || ARM64 || LOONGARCH)
+	select NUMA_KEEP_MEMINFO if X86
 	default y if ARM64
 
 config ACPI_HMAT
-- 
2.39.2


