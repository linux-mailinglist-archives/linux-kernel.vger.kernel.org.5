Return-Path: <linux-kernel+bounces-105754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10F87E3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C2A1C20C76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A2522F03;
	Mon, 18 Mar 2024 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TeTpBphJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A022EE5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710745365; cv=fail; b=hjxAU6piP531SFHGQZXDIztnkWLe+9mYHDCVUTSi513JReNY5+Mr2ScOrfkVAiWbiicXj0qxtICZVTFgcbLA8D3bWqtrgTo8Kjv9bzPuropBrtZooZdV96DwlDLc90rFw8lyXxLRvNdAbGH4ZEE5H3vb7gpfMgMx41L1UEXZZFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710745365; c=relaxed/simple;
	bh=038RpIuUU4eaLm7y01p5tuc1tmD7dCv5a4FFVlDpr6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMigFqt3GEH7bb0N2pyNWCrPHoUzUZ3fksCqDAIuvhr2jnQek6KKYkFTVFSKLGqlZTtUzvr7zUJjja9anSC4GyESXKeV31CPFvAFPV+K3858rAXbMox+VN2ZZe1W51UiHOUi1tKJMYQNbRZI4gqi6kA73ystDN7JGltiS4imGmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TeTpBphJ; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRybgNIAECvQCQsJvb0kNof2YAtHEIfUZY2WVxo3g0T2FhqAyKv49M+PyY83pyEi3s3S/KLOtgtp5v4oA+hFhSrqyPRSNqib+MryJBU8t52CuCUqgvd4AAoZq8m2aOsXaoaxipIELJVA26ANw21rrOQL97bQDYi/BqCXZLT1fbtnskOrDL041Af7OLOBFrcCxNcRKbORZMbGtsm3g8dgSmGlHjFdE1YiHJZmeI2LMT1LgT44Qx8FD8x3ntjw5XhAdv6XmCXGFOWwtBdXEvvwJ8Mijb7c2fjSEOCwYR3ff/KyiwtZrICIWoK2ktFalx7914yWx5rW9Pic2NEQcdjCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+85XbWfJbKBP7XmrEj0lBQMTOoQQ8dWyQJCfkoFmycU=;
 b=Co3duslKSmZ8H28+kO1y/xrnWYBE30xpogVY+prthu4nD0gU8ai3VGmobHj8tW5UITvZutI48hyLFX54XJVmIUnNUihzrVmhysPaGe+ruN8vlIQBwo9Ownk8BruizH+Pw8Q2QbW308LJpgHLRpZupg9V2+JvdfUP4Yd8U19PkxInb4C5/tmPAEypnNOtNRGWGU7+3VZGgjGgYon5IzoJTKQng5S2LXw6nuUUzgbrzjd/MTF/xLsY6X/W5TX/N1GoQw1Zz3ifjqvReyKmxqP0iF3QBEnUh1nU4lFLDBwGTlNwO73A745s9P1BGerqoY/AHStPQXE20Cv7lnkBEj1g6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+85XbWfJbKBP7XmrEj0lBQMTOoQQ8dWyQJCfkoFmycU=;
 b=TeTpBphJ2thxECkMskSvyydmlxoDvzDPeRbqldLRGO5cmKEWhADuO+DbvrgEyQRbM/+YY0sVEOnhIRAvG03hd+T6nW+Iap2HU/WrWu8RtqB5GNnfhKgexVByHQx6JWjPe4YxsZYiYRH5ap0f0tfEsxo3kRz79gghEwNBMLfGgsc=
Received: from DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) by
 LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:02:41 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::95) by DM5PR07CA0084.outlook.office365.com
 (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 07:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:02:40 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:02:39 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <elena.reshetova@intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <seanjc@google.com>, <michael.roth@amd.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <bdas@redhat.com>, <vkuznets@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>
Subject: [PATCH v2 1/3] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 18 Mar 2024 07:02:29 +0000
Message-ID: <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710744412.git.ashish.kalra@amd.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com> <cover.1710744412.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: e661cc3a-c515-4312-c3ec-08dc471966f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RCxkxCK6aw0/UClItug+3omadoMxcMpIeIOW22EhwhK5JjEjTL3yBO271vzvWZh1JhKZ/mRtHL8yRHL863hbj0VVmSsbSKVUVfd2/CU206UUq69C7KrCKaa16rW1d5/NZoOy2Jwbc8HYlfu9RvGl+cDqicuKkutMNY9ZrHYiIzXgpla1yDcL4WqP/aRWVOKZYsKlrKG/nOt89SzHLd9CGYBKK5z+f3A65ESg6lzKR6FvsEOY6085UGiYaZXku3ENvoqqT3Xsa0JmafDmFaJS8z0lFFznv1psCw8pXDbu85WYeSgcSrz6mAJzqAy1ix/GsW0cgUjKJ3cmNkYFpCEh9frsMfmtjo6B53yFQCrZ1Udyj8G4pNMqVRoeG0wSYWu6FdheWcCzI3RA6M4vk4mCgJ/LFGisnNSmdpFTsp4mmSS9j2qkAWon4M4nQMcru18d0wELzDHZilqTsL79afamizMpF6mb6g+nqWohVRmUWZvSkArXCypctljoaq/J4vUD5/kBWZFrhA/M+wWYTQuIDzU4LsLT8T/qWu16rLFOBJ3Gf6G9acylr8IBaBXW0CkmgjEz9iKgQSDp7xhNYEP9wjMsY/KB1Ksu1Nr7NRfYyCyMjJbpiCR9n3c7oeGbHZJcmwSHnyBsqArQBwP1S0oiEuuZdtNtFel1Yh+Pg3bDLO3r7dbP2oLdMzKqqHFGth7gkef8nidCiaKdzlqED1PVfWUtLwHPLeOLuTZs9obahkGRkb4uv/rnmeiPtAtEB22l
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:02:40.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e661cc3a-c515-4312-c3ec-08dc471966f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

From: Ashish Kalra <ashish.kalra@amd.com>

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memboot & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..d4562d074371 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
+	/*
+	 * For kexec use case, we need to use the EFI memmap passed from the first
+	 * kernel via setup data, so we need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memboot & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+	if (efi_setup)
+		return;
+
 	if (efi_mem_desc_lookup(addr, &md) ||
 	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
-- 
2.34.1


