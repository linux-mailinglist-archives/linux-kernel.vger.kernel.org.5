Return-Path: <linux-kernel+bounces-156970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22F8B0B04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D25E2840AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A7161310;
	Wed, 24 Apr 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0ddYmav"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9F15CD6F;
	Wed, 24 Apr 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965525; cv=fail; b=hKIYVzQ7XQ15A7JOOZPGdTwMOiECjT3l1qKIsi1gd+4M6gpuAwU85GAhTVPOEaLrcAej9EnizVAsB184rBPeIcOLHxjFRAtcajlAJduc6xC92D33efmvgtPUudgWhMYND8R8g8o7dyTk4dsE6N+jeyaUGsRA+yoGdfkdF6KDNKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965525; c=relaxed/simple;
	bh=AyZq9z8LVXJu0w8WY3EAUe0edzyOPHBOZlDGSipTHpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAJw0+iS7ul7CX/XULQNh9JBXP0I0AoUDAXSazVSFsOKq2vcQwTwdphC5BIvx8oiyyi4Em28Dkf9UYTQPmCRorwxbPshH6+2VCkl/GXSSPqNlPOVmq7YT7dgvN0AIhtpTAEwmepUm/bZy1dS6OPCzYUwK0pgtPMl9vFbw8Ibcxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0ddYmav; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN/n6kKoIvxn1rQvNwgB7skcmMEMFFGGxvhGhSh8Dx69f3edbFEsHyaVojshk1dbrYoIl9gu0V0CUqWnbSKM6WKRoqOsslXgOfoYbsuGVqOXR96jphEVEPR7oJzuC8/HU2sXZO1fCDJ7GQbaK6X1XFXPXEP6AueWV0Nr+PZaBLqASIvzLERWcyYmTTv0mhSOXkXxth4Rl1G5gz79BrOgG9VcIiCB9zZ/4UmgpHteF8VC+FJuA4fwNQuU7kncecebbn0KKdge7iMFiA1j1P5QMSVa7JAbUogfrPCs4i1We0RjrxXc/aauQ07wYaRIJjCS0dS2K3cI8JPU9MYLvEuV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe4ntOaSuicGaSJiHes6nrcOeDZzhBDceo4XZE+9Nuw=;
 b=R9LlKkO2eeCCHNpACrmCGofpRIks7BRnL/eKWUHnAbMlhCFpNtgXzStv/z6Ie0DZpVmxdgKXq74qvOuYVyXbG7KN2WPydRxxYzZS/a8hlii+tNuwxfQVY1/BPOcsic5IwLJyUdyDHVYLfFBQtiSGc1fv4pu5DacfXRdEzfi4Oj5bVp+kVnJz8r2hibpw3QBYSOOouEgFDNJaDgafFXfIHxlfNWSzAU7z2GfRgCXVt7C59xVV0vZc75UHMabJ8UaJUNembF7kkxzrGzjCr5mD/8sD5nilkEM8pF9RrbtDwv23DG1xmdmq37KXBnTsRI2QkkS98iSCF0LVFUJtJDteUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe4ntOaSuicGaSJiHes6nrcOeDZzhBDceo4XZE+9Nuw=;
 b=O0ddYmavb/YiuoUoe36OSsWyFb8IRtP7MGbuT4AWyq6ruBwbw20HVhXudSooYrMu1Y52BVeS0oHhLKIQMfvxhE5vihdUVFHYdeOyHrVc2qESk8Ca8oK7ZxzbuYaOzYHyTouQMU8gXswdJklm9nyh/d5E226OEQfCq0mZdV9c4agWLps1zw9ceCc2P0dJLXTrVjlIPhfYIoeO4MNE9P6oDvELEcWASoFxUBrY9+trXFrgBSjyFZpQMSfwi4bpcLCIYAkgt1OTv0e0xU5Z6gqqHBbNNenbf9VFHOZA5ifls3eS7XOls9MyAkghfonwVPEU44hAeu/MuN29ZhuZO//F7g==
Received: from CH2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:59::20)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:32:00 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::12) by CH2PR03CA0010.outlook.office365.com
 (2603:10b6:610:59::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 13:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:32:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:31:38 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:31:33 -0700
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
Subject: [PATCH net-next v5 10/10] ethtool: Veto some operations during firmware flashing process
Date: Wed, 24 Apr 2024 16:30:23 +0300
Message-ID: <20240424133023.4150624-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 976ea43d-d9f0-49ba-038a-08dc6462eb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5cHtPmPjeWo7HuPbC+qSh4ODpDdyk8LC87Aq6jrEHGSXKjeJjNTb7cwWeGVb?=
 =?us-ascii?Q?M1bXCxODUXKvkQ+XqFZbIZLIp04H1gWTq+5H7vjQu2c+lBAQpDOJHKQ2rBjn?=
 =?us-ascii?Q?QI5JAKztnRRtNAtvt0kTqa4vCDvNB1XWWjWf0TP9T+0gnVmvzUM2XvKefYF8?=
 =?us-ascii?Q?CbmNoJ+LcRiXJ77xJp8HfAkT3/A6TTGNMGPEZnROIF7o7dZ9VtHuOrGcTefR?=
 =?us-ascii?Q?LXz6CMbVnFI11L5DF2i4npiTE00gnrOtUbAJJM/Czd9q87xPRgFGdYLG3c1C?=
 =?us-ascii?Q?nQHYNzHKzeR7zeJ7rpZeTALFrVq8vqbHKxllpdOvqFAJPALoNJ8c+fKsbKhV?=
 =?us-ascii?Q?ptoNu1kxq1kfJ7ZNY2VRKyEYoFr9WkONWkpaN2mKz2MScs9dA9fUKel8/gIH?=
 =?us-ascii?Q?YbtTrhgWHG0fPby1sowOMhRS+FE7GDmitYmhe0autdOEu2+H9Cx4ljZamPx4?=
 =?us-ascii?Q?lqF83AU+WWZLqGP9jL1AItEvxq4kOd4Dux8wZPu5v9BBBCTo5vmhgHUgX4rD?=
 =?us-ascii?Q?sHYJ4mQEfWgum3CuSh+KfY45OqkHeOF4NcYdILOFK4Ul28+TAFO5nUMYVEdJ?=
 =?us-ascii?Q?uK0UhzBTXIJJ/A+GmXRVMUZZlQmtQZUTbypKyStLyjwh4sFnS2zPlOP03zuc?=
 =?us-ascii?Q?sSCBGDAO4x8Atzsdv6ro52kyQTmDSIUvF594mEGYyfcfB9IqgyhDzsEBsuZU?=
 =?us-ascii?Q?sMi6tlvh2rnWcJ8gGh/kruReTzZLb3do5bIC5VY0aWxqgjSG5qryFk1bzS2U?=
 =?us-ascii?Q?ocgB9NRBFGosMWNtsCbbhp6xQvf0sTZTqJFJBZ9KiTVbc9hqsgsJQS8uctIq?=
 =?us-ascii?Q?zmVdhGxaBPwkFRNELldtr8mIPUQ7nJC6xTe8NhyNMvu9gNvgdmM2UULE7jdK?=
 =?us-ascii?Q?PdqzOGVQWpeoPIKNXJLUcx+k5phV6Q55TOczGiMa3pX0PxdhGiRIuGbnka6u?=
 =?us-ascii?Q?BRYsijulsOrOPfXe5ZFgKF49I5vUSGPez0lK/pDbxpHmxSZz0wLLJcUCAYv9?=
 =?us-ascii?Q?wBt7Vu9g6Q4ZCAJd04FRfYd8ZNhBitBJOQVwcfNUQ9miv2yEyz3ASS+gMHze?=
 =?us-ascii?Q?kRlU71Zh2ZQwy/hxtHt8g0zD3IWi+8stF4wUlyPWMqtvb7TWzvuUJDgDIgjf?=
 =?us-ascii?Q?Xiyh4OjExdMlK2pViAn33TKtJNodPCMFxy/ngxpgcYjux8L5AS19MMjVOzDs?=
 =?us-ascii?Q?94OQx1XKlqlKiGhSHGMMSrKYgXktmRcKRtl4jYoRFx7+mdLyJkO7byvHOFkc?=
 =?us-ascii?Q?ljWbXmoqy4M2ngWRHgVc7Cl+7W9LrhBx+STPBPkly99bTXbz3MB+yyz6s4Pk?=
 =?us-ascii?Q?qivgQigGQmPhiw65X4bo44ZO5ECxq3bD981PHcivY0PeUST61G3GjR1hsO/l?=
 =?us-ascii?Q?BCAzbTI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:32:00.0648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ea43d-d9f0-49ba-038a-08dc6462eb9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

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
index f42e9a9a1ab8..abb7c01e34d2 100644
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


