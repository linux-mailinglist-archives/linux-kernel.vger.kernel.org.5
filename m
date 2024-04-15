Return-Path: <linux-kernel+bounces-145040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE68A4E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D082830D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A073173;
	Mon, 15 Apr 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XId01Qqg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D970CD8;
	Mon, 15 Apr 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182938; cv=fail; b=U4m46pDf+nYVBiTU0+wHj3WL6OWaYy5CVI4JuMphHMOzLlJ+KIzARdBu3O0PJBtC5iDGpbPxioFpzwt+h+T/pcG9D4PSlDaUFmzl+plBBYSP2UKj4+FQ2oBAQoMhPdGMODiYy2UAh6Qg4JipjpXBLKwUADaE/jQ4LxiUFAbcvK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182938; c=relaxed/simple;
	bh=yZfvoGxUnvDaatNkkEDXy9xr1YOYnlqdKwLC2dw6GmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDHr/h79vmCtCf+E44z2MiW+qviJ90K1VYfxdYIZJhEr5DrYDTWfxn72fc9IXCP8LSP1ZtUSnPLkEnTXXWgpfPGGZsmzJeL0ybE2BNk2PUR9F5E/jXSdsqGvwd1q+DoCJKCs5y7VKMJ/C6QBI4B+tNHA8NkCk4hCUrElysw3JLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XId01Qqg; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l94p3nbqH6bnqkS84DioeiPFpG4MtKRMafo36MEVapUVBZeYx9/9EMXJHfNJHDTcj4KiPW8xzhi5tuvXHKczHpli3CLVJc5Ney3G+M1vd0bPq69mL3d1xomWTTwAlcqR38OcZ23+TpL+nqOHmEceqHPbsSJJ1b/5pZ/rpwqblpT9EAgONxopkz8l2DBmLj4Li950qtwlhVmNKF/s/LRrK+EtYysL+Gqc9Zy0bqLDC32GU2PZ43rMDUUR9Y/DpYEPvy2MV2wYVxiit0rkCvWkbjwG4CCJ/V7/SmDyWb58aqE2UyIZ6hq5mpPNzBFtDYTY/+Wb5nmNNhPOg6Xch2ZXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2K2/ziAy9DPxkA8GJpo5t/WSRjiRBCvqdWzB4ohOM=;
 b=YYMGRJ8Gix07HhYn2eR3J5dO7KF3jSKoqGHwSWucVFI/2hYfS7w0bhz4n2FYW7GHpM59c5Hz/XtBFVIaaNVCGNEU0boZ4uSULIwmmBCnIk4p8qYudnnCxhxK8uHkzergswnGFow6NwJ1RAmnqFJ4QruLqv6eLz2gEzhi29L7NaD3ngLvswqY65eU4lRqW/3hx+Ftf/3Nkl9P4um/HRMU5qQvKSvHEGXZ7fV6Ibsn4I7HIomvU5BZCzplveoN45615twQAZstakOqF+ViOBwMiEgqVuIvvFZ5H4ofBScSH5M/PQi1+p4mHsJ56R2I4bk9FwZQU5QddFgaRmhzWbj8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2K2/ziAy9DPxkA8GJpo5t/WSRjiRBCvqdWzB4ohOM=;
 b=XId01QqgaPz4ovKb2KUdYs6kDPnUmQwIlVqgbNJNqB0y+AN9MnLgVLWwHiNgA8pNAhngZbrg5/1ofwfc0ERZESXuwa6dwvndRAQQwvuP3WVsvQ9/D19qfKlnMsFtXUJR6XzAemuHG9cxaJQLzPHOJnCfhryC1kPXGc/EufN2kQ5/WxurxF2AVedoFfWojXxiPO5EHObMoftN6pUKSZNRJKRA0r9HewLxvJajhzp9NPHuv9JKyPVzmuOYWjgX/4VLG7VfURVkXcGkjFPF1IZXoJ5dwgDCWLIDtq+eJQQeS6byDpoRCOsMxnfG6k5bw0+dlg4RQummzEUwNDe+0iTA5A==
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:08:53 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::af) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.17 via Frontend
 Transport; Mon, 15 Apr 2024 12:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:08:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:08:36 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:08:30 -0700
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
Subject: [PATCH net-next v2 10/10] ethtool: Veto some operations during firmware flashing process
Date: Mon, 15 Apr 2024 15:07:17 +0300
Message-ID: <20240415120717.1251864-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3e323e-98c2-4c9a-f3e4-08dc5d44d17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XTmP5YEeCOLB+mGeVOuGVFUfz8pe+WVcSXXOYkfjGcsnxDgzFy+V9gubpouG91msOW9Ht+KBy3KPfuseRWb3Cdj8wGrTS40haCIQnBlPNs0PZFFsCMpjXanpupdxDfvuClQqC+V4+kA8oTqEZTbc+j4vldNtSFookyfo18OzaLlSxIP9lTghzV1tH4+K6ZQiFEnpWx1wCpkgmDA1iNepX+cPfmMvC6p6mwZU5MamojqIwLO1iqkCkwHVXOX4/+4RjyQOlf9uOvS6ofUl6IQKPW+u/dAAtJGcpIuKFeVyL0Sl6XpQF2BYi96Zb3S/1UpllQZDsAKdS3MnWvG4SB/IMHwrM9Ck8y7shonlD948Fei4jtoRf8oDtBiNCQwlur28OBUNCySe6I2sd7SKQAid4dUMmzhAg2tuH7AXvRz5GB0BboJiT9yOL+VwZsoQ7E2NNKBmbgS1bIaSmcrR7yLc+vF2JERsUbc+9k9AhSCdEoIhfwakBgqMguq/2THo3btUD2fu3aUbLyzwkoSrDzEwuVSH/z9NecoHoDCLssMABZ8ufnAQx3xaI6bHP+meqzp95sNkpe2MEgoWiIrabJatgAJpnOceaWzDeJ/K/PWH34Zv6aCMjAHod7HSzVY6MD8yyU0uwz+/LajOGGouFxifgWuEMnercz1As8XONScCJcRWeTvWGWtsHvsL/5ayuKZG3M0tAgQzNkgPFZVgdBUPO5tjM7L6cjZvEu3ytHrdG0bdWsQ/EcrQg+dVAEqF8ReQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:08:53.2122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3e323e-98c2-4c9a-f3e4-08dc5d44d17e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

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


