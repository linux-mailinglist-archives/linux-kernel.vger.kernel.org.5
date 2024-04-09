Return-Path: <linux-kernel+bounces-136744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850BC89D7D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF101F23B47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239A86AC2;
	Tue,  9 Apr 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oBI1jSGN"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56F8594B;
	Tue,  9 Apr 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662101; cv=fail; b=elBg/c4gW0SRQij2XcnyLgZ9VPVkVOPtD0QWbUMRxlqd7D+HDWj2WtBm8cWwqwQEVhLe7hHrfBUI+FOdXR0pAUMaZ/8SSeb8xV6R5EqTmk2+RgSAiljrNWDymUFR+oiD2KR8LPbU372vray3zKH1aBJrIVHuy3gIR7Sai0qvB1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662101; c=relaxed/simple;
	bh=xwRgh0FAAWVlWlc8+FfKs7qRxK+7fH1en/N4Rk8n4MU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lN342xHyFlH7ossqD8gJZCmANjmu3UAT7hpM48e86JIAlJXs4O9ED5pxrCCK5YduVo0nYlV42keA1yr1aKCXEs3IsoOrCIYFd8AJglJOv//pFbv52gYKo/6gCdxU8DUG6S01Zb+bhm8Y5jWM6b4EJkG9/XJ/2o3lIZ1v5mM93mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oBI1jSGN; arc=fail smtp.client-ip=40.107.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMjBLK8vQpkAlZzC1SEhXebz7prS1AaGKhLh0Uo6ccgQBRJY9Ox4PPSiaqZaCfUVcKBbo+nPqrFlUkZ4rVuUPpV1sxwtAyXFvnYj8vN6pcUfRnDBphNjR7dvFMCdmutRL72w4Kry/lmsaRBSlBBmKsFPOwWVUutCI9xbqcVsGFrsNG1OCmIXHcV0f9RuLNhS4akNAdhS3C/ucrMLqsgjryV7xNwkpjt1QAHyByzmRR3p6EUQNuJCJcKUNnIbtnbcz6PUVlfgRd1GiES7GTJgw7uT8PxrjGTrAroE7r9TlCca4jm8MuudFIRdk3u+ImwwuuNJXsqkPiNSE3dg6Qex1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAoiTJu58YGiL5bszvz0adIiRLBgssFaAX4OsNFB2nk=;
 b=RWdkkUjvtlRMkcnEpTKQYhz7SZ900nxmpT/9JmUBPFcBHB9QYK2Xi9oRZOVXemZJwectqgXcBvOZqWJEp93On7kcZgTdSLyu3tIWCv2J0hT3Sd9pSWI4jNwPVmqWh/o17Y4Wb0xR0T9oslAeGQGAJMkVZ5GkYwwMfftHzGLaNBFrDyY703BC0M4FsS5YqMtYMIbWtB1C4ba1S0YGLiLpY9eQJf0FJGg2H1aEZLJtWuqvTx80nR/rBrVZv3SHCM/bnPiWsxpOMcik1avz42ypJRY95XBD5TL/vrFXrRE7BJTqJ9xrYExIn1CTiHCyd5dZExJIdJJobMppayrmX2Xppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAoiTJu58YGiL5bszvz0adIiRLBgssFaAX4OsNFB2nk=;
 b=oBI1jSGN105u8UJCLq+OlO/IfwXNTozibIRlMe2rjJ5oLhzyaYK/kr5iPfwrf/Pi0xhJwO8Dg3LaPfxtPlZC6N7afoAavR2tvM+lO0Cd+ue9yH49AASo9ccd6rw+PcFF5DP7TQUNQHSQ8MpzBJM69jhY0ImeV3uhytKuRNcm0Ew=
Received: from AS9PR06CA0413.eurprd06.prod.outlook.com (2603:10a6:20b:461::22)
 by PAXPR02MB7910.eurprd02.prod.outlook.com (2603:10a6:102:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:28:15 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::ca) by AS9PR06CA0413.outlook.office365.com
 (2603:10a6:20b:461::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.34 via Frontend
 Transport; Tue, 9 Apr 2024 11:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 11:28:15 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 Apr
 2024 13:28:14 +0200
From: Rickard Andersson <rickaran@axis.com>
To: <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<sfrench@samba.org>, <pc@manguebit.com>, <ronniesahlberg@gmail.com>,
	<sprasad@microsoft.com>, <tom@talpey.com>
CC: <linux-kernel@vger.kernel.org>, <rickaran@axis.com>,
	<rickard314.andersson@gmail.com>, <kernel@axis.com>
Subject: [PATCH v2 0/1] smb client hang
Date: Tue, 9 Apr 2024 13:27:57 +0200
Message-ID: <20240409112758.467112-1-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|PAXPR02MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3d8131-0dc7-46e4-0f2a-08dc588825b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hsl/B87IJ+8byIpJ8r7apMGMJ8PzUiDSjSrCXM/1eBjTrhXhZPATZpduT/pWdwmQbipHgt5hu8/0DpJQhL0MaItncHbldezVSR4nfsJEoBCp3pBqe7I/1Dn4J84Opy5QtUpYjBD4eSCrqXCkceGa2ipZHFtT8UOIFnG9ShIY/1JQ2efNozUZqn/R8yU6kjVkkPYTr6qwZSMXCNdAKelIX6xDIy5zhMo9tu1AT2fcB8ljVafSrfYuV1rIH2NuC7ud00pGzWPkp9AyggJ59ENjtzASzcDLsEpr2bsUtAB+Tud6uRWn4ZWgfhlaPIgDO06EO2SDUtybu1bedPTeywqxRNGs8HruBdTZTSS4m2Wn7n2QC7auKqmCO7Ej8f2PzqbK9FSiTMSDgXDseurLGjBd8hfjcqNAsg6Q1V+QJ91qBFyxDGpr58ogrwtsG21Wc+0vLS12F1t2/dNGWAqDf9vWj0b8NU5gep3AHwz02owJ8VU2cDfNEIF/TA2DIP+lMLZW7nlztmqleTaiDZthu+xfRcCZ6HEyI+WDXpxAVMSGeVSsaV3rlTcECYKTbd8aZnnuCV1v3zll9mrNkDfAURz0o4bMnnFTsF/D0GgP6zHSRuSTmawuR9uUOeIMVpt33tTvNlrLlDLkOALuRte8uY/KdYzbXBMS3e7lZUg/4pwa1Vobp33uk1jF3lAX3gt6fQPwAezpid7Od1919yBLXwXj77ztqaYRwCZln0g1oenj7Vh1ilPvYMgBz2kd4zl21H3H
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:28:15.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3d8131-0dc7-46e4-0f2a-08dc588825b2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7910

From: Rickard x Andersson <rickaran@axis.com>

When applied to Linx 6.8.2 this patch makes one of our test cases work.
I sent a first version of this patch for Linux 6.1 in October without
getting any feedback. I have now tested and the error is still
existing in the latest kernel versions.

Rickard x Andersson (1):
  smb: client: Fix hang in smb2_reconnect

 fs/smb/client/transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.30.2


