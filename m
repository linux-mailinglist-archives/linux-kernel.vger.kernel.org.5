Return-Path: <linux-kernel+bounces-135372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29489BFA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5DAB25C59
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B17F466;
	Mon,  8 Apr 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cN9I1UP3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C17EEF4;
	Mon,  8 Apr 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580920; cv=fail; b=HOD5OUR+JefltFSAuF98LC5qzMpvdq04hyF7tLPwFBj5Z9MsZtbCNKKv4ieKlK+e1qh/Au3e2Sri3L2zlj3rtWWLkynrSqzZJwzj4NgUhzJGvJOVBm3iKcdF3mdAj4mPK7NeRmSpOlLCHU2uC7m4P+YIv+rJ9soKb9J2VzaDqPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580920; c=relaxed/simple;
	bh=JTac1z5ELy9SrBBxysMSelD9e9piJV439+U4bYaGNxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXw/OieV0kUXEJoeaEypgo4Lx31bzrMQ30kOoZu8fEpwMBL5y/nSGRqxSBKU1Pz8rQMjW1bkVNZOIfEbkCU4c8/LCKfMMo378y9Dc5nD3jg5RJol+eJzr6N9uBZA55gGYz6upl5FOUfATtt0OR0f7AuqaQHqHYAJUYNaQQDfxl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cN9I1UP3; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTcNknIMZ89/DoyuJg/JxrDHaKJbRCOy/Ld1sPlLQ8r8mE6kEbNIAJT1bldLnaSjrNE9XnJyHkDdjU+u4gY4nUuSgeCln+c8YFWd/f0wXw6/ARX9iaR0b7Dp/d3HfJXH9+sGBdj8GaTZFZFGUJZrB5CpCxMv9SkItn3hsovX91xfLRGBHUrntogey9CLkWyZMG/B0q3Q9D/pRDeXwBw2a/FenjN+IiEdH/jPjYKMajtwoBwibUSOnqMFt2Y+FC2fP2yVnpCE2SzECUuM9bfEaMwFvDmIDUpy/TFjWrn5IR0L7FbFlLi5mbiLTX2W+/bqvdrICK5/rgHfJCy4p0K9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms7mswfQOwtcGKOeOaA76fDWr6OcMeb2MRz0PyOcP+0=;
 b=m2txtqt27tkKk3iA5ZDNcOX8ZBsyzIYzwjpqXXoICxWM3vUKeS3OBzQa2/8H2sKbAdBeRPRi0e6z1SakG5HQLO3JubLR8a+qS6vQ/QY2lbIqf9X3JeWcN/tiuethBko3TYWtk8qUj/SDGyRcjVHfZS3a0rSvak1rYoWuO3GRi9kYq779xu/QQSG5niUPDk5285gZWmg6+LeePqOrua2+62w0mZ8vqEQIUwSgFO11e2RQ34dChn+OQrCtfH+evtK36lI3IzyCvfdOztQ0+XPXBdtEEbVICcy+bUCDJZ+KWrY7FNY9JARur4E/kojrqtH/ZJbgH/GsxluUbeVeVHrn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms7mswfQOwtcGKOeOaA76fDWr6OcMeb2MRz0PyOcP+0=;
 b=cN9I1UP3fwv5J2ciH2S7wOgdvA9SuWpm64qw/G9Cm5EVZqBD1iMCdlAw7WD6z8Q+H7g8KM+ipKhCmPEXA1ZLknrW36bnl4nM3bMNw8fJsEGrLVgnu1FfNOjt+sP6gtRnV6x52SAHe4jAMRYcGckf33MYqYoYyt9MGizN3BsThD3khGkE9XuXdtMh7H4zNV2FUPGGLtp3yeNId7UYnTfZo0YYxALjGLEellPhSNwWQiN9/JAWK5IMPqF7nmoDb5jgyMegi3f5HXEWgS3ulYu6B4eD+nSWC/o+Nw5DVM//WyyOCwvPHw9PdPBgAGN4Ibuky+xjk8yzB039J428KB61OQ==
Received: from SA9PR03CA0004.namprd03.prod.outlook.com (2603:10b6:806:20::9)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:55:16 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::16) by SA9PR03CA0004.outlook.office365.com
 (2603:10b6:806:20::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Mon, 8 Apr 2024 12:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:55:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:56 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:50 -0700
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
Subject: [PATCH net-next 09/10] ethtool: Add ability to flash transceiver modules' firmware
Date: Mon, 8 Apr 2024 15:53:39 +0300
Message-ID: <20240408125340.2084269-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd94e81-52b8-413d-d20a-08dc57cb2309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3TXigLxUfWIm2eON6nSFJDMP3T/Ei8XwLR9r2EwYzW1yPWGeF0S0Qwg1JKsmBVSFU5Ioql9Z9+c/RD5fT9nmwOJEmVJcRSXQCxjrFFExpk0lmZAD/B3u/XoF23w2zFk1I+TpTUMbNC9g+SN8fb70xCGNYwOEzEaXEyaKC6pr9mJuN+2WziPeh7YS+OHn/PquNlLoSlBq+xLQhvg+jcsKWNdceMhHKED7kQwXTmIM4HeBG1ztQWgK7hfdJGATI9X3x4yzQqobRrRA9t7s5bwu8ZpfrPf2XC+f0MuW+V2p0wjGmXQ/0mlwRD8GE+NZK1qkJrVbXHjkt82J/BFKTOHK8kFuBCjyEpJ2lLwy6kskkda9m8qOqvDrxUc/VSmv/kks+IdPNh5bCppMZdWURV6jwFagHtyyLnZdoC8F7WCVp5oHb7a4/2r2NsEt0yDlC32KQl7hMA3iPkz0dxnE3WvpDq34HV2WEOopEmlvqttJboLUda3ggHgSZuto1TxV7oZ9X/kyR+hqZdmzpKuW89qo1bvU/PQLIPGvGCtyQJMqk9n/vlY6+z5BCdgEXg7axXJJAj5GpZ11DOcuMKDaOwdpM+S7cNeTT7ZB6cLhugNJmyA+bqfytR/raIqew3ZhWeIxo1XXeU63REcVhbZPhXt1mTinopiGwaE4TTMXyPBLzPH4tvxPG4BW5k7bCK9s2tjUjaHxpt4NjJRME3YUg3e63UmJk7pMAJI10kR0fXFZ3quKgXlxs4suki5TjvLSk3QZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:55:15.6185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd94e81-52b8-413d-d20a-08dc57cb2309
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

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
index 34e2f75c9e2d..ea3b4db9847a 100644
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
index bd04f28d5cf4..dc3e208f5a75 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1125,6 +1125,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
index 9a333a8d04c1..46712c9531ae 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -441,6 +441,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -448,6 +449,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
-- 
2.43.0


