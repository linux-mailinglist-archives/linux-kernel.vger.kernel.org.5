Return-Path: <linux-kernel+bounces-132240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362A8991E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0671F22E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507513C3CA;
	Thu,  4 Apr 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KXj4ZEdQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC813A41A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272277; cv=fail; b=faTktIMooOTaoV2CUisCv0ZCrhGxSZX2VyAb7o8Cuhb2JjbLx027ysxjbdLxnSUz/AVMu7X1WUh8Tn9tW5kUbDx41LnxXUMBur7fRcdail+o9c8u7fQY3PC7uHKgxmKjD4jENTXFx4Rka1VmNCF77lhNqkI1wZ75j69TAxo1TCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272277; c=relaxed/simple;
	bh=Gjxon9CWAl1E5KONmZ4XO223NbadHZMJVryA/SxMQQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REjxdL5Ui6WI1kMy4v8xfn5ESjsMU1tXvtwUaCOsHBr7rziIIK9YWHxWGfY9mkXedK0Mn3y3JKCi1zpQvRCq3t3XsgDpofQfGaJVC/C2eEZSoxaPN1C2WwFugvjM5gAxA6Cv3YqzoShQk0FTdY4FqW4e8BTdhdhzZHDHu1jVCxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KXj4ZEdQ; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB4qIXfHrBc2x/FTnH7mVknfdiSoe2viSgKcxtLG2La7hmsJVd4hO/HMIiaOpLNZOHZ/NgGIC8eVh4d8Y1VBa2LKR2ps/8nbo2fu9MwDanhOdGTME1Qvm0fwIdgMOGL24Cssa/9MGajgVDvB3DgtebMNm7LBgkxEjUW0CcRJl2vRjaf4QbGR0TsXnfZ4dLWqmc1S18Xw5V1FVisn0UcwuTNwJ3pMgUBwlXd1yxVOMVxyFeHv3MF2daNG3mwE4u1JlP+BlqyE7C2CBDidSQiePPwNpYUv1ppmzxsnva293FakLqaAgKooYhiB0LJAMjJMui+z9LUtmiNO6eO4e8DIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynAjWB7gpOag9jprnm17/CfhdBBqZy7DoD35EXOrrdk=;
 b=dmS3MvYEjAppB0RlMo1yXz2qobnCn7I3B+jB0alg0TA0YoZkWGzDBZjr2c9eGFbaiP8/E21BYiU0xqJaFuUiyeh5tkdte3qJVGL6JeOo2uURTVcT4yRjeeP6f24RkEpXu4uW8n3H+CDOCAws8YCsOoBD8LDfGAJNw3MHaHZliHi5/Rm1rcxRtVaWdk/yiJzfw5Py1v1MprJcFUnJ4nDrKmhM9//njZ2f0HrCD28RqFtZdpzHC/780oUSV1LsL8fREq7ta7QssYfup0ez7c+RMf6XepzQglOccBzAi8UOxeODCDvizAx/WX5MtXxtLRFCidxB8SHSzG+HFI0hzSEaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynAjWB7gpOag9jprnm17/CfhdBBqZy7DoD35EXOrrdk=;
 b=KXj4ZEdQjzjHWWIw3hS5LqlthcSMo+naOb4QrRjFQxGgHyi+cEclu9kK5Ycqb2yuL5FU0eVBd4AI7DJPOaESS+GsMsJz6GI8YNxvkYYC5dDyKdvaM/OvlptyTbsG6l9o1Xaon85gob+PFd1BDwunys3F5u7V73F10zcqoFokX0U=
Received: from SJ0PR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:332::8)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 23:11:13 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::43) by SJ0PR05CA0063.outlook.office365.com
 (2603:10b6:a03:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27 via Frontend
 Transport; Thu, 4 Apr 2024 23:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 23:11:12 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 18:11:10 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Thu, 4 Apr 2024 23:11:02 +0000
Message-ID: <7ca8179d7671a149f2808d8d081b6e736eea4394.1712270976.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712270975.git.ashish.kalra@amd.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com> <cover.1712270975.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b75396-7eb0-4a75-c2ac-08dc54fc856b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7AbpBgcW/J/53Svp3WQMND/H03elYhI/XKSN/zgMsN5+CoiuCNVa4IaKk2irsF4lf7ZAPBRAn7gyNK9UsumUzlqWVIiz1WhTPblGjK4pCY8dzAffb6gjl0RQ6qNlTED6dF/lTKnjRR3CFomBQ2PAOtnxOxsvYIR6ptHWWG9sfuFZYCu0i/wPjbDRs5a0l+g794DK8PVIMmcppNhcw8nemBqReMHLbiCMfeHjqcwzUOxr+X9+rvt+634iQSZOkQWiUGbMBO7UiMd5b3/PFoh6mBgft/I3Hlq2JC66w8evvQQSBCBN31K3VtY6ZQZL4xT071MVDHmTE1XkUW6PPqObDs6FamES06M89yUZFY5gVA2W28o37cJJzMg4yCX/OFv4roU0q9UUINxLTTLl/rTDEQ2jcGX1AutCYVBA+e8Q75bWNuPMQKIPRhxvRUReE2U7tU/DyjXaVS3U1nX6Agol1mGHq+BwAWf77Kh1238L3glymZ6fhsZCI7njGKzSuMzDITl78EGWdB3Mekw9gAGpwqbQlUKLIGXaiRHa8bqA6JDDDDWnfwfheztYdAaP1s/6N6WiIRh4kuQL7oYOY9IAa2WwueCuoN0AkWd/r0LihbaMgTl3SUBWMa8gXv4K1K6MDVJIiiU+sr2p0QyqQb+Wd9PXaueLFtzSxajiWTkpOdmuFkpsK0mHaKxiBZqmcakBoUdD7lfIEFemW5i1WvXAmPqYYjFJ8E7w0hjS+XStrQQvVQcU4smNdcPQ7BBVAhwb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:11:12.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b75396-7eb0-4a75-c2ac-08dc54fc856b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

From: Ashish Kalra <ashish.kalra@amd.com>

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memblock & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Suggested-by: Dave Young <dyoung@redhat.com>
[Dave Young: checking the md attribute instead of checking the efi_setup]
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..2b65b3863912 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -255,15 +255,32 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	struct efi_memory_map_data data = { 0 };
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
-	int num_entries;
+	int num_entries, ret;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
+	/*
+	 * For kexec use case, we need to use the EFI memmap passed from the first
+	 * kernel via setup data, so we need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memboot & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+
+	ret = efi_mem_desc_lookup(addr, &md);
+	if (ret) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
 
+	if (md.type != EFI_BOOT_SERVICES_DATA) {
+		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
+		return;
+	}
+
+	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;
-- 
2.34.1


