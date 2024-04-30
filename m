Return-Path: <linux-kernel+bounces-164253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2378B7B66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC5B284F05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33189174EF4;
	Tue, 30 Apr 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1J23oBaN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA817333A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490707; cv=fail; b=RYSxnA+fIMrqVUfgD8uxZOfkQcH0chgwS+pyyCMA9BhdITKLgv6+4CNon5VDeW6v2OPccUEi5LKL0bd9cIdEd2tqFNzjbaXYsKm76VqQ8Mglz4n3YEV+xFd4slar6MPYBil0xl3JtM+VrrmN45rM3gz9OZA8/IlK8hwue1LoGB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490707; c=relaxed/simple;
	bh=cOcA9DqOxPaKR1OkxPkECu9CH8Jj255GeHsMCmYd24k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exJfHJ7d1rRqgKtQt1UhY6JueGFdYK9ohFtxQ9G+bfex2IJW+AOy18EWxmfS2Tk4NW3ewKQQ3+nVJUzUorxqgy0Y5BTKEP6OsirPRDmIYw5SabgFNSHqkW0fmSZ75nV9Di5MFBIHQMNTi/I0tI3YQneiL7TtryNnsIQUeaDXP0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1J23oBaN; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKJESi9fwn0hIAFCTzyJhRl0q0A5rF5FMCPmg5jJyMzzGQzYBppOhlJI0RqQKbnOqzRC/wz72eFJyQcobCShQQU94QbhvLNVNoCCRv0ljqdY0gU+729har+hU89yXM+r3GJJrCVmz4zA0J6VtawTTZ6PHAk+6csdbheUtBC8GrTlX79LBVlb/qniyLn50bKgv43gbGEINUiUzsumjk5F+aIGnhnmyA1YJpVscRNiPzjf04KaiAcuZBEFXpTMDz+uKBZdTzXlGgeJiyclLk5YeMhcVX1rhZboR4JrsJ4UNi8sa49JVEn51WedpU3bUNUrzTG4VSu8E/FlbFjNwX8IDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeUIfms4NyK/L1REOCI4006KhUoJrcQYrKvPsIxuP2k=;
 b=NBcBtfUZmoFJND9Ohw3mzjuT/nNjnn9+2C7/+9Q1RwPTP5AsVVpLlpH+gg4ekVfHaOVRmaohr4N1ikIHwkTGTDyS1LffaI5PI8lE0E5PlFBQYeCFJMxNq/Ry09FLoM+DcrxyULtYX2sWg5JjPUZtw7sOI7o6ogB24tyOiT9IEx9ar8nLgdgd3uPfaPhsiJYoBAvbMtd3EKd+PL1L2/NARH7mUhUSjOnTfoOmis48dmYLjCF07QweZ/Dy/5i0XIJ8RFER7UaznpUIJHGbUfuP5cj+DQLGxOlTgOfLCiJAtNvc4ncnOC7UeR1afCUE2VN5QdgbY73hCS31cETLw3ym8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeUIfms4NyK/L1REOCI4006KhUoJrcQYrKvPsIxuP2k=;
 b=1J23oBaN4eL60UNpAZsiB7SGpbPyjcF9gWpl7tWHjEBt1utW5Xuxub5QXwlAkJOELQxDAkMR0YZbBJqt6AlwpnWLL6blozG5DclR6HEMM4YQ6RDMy44QkoHtaddd7LSTdf3u0iaeAasj4MWJPqo9bgB/mhI1j4pIqSKojWXNxls=
Received: from PH7PR13CA0004.namprd13.prod.outlook.com (2603:10b6:510:174::25)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 15:25:03 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::a9) by PH7PR13CA0004.outlook.office365.com
 (2603:10b6:510:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Tue, 30 Apr 2024 15:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:02 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 5/9] iommu/amd: Convert Event Log pointer to use struct amd_iommu_mem
Date: Tue, 30 Apr 2024 15:24:26 +0000
Message-ID: <20240430152430.4245-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 236f8648-94db-4546-8226-08dc6929b4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bp7c2/5WfNk8L70yt68pHJZeh/R9fk6k0ik3azzCyf2X+27OTlD4LUdisTBB?=
 =?us-ascii?Q?SkohgD09E4FQ+UDvJEk0NRTjrco/kCNszPnXiXFlqcQ+ODjp82knulBzCXrM?=
 =?us-ascii?Q?VWpJvzrDCq5tRMMkVbTkSG1KGDHovrvQnldtCotDkO7fXhGfAPocqU0rM7NO?=
 =?us-ascii?Q?yvSoOu0cYOUN1xUarf1ex4oDt0HbgdPABvrWIXq6ZR06ZWHxS9lLbn3MoS1K?=
 =?us-ascii?Q?c3lWPEYH9gWRr+r7NNqpXrMZ6O1LdV2gmGzCnmsIj/IroKbH70r+3MdBKBqs?=
 =?us-ascii?Q?WsmSN81VUQ2IOd+5e9NxeiwpyDJeHv33xvYa4PB1UGMDAHiepA7RjB/WVgMP?=
 =?us-ascii?Q?0lSRwQdRmws8/AyPrImVTWbtkBulozkqTLWFmIDoTp/ZAXChPXruTQ4HX56K?=
 =?us-ascii?Q?zKYYmIBrZqKgfJetcxz8+FW3O4cJbRkjRpzrqlGNvzYzPA0piHyWfV5r3qoN?=
 =?us-ascii?Q?EzeDkJOibQanrpI51KE1UWrf4tYPNurv6xiUOTe3+r0JLqNfkQXJ5Y5wrd2x?=
 =?us-ascii?Q?7Gm8epmKpvxvoI0zpKHx5rlJVjlDYIQR875G4XG+RDMpRUAdCFZygmumClMI?=
 =?us-ascii?Q?TmfhKdxUtdadCMoJAUX9lLDtq1C3SX4ddWSFpkU8rPzcMBpRNTa9oqzM1D9y?=
 =?us-ascii?Q?YPuhawZ8qQ1r0ZpKt7okofo/FDHa78C/pPUtn/U3zU4naWykL5DvW7ITfcFr?=
 =?us-ascii?Q?qjlbaD+VXpx4T6muAiq5PD1SnEAZnG2JjuhoJ9MT0eMuMzu3UnsSRyYOQ2Yy?=
 =?us-ascii?Q?0to2vPoJwD+RuP1uabHwiH23+SaWwaSaqHWbXhK8DuBF77gYg82S/a2dXqaY?=
 =?us-ascii?Q?8rZTKaGhKQZtCNXxbatNVHV0Irhwiy3st4q6jL2quMd43AZcl1hr0wY61p02?=
 =?us-ascii?Q?7+CnTBeEIf6mmJhn+ZgI8wUZZ2QJIfYOT3we73ZvNexsNnGGnMk1eQNzPeYv?=
 =?us-ascii?Q?68oADb4muU+PVCNnhFVbsRCd0nDK+MY2YaelxqXyvjcigUn4qGQ0FLyX6yIL?=
 =?us-ascii?Q?0MbX5gWxHV7GhPw8bBzuOfhU8ivPkUWkdpY1RCgNK64u62eyS9hAK4awmK42?=
 =?us-ascii?Q?xDa774hFJxdBhGhb4UUpWo3dZCwd/3elanR2lBaj1/nXSBiocjkH8xM3b7DC?=
 =?us-ascii?Q?gRxFb07uQ5Qga9DDMMeWARuE2pfXq/+dngMtmXVD3+JjBPYAfrWwve3coosT?=
 =?us-ascii?Q?66iKYC6p9+K+CE1EfH96VayMrTUSYhMAZvsAP6mgpW3Xd+peleLZJrfBMMyl?=
 =?us-ascii?Q?ApLAJKsStUy5IKijpOSiKAdT2qawqV29S/ny4tiWve5UYTBGJ0lg7Ba/kx1D?=
 =?us-ascii?Q?1Jnv4UXT/ondR4FUTX56/L1oyEHvgjoB46fZkthjyuiNT+wIXK2zCwtj+l0e?=
 =?us-ascii?Q?jPGI7tGtDU9LIR85TLUvnCvMyzUu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:02.6314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236f8648-94db-4546-8226-08dc6929b4c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

And specify the memory to be 4K-aligned when running in SNP host, and
to be decrypted when running in an SEV guest so that the VMM can access
the memory successfully.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 20 +++++++++++++-------
 drivers/iommu/amd/iommu.c           |  2 +-
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e671e9220a21..af4e9ca6414e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -738,7 +738,7 @@ struct amd_iommu {
 	u32 cmd_buf_tail;
 
 	/* event buffer virtual address */
-	u8 *evt_buf;
+	struct amd_iommu_mem evt_buf_mem;
 
 	/* Name for event log interrupt */
 	unsigned char evt_irq_name[16];
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 51861874656e..5242a9a16946 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -860,19 +860,25 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_event_buffer(struct amd_iommu *iommu)
 {
-	iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL,
-					      EVT_BUFFER_SIZE);
+	struct amd_iommu_mem *mem = &iommu->evt_buf_mem;
 
-	return iommu->evt_buf ? 0 : -ENOMEM;
+	mem->modes = ALLOC_MODE_4K | ALLOC_MODE_GUEST_MEM_DECRYPT;
+	mem->order = get_order(EVT_BUFFER_SIZE);
+	mem->buf = amd_iommu_get_zeroed_mem(GFP_KERNEL, mem);
+	if (!mem->buf)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static void iommu_enable_event_buffer(struct amd_iommu *iommu)
 {
 	u64 entry;
 
-	BUG_ON(iommu->evt_buf == NULL);
+	BUG_ON(iommu->evt_buf_mem.buf == NULL);
 
-	entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
+	entry = amd_iommu_mem_to_phys(&iommu->evt_buf_mem);
+	entry |= EVT_LEN_MASK;
 
 	memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
 		    &entry, sizeof(entry));
@@ -894,7 +900,7 @@ static void iommu_disable_event_buffer(struct amd_iommu *iommu)
 
 static void __init free_event_buffer(struct amd_iommu *iommu)
 {
-	iommu_free_pages(iommu->evt_buf, get_order(EVT_BUFFER_SIZE));
+	amd_iommu_free_mem(&iommu->evt_buf_mem);
 }
 
 static void free_ga_log(struct amd_iommu *iommu)
@@ -3838,7 +3844,7 @@ int amd_iommu_snp_disable(void)
 		return 0;
 
 	for_each_iommu(iommu) {
-		ret = iommu_make_shared(iommu->evt_buf, EVT_BUFFER_SIZE);
+		ret = iommu_make_shared(iommu->evt_buf_mem.buf, EVT_BUFFER_SIZE);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bd29d26c8d44..4f95c726e139 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -890,7 +890,7 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
 
 	while (head != tail) {
-		iommu_print_event(iommu, iommu->evt_buf + head);
+		iommu_print_event(iommu, (u8 *)iommu->evt_buf_mem.buf + head);
 		head = (head + EVENT_ENTRY_SIZE) % EVT_BUFFER_SIZE;
 	}
 
-- 
2.34.1


