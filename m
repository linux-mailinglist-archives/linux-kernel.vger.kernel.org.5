Return-Path: <linux-kernel+bounces-164254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD348B7B67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D797C285252
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB2174EF0;
	Tue, 30 Apr 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GXkeyFk1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D8173359
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490708; cv=fail; b=sOkV7NUV7M7IzyZNnPrnUQAsTyYHoUPcxbf8mapRhfQu4NtcxMpMHOg6TSPlnsWZYbk0XK68FJJLyQfdLhKt3oK6B9rmtT+Q85v1GrJJMW/rlUtf6VtQiAjBvtDtjtJ9/SQstSm5eGbsy+CFmJaXEPCJZ3VRRPbRmNVdmeWt62Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490708; c=relaxed/simple;
	bh=8/uqFCVlXMA0L01Qk2shlzFHnOR1ZzabUpe8hy9jJK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ii65P9sjaDBMItTxmiezdEW1yT9TbAFkJXoJYn5mC2JEHl76j612kyigO8mFhtu6Mb3HGIKHNymE2BTpi5wGj1kUl51hg1xPhVK23Xbt5aXv64BzDvMJIbw+LO8/8pkufmJ1RqdhZdnOlYhZPIF0Pc1BjaD/fjsqRe/0c0norbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GXkeyFk1; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRHQh14SDnSX/Ir8kYRKDicti5FQv6rs8+swMALTcGWFgd68Z7TJyUJgRYmyzwEJi9iAw6C9NFKgGdkWK/YPLkQvCeu/l/GPO6gz6cXUcHZydnD2roo7CBLb8j2hlw252/CNb4hLHMb7G859fYghcNIRnHVYFtpyuzhmuLzN2yDT0h7dJbzFgzAnRMDTCNKv48oc+oBeP5ESr8nOVLhl36sJFk1bEf69e4yreBwffY9+v3a8q7DGB35lH1DxojTiF1BbpZKx5FNlge09OCvcJTXf91S7C/YklsFPk5eeVIvi3fyitD5oZDqvEodkohsHN9eJmOtDawr4FhF/pmNAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbiZDh/plK7kfI+sYdgQBPI9Mei+PWXCGD/Y4FwpWzU=;
 b=NuhUfGLgN+GrU4daTjhsLrgKLO9rYkktkUPThlwJw9rfjcxkk0lxqIG4KGn8eDMXlpU0ePLN/79dHNLpmU+ocgwwx0PK3t8qjSvaj86iyHZWuV61k8kp8NRgGWydotatclkanr7ViXkODTcDzFXsvhvE4hRVN4i4rlBsbdpBT3wW7pukbZ2FTI60sIs17lYhMxGMtOz5o1JCAv1pOgEjW/cEc/zrXI+c+ZxGpbT2kk+qMJcKr+Mh2ILFLMElTh67SyaOlBCZ3sEapatjajw76O2qVezL5oaEJTajHfDQznA4COJzPjX6GR2/tTM59VCwrlhfaeXcuc+h1M6HbvzHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbiZDh/plK7kfI+sYdgQBPI9Mei+PWXCGD/Y4FwpWzU=;
 b=GXkeyFk1LMrksvZy1vkhPTeI3+9ZwT7PyacZQlmMFgEmaQUQKXKov8k8/g/GvxdJcFsllE7mznYOYhXqi1i+3aIbxqdD9LSvlRiG2pu7XAY1maLVv84uJmsedTI4ENM0cvJRAywKQDno+NwBn7iCy0GteERzLMe5p3P1rsaZGtI=
Received: from PH7PR13CA0015.namprd13.prod.outlook.com (2603:10b6:510:174::21)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:25:02 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::2b) by PH7PR13CA0015.outlook.office365.com
 (2603:10b6:510:174::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Tue, 30 Apr 2024 15:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:24:59 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/9] iommu/amd: Convert Device Table pointer to use struct amd_iommu_mem
Date: Tue, 30 Apr 2024 15:24:23 +0000
Message-ID: <20240430152430.4245-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 320fe08e-c88f-4353-7359-08dc6929b2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iugVqbugoynX587/0qGxSdLAVn7U6AmGGVTnQXzXBc1Q34DAEwI11iVojwnX?=
 =?us-ascii?Q?ahxtj8tdVrKjasfPXNIOgEPUaycfrtY7zUvqfMhhzKMWb19j1JCSPdPCHIsm?=
 =?us-ascii?Q?MCIotGtr9sRj3RTLuHZneXMk1c0GxrE67XusDpcaDID2h4RanclHnyc66gt+?=
 =?us-ascii?Q?OWGYzVY3IPP/HwbpHc6MMTBr8rhVDopYjRzZ+ciA3q43CqXMHUjl8oJPKuv7?=
 =?us-ascii?Q?h7wbRgDcE6ne8ajKfYvYEIV9WbewGAv9oRGeopqBrHrjGlXOs/4mQj4A8tGP?=
 =?us-ascii?Q?fOhKhjgFljyL6duhZ3Fc2fZE70Q00Had0wjNQF2zuFaXhu8ZcEBDKnqHlBnc?=
 =?us-ascii?Q?9vY3+n4Iis8EKV5ZZObPtXT44byKORkbfaO4CltRMtEYPFvMmL/5Mug2lKr3?=
 =?us-ascii?Q?u1gbsywfFuvXr4myjC5bgA2BcSl0al7Ei3QiyI3HjFCYv6aQW2lauy7K3qPt?=
 =?us-ascii?Q?D/5fM7onm2Z3GcVfiClODJ5ESL1IrKuWlwSfQBq1FKbkrvNnn9e2o9gsOmFV?=
 =?us-ascii?Q?+ECz+r/2L5avYKUtCwVzwZc7G0k3c8FGd6vpJ6IReTh2Ad9jgB1L368jzrUs?=
 =?us-ascii?Q?hp3B1lQXRTtoo8N8M3gN0M4OY/I2y8fuf8nuqsrOnk95LXMOBvjs+RwYEWgO?=
 =?us-ascii?Q?0gPzgmGfDhQZ0t7Io9pSkwtl3pFy60Pyso3meOICvZXm2rMTzMwv1vS6NUhd?=
 =?us-ascii?Q?9Y5X/8OwBugHKnUxI3+RksZERLv9g2K4/DwNU60zhW2dT3AtdFSDtFo6rPeo?=
 =?us-ascii?Q?GIbuzrTDoLrP8kD6oriZCDeTNlI9cXJWgAHOwgEp1IqOZS+Pp2YK/CXHV5A3?=
 =?us-ascii?Q?+nxyIyuPSIwye/bJ4FGRYScQXBcGikYG+Iy0GyerQuEucKsv9x05czMHjoKG?=
 =?us-ascii?Q?CbL1UAgmn9iQYd0hM3JmCbcSJijGNlNAvK7X1dJTQsCTV2uainoYIvLwwZXB?=
 =?us-ascii?Q?8bZBd+rDWxaUggnnVyuzkA8N5zIssmBiNHDEb5IoWRL3QK84i+TAJ+kci79k?=
 =?us-ascii?Q?CFbWd/gn8Z1TA/yAB/L9HEA9DPYngyBuG52ld/eQ4n+Qq+nKEUfrFgAwndS7?=
 =?us-ascii?Q?eTX2z9Joe/jfwEBFXVvqvaykx1qoMsnl0yIg1eDPZM+cwEwOdeSO39JfUlzU?=
 =?us-ascii?Q?hEWp/QExqEKA3aXK7KCztQ4uo0qU93MOQ/2U4+6Q3L+MJBeg7NNoplaVJ2Pc?=
 =?us-ascii?Q?HNodFcSdbss4yF8awjXE0deTV+ezKdJhjzABLjrcOMk6bhkFYoL+WFgN/LV5?=
 =?us-ascii?Q?lhSy/X2EeW/xCXgfraywUZbgJasJjIDwQIrbCwbNx2qw1LaAUSIqO1MbpAb3?=
 =?us-ascii?Q?/37cwFZYIhrkXs6DdpPMfuwA6+nU+UaZ/4+stIRcdjTNEkwbbPWWRSXER3GO?=
 =?us-ascii?Q?TDn/Lbq+o/XndmzxgSVQlN09dinA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:24:59.1157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320fe08e-c88f-4353-7359-08dc6929b2b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

And specify the memory to be decrypted when running in an SEV guest
so that the VMM can access the memory successfully.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 26 +++++++++++++-------------
 drivers/iommu/amd/iommu.c           |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a42e10777922..d9159f2e3f0f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -638,7 +638,7 @@ struct amd_iommu_pci_seg {
 	 * information about the domain the device belongs to as well as the
 	 * page table root pointer.
 	 */
-	struct dev_table_entry *dev_table;
+	struct amd_iommu_mem dev_table_mem;
 
 	/*
 	 * The rlookup iommu table is used to find the IOMMU which is
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5aae03d24e2a..c68ff602d534 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -409,11 +409,10 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 {
 	u64 entry;
 	u32 dev_table_size = iommu->pci_seg->dev_table_size;
-	void *dev_table = (void *)get_dev_table(iommu);
 
 	BUG_ON(iommu->mmio_base == NULL);
 
-	entry = iommu_virt_to_phys(dev_table);
+	entry = amd_iommu_mem_to_phys(&iommu->pci_seg->dev_table_mem);
 	entry |= (dev_table_size >> 12) - 1;
 	memcpy_toio(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET,
 			&entry, sizeof(entry));
@@ -650,9 +649,12 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 /* Allocate per PCI segment device table */
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->dev_table = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
-					       get_order(pci_seg->dev_table_size));
-	if (!pci_seg->dev_table)
+	struct amd_iommu_mem *mem = &pci_seg->dev_table_mem;
+
+	mem->modes = ALLOC_MODE_GUEST_MEM_DECRYPT;
+	mem->order = get_order(pci_seg->dev_table_size);
+	mem->buf = amd_iommu_get_zeroed_mem(GFP_KERNEL | GFP_DMA32, mem);
+	if (!mem->buf)
 		return -ENOMEM;
 
 	return 0;
@@ -660,9 +662,7 @@ static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 
 static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	iommu_free_pages(pci_seg->dev_table,
-			 get_order(pci_seg->dev_table_size));
-	pci_seg->dev_table = NULL;
+	amd_iommu_free_mem(&pci_seg->dev_table_mem);
 }
 
 /* Allocate per PCI segment IOMMU rlookup table. */
@@ -2570,7 +2570,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 {
 	u32 devid;
-	struct dev_table_entry *dev_table = pci_seg->dev_table;
+	struct dev_table_entry *dev_table = pci_seg->dev_table_mem.buf;
 
 	if (dev_table == NULL)
 		return;
@@ -2585,7 +2585,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 {
 	u32 devid;
-	struct dev_table_entry *dev_table = pci_seg->dev_table;
+	struct dev_table_entry *dev_table = pci_seg->dev_table_mem.buf;
 
 	if (dev_table == NULL)
 		return;
@@ -2606,7 +2606,7 @@ static void init_device_table(void)
 
 	for_each_pci_segment(pci_seg) {
 		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
-			__set_dev_entry_bit(pci_seg->dev_table,
+			__set_dev_entry_bit(pci_seg->dev_table_mem.buf,
 					    devid, DEV_ENTRY_IRQ_TBL_EN);
 	}
 }
@@ -2778,9 +2778,9 @@ static void early_enable_iommus(void)
 		pr_info("Copied DEV table from previous kernel.\n");
 
 		for_each_pci_segment(pci_seg) {
-			iommu_free_pages(pci_seg->dev_table,
+			iommu_free_pages(pci_seg->dev_table_mem.buf,
 					 get_order(pci_seg->dev_table_size));
-			pci_seg->dev_table = pci_seg->old_dev_tbl_cpy;
+			pci_seg->dev_table_mem.buf = pci_seg->old_dev_tbl_cpy;
 		}
 
 		for_each_iommu(iommu) {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 05e967ad7032..3df07e8ef002 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -144,7 +144,7 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	BUG_ON(pci_seg == NULL);
-	dev_table = pci_seg->dev_table;
+	dev_table = pci_seg->dev_table_mem.buf;
 	BUG_ON(dev_table == NULL);
 
 	return dev_table;
-- 
2.34.1


