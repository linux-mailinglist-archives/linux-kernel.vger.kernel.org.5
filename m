Return-Path: <linux-kernel+bounces-156958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D58B0AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC451C21108
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E815CD6C;
	Wed, 24 Apr 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GLkaRveC"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD415CD4A;
	Wed, 24 Apr 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965474; cv=fail; b=Floi2NPcUTYJXm7x/U95BnNc8HJp928WHDxEN2eGRF1FBFxdwn1dodc+TtryQGsNVNmae2AK21q6rA0CdoaQ/7pd0njjzRxngvwjI8k9I3OJJlRADgTWhjsPuglbd18BvP2lubGQtROL1trMWEkM5rBhkinADT0ECiG1u/0mq8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965474; c=relaxed/simple;
	bh=485yKaVzFw4bNDXfnNhUc4xLloZouKdblr9Y2t97zhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L66xeoHbDCkeBBM/UYjQHD/tBYCwXbfIwjogPAKI4krZK7hDxHwmWvMjNtfE2Zf/FU00aJuMaq5/osKlch8isi8D1Sfa/Xxj04dzekr8Ha6Hzv18cXkcQEZh1NQDYiAV3Oo0s2mKPTaUFYPIaV96nQ8aOwYOPRFjCQYNfjdGvek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GLkaRveC; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9fz8JxPwhoE/cFw9RO+9Qw3D62FdITkxOBtaKnuBcXiqp/dR3lpeCiL29jhqZQjmgBtW4TeGbBNIXX37Ih4+rDTa+sVh7S3+oMrehLeFYD0IT06D++6Uq5lp4/kDEFNh7m18E+CkCTuakF2CNbhVPCfXnn1MH4INgCdwd9rT5ftb4kpzESuEL/ukm2/P36r47LhpaMv2Gx4mX21kR9Lk6xUl5/kz0ndiREWVbUugm9L/uRpi6HDoBUPJxZfKB+mr77FiGLPFDGxnGLtywGKydtOKjhmCjEN1xa/ghi++xZeIRmbaNR1rzhBe6XwPzZ84A1BBu03qY0n6i5ifbkmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=Tu/I7XO0jlTUHVFuVTvVrWGFOfO3nGih2h5jMIQ7esFzImJsJTV1r5x0haKblgHsWHU8qDp6HHzP8/MGEOTh5DIqCnl8JAvlYV6OSFOT7xAwPWC1TvT02u8JtJ81uMCXkJkziChWTrFP/BXDgPHex6juqpLrmccrjApcH2HjYTq6cSg/ubxta4z1ZyIQ0Ox7NWLgBElIK3ji6nBUJS0hFIoIGiGCb7fujVIrv6XMu1QvGEL2Oyi4mhtWX0YMzSUvuP8UVZM7hVo6vy/OBehAHR87LEizfa2OX18OTsBMpOY4/rcoekBfKjiTcyOtU1pVHCoNZboi26cHRCmMNC418w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=GLkaRveCvf4GUVX36wbAKnQYZYcGcpjxm2ssnvNSnT9b81kzJb6XSfysRUiQOMuAXtABOsH8ugDI0IbFK57pOJm6BYVckiFU70QCkFVk6YNjfszS2hmBitV1WNHKb+E68/XjVaMFW6VQ8Uc1IGYjPUfjQ215w6sc7spUh8Tyzwf+9RhM7z02d0kyH6P92DvbznYrSCBLMvHObdPamMgxsfd321ioGWCZkO84UDkOpA8CIyT8vamgstWoxtviWQt3TjzaYiaD0NZ4pECIImCgZa6aR4buQJ989LWH4uNmqfTjBxScwdo0yIT/aRuwMW9rEtp3RRB2qq2dN7Wpp1GFAg==
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Wed, 24 Apr 2024 13:31:07 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::a3) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:30:48 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:30:42 -0700
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
Subject: [PATCH net-next v5 01/10] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Wed, 24 Apr 2024 16:30:14 +0300
Message-ID: <20240424133023.4150624-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424133023.4150624-1-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 438c7b8e-f66c-48d2-239a-08dc6462cc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUIG2C6YPipzw6PSqGEgaSmTbqYb1kPi5CsMVdiFgNd5EQjkJfx+PqmIwnfK?=
 =?us-ascii?Q?fT2Ufa6GXVQTcPHkioQiq+S7fIEQN4BPn4W54x8AsPjFgjIktNZV8Gj673eR?=
 =?us-ascii?Q?ZASKnHw+Mzk3IfeGXHYmXcJYz/cd4OJWajXFE07oqeM2sSWsNfmjU2u6vxym?=
 =?us-ascii?Q?/wmYoGpxreQZcuaGNdu9MwGn4a0IIK0OnX8feeh9ks27YezteVSXYuYMEyV+?=
 =?us-ascii?Q?D6Fh+ewrNEjeY0apipTyLjzUWji9hOd1Fcay9LKWMIVgBDnWHSFTNxTRfyfb?=
 =?us-ascii?Q?Ad4ZwYW5szP2Ti0+lNzcO2rXlrB6mX+6kjw2bVSFheLeIQqSQFh98NHErv7C?=
 =?us-ascii?Q?UFuDAtLHZnIKv5D9d1XeF4sWPJ0AEpOtJuFw3t9nHWmnYpHBsgmcfhH0vtWF?=
 =?us-ascii?Q?nYibAbvHYOLwtNJ6r6gXBF+kLZlkwhvkVFYwYWiRtdcTXxTaIW6nZfH931sU?=
 =?us-ascii?Q?8PxGcHcc/a7/8vuawW2d+dSE29vrBP3RwUZTvLQMuhQ4jUw6SPmPQ76gbtfw?=
 =?us-ascii?Q?eKvMnAy6S41L+dwPkhwS8orhronxH3Dz6tjnMqHoD5u9xOMF6j4RqOOw1vX0?=
 =?us-ascii?Q?2KhzVOWovTrXNeRBKeSMNDRxAMqbSOb7pgFOGUp9T05JJyXYj+APb68aXF5C?=
 =?us-ascii?Q?wU6ftfGQ+dRmImlNsyXOpceLY/+jwjrzloXtqYIH7zvThc2IYb47U8bSDym5?=
 =?us-ascii?Q?5UhOZl4YBkLqtkKy32jJBTWcCt/ml4WpKIY7BAmPY8/LwmRZ/itXti8egMcL?=
 =?us-ascii?Q?BONyhuk6LGCj0iCE61ClNcdV6dd121eoRIkXLKWmznNln5g/k5GKObEDUdc9?=
 =?us-ascii?Q?DDMe+AT6aNof2OUIAmKqcu4zGq8SuDBsYp5cKGh/1CDHyMFfvDTkY2scCJYo?=
 =?us-ascii?Q?e2+HYDPfb9fH0y6qBD4VoMneQAsIkFKWwk1x2IUpWaAQokjCfvJQhVwDk4ZD?=
 =?us-ascii?Q?zzRJ9aPKCkUFxt76qMtw1VkaSYHrIpeeGJSMZrtaqeQuAYz1UdgxK717JECh?=
 =?us-ascii?Q?iw1zM4c/zBQ65SlB5i0uEz0uhY1UYbG7El7mQGSCxtShEhAgNgg+/FMJIF84?=
 =?us-ascii?Q?1SU6590x3Ves5LyJQKacTjYtuUiMj5Zkd8lHhg9p+yhQmtIuEaXDSGjo0hKM?=
 =?us-ascii?Q?C77mbln/vsR8Xkgzq/urWeZrWTRoVPM04sQpgkl/RSw0COsn16vx7BdiXWuD?=
 =?us-ascii?Q?P4uDjplb17EZwWe8miRqrw7NeFl/rx2GsT4YpzNmi6iAqbFKxINLVF6T1syM?=
 =?us-ascii?Q?BwqXhVgwv7u/YxUHWGAeCMEgzglIZBtnmMBh1ohflkdnbIhp9N9W3u3CkJSQ?=
 =?us-ascii?Q?+7W7R4CBT58ybTNEPGML+sHpnOeO1EZ2s802Qmn4VO4QdVBoNU4NyqRWxdoF?=
 =?us-ascii?Q?NoPGBriRRe82GMuC1G074jlKJ8YU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:07.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438c7b8e-f66c-48d2-239a-08dc6462cc3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

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


