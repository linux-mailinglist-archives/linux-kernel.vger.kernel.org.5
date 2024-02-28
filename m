Return-Path: <linux-kernel+bounces-84482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E7986A745
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AC2B23305
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21157200CD;
	Wed, 28 Feb 2024 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGtY2nwP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21E200B7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091722; cv=fail; b=YYDzByyTvbuG/sHEDatske1rJ3aeaJdsEODcM4WsCA0Xjl1YI/Ykn9KMcxbL56oYU7qvP4K3TNFGu5J4XPV74xb0/X6yBHh6MhsHcMlkD1USAmN7wXGsCewHMQw4z/XYJr/Y0MATydy3nVAf0q7PMMKRgWLcaqg5ZjPsJ04JlzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091722; c=relaxed/simple;
	bh=2JZDGa9mkCyXR6avDiA+ez6qY3nEQkWDo6bdcU1F61w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n5PAdgk/LDSfXFJDobFEKwgEsARl/JlD2IaP6Ei51z5euzGLfUD/C/hdQN8T/EQsVsxsaQ4n89MKVlzrKSD4SIwiJ7DpqlSZf2gW69RcMhfvJI+0swaYYOk3QfpROjQwJjPOdy1L9CrAoZgl+XLToft3DBd0FUP6wUy8l9U0irM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGtY2nwP; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW6uI+Gq03NNLl/T0fckbHRsupj6mEl6juC4726LJ2W/A2uBwsNCnys3pT9GlYUZidiHmDK+lvS+MLpIFsGmwUb4ppwmLRoYBuJnjd8eipVZISyZ/AGEO/hlboqgdGtK9k5dpt6ZL1BQdBpLWLZQe/Rr1Ni8lMVNVc/ZTkTsP9P7TF7tfAecj7WpAHdp5bY2cWctxzvcAP0nC03q7G24PdCzfEW/1B5XqbqvY5Nw0KdoX3Njd6Luc3UNjo0pDD/TsUqkQpquNAryKP8OH7idC1dU4oD5Ezuds1awaaJkdiI4gtivS24xmjDp7LT9azSnNPUim+MOEpxvk/4pV/rViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3Mybnezfu45hJMbc/5Qwp4vfmOhIfOfpvNNSbRuaY4=;
 b=cIHm+j2LGeCRwdXDjgI2UXDNh5M2bB8e16S3jxwZ8n1iiLXOldLAbfBuhy5HaWXAzhBfQXTx2lTZZjM3618zZEwK0FBBxBhSZqWjL5mKgC27CwuE9w1c7wUrg8DF1/Ht6W50yydSUy8g09nUnw6yw8mVg/+r3NzpL+8U7Cj/sHAd3WQ/2e3eyhPVzM3Icg0wiHvEm/9a6OPlT4SHlwpuN4ymZNry8hjRgMPGybkueDUXnFDU4/hNda0CBNKvtuvd3XhrlRnbcgK7LS4urevbvIILfNXYrkUmctjz1/cmhd/uxTJKhsHZ99WfukxtyEigGM7Emc1uIH7m84Uj4QQJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Mybnezfu45hJMbc/5Qwp4vfmOhIfOfpvNNSbRuaY4=;
 b=DGtY2nwP0PP1XjDZVTVYh+XpHqM3DnfPpj1BL6iqIPjNPgahnYXJwoVars7h+gwdmIfYLA+p3jxtdGLnx+G4r+kKPZt2etdJhxoh/KlfF5TChMr25Fd/Likk/RMHGnSsYF2J+vJVEfFvdWLR7tg0ssBtHRNaIGsWKWkew3Q6NA6IZSe4T6GKKp0waYAnmgfzJ1EAuULHsOGLxFzjLdSpOqqgy5UlaWD+/H+CpYCH+BD9HzR/uRLPr8eTiq0XPOj3g62/VwdLoklxNXhHikF5PeHmBAsgBHMLRcqFwKBMINO6qkegm3es4h88bBz0iQnotMOl2U3oWv1KDrZ1PZxSwA==
Received: from DS7PR03CA0234.namprd03.prod.outlook.com (2603:10b6:5:3ba::29)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 03:41:57 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::53) by DS7PR03CA0234.outlook.office365.com
 (2603:10b6:5:3ba::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 03:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 03:41:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 19:41:56 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 27 Feb 2024 19:41:56 -0800
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 19:41:56 -0800
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, John Hubbard
	<jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
	<david@redhat.com>
Subject: [PATCH] mm/memory.c: do_numa_page(): remove a redundant page table read
Date: Tue, 27 Feb 2024 19:41:51 -0800
Message-ID: <20240228034151.459370-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe908cd-3503-4e90-289e-08dc380f36be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sY+ThXaeeqFuGPEl4TfslpkVOHuNbaoYs+lwiShg8kAXBEIbg/vIU4AfmuKCJHLgcwUbUlpGow+PdUCjUv0gqKw2S/uF+vJt0L0zJctURgKQyxNg0latzQK078PMLzdHeqMaxPM50zcAIbvUqgo4jAM4aHDDsKPBJrMe2KuaGfOItRugxZNq0WXts7B4ED8eDrCAA9s2GgAIfEg6tMdDQAEg/Kj6Kiybrwnh6IpevEfa12Rv8fw8ZVpG5+D/j6Aq3jAWd3r59foEHCCQaGJ0O0H/4WWjI3Y2Whrcxw29QflKEc/GoYbwOAxjXoLx/80aad8Th5v4w2Uh9aDmkohvxUoFyHW/6j937M58PPXLqFFqRfxqMQlwnRs5uTWeSPbalZm5yK+lAOHpe/D80O0eZXDrFZl9vae9dKiVvijZfnhqNRcQMobss4ZKKgE7ZmDKSL2L/5Rzeg4dz4gxv9JpMt1MihbdpIXp16XS12ijlM7FMXxmszoSJh939MCGqiYa9LrYkUzAd1j9xiNvb+nCtjrWPgxISFGhtaGnRc4bgQWpb19Arl1+b9op4qEOTJ0HKhkupJeGUdKM66R4ZIqUgQ1snYB9lEA5tYLhc12s/2xyC06UHQCCvOr0kRbV24DO1MosIStycR3a9PC9w6ybEGiJzSVny95MT9O2zcpQaql0huF6uYxu18CMAOnT767ufnFsxeTDUvossOT7aHUI9IiQsFtU5IZooKn+y+UN9eMHNzE2f6MxVL0J+wCCeflj
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 03:41:57.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe908cd-3503-4e90-289e-08dc380f36be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345

do_numa_page() is reading from the same page table entry, twice, while
holding the page table lock: once while checking that the pte hasn't
changed, and again in order to modify the pte.

Instead, just read the pte once, and save it in the same old_pte
variable that already exists. This has no effect on behavior, other than
to provide a tiny potential improvement to performance, by avoiding the
redundant memory read (which the compiler cannot elide, due to
READ_ONCE()).

Also improve the associated comments nearby.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0bfc8b007c01..df0711982901 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4928,18 +4928,18 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int flags = 0;
 
 	/*
-	 * The "pte" at this point cannot be used safely without
-	 * validation through pte_unmap_same(). It's of NUMA type but
-	 * the pfn may be screwed if the read is non atomic.
+	 * The pte cannot be used safely until we verify, while holding the page
+	 * table lock, that its contents have not changed during fault handling.
 	 */
 	spin_lock(vmf->ptl);
-	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+	/* Read the live PTE from the page tables: */
+	old_pte = ptep_get(vmf->pte);
+
+	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		goto out;
 	}
 
-	/* Get the normal PTE  */
-	old_pte = ptep_get(vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 
 	/*
-- 
2.44.0


