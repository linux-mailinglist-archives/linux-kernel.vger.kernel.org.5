Return-Path: <linux-kernel+bounces-148186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD38A7ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF981C20B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D613C3EB;
	Wed, 17 Apr 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iBYYDi5w"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418713C3D8;
	Wed, 17 Apr 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344100; cv=fail; b=af1V8iFsFEtCxTV0n+r4K79TTgQnVRE7MKpu2WkFBDfn9MZg2cYxPruK2h46FMLL081jQh0OGSiQ36te3uXcVXhimsItId5Vp/5+x9oUiNg2p7eSSjDeYuXNOw7OPIDBrxVicWKoNx1Z/i9jYHN9uH+WYgIs1v2RcvcZFVpKytc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344100; c=relaxed/simple;
	bh=SdR8AK9p5eXkXVsxuQJGJMTlfnSMm8NrhQSC3qadvTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OezLtNk5P5qu9PS+iP4xO81QxHyDGDv7Qw2h9Ykpi7jDv02WXISXt6nXRku7rPwkOVfKxbWgL3eAU4Kp6Q3PpVEIui6cEt9cNbUvj+OwoBWRDd+nSZFOFiGgr7tIMtXYGukygPpKVijLbHd7qeR4LC0tmmmeQ9vnjPr16qoBNdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iBYYDi5w; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF3Z6I7riyhguSs8dm4z6EX9FuKgY4LMRlol/ZrYmwp090kwU1goiZaeyXkdXHkH2sGInMsXL/UdrJRQH0pb7n06YTfS6rDzvtufSIPB0UBCbMJpd6eyGd5ASRNSHb/nfrhj0ut2qxAWJeFuJ3OubwWEnhX2LgkuztZr6aEy3UsSwFyG3XRIPWBH5yXP20x13nML3EHBeim7v+pY6rZCJzhAoNL74Bq7PFeAv6Gsv3+8tv7fpxKHLCVtd8YDXyh3I9crYoONlk+2+KsddZ2kc9CTezgVtO71oRm+rkCH4pA3HWE0zEue+nNRv9pFPKT5BZ/YbNcAz/d3CVriYytMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=WOupUmA/PbZZM2Jl4j6d/P5H/ZYdBczDizmo6507Qsv4w5j+T+useDdWSIGDIn4aXdi0HDac4gyOCOzTJEdKK0OKtxMUB1Bk/l8RxWxc8ZpSJlZ63f8ho5AB60ixF2vqnugoZpH7DDuqzUd5njoQ1z8yCkJZfBMp3HMpP+PXMnF7rkEZyNfiEEDSAFguaNbhugH/Q97ADHWlXMPj1zcQ8dQb5vKXYN4Yu3mRankUFg6UOWP8CuIBw7YN8SVFLyZg95s0k5Ygfy+lJhxUK/bgNBZjq06w1em4jPAfaEeg3Z6aPdkLkUXE4xmeo6k/CRzM3w0w+27rs8MbrWnnhwCZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=iBYYDi5w3G5GNfQGgLQsQvv2ihdumW3xHVm62dwEyRdkhx8oi9dZ4qLAQgFF8TdYW/4JeRaxB/cesIIlaDzm8GJbabgMWAT3uc6PMoiMhSblgTiITidKgfZCbvhjSrBvrm4qb6UGR0K1uiW8Q6Y+gQeu2irybrxbN1/GP1Xh+1/VGeWs+zpyuxsrzOYpWJDpN7Rm7Td6jaPmBFigrk4jsGCLhJaTfaD9GSYZl4desOUCQtSmnoAegq36b5nVjEsGyd6bZGHbXugoaELqv8mljeP1tS/vI+PnVhY5eVy0R1fNpKgbkfz6bLJ3Z/FPjpSTtqOceH+AaL919DVixMk1Eg==
Received: from DS7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:8:54::8) by
 PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:54:55 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::b3) by DS7PR06CA0053.outlook.office365.com
 (2603:10b6:8:54::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Wed, 17 Apr 2024 08:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:54:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:54:43 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:54:37 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <petrm@nvidia.com>,
	<idosch@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v3 06/10] net: sfp: Add more extended compliance codes
Date: Wed, 17 Apr 2024 11:53:43 +0300
Message-ID: <20240417085347.2836385-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417085347.2836385-1-danieller@nvidia.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4707ea47-76b6-488d-e65e-08dc5ebc0d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2gsZGOPyzlkL88jt+jI1OvmIdCTvvdcXM8d4PebKMkCRnnbwB6mjvseIGtRXsvOUtzLPwy/jWoMuuDDfWUGuPE638EDMZE2pic3tT5ur7oXTPCtNqhp4M8Zmu/G5LyrxdutMPvkvgEQ4pVvGQX9tL8PbPW8IGJ9q8yReW/gk2dA+OTWRoNsrDASUL092MZbRkgmeGMSwCdPUrYmgSMW7bwt/pHi801qMdrqkDaNjX3NfvTE4y0NdHorclz7zUMYSbuRC9UNxq2HqWrWC/QjgG+ev15Oi5X7NxSmLk/xsW2fOQec1Ghh1QWku0g+4SxVRIKGyiS5q3M+RySgJKQhqILhwE+1WQfqtRkHOwiC28Fw/iO1JDPm5zeG3h2b3lvNrBDv93gRXwdK9I4Ps0Xw6JSMa+wCnKhUuluuyvasnVIljgncKD4x/FXR7TI3jTCXyhjkYrNnKK8ujHdi83T6op1a3kHp5jpg01E4CY522bAz46je1+2PLCFyBEcFGf5OHdl6Yrp/A72EsKoZLY9sg6ZNUkZr67JxUHvIpI9iaFiB4s0EZMlcfczhatXyxSnUeCdYsHQ11whaBawuPvyJRipLzhI2/QAT9mmkJFMwyQCuleW+tFSA95+g7OFfYb3xWFQJKFlpTH6nKhFwqB/6q3Fd45sACaBr4wvFqTTsvsIop2YkyIi56C7gK3D7NoV5VMkRnwBprpelT76c1JoVwlgENmjLFMlmpAjtPM4xzR9kIthdMaxx5szm5EsYJ3KtI
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:54:55.3192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4707ea47-76b6-488d-e65e-08dc5ebc0d98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

SFF-8024 is used to define various constants re-used in several SFF
SFP-related specifications.

Add SFF-8024 extended compliance code definitions for CMIS compliant
modules and use them in the next patch to determine the firmware flashing
work.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/sfp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 55c0ab17c9e2..46c145fa855d 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -284,6 +284,12 @@ enum {
 	SFF8024_ID_QSFP_8438		= 0x0c,
 	SFF8024_ID_QSFP_8436_8636	= 0x0d,
 	SFF8024_ID_QSFP28_8636		= 0x11,
+	SFF8024_ID_QSFP_DD		= 0x18,
+	SFF8024_ID_OSFP			= 0x19,
+	SFF8024_ID_DSFP			= 0x1B,
+	SFF8024_ID_QSFP_PLUS_CMIS	= 0x1E,
+	SFF8024_ID_SFP_DD_CMIS		= 0x1F,
+	SFF8024_ID_SFP_PLUS_CMIS	= 0x20,
 
 	SFF8024_ENCODING_UNSPEC		= 0x00,
 	SFF8024_ENCODING_8B10B		= 0x01,
-- 
2.43.0


