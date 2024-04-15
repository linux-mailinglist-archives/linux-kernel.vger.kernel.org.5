Return-Path: <linux-kernel+bounces-145029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB68A4E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4943C1F223B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61969D2B;
	Mon, 15 Apr 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibj8ShjB"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C266B5E;
	Mon, 15 Apr 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182889; cv=fail; b=FcRk9FNECoKLP4RMknJNd2haTZACTfY4vX8+wfJdTtRmFx+78u09idHm+X0mMHpSXxwMzAb01pE9sHJggTvOEAT+q8Hemov4P+MeyqSzRLlXxLHZpnixKopFIuep2rgXTqKgzJUfnrvCRDwpJVJ5YwPUWhG/pq7DerVH9SQy/jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182889; c=relaxed/simple;
	bh=485yKaVzFw4bNDXfnNhUc4xLloZouKdblr9Y2t97zhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDKDSnLISU5soWS5TL28hIdMZHA2pZ7cKn5Ksp0M/vZyhy26PJPVK45bPNxxmCHsZZ6HG5buN4yt9a3EceaiTnoLecVj7Bw+NO5ZsQGKzqGOW8/iNLBG7e5BrP7kZyndPTwmddYJm13a2nqQHtjAK5hGl4hPdmVZy29/AVQKE0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibj8ShjB; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjSSpDiiyFpgGarTnxyh05ii4yii2l4j99sxfBtRNOTNutYwbhdWECF4v09q/cArmeISHu1DOpY+ylv96kePT5uhw6XitPRKEbanWqKUdXyFjM6i22YzDN4EJ2nVhJ/r5AicTsMuCMFyfZ3AGWJtZQe7Sk9yBgGl2fC7AYwYOdP0hHzSR2vVcfQNwg77wreoiYfHf6N7hW4OlEwCSgccdizExbzi9Frxpx/Zv/BUlHwCOzfIb4n3Py1ZzDo+2eMzNHB2rqOmGFLaU50OQIwunxJPnsboLCQFoiBIEyPhMOmlSnCPXKuuOiH+aFJaerLc/rHaZEhVs87KZ/hE98XEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=XhOV0NxjrhDeQhYmv8gWorMFjgdkA1twiW0QI4Gsw1nORcoy8R+Qi2CyhXu3FC0XOVpK/qYeI4W8Br1BCYywqooJdYf9Tm8FFZh4h483506i+wtm4emaeDfvJKO1q4foo5cZZlz8R6AfKoPgg5CZ7Mvt/Kt8VeGdC1Y32xg2PCJLlrRFD0RQlkvP01yXNeelzWS6Zh2D6Rsu8jW3dhcPO7Vbevp+vhjRCH+tNBdc18mSakQplSrR3tVQJqPJnoYq/mFLX+Be8mWmMrPuMry6ctf3JQBgmH6S1t1AvfBmT7NJTivut+D/tBGMC5LDb2JtbcK5d27s8kby+Jm9/xNCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=ibj8ShjBEfYU87Oc/lKpWUjkUX5azC1dZWO8oxXQjlRR6NhadnTDqdPm+0nkSqLKmSXpfcdPFNR0DhZEWhNH0wsdvIcDULgtfM3fvH+aNq6NsR7ggurmpkZk7vlKA/EC8shdEWUYlkt48DQ7QrtDvQA5sWaD9PUibv9Ey/Pw4ZxVLMjEfm19YY8qSBxADEVmZ5xRJrsZi4n5sbvJNWai2hn4l445VI1/aaTJSwztnO+g8jCDdfs0szjgkJ9WbmZ5TjecZSzim7MPcvT2UfMX1VbD+eL+Xpuuu6xXtW8AqSBbBhUrn9BYy0NUDulCmYNEQI752L/yy4DUpRfjG6HASw==
Received: from BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 12:07:58 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:51:cafe::f1) by BL0PR02CA0087.outlook.office365.com
 (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 12:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:07:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:07:42 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:07:36 -0700
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
Subject: [PATCH net-next v2 01/10] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Mon, 15 Apr 2024 15:07:08 +0300
Message-ID: <20240415120717.1251864-2-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ce435a-158a-4f45-d4c9-08dc5d44b0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lXtPlLn58tIvZBfA/8HbDB2K2eNQDjjKiODrHBCUeDKOCPtU4+0OVnrR3esgGgyQ94EuMupOHpPeIaNHzIZfGilaIRLqF2k48EO1WomnnATVew0EjtSv69oRmP+VuSQ3Lii382YWB6b+RImzHxc2Vgm6zUEF66okKcCxdj5IrnTZjBnuRQ2SiZe0N16/89HizMkwMwFyXP290EsqQuSDgK1YdkXMXa3AquWclhSQUshoBA2nYperNOsXj8N8Ntq/nH5KKlrQ4T2KBMGl1vzKyovxe0s60v70kD+X+o9IkvSl4f0pe1YksN20rctn6f2+NRnmHmP00qiCcyo/NrBRdxMNv/gPUjdjAxru/h4w3+QWRlROrBPK8Em5CxqvgIhBIPO4YXcBtvWBXsQD+GpUNiabPvUkLH9NP+zYVsX5gVPzXKi8yPcF6M7MK+KXjG/SAOmvNXgpy5wQFHe9Ma7v4uhxs4fvxlf9q44OKoXGAvjEoCz4mgJ4KvvGcv+9Q78o/gehi4GKm71DcJNkrxdZlBsgW6tSbsnAvNu5laITBqVvD6wym8UvJm4X7jjFZQ3RZ30pJpQDuX7wid3x4V2GtB/ORtUO6Lg1423R54mRhUnThg8CiLv35y7ilkWi0jv16t5KHgNB1+dSSft6SbKzVmu6AeqGmx6b4Fz9w5LeNAp427utVezlP9LSmSmXAJaV9aK/hliCQsXkm0NZuGKvFL4O01g+jjE7t9WiTeL0p5eC5P7rho5Q/3hTkSCje6rD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:07:58.1012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ce435a-158a-4f45-d4c9-08dc5d44b0ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625

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


