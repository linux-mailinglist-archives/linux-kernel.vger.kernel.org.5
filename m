Return-Path: <linux-kernel+bounces-156965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344848B0AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589411C215BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EE15EFC8;
	Wed, 24 Apr 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5bBNyCJ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815D15EFA1;
	Wed, 24 Apr 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965501; cv=fail; b=kL1wnRS/zbuuriaFipbWjC9Mj2HDwLsh8qxanHQf5H4mrBX7HCTPtN+Bp6sXXHPMWpRIfWB4vvE+//zZCuFo0D8XCr9QFhP4caHzzW2fI1gdGzml1xFApiS9PcwzcWD3vC7YyjFASbIVUP5QThEAGNMsdZcWY4heT0bqmuviQzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965501; c=relaxed/simple;
	bh=SdR8AK9p5eXkXVsxuQJGJMTlfnSMm8NrhQSC3qadvTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjwPClzwBQUIpW9GE0U8KnPkTcwNu9hPxor/OPfU9ZdwVz22Pd62cG8BXa5WSHxzIz6pprlZxtejl7EhaOA+W1urGqqIsvH8NxNQtQcysJ1HcdtMYWbIZ44STwoW2hxp+BS180JzpALyctR9K0sbIWdGzSlyC+Nd7DtYFnILTig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5bBNyCJ; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAAq6J9VPTadhzgwiyCgdSef4KdCIyA1ksKJTAflgvkap5qx2J5qy4KRGTo0NiujyW1Ue+/kOk0p0pYp1V+qmnhVmuPwKtsW0EO4lkN9GIS9XcI85ooBqokBO11ty+hp5TzoYsGYOirJgnjT23LunI801Z1uFy0+tliAwr+T4X6LzWhuCraVfDc+sfb6Z0GpE9aTT3w7KRYBO2ZSstFeTSe/5z81itfWfWhR2LANlcA7Jw7p7PFpZSuYj/wWOmM8wop6+49wdkClN/+gndA5NOtz/N0wv5e6QYn3JDY/GE53EtWrGGHNbZ1A9Yht7io59mvdXt2z4HrtSCTmgDjCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=Jb0Q0hHPCLHwAzhGHjZCwbHFTZcPatv3X15juaH1U2YfRj9UZ+fQOrWrB/J45/qx7XlgdngfcIva495Qn7Fp7xfU3oihOLTfYcqBkjYegNdGjj0oCAaCodZloJhU84tQR/nOlPCnzTgN838fPRcwMPu+EJby1B+26yhwzymuGUt79wVdjolHmATkJNIZt0my/WUmV/GRF7HlKf2Q5Q3lhYH1d/cLMdY1TeGIloqisHV2GGQLbNFyE4+KK75rOU+USsTh9aMdIKXAnPeqwG4Tu5PnhSG0CHA3cVS/CCjhaV/l5Nt8+cC2gM1T14wv/PumHK3hGtLTnms42E6bgBqtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=I5bBNyCJU193Hy+APAV2lfyWHm/DmwtBioHwxHsrhw+gXypVhxj0WAHStxsTBjSu7bhAiI/ql9C3bU6+oh2slXHw7H0462n6kadpwe2r33LojQMV84IJCVzEWVpjp2FR9gDT9C9FXBRmNKs1DIvDOM734usF3JW1mQLCyJO2ft989Dx3DWrNHLhWGPPGGCxjrZil/w2NLsLPox4SFtfdoSADJS8aQcB04mYnPlezNw9/vFSUEtZ83Y+akYeEGfXMwuy4P0YVYOFsty9cQGZljaGdpp+Tf8uzaM9y1Y1evMZ9LPgTApEpxHG4KkELvdetj/hiClPNyWWeT1Kt3JYavg==
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Wed, 24 Apr
 2024 13:31:37 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::74) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:31:16 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:31:10 -0700
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
Subject: [PATCH net-next v5 06/10] net: sfp: Add more extended compliance codes
Date: Wed, 24 Apr 2024 16:30:19 +0300
Message-ID: <20240424133023.4150624-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424133023.4150624-1-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 486e89f2-20a9-4ffa-7e56-08dc6462ddb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPlJwzyfs1ZYI+1sZ5P4Dai5FehC4mgZYpo+BaTJmrPwycTq2aTJ3wbWzZvU?=
 =?us-ascii?Q?hLpTF87zOtfU2ql9bfWJvnc+PG535f0LSFei+Jiq8rteYS/TapKfPzqqnJwf?=
 =?us-ascii?Q?yPiuBOum4XRANNh08xlZ/OAlwddTXksbWdgM31h8c+fhv6S35OCGKJid2FfE?=
 =?us-ascii?Q?8hHv7mEFKVDoPvj/ywjZcQRZziREPfgzva4jNVPv834BvRaFSMIVUP37375W?=
 =?us-ascii?Q?cGkltBTBARqNsiaK1sMXyr0KG1hE+3pvL2Rx8DwkMpGkEWdCXPAAIZa+WvSh?=
 =?us-ascii?Q?bRjOSS5gwYtsGcpBPEWzhTtEtGWY7MFOtt/x0dcqNtcYVDy7kw8ZeDMi1hnZ?=
 =?us-ascii?Q?tgcJbthyhDHKabGY6h65mOphUdBZbW/rniMqnNcUdAyser0OotgveN/DEJlq?=
 =?us-ascii?Q?sTAgkuWk3LOCOUvrgsUIXUAFT5q9Loi3yWSU3tGtQ4yT/xdunxGUH2pIUpZC?=
 =?us-ascii?Q?L6ybGuw7eIix9Y6Ov4ow89tA+0sWku8iDJsFeHmu3/+gUXF/rKkLgq9ittM+?=
 =?us-ascii?Q?AeyoHIO+VpGASCrlkS5mF1byo6FuT/yfpSJr1rc7rXxcD3ZepKXnSOih8ZIU?=
 =?us-ascii?Q?v2KSte9/sran4d6nA/DeTtukuG8EgZTe8ygGhznTL+fCHj0xPqVyR9d150dG?=
 =?us-ascii?Q?zKFxVUHEpZjkRBXJAdJn392+355TKOkxgpE6xHw54lIWB/0WDXiKNg41vh07?=
 =?us-ascii?Q?zAwYrgLTey/bavX+6t1UkuA5FzTcwPnYCRd0GUgifayyXJobxGfaAjeqTFrm?=
 =?us-ascii?Q?m8moLfC/DZsCWAMFo8dc0ZmL1AUU8eMbBrP6CRQdD64i7zd8zv595wNvyE9k?=
 =?us-ascii?Q?BRRMrZAYSQ1+7M8J/wu9owb5Rwg/6G8TVD8ANzEJvqEcIj0f+O7xsJnBZ4O5?=
 =?us-ascii?Q?jNS/VYk3tQL7IErQpd+5Wlj+SMNxaD/qDVcLprVn4JzVRjaFLw3Sxoqe/quY?=
 =?us-ascii?Q?fDCAaFX34+9EWGJN+hpTaCZR4lTwKfgv/g7izU/ED2/5QQkhJlbcmzBvDbZk?=
 =?us-ascii?Q?dY9gxc+tL0A95jFFkhsh9on4zFuqpXzrXfmteAHLMd1eeQ2bhXhUL5wHhqO8?=
 =?us-ascii?Q?5BS8zRJEk8af2x92xftuXVBY2Kwxo8Bcv8jbGgeQyYW4NfMzmXjn6miwj5Ep?=
 =?us-ascii?Q?6KJx7UMOX7oQpaUYGtgqlFJRaabChhz7xew8421bWgr3aqNzM3F62FYyEkfZ?=
 =?us-ascii?Q?R3CicF/xkfKb8n6k6UiK0aE8rLQiYh1wiXarOCrHvlgj+Px9zX1zxFyJBaC4?=
 =?us-ascii?Q?bjAlK4P0Rtz0w8qUN4ScuXHDy4jGoYWIY1rNaf9MuezBOztWZROzOLwxCCyj?=
 =?us-ascii?Q?yfkDLv7iRzy463E+PI/HrmOeEKa3CvapGq5iEyLlwhlNhooWBpuEfd5BbGzg?=
 =?us-ascii?Q?VSJ4HrtZ1qgwgNZtAYsQGIIfBpHJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:36.7033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e89f2-20a9-4ffa-7e56-08dc6462ddb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

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


