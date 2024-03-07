Return-Path: <linux-kernel+bounces-94901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1F87467B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A41C21FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4CDDA0;
	Thu,  7 Mar 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IjrPf94H"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04A634;
	Thu,  7 Mar 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780630; cv=fail; b=nlzROLSjmLg9qpKg8caPUFcfU42HZMr0Jfe68BJ6unUxp4C6pAWZPB94a796digCY6HZxBHvE9macjXWr6igrWI77/x8qcY5n/scIkevaecMdmhmszUjh0hIdMhE7w9b4T+Lc78VMSc5sfU3+yyeXcnZW8cWhiKVaeusTVpZ2mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780630; c=relaxed/simple;
	bh=/oaisVswNk56wMPXCBv4ZTtNqW8JPJ/xUI0AqzWDsZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+U7mXBYd1iDXe3LfxKNGqNMrbg14Cq3t5ULViPurp1WajPHaSLFFXUGfB81CncR1OXw6GOzDtDkw6MWh9GAsZdA+AalIFjjQrhqDRy5T8qmAReCLGmE5HQsj9aPgboAxE1F2yti98eE6EnqK8yQZMxTCZ3LjF2k/SXbeF9FOdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IjrPf94H; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXOzTeKzQVcWlQdUgq424T0oafjbFgqMl9lBO68OUHxf1YlgRUeU+uS0ORZzIqI8FOgvhQSZ1ZUwdHQwt40vMzDEEj3rwONnv9uYgtz35WHYJnviiZKx8YDiPro+ODRR57EiLUeRAhM/2d6cDJ88Dv8jPI26NDOLbFMaHG8f4OmQfany00tclH+LM+EbVnoOQDLPLXWU0K3hMu/gCJcojle63EFR8F3GTz4tc8XyMD/8FjTScDVyEHoRUQLT4V42NZsZJ+E4LFZSXrrRQUDMD8AbbJ/7Gpmn1wmNk8/LN4Oqyfp8VcMiRfy+W9/8B+DtKJdnCsMCcSc/6zwh9Uyk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO45lOFvJcLZT+DGum/ICeQlwjklBsjkwhTc+DYnH1I=;
 b=BIv1Kw8DZcf0NtFt/2PSQxrHpy8aZNxxaHjY5RDmIVvFsXP+eRQu3mAkToVMhDOqxdhbVzGILf6m5bo3kwU/hGZht5om0uhM8EXxXdSPq1Q2mDd1VLk5S1lnmFPEZvDyjtJbD34Ea1wv+1NEQhKN8j0+CmWPDs4XIbm91jQ3l3FOp9/JEx9++FGJwrHy1OAIDbvo13RwnK9T5KTiUIPW1DOVtQh1aXvMK0c7MCvH05dxHWkPiB0FpihTVNQx6CRjav470lG6TEMTuc2uVKsxLJjH/PPw+IG+jr8+fGERm07DNn2d36F31WQlmQeAADAAAnwyxL/66ZKfVQN7FK4XBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO45lOFvJcLZT+DGum/ICeQlwjklBsjkwhTc+DYnH1I=;
 b=IjrPf94Hmc/BU3SOjdjrHX/vdO1eHEAdN1QvgDpR6Y2ImQBBVvp/u8xHEHsr5xE8oyc4+s1IHq84uroHyp0xW+I9mMUwrJnSrhGhg0SZgVmZEdKYWsrrUQDkU7qvWRHxvKeCP1BLumtUzugZRnMnUQm+TLWaszqLFjgP9Wb8TSE0TWbaTpcqkPI2p2VKKyS8xi3d+p2/6tkJi+cse2fEhe+6kuAfmUce5E1IObr35sbZAfZff3ToH8Ns9oKVvGaTaKwV6ebXYmiuzrOwc2WzXNeUsgovF7vb0kyHQh1G3erYp8nGK7BwGP9Zq1mCZus5fzXTbPGA/seLzIHehgtI9A==
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 03:03:46 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::da) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 03:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 03:03:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 19:03:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 19:03:32 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Wed, 6 Mar 2024 19:03:30 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v2 0/2] Fix incorrect USB3 phy parsing in tegra-xudc
Date: Thu, 7 Mar 2024 11:03:26 +0800
Message-ID: <20240307030328.1487748-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 3268c1cf-1ae5-465b-61bb-08dc3e5334bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OBpRIP9Q1Y3oOLXlQBRgLkxDcSFec5x3b45pCk3oWhawSnTBajdwCYAaR4O6bNQRdqpWJgT/OKih8RAluys6Sqyd3iaSFhu5K2o19W6xnmjMQb/9I8v4LH36f/w4WiFEn2nZuqzOPRiHrA+pad6+1W0holErXyyW5D0igSLEtgZyuxe084PYlZaCKIfUB5Q+rrtLzXlieZEXUsDM20BCmvsAr5s7/2m1XYujwPX//VF0OO276ETKxzFLt3nGtC+UOPeZ3or0ryt+gfNAUddjewZM/OtXvbcPTtOdpFYAwQk2Dg31TyZBONXkik7oI+EzldVTQh4VC3M8fjswg5jWP9Sek3drTgXLhkbg7MJRWGD2DlOQyUKKQMm+a8ozWQyANyrWaqQOTDQXNZZq3qnECE2GqAjcdtM4xGm7kseKtuiasDGh/Zktz+7a+42M76pYYHXLOVXUeVA8Uc1fq7a0UTHfDAZ4Nk3iwbqiRLvfBdjK44FD97xvyn2IYRkV83H0NlD5chipWLe+kxcngbGYL5HpBINpgsLLAd4khWqETfrCknpRygzhx3ZhgJUZ8dQhun7hm4btKcoWiXmG/OQJ5yAIEO4qJj0ckTZznC6si8YrcUhg6i/uQZxXNjgaErjKMWZ7umJTinxkzncbwUIVO5IzQtZAGJFkDuidFXPlfp+HipPvPR2gG+5h/+3S7I5qmoqFSw6KJ8pJpldHzPXzJZMC+B3jlkKaPTgSDViHM0hoXtzguX2c2c8X9kE1Eqpr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:03:46.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3268c1cf-1ae5-465b-61bb-08dc3e5334bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

The patch series introduces a new API for retrieving the port number of the PHY.
And then utilized this API to address an issue in the USB3 PHY retrieval logic.

Wayne Chang (2):
  phy: tegra: xusb: Add API to retrieve the port number of phy
  usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

 drivers/phy/tegra/xusb.c            | 13 ++++++++++
 drivers/usb/gadget/udc/tegra-xudc.c | 39 ++++++++++++++++++-----------
 include/linux/phy/tegra/xusb.h      |  1 +
 3 files changed, 39 insertions(+), 14 deletions(-)


base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
-- 
2.25.1


