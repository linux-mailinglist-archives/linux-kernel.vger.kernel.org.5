Return-Path: <linux-kernel+bounces-149902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA398A9796
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316E8281661
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A89160865;
	Thu, 18 Apr 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSAU5xej"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBC15FD19;
	Thu, 18 Apr 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436586; cv=fail; b=KAvKL2XbtGQU/CzXlrfRGf7vh0F5zH+6Tplv+GaJrpGg/1B2J7P+HxCA0oi7/pkh2YBnooxY/gyZ9d3kslNc85YbJ+Q7Jipqm5bdeJy0F9NnGCshlQ1+jWQx6a00ZTX5V/t3/zms27mvpc1DB2bBCKKFlEKLxO4t+LrG8SvTQ1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436586; c=relaxed/simple;
	bh=yZfvoGxUnvDaatNkkEDXy9xr1YOYnlqdKwLC2dw6GmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVruVBLPT90f3BFNHyQAEhawE6vD7ZPUpNRcOOcq8wA5FDz/X+cZHXocy+hW6iG2Fj2CuOkzj8lFPsVQYzQSj6IB2p7lF0nTaaslcLbNu5DmniWfzwAdE9Rd5fRYtxJuMEXNhdpdVPOyoCQd7hJDz8ZfCHm2kvh1N7S3yRZp2sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSAU5xej; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaSuwcqBntfOtfMRYkSUQ+py4Hw9azkJ22KLe/RwUryStCcHXmPvvI3caq8yy/GLhE5Gk5iS5AWaDuyDbC0ygZFpnNJn3HwT9AO19GBIeUQeIT0sL10c5eN0c/xIn+gdoIrG/e1wGNnqFBK9W8LQswkSjLlBqKdXxA3xRX7h3FUl+cB+0i0iOul4YNlxt9mjLhZipIeR8a0FS4IrraYE2U1i0b3RjuGSud0yy6oe+eWo5X/HOjBQM6dN52S8TssLXEXSE85fZEvBc2QMMntKqB/FXcrLWONTbutpblEhShMe+FsReisGvdBPegMVK/alh58aQUbVlSfW4042lW8TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2K2/ziAy9DPxkA8GJpo5t/WSRjiRBCvqdWzB4ohOM=;
 b=SjO3S/xg0N9Oyi3YkSAajR2jph9EUKWU7uxpG4rd41kdPoCJ+Q1yv0fJzcj4iqzYixwD7T8qp6Mvi+UmBGhbBMCyl9790U5j5yilBtnmFOCxQZLqY1RoijGV48gO6b/i9ostiVRCmPIsm0qan2fnWhiPK+XAq0u0/OETlZv1ITOjSFGkMdYVRxxTg20qta9av1OmnZN5jqIozU2sukwKu251KxnpNT8pMWPvudda9q4YE0d6rglTBrI9lncK0/dGW4FkWhsyLB/fElWpRRbDd4OPLCgsPKYVgEhrrvjZBVpZ7yNHToWTjUsaPCjAiO6GlgqwAj8bd2P0jGBpOHkrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2K2/ziAy9DPxkA8GJpo5t/WSRjiRBCvqdWzB4ohOM=;
 b=iSAU5xej+axebz1mzYLTwRiUGrgdF8qeoULDOWfBKMHIxmzfUUdPh/4WWk5htw+HdaAOK/yasxHSpnwS/xz9VZ5KEjJTROf1eODo4dbxug/O4Rs6lCX+zhjLHVv4uOBiGlIM4LDm2ox4/xqevI5llm92hFchuzWqj8NJmXscKjNkphkS/7gHltIC9DSm4N2sn+qkWklzsufvRghqczs73m4c6iDeMaStIh9PodFE0pCHZ1/XzjZkMue4CPI6K08Y28UhaRMrFFOsO9d2Nu0XE0xrf6TunNzr3IRY7a2LlPiNK5BsiHaBCgf74jGV4+FsKcfL6xfU+4G+wPfohDrvRw==
Received: from CH2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:59::37)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:36:20 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::cf) by CH2PR03CA0027.outlook.office365.com
 (2603:10b6:610:59::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 10:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:36:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:36:09 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:36:03 -0700
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
Subject: [PATCH net-next v4 10/10] ethtool: Veto some operations during firmware flashing process
Date: Thu, 18 Apr 2024 13:34:55 +0300
Message-ID: <20240418103455.3297870-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d678916-db14-4017-7de8-08dc5f9362d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oD/06bWvJv/T02tw4GWZ+gyw4HGbgkXP/bE6ysDhfGtDzSnMjvhQoGfD6Imm?=
 =?us-ascii?Q?SXlF00ygR9HSaaiYM78UAdiadl3CZE34mr/AtnJxuA50LIqSod5GAM3phffB?=
 =?us-ascii?Q?HNHXS/30UwQwOhkQ64m1S/PPApgWoX5+qbkSy0fez/wUl6SzeB63Raxi7gBS?=
 =?us-ascii?Q?C35A2OB3QBREm+GnWkCRGo1i4Hv9WLjVEkWcNbC8xRszAUqQFxwiJKxkxaKE?=
 =?us-ascii?Q?bDIbzXSt153s7Wl0h0pPIlVFvS5ff6Feflu8N1xNpjcfkALqwnA7GV9tRcUd?=
 =?us-ascii?Q?BTpm9j5gT4XSck85lnxTtERma8Vi85mmbCtN/V0dwT+gW3m4V3sfppbw8Q3Q?=
 =?us-ascii?Q?eav2gYOTOHmcDW2vP7oNlqHHHlgFxQ33nXJ2e9U3amVIrlAojJJWyz+ph4ok?=
 =?us-ascii?Q?DVlNVy/RY9d8OhrmrdQFxiypFubqawe52vkm1AdGtG+SCUegv8OraYR9gfOb?=
 =?us-ascii?Q?t2FsXb3/zi8aGpWsscwYGt7bJ/3OE582aChUZEaxkbA6bicywaDf+S9LWgiz?=
 =?us-ascii?Q?Dk+5O/BQkQZEmbw4gSVAcHTS5YBoFDTygTQiCkHTecMQQMZq6ZPXLRnkbZyr?=
 =?us-ascii?Q?RyrfdLxPS/t0IfyhOmGgZKVYZDzJnWpj2HJwr0h6TZl50dnTv0AKd1Kfgobg?=
 =?us-ascii?Q?Uu3/RtQF8/zvBuepJgVsAryWBv3BAtT3NHVp3ArSVuKH4XKMMdagZvUl5rS5?=
 =?us-ascii?Q?+b7OmK6MgmGlsnYSPh78C31crwsxqyHGoWFJig/iviM1gNGbYxWFRTuaRQ1q?=
 =?us-ascii?Q?jvI/Hed3GRtfueHf/quuO7ChDRCS0G6ypdalPY7pAWJwEqwlwS/krw1EajdR?=
 =?us-ascii?Q?0v2OHbb79yh5ovJILZkDxZpwaBpcWqk3HlplM47sFrUgCWGiYH/qTARi2eb2?=
 =?us-ascii?Q?Bg7yQ1VSCBntka3akgiLYdw6xtuDlwVsXFBpiOPwKzSl4Kp2fKuA0Izw28LT?=
 =?us-ascii?Q?sR4LUaa2qP1CFXihX+EuRSHuvKco+4OZrDeJZjhYol8IgpdHE0HIx3A8Grwn?=
 =?us-ascii?Q?DWMuWWaxCkieqYZHAqfHgzXQCr6MkaIjumxGLG9o8i5C7i66DXbwHe073Qbk?=
 =?us-ascii?Q?dCa9k22hUpjIeNNf+dSYdRUNUuyi7qXxBpb/Dsa85BJ1zJO8akjiUgP5VdX9?=
 =?us-ascii?Q?J/Br+cGShMo9yeQQhIkIQZ/XYDJafLbJBnQn5+uFWssMA7/i9i9DzLFGvjWC?=
 =?us-ascii?Q?GJjE8efP6u1x83J0axHA4sOKH3/dpT1JbIQ9Drf2FDkAke5aultVFFqXH3fX?=
 =?us-ascii?Q?wATb1lHb3/M1WgfMVX46OkSLbHhR1O1jiLmgUwZPy+n6KAj+vxvlOFwZv2aD?=
 =?us-ascii?Q?eL3R8l9boGAtAzuN2RYw5xG4r0tBYiX6sQ8IGwFG8E7KUh73mv6jHAqjk9/h?=
 =?us-ascii?Q?n27gvLM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:36:20.1391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d678916-db14-4017-7de8-08dc5f9362d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

Some operations cannot be performed during the firmware flashing process.

For example:

- Port must be down during the whole flashing process to avoid packet loss
  while committing reset for example.

- Writing to EEPROM interrupts the flashing process, so operations like
  ethtool dump, module reset, get and set power mode should be vetoed.

- Split port firmware flashing should be vetoed.

- Flashing firmware on a device which is already in a flashing process
  should be forbidden.

Use the 'module_fw_flashing_in_progress' flag introduced in a previous
patch to veto those operations and prevent interruptions while preforming
module firmware flash.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/ethtool/eeprom.c  |  6 ++++++
 net/ethtool/ioctl.c   | 12 ++++++++++++
 net/ethtool/module.c  | 29 +++++++++++++++++++++++++++++
 net/ethtool/netlink.c | 30 +++++++++++++++++++++++++++++-
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 6209c3a9c8f7..f36811b3ecf1 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -91,6 +91,12 @@ static int get_module_eeprom_by_page(struct net_device *dev,
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	if (dev->sfp_bus)
 		return sfp_get_module_eeprom_by_page(dev->sfp_bus, page_data, extack);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5a55270aa86e..02b23805d2be 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -658,6 +658,9 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	memset(&link_ksettings, 0, sizeof(link_ksettings));
 	err = dev->ethtool_ops->get_link_ksettings(dev, &link_ksettings);
 	if (err < 0)
@@ -1449,6 +1452,9 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
 	if (!dev->ethtool_ops->reset)
 		return -EOPNOTSUPP;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (copy_from_user(&reset, useraddr, sizeof(reset)))
 		return -EFAULT;
 
@@ -2462,6 +2468,9 @@ int ethtool_get_module_info_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (dev->sfp_bus)
 		return sfp_get_module_info(dev->sfp_bus, modinfo);
 
@@ -2499,6 +2508,9 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (dev->sfp_bus)
 		return sfp_get_module_eeprom(dev->sfp_bus, ee, data);
 
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 836c198d2cc4..239e7974f952 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -3,6 +3,7 @@
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
 #include <linux/sfp.h>
+#include <net/devlink.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -36,6 +37,12 @@ static int module_get_power_mode(struct net_device *dev,
 	if (!ops->get_module_power_mode)
 		return 0;
 
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	return ops->get_module_power_mode(dev, &data->power, extack);
 }
 
@@ -112,6 +119,12 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
 		return 0;
 
+	if (req_info->dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	if (!ops->get_module_power_mode || !ops->set_module_power_mode) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY],
@@ -219,6 +232,7 @@ static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
 static int __module_flash_fw_schedule(struct net_device *dev,
 				      struct netlink_ext_ack *extack)
 {
+	struct devlink_port *devlink_port = dev->devlink_port;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 
 	if (!ops->set_module_eeprom_by_page ||
@@ -234,6 +248,21 @@ static int __module_flash_fw_schedule(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack, "Module firmware flashing already in progress");
+		return -EBUSY;
+	}
+
+	if (dev->flags & IFF_UP) {
+		NL_SET_ERR_MSG(extack, "Netdevice is up, so flashing is not permitted");
+		return -EBUSY;
+	}
+
+	if (devlink_port && devlink_port->attrs.split) {
+		NL_SET_ERR_MSG(extack, "Can't perform firmware flashing on a split port");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 1a4f6bd1ec7f..90e5b5312aa2 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1194,6 +1194,29 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
 	.n_mcgrps	= ARRAY_SIZE(ethtool_nl_mcgrps),
 };
 
+static int module_netdev_pre_up_event(struct notifier_block *this,
+				      unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_info *info = ptr;
+	struct netlink_ext_ack *extack;
+
+	extack = netdev_notifier_info_to_extack(info);
+
+	if (event == NETDEV_PRE_UP) {
+		if (dev->module_fw_flash_in_progress) {
+			NL_SET_ERR_MSG(extack, "Can't set port up while flashing module firmware");
+			return NOTIFY_BAD;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ethtool_module_netdev_pre_up_notifier = {
+	.notifier_call = module_netdev_pre_up_event,
+};
+
 /* module setup */
 
 static int __init ethnl_init(void)
@@ -1206,7 +1229,12 @@ static int __init ethnl_init(void)
 	ethnl_ok = true;
 
 	ret = register_netdevice_notifier(&ethnl_netdev_notifier);
-	WARN(ret < 0, "ethtool: net device notifier registration failed");
+	if (WARN(ret < 0, "ethtool: net device notifier registration failed"))
+		return ret;
+
+	ret = register_netdevice_notifier(&ethtool_module_netdev_pre_up_notifier);
+	WARN(ret < 0, "ethtool: net device port up notifier registration failed");
+
 	return ret;
 }
 
-- 
2.43.0


