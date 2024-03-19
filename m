Return-Path: <linux-kernel+bounces-107472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933B87FCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2A91F2312E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6440867;
	Tue, 19 Mar 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e6/y+tnM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57E7EF06;
	Tue, 19 Mar 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848017; cv=fail; b=rQCJFEDMN7G5IYiwhg0EkjTHe8oMI14g9HQqIIudnnF34sCoqJkk5oUZ9h3aNcGiMjZEX9mfm7RXJyIUYexsERVFLHT3EM4TC7pUP4tbJobYPPzhJA6+Nv7iKruMF/0bxtoZ+6ZcTz0MGSbcPph7vU84L/u7IcGcrail2gKS5+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848017; c=relaxed/simple;
	bh=Jmvtaflo+UqsNpkXG0GXhIIEc5jQJGTDn9fnhuyHfUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dUkCftfj3R/lZnWXZ3kVq/n/40BOQ1cB5FSh3PtQCKdwhN1PgIqoXapEiEPVU01hIGlbgOvdzA2GJENH149M6xyxRXdKpHxeqjXqT4bCDE2qBbPoLE1+CxWAApWgTJwXL+8u1NqxtvM6YUQ+IN3Cwthjct7rxvv3tqwALHyZDhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e6/y+tnM; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSFIkMToHT68UmghzzVK3sgzH5OVHPbBrCcH97Pxlc8lX6nTdQyaEKqwnTeLTUldKZig5zEBS9Nvr2mYqDWuNayILaAqTumA3iGzQuE/oSDd7kgWujspkanFhbGPE6D/OZuZxEKparM6Po9KDania9tRlb6HurkhP/PQhXIVDaU0T1pxNwDozX26pcl0A1Ru4vy1BwPVIf+U5Jx/wNqa9kv/gwrsRAdSc7O9Myvtnc3N6rnd1yxBK+54lWSW/ty3s7gXTxWKk8o3q/ffROhqo735Y0Pmtd3LS7IU1R9SgZGkgIXNbR6Y5/dDGHL5P6UlU9bcNVa1fHSyf6EYzkiK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQhVmICdvrOW50Wlk98j4ECopkC6395VSHr/PhS0g3Y=;
 b=Y2gChYEiqnQ/CAx9gzz7FS/HmL27lEc7uGgGMfYAFS+fBIYy82N8GxULi0dQEkn7NZ/s9GPY30RZZ6c5+86VKm1lB0gUtYqRMDtXi+Uro82PXhLQeNE2ISQ9RjmeBhQM75cPUQlkAz7iqWy+2u3rdd0YOkEBd4WYKQmadAN2S48KH4RJiuAcocHa1/0qQKCyS3S/er9MFWvofKdi8cS/QURPSQ28gShNxIyqYLZ6pW6OhjDTwDGeZRZRlcPFiEKnWvy6TIuKBvlA70Fir+Yo1MUigvmln26zNkvOdxns0Ov0YBRyulqWi6Sa+jqv+W+iM9AuCxeKDlKpCatdbH6v9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQhVmICdvrOW50Wlk98j4ECopkC6395VSHr/PhS0g3Y=;
 b=e6/y+tnMJMwWkZ0KAHozMWqIoXR5XEZiHgIWHZ1nP1OVd/yRx8vZd0Kjyd1TIXNKlajWMMZt4bDXKgYe3gDD4TB5FCLJr753b0KSlIx8UKe/NSn54fTBKJwBA8kt4DFZtsCYb0I4WsI8QZzxUsc/RT+z1RhEG5ii1VlYOrObsZQ=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 11:33:34 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::7c) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Tue, 19 Mar 2024 11:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 11:33:33 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 06:33:32 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] FMPM Fixes
Date: Tue, 19 Mar 2024 06:33:20 -0500
Message-ID: <20240319113322.280096-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: d00a6de7-ea74-4083-6826-08dc480868c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRezc3bzWF5Ge2SxdpsPe0pAZ1bmU2uZnOn7HWiUWNnOw5UmkRuuGsvFdeb3DRFjHrCgGXAZU7jm+vXnbvuI3Sq56vwHhtOaTav1GPpbFOMU4PhJTajN4ON18I+dEhblGiaXV5j1pJGdSteKXveEElrEOS1xoWYpGQLadaUWxv9A9yrWEsUC6uqp3KKvh2+7FvtoEb5dP1SRbjvJ7uwyaflrwEBHlfp1gWfB2ixHvCMqx7v/8HsqCjnK3VK0GCF7szPcKIxcKsmlWfKH6agDV1bp+mKnkSiatFRRxiM9JPVrK1l0tu3YYEu6zNJhY/iCH1s69fQ9CzzhLocqlr5zAaspXa4brRuX3JgpqE9ibYAdMfeFOZat9U6DJ3TTX/PlrlZEea7kbR0GeEQD7JC1jsC+Ykk/mi9/LDCwSHzepN7f+Il3Wqj2iQ1ZDvBB5WOBtZX2vxf9NeU+WLQ0ZZKCYzTaF0ivRJF+aBBN+DHbgl2PCG9yd3dGMuBG0q8+atcX5c9aMy43aYu8dhiuA8Q4952/tMbrevte+MPYgx6LCA+mbKxG/4vxefkmKeobEr7rBokM2OQcSTiHVzXIJ1cAuM/21nBMPo8ehVoqdqoq4Cl0sQXj73uIqvqRH4zuQV2Hyw2OazM7AQ2+aADxOwq/FgVICMKHO0BZpuQweq+GWizOeFpe/nrjhHnYMOLZQ719P2Wk6Ukndo7fWjSQ57MVSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:33:33.1177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d00a6de7-ea74-4083-6826-08dc480868c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

Hi all,

This set includes two fixes for issues found during further testing of
the FMPM module.

Patch 1 fixes a NULL pointer dereference. This is a resend.

Link:
https://lore.kernel.org/r/20240312154937.1102727-1-yazen.ghannam@amd.com

Patch 2 fixes a record restoration issue affecting a couple of
scenarios.

Both include Murali's Tested-by tag.

Thanks,
Yazen

Yazen Ghannam (2):
  RAS/AMD/FMPM: Avoid NULL ptr deref in get_saved_records()
  RAS/AMD/FMPM: Safely handle saved records of various sizes

 drivers/ras/amd/fmpm.c | 57 +++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)


base-commit: b3603fcb79b1036acae10602bffc4855a4b9af80
-- 
2.34.1


