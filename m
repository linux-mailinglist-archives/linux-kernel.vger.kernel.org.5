Return-Path: <linux-kernel+bounces-157244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420438B0F30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2AAB266C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DBC161310;
	Wed, 24 Apr 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZ77HPPT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2D15B158;
	Wed, 24 Apr 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973760; cv=fail; b=SuCxA9BBPM04O12CG7t/KmvjTpFZurRlD4oqhv4x75F4CoV5Bb+8PxqOYJWc424iLCC8Y2iK9Y9qsxlfqtWQ1IkdAkttY3nyApow388ItSDMD6iLwSQfO2A32WBLTjIxrqXC/hVBdgwk/BHl9Kwdy/Gcc0LGa4ERWLUV+BBUTjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973760; c=relaxed/simple;
	bh=ryIvTGaKwLrqKTHCwTIriXWr9WIeb7OGpLLqzdmsKlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbhWXLFmFfXLQMIRQpyF/zRUrQ9PPDcrJomsRJXrnDtlb8KiXr1dGWcqZRfc9wgBghIfYDCaapcULvtfF5yXka90vlrKT+8S1iGcp1+RCNJ7kfkJUPUcuua1mdVsnxQmCieoQr8Hgz9/BpxURCYnEsE+xP6l520MCDRRtx3V01k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZ77HPPT; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXjQ8FdJ53y0jyD8rPuWz5wR02jV/BAq/AKeru4URGWH/RTqYKHfeN1ZFWSPASHQLBO+T2E9WOu/omtPt9rEDe1izm21f2rOYMsy6ewo+vFatXmna/eaoHEwWYJcvPnufpterbLbUSh/LgFWnrjk8+erMPOqjHq6Lp2VJIJaMP+LtsiH5FIEn7bgkp8T0v+v9R6OflgnbwvPHQ6ZjbLHAi7/1+/9Cmu5aupQRiray5GlpGn1dPDGAPiuslgLpbf734Eu7U60q1wJZ+egHOXQtXQtnt9eIVTDnjguv61BtIn5YSNUOxry1hMW6WLbwtmpQ2G9FayFtAKXcLquAgl89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cr09hc8g7GLfv5BRixzfJAo2HFsjgg0Zq6vMKGdUGg=;
 b=l1QYbLDFEYpbMt/d2se+6XP3zpnlgu2pMBbW5D7oryyzSVwPY03Nhipvr2LaZSSV3pFZBIeOM8xQtsFep71sWqiclmc8fSDFQ07kaiY6n7jsIWpat/RatLLVVDb+nrOd915mjM45sYxZskJQfwW3j8H3eu3jUkWoSM7JFYygW6oApjmZmkf70Vkv3CJh2shPVspiwhqY+i9PR1m+erKmg6aIkchQ2lszQq29VqA43u4HcTc7rrmHBspZ4qSH3SJtv47/oZGwbyNgwz0AFUSGEg8Oc4l66KczJFhmOPlNFv/RRNTb7brzo7utcuP1eoVa6uUW4llzWMfPrswxkqKWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cr09hc8g7GLfv5BRixzfJAo2HFsjgg0Zq6vMKGdUGg=;
 b=iZ77HPPT+93qMk7WlPy6iIRksNjrqIym5uw5X5uChbpc52KIZzDiaDEXgmsMQ/eFj5wGQD3YBdHwOMoLIClRrlWtQ4k3rNcYXzuGDfxsq59UOXICnNni740SoRUulrSZs0OM6dfyeDDD3frWxsNdbkXBVTN7pwrgEs7ui3PD9+0=
Received: from BL1PR13CA0446.namprd13.prod.outlook.com (2603:10b6:208:2c3::31)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:49:15 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::a) by BL1PR13CA0446.outlook.office365.com
 (2603:10b6:208:2c3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:15 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:12 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Robert Richter
	<rrichter@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v4 2/7] x86/numa: Remove numa_fill_memblks() from sparsemem.h using __weak
Date: Wed, 24 Apr 2024 17:48:41 +0200
Message-ID: <20240424154846.2152750-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424154846.2152750-1-rrichter@amd.com>
References: <20240424154846.2152750-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 827809dd-2ed1-421e-54e8-08dc64761823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400014|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?js1asoeQ5iBYpRVsryVPBMEi8I5uxrchDnKYOP3RfqLzNzZKWq7wlytWKgKF?=
 =?us-ascii?Q?P+h7op1xfhVAijaSrHnfSwWUjT5l/kd3iAa7yIo99fGGQgkxPPtZqPgOqAH2?=
 =?us-ascii?Q?k6F4zyIAHipunSpIUndzzlLyVDXNb9UgFILfeTUQlOr2DilJgY7RtK1zYi5V?=
 =?us-ascii?Q?YuCVu7t2YB/LldX8dz6xT6XdAy39JDnxHqaLD17J59EiY/OYTECHpdPfHYJ6?=
 =?us-ascii?Q?eXrLLSoTIYRRTY2WYVsCjc2L6fJf9sWUycnarjnOEL+wYtwFWuyWwjTAzqO3?=
 =?us-ascii?Q?T3bwDkGWFo0kF9EjbnItwy2FVQILG5rppSNbRDqwrr8stcBKsvphjhlJl+Ry?=
 =?us-ascii?Q?2DH4eeBxcFSnd/hi/M55Urn/Gj9MGzeLgyEPIc6apG0IBq2lpExTG5QAj/+j?=
 =?us-ascii?Q?OtnTF3zJqoFJfB0briJH9/Pz1F7DZzhb93kbcABaxlEZO4y5DPk2AG/L3lOL?=
 =?us-ascii?Q?PEDFyOQpWaTTFkygb+YYvD6PNmj3snSI0IO8SYl3BevWWsLJLnUdhjpvw5GM?=
 =?us-ascii?Q?ScUVkkxAvCd9RkeknscgZhK7n78bBeyzQ1CXv3Qz/nNkqomf0RwbmVaZILsW?=
 =?us-ascii?Q?uMXNhugpsQLJ4u0MU9+/EKQAOwWeX8JRD7jjez3Kh0xuZTsfespxU28vPttG?=
 =?us-ascii?Q?f2IdmVe/Kpzw6N+fRCE4YW7TIyBfTUp7YoajJEcFntgGiZf3ZcHmApjebZRm?=
 =?us-ascii?Q?kddeWKFIw2SnnG7lxfI+kN98ke0082/xczuOFmuBelMk7S/QRe2dTmQYZw0b?=
 =?us-ascii?Q?94svV9f/1hZatk0CYeZ4VV8jaZdm0XVs6rI0DjsgnYA33DQKFcZt/9eFf2iK?=
 =?us-ascii?Q?5PHktc5nsCqTM2ZeLYTR0EHVE9W2aXZG0b+d12nsbdu4jyC+xxPkDT583lsu?=
 =?us-ascii?Q?/N3K7xWfqbIC6Qr2GbSrv/PsusGjUXZUfFHLwa44yw0GrwDY1ttmxmCb4mTV?=
 =?us-ascii?Q?TYhlyJ0odeA6LeiZWf4Enf/U9+C4RzWgRnWiI3SVAbhqbCNvgsOxrwhjQaqX?=
 =?us-ascii?Q?LZkUlTZYuYEasP1tUppTAbg2WmRD18RxTd0kz6dHjCTXinFalzq7vk9PCC66?=
 =?us-ascii?Q?oqdsOHQELU7YNZs6RaR94YATPA5jHW//mOq1GLt8Ut8tKFFlJCrPmzPQqwb/?=
 =?us-ascii?Q?1HpMv5BDcyy+SrsUt598nE4bt+WleZT6oxgZM9MbezSl0h2UVUfqrDIWteRd?=
 =?us-ascii?Q?wv5R1cchyFux5a6VG0em6x8vSSUcEw/h3nOSFjIHut15pvwUgiRALII9T0jc?=
 =?us-ascii?Q?NzMqiMTXBvQgnWkqE7oagAPAIvj1XG3g5rU9+e4fJZgcJ5AcCSRvoQN1xwda?=
 =?us-ascii?Q?VueuoT+ad9WOAAlYlZLwfJdu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:15.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827809dd-2ed1-421e-54e8-08dc64761823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

From Dan:

It just feels like numa_fill_memblks() has absolutely no business being
defined in arch/x86/include/asm/sparsemem.h.

The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
applied to memory ranges hot-onlined by the CXL driver.

It belongs right next to numa_add_memblk(), and I suspect
arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
what to do about the fact that linux/numa.h does not include asm/numa.h
and that all implementations either provide numa_add_memblk() or select
the generic implementation.

So I would prefer that this do the proper fix and get
numa_fill_memblks() completely out of the sparsemem.h path.

Something like the following which boots for me.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
Signed-off-by: Robert Richter <rrichter@amd.com>
---

Authorship can be changed to Dan's if he wants to but that needs his
Signed-off-by.
---
 arch/x86/include/asm/numa.h      | 1 +
 arch/x86/include/asm/sparsemem.h | 2 --
 drivers/acpi/numa/srat.c         | 5 +++++
 include/linux/numa.h             | 7 -------
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index ef2844d69173..12a93a3466c4 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -26,6 +26,7 @@ extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+extern int __init numa_fill_memblks(u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
 
 static inline void set_apicid_to_node(int apicid, s16 node)
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1aaa447ef24b..64df897c0ee3 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -38,8 +38,6 @@ extern int phys_to_target_node(phys_addr_t start);
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
 #endif
-extern int numa_fill_memblks(u64 start, u64 end);
-#define numa_fill_memblks numa_fill_memblks
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SPARSEMEM_H */
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e45e64993c50..3b09fd39eeb4 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -208,6 +208,11 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+__weak int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 915033a75731..8485d98e554d 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -36,13 +36,6 @@ int memory_add_physaddr_to_nid(u64 start);
 int phys_to_target_node(u64 start);
 #endif
 
-#ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
-{
-	return NUMA_NO_MEMBLK;
-}
-#endif
-
 #else /* !CONFIG_NUMA */
 static inline int numa_nearest_node(int node, unsigned int state)
 {
-- 
2.39.2


