Return-Path: <linux-kernel+bounces-135373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A589BFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FBC281CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACB7F49F;
	Mon,  8 Apr 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LEGrnBo5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1E7BB17;
	Mon,  8 Apr 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580930; cv=fail; b=QHaE9E033ZllutVtkVmkRdw0Wx4kshy3OFk6HYnYePHax9CAQUIKtsZ90UVyesJ3nVOSBMvlu3xRD9SYnDAUO9FkowaG27iLQy3tD/d+MbnbAw10OPwWZ7g5Mhu5XyfomRoPqlAfqkHxeBh1p04sAJAzM2Vd3Jj4tqZVv6ERvUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580930; c=relaxed/simple;
	bh=2doBOBTQ8z3ejTl86DoaiwlRV2rt1/67GsARTAPPH34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbaChfxcG1ZhbfATxN/xO9mf4lofpG0RpTlcH9aIe1jG1+aHoo9RLqy7sGbC4V2LsHMLgdlfifcKTLqh09j4NRkwlttWGjzOJCz2k2vMcmYf6F3eykngZ+XwkmyqlZpCg7VVu9G8TI73zfAvHGuD/FXKeeNzO+0za+mhgFlyosM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LEGrnBo5; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmpgNDBgTgxvrVzJwjK4pP7PSh+A/grcRIuDCAEjj8rVtNfCKVjcxwR08ARYUrwvaOlN1BndD57W/XRFA+ajxT2Bxv3/OSLoYRLNoHik4lrPxs3HJc9EiLXhtc1XQHJ3BiUOzUAWN3YqKNUQPIBz9PxqF/3Ae3eLc1j547ALYCuVwM75Q3U2uMSmJbp0TqHa6MPurjDPkBYYZelbBBP+0TdzuABXLFjW7z61hIpXmpPwiQ+njaIEjJqm7yKM8J6cKEcnSRT2G+LkMW/0Vsk5DvhfDO8UFaTLDgr3S4+OoaAB0akJHdw2h1et2BbSbU75y8CIfYBcBJnSL20DCYHzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOqJCwPLuj1gpmcS1UA5YpBf2yKoNYs/QMXHqyoWrvw=;
 b=jD9AR868SMGZNhSbZdlWXGPBHAtO9XHW1W7K/Zc9toZJldox8uCSn/X/a0DbyDjQP22XokEkgcFDMhTxXcjb3MQTbB4Bv5VB/ENCFbXnJzMkTzN6pzVIdMiSv3v3tx/Wbg3smY0Wj/2YofPtgMQYGXGrPSoLtUflIvTTatQzw7afbMLRWnFmeuho7w6cJMs+3GXfHh5EoxuKUAHktiXT5fCZxsH3Ixd6LbMEVjtQVnYrdmR+T+yGXeCXDVEXSFw1LNVWQluY4DOILMLEXqDxXln8hEJWgCwJTk7uX2xK4Y87bugzamhpiEb8QwuJ0Pu5QxaPjJjz6h8NYPAOkjF+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOqJCwPLuj1gpmcS1UA5YpBf2yKoNYs/QMXHqyoWrvw=;
 b=LEGrnBo5Q0+AJI1pDytjZggasTtQGj8skKgYEgsGVCu91uoycdsHNOWx5HAMQHZijElK/LzGlykvMh1o0czX1w5GFCe9h65sGgZxcsZPurE2EhicolTZC7AQMCa2TgR9SsTyh/jL7LzpmbDYhZf81Cd+z4GM9uIZ3/rxQIavDGezqRjoW0Dqgs8eJ0nKiOVD1zG8+854QOYidbUuAMPd/hwc//ebz4YmJQWrKB7h8tpxvTDErWwPwxTQ+BZgSVIA5dhHX17igM90+a7zsbTL8+6OkEAkgpScn+2ra0mlOkV/Brzs0ajYs2D7OIhzCnKoER905LXsUV+QRSjjiIFBNw==
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:55:25 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::7f) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 8 Apr 2024 12:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:55:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:55:02 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:56 -0700
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
Subject: [PATCH net-next 10/10] ethtool: Veto some operations during firmware flashing process
Date: Mon, 8 Apr 2024 15:53:40 +0300
Message-ID: <20240408125340.2084269-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a550b31-ec86-4a42-10af-08dc57cb2838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DfK3x+EJ+TZRDZ5VhWJatcW1bgLURsyntPxXbeGwoQPBnq4yIo+63cKIpy6opNqVnUA2MUwc2SWA+YtZwk7l0PH1K9f3PbgqERpz2hkFV4Oqljg5vWDRG1v9Osc8QJeFFBAkHMSSeqeFM59K8Tyi0NFn/quNOKcRXRapnaT0iqwigic5T14k8w3uqnh/2Y1YKDGLLKVqyitNJz4OG4oKIw/rSOSaT1HgdeW4V6GEgfuuuGAm73EAJ2J4AHAX2FVHm7UIDeIx6eJYlNfl8W+qGwvC0RBT0ZdWlD6t5nUpxGVsjhfdW5IJXaEZ3bBG05W6CfoPc/wSMQhhxvxDuSZ8y5MCQPCSsSscQ8NdxwbzsQP+GMkwsEDjO70PiLWd2qEGfstNM820Q90s95hElPUq1RGgNBsy09bxWGEwThpLb0ds8RvmrIqo4p6GpolDBFapnPfv5fH1ESdjm4SrgVRRHhS/Jn4A7uqzSebuL96kpoQUPvOq39F/RhXTnxQWNzRObiT/0VyX2maHA9Ytt3Z+0xItmbl+/GNGyxCUCBLG9XXq0NrI/sh5CZv2ttlL6ndeYrozqu0Alez3S0sdF7S744Veoym9EoCQMQxl/o9F1EP7vUj+QPi1+R/ynafP0WjB9Yg8YUhLwYFbOdgWuYxO7iTkyrVZ+zT/lJZKAU9FOw3zF9KlpsrS6RkzNeH+/Y9swjGxvjBlniParYmoBwFIDOQ8/lzNzfYm6wJYaIsXrFcSx7EXlXQ0OVKWO00c0h4w
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:55:24.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a550b31-ec86-4a42-10af-08dc57cb2838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

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
index 317308bdbda9..ff9df2ee083a 100644
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
 
@@ -2467,6 +2473,9 @@ int ethtool_get_module_info_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (dev->sfp_bus)
 		return sfp_get_module_info(dev->sfp_bus, modinfo);
 
@@ -2504,6 +2513,9 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (dev->sfp_bus)
 		return sfp_get_module_eeprom(dev->sfp_bus, ee, data);
 
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ea3b4db9847a..33d5b39a1c60 100644
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
index dc3e208f5a75..00406ce3f7ac 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1150,6 +1150,29 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
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
@@ -1162,7 +1185,12 @@ static int __init ethnl_init(void)
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


