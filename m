Return-Path: <linux-kernel+bounces-48402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240C845B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29AB2858D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBD15DBDD;
	Thu,  1 Feb 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9MLSFlU"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632215DBA2;
	Thu,  1 Feb 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801175; cv=fail; b=YisqPPdvqNVJjumwhX5Al3gRHHV8I2klA3jZUf3TDGO8MoMPS7JeetuFO+OQN3uJKCPnvrtyPOrZzeJMVfwDtIH3MwWMjcEsQPu4H/1MqQOid6ogJAogb7y7BbjQp7WQv5NEkvRqgeXQQnX9swEYHSRa7/566mdh4MKHkP+cQHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801175; c=relaxed/simple;
	bh=gFnVtXXhF2E/aAopuLCHH2MMPH3g9JGW3jTst6Ba3l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk4iTzuFZ2cntrp9morNNzeFAUSIWSMbfkhNk6HnahPt2jK73t4R1TFcExms7i0elYbb2DF8nnw91+R9zDVRTxmdebnf5G8SLF+mJIo0llRgvzXnxcySFXj5YM1vjLgR2QyhpOtOS9eADKWHdFDlp2sXljfTH5VwTFUeVjiZAkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O9MLSFlU; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsYfsKnvudhGJdlUmQRd64QL0xZiEhtl4OuBTYFsymMZBcpqfp3O7a2AAa7u/Y1ihctkl1nj8+woajUFgsWieIpHroXWT5ywkatK8Cl7KGnwGVcBKz1SV6vzUtaoV2NWSPLCOOdb+apKvVxbZssiQdD69nhBSvNCrRF6ZU14Q1hyqn7bLFiMG1t3LFtHL8xowGhSBgICCUIhh8Nmf28Rsm9IB3gP3O+Z30Hzn9Z+PK5DiZxNtzwNTLplWLSf3/ENfVXGeRBssaL4IoEHX3ZnuvIFQstWIlvyK2FYgFmZjLwiOtgldVVOl4sqHW9jldZ8ZKsj1cNh/PP8Fj+TXHwayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbjvCQOZtFbYLZNNg2W7tfykK7mijM++KCZPUQhNBpo=;
 b=fLW6l7wEvr3zEIgiXmu1uSQHDGaHL5JSM6OBAxjCHvTYBAFsxnkg/0Vmooexd9vESQa3UoFtk3pwo3OT7eMEFH8qJQZUu7o/QtSD7zHyrS3b8pK06FtNa02ITsKAew/EDMLxrDP2fD47Eo2Y/x7IAe96MrAZUvZo6qvOSsU072wCcDZMM/PKS7pDIR3X62nhfLQ4MLsQ03g4pd5TqgdeSQIhmz64YLSwyt3BIJMBVNCehhilHTv+vq8Ak6Zb+CtiPdW0Zd21tRX1gGbb+2+YHYPfpfRJO9jJxWxXCaOAcuzFzrnVcPzz44c61AOr/3EFoWqL535uZjqfwXRDyYuGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbjvCQOZtFbYLZNNg2W7tfykK7mijM++KCZPUQhNBpo=;
 b=O9MLSFlUzxwS59bwfNJWyC4F93CVMgZh590nz7CVXajOpxctE7JARDiNkfB9cXjYDg3bBF2sTAJB2NV0lYPBCv0xSaAD5iqIIdV34zRD5iesc19zO27dnXxiEoiA8blNlNP//cqND7NIAaeW3YavqWVNgqZa2V8D0KqyNItkz9hqszvKcYo29MGqTGcgY5Mwrc/cA6xEP2OVwP5HFzhE0fmcc2sRsGxczTup+o7fJR3kIdqBlIpsik6IKNMTlAk8kY2swfFUUJtQ60teFqTWtVvhT4lZIq4wfdylSDPioZonJn0UKVWB4V/Fm7fnD9MaY5nBGBvnYkUW45afEoP78g==
Received: from BN7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:20::41)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 15:26:10 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::11) by BN7PR02CA0028.outlook.office365.com
 (2603:10b6:408:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Thu, 1 Feb 2024 15:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:26:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:55 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:50 -0800
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
Subject: [RFC PATCH net-next v2 6/9] net: sfp: Add more extended compliance codes
Date: Thu, 1 Feb 2024 17:24:58 +0200
Message-ID: <20240201152501.3955887-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201152501.3955887-1-danieller@nvidia.com>
References: <20240201152501.3955887-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc02ace-3ca2-4b8e-5dac-08dc233a1e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7tAOVDV+HwDbeMGhwKrvNCNFhE04wlky0TnM/hvTdq5J/cbay5NayEuaGvnXhthk4nWUk8Yjnj3Z6bmT9uynuANAOGFIkFV/Vk3kS27n2LwG5IOx6oy13NaB7tJBXBdS7dwMrPGU2BQ+QCGpTTrVMZb3n6E9Vj+zD8sr9j+gAZI+IiLqSmecK1+3V8Rl+O5h/hy/t+56wRg53a2HGOBU4/+1j4fZEalaXvHTXzJvAMR2YSHHcJeK+vxEkh3EwlAoLO5ZLPJQcA8VodjN4zRxJX1QEbJBjZPckNqM5mMBSvjwilzGuqcdJghG0+8WtnJrw/f2aUJEKNqmySPMr6FYyrz9JHC3VxziUkhAjj/TIyTGaVi12kG8z+1A/79wPqZ1eIzuxH7Y/MBYDxmLQuVEPxlVEUApSrW7g2icECTxKObGPAQLZU+UlPcHBQamnit/0A/WpVQ89HJ+a/mB3f+4Oju/A7NpXoH5uWV+2zLVW5+s4Yv5zsL6fgMi++G+7gWMMGXKVPwzL9TqynsFAC57+O5gYfIewQh2DAqduAqqPWzRQiuHe3T+9RYReQbPmuQeEesFz9f5b2QcPpce8Zth/CbRLYnNB7u00m6hQB70CdaRZ8unFfo/4RFg29SxQ8mEeQv0wOa4fA/DPKNn9p4pNCNlBV+MDLOTBF0mPjBItIY5GYlkTJxehEVmH/e2TajZlM4yqKrXTHNCCGmOeCyxlXxdT/KkmNo6nyahv1xCyDX9l67PxGkUcAzNSpd4xn2W
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(7416002)(70586007)(2906002)(5660300002)(8936002)(4744005)(82740400003)(86362001)(36756003)(41300700001)(356005)(478600001)(7636003)(1076003)(107886003)(16526019)(36860700001)(426003)(336012)(26005)(2616005)(6916009)(47076005)(316002)(8676002)(4326008)(70206006)(54906003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:26:10.1067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc02ace-3ca2-4b8e-5dac-08dc233a1e4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

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
index 9346cd44814d..df2eb988854f 100644
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


