Return-Path: <linux-kernel+bounces-32546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275DA835CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C04E1C2399B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090438FB9;
	Mon, 22 Jan 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pE3kdyiw"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5A364CB;
	Mon, 22 Jan 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913172; cv=fail; b=I93Gh9LpZ6KTLzBVcTf1Ol/xwI+WpCVFmJM0aGJ1ZSOBl/suSC9jdUaNzjMZiAXgf3wYMKSGG89oBUYqBl0dFTh3+rTRs4roT1MzsuwhEgDdbUkZAjreVD8tV5IRRsO62b67xyb7HKMbGng4LwRlxKBDzV+lqcPSpqS+LlL23w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913172; c=relaxed/simple;
	bh=bMZz9FC0hpSJTWqNuvMPvmiaUjXR7ocPHtgB2At+hAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbXvx+Wq/oMXFYi39hc+qphdZdzVOVHZqu/j0eRiYxrfNxpzyN7NpJSzusEEYwzkr4pBA5PNpl4XHWe2S757RUHIHFe8Koz2LB1m2BcspRkC7M5gjSgXsnLHo7C3PmbLCtDWlN3+RyhVVZ2MHhTSPdhOCV+TWVV7fHFF20EZUpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pE3kdyiw; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELI+Oq49qg/M0LALzW/t0/3lp/M+Llc9BlruDCXI0ozvTcXz7AvQFup9KSrZ8AKg//vknAazlr+Tp5B0WI3lf+zFPhx7CTfXD7NwAcSMD0h1zZfg0YWhKZvG6UXvbwVdEYFMcHNBe+wAqHJ8N2uS6NrlfYB01MQqDisaSSLS6jQ2U/tcr60qm92KeiUku1N+siivj40KaFdjTvcnZrM02GpFxXIWwJjNlU4JViIVrC1Q8spCEmzuhbZXl6onzOWcKexMg9HAFfEtJEeQ5VphE27M7pAA3G1Sds6Qxw7ZzXGEUH6bCt9cn9APwqV0fGsVWjthG0EAy8AeVxD2t4YQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey2O5ktrthQlwGd9R2arXJH4t+wDrwCX5uMLGaZciKA=;
 b=jeCC2rVOPZ5r86mwatAL8dWxXqlnOOwaLFLJ5+BzhweDP8aG1sEP+xHUki71NWqTH9L5HrNxUnZxWHBWDmxRHSjcJBFcwXAF7s7YYy9aAc10pgFdVDCczePYkQgMysHqtNCo8aQUKG1gncEmay8NMZ8swrF4pZnGSHxeZuoA0yIUWv/Qy1fAsW31cSlJUFHUBRcMiU7G08MwO48t60xWxO1zNqg4Z8WciUc8Tos3kl5iZXPj66N5dEiYkiWdD/JtnmJoa1k+zGfnUNsDex5EW7Jrx3PrQln2cCeuYxdZkUGjXREJwWeYcrWv8YVLcMmJhF4B+OHUnkgTvsJ2cnQNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey2O5ktrthQlwGd9R2arXJH4t+wDrwCX5uMLGaZciKA=;
 b=pE3kdyiwDpZl1mKMBuianDLjxHmWaEnEkSoH0t/hOEqbcfXH4LmBnBdobwTmEiNgbcEeh3tvnPeDznI31qEZdhEhTiiVsyDRa8NP+R9qa0Lc2yYHGPVniwvsGGj6igJDSPkHI0Htv00TrE07DuiiEzby60icmrFPPzgRdurrbY7l9Fq4chy62wtwRbi4D1DzEJhui+tiArWBHp0LBhBtpCG8Wo3QQjWQXG/yI1Iyo0wGe73Hl3Kk88u3EgR63ZrAN1KUVUPI/FtZmkBWlh7jdHfVZ9TwCDIrDTWuyY3v/a9lSKUTeYanC+hXUjnzRCNske4nEMim63V3XLLeZaF+bA==
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:46:05 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::2b) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.17 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:46:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:45:55 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:45:49 -0800
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
	<idosch@nvidia.com>
Subject: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Mon, 22 Jan 2024 10:45:22 +0200
Message-ID: <20240122084530.32451-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122084530.32451-1-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ0PR12MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: b411a1ee-fc80-4ed4-fbc8-08dc1b269214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1i5dRMbGY9tqhjmI5gaPbfpfuzHfFsy8JmpGk1uA6Ofi1STZi+jBUEbWkBTh8ADpiMrVuXSIL1MUrqALJqcQqokVZ0/8vMKrGDRL+6a8poEwikPEiHvgVStaRfcBTE5ivIHmkYiWMx2WTIDS5/eOSpr86i2oDdUxz1fajfMX5u9dDJ8rCglInokKYmxx2XUsmR9n+342BFkwC69Kglvqx2RAIDD26kNbK75cyqQOo9wo3KjOMmHrFjKy+Q79LiEF0EbMdba0CF376V+ymuXNE4Zu4R3mwkuN1VMGWL+Wk4uakEuSNpO1MYJxoWx7af/mHla1So/RXt8Ookr29iGhc4EpdJgrkus2l5SogJTy67o1s+YElF745WAGgvhGe1VdYPpmT5wgBpWrat9UGRzu5B3Z1xRnrLO1WniwnkscEKJflQSd4Z0QTg7hNgkIPaehN0lyNZyOLoO1TJCxJXIS1sLKBut9DAals6gWMaJ12SDG40m1rwk9YDijKvIR0a11GXBHUYOiRq/PeQDv018WbDXr017CRbtdzn1fKH6Eve8S3KWgiSrZKn2inlqBcqt2s5TNbjveS4CZuyxBN6U0oUpI9LTDaZr6AePCtbGmcCMt58bj8H4b36VIL4yvjDamY12n9SMJtr/aHlfHhWxtT3x/0DmTMG/oVy/UvNI7Zl35qLkNuspjgQfPKAZny7R3z9fvacnxUh/mov/049o2auH1bM7pBkYJaeU9ke8gjGDumvnyA6C5Y+FD3IA3Y28v
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(16526019)(40480700001)(40460700003)(336012)(6666004)(426003)(2616005)(1076003)(26005)(107886003)(356005)(82740400003)(7636003)(86362001)(36756003)(83380400001)(36860700001)(5660300002)(7416002)(47076005)(2906002)(41300700001)(8676002)(8936002)(4326008)(70206006)(70586007)(316002)(478600001)(54906003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:05.3011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b411a1ee-fc80-4ed4-fbc8-08dc1b269214
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406

From: Ido Schimmel <idosch@nvidia.com>

Ethtool can already retrieve information from a transceiver module
EEPROM by invoking the ethtool_ops::get_module_eeprom_by_page operation.
Add a corresponding operation that allows ethtool to write to a
transceiver module EEPROM.

The purpose of this operation is not to enable arbitrary read / write
access, but to allow the kernel to write to specific addresses as part
of transceiver module firmware flashing. In the future, more
functionality can be implemented on top of these read / write
operations.

Adjust the comments of the 'ethtool_module_eeprom' structure as it is
no longer used only for read access.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/linux/ethtool.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 325e0778e937..bb253d90352b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -474,17 +474,14 @@ struct ethtool_rmon_stats {
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
 /**
- * struct ethtool_module_eeprom - EEPROM dump from specified page
- * @offset: Offset within the specified EEPROM page to begin read, in bytes.
- * @length: Number of bytes to read.
- * @page: Page number to read from.
- * @bank: Page bank number to read from, if applicable by EEPROM spec.
+ * struct ethtool_module_eeprom - plug-in module EEPROM read / write parameters
+ * @offset: Offset within the specified page, in bytes.
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
@@ -789,6 +786,8 @@ struct ethtool_rxfh_param {
  * @get_module_eeprom_by_page: Get a region of plug-in module EEPROM data from
  *	specified page. Returns a negative error code or the amount of bytes
  *	read.
+ * @set_module_eeprom_by_page: Write to a region of plug-in module EEPROM.
+ *	Returns a negative error code or zero.
  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
@@ -921,6 +920,9 @@ struct ethtool_ops {
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
2.40.1


