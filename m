Return-Path: <linux-kernel+bounces-148179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B158A7EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24CB1F22D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF512FF75;
	Wed, 17 Apr 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nu4LEpz5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370C6A02E;
	Wed, 17 Apr 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344077; cv=fail; b=rb4UlLPmQhmBk/PTvhf274qmQNfD7veQF/5KZEtcwgD9n1/Zw3wmT94SGXtCcqLXUEn/qTgnrX1ML6eDrg/jLZx7RWFRuYFyddpMNTKoGgMy2f5y3gyVv7yMUc3PGF1u4aEXSBE6fQoze5uQTdlsNZfLsd04HsOA5HU982Rw54w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344077; c=relaxed/simple;
	bh=485yKaVzFw4bNDXfnNhUc4xLloZouKdblr9Y2t97zhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljR2t73DQQsjq8V/QvApbRxGocZ8n3n/3aZgjlM3n+g3d+xA36PeWdpAkByk4yONpWsNUjV3rA86xsUoGzCPr1qmnhpq/Rn1y8JCAXUMy9QPRMUvf8d+prWLIQW1eMYmln8eFq38v1qtLRfXS+h5BZFbhfVA/PxreZURfokSDhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nu4LEpz5; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLs33OaX3yiohUobFYGjAqY9FvCbS4H25VOkm9mBTdPtDB9rBdEdBehBDHznI3UI+BxpAJhK1e0SGpCrMJpWWducizfPGNXKMVtvhmLOIk7MRW49Shzadzr6htYsblkF2wO3Iy+vojut/h9nUFjScjOiDO5TsxXMMj1oX56YefN9dIXS6aQfx+YGRwY9v/qj6ET1QR2MUjpbaHeq+O6Nin0LvmJyIY2lMd2wyGJZtVDI5/lJugqThhPJdmz/5AEKJOtR3brgOgtO5+ZWUzJZp6oizMYOx1wATTAt0j9Df97lPsDb/yC/K6I5hBFyDgH4QsHCWNROJWpUHmYJ7U5aCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=KZCdGaV1dRBMR55AOAj+Gbnw8Y9WBD3ZhjqDkbBxAXTcotf5/h9sfyXb7rJ6hwdVd8ZHWnDi9xDTz9Iwplmmq1DSkkgXZi+IYLVYHMwcQtGpsC4QkPR6Y/uoDjiHO8deQsmg1Yo/Zw4iUiHJRcFp6eWDnCexjYN+Tb+ktJ74yVFmEBmAHvD42PE22DmiBhv3eMG/XVJFQPK2Gpe9n2PMMbB49Jf9y9SUr/W9nXglsuBw+lO1VNzG53CiZA5OnuURRyfoD8BloWK1uw39dOtGkight6aHzAKgTI+oUDdAqEYr0ndvSfMIbNpJbMNiKt6uJmGlrZQyyLM21MI9UJaVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDEuo5q5plxK/stzgXDSSj2K0u5JO6eOsUjnC3tZ2M=;
 b=Nu4LEpz5wZZsUQej6F7yqOJ51W6J8x81KOvZOpfk8PAfyqpYTaOekqB27aaOsNOx9GZ9zBMpJ4Mzvnni3iyYf+eSOcVh324XQ4vAEzA/RFIAnd91nwLJPOwa2MIxFRxsDtzqII5gNzSJHFQyiALpOzFLcoDlvTBPuFzmwaI9VW8y3Jt5Kv+Fu4/Av9Jg5EazMpnR2Pr3nX1wST7YzP4ueR1F6waeR+UKlTqxSYEo1D1JqZX+NB87KYGHK8EXjFn2mOdDloqL6TihQB+7axdHFLjs8BaaIGMKQ1PoLTBOxSkFqZBohP3BN0/pKGB27A2uRwIqAba6kz/VAmb1jCBlLw==
Received: from CH0PR03CA0408.namprd03.prod.outlook.com (2603:10b6:610:11b::9)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 17 Apr
 2024 08:54:27 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::d6) by CH0PR03CA0408.outlook.office365.com
 (2603:10b6:610:11b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 08:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:54:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:54:12 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:54:06 -0700
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
Subject: [PATCH net-next v3 01/10] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Wed, 17 Apr 2024 11:53:38 +0300
Message-ID: <20240417085347.2836385-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417085347.2836385-1-danieller@nvidia.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9b5ee3-370a-4fb1-43eb-08dc5ebbfc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+7tV5ei3a74VW0m1t99vr/OxxE/ToQ506yaOqIPG/edBXaO8hGwQOhz2W4hTJQbW3ejlwa1qWg9mhemvWNssf2LPiVym/CSGm+icRh03n3Q91XB3LDIeIPtgX+WzWP6VhDLEFHrfYQx/TGxwMMDNKuL79UdfnxIL2EH22OUCyMF02IURkTSCq1eL4JEwo34Md5E1Sx98GbpGjhN+uD2YOCyTJ4WBtwFkpHnSo5UXRrD4pyEeBW7ozg31FyjqoR6790m17IlhL/sEdwP89l+wl2KgBHaEn2+nFRd3RU9RJ3EdqGcq326d4RBDSD9z+oD6V1VS/kKoGV2IFjMJiiFD//UKTAa+7oiwWqT0zvIoknWrlccOd5eQhSqtWqGYYaIpniKLWc8Ei+CaBmmwK2/pJBexOXI0VtlcAn0v5Krwhf5CUgLo+ZlXYUo6GtzFM+X1qINeQmyDCrnCO4tf9Ci0t5sVv2a1Ud1S7CFPVQraG183024UkibbcVjh8LYfXp/n25lkXpYys1TKZAGgUDVOXZMdDcUgOTd7+hNW3RxfKnBm+SIUHN8+weCVwacQ71T3T51C7prMe8Uopxs813X2HH4d8PkQwvhr8GjJQ5Rp7dHcrW0AC/DtyFL/VycjYEOOVrKzsoTGfMt0FAjrEneRlrLBjAjvupR9WOSWC6S6KRyDlzw/sHkYp0HP40myoT5yKu2RLrvG0vjiVZaLFrGMm4YtavztCxXg7x8sXho1/PmAbmxjU3US3Pj36GJjk9Zg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:54:26.7085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9b5ee3-370a-4fb1-43eb-08dc5ebbfc8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999

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


