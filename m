Return-Path: <linux-kernel+bounces-149898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50458A978B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C7281CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE915F409;
	Thu, 18 Apr 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwViZNv9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7415E1FE;
	Thu, 18 Apr 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436569; cv=fail; b=QzJ2ECD17XEtxeF62VwH5wvCIyoa8Imkr/CG9J9QYvTyCmHIQv2iu/EEkx7SmntI0RtO+2dFwPJrp4197Ky1gm8BVm8EX7rwalojpolEPSt2d55qyWXxUH7D16OBJqOVrTNc0H9AyR6RI+rQxgg8E0QugrKvcxpvhrleR0m8h8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436569; c=relaxed/simple;
	bh=SdR8AK9p5eXkXVsxuQJGJMTlfnSMm8NrhQSC3qadvTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cesqGIkxwMDreSqADvZpnbrEnuJ00qx+G8Juz+3BKL6johYPi7KmniXrF9Fpj/jkC78pGB5AVRdeAfVBHDq6Z7KNPS6fCRDhTVB3C6MeaCNwMPtzGeCJY3yxOZZ00d2X8dVRYZ3OrZ69v8JhW0CB7gTlbENrzMv4CXRwU1n/vWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwViZNv9; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LivQxhbOSBvtjTfLMtm5o+Z5iPGQLsHImjwoktlrdKrvLTK4fi2kw1Wepet8RKXfpV2a/hKBSeo6tc1adO2/786tYeIkiNUyOJC0Gp3vwP4GyDe0W7PswOTs9ndHddn5rWhdrBi/VzQR8spqiUQIfpQyrGZB6l7+hMhSJjK6edF0FF8qzBwgb1ZKOIzej0kFIn28fxE3OO3wADYQiDmJiLAl1oTevPv1xr3pGhVidC7SRipf1PiixVSk6ttx2NTwfKiWvHZGG+QsldWJxRahXBHTk0uXR6sS2b5CaZEvcv90bBc8DHHF41q5KtaTmqKuKks4NtlW1fE4efN0N9oGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=mOsqw/RAlLXQ71Rhnmp8g4Ip3ER5SpfSdsijFAZjoXcWgNWnUe2Iy3PDmNGN2IDgPtZiqZ9L9L6bPl+4X1UDJHateICJE0mO/NF2Unhw4W7SkiCo3hhsesbUSywQIrOlN3kPZSmQGtTpJe4SglfnbgxzYsXbPu4sQ0Ab/8LQC72+u8FspoWIzM6F/cdLDWToQmYGs/siTlEiDqvK33r+BrkaBBboqqeL3upMvLTzuC1v5HO0hl/23IrRo2oN3jadrFa3Qb0cuE0BRAFQKD1gRodK/ZCf06fTyBRYJ4KYJq45UIyRgEV/TgH7+vkFYhWa/JedMFHT0c13L7G1n70s+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=VwViZNv9jD5x8aKguPss7XKdiyF5FkqxVz8nd8jdXUrX2kk/OBOS9I+GMvo0Fc0s3bCjXBI3aCBAXMRUQLejoscygHJT0x+QyOaDJAKz6bMEgOcXKIjgzwaxjDbg0Jj/UIt7ELow3OPjRhORgoZ5eYs9YS9nHpaJsY98yKp2l/Qpmx2phblTnS6tMXLFygRYAGUBXWJfIGp1Yml/RmJ3wNMl6aYES3FSHZZmwF0xsJgWk83d4MD5hNSQwxONleTXvRN2ap6kYyo1KGUwRq3NeFbmIn00xez43R4lx5yIRXtcKUjuOtbe+G/zDd5Rf6dejqpLxFDwN1UoFP0o2aUFJQ==
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:35:59 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::24) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.27 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:35:46 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:35:41 -0700
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
Subject: [PATCH net-next v4 06/10] net: sfp: Add more extended compliance codes
Date: Thu, 18 Apr 2024 13:34:51 +0300
Message-ID: <20240418103455.3297870-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418103455.3297870-1-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f36739b-cf73-42b2-5532-08dc5f93567b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	saf3X4pX78tVNf4/NJWvYZDuvXhGRxqidp+Fg0UTiX3iOuSNm6ZHsazzs8gx+GtOUDAwbEMX0GbKELij3Iyb81hn4wv1r8RJgL5kFCkTt+koNl/sxFuNuUK+P1nRz0bBjjSJRPQUTwh6Ibb2FuVCNukENjlL5olL2Z5UVTQ2qHwTjdv8iJjebv46KbOYAgiCbz5SNlz7jW/I5Km8W+HZ99OfQ9QoJTFrQI6S+/I23rEN2AI2vAJ0V58nTFuErV5tuyof1TZo24zZkTO96JHQ//vK7ViRaNY6qg/ah9JhIQ+i+LEiXR7B/ByhsUmJ8EwrD9oUlh7+59bZ2E//v9wN/lPKykZP/UR/4S2Carhc0tXFndcSX4tHyGdqGng9iAcaCz/03p9+ciOM2kw59Hj6Sl9BFT5eyrEwMlaezsuAqEMZoW4KYLlkAQWeRdIoLIRjMBSRdn2slaJUJRKDurLdxMYSK4xmrUqxgeD1lUpcoI1x+hzl5r3yGQopFCGvUAwT/L71BnfbVkdVdu9pijsTD0J9i7qFJnAStOKhZ2UrfyilNAvimY5YRZKixwxfTQ2+jbOZoBXjzQpJXh8BDAtHC4aHGvEr9oe2aF1cbuUXC/8EuRqIHk8f7opTz3OauxRlL8vyd5ZYJi4+khoIa67MjuDkWAk4+rEOK4JLTkrqHB/OP3NvzGrcPzZzZq4X9csauW73YlDnK94foEFcrRRaCWAxcfBuBqvCRaAsiOacaFHY72c79NFDoJiQziI4eGio
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:59.3803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f36739b-cf73-42b2-5532-08dc5f93567b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

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


