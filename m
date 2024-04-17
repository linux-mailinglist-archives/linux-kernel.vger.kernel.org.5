Return-Path: <linux-kernel+bounces-148191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5238A7EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688F31F252CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38F413CFA9;
	Wed, 17 Apr 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KyW/2LWq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9413C9BC;
	Wed, 17 Apr 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344122; cv=fail; b=DMi4uLYFhWIP11ZdwcxIDUiIVhCvUCVv4liuJQd2OkaBOof2uMQIYCPvHn/I88W8Ce46ayemAFrwYb2r2ob2pXYo5QJaydkWszm63Qe2bNwmWkODuHJALt5huqSu2E3N8KOvIitA7XnpgTw+p18gOCt3GRkT3Rv+svX1PpKBRek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344122; c=relaxed/simple;
	bh=yZfvoGxUnvDaatNkkEDXy9xr1YOYnlqdKwLC2dw6GmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR0//AIO/25zFPrXtINeVJDbmoRav/ioaVmAaSyaAgeWklgQ+Wt+ybVXWv8XTltBxjsrjZx5pChCcDCHsbkmEwRVgA8o+wVwQClAB65q5N/gvfOZ8hZuz77giqtxQ6+HKJSy1pG3Hr9bocX4vwe8X87B4ubqI5v5xF3TBYBlJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KyW/2LWq; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4FRrRWqOXK0HPPf8B2fLROufu+fL/zNvoqFl7Xd2+r1OHGimyqV4xfueA4OTzfnScjv92QeFOzoqzngXEnANNeFUvrXIbIscTP/DNU5/4ATBl9NOUGT9pZsp67o0+LxDmDmTvhX2ZhfBehdMxImneWpdtFsvQyMY9ZDaYFPt+f+Ru9tEpbTSNLXLMsjsoSLMOdqTDtKdCA5BKLwEcBkATZOY2LZIyqyKXluZo3TxBC300kpd2+WvA4Al6hC/hxNw4MBGE2zRIpuP2vUdsAc9ULP+9U0R+a0RNh+PAxIw5f7uZxcFdI59axiEw097ooVUfZ1YJTLXtJxghuBeT+X4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2K2/ziAy9DPxkA8GJpo5t/WSRjiRBCvqdWzB4ohOM=;
 b=cvswbEds6bAYk6rJrjgq7aKNV4PlU/Xx1Q6AaZnacPkw+n/3aZf/OrIWJzaJw20/fyAExcvNxTciASpkFv68TgsPNTzWAMND6LmCCvAGEq9uKSNXXtPIVFhrtJ5R9XEOIVgJZLouHBFEISGrsxF+LT2T1XZ5Uuu4IxUS7L6hYTgA0/nbUU0l/KdH5UmTwCVhHSx1pudg5qtGchHTOTAe//MtA+LlwuyxpoCHu4i1GnhtQubH02Tcugy3H5fn26Llrr2Vcu05xsx5TP7dms6eHBi1Fpz3Dij1mBTPsEeQVjV95QZNneHYp8FsrH+aKpvzkKpOvKyHD7jmUKalmLthhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2K2/ziAy9DPxkA8GJpo5t/WSRjiRBCvqdWzB4ohOM=;
 b=KyW/2LWqC2l8Cmw5CP23nU9QyrniKB8AW1mb9oZNJIT2xXsFRB1lhtyg/NF7Di4L12Yir+64gDw9EWQNtC1ETQ9ORCIV6jjOB5Xh8HWwag+A4DndDJ6Xmzw5bsat+nBX3k8gdQvFAhfzZC9jkutrMMnCaS53wtpvE/VsXInk7BhgJ0GXP46vGuAskv7mpYhVwPU818RE64ISVZD0da7R1qdQDAmzklsmvC0MSWwnNiqYb2haKPpVdHjaX4y3ds5JOjH7L5cn6HT2qXYo2ZZZJFCMD8Axv5HyFkdNHCDk2nGrL8I1a8cF80s8TPuLngJv8quXHguTude6uS0RwRitNA==
Received: from DM6PR07CA0092.namprd07.prod.outlook.com (2603:10b6:5:337::25)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:55:17 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::b3) by DM6PR07CA0092.outlook.office365.com
 (2603:10b6:5:337::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 08:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:55:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:55:07 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:55:01 -0700
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
Subject: [PATCH net-next v3 10/10] ethtool: Veto some operations during firmware flashing process
Date: Wed, 17 Apr 2024 11:53:47 +0300
Message-ID: <20240417085347.2836385-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a8897d-6e71-45c3-4e7b-08dc5ebc1ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y6/GyvM0i0oPyJWrk2PpQoTIwDvnU8VT9AUihO3CSeKU13grsVyFDxoCdsIiQncxO6s1t6sdSVWS0bGtGrooDDQwhCc64jhOb0pHXOBt3moWdk73pnsJVsda61iLBdXe34jWEO6MUzf2dS5Bd2d1BqgRkWdOeU3c/fgqTNMJfm23VWL9k2qfjhIp/DfbhrpRvoZHRL1vbPi9O/TvqRTKx+orYnzgRvEjDW3tJ5m1jXX96/mxyaWpzeDtnQtvyv5BaC5eSzvME6jq5DoeBllHlfYK3kx+dJbY2LUqj3fTWkp4GADNGMqxYgUT9SdJXIAqbc7upTNQezHMv1j9T7A40k0qa29G1E0S7tywHGrzm1mT+9FWZS1Qb1NdZZgm3KIxjW6bMgWv/jb6DgeXddBbtcBQGV9wO+7nWRa7+jBvW80Mcf0eCXJpH8I+p/KKiJDon62A8wxqDdIGs9MPSX+cqU3lHPnj3DqGKmQGZyQQn2hyeQt8xOEvuptJyo7vsSs2prjBGy/Wt9QQdb2oxhCsd2eBJGN6tBWbbPSQ7rYNx/fKKrtq7PYUXPdM+ZHsKztKwfBUpolWjHLHr5SUTjK5joUmpxnIxfUTQh5KhUq62E6jvYktIAHti9OhmAameZVJ2PjflQrfpIKTMBQiaVaAEbWiYmhcVlPfOV7BWUROHjf6exDwpCzALM1EkNl+3QKTOuG49/HIDKufd7X4dzkh5WB3SO2sU1z/DObJ0o04mXDSigV5LUob1kIFIDlTGC5X
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:55:17.5516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a8897d-6e71-45c3-4e7b-08dc5ebc1ad9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314

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


