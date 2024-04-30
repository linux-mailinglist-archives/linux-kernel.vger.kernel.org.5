Return-Path: <linux-kernel+bounces-164255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63678B7B68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAD1C22783
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615D176FA8;
	Tue, 30 Apr 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MnOUbijB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F287174EF3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490709; cv=fail; b=oZA47GDAkUDpDa3R56YqhFbSw5PyBa2N4QwJM2XFBTtujmlM74r12BlcpsyEx5Z0jCfNgv5huOX9DXQIx6jyCH/j90aOSCgq7QGKckztIVf3kqTnOU28cMhkoKwt1WdsTYjfui8TnrxgSXsOq7H144//L5przs/GSTPLNFEXB7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490709; c=relaxed/simple;
	bh=XtkJdDu9b9MZCRmzK121EgNS3w7zzvQ6r0E7BngQXWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJfdimT/U8VsPA8FHyftEn7fAotTi/9biS93vOH6iSTbw5RlVYUbtWN5QJeZt73A3MSnbh8+kwwmk3Uo+R2D6RprVQsumS+MQzWhJ9qV8LfTIEsnA+JMVvq8zfo3uuh8doZ6viEpaYxD8HjAHEPm7pPTf37VdhkVozkfl0lfP4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MnOUbijB; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnqPWsSRT//nissAz9idMLB1wR4lBFQI4JGR2xCWxtBQeBkVG29wlJ7ankOKthz2ppKSbPuvOxP2YDZhXT1KHp90p536387Mg2GvrZL8/ehceuPahEpIsMVcTe06xEDbB+9sBydqmtLRMO5nisGLzNqo72ZI+h+NkZ8YDX97QhPjp7lYTont8eDs7t+5F5qjnvbA/Q2gQxAovovMaOLYBByiv8zo+t6QNGJHrxJfe/ye4bY2rGpUEKCLHayalmxVa6CVcGsIKKO6vFYU0Vb4VtL3TZz90kboAxYOcirkwC+BC8vEeiI4PSspP6WKnDzypwQmt7YFnsgWN12+v1vWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAM7UTUs61d8KpwuxWPG/4mwi0zvGf2V1uvkPEYLEmE=;
 b=JFxkncxJgb1rJ8avp901tFa1/zVERxbpMYXPZ1K7PUb5f212SPAtW95FlHbq0LcU4lTp1n9F3V0oqTPHB2iSOuxL+8Ja507Wz4HWm6Pi3DPH5fDd1P8y2Jf2loHDwX2IbVjxVfZvIwutiogx84F160rPZue4okZH3CD17f2Xl0Fv6bYJkkXEY5zJnmRB2XmOGxy4yVXJR3yZ/DySUHy0cIjb++GXETDBHPvaVDCih7KIq/te+g54pFtAYSimRBQ3kIdy7zTy0GMARbCyc64MHs9dsrMGO1YtokDWfnOkgbFZFQCMBQ7IVLXjM3HJold951uv8JwW0cm9UXQtqZJ2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAM7UTUs61d8KpwuxWPG/4mwi0zvGf2V1uvkPEYLEmE=;
 b=MnOUbijB14CqFpw8m9rb+9yAuKpy2K2N7s0HqBWOnV/rsa5GnRfMghWw4FdNOlENNgu89jvu+T/O/KtfEo8TyfKCL5bDTsc+/WD5vt+8xtumOD9BugWecAMItV+wFPZ0P5zEfoc55wJWaOwl70RO/hG6fyVd0i2AXiaJdeC7pdQ=
Received: from PH7PR13CA0014.namprd13.prod.outlook.com (2603:10b6:510:174::28)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:25:04 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::44) by PH7PR13CA0014.outlook.office365.com
 (2603:10b6:510:174::28) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:03 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 6/9] iommu/amd: Convert PPR Log pointer to use the struct amd_iommu_mem
Date: Tue, 30 Apr 2024 15:24:27 +0000
Message-ID: <20240430152430.4245-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: e8632f4b-396d-47a5-2bbb-08dc6929b572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400014|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/bq6NUWYJEmuifutzip40PkgLRBhL0Vn+QdsSc9PZozUNZsqCjxBSnYVwZA?=
 =?us-ascii?Q?W9+yS1lqqOEVPLGL2TtKtEnc4iBTbxapDERgJzKBvbKwfyMcSVoztXTNuT4y?=
 =?us-ascii?Q?cVQbiufkjXRN4LLSMpvu8MHf1zEBItYSZ1npQBQwPUBLEv02vxw5QO9D0dzw?=
 =?us-ascii?Q?6wBznsTTOetujD7TqDfaqIyGS/5+LzRK96R3c0Ao+92/Vag4EsQ9A7PPP0n8?=
 =?us-ascii?Q?+aD0i2tIauO/sOEOScdin8Wv+i7Mq0pWAtrol3YITWGuayVrzaIt5vCLl4HM?=
 =?us-ascii?Q?Q892HzhO4MfB3LRtWYpRNvh6MOpAWN9fUJspL8lZ9ES7D/4ktQmil/GudnxL?=
 =?us-ascii?Q?VmC0uFwfksDwz2Hl1opyYEe1E4fOX+sHXiATVNRfY2j96YvnNpT5x5mdUQYa?=
 =?us-ascii?Q?DXzpQ628En6ZRPf6Vjj88GpKHH6Jq9GVk4Fo1cY4ur6MDsTAWd3WLeAUika4?=
 =?us-ascii?Q?dyk59PLroD3oduhE1PD/e2j7gsfQq4WvcvYU/wV68R0EfuDh60aH1n2QpM4P?=
 =?us-ascii?Q?8nDGN4oKAQbEcKV2vJCsB5Ni/yQOsNrs07IiXdUJ6OpU5oGqrepvWn/Pu4+0?=
 =?us-ascii?Q?eJLGc3qRtxGQJ3AyYEOXb5Mo9ha4OaEFwYttv4i7wv/KRUP5pjZw4BzRQ2BG?=
 =?us-ascii?Q?Aki5CwSKBhDabqkeyX81bGEaaUWO+b2kLI2yYwc+DIJK86GlRf69Kmx+6+G1?=
 =?us-ascii?Q?Xh6Y+7RNqdsa+wiq/C555UIaY/dH6qHiZ1pN6wTsDl49Ijyhnug4ABhaeWKI?=
 =?us-ascii?Q?NWYTrStFvjgB6KsyStRsA8OPnYCNyLMEsQNX0MBJeAGbSt2jIW+IG+ahUde4?=
 =?us-ascii?Q?Tjt4RtrvcjHPc6/OdIe5YRs1j2e0yIr7pdkFbMe2whPzbr2WEOyo85eMKYdU?=
 =?us-ascii?Q?D75mjYfC/Z2UxLMfxAU/bsTZgCin9pfx1rd+Ym8W19uFR9qxJ6wCdOeR/3me?=
 =?us-ascii?Q?kX0aiv70eR+5jQZ7D91INji/XSBvf6zDg80IADwZLjcIZcRONMbJlrNggHp4?=
 =?us-ascii?Q?iyOhpuP/YPgX/xsB4ELweB7K+BWdv2/vsPyA2AuQaBRXwNQUa28eJ3c1xUHP?=
 =?us-ascii?Q?TomAbXKAxef9rvstZVaQbdO+OgRLaxbFfaIUGPZzgC1Rj1oGL0yclVRWrTI2?=
 =?us-ascii?Q?JKKm6GKpJmKYLwfVxgBoOKveMytPvuulV+m5mQbvJqzaDu6xGNXbtw9lWQYT?=
 =?us-ascii?Q?7+Jo3815Zim3ca9di4WJk6AINKyr1h+45KsQnd7nX7aTTqIeKX6/HPSsp66/?=
 =?us-ascii?Q?Zz/TAL6wbrpMcB3UbTLXWKwKT5zmwGjENl99PYOCtRMr33UxPhG3dPS8g3bk?=
 =?us-ascii?Q?gL6+1AIeJB0QTULcavDT4nhO14umb66OCt6ndUz7Uf0RieetZf5yGjwraDN1?=
 =?us-ascii?Q?CbjXK8IJJUptI2fUxwiOQnAR9qwU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:03.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8632f4b-396d-47a5-2bbb-08dc6929b572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

And specify the memory to be 4K-aligned when running in SNP host,

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  2 +-
 drivers/iommu/amd/ppr.c             | 22 ++++++++++++++--------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index af4e9ca6414e..8ced34cac1db 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -744,7 +744,7 @@ struct amd_iommu {
 	unsigned char evt_irq_name[16];
 
 	/* Base of the PPR log, if present */
-	u8 *ppr_log;
+	struct amd_iommu_mem ppr_log_mem;
 
 	/* Name for PPR log interrupt */
 	unsigned char ppr_irq_name[16];
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5242a9a16946..b62d4c806155 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3848,7 +3848,7 @@ int amd_iommu_snp_disable(void)
 		if (ret)
 			return ret;
 
-		ret = iommu_make_shared(iommu->ppr_log, PPR_LOG_SIZE);
+		ret = iommu_make_shared(iommu->ppr_log_mem.buf, PPR_LOG_SIZE);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 091423bb8aac..13983b4bf47b 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -19,21 +19,27 @@
 
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu)
 {
-	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
-					      PPR_LOG_SIZE);
-	return iommu->ppr_log ? 0 : -ENOMEM;
+	struct amd_iommu_mem *mem = &iommu->ppr_log_mem;
+
+	mem->modes = ALLOC_MODE_4K;
+	mem->order = get_order(PPR_LOG_SIZE);
+	mem->buf = amd_iommu_get_zeroed_mem(GFP_KERNEL, mem);
+	if (!mem->buf)
+		return -ENOMEM;
+	return 0;
 }
 
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu)
 {
 	u64 entry;
 
-	if (iommu->ppr_log == NULL)
+	if (iommu->ppr_log_mem.buf == NULL)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_PPR_EN);
 
-	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
+	entry = amd_iommu_mem_to_phys(&iommu->ppr_log_mem);
+	entry |= PPR_LOG_SIZE_512;
 
 	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
 		    &entry, sizeof(entry));
@@ -48,7 +54,7 @@ void amd_iommu_enable_ppr_log(struct amd_iommu *iommu)
 
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu)
 {
-	iommu_free_pages(iommu->ppr_log, get_order(PPR_LOG_SIZE));
+	amd_iommu_free_mem(&iommu->ppr_log_mem);
 }
 
 /*
@@ -163,7 +169,7 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
 
-	if (iommu->ppr_log == NULL)
+	if (iommu->ppr_log_mem.buf == NULL)
 		return;
 
 	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
@@ -174,7 +180,7 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		u64 entry[2];
 		int i;
 
-		raw = (u64 *)(iommu->ppr_log + head);
+		raw = (u64 *)((u8 *)iommu->ppr_log_mem.buf) + head;
 
 		/*
 		 * Hardware bug: Interrupt may arrive before the entry is
-- 
2.34.1


