Return-Path: <linux-kernel+bounces-121588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1788EA43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF991C2FF93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679E131BA6;
	Wed, 27 Mar 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J8qrdkF3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813012DDB3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555403; cv=fail; b=nuLpXv/3l8DVaS1yg9YPtT6/Ocv3jc0T4uOIVLY3FdyaGIwvMDmGdJ98B4QNKmuAIH6zlAZWkjDr/BZi8usSiZUJ5DIDtO6pcr/PMeZQkcLHjkJ6D+HfC47VjdC8G5NfPBRUrcp3EJjL8CG6XpbCSkFmuD1GRWbDVW/8VBbY338=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555403; c=relaxed/simple;
	bh=LPBMSFOcBdnCWTWSwZuMQhwlQ/BwseXEsRshpPWQ5BA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUYZm6xnYTLnjiTKmtrNCnTb2uk4NqfR3f3ONs3Id3+KeZA7/k1DI3dEqwpzv5PNVBsq4EtpdNpKTzyKeV2/5no/K9kBiuuegh34pgwItrEgT40r8aPK5FkpaLJMiO0F4ddlpmFTUwPq1/H1gnCWDq6dnfDcmqqF3CuRVe7IYuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J8qrdkF3; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMscX8Lv63t3jsfBmzyohx2Kq+Ult//SvzpmSURZle5oLN58KN8Tz2014RXQ8LzUvAoH+qix/oBL310U1NH0LYcgHBk8LAu/z6jSA7uPHnF1H091Lld6Lns/tEROkgdSV3MeZvz2cHYOi2Aw9KAs3iVnX1EdDU1Q6uHpc98r3uBYKUmmGXfUTc3940kjWuzpNqVKcMdHfn5AvpnT7kI0Sva/mlW/iE0riSW2U5p0jmCZlkwsK1lRk8AAgftyxGuJumgGLO9brGip2acQV8kiBTay8blWnyCblkn70WjKPBY5s5g3B1TW6hbwoM5M+7TPJz4PAeDSW5s5uHDmgUMrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pwK0KzVxNxNJ1/NHzBY5STd6/oycVRn4PIDhMsV7ck=;
 b=fdhFwu/cmzEcdp4hbxoEntutNoeuZdgQ3vK7+52F6ZZVv2EZ7kFhdEjybpxFrU8M+W87AEZBb/FCBD8aSswIzkh4SDMXoFZSe2T7zzoFHle3XrZQqET1Qfjrk2KKw6gQXDLm9mwiAU2YtluKSr/mSoUn01QzZP2McDDQaUEskA9Dxjvs94n97n6DD0YRGuD8o9JXJsvKjKVEQFbAbzV9OLmPYKg76XSlNzVdzna4UIkebi51GOA6S1dVbVKBtEPESyzgi2Iz2Cf76s4Isl9BYXT5eUumeE6xVnyLp/ajg3l5Y0mNmymr4bPTXs3lkptzeO2x1gtsSBLKN+qYcDRGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pwK0KzVxNxNJ1/NHzBY5STd6/oycVRn4PIDhMsV7ck=;
 b=J8qrdkF3Jcugxk8LrDWRbdK1xP7jnJrc5MPh38AS1d9x8+JxC74c27P84MSnZeEIOh/G6f/mO00ptAAjn2PNvMXS/YAPBEyPD3/4uA1K9S45hquaGeyMD4K+eEAJor+Ns/iKZjD/hzl86cQsO83ra9COpppH0+CDqjf6RxjhP9o=
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 16:03:11 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::53) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 16:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 16:03:11 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 11:03:06 -0500
From: Bharata B Rao <bharata@amd.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <mgorman@techsingularity.net>,
	<raghavendra.kt@amd.com>, <ying.huang@intel.com>,
	<dave.hansen@linux.intel.com>, <hannes@cmpxchg.org>, Bharata B Rao
	<bharata@amd.com>
Subject: [RFC PATCH 2/2] mm: Update hint fault count for pages that are skipped during scanning
Date: Wed, 27 Mar 2024 21:32:37 +0530
Message-ID: <20240327160237.2355-3-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327160237.2355-1-bharata@amd.com>
References: <20240327160237.2355-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 531f7416-a48e-4b52-97e5-08dc4e7766bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o7jMpkaBwpqEDOIdhIv6SMVT0criqKknSh6v2cmI21d+EM8bIqG+pvgUJZxRkkXflVabPKx2iTzhR++jfAu64S3ZxBAWjHmfcRSrDZCi3cZS7mhr7aRk/f3zVItmG74+ylOE9m30JpGbiizw5FvUtv+VH0DebqNqhO1zbG0EVfJdoITsInqzN8PDDb3sMAMo9RQIIriWYfcyG8+g4ThjT4IWYUzt0WpeMc0dcrjJYKG+fq0YTYEb2jub4n6/SsTZvmgJkvvi9jLbjEwa8U1Dq3e1eoHWX6OI4L5PRhnwB4OrTYqogGbRdKI/CV7vp+oBe0rsmgRxntJPKVzqAIoz0sWlh+Xw8mJrpbhmXckzeubNsyaX4KrFP3wAQ+EPKiDmInCWSQFSujDn26MDIOb/7+CpYAjPBB9LMFVeXo7fUmE2dvi8FVPtaRGRmRzx3ZGJOz1mUmfNk/jEtvk2R10EbtVWKbko+549ANQUjJLu8HkBcBBY+JYMP+k6qWFEbLmUgrF4NeDEh7VUnrWQftgac1NbkpY9spjZ+Jp03sg39ixFjNr91zJ2aLU8hQsGc5LP/5wBPGSO6BcXWXdKfo3DarGGz9NSibH4Kq8QGsrC9a3HLPp5OnTKcsCnfNkcqYJeMx+dqs+95hVVNCp5gm996IvaQ+LolT1LpokilPVYwswujdM7L9wiRv5Yo84wPbbFQW+IfaTjWPrRRHDuh07m240dIeUPbt8O4w1xwL61Aokiu7sQ0SCKdy/OPQLlMdF/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:03:11.1075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531f7416-a48e-4b52-97e5-08dc4e7766bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

During scanning, PTE updates are skipped for those pages which
are already marked as PROT_NONE. This is required but update the
scan time fault count so that the fault count which is used to
calculate the latency is kept uptodate based on the recent
scanning iteration.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/huge_memory.c | 7 ++++---
 mm/mprotect.c    | 9 +++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7e62c3c2bbcb..24a4f976323e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2086,9 +2086,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (is_huge_zero_pmd(*pmd))
 			goto unlock;
 
-		if (pmd_protnone(*pmd))
-			goto unlock;
-
 		folio = page_folio(pmd_page(*pmd));
 		toptier = node_is_toptier(folio_nid(folio));
 		/*
@@ -2102,6 +2099,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 		    !toptier)
 			folio_xchg_fault_count(folio, atomic_read(&mm->hint_faults));
+
+		if (pmd_protnone(*pmd))
+			goto unlock;
+
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 30118fd492f4..cfd3812302be 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -118,10 +118,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				int nid;
 				bool toptier;
 
-				/* Avoid TLB flush if possible */
-				if (pte_protnone(oldpte))
-					continue;
-
 				folio = vm_normal_folio(vma, addr, oldpte);
 				if (!folio || folio_is_zone_device(folio) ||
 				    folio_test_ksm(folio))
@@ -162,6 +158,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 					folio_xchg_fault_count(folio,
 							atomic_read(&vma->vm_mm->hint_faults));
 
+				/* Avoid TLB flush if possible */
+				if (pte_protnone(oldpte))
+					continue;
+
+
 			}
 
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
-- 
2.25.1


