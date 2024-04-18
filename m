Return-Path: <linux-kernel+bounces-149893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F58A977A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F826286AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709E15D5A8;
	Thu, 18 Apr 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iX48fkdx"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8815CD6C;
	Thu, 18 Apr 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436535; cv=fail; b=JkYhjURCUd/BkqfAlSvSGp7eCFojEd06Ph2tp/iEW+psKLDcLeXnuCWfezR12qq83VqtRnk1xR1W62wU6OkC2rXp9dNj+cPZB6sdGjMe3TpDsJSjUSxekX9EdcrNedug0zIx+riX5mUkhrKSzovHqbsqO76Yoi395fp44tyfIPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436535; c=relaxed/simple;
	bh=485yKaVzFw4bNDXfnNhUc4xLloZouKdblr9Y2t97zhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+jamBGr4G+zHwJVH4zBD4aDgreTqUPpQRuWxK+BoZHSFJpI/RorOosInFvDIN85qHRhofold7ndh8tEAbvoOoT+EkKPVMAS50ZglsE4p2QG8n7xwM6AFJrgC9dDNEomxNDZpHtmQXbv32cbBPBMZZtGhkYOSTj9aH+l7x036ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iX48fkdx; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwRRm5CQ5RzyoMILvR+t6fO1OxZMF/fgI0C0WijOUHVNNifDgCN7a9Z6AqDXX/S5mtNJr7KquNx4ytmrc881yMYB3teEE2nMUiUs/2qpiPSniYJX1CofQquSKSfNCE9K30smltqZOKT+xx/o565T10cP7oNtuWHrtkKLycRXDyXp/rzwVLm4QD5AdKlBCn6U6Pn6vSVeeoUG761mKBoX+nmquWbIr3aJWVxaIpyq7N8/iTtIBa4dqHt/YLbA3sYSgH7110JMSbVfeieqP3Wgo2qaDR8ELeu8I4i822TLF21xwFoxlt55PZWHCXE/MrmSCc06chNxQ4oQkt53O7uPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=S4Qs+V3Hrpjx5oEtJerm9PVwF4BDS+ikbZdU1v533XLUlebetiEQRhlS4LaNaImI4xNOtHrFTb0pU4KHCFNkFmPJveSFQNZNG+f9SeOCsxSVwMZOgrrOlf4hq9A4XFdz1KWf8qbme5jKR96vBQ5V4bDYpq1BWyaGy9b+1RRxMzyc7ftLb8nNzBE8z1+d1O9MD3i+mTYF/20KRPWjsJ9L53Sa6Ctr+q40PUxptg8EZ9t6/MeM8S7grZYq3fcPKL5EQhbJ36ho3uCYiHw4RUc/mYF7+Ir0OJoUjhLEFHdzCWusGE7kNeDfVNiloG/fvYEOcoM9HabXbp1n9olWHWYqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=iX48fkdxPoCy1Q4Ko5VPUHu2bs389R0MXLjy0T9xOSZare14OLPh2PkmOQqf6JuGDD7UWQnnF6sv8TnmQaG+Z9rLWoYONyUo05objLjcp3TGZebkHuJsCL+8z0Xpgw21Y0w/dA4lDwdrxheZNukJswTa3bbTqVVYGtx+RIQPseIGRhvMjr9Fc9Bf1dw+SDZU3fgca9vFy7YbRkAo4omLjIAC0/vHVkdqlP+htGSYsMJRTVmoKdFVmkQCSVmTlmzS5SGcCxtlzj7Gj3xCFf9Zkql2BpoYs3o8th3P+PXK3RraNwKVvl8mxNCfsVdvtBLlWFujhG8ZWHN1mq0Cl4P4gw==
Received: from CH0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:610:cc::12)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 18 Apr
 2024 10:35:31 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::a0) by CH0PR03CA0067.outlook.office365.com
 (2603:10b6:610:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:35:18 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:35:12 -0700
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
Subject: [PATCH net-next v4 01/10] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Thu, 18 Apr 2024 13:34:46 +0300
Message-ID: <20240418103455.3297870-2-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c061c68-b29b-4ce1-6c6e-08dc5f934564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	22GfItyLXK5ZlM1sE6arl75sC0mUuPnTE5crACWGlKwP/lki6Vc41mOzxrxqge8LmgRmCKM0Zt3zBle/Byfi1a0zQm3QOZyvR3lIG7LEmpWXGXSAdSsfkZiShq4JPqgFnF7sYrB7ddRnMmwGoIotBLLhmxpWPrGdlW+OzQ+lINCvCK7FUdFLN1196tycFLy5mJoEjxmap+PHMk7lTX0QRxkCVrSFGBvCDgrwvOaswSfgguaXbArQiM1bHKHJpS+kqZSqG03QjZQx1pgCjW4kzJk4PDwPV9411VM/JyComMNsNtHSUkx8H0QVd/TXjSodTqqfdVATQdoGOdmYrcvLG0hdZcap9xk5OEHoa4G7izVkEl2w8K9tfuz2S9k6yIUomfJinxzt4aTXFKgFAUaVyZgQ9M5FCQiP8nnQKehvWmlCOU8rNxtCeoLpZBkIBrq4+nbkTgKl+EB82dOwO261plqrMnmkfhnXZpR+Ec5Tr/GaahOrnYdda9s4lvCHv/ipjH2AHtAcrxjzbB9qJSpSUzByviLc6CKQHnvbKdHksr0e/QNYEFV+t0dUVQ2cRQqxZT17ZvnwDAr7o3Bq6rbPeZ0qXbLs/3X5SsiM0GgYWHsxmXl/x5yi/tQQwMgVeD+u/Ym/f1omGAyyIigBIALeNZY8V171SRiv2Y3sB/F19bsulW/jxNapHsGYDDM5ZrtwJSiTY87sqtpMtmSPSZBGPepNrlzIp3JMEbQ9BC8HwEof2NowroG4YvSi1L3qz53n
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:30.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c061c68-b29b-4ce1-6c6e-08dc5f934564
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

From: Ido Schimmel <idosch@nvidia.com>

Ethtool can already retrieve information from a transceiver module
EEPROM by invoking the ethtool_ops::get_module_eeprom_by_page operation.
Add a corresponding operation that allows ethtool to write to a
transceiver module EEPROM.

The new write operation is purely an in-kernel API and is not exposed to
user space.

The purpose of this operation is not to enable arbitrary read / write
access, but to allow the kernel to write to specific addresses as part
of transceiver module firmware flashing. In the future, more
functionality can be implemented on top of these read / write
operations.

Adjust the comments of the 'ethtool_module_eeprom' structure as it is
no longer used only for read access.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 include/linux/ethtool.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..fa1a5d0e3213 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -504,17 +504,16 @@ struct ethtool_ts_stats {
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
 /**
- * struct ethtool_module_eeprom - EEPROM dump from specified page
- * @offset: Offset within the specified EEPROM page to begin read, in bytes.
- * @length: Number of bytes to read.
- * @page: Page number to read from.
- * @bank: Page bank number to read from, if applicable by EEPROM spec.
+ * struct ethtool_module_eeprom - plug-in module EEPROM read / write parameters
+ * @offset: When @offset is 0-127, it is used as an address to the Lower Memory
+ *	(@page must be 0). Otherwise, it is used as an address to the
+ *	Upper Memory.
+ * @length: Number of bytes to read / write.
+ * @page: Page number.
+ * @bank: Bank number, if supported by EEPROM spec.
  * @i2c_address: I2C address of a page. Value less than 0x7f expected. Most
  *	EEPROMs use 0x50 or 0x51.
  * @data: Pointer to buffer with EEPROM data of @length size.
- *
- * This can be used to manage pages during EEPROM dump in ethtool and pass
- * required information to the driver.
  */
 struct ethtool_module_eeprom {
 	u32	offset;
@@ -822,6 +821,8 @@ struct ethtool_rxfh_param {
  * @get_module_eeprom_by_page: Get a region of plug-in module EEPROM data from
  *	specified page. Returns a negative error code or the amount of bytes
  *	read.
+ * @set_module_eeprom_by_page: Write to a region of plug-in module EEPROM,
+ *	from kernel space only. Returns a negative error code or zero.
  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
@@ -956,6 +957,9 @@ struct ethtool_ops {
 	int	(*get_module_eeprom_by_page)(struct net_device *dev,
 					     const struct ethtool_module_eeprom *page,
 					     struct netlink_ext_ack *extack);
+	int	(*set_module_eeprom_by_page)(struct net_device *dev,
+					     const struct ethtool_module_eeprom *page,
+					     struct netlink_ext_ack *extack);
 	void	(*get_eth_phy_stats)(struct net_device *dev,
 				     struct ethtool_eth_phy_stats *phy_stats);
 	void	(*get_eth_mac_stats)(struct net_device *dev,
-- 
2.43.0


