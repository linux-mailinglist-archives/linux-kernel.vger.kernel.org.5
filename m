Return-Path: <linux-kernel+bounces-94903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2068874684
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FAC1F21C87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAA81AAA5;
	Thu,  7 Mar 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTRkRI0s"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5014292;
	Thu,  7 Mar 2024 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780638; cv=fail; b=PFddsVhRxefNUKpqYTkQIXM3F5GaEyJOVK8NV+Purehx6nQnQGMCi9HBo3sdEcUj1nU26B0gUo91cGVFCD/kgCzBfke4xQO1ZPtYVoa3XgiocP7SHkTsbJVfmOuzlCl6MuH6ohIitq9WwED80kKablNQue70PPouyl3nXnS8eRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780638; c=relaxed/simple;
	bh=XeysJMo5ZGQvsZQSuOKUqxFgfZOi5MSsrbA1ctgbSjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3dwpPpeJ3prmvQ8EDlVxqhMzMsoB93kPZD5OUmkqs3QC7wqvW+uV/Y7n03AzBbQ1Wuw/dR8qPsw3p0mcRZfMmR9YjCAgTcFg1ytIx3PBjXhyFBJHk6OhIuw7uhEUJAWapFr5XsmefzRFUihCVpsxAoa1k96XCK4DD/kI0TC51g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTRkRI0s; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrOAa9hLwL49lcTLMPCDm6H/uemy+rXlnL+UwgFL6sQ+f5swf6QRjr7IAcXo+ivM0uRuatu+qTifcxS3GgRcUIqMhS3XjGgk7YIDePyaqTu9UrMTjq3VsZsvmfMKoz9jh2TKQw3nEhTvApKMJVa8H5IPQZHTxDHdlszvUBN0ayhglRSSr73nGQBupqzq2BzRWWyQL5Xygqqo5/rcKVQeq7ylWMIagdDh5iGy/lmpLV5ZJISu8lje6/ZdP0tOjQW0UnHoCIS6SPqdosz+Vwh1XbCNZqMM53Fn5g2AaWV4FNsWORj/Ymlcrr5Nh3jAGEqDwwPUXJUSq+UFEbVb0BNfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD/K+1/pka0o2jzGIisI62E/wSox2b8Okd3jGKUSotg=;
 b=NNBwg5g+eEhTJPvagK1uGmmNNQ7v2u1ZS2eiE0Avab/qAhGsHN8I7wqQdgQEQREWPlyIZtp70pckEW4Z8pT4/dyybXhNZtcPk70RN0kG9Et26osISK7Za9xhO3RcrQZ8IxuULbNf80I9pZdh+UhJM78VQXszQj5ls8qvAIf0oCoL+gKpeeOjCq6fMohAZSFXqW074HoXhBOiAuKDBatrVCNz/bDScPDe8wovEW7oiGsjVP4+aaZ6/V24yDJoOWT25QG9nw1PG2TZW0sjQOhkVc4Lc4uaW2s0QwCBYM57Vj3ZiS/l1tq1NiceOGq5Emj1s3jr2B/Tg0A0sP6VareQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD/K+1/pka0o2jzGIisI62E/wSox2b8Okd3jGKUSotg=;
 b=UTRkRI0s5eeV72Aw6e0Cn3R/7TJyZfVjReTU0r7uLbywSoyGG/6u5ZVZtv7a/znplii3AWYWgAouyAQolu8YaV71Q2CvOTdYr6bUFwA/wR+6EgkUOto0tPsNQ3Lxtp7jokM9zTAS9xa/BsqqmIV9Z2QdqPh4unFj2ylsD07d3JpscVhGMX6o9JtDX/3zgZiKrYN8ur42e53Kazlxd/fXEhEkRZNqmT0N7Lf3+LzhvmBLCsdj/2rTG35kgB3qJ1txZinO53aVkLNAIQjeDpISaZFUTE803vhccDgurWQ8KpKEqzaZR5SCwx9ZtUDXXIGtSvYletEc8mT/LiTpFbrtqA==
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Thu, 7 Mar 2024 03:03:51 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::f9) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 03:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 03:03:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 19:03:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 19:03:35 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Wed, 6 Mar 2024 19:03:33 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/2] phy: tegra: xusb: Add API to retrieve the port number of phy
Date: Thu, 7 Mar 2024 11:03:27 +0800
Message-ID: <20240307030328.1487748-2-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307030328.1487748-1-waynec@nvidia.com>
References: <20240307030328.1487748-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 95deeabe-c664-4341-385a-08dc3e533783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JKJuypVDCQzn0CrGVl7fFrNGLh137jNUxouXuY44bZ+Ld/tWkxCKFIhQbQswf6KrW7aSg75mN0KAQfAD6sDx2U71C43JWh6+eoR8EIMKqq236b8N4KOOEvnIQ9GzjAjtQx0RtSjwAJpJXjGTFpWHASG2Br3nYh9o+af+AWnkVapgyAOlOd0IPTtWZ0ZVfoQLZcVepQZNxbSkwvVICM34FPkGHmde/sQR/a7rKJpICiZCQ/EA8s76herfbUZrX6glVcvr7W/2leq+I1hV0yix2w0jUi2z6VOpezJxViVPABxiA+D1pFOj7vuKTifS3u9eX/nQQYlgiJ4SsWYpXe+cT0J2sLHkBd5U17iB9E3BAuRxGIxEyv2ARoYq1BtCddxlqd/N0J+SqEsnGrIF/qQroyl6t63txqWq+DKQsEGQJK0NTv9Pq+VEI4dvUnVkFATZ3uR+OWjkBuaeq27TyaXeH8SDwip9ivuzfsoPj6VleAtdc8lLX7ccNi32qHSMNP2ETyUHuC7zTxaK2byyUnoP+LUgcovwF+zLvbcHu+mboDlLf79IAicuIsNZhaBJcG1U4gSW26qkt5f2B8Jjclao2SrH36huAvWzgagu20jK+B+jCGJP7WdFEseEJAGoiLUgfouKW1wV9Z1h5Uf+roJAu6iylMFd8RxSOLnhH3mMYFeddksm2M2P6/bpJuX2t34y7xmbZ9Lkmw1VL3rgLY/FcMZukmuUZXCihIMJZwsrTg8AdAFbJWEPHaP79Ynuf7q9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:03:51.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95deeabe-c664-4341-385a-08dc3e533783
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

This patch introduces a new API, tegra_xusb_padctl_get_port_number,
to the Tegra XUSB Pad Controller driver. This API is used to identify
the USB port that is associated with a given PHY.

The function takes a PHY pointer for either a USB2 PHY or USB3 PHY as input
and returns the corresponding port number. If the PHY pointer is invalid,
it returns -ENODEV.

Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
V1 -> V2:cc stable
 drivers/phy/tegra/xusb.c       | 13 +++++++++++++
 include/linux/phy/tegra/xusb.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 142ebe0247cc..983a6e6173bd 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1531,6 +1531,19 @@ int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 }
 EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
 
+int tegra_xusb_padctl_get_port_number(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane;
+
+	if (!phy)
+		return -ENODEV;
+
+	lane = phy_get_drvdata(phy);
+
+	return lane->index;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_port_number);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 70998e6dd6fd..6ca51e0080ec 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -26,6 +26,7 @@ void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
+int tegra_xusb_padctl_get_port_number(struct phy *phy);
 int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy,
 					   enum usb_device_speed speed);
 int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy);
-- 
2.25.1


