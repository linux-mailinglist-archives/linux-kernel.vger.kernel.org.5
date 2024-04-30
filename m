Return-Path: <linux-kernel+bounces-164252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60D8B7B65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D178B1F228CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA43173335;
	Tue, 30 Apr 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="422otHHW"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEA143743
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490704; cv=fail; b=E+HnAzrXabHS+V6DE2sJyhoKHqDz4TWqzF0EiUlTskVIZYp1ULI2AUiOoPCC6M7l2KVViN5/IX2n8Iqk+HzKWtl4ohsy5AsSnTcWIoGXgdNzxfebcH9505D8wacYqNEm5KCISVsCMER7l2x4ccm1VBIHkKlwFd7M6OQPY2GyQLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490704; c=relaxed/simple;
	bh=T9PMDa2m8f9pWeCvWIkwvv3uWatQ70SXRfoWDcrSfjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4E57qYiQXHCmQPohcOGntqC898lxM3O9+3BpmRP+tzOm9xeE2d4pLkf0Cdpv+ftSpsK8KsO49A3UMm8T13FALlSbTtzdlzTQNagIuGqCel349NPymsr+U9R+slQlxatKZ7FjYl0753yQLzPEEBgr4VGqixBhULZawxbpZAh/v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=422otHHW; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyhfpDVDFMpJYRgBRBwwmJIHzlufy9hqsLjV677ayDVnhAEz2sqCsrN9iD5E2ugWVryTBf1O4T9mYBjFD88Wx/rDF673zJVpf7I9A+w9meU1cerxlTf7uAgpB8xyxai/3Z9BBLn2M+TCItXD9K1ZLQ4lGXCn6zv/RvR/L2TM4M6nBUnPYFWqrCtV32VajdCUXqW/xp5DC0t08VzD/ukDjgt666yFLeSfaCT9nuBWRN8RyoIRpfElk0f+p1+5fPSjhAgts6jwoQnwEWpuGKbEwX3ucMhC0JhNIXlfwr+LWCVe0Ver+hVJJ/ZPPpb2JZqNDWg0aVEhE8G7GXSiw+2s2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bldSHydcHathPRCxxR82cCaaVBffJpF6fITCz6EY28s=;
 b=KK7mE4LvBMpLDOg325lUTJlqa/ZErn2M3jnK7j001eETbl1gzcCX572eI8O4ecJPDdVh2FGhVgiesS1UN0DQ5k8jNfRglNpOwoyRN2xJlgkuWweQVqUPIr5eqtAxHdc7e9zWWyrEibXc71gVvs929NGtOc8e+mlXmutsTswjQYjLJw1r1hIrKcnzUbDPpiXCEDG0A1dfoyUnWoxvycpIqXozIObPnnMrp65JE+aZRgqmQCOyyTKDWETdoaPICwSCTUlV2Hwn4AGGcERGktsVXNM3FV3NK5luMSLlyt8tsx5LDwXkNY8PPU4glNJ58amfNf3LmlaWjNgU339oRmCRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bldSHydcHathPRCxxR82cCaaVBffJpF6fITCz6EY28s=;
 b=422otHHWP3H3sOJWshMda73k829FbxVN+K9ky1f76S9S9oJ+FaB5HHpmU5mqJJLZj60i3/Gbksur5+5KBA+N05csXuMk+KTDtfgtHNivU0ETEEUP4jXlgFab4yCUGyh19TfswlAh9KaWKxXxg2oQB3ZyAF/UZhE6RA7RDrH3RVw=
Received: from CY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:930:1e::20)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 15:25:01 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::c8) by CY5PR04CA0029.outlook.office365.com
 (2603:10b6:930:1e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
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
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:00 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/9] iommu/amd: Convert Command Buffer pointer to use struct amd_iommu_mem
Date: Tue, 30 Apr 2024 15:24:24 +0000
Message-ID: <20240430152430.4245-4-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: c61a7603-6c04-488c-34ef-08dc6929b3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/m/rZurciQIW6KnmqF2vZJ/l4obm3/FwQmWUCdA4odWQhztnhJfg0ixg1ae?=
 =?us-ascii?Q?erhFZer2qGh4lz1XDZwnUfGXsExruMQ/ie3p7PwbjwtL9trQ8TqGBIojY7Ru?=
 =?us-ascii?Q?u4PpAWyiAn4cjMknQ3DjQpJ+aaevjTTk74SCbAc58HIdPQEcaHj5h2leG8Ju?=
 =?us-ascii?Q?RAsOICSq8o3VkSXpSWD4Lc3w4KztPCqP6ujOwVvruVHuSK+aBRZ26Y2caa7a?=
 =?us-ascii?Q?s9pCnm8sEiwkZf9tbqyve/zl6dQwzs6rMme2T/13cCxPeiZuk7BI9+v9hjfr?=
 =?us-ascii?Q?tQkPASvjuDD4kzb3V+ssLYUvU6v702GnEqZbeEFEeLfPMP4fTeVpvrPQPehD?=
 =?us-ascii?Q?hX19HSBly+gFFWRGHQtyyzy2HmUZm/YLl4dB1xvjdPi8MLj8MdRd/0p9fli/?=
 =?us-ascii?Q?Ax+6veUgEEKgcQHd5+/xGBon9Mc7pl1ChKFK1b54hDnnCuIaQfnTFs5BIL1B?=
 =?us-ascii?Q?6hc6iAu4Zi5cVy3Q5ck2FDj4O/zwGdz3mtExZLmH/Lz8O/qM8aasn/diZL8E?=
 =?us-ascii?Q?qBzjtDM2xece8SwQ1vd01OVbACMpQEWq6AnE/KX7V+1MDigZAvMxMxx+6VFs?=
 =?us-ascii?Q?hDpPxIuFXUTQXjn9KKwyEXPwJkNMrIQ+07BJU1bNMVf/CvP+kzd+VAhqsnGh?=
 =?us-ascii?Q?E5vTpusTOXa5AMRy6UdziN4qNJXUFMoFp1DDkZIGiAOvduc+E83mZlDgg4ir?=
 =?us-ascii?Q?YaW0DFu7L3arC3Be0FgPiZIIZH7O1ZaluIhG6VwDTfZnUA3XzQMV32vLgnAt?=
 =?us-ascii?Q?1BPyBXIXwcPdjvZkMKXJLLA91D2X6UbogI0ahsJ1o8yWkrW/gDzc33VN0pSk?=
 =?us-ascii?Q?iPBFhunmcHNizTHxpbZwiER7Wy5ltK8ralwdVMutXuxMOue6NkEqBIXca1BH?=
 =?us-ascii?Q?079Z+hp67B0JaiWMEK70qRM1ZmbBrpWbxNaEVdKFcu/eNs68jjyBD0toKhsE?=
 =?us-ascii?Q?ECEy5SNPuOBXH52nzapR0N3CyVXpimx1G5uWompirAqvw0k7J9U9E2whxXUV?=
 =?us-ascii?Q?7wqiHHZWLtb1f5IAoeKG9ZpnSDiskbSgVom+cMwn53ivvP03UhBA3PUp6knb?=
 =?us-ascii?Q?VtWOU7CJYZ6Xf+yC2qO+oDc/oJa3VU+3ysHT16X/vLxcIOJ+SpQlQJ2qoJdT?=
 =?us-ascii?Q?iSeHQ9jHS+8sbHeFwonfgwYrtDP0nXvCyRpcvNooHsetcG639LSPFlImSB5T?=
 =?us-ascii?Q?gTVTAoqPrkhVx/6hpVEi/piNfy9VguXfF5zJWZyejcKEtxI+RDF2ALSDkguV?=
 =?us-ascii?Q?LKpmyjcVS3fUQnz+H4k6Gm46DpHQcdyIJfKkhERUeD1FqPHaYYQ0jjI2wtFY?=
 =?us-ascii?Q?6ACPgNNAL5T8q9XJ2aHziGD2Gkqe/Fe2cZLjqo1xEKzr5wGAeZ4aMtXPQi2E?=
 =?us-ascii?Q?WfxS6/4XJXxw/Yin4S8t3zaRHszF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:00.8730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61a7603-6c04-488c-34ef-08dc6929b3ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506

And specify the memory to be decrypted when running in an SEV guest
so that the VMM can access the memory successfully.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 17 +++++++++++------
 drivers/iommu/amd/iommu.c           |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d9159f2e3f0f..653955ab120d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -733,7 +733,7 @@ struct amd_iommu {
 	u64 exclusion_length;
 
 	/* command buffer virtual address */
-	u8 *cmd_buf;
+	struct amd_iommu_mem cmd_buf_mem;
 	u32 cmd_buf_head;
 	u32 cmd_buf_tail;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c68ff602d534..77147dc3b79f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -735,10 +735,15 @@ static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
  */
 static int __init alloc_command_buffer(struct amd_iommu *iommu)
 {
-	iommu->cmd_buf = iommu_alloc_pages(GFP_KERNEL,
-					   get_order(CMD_BUFFER_SIZE));
+	struct amd_iommu_mem *mem = &iommu->cmd_buf_mem;
 
-	return iommu->cmd_buf ? 0 : -ENOMEM;
+	mem->modes = ALLOC_MODE_GUEST_MEM_DECRYPT;
+	mem->order = get_order(CMD_BUFFER_SIZE);
+	mem->buf = amd_iommu_get_zeroed_mem(GFP_KERNEL, mem);
+	if (!mem->buf)
+		return -ENOMEM;
+
+	return 0;
 }
 
 /*
@@ -812,9 +817,9 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
 {
 	u64 entry;
 
-	BUG_ON(iommu->cmd_buf == NULL);
+	BUG_ON(iommu->cmd_buf_mem.buf == NULL);
 
-	entry = iommu_virt_to_phys(iommu->cmd_buf);
+	entry = amd_iommu_mem_to_phys(&iommu->cmd_buf_mem);
 	entry |= MMIO_CMD_SIZE_512;
 
 	memcpy_toio(iommu->mmio_base + MMIO_CMD_BUF_OFFSET,
@@ -833,7 +838,7 @@ static void iommu_disable_command_buffer(struct amd_iommu *iommu)
 
 static void __init free_command_buffer(struct amd_iommu *iommu)
 {
-	iommu_free_pages(iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
+	amd_iommu_free_mem(&iommu->cmd_buf_mem);
 }
 
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3df07e8ef002..2b18134f1eb5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1078,7 +1078,7 @@ static void copy_cmd_to_buffer(struct amd_iommu *iommu,
 
 	/* Copy command to buffer */
 	tail = iommu->cmd_buf_tail;
-	target = iommu->cmd_buf + tail;
+	target = ((u8 *)iommu->cmd_buf_mem.buf) + tail;
 	memcpy(target, cmd, sizeof(*cmd));
 
 	tail = (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
-- 
2.34.1


