Return-Path: <linux-kernel+bounces-145034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA798A4E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D252831C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA246EB5B;
	Mon, 15 Apr 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+tmOm36"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C66BB5D;
	Mon, 15 Apr 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182913; cv=fail; b=J1ThR1EgZCgDG6ZTA1f7we40faQAwGKkwI+XMOlm9/O2Gta9uF3mP5ogC0OPFFsXutsaGAFtRquTLekuCig4f+eufY7GhMbBo3cH5u5HulMwvRUHfGs2E1TqWKoEpNPicaUesONPSJ328vnJOSmNzl7uuKmco6YZPELxOEKNTgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182913; c=relaxed/simple;
	bh=SdR8AK9p5eXkXVsxuQJGJMTlfnSMm8NrhQSC3qadvTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heNQ7U11I0e5i/qdspdpzPV508zqcxSbobJ6e+nIgwofA72goaaojgvmx3SPz3sJ9xGl1wSpeWFk9Zm7G5o50q1LTGhzMo8EJavkMUvjjVXH1OWJHOiDIBkwfzt+ox9ZafyRtpk+m3T5SQ/j6CDY/KJbBpXYXOsO3YMOAthQDSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+tmOm36; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbQm4myg36j3g4nXcZfDCvP5bn0m9sU6SWkk2YqDAB7XrHTEcPoRtkxJs3mgDRhL9tWS5oHD6inv0Je2MlJFP5po1LcWPE7W5klK0oiJXhPen+jpC8VXk7VZAZsVvcRONZk3mBzygvKNpiJyZp17Bh/62PVUPGlDwoFOcWvPyjhdGyFaLyC2JnI7B5i68K555EbrwCaa1/G/u+Ll3RXGnFFdzeI+AviNrUjs9S4pYkxWvA4hhdlfs4raXnuHCq5DCMMYhpu8yzyRemY506enYs6W8nQs9iElBN9jGzq0GXmdhrWsAIAypWV9zi7G+FMiu72ZerpDCTA8tUQ/oe8gQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=fjeLHpaZbIglBuvmTvXjWDJJQDQ/vx6Pa+FJ4T014QaXavN0UE2dmrBmgpnSCVG/yI/4E0H8ORBVqHojBquXLL/dNsGJRs71xOmjonzktfVS3G30W9K3NssedmOCngYvJR13Q197idr5ZWWqIM1QknvGjxViHPKRrOvO2H/9ozQpti85hnjSf03vkrMv/H9zdbrMRjbgC/eW8zj2nQDsVlG7hcGKHL5BG7Vm6zXh+GecNCg7QayxofwBFRzYfpsrVrwalPcfbwhYZfVek1mAw2MOWMUUjI/X4te3nSEFHXVBiBqk0nntmcR1ttBwW1VxVo/TIV8IJ7eDTnAPQ+fxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V1UnlOS3EMUCV6lMUtqtDUSLw94CQZRNztlwUtCjPU=;
 b=P+tmOm36pcNKkAxYklHtqwDgAj8LYYN1RyZjA0SHAxxUOaVaBWF5dpdWp784FV5+4XEFwI8LUBcWb/JHql8gah4PA5G9XH9rwqriaoGzb6aztEUo4W8t9wKlm02dBB+etlOdahh01ecomRaEsuFxu/Hw8SoGO6EBlGfmb5jbBxMO7kGC3kLzeQ9i6cPGTno9u2dcv1E6Yz70XU9jNO6wFvSBOuaJiDsUN99vgFlLiSzUukgHl9diHG5orNufMfdmHRPcUxHC/oT9JES5z9yXP8Qed67C4oeqFXOr1bkbZzntQeW+AP/XoXnnLWKHO5ogUk96H1bd3sVrHZvPAB1YbA==
Received: from CY5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::11) by
 PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:08:27 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::52) by CY5P221CA0006.outlook.office365.com
 (2603:10b6:930:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 12:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:08:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:08:12 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:08:06 -0700
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
	<idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 06/10] net: sfp: Add more extended compliance codes
Date: Mon, 15 Apr 2024 15:07:13 +0300
Message-ID: <20240415120717.1251864-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415120717.1251864-1-danieller@nvidia.com>
References: <20240415120717.1251864-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 24653a33-ac63-423e-15f9-08dc5d44c1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uW4PFv1DJn1seyzuMwugsi+gdOSfvcJe0t+rHE1vGD2GzyZHxgr+Ojx/2eBkT1q0xwdPO0I4Z+kbW1JeJl5ZH8Xv6LnIl7nrtPlnkYAN6kzVtavpXT7fBAaVW1M//64AnhN4hd03OlqY7npo230I1hky13cD6Z7REC400OvaiPfxgROmxhlSAMxVyYoxUavSkk+g0jgqWks4TsPaDmKzOVAaAxidU0zDbtmPfCm7gxKu0w4LSAajjh4cq+SAjnmiFlU+DYzXHg8rfFkc13caBNmViM8xYYHz6Yh/HLRdBBUVa2ND1BHn0dhS9ezzQWGHnoXv/vl6PT4EtKtGiSuriLAcwg9t516y/b3imJgfLbPnIoA+loXTxr25VVq/tEvuAlp/QQJo5f02vL3A/y7N3RKwReCrCYP4rpLZdv9nSVgwzj0MWgN3ol+09nxu0vNzqK0rXozKqejOrLxkDVf5VFho7w6SXK6DXnZVZ/oKp291kVeuAz0C6E+88J4lDYSrU3B2+BIkZyWjFTM3WidJKoQPki8mUz4C/kS3WDooynemqzLNZnoBjzKRTA8vvQLAEFwmyfqN6cmtuvdtX2nUf4TBe80zT8ZziLqXDw1bRJ23pWkVbDvuuZ1/nuVD4jMl1gzW5FTH8KRw+JX/sVlGKFaVmdaUKpSY2tOJnGluDlFjpc2KElUa7+ti+bHZW3N0TJ2dGaruW6IJAuETbwHsCMd6+aPiCybRmg/GTJhlk7LF9Icb3xxQmDEycREbTG8/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:08:27.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24653a33-ac63-423e-15f9-08dc5d44c1e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

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


