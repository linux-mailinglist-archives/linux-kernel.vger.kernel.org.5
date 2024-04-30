Return-Path: <linux-kernel+bounces-164259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F038B7B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CD51F2276D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D087E17B4F4;
	Tue, 30 Apr 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYjl0tp/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195B179970
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490715; cv=fail; b=o71JUl2OaPtV0sIW6J2Q+CYRF4aG1uT7oRu9ztL5PvUS1J9Lx9VAbj6YbZgQLKWq57Qum0hMPB8UaBUod3ddxA+LNZf3grvpsu1Kv1JlxkuUW6nRmeyUQxQxjdHEulFuo+5PS2/Ab8wX59wJfCL1puFyNZ41MPiqL5lneyqy5mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490715; c=relaxed/simple;
	bh=SWptMURVStmPicvFcbd7gPMQ0jv7Sglz+hhq3FncuR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpYbwSO8jJooY688FMp0P+41OH0fzXnuKWu31zlsGoUI/lUKmRHLd5oBiGQwZSlJ9gSpWc4CRCnTzMF0fiOYf50KJU9eVSeMNX+VK21El3RH7l6qHyRsI6fWSFgGfbM8XTF68P4uINLOHG/YxovzAxXcyF467XUoJ2wu18fNz78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYjl0tp/; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1VjDEuznWPKvlk5WqUbW9XYjUy9cGHDRxmavy0tEC6jXs27yjjUJeNQqmgoghtmm2O78zBrUFoS0lc2R55Gqy2LI/ljtcVQyQxub0SUtlXNhW+OEjUEAneBuJFd6UIwEHYHAni9zrG4vEbIiPoaTjxo+2pfPzctqE+VLqhuqgpaxovQ9lzqQD1tKw2Ip/GgVCb51aKqMZ+cdHyLLJEZsDqxV8ghUzYA9pf0rINebgjIpZJxWxz00At1d/Db2R44uyrl/whx0/oWnI27lKeiW0Wwd5iK2MgQH/5Dhha/DtyWS7KnbMmx+voPykleo+sbGwUvEDgGue6nV9pB92Y+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpUYbG/9JwQI2sYsQb6rVJhddfA68lF+BIYSXuXOxX8=;
 b=jdSVs5KFosgsrV1u+yEgXQKH4uqDeaw7O0aPKGMw6fmSwS2qtl1zcALeQdMffhql4PgTU3+KDoN64apAGR9M+tSIZKRfmCh1bPr7HPjeqPeNda5CgpMK+xK+9DpjYE3p41ul5QBXJc5dhwuqt9Fy0DHZMnkSb54BYAhOceCRfnI/qqC5Z6UkwxppCY9IFgPwo7Tn2kVSdI/0q2uDEqigkQikU045fdsIBeMadTmFZTuSSJtesJifq5OYDjTS2QvBLjp5ihFI+5hK+/vjdYcWATKrw4eLWhC1Cx5+6BJWDSizl5S2hnVo9Xb9/by+/x5Jua9sY4z3X/gU6tmEHRIdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpUYbG/9JwQI2sYsQb6rVJhddfA68lF+BIYSXuXOxX8=;
 b=TYjl0tp/Q6IMNUZcvPqSup2yBZ3eyUjaL/jl4Ex+20mPBD94ANpQfh5pZo80Rerd3Bj7WHvVhxg7Dz4NnJmDMuoa2+2Ks5xq5VUNwVTXxNWzSEwOLZyA+053rCfirnuz4NpmCOQVYz9ZqiuOo3O7nIYDJ8rx2p4kAbnAXAmsM/g=
Received: from CY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:930:1e::32)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:25:01 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::24) by CY5PR04CA0005.outlook.office365.com
 (2603:10b6:930:1e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 15:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:01 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/9] iommu/amd: Convert Completion-Wait Semaphore pointer to use struct amd_iommu_mem
Date: Tue, 30 Apr 2024 15:24:25 +0000
Message-ID: <20240430152430.4245-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 39aced07-cd3e-4e33-44fe-08dc6929b40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTaWK6wY8Iz/gQhJji5TVBv8lx3ZLcDxUkMX92N+ViZma0R7roOBNeF2RQ90?=
 =?us-ascii?Q?2GVlnlehZR/oZy2b5FQXbVF+PBA9MRNx3KlUjXtIHwUPIvf31jFvIBOHGovV?=
 =?us-ascii?Q?KCoFIh876pwEwpcm3ctLGprr0o90wfC1kY1i5dwFCNvkhN+StKgd84MMfO3e?=
 =?us-ascii?Q?m9gYwCChyRM+MiOFYHNPT7kpUnMJaWv0tvoJqnnaeUM8hZWYwBqrerjstszc?=
 =?us-ascii?Q?arHU2gEC8wwklaNXu2O2bAEjeCvwRGUPvbc33U45SrsFPaoEOWZSkGTDs7Eg?=
 =?us-ascii?Q?DxtVe5tR5VQZRcgNAm7QvrQ+txfXNMpR4/ZdcBSOHlemB1u6Vj7VQ2yBASm4?=
 =?us-ascii?Q?kzAF7CO7EtEQSFYjYx85VSQF2jHV44Zk9KiC4eA4HsZ74BP2yCh3onWWp6cm?=
 =?us-ascii?Q?GBCWCAGjbBMf6i8I2ZlgkNJMBSISvZoUNtyKH6GlDkVWpiEh2nM6x9Br9NNe?=
 =?us-ascii?Q?SO4OGAo8RpqTn3hcJjKYZoVDjqrjEs0m3BJLVnndiIEZF/BcWaFQnNl4bkZq?=
 =?us-ascii?Q?/PzUoFkxI+xeMNuLIAZ1Fjq56DCM7wyRlpIfesS3RIbO3jeMDVgcNhIUNWuT?=
 =?us-ascii?Q?fce7/fffEAh+fCkNE96AFMLdsfNWVHto67dx2xrKjjoT+W5kXEJERRJBS9xY?=
 =?us-ascii?Q?ABIDm3m4xYFopqKv/ef72iS003tPp6Pn/cUh2Z7xYM8PwgEd0rXlej5ZAllt?=
 =?us-ascii?Q?quXnDTJq/VguHHP4SiVL2VCapF6O8i7Pta0VGTgsiYZuG7xhJXzOmfTuiaJi?=
 =?us-ascii?Q?X4G9H6doj4hD7QgayALiyc5y194lFowrFbIaJ5tXYaQVwh/e5LnCDoutMEEc?=
 =?us-ascii?Q?vBtQkz3+8iR9vuJHAEQCTmfPc79MtqESwSp1IOqaPW54CdRVcUtk+fLgv1UR?=
 =?us-ascii?Q?hspp75l7PVC/aTOviHOpkoaleAem4YDH2Miui3WD9YEFhwQQDHR9TXoR2afx?=
 =?us-ascii?Q?ljAItyIUtlmytTyCRPq07mEaQyx+XTWZQZQaax4RsU8z04RlJSyzCkJklBoJ?=
 =?us-ascii?Q?8U9L42gS+c8UxJwf/TiOYY0lmkV/DtgY7DbW9RPNIQ1ZOenetmih+Kv4ihaL?=
 =?us-ascii?Q?ltksSi0ZTJoZdKpxec49HTIJMHSxkMPEEGQbdiHFqACArcvRx5OaF3Vxufj+?=
 =?us-ascii?Q?MApHvvlIrFiJCfVZDqmZ+miOtcKLNdc6VkCXNBOgqZuINDrLOAE3hHSApKoO?=
 =?us-ascii?Q?p/vjOwyp9D8rA/OaOH8ZMZ/B5VPR1nDYq9A8FcZj09bREskXWLLR+3NZiD5K?=
 =?us-ascii?Q?Y202FzsGg0aewOHJ0lOv6ry2lgYf6KTVW3fQ/Hl1GF2SdC2QYVfvIVga+Y/r?=
 =?us-ascii?Q?XjGsrEDh2FPW8xw1AhgvQVD1Z8ZqoRvc5rBeEOrTiGmYPKTd9TmhN2PJgaVf?=
 =?us-ascii?Q?D8pRhmo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:01.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aced07-cd3e-4e33-44fe-08dc6929b40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641

And specify the memory to be 4K-aligned when running in SNP host, and
to be decrypted when running in an SEV guestso that the VMM can access
the memory successfully.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 17 +++++++++++------
 drivers/iommu/amd/iommu.c           |  5 +++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 653955ab120d..e671e9220a21 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -798,7 +798,7 @@ struct amd_iommu {
 #endif
 
 	u32 flags;
-	volatile u64 *cmd_sem;
+	struct amd_iommu_mem cmd_sem_mem;
 	atomic64_t cmd_sem_val;
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 77147dc3b79f..51861874656e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -383,7 +383,7 @@ static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 
 static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 {
-	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
+	u64 start = amd_iommu_mem_to_phys(&iommu->cmd_sem_mem);
 	u64 entry = start & PM_ADDR_MASK;
 
 	if (!check_feature(FEATURE_SNP))
@@ -963,15 +963,20 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 {
-	iommu->cmd_sem = iommu_alloc_4k_pages(iommu, GFP_KERNEL, 1);
+	struct amd_iommu_mem *mem = &iommu->cmd_sem_mem;
 
-	return iommu->cmd_sem ? 0 : -ENOMEM;
+	mem->modes = ALLOC_MODE_4K | ALLOC_MODE_GUEST_MEM_DECRYPT;
+	mem->order = get_order(1);
+	mem->buf = amd_iommu_get_zeroed_mem(GFP_KERNEL, mem);
+	if (!mem->buf)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static void __init free_cwwb_sem(struct amd_iommu *iommu)
 {
-	if (iommu->cmd_sem)
-		iommu_free_page((void *)iommu->cmd_sem);
+	amd_iommu_free_mem(&iommu->cmd_sem_mem);
 }
 
 static void iommu_enable_xt(struct amd_iommu *iommu)
@@ -3841,7 +3846,7 @@ int amd_iommu_snp_disable(void)
 		if (ret)
 			return ret;
 
-		ret = iommu_make_shared((void *)iommu->cmd_sem, PAGE_SIZE);
+		ret = iommu_make_shared(iommu->cmd_sem_mem.buf, PAGE_SIZE);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2b18134f1eb5..bd29d26c8d44 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1056,8 +1056,9 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
 static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
 	int i = 0;
+	u64 *cmd_sem = (u64 *)iommu->cmd_sem_mem.buf;
 
-	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
+	while (*cmd_sem != data && i < LOOP_TIMEOUT) {
 		udelay(1);
 		i += 1;
 	}
@@ -1092,7 +1093,7 @@ static void build_completion_wait(struct iommu_cmd *cmd,
 				  struct amd_iommu *iommu,
 				  u64 data)
 {
-	u64 paddr = iommu_virt_to_phys((void *)iommu->cmd_sem);
+	u64 paddr = amd_iommu_mem_to_phys(&iommu->cmd_sem_mem);
 
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->data[0] = lower_32_bits(paddr) | CMD_COMPL_WAIT_STORE_MASK;
-- 
2.34.1


