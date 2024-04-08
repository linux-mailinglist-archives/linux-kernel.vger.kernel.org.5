Return-Path: <linux-kernel+bounces-135363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82989BF84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C25DB28130
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0E71742;
	Mon,  8 Apr 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RsAbnEHD"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457226F065;
	Mon,  8 Apr 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580873; cv=fail; b=HPUkUddtsYFyL2UcT8qNAki/UhXPYINEVwTVLDK6cgHCXJ2aIU8ryyAQZL5FpbLRidqBrXG+JPYg56tvL8m7ajJ2eLjQqcIefZeS32gib47e04OSDhWXVpvQVeKtugFKftH6iJvMhfDzTplhzgl63DF2uzbba3DA77X8XFg2yYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580873; c=relaxed/simple;
	bh=QscSqEZ0SyE3tEiSYY7zKgOkoDy3DEizvJp/Ld7hjl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIgWhyoyf5OJ6XXXqZ8nXLAGjQMXEQU7JOT6g1E50gkzO5M1Hgxs9AgbWitfS+nkVSuWPohoi/qvZ06TzFOj1evDF3zg8wvqHx0KldgCCvdog7e1b6WhZuX/W0vx6BElvZdUidQ/4pOveqAk5X6yqVwIKBunMFR5vjSI8WCTtLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RsAbnEHD; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN8geAY9sC6aQScK1jhnlanWTtt9i3kdtTi0f8PyD45wlSsq0eg9tw5FCIC9WriDVnid7Toj6Q/GXVzP1/EhmUfCqb7vE6Vphh0i5Py7WjTHxNNH7JFKCHOLURjxNIzckgNknjEv65hmjv5PZezfT2b6iVCa06hk+LtTra5TVpN89SVjOoUmbe6ppqFALxK3GRdvW/ythj0YKdWYriL6Ii5Z2dq9lRWAeGToJJlb8JNUY8mGZ5J32KZkc9Kjv3CVvITkcNY/3uUOjp0vMVYUtpw9bpwoNsLpI0vdw1GX/1coVPOkkHNycOGBFce3o/tQg/RNaFu/BfoND9Q6sCHgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrF1CQDw/B19n6Dc524IxfnArcuaxSue+09jQV/DZ8g=;
 b=DHkXs9lHhbs1Gedkv4i08KjuYAuFHEs6Q0At7ktboKJb0oVfmmZHKGvKQbev1S4e1z2tYf1Pgm8xHFymb2B8Yil30LsSKyV+lmyOM1IPEi8DvxB3D4DP/f+kHfLZ4bCMYxyQyx6jMGGBgUZVUVOn+ka0Qej6hUCu4i7vvMojVJS/gAym3lSYH9vxbyuLl7GQUS142W4f8zCsQ5pw4NnrsHdH2jY1mDa9oxwxBIWu95oUal0QFi67C7+G/ZHYYg18h3c3IezuMj4qtvKJWWL6FGBB+ZFMLkuC+ZqWY02xNCdliDVpMHekYnTAgdNap7WAl5u2NF4NrkGgueAOajzggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrF1CQDw/B19n6Dc524IxfnArcuaxSue+09jQV/DZ8g=;
 b=RsAbnEHDLqky/Igbj77LIBGcN7j7RfBTnZoCNsLazWh3CLpSDg2z21qi7t7ARmN6Dn95/dEheTrcECe/jAwfPWfz8nT47bBD+9TBEvWPo34Y0uxoirGzo3hrSgHv2AbMu+D2MAjFVerXxwCzniidU/LJo3tQM/b2wuRs/p6u5PbCBoqTql+KYHg4MPmtwh9mEBSnVx28Mea52JcIBXAX/Zq9JH3xUEG3aC0GfCa6zPDQDIN/JrYoDYQbXYA5umEaeiQ8/SPt48/K0zy1+Vvx6yoXRWi/K586A36H4Vil5q2pWSHEagHtk/zfPRMXHDm23mjMSAdmgBuexCFCuJUaZg==
Received: from SA9PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:20::12)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 8 Apr
 2024 12:54:27 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::fc) by SA9PR03CA0007.outlook.office365.com
 (2603:10b6:806:20::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Mon, 8 Apr 2024 12:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:54:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:08 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:03 -0700
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
Subject: [PATCH net-next 01/10] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Mon, 8 Apr 2024 15:53:31 +0300
Message-ID: <20240408125340.2084269-2-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: d60adf53-de25-48f4-1f03-08dc57cb0677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CUiqj3RjAIC9Ti+2Hek9SZuyc0vxVSYqbXmUW453gwAXYKascmnA8/UWO+QJeU7pLYb3VfycM5fSgDQBDCozmOPQ2EdCYBkGFJOfxcg03tznusSN3nE21RN0vFw0vTPJSiUZRaNVd7r2C0iDvwu1CsdVkjdXpoRRprvu4tX3EVWAaQrrP5pyHfNJDyxQgWXI2sSUihLjf2rlL63FBpQblNnRc8CQ4Fai+NxoybQTm20qSBnrRXwxeRgor6ii5OAUJrJ4EtOmRR6ws69tN4BtA/nhb62hQrZ2SsJtZHxv57nz/nEX5NSD2fq8AAj+trQ0Y8yo4QxrncjCRq2Zl09pMvFCwPsDxAWAsBPPHEaBxDmWM7rZyfwXTkfLyPKVApQga168itfbQtfj0/W+VQA7gsOpHX0IP/RXGDdUbsM5jSfIxyTYoS4KyeQaafPG4OguClaHH/tRHFl40OWXBuRUZP3/FYyNbWnjy2igaH3B3lM5wn814of3N7kkcxVFblzwEtqZAKwBXDhKKXT3yRvtBW9iLQ/YH9WI/HuA/OO2omzpLz38ptF9A4KUeAa+YPrkf+P1R4b43i/BGY3+bWr1pKchi41IlXmiWh0y7Mo3mf0LdZyyNZapyHBb5cSvr1o60QM79+jeiNPIV7bYIeXidGgItSoI6KTbSpOfDpJhmBRmOk4tmaYc9bKsRjw7ByKLbEaoWIJGqrJXMW/RpTQC8PHWlp42qDBHMjo/FDysK5zBvFCM2u+2v4WXxNcw2MJp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:27.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60adf53-de25-48f4-1f03-08dc57cb0677
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

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
index 9901e563f706..2d9f2e46d3c4 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -484,17 +484,16 @@ struct ethtool_rmon_stats {
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
 /**
- * struct ethtool_module_eeprom - EEPROM dump from specified page
- * @offset: Offset within the specified EEPROM page to begin read, in bytes.
- * @length: Number of bytes to read.
- * @page: Page number to read from.
- * @bank: Page bank number to read from, if applicable by EEPROM spec.
+ * struct ethtool_module_eeprom - plug-in module EEPROM read / write parameters
+ * @offset: When @offset is 0-127, offset is from the beggining of the EEPROM,
+ *	And when @offset is 128-255 then it is the offset within the
+ *	specified page. Offset is in bytes.
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
@@ -799,6 +798,8 @@ struct ethtool_rxfh_param {
  * @get_module_eeprom_by_page: Get a region of plug-in module EEPROM data from
  *	specified page. Returns a negative error code or the amount of bytes
  *	read.
+ * @set_module_eeprom_by_page: Write to a region of plug-in module EEPROM,
+ *	from kernel space only. Returns a negative error code or zero.
  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
@@ -931,6 +932,9 @@ struct ethtool_ops {
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


