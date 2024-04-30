Return-Path: <linux-kernel+bounces-164257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FCA8B7B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA56428554A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ACA179965;
	Tue, 30 Apr 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eC1lgvtn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31717176FCF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490712; cv=fail; b=Xb084tbANC9bsU8HzCx2WY8PbWbQpyzFsvUM4Ss2jfgtjJ8J5KVh/59Bsw47J6WoNOr//O9BW1bt8fO/D8WENDseKTWm9fA6gYuGISR57M+nw8EeksE72dlN6K1XCaR/F4ILz0vzuRrIr4exJ1g5kUjQKt0vDykpaSeEsPKqFCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490712; c=relaxed/simple;
	bh=3ueA/qx8foO3edffgwwwv62GoMXRH5BIKNhVoPtJD3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gdki/nBEOvNagC2VMJlAAPsRYshDXicyN/TH6e5Bm6KuoOZIKzUmi7N2DxF8E+62YX3NIdVwmEvGhhlwTV9dnnogLVqoYiPoc16bj70ENQ+9tLY8kOIVaHXSYIGX7uHgOGSrXrp3C9k5S3mmkcv+pnCUr0ojc5tVa/4MJ/99Hp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eC1lgvtn; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMM3Z5jBh/0xZJ3Bh0ldLB+L0gxeNLgB9xmCyXunmmwpvvcmCX9BWAW7IjkWNtbazzEjq4CEP7kUj2j5XtmCNyXV4QdA8Ss1AF52HSqZ/+49Z5cMQvFoAO2gmbk5DMS4yxmEpq82e9NKhSzj/65qZiWM5MA4upSDm379BdtIgFlvBrMQrIuo7Fp5pm4pvwdxLxukVA5N7L35QYy8YWpG7eg3adLF232yHryscZrZRR2m5nknVjbQEh4i9rRn/UFMjyPII1Kibj0WQaKieRfaL256nS3khf8lscgC/J5kqCn4XGOqtQxcDb6f3Bsi44tkY1TdXlwXgAGH9+OETeyy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6twXRZcSuSyGe+wMus6aFOt+RerzkaZOxRywtzHOGaE=;
 b=PaM4TZDglWEgyk+ath/EpS5kIigzdc39yq4TbKZnA1jWBSt1sYi9//FjNPUp2gziOIH9Zo+9iXcD0VCeD/gKNYBOP7DfHNyJ5RVbCQYQpHuHYjqL4VIWAA0MKF/2mQcNbrl1KFwDk98eQyu6mGGVT8A8iQbN2nonZ4RZ9OI42j1PgU25mZs9XRHLdgwzsg+8USDGrqz+COX70ma9xoj7KD5zAx9gF79QojlQ+LGanPy1Sw3yqt/gI5tDYIkCyLSInzRkEv66XR9N/hyZj7R34wT98ioIrFIDLMTfbIz6YjuybYvz9Ew3PD0bdB0mYb00yj0mjznzSMXOOVgaQbGnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6twXRZcSuSyGe+wMus6aFOt+RerzkaZOxRywtzHOGaE=;
 b=eC1lgvtnZP/0nNJOwKzLmMGrt14+ppNKH6HysMiCCoCNTbTpgluXEin5ZRPviYGzy5ALlbTu0hB4R4sKLTvhUShQzXZZ73JlHbob2/IypK8Xq1KaISsmVs8cHPx1lSF16470YwWxZLa+dVfdPU9qBJNqt7F7/EV9TvW71jdcOYA=
Received: from PH7PR13CA0024.namprd13.prod.outlook.com (2603:10b6:510:174::10)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 15:25:07 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::a1) by PH7PR13CA0024.outlook.office365.com
 (2603:10b6:510:174::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Tue, 30 Apr 2024 15:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:07 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:25:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 8/9] iommu/amd: Decrypt interrupt remapping table for AMD IOMMU emulation in SEV guest
Date: Tue, 30 Apr 2024 15:24:29 +0000
Message-ID: <20240430152430.4245-9-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 953df129-0d08-46e5-397b-08dc6929b7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IErd6a9zRWkvFpqH4/YeQ2DQuVzvEF2RIsRSUPQ5Pzgc0tWpJVMNylt1PUtg?=
 =?us-ascii?Q?jOLRL58wSmVYGstR0cE6nBh6nWrEqKwU2cl4zVLc5R/Di+NpG+8c1fUwmaar?=
 =?us-ascii?Q?l5A9WRbC6V4xwx7RZuXp6PeNGskRF40fp31V63jH4j/k/0lDLJLWrJi5kGJl?=
 =?us-ascii?Q?R9KtutMBWvZ5yxUnahILZm33uG28AxTrxLPSMDq2O6Jlczi8dc7+eWtZbLtr?=
 =?us-ascii?Q?SDuXMWg72dNCCAj+/l0d5MDYfK5p/e9wI9jnABu3Vb5IdnndUEd5URttrM/E?=
 =?us-ascii?Q?bmBrfDIEMxwC87EzgdHDk+we6pIBPOl9DKjQMtDDwA3fKUxiIw4ApsTvkAvM?=
 =?us-ascii?Q?Wtj0e3eroBEeU7f8tlN50fw3Jb0rIcKBhiIYkeP64eZ7Pmg0VEVHG935m+yR?=
 =?us-ascii?Q?ygjyQXK8GIWBGLv9midQsXGOLcpUw4FPIszr33iUzxkV/NRr6AejfgVFynpM?=
 =?us-ascii?Q?RLr3qUq6oGJPV/DDXRL9LEn5X+BiLdFmVZamMvYY4pAwScBHH1RPQHIUXI1w?=
 =?us-ascii?Q?tWqO5ohObaGoURW8e3nxucxAoBPYE/DwDHpKls1h/sxdhegvBcyTKg3uG/U/?=
 =?us-ascii?Q?+0TqPd6nbgbb1IsKfI/9xaAQZpdVxKlYw2gwOrJlKezOO9h2hWBc7y6/IfUy?=
 =?us-ascii?Q?YDzbcvIPT0EiIYenZicNAsq0IxFn0bzZzkmbik4kB7WjhgEEfTxwOyeafAke?=
 =?us-ascii?Q?B3zKd1xdJ+fGVmSvcRJ17q+ltwEb4TbSykv9+v2o3zBEJQiAyCuEcjGlxpna?=
 =?us-ascii?Q?BhrGn43vU5thR1VzS+KNDz7+X9C0DlOeFGmak+2C6Yn8R1qfdI0ggS+c6cHb?=
 =?us-ascii?Q?/jOihMSxwiXXWEo9/jbStmnchkHZ/clXNoJ7bMtzLdR4RTzxiO8AtC/EQLhr?=
 =?us-ascii?Q?zwrGCMjvNHLmfiG48fsgqToM7xINwziTKSvHjISCeE0TP7yg/+hWBjNDlWYa?=
 =?us-ascii?Q?/rRcweKph52F3n3u7JsgEy3kcSqubqf0SZwSprV2Ldkxf7OcedSIgNFWAENa?=
 =?us-ascii?Q?vDLouhd7KYjcO+gqqnp/Vm4fqoW5LiL76NCnu2LnTl0rZ/yP75LuFEtfvsxc?=
 =?us-ascii?Q?a0mFn1IHxjr9/R2x4BsKJk0j+H4QJZkyiX3hWf1u4jzfwZrEoPivn2DQ/l17?=
 =?us-ascii?Q?xRF5wYgOxqj7jJaE/M86L70bOSpN6K1l627NpZSKtaAcKz8+ysQX2vlOVor3?=
 =?us-ascii?Q?HsqNShomb67gNW/o+MVwR0zMQ+2D1L6Sn/jSsKDPyhCyOi5k2rP1Q45nHUvO?=
 =?us-ascii?Q?JJ/Kl98g8wGhmg7oMQrII9/0prKhkKRCNxYrlUiPDvSyFILf3VwhNDdVCW7b?=
 =?us-ascii?Q?fwYM+/XQvpFe/a7g9HWlYNsn7ZCdJsVSER8X/4bK8mNCjoSQgvRH+8+9l2/v?=
 =?us-ascii?Q?gErPUn1XAihUYrQuTHW1kBRNfqaw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:07.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953df129-0d08-46e5-397b-08dc6929b7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506

The interrupt remapping table must be decrypted so that the VMM can access
the memory to emulate interrupt remapping. However, the amd iommu driver
currently allocate the table with kmem_cache mainly to enforce 128-byte
memory alignment as specified in the AMD IOMMU spec.

For SEV guest, memory encryption is done on a page basis. The driver must
be modified to allocate the table using page-aligned memory, which still
satisfies the original 128-byte alignment.

In addition, the table is setup per-device, which can be allocated with
NUMA-aware page to help reduce IRTE access latency.

Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +-
 drivers/iommu/amd/init.c            | 31 +++++++-----------
 drivers/iommu/amd/iommu.c           | 50 ++++++++++++++++-------------
 3 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8ced34cac1db..980fbb9bae39 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -309,7 +309,6 @@
  * AMD IOMMU hardware only support 512 IRTEs despite
  * the architectural limitation of 2048 entries.
  */
-#define DTE_INTTAB_ALIGNMENT    128
 #define DTE_INTTABLEN_VALUE     9ULL
 #define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
 #define DTE_INTTABLEN_MASK      (0xfULL << 1)
@@ -497,7 +496,7 @@ struct amd_iommu_mem {
 struct irq_remap_table {
 	raw_spinlock_t lock;
 	unsigned min_index;
-	u32 *table;
+	struct amd_iommu_mem mem;
 };
 
 /* Interrupt remapping feature used? */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1b74a31b4337..b3ff89952c7f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -697,6 +697,17 @@ static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_se
 
 static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
+	int i;
+	struct irq_remap_table *table;
+
+	for (i = 0 ; i <= pci_seg->last_bdf; ++i) {
+		table = pci_seg->irq_lookup_table[i];
+		if (table) {
+			amd_iommu_free_mem(&table->mem);
+			kfree(table);
+		}
+	}
+
 	kmemleak_free(pci_seg->irq_lookup_table);
 	iommu_free_pages(pci_seg->irq_lookup_table,
 			 get_order(pci_seg->rlookup_table_size));
@@ -2923,9 +2934,6 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_iommu_resources(void)
 {
-	kmem_cache_destroy(amd_iommu_irq_cache);
-	amd_iommu_irq_cache = NULL;
-
 	free_iommu_all();
 	free_pci_segments();
 }
@@ -3026,7 +3034,7 @@ static void __init ivinfo_init(void *ivrs)
 static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
-	int remap_cache_sz, ret;
+	int ret;
 	acpi_status status;
 
 	if (!amd_iommu_detected)
@@ -3090,21 +3098,6 @@ static int __init early_amd_iommu_init(void)
 
 	if (amd_iommu_irq_remap) {
 		struct amd_iommu_pci_seg *pci_seg;
-		/*
-		 * Interrupt remapping enabled, create kmem_cache for the
-		 * remapping tables.
-		 */
-		ret = -ENOMEM;
-		if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-			remap_cache_sz = MAX_IRQS_PER_TABLE * sizeof(u32);
-		else
-			remap_cache_sz = MAX_IRQS_PER_TABLE * (sizeof(u64) * 2);
-		amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
-							remap_cache_sz,
-							DTE_INTTAB_ALIGNMENT,
-							0, NULL);
-		if (!amd_iommu_irq_cache)
-			goto out;
 
 		for_each_pci_segment(pci_seg) {
 			if (alloc_irq_lookup_table(pci_seg))
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4f95c726e139..f98a10b7925b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -73,8 +73,6 @@ struct iommu_cmd {
 	u32 data[4];
 };
 
-struct kmem_cache *amd_iommu_irq_cache;
-
 static void detach_device(struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
@@ -2998,7 +2996,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 
 	dte	= dev_table[devid].data[2];
 	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
+	dte	|= amd_iommu_mem_to_phys(&table->mem);
 	dte	|= DTE_IRQ_REMAP_INTCTL;
 	dte	|= DTE_INTTABLEN;
 	dte	|= DTE_IRQ_REMAP_ENABLE;
@@ -3024,27 +3022,35 @@ static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 	return table;
 }
 
-static struct irq_remap_table *__alloc_irq_table(void)
+static size_t get_irq_table_size(void)
+{
+	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		return (MAX_IRQS_PER_TABLE * sizeof(u32));
+	else
+		return (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2));
+}
+
+static struct irq_remap_table *__alloc_irq_table(struct amd_iommu *iommu)
 {
+	struct amd_iommu_mem *mem;
 	struct irq_remap_table *table;
+	int order = get_order(get_irq_table_size());
+	int nid = (iommu && iommu->dev) ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return NULL;
 
-	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_KERNEL);
-	if (!table->table) {
+	mem = &table->mem;
+	mem->modes = ALLOC_MODE_GUEST_MEM_DECRYPT;
+	mem->order = order;
+	mem->buf = amd_iommu_get_zeroed_mem_node(nid, GFP_KERNEL, mem);
+	if (!mem->buf) {
 		kfree(table);
 		return NULL;
 	}
 	raw_spin_lock_init(&table->lock);
 
-	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-		memset(table->table, 0,
-		       MAX_IRQS_PER_TABLE * sizeof(u32));
-	else
-		memset(table->table, 0,
-		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
 	return table;
 }
 
@@ -3101,7 +3107,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	/* Nothing there yet, allocate new irq remapping table */
-	new_table = __alloc_irq_table();
+	new_table = __alloc_irq_table(iommu);
 	if (!new_table)
 		return NULL;
 
@@ -3136,7 +3142,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	if (new_table) {
-		kmem_cache_free(amd_iommu_irq_cache, new_table->table);
+		amd_iommu_free_mem(&new_table->mem);
 		kfree(new_table);
 	}
 	return table;
@@ -3202,7 +3208,7 @@ static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 
 	raw_spin_lock_irqsave(&table->lock, flags);
 
-	entry = (struct irte_ga *)table->table;
+	entry = (struct irte_ga *)table->mem.buf;
 	entry = &entry[index];
 
 	/*
@@ -3244,7 +3250,7 @@ static int modify_irte(struct amd_iommu *iommu,
 		return -ENOMEM;
 
 	raw_spin_lock_irqsave(&table->lock, flags);
-	table->table[index] = irte->val;
+	((u32 *)table->mem.buf)[index] = irte->val;
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt_and_complete(iommu, devid);
@@ -3358,12 +3364,12 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
 #define IRTE_ALLOCATED (~1U)
 static void irte_set_allocated(struct irq_remap_table *table, int index)
 {
-	table->table[index] = IRTE_ALLOCATED;
+	((u32 *)table->mem.buf)[index] = IRTE_ALLOCATED;
 }
 
 static void irte_ga_set_allocated(struct irq_remap_table *table, int index)
 {
-	struct irte_ga *ptr = (struct irte_ga *)table->table;
+	struct irte_ga *ptr = (struct irte_ga *)table->mem.buf;
 	struct irte_ga *irte = &ptr[index];
 
 	memset(&irte->lo.val, 0, sizeof(u64));
@@ -3373,7 +3379,7 @@ static void irte_ga_set_allocated(struct irq_remap_table *table, int index)
 
 static bool irte_is_allocated(struct irq_remap_table *table, int index)
 {
-	union irte *ptr = (union irte *)table->table;
+	union irte *ptr = (union irte *)table->mem.buf;
 	union irte *irte = &ptr[index];
 
 	return irte->val != 0;
@@ -3381,7 +3387,7 @@ static bool irte_is_allocated(struct irq_remap_table *table, int index)
 
 static bool irte_ga_is_allocated(struct irq_remap_table *table, int index)
 {
-	struct irte_ga *ptr = (struct irte_ga *)table->table;
+	struct irte_ga *ptr = (struct irte_ga *)table->mem.buf;
 	struct irte_ga *irte = &ptr[index];
 
 	return irte->hi.fields.vector != 0;
@@ -3389,12 +3395,12 @@ static bool irte_ga_is_allocated(struct irq_remap_table *table, int index)
 
 static void irte_clear_allocated(struct irq_remap_table *table, int index)
 {
-	table->table[index] = 0;
+	((u32 *)table->mem.buf)[index] = 0;
 }
 
 static void irte_ga_clear_allocated(struct irq_remap_table *table, int index)
 {
-	struct irte_ga *ptr = (struct irte_ga *)table->table;
+	struct irte_ga *ptr = (struct irte_ga *)table->mem.buf;
 	struct irte_ga *irte = &ptr[index];
 
 	memset(&irte->lo.val, 0, sizeof(u64));
-- 
2.34.1


