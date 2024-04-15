Return-Path: <linux-kernel+bounces-145038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB38A4E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA682835A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82426CDAC;
	Mon, 15 Apr 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLwAWVbK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD971733;
	Mon, 15 Apr 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182937; cv=fail; b=DGGvH0Qc47lIHT9SkUpVspgnV5tcnMZaEIoTcWhT+N86HXn5bTu1mh5+oom9gMZsgCzLUWG10DJ7WNc6Mp6bHV2tOGV1a067m+S78U3rcoj32Mv3q18QXEI5hUUctzmzPUsSW7SKNlSgpLd+MHzcutL7fg7icnmK9KczIGCMZKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182937; c=relaxed/simple;
	bh=AfMSgWSQr14Kq7RRN+mCLxiDZzv7bYqh+EGqO3emaZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTHSckYU1bn+kGbT0mh7+yos0YzKu2sHoLhql2sIQSdrCvlgXzNbqhwDOWx4YPmmmMOqTmUZAMPZ8AYQfeYYmpqJ6SVGBjyEYviPb035Mvk8pvH5lj4TeVLLu3oZFCuC5n1DzIg6I0LsLX3vVixY8EvHNneB5P5V9rqXR11+V/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLwAWVbK; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kqm2gVZ5GmdAnFbvZYcEvtp5LZ3xUan/4ScVg1MCt6b/iA+t55/aFIblsKJx2D4cFAIyamyn14hMKV5K4XkDNhr5mxk45H4oOFEkBKFJSmRAVNRh858opkh16XDJ2hTGsBa5CVLGfWSN/81rX8/Ijjy0XyvTuvqZIorsqVZS8nd+/UY7spG4SIwFiP2YqmNXnjJwkv6bVfvgiPgP2SIwR8jB1h4VI3BNgQqQvAzd+wanEMG2bSlEmiLqtMEJzfb60xbNyjCB17dJKayOfgpELzAZowgkc9RAF6usJ4b5aE78u6XHmYqSAvkhAf7mS5XHO15eautqeUdhA5JZIEcI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38Gdhk3KN04AsB2+FtnOPufQa9OPd0VNkEYGnuMTvIE=;
 b=eU358+iUYh5bFS6C4F2+KAob5htZRSDWiEJHHDomBpxkDQ2QiZ1HPp8qb16iqZEOVqZTodIrhDkC03isXQVgDr01m0uV1Q1wKZw5Iy03w8cZrlGh151l9BFUSkH/Z2TYxX9CZBxV+vkk4TD0YS1E224/lC3y5gYR1wBcVCBMEuYSQSpvc3juKh7SOiY0ItwEIbes+7hz6fGJ2gZJ1fAAo+vB8F0VjtkuOt+HTYNx1nIn+AJSTfWl09e8YjtZ9B56QlUgNvk4u2ftYnn8y/GrQFEHeUuEYliTWs7+Vtdqtd2AChtJvdsjgaU0kfFTF77yg1P0kuMszQMrlgu62IxvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38Gdhk3KN04AsB2+FtnOPufQa9OPd0VNkEYGnuMTvIE=;
 b=gLwAWVbKijzwuuIGWefgpaIQUZ+JzczNCVxQEPa28IbbQPFzJ3b7XGQ4PAHTHtL1P6jPYzFTgQAoOKcuPokkoaOPVxIP2K+cAyR4O5xZ8DQ0ApBCx1QHrIBdCi6pF84MRQeGKmIZPAgpIxtxvTqxCkMdIsLy400O6NN0f/4ofbFLbmK61MreNSvsEkiJ2qwOSemGv99Erg5OunJd7t04VwHnCFvlavPlTJ6D5nV5ZOWENgsyDl3mJ4692TFqTVAFxJHsg0zJZ8LWByRRXgrwHCuqbExKkF3cnIXGLJ+Y7uRXRUo6/MQ9Z+C35KG/+Zp7/xphApT8orccwmsfOCWATA==
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Mon, 15 Apr 2024 12:08:49 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::97) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 12:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:08:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:08:30 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:08:24 -0700
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
Subject: [PATCH net-next v2 09/10] ethtool: Add ability to flash transceiver modules' firmware
Date: Mon, 15 Apr 2024 15:07:16 +0300
Message-ID: <20240415120717.1251864-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ecc4df-3a5a-46d9-3e57-08dc5d44cf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sq6kDZUyYIoxOlMdceVhGbqgkzIBRkTdeyKHDtHNIW+3Tfa/AAa3msdMSJmjGeWXOrON4/uWAqBqtODjGexHQDoqlSGdCyTMaWN10tUtDwHKyEqc0CSoIR6uiarWFR2wTOkbxMk1V9yHpoKnsw1df1qynY79nmxKNCLk2vTIAanjTipQVAlKYU1lhDKnLDawG/sKPdqFxmQs3p+RBeHzs13dYqaOnQBy8Sc0/Y/8+SqixdYj84gq+Z3NVY2t+zstNUhU73xeP+NbOCJBE+qa3be9lhrdBcaoTx02hKxhklUB3TRkus+J3HRpYZik+0S5Jc5luD2KmIiY1der2OS67V0X0/E6XEaM/7aGrgddkKo/eqcZtdnB6Vsn8fVWNkxnaz2rqE41oOHYiZR4PiQI9R8w5oqn92xTM4OVwDh+u0vYD++p9k/MSY+3adRkibzolG/NvP78TuWyPQW7ZTD3aGCG3NLNYPKWfX1NSLwvvhnuyQJltsyxJLFk/Irvs7J6dXADZ1lNMZpy1R7n9J9l4oRCg7y7996b8WOes/o5httabHM0qnoKBuC9fR2fYof+Uwd6uzYjQNQmNt54pEokO2+ZZ47fRGdZoriTGIku4I5Eb8XBJp+4rPTE1bQtlG6KvC43R7se4yJOR5aXJSabd8Mu5X4QX5E9Q6hwy0su66lThQiXJTEV67Mfujqn2jHVYisv4FaaxYtPt2ouIhTnuZRheG5NSD8An/pamTz7QYb0ka750H0z9nhOflFy1R6M
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:08:49.2810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ecc4df-3a5a-46d9-3e57-08dc5d44cf2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

Add the ability to flash the modules' firmware by implementing the
interface between the user space and the kernel.

Example from a succeeding implementation:

 # ethtool --flash-module-firmware swp40 file test.bin

 Transceiver module firmware flashing started for device eth0

 Transceiver module firmware flashing in progress for device eth0
 Status message: Downloading firmware image
 Progress: 0%

 [...]

 Transceiver module firmware flashing in progress for device eth0
 Status message: Downloading firmware image
 Progress: 50%

 [...]

 Transceiver module firmware flashing in progress for device eth0
 Status message: Downloading firmware image
 Progress: 100%

 Transceiver module firmware flashing completed for device eth0

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/ethtool/module.c  | 174 ++++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.c |   7 ++
 net/ethtool/netlink.h |   2 +
 3 files changed, 183 insertions(+)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 1c659bd85160..836c198d2cc4 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/ethtool.h>
+#include <linux/firmware.h>
+#include <linux/sfp.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -160,6 +162,178 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
 	.set_ntf_cmd		= ETHTOOL_MSG_MODULE_NTF,
 };
 
+/* MODULE_FW_FLASH_ACT */
+
+const struct nla_policy
+ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1] = {
+	[ETHTOOL_A_MODULE_FW_FLASH_HEADER] =
+		NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME] = { .type = NLA_NUL_STRING },
+	[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD] = { .type = NLA_U32 },
+};
+
+#define MODULE_EEPROM_PHYS_ID_PAGE	0
+#define MODULE_EEPROM_PHYS_ID_I2C_ADDR	0x50
+
+static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
+				     struct net_device *dev,
+				     struct netlink_ext_ack *extack)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page_data = {};
+	u8 phys_id;
+	int err;
+
+	/* Fetch the SFF-8024 Identifier Value. For all supported standards, it
+	 * is located at I2C address 0x50, byte 0. See section 4.1 in SFF-8024,
+	 * revision 4.9.
+	 */
+	page_data.page = MODULE_EEPROM_PHYS_ID_PAGE;
+	page_data.offset = SFP_PHYS_ID;
+	page_data.length = sizeof(phys_id);
+	page_data.i2c_address = MODULE_EEPROM_PHYS_ID_I2C_ADDR;
+	page_data.data = &phys_id;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		return err;
+
+	switch (phys_id) {
+	case SFF8024_ID_QSFP_DD:
+	case SFF8024_ID_OSFP:
+	case SFF8024_ID_DSFP:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+	case SFF8024_ID_SFP_DD_CMIS:
+	case SFF8024_ID_SFP_PLUS_CMIS:
+		INIT_WORK(&module_fw->work, ethtool_cmis_fw_update);
+		break;
+	default:
+		NL_SET_ERR_MSG(extack,
+			       "Module type does not support firmware flashing");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int __module_flash_fw_schedule(struct net_device *dev,
+				      struct netlink_ext_ack *extack)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	if (!ops->set_module_eeprom_by_page ||
+	    !ops->get_module_eeprom_by_page) {
+		NL_SET_ERR_MSG(extack,
+			       "Flashing module firmware is not supported by this device");
+		return -EOPNOTSUPP;
+	}
+
+	if (!ops->reset) {
+		NL_SET_ERR_MSG(extack,
+			       "Reset module is not supported by this device, so flashing is not permitted");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int
+module_flash_fw_schedule(struct net_device *dev, const char *file_name,
+			 struct ethtool_module_fw_flash_params *params,
+			 struct netlink_ext_ack *extack)
+{
+	struct ethtool_module_fw_flash *module_fw;
+	int err;
+
+	err = __module_flash_fw_schedule(dev, extack);
+	if (err < 0)
+		return err;
+
+	module_fw = kzalloc(sizeof(*module_fw), GFP_KERNEL);
+	if (!module_fw)
+		return -ENOMEM;
+
+	module_fw->params = *params;
+	err = request_firmware_direct(&module_fw->fw, file_name, &dev->dev);
+	if (err) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to request module firmware image");
+		goto err_request_firmware;
+	}
+
+	err = module_flash_fw_work_init(module_fw, dev, extack);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Flashing module firmware is not supported by this device");
+		goto err_work_init;
+	}
+
+	dev->module_fw_flash_in_progress = true;
+	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
+	module_fw->dev = dev;
+
+	schedule_work(&module_fw->work);
+
+	return 0;
+
+err_work_init:
+	release_firmware(module_fw->fw);
+err_request_firmware:
+	kfree(module_fw);
+	return err;
+}
+
+static int module_flash_fw(struct net_device *dev, struct nlattr **tb,
+			   struct genl_info *info)
+{
+	struct ethtool_module_fw_flash_params params = {};
+	const char *file_name;
+	struct nlattr *attr;
+
+	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME))
+		return -EINVAL;
+
+	file_name = nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);
+
+	attr = tb[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD];
+	if (attr) {
+		params.password = cpu_to_be32(nla_get_u32(attr));
+		params.password_valid = true;
+	}
+
+	return module_flash_fw_schedule(dev, file_name, &params, info->extack);
+}
+
+int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ethnl_req_info req_info = {};
+	struct nlattr **tb = info->attrs;
+	struct net_device *dev;
+	int ret;
+
+	ret = ethnl_parse_header_dev_get(&req_info,
+					 tb[ETHTOOL_A_MODULE_FW_FLASH_HEADER],
+					 genl_info_net(info), info->extack,
+					 true);
+	if (ret < 0)
+		return ret;
+	dev = req_info.dev;
+
+	rtnl_lock();
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto out_rtnl;
+
+	ret = module_flash_fw(dev, tb, info);
+
+	ethnl_ops_complete(dev);
+
+out_rtnl:
+	rtnl_unlock();
+	ethnl_parse_header_dev_put(&req_info);
+	return ret;
+}
+
 /* MODULE_FW_FLASH_NTF */
 
 static void
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 563e94e0cbd8..1a4f6bd1ec7f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1169,6 +1169,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_act_module_fw_flash,
+		.policy	= ethnl_module_fw_flash_act_policy,
+		.maxattr = ARRAY_SIZE(ethnl_module_fw_flash_act_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index d57a890b5d9e..e1e2edd05206 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -446,6 +446,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -453,6 +454,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
-- 
2.43.0


