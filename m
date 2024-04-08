Return-Path: <linux-kernel+bounces-135369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA989BF99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A97328158D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8F7E572;
	Mon,  8 Apr 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f49f8Feq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EC7E0FB;
	Mon,  8 Apr 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580897; cv=fail; b=svy0jqckjA4b5t5avg1TxgSFFIUaPfd58wFC+x93gB9ypZEPE2q95UzuCmmaw6FxcmJ6Fp54NSnHuklTFzsYUUED+nUbooj9rmJlg+yVBerFhUriQinQq2VkTNRm7SfqNrsV4yuY3MuKvnRxuLcbxM0JW98asf4ndqfH2Ixs+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580897; c=relaxed/simple;
	bh=gFnVtXXhF2E/aAopuLCHH2MMPH3g9JGW3jTst6Ba3l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK8y/+42YW7Asp5dIFqbg/WCjP82vA0QDrOKNhOYl8sKwZ6TKNAtnj7Kw08UGitpGRvXa/4WKu3FZNonLldKjF2a7cxJpM8UKUbm4ZnTvrMu9jMMZGKjhkKdcrPcNl7fq7GHZJDNoJynACaxnBO/2/z+hsRsKQiiGpQN3BCSamA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f49f8Feq; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtOTEveuNDXchnK5r/TGHu9pwjLG0OzA9RD7iyYwGORwZV7gOV4Z4Ei5eG1dQdeJ6gIGj7PewQesLgmXs2jV/KMfM9XPoGKuocn42rjhxwfZLPYfFy1OChTQCaekTGnVLnLl/ryjdTC8lZnIANa2bTMjidrDo47f7lRD5zq6gXMmKb65Y3nkU1Xv8IdV6B+XUKUVHyNwIUKJTp3HUNv08imKT1n5cAnxDYbRyQKg4UQKCygR8W49hKE2nAXdJLZnEu1xDvUaG5rLHYwZo1WrQsQI6gAksTGx846+rv8aFMYa8d7DNWmjuBH8YAGv2aBirjnZssooWI4uvItTy7EXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbjvCQOZtFbYLZNNg2W7tfykK7mijM++KCZPUQhNBpo=;
 b=MdXtli/iep/6W5eW5Od8LVDt1mkiBNHicquSsyqoU5qX0Gf2pinsosr85idHoWTtwLCAH9hjY/72VfTS0kxZOTz+Duwg1QoYl3CeEgdzY0RNJBkGwEYB0a7AymOgTbe9EKVfF+pLM1u0EO7ZCU5gxeLs+upHZOyjQCnv47/VprPX8FfpE2PTFcrWY/YTh10ZV2EPtwpQaIUhOPtwr8K/i3LGlAoqSHm2Q2GvMZorBfXZDpXtYdXk7fasDoO3HKRBvTYUjC6ty/whBA5DsOjO02zAZL11QbSBG6BKIGB1SXy64NXWBsvBVZnxzGUv1R6tBS0n1glpl61TdfcWiTswew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbjvCQOZtFbYLZNNg2W7tfykK7mijM++KCZPUQhNBpo=;
 b=f49f8FeqC6B+VjJdNuJKcHwTiuKb7uxXhfh9Fb/s+I6jSRv+y5Fmx7GfbRaNNwV4TwkgRVEKMYhr73Y4zkC+xL35JD51KnBqhbcr/yxr5vy8pDTCEuLuwG0nC45zLGGEoW91HuA1KisQpiJRu+jzQyD0fJLmbulbGOPdY9IQS/VNqpMiEm/LSY75Ho++4f46Kx+R9hmvHSISTrTEdfEyRpWXmF8AhinuzijBfc2UA1nviH1rW5dNEDHQ9IGnKNHzDk9wGNyoqk29Mv6H6iPIKG/H5TH5nPr3y7EnVinLCFsvqxG3zXPyg2mYIa4U24llgX2oGdGNMmEDSsqjOZjlEw==
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:54:50 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::85) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Mon, 8 Apr 2024 12:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:54:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:38 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:32 -0700
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
Subject: [PATCH net-next 06/10] net: sfp: Add more extended compliance codes
Date: Mon, 8 Apr 2024 15:53:36 +0300
Message-ID: <20240408125340.2084269-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408125340.2084269-1-danieller@nvidia.com>
References: <20240408125340.2084269-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce3cfea-3be2-455f-e980-08dc57cb1407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aTuYY8mjH4UUueGqiOgai3gtzZ84z0uEgeVoQUdGfKnWGlM4rN4AfOx/W58lMvwPe+MvHrom4ouJKb1WPbKW6cpgnJ9So7Xf6w5r/QavPUky5jC91v5Mdf/vUvQJ8mvj55iKk756vCF4Shh2bDbxp99Tq6WmkWgMn0IOFwU+DDsWe+s2xEvofnllcKd6KMwtDszNaGDz9bVD2MU/9RwJ00erUZmjpUoJeg0qa8J74uWQ+JC16m8tQouW2T2z+/DGb7Jj7BivgO52SR/SNHa+0EU3KBIcJdtGsyupeZFD9LeTjsfGPdTyIjOoprNrl1rBhzucCm62vzG/rl8BLR4xU8VXq/lYV13Sy87XmJeE5vSuglVenUTOmA42UXr3G7eC4NilWvXk7ye9thNGGNOu09qSw2lEd5VSGbRtPKDyWg8w+wMjuCxACw2Nrpb/l8vwm+aKR1xiEWIQ+iR+zkDHvHol3rQYebgZade/vnX5wODemW7KwUMJyIER8llmEKSskrUIntfeqgQbbSF8vJ5gQVsNwj6bsDM6RslOueLUMOYKQ96x5lo/a8megQ534E6HyIEUEKoOfAM811B0kBInENbDpnb8E5ZipsA2LXhpZlUD41dLDqJR4s/P31zXWbFDQHo2dgii8snVwMckLqTeWVkkxXpfOTchY/puqAO2IotCP21W+deh61i6xt0W3QX1/7DaG87xIWF++n4amkgrum8pTf7jn3SpRvL7Rik02j++9WIdt7VR+M4L/Ya75ZDH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:50.4401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce3cfea-3be2-455f-e980-08dc57cb1407
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

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


