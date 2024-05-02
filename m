Return-Path: <linux-kernel+bounces-167042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5048BA3CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6631C22DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C26347A2;
	Thu,  2 May 2024 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFrLBBIE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C620322;
	Thu,  2 May 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691442; cv=fail; b=Uglxji2IA6Nl2UXooITRfve2EhMP6b1ruKWofPjopcyqD5r2JWlXBPM8CSosRltTM+/9gAyKrfMm2qkKpHbVjPfyXXMgAnye2MSGAts1EHUK3QrttlRWsxxiwFcg5HUu8BH6aOnwCTIKCedqZnJ57VhJlgtVUn4vbyolASrkTIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691442; c=relaxed/simple;
	bh=HYV6Nx/9pVA0TXb4xhgkn3A2RFm5u9x6T6zQHoAyMHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRsaCjRrc5EV777v1IaOMxkuE6ijvCV5rmBgENQIEcSSy99cioFRbd/ewqcxbICH0+qe1z3ee6xFPzhpLaDG3/ndtzTTYzFToDXA1NBbUStbuDTwQ2cKn2fQpBLRdnxDDOD1zeuso9as46SoLRVK/FYP64pYdQjzc6h00bQAnsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFrLBBIE; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHvrt2Gr7O3DwvTyh+aycXDSm3rawWEwBv4bwxnGGmTF+r6N13H4VVAIrqcDrEtqU1IslKdBTVTRkI4VfFqMcH8SWX74MfEbOBMdKjk6XAUQN90uL2zyktJJy1tM8dUAI5O879uz6Z9BT5CF/KgxOyOZE3DkOWKXD0nYUqAaKHfz9QxagAniMMCKlmDM6rDgjwKqaXvbHoCAa9Tj0n7LbbgEkzjnPltZQEXlmfhjuKYm/MnDXVpmTDuui6+I88+QiK91iP6AEuHGZwZJfquL0PUejXXiHybz8QGMrGABU6n6aBHCaSsQUovY0QRXF6aiz3XkYhuT7CwfUmiEHKqRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUTHSxFxRFuPGLGaWKBjDzlEjY2+Z4E5wkLyVslsEpI=;
 b=ab2h9ZvrLCRZItw9QPB36ieKnxCwTaKysLQa4suCBD+FM0pUjCyKyUvCcjdc+6LJkrDijv8pjkF/gxzmWijLB5ryL9bQh2bfmcjFV5yNcF5zLjIdBA0e7xpPK7VHj4l1c2NM9+VYxHlVEO9cT9MDfsm7inj3Uqf0h02D3knDEL4+OxoJQmsoxevXGrRQd+lQlY05ZoL14K4lM7Xvbusc4R+b4A5hhAAjTnWYn0qvxY26D0dWglij3JfoYEx3u6bYSPVE9fQlfzIHRaECtgJd1/Yaem9WCt1/A0NQWbP8xOhe3Msjq2AeB8pKxU/Sfh1TVsQhfq8ppHZGr73AsMtaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUTHSxFxRFuPGLGaWKBjDzlEjY2+Z4E5wkLyVslsEpI=;
 b=vFrLBBIE7M2h+lhM3vTu9kMra2ivdQl4SvCcnzxYsew3mQormo+cNABSiMC9vkh/rOM1JwHdAqRH/+96mneMwV/8PyXXLbtzLO4RpKuOj5TPl1haq8qjzS8A6PYtggt6Hj0iOXD0EgFTNcwdfHnE4Tp6IjnmHV6Z12sYaDv7GdE=
Received: from BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 23:10:38 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::9b) by BL0PR03CA0027.outlook.office365.com
 (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 23:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 23:10:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 18:10:37 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 18:10:37 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH 0/2] remoteproc: xlnx: Add attach detach ops and sram support
Date: Thu, 2 May 2024 16:10:19 -0700
Message-ID: <20240502231021.370047-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: b1eee907-3441-43b5-1658-08dc6afd145b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6vGCoDiUaCIWNlTiL1BEe1FquI+iypKxMdMBplPIHtI76JgMOTO+jrO0+xt?=
 =?us-ascii?Q?ovjwzM2UFN+RFzWqsxoBzonNiZ6A1NvQhsvekn9oMLPLsCzVdu6oZwUj9DU1?=
 =?us-ascii?Q?0OnETYoWhZa+3hvgiChxbyQbvAkK2YkeVpGRD2tw0zrh0VXh5JNTjYVrnR5K?=
 =?us-ascii?Q?s7+Px2aFFEqS1nIFbTR9meeQr9yjSop3PRpE7eOljpCv6vegmNnMAtG8n7Xf?=
 =?us-ascii?Q?CAYaOwvabocN6GydFJ6X1YAXyohf7DaTdIBnDHzAagSTQzJfkd2CQXryfrir?=
 =?us-ascii?Q?geVacZQlsQK0PgeR2R79m4zOBVAypWAbOOqYQxLQjceCsbKo2w5zpxuQeTGe?=
 =?us-ascii?Q?xj9VOH4fm1hIIgMHPgny7mmDz5ui9yH8EKVV92fZeMT0Sf8/0dFQGQrAbwZ2?=
 =?us-ascii?Q?4mMO/zDUO+e2tJ0gZX8drhJSn19LUxLfxAcp9C6aN0iA6O/HiBD+unsfRiUR?=
 =?us-ascii?Q?2vmH/X1CL/Rx+O9pmuND3tT5b4H3BWghTzTpP/C7qg7deczL6wPRA2N0VKGj?=
 =?us-ascii?Q?SJAlXNErC2BtDM1YPXAZSRbJwJrLTNJZP5H8OiOL5fMyPXOIRDL5pWZSdmHM?=
 =?us-ascii?Q?q2JhQwLDaDdt/z3E5yHuwwfMLehThArr7eM+pKNBkksOiKA7h3cMGbShQgdV?=
 =?us-ascii?Q?dyDWm9jHPJa+z01wsgnUOkMkaIN+O4E7Bayx+Mtm/NgLuC3/o3x81LagMuuc?=
 =?us-ascii?Q?F+PI3Fsm5lYCcmalgwpIl+6vmMdghDSku5MuhTpsPGlJuy4cVua2fK3w8TZq?=
 =?us-ascii?Q?A4Yd1iZiFbhZ1DS4An5csgXBcb1OVCjoE66IS+vELdnDpprZ+BmEnQy9GP6j?=
 =?us-ascii?Q?4kofsITa4aZoJZBBqdXHKjKR1ruX4WjU8TA0CKaavvpC+wzB9XcvI/6cD3t6?=
 =?us-ascii?Q?6KQZAtkSwYX1oziA40XvgxysuG+iAas8AFRux5Kd1gBz8w53cL5uBi9nheCK?=
 =?us-ascii?Q?ZvKXFnTrPc/20gw7WCZOATRq+Sm0TVxnBLMZjvgNaarDe0KCZ2WMgefLnm98?=
 =?us-ascii?Q?8ImUKNarA22HPAKcK+EtOIuASg96hawbWUW1w3v1O18YCzwpGTB+VWIZ1a2Q?=
 =?us-ascii?Q?3veC7a+L9GFX396CB8fFlj1eggov5SybHh8PWj4fvenUdCY23jyKNdrETQgn?=
 =?us-ascii?Q?IoNRRFgMBb5pSBnLxANjBlgUFFj7pK0ZGEIsff8AORNW+sGd+f0ZPNiwTrMy?=
 =?us-ascii?Q?fC6uYri81aTNvC5/+ytKRMRgHyU23I0Mn3x4IGxTf0CoEe+QToHJTXqrWLJF?=
 =?us-ascii?Q?fCsXbekGcS1B2eDcfG1M7WqQYmJfyATsg9plXydo1yFdpXZTuzKIKG9d2Ony?=
 =?us-ascii?Q?B+UBgA6UuP1PWxSooH6AaUatqJjaEKdVk2M20kK4y+nC4j5DAJsV7W6y/En8?=
 =?us-ascii?Q?qTWzm1k2qUPfJGHYebM5IYZSaeNm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:10:38.0083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1eee907-3441-43b5-1658-08dc6afd145b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858

Attach detach ops are needed to connect to remote processor that is
running before remoteproc driver is probed. Implement remoteproc
framework ops that enables such use case on AMD-Xilinx platforms.

Remote processor can also use On Chip sram Memory (OCM) for various
purpose. For example, for fast code execution or data access compare
to DDR memory. Such sram region is made available to remoteproc nodes
via "sram" property. Add support in driver to parse and use OCM memory
via sram property.

Tanmay Shah (2):
  drivers: remoteproc: xlnx: add attach detach support
  drivers: remoteproc: xlnx: add sram support

 drivers/remoteproc/xlnx_r5_remoteproc.c | 385 +++++++++++++++++++++++-
 1 file changed, 380 insertions(+), 5 deletions(-)


base-commit: 0496190c4d42965acb31b9da1b6dac3509791062
-- 
2.25.1


