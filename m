Return-Path: <linux-kernel+bounces-92663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004418723DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949D91F26540
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62A128823;
	Tue,  5 Mar 2024 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gHuMppaZ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B25C604;
	Tue,  5 Mar 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655109; cv=fail; b=D+dYYD8DfZSBNr38h8xgJZAo06NboQbaWk7yysNArmZWdKLaHi4GW7VWm8lFZF7Mi7l3zzBgJskyEflBTkgLzKIoKv+vEpNiCxkHtgZElnYeydYudro5DJfJ0jGOHbHpB4QYcP0WqVRgKaAGOgyhq+pv+KSJ79pz0jDzTSyqosg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655109; c=relaxed/simple;
	bh=/oaisVswNk56wMPXCBv4ZTtNqW8JPJ/xUI0AqzWDsZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pihYZe8CM7XerNGZ1t6yLbDv2VeCXfIAir7z1Pt4pp/+3IZ7JMz6PoSmDEDdV/NfwxlCw3ikcwxwWtqIEz2Nv+h2FnPCdoOr4DnvZowB735BwIPcb2mQJnAbl3NJR/MK9g0PiBrlemF5ieU6SdBZQH49vGKEKszwyfNJ463Lyyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gHuMppaZ; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvcGxIzyg61soIdkKJPW4Mdib8wmy56ZyANSsla2mgQ+Brq/Cw1lIkLYUVsVYaCaEr6fAkUzg3rtmLbuZe/a4zmhx9OvhXjCA3AxJ6ZuOvZsog6XSN8uegmZ4mNPHSaxyQHGpFeN7TEtT/51fh4RdHJ5qZAMAkvot+2ZaD5gdn8OFiQqyUfGG20vNCkE1pu2BEp/+7Toh5syNPOgmYj0gfjh6YDcxGY3f8v08NZbubnx+hV0iwEzyZwSntxfAY5NyeqObQIZaf2kZQIqtGUnQP3w0Rkq4tkX+nniUK4NKmXZ07R2JMYyp/AyqJFmr3DgDQ1rvtqOBjPySBv4MmOGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO45lOFvJcLZT+DGum/ICeQlwjklBsjkwhTc+DYnH1I=;
 b=BXWpZ5m8rj5q2K0uwlGiS3MexrHyysOP8IpNeoxclVZkt6PV2sKftjZIINoTwGN0pjUjKPO962PeX0uDYiJN2z8HWtH9IOQP2MR64VrRiqtgNoCaWjrFxYMKrmINqWHL3mJ/16zFg1XdYyu7vza9SCbjqklA+JXznOUDuNeA8gzZXkYkdulK5snNcEWnKsy7UvPAQ2BqZcbjgj8xEcp5Dg2TMVNzeygomB7DpPhpMJQciMnTY9u/iNzidZZ+6E6SEZIeT+y0TtHUp3JzxOeGzudjeh1vpzbGkSPzorwOnTCUsVsZ83SEyecxEZFEmVSZJhPXHX5aLLk7XYbgmasKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO45lOFvJcLZT+DGum/ICeQlwjklBsjkwhTc+DYnH1I=;
 b=gHuMppaZQjjTo8ar0MHO40JFnAZPNqCzPDdevdMi9OJf3NVtwPnfs9rq0XcDckjJq8DJRCp2kVTgSdbZvpAj3jZPpKQgU2EW8aQBZ6oQC7xcqH2qhGRcF+CWceinP3UgA7E/viLAk86iDwGR4njrxYGpQvIeiOirSxfcFVn0/l12uILOKgV0YS8kg1n8kMZkZBbjudUzODMmluvFkCBMJivbrhGcm+rxyY/qQfwHMuMp99K2hJ+zMYjjG+K+1sPtdgNnHLTTv0SRrng+HNCX/OdZUCMQ4VKYTF8B21mx96BRRlOdf99eQC14vLDQOKM7Tbq+wZWs//3k9sP6cbxCpw==
Received: from SN6PR16CA0071.namprd16.prod.outlook.com (2603:10b6:805:ca::48)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 16:11:40 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::8a) by SN6PR16CA0071.outlook.office365.com
 (2603:10b6:805:ca::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 16:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 16:11:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 08:11:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 08:11:25 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Tue, 5 Mar 2024 08:11:23 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH 0/2] Fix incorrect USB3 phy parsing in tegra-xudc
Date: Wed, 6 Mar 2024 00:11:20 +0800
Message-ID: <20240305161122.1254099-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: f121e18d-1e8e-4453-ef0f-08dc3d2ef0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pam/BsaorIwXv9EME4NtmyXVVXHWUYgara50Vplfb5qF5Vky3y6DlDqH9NbEfltt3ZNslrg5A/0cxhdDOWNr838zNhh7PBWmYaQnwjMVT0Knzj4w7UtdsMHtUO8PbTS7BisgG3kDEjCGI3iXAA4YhejpDz6C5ZvagedmhbEDOQDO2+benu7f45IEzfuKAgSjdwHtXxP8QEzfoCsV+q/s4KfKtYMKUltU+eRMmezBYUIOCqiZ7Oz+O8yhsB6iqdtZD0wGdX+DdrGC2513hJNbdCcWYIYPs7VRT9jzcLy4cwLt7GSR58myvIL4iiZLl7n7d5gVSlrwFR3sNLr/opU01lexEj2fn5pndzRvCO6TzCn9U5KM78XuHDJZbFp/2dtVu+2JCFMF0Z4q6hzOn1RNC5atiBf1oXRuF6ATM9DTFSim3h71SvOjbh63BaZnqdDQSK1Sx3vFcfWyzsyj3hNbwehQykmL+kV+DlRGdOflkuEkObKmT1lHOk/IpO/rCmXEy0fIn1ck2+dMJeY3mYgO4FBJdAoEnoXrnnwIjbCJgK26n7WgdOouyj9qPV+XkJzbshngL0xEx8pDX0fJK7wiX7yi4KFIY1TD9VboLtxbTSlEPClumNpmvLrSlrTwLn1uMDkGPQL2pnTO/cSnxi5ikZI6PUjqUJ2B6chVgSXU4KNwQtDomglfjjTLMpmw87xgyR3XA2LqoTautHktctAVx6BWCAtMaMMNPxHyg2mqVssT9zCbietKbZGZxLuK91PY
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:11:39.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f121e18d-1e8e-4453-ef0f-08dc3d2ef0ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

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


