Return-Path: <linux-kernel+bounces-48397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CF845B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DB61F24605
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C5626CA;
	Thu,  1 Feb 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ad5/NOGO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7E5CDE6;
	Thu,  1 Feb 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801149; cv=fail; b=LX1DLt43pis6LXVJ9xWnlxZhQuPL/e5S3sX5+zDhMUNz9ZMUgKQ5Rr1rwpjl82I+1DDGetmTrz3M6F7v8QL4ODHEdDhJEJoyCbXMv/QFDuyyfmLmkbTwDZ0DHE7vqf0k8AwbHvDxfQfevko271JelEbaqE62VOEGK17gyCvdhq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801149; c=relaxed/simple;
	bh=YdCe6dGdwhkGwWXk6D9MdDO6QbJjHTDmocAKDe+HJRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKM1jNOTEjLtV2C4xRShzCcXTPDL0n240oC8CcN06ECXrQ3+AyDr9onldc54LQ5/h1i+iijne13IrKQxARAfShdQRZ7N/xGuUxvTGXQ7TwnTnTi1TfZcryTVW+gm6SzMeJB94TbuDdp39lfLD+K4deGvvSIAWdo0qB7+fWRezMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ad5/NOGO; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBM1C6UIa1blRT6/ogudMuwSHTDxiPprKrQrRKHiKDeS7g13QFiF9kdv/kSysP5jqBR+b4HIsHPVhwjGerRDEDR0IEJCwCdmpHGvAeN9Fn+X8CVQmrhT6+s5EVXO9dHvXWuoTQkaaVpOjWTBSnwOWHRutx5WHT4i/TDXuSUlwTSr8ga3El+c9uSJeP9UueLvLQ5XRY2vUkUCiDfDeeBzlE16n4SGMd2ObuJKFJeF48MergT6JR9VkRlIJ1O1Ju6EtYMwMwTbkWu+2QKZuxnBaGjqNy3nylKqJwO/mwxZgCzaCPQrwVO6KPlflFN9la9KNquw6FoCdKI8jl0D0uVjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8kM0BmRYpQ9HDskPkYDaA/HFuYdIaQrpfkMGqUwVRc=;
 b=hhwSyVowDjyULcvtpaerEytPAP/uZEA5HfvTv8Ee1D5RPO/NjxMW6MrMyzp8Yin1aKzzZ//VgVf88odUfbWETscrplKKRcn/jKuEmg8Nrj5zXiwHOHj7dBrnJfwzpqMmlt2Grzw07eEN61KvnwxO8wpsPHZSyRIeL86hmNh5Mct/5L1a77RuI55/8tvE9O7IqI+oQ3kW0c+A3cYK7jpIHv+EN+sP9IdObBpi2ZjDeHW5j1lC9x8zkw9BCAH/qUqhjqhwVC3YKod0G6DA0eJGHPBXdVexf4mFnxTP8AjLULsW1QfjQT0tlQ2B6d4TOw/mPxWcKCAJ3LBhvp1UXX1nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8kM0BmRYpQ9HDskPkYDaA/HFuYdIaQrpfkMGqUwVRc=;
 b=Ad5/NOGOWjNdq+caQcaIYUL33HwGhKdnA7reRwErmdneAKnaxauwiaE8/3Ku9EkZjUpEj43Z222aPVcjk6SCDV4Q5pex40qskyD1UV/I6NVPnM4WJ3P+L6JJCsAGejx+OS/3/2MzAL/5mxpD45UllwuSGKoIKN7mZ44LdRL22tT73RWy3+XYLF+a7Yt1MLQDf7phP+GHEqaV4rWHNlgnzHPqSwo1N3G4mfl7lYC+xf4dVzCY4C9Jctmgw6FPPnjwmOkl5WfSB3F/1+aKYmw0IbykXaNHK6oN97LCnjpLO/BmkDgbWHAPDWddyNlXzzf+JffD/i4cPcC2x+B/8Ys5hg==
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 1 Feb
 2024 15:25:44 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::65) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Thu, 1 Feb 2024 15:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:25:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:22 -0800
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
Subject: [RFC PATCH net-next v2 1/9] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Thu, 1 Feb 2024 17:24:53 +0200
Message-ID: <20240201152501.3955887-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201152501.3955887-1-danieller@nvidia.com>
References: <20240201152501.3955887-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 78353046-695e-487e-fe6c-08dc233a0f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y0CHsjYrCHAWG9a/NT5/5gt6JytJl2FFvOTqjQInkwkXR39+5pkxiUXTbojiUFrXAHhrdwhkIKzzdBGOfXOYXwM4nfcaaw2GczGbD05G9z4KtIsmy7r+AqhA5YHwJMmStjiYmLMrv8uTGMCtetbEBFsvgHFPxN51FyRRUr/pizghAHk2PkPLRIrnOICHY2cUAH8NpnMxOAf+wf5Fz+Ucu7ffHoTYc/DXNv1AdfYHDpvV8yHoUGY0OPz3bbEEcNlNd0pqoCfd4cMcmMCAcvE7lefbEd4AEWBLI4lKQFzTlvKpn9fOuAspTa9Kt+8CuSqswQsPX6+8oPhUq5YePj1Bh2N+h0xWItJpfLiTEyVo60p3d0MD6U+OgDe36YIrIO3KtclGQ/y71FhwFfztQ8dHa+aFr6ketlEPYKBVj4Qn8j5zvnDNyfD8AUje3MJYYUsaYlYkrtafV0ecTIf3A2WBP+YwbukJiOgPEFHrBRbVB1f9GmObc0pjjLeW8TRwSb+wA9TNga1v/OKY4o22CeBzsx1NiE9XNwopDaNS50I/r1Baqk71mKO+BQqHrMthymhJAd9VnbWb49ld5D2dk/xQl2+aHpL0gPmmfwmQzv8acgDmdj45Xj5twbUO0tliHqQcCa8qB8LQXsGufMG14ANmWmZ8IvEC/yjf+fuEqN/4BMEhl40DtP2120ZDGCS1cJ7ORs9sndYXWiGPC52vBn47OHC+1OgztabkogEl1NOcL+r0puJdHXh4nOfmrKDNb22H
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(336012)(107886003)(426003)(26005)(1076003)(2616005)(16526019)(41300700001)(40460700003)(40480700001)(47076005)(316002)(6916009)(36756003)(83380400001)(54906003)(478600001)(6666004)(356005)(7636003)(82740400003)(36860700001)(8676002)(2906002)(5660300002)(70586007)(7416002)(70206006)(86362001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:25:44.6435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78353046-695e-487e-fe6c-08dc233a0f1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    	* Rephrase kernel-doc.
    	* Add a note in the commit message.

 include/linux/ethtool.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 325e0778e937..8ef21f66b129 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -474,17 +474,16 @@ struct ethtool_rmon_stats {
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
@@ -789,6 +788,8 @@ struct ethtool_rxfh_param {
  * @get_module_eeprom_by_page: Get a region of plug-in module EEPROM data from
  *	specified page. Returns a negative error code or the amount of bytes
  *	read.
+ * @set_module_eeprom_by_page: Write to a region of plug-in module EEPROM,
+ *	from kernel space only. Returns a negative error code or zero.
  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
@@ -921,6 +922,9 @@ struct ethtool_ops {
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


