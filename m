Return-Path: <linux-kernel+bounces-103578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717587C15B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480CA1C21E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07673535;
	Thu, 14 Mar 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQu8uwjA"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED970CCB;
	Thu, 14 Mar 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434165; cv=fail; b=K5O0fRev7Obxg+IfbbkmUSBROpwR2ocwyWv3z/pVcjQzDKZcAyCGnou0DP7FjPdSHCvyjTlSxI3k00DBq9CeFW9tqDhCw/Ygp6Zif2lBWkFIJ7AL86hyr9GCOI78yrKbDslS6PmfKtffVDmoAgntof9NjwBj6FFXSQD03tv2xFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434165; c=relaxed/simple;
	bh=NvkeTuX+OS2ap2Tvipeu3pk5TdIr83kpkO2ZRWiosRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bWqeNiOscWw5NihMBvZthvf2jG6RZN56xaX/dI02nug6t5jLyWx/MP0rc9j21Vw3lACwqTHTz24TOp7hEZzm4sJAqwMJkEVMUi8ddKHOc0OPEI4W2I+Lv+wi7WR3iSDHtziDLWR3/i02bFDS5MEZMJ2CTTrdBgXRYGlK/L9RPVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQu8uwjA; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgDCdOy1u13yCyDN60zgJaCC3+nPyu0tB+wFrCJibxw35rd4XcHsG+pCgN128h2PS3y7wMritgetku7kpYsu1WOLU7vgligY5/+CGp3SnvDeMLZ1s3UiuQ0aBv8h7IyaEdzWtN4KmdNb7QrLzFO/HfIZYh9ifjgGe5sUXhSx1WjQFHu8HsHpxxURz96TuQjpb0zy8K5klHTCuYW+XNhfaYWswHVIZYjpt/cSwDazlnVsWuILUgOKZFVvCaZauumKmuBb0png8AIAKzOk5tX3h6hkxCVgH+mBciOQNwp+Hzf8Nq3pkLi3ViT7XUGtpLdvamyuGtoNpvO8WKmfVQMltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8qKkfcsjoyEHNBF6XoQkBFVCo6OKU8BpIdAlkv0KUY=;
 b=hKTKH9mhAfcrwoPEY5QrqAj9RcTwTaNwM4dkJsKkuJwmBkymQscfivCrQxXIjLqQkLtKIjkLkD177ahm2cngb4ZQeDUEKTToqtLZFVMbjYLUu5T2TfDX8ljWDVVyPizoR5Fjb6DDFpWcUyAWARHfMZXm6tj3NikWraBnluArU2mcg19iu1urAqZZHML5a7DpCij9rMiwtCIv+USeiIbTvpHKVjJj7tHnLYh9MzkBUjC5Em7I99+QbcGmejJ/owAXy5noASsXm9FDkMdgjJIdMXpShax1q68NGoTWMXu8QTSZim87Wsft+TeCKSMZfM7od9PfpGyNFtc2r6F+zB2JmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8qKkfcsjoyEHNBF6XoQkBFVCo6OKU8BpIdAlkv0KUY=;
 b=hQu8uwjAPD2b0+2hjmwrRpZG+PXidRhmo/LkMHtPkqPvjq+Y2GF/ydKKu0YKEzSPLKHhy6KJw3fi0Nm2Ux03k6Y44Rh8VtZrYXyCXj+0U6TDd2eGmM4HgDYx2Q0GMFYUXClHWFEawxvEhPSL3i2NXxbu/ofAhnEC4L/sCqjwKYQ=
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 16:36:00 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::93) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Thu, 14 Mar 2024 16:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:36:00 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:35:59 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<yazen.ghannam@amd.com>, <muralidhara.mk@amd.com>, John Allen
	<john.allen@amd.com>
Subject: [PATCH 0/4] RAS: ATL: DF 4.5 NP2 Denormalization 
Date: Thu, 14 Mar 2024 16:35:23 +0000
Message-ID: <20240314163527.63321-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 751b6a88-c641-4754-bc78-08dc4444d508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a15+NtaXcNKRXSsi0u9pVNBdTvUlQ6pYm9N3IB/Jj3B9YrYIxBeqJBnnlxc7G5oSR0b4HwYYKSOZQUTnVDwTXztebp+WRa8ekA0jfzv0MpFsQXYJuwPuQys7PyJE4tmNq9Oh6l8tHp3BlejrWaZzF1m5aJmD1Vtmt8sz1g/zw28Zmno2M8Hc210CWWcW0uUrRM4fjvaBRsmogCRb0vE74u9vrlL9mZktngqJpZaZiHEvleJaREgkc3jO2/ETZFdOTr5/pZMyKW0T/Ku6x4Mi/VLVTG7xuGxvzfLtAHl6xFVTt6IjGyAP/20cIonFleEi7HkAr3lf+3UOE3kzYElFavJQ9N8jIwIEFeSaMRC2znoKL3/87YfCGMyvOx6qry4LP1+po2tHpXICmD6b8HGXXM1bevWn3Yw1D5lykzl2mr8xzMtufDFqIswyi8RdaqqM5SpDIcawMB0dwX32PI/9MT7X9CDFGJkqUAAl9pIcVdvLk/OrH2hCgn7SexXibxBXkCuObcvLpweJHII3CPD3c12/n5bDGfR4GTVbwkRrV1oHHYFUcqjHM7FO5ixhS0t6HtXAjsXoQSqxwwAQucXittJ60SJGLvmVgoTTsRQ/JsheTAZC1Oq3QcG80B9QAC34m57NkbWr5ttdx6Z0mfPVauSVcBDrTxPmJAIITaBvzytUjdEcXrVjjnqaNh4ZuoNV0H8jLpYsWG6BJNaZa19z2TwkS032mEv276wLw/Ib0UzzdjtiRsVW5hU7pkPL7hE1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:36:00.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751b6a88-c641-4754-bc78-08dc4444d508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239

Implement non-power-of-two denormalization for Data Fabric 4.5 in the
AMD address translation library.

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
Base commit: bd17b7c34fadef645becde1245b9394f69f31702 (origin/edac-amd-atl)  

John Allen (4):
  RAS: ATL: Read DRAM hole base early
  RAS: ATL: Expand helpers for adding and removing base and hole
  RAS: ATL: Add map_bits_valid to header
  RAS: ATL: Implement DF 4.5 NP2 denormalization

 drivers/ras/amd/atl/core.c        |  48 +--
 drivers/ras/amd/atl/dehash.c      |   2 +-
 drivers/ras/amd/atl/denormalize.c | 530 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  48 +++
 drivers/ras/amd/atl/map.c         |  37 +++
 drivers/ras/amd/atl/system.c      |  21 ++
 6 files changed, 662 insertions(+), 24 deletions(-)

-- 
2.34.1


