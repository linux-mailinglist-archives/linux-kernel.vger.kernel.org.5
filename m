Return-Path: <linux-kernel+bounces-92665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF538723E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF87B25F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66C912B174;
	Tue,  5 Mar 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRc3FK2B"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A51292F2;
	Tue,  5 Mar 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655115; cv=fail; b=rAaIxYJzaKX4sYzNb2tm3Ls0OYt57ceZF51EnO9Q/HF7BV1cKXYxD6ZTwDsovLmTdHY+xMV4oQc+2qUKU861ZzirgU8AosvBFiyX+8arCD35cD8NCsOQ4BSo3n1YKMb1Ki8GEe1tScqXppGdh5yRhLQGZbOFfeVlhNSTxf5UfAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655115; c=relaxed/simple;
	bh=c8lyXzF+OX4yn8gwmnFD5NSoL7Rj6FGxVdF9S9mOieM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q432kFBOPUVAuf6gEVcrPhXEzKn+qHD0ZrFvbJ/q/roaVSvXy9h0Qbw2zJpPIn/xLZWeQSBc63LDh+a6Ac+gc0airbk4DBEK316I5Y3kEPUjOn76My6qXYt0LNgpcEfnvTbh1n3CdLepkglW371oIwQlqoQ3FMSW3XaynK7A+wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRc3FK2B; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEztvqIp05zI2ch+oiYEF5w8DBOZ7LixLKEHgt74mBsMfalL0duyK2dzdTzy5oDjVdSfSr/00lGnzNy/YW6V4D3dlTD3mvrrWSJH17dKvDNJRR6gE2M4Ft2oLz3xzrUXa5S9NU3iCMJ9tp8S5eeR5C52gxxF6hmFBWL6BqzvR/4cbVvxtMjy+rtJU1kE6VwbaxA2mXe1jMEtEjvtf8YzuKY94KK4+d+yaCJX7oCHUjTH9qEJz5rVl8/SaAPPrsnmoR5T/yvTR1+ooIiX3FWMVAP3f0/r2LvSpeJOPOKuqXElN9IEL76wbQvtb70Sgr+qbKifV9MMRYF9bT5YkLlYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+09M14IRLI3n9a7Q7htbZ/uODfxUfA5y9XELnT5hyY=;
 b=nxL5IOsYyKYN8uuSWfksIlXKeIXFwb6LtObe2XE/i+5AwUokiMYqlx6zq9ARyVDo27u8anNerEzkRHG/jMfOTWpwsu2mfuu7iiKndh5VUFHIA9CbjuVn0mT/yHjjDWhqTEJbMPKV24ZrhNJC8fJZ5a//sYcc2aAqVUJSIU4UskC+gFgzcdZHT8u/eLU4QUW0O/cAbgjfJtjp+8DXdztK9PntHEZD95qGxAYzxuWNccVyye6omFlHAO2bmEBgiV/owcBmUQDHemRBUjtmihovvSLsnkDmET118IKJyMbfbFn/zw+KfmGX6Heq2T52F1uqsgxrg5hsp3ybwuklgu0pzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+09M14IRLI3n9a7Q7htbZ/uODfxUfA5y9XELnT5hyY=;
 b=GRc3FK2BOn8rRRWVdH6OFbsnZoZl/E5fVvxL/PXAKrquNIffZgZRfKB7r+jxQABxZIU46duZjWb3MbtqVY5uYjNFSHmeGJZF/aIcUDMxRxeK6btHtr8fg8NsET6jEtn9PehuLLsJZS4leQlZ/TuWj8sVTeD2/wbH6PvhxAM+2gvcK9Dh5LX6orw8y91uMfdADXEPzaD0gX79GZelcqpdCvlmB4eSZPLv3jmW99r1gI2Ak5+yO1U2RqmfQkyjoAbbUfnFp8l2IqYAk7SwztGJMW1NWfduLpmosMtTlPnSeX4YDiHNvsCuqk6AMdquCFY34hoXuzVI2capQ1kx+Jffzg==
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 16:11:49 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::f) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 16:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 16:11:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 08:11:31 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 08:11:30 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Tue, 5 Mar 2024 08:11:28 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic
Date: Wed, 6 Mar 2024 00:11:22 +0800
Message-ID: <20240305161122.1254099-3-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240305161122.1254099-1-waynec@nvidia.com>
References: <20240305161122.1254099-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c21c61-3690-415c-5dc1-08dc3d2ef663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	orIsIax+F1njox/cuhWGy1E6+lqjHWA82hPdRyZ9cj+UsqnalWcCnYMoAsgEq0FC2YwiYa+gAtaKKVQy/GBSA3grGSKvFARJ4RY00DSYzw3iYHrFalkAti5zTJxpJPjb0l43YzmbCT2sBCeoZD0bGYVMG07PdcNuyUoj/Rjt019W59vAe6b/uOd9es6BZ8n5Xv9W1k00erz0CpK8FXQpG10QdL0AFmp0wTYrik9Q6OKunXuYh3QIhdzqweNEtIHuuU/IHzAsCIIQrcyzSpOr2T5+TAAIE2KFPRg1HHnFKa4xIRRbVSLccAXcxZm9MhnF6rD7dN0UWRRowIqWPtQViUebLNsLK2nL1PqYFFvYRsyero0YdmjJwkhHtXlmHcKLsQHLbcG15k4R2jI3rKlJB7E8LZxHcl5YDZqHxNSQyzDj1700/ZiGteZsWb6jDUSKkZ1pxV2G3ifhs4vKnHhdgTPzkeV+fY/nd4zz2qv0ZVOR49K+d+jQ+CGQnvxVVH+6Qq9okpcgDn3M/93nIS8wR6jRATSqh9D8e1EEGHjDK0CXPa2kFmetz1BICui2gZnbqw2X6wYpYW1CrsWBAzd9FY1BG/c4Apx1HBFqwWMzXhr3Zn6zfAJynkikEdNVoeghaxYv2NdekMPJ+pEpx3JisDfQryQGgPJP6032TRQL2ntqapCttu79psF2fqx/Fo1GrZgSGPrfMnFEy/3imqlbJ1j+7Kn2OCmomaRtEhtwn7TkyPqWoXBfGjcApH1geAkT
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:11:49.0013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c21c61-3690-415c-5dc1-08dc3d2ef663
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

This commit resolves an issue in the tegra-xudc USB gadget driver that
incorrectly fetched USB3 PHY instances. The problem stemmed from the
assumption of a one-to-one correspondence between USB2 and USB3 PHY
names and their association with physical USB ports in the device tree.

Previously, the driver associated USB3 PHY names directly with the USB3
instance number, leading to mismatches when mapping the physical USB
ports. For instance, if using USB3-1 PHY, the driver expect the
corresponding PHY name as 'usb3-1'. However, the physical USB ports in
the device tree were designated as USB2-0 and USB3-0 as we only have
one device controller, causing a misalignment.

This commit rectifies the issue by adjusting the PHY naming logic.
Now, the driver correctly correlates the USB2 and USB3 PHY instances,
allowing the USB2-0 and USB3-1 PHYs to form a physical USB port pair
while accurately reflecting their configuration in the device tree by
naming them USB2-0 and USB3-0, respectively.

The change ensures that the PHY and PHY names align appropriately,
resolving the mismatch between physical USB ports and their associated
names in the device tree.

Fixes: b4e19931c98a ("usb: gadget: tegra-xudc: Support multiple device modes")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 39 ++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index cb85168fd00c..7aa46d426f31 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3491,8 +3491,8 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 
 static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 {
-	int err = 0, usb3;
-	unsigned int i;
+	int err = 0, usb3_companion_port;
+	unsigned int i, j;
 
 	xudc->utmi_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
 					   sizeof(*xudc->utmi_phy), GFP_KERNEL);
@@ -3520,7 +3520,7 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		if (IS_ERR(xudc->utmi_phy[i])) {
 			err = PTR_ERR(xudc->utmi_phy[i]);
 			dev_err_probe(xudc->dev, err,
-				      "failed to get usb2-%d PHY\n", i);
+				"failed to get PHY for phy-name usb2-%d\n", i);
 			goto clean_up;
 		} else if (xudc->utmi_phy[i]) {
 			/* Get usb-phy, if utmi phy is available */
@@ -3539,19 +3539,30 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		}
 
 		/* Get USB3 phy */
-		usb3 = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
-		if (usb3 < 0)
+		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
+		if (usb3_companion_port < 0)
 			continue;
 
-		snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
-		xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
-		if (IS_ERR(xudc->usb3_phy[i])) {
-			err = PTR_ERR(xudc->usb3_phy[i]);
-			dev_err_probe(xudc->dev, err,
-				      "failed to get usb3-%d PHY\n", usb3);
-			goto clean_up;
-		} else if (xudc->usb3_phy[i])
-			dev_dbg(xudc->dev, "usb3-%d PHY registered", usb3);
+		for (j = 0; j < xudc->soc->num_phys; j++) {
+			snprintf(phy_name, sizeof(phy_name), "usb3-%d", j);
+			xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
+			if (IS_ERR(xudc->usb3_phy[i])) {
+				err = PTR_ERR(xudc->usb3_phy[i]);
+				dev_err_probe(xudc->dev, err,
+					"failed to get PHY for phy-name usb3-%d\n", j);
+				goto clean_up;
+			} else if (xudc->usb3_phy[i]) {
+				int usb2_port =
+					tegra_xusb_padctl_get_port_number(xudc->utmi_phy[i]);
+				int usb3_port =
+					tegra_xusb_padctl_get_port_number(xudc->usb3_phy[i]);
+				if (usb3_port == usb3_companion_port) {
+					dev_dbg(xudc->dev, "USB2 port %d is paired with USB3 port %d for device mode port %d\n",
+					 usb2_port, usb3_port, i);
+					break;
+				}
+			}
+		}
 	}
 
 	return err;
-- 
2.25.1


