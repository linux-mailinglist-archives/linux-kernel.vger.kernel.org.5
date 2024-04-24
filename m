Return-Path: <linux-kernel+bounces-156969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE498B0B00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD58EB268BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934E160787;
	Wed, 24 Apr 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oy9ZNCPm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19B15FA65;
	Wed, 24 Apr 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965517; cv=fail; b=agRkeoY6/PoUsrzhvnZAA48LD7/dfdsoKsyeh6O0kp38GbtaDIFoOH22ELIkv7N6uj4fY4ZeCAKFvQsX1m5Bhkk0423SSMMPRi/2KgSQXhU/wvL0sK2QR8yZiIRUMcH0TIxeg+HS2Z7e176jY6g3F0cFpSz6CfhvLxRgEPtYRPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965517; c=relaxed/simple;
	bh=GDg8Lb0FmSOBJdZPyinEuxyNC9j/nB3Dwv3rnm8RK50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbfYUmsiNWaAmeqg7hwQqlav2/+A0pzEoP+Z7H4BkGMlfaUUf01rUVrJcDUPKqtpyKsXVs23OcxY7qfrreqCTng+ItvYSCPjImswaahbNDpjOM15QKVhpaurXFbdvXJm2h6UenYB2IrWrIpMuxO2sOqxbRh1LBd2w+VED0JB/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oy9ZNCPm; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nimitnAReOrWBs5RchLQQJyDtbcV/JaYjVN0d6fjCORdlVzihdipRM928YykKzzi6zCBRFlGzfWcg9zjtVEQKR2aXZ1RC+1cMWTkOqHP6zBcDtyBAw35zLqczNNyeYtiAJnu4LFosBVSovK+bzEdHeg58Ldm9ViBizomX/8vtvBK0F7C2yBfbf07qGRJwNp6DwSqKaeaIIyTzKmrvmJzEceMPgkcuHWG/SY8shUFOLzDFEEDgn3aSZNbhf28YAFcm3nUTNpbHDU9AcuNafmqszY3zmXdFVqDGSzDaPr8ggfBTvj96Wr4k5zAVq4XMN/MkmkLu//cuR4FTxX3r45zMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwaaJ+RCq05NNKQRaVnTMGrIzheUtVaAl1mwwv2W3vw=;
 b=B30zEGxCFIVYaQ8cJhQR0BN1R7ga5glQfPGGT+C5KyWetu1aTWS3xgRJ4KZiq38h6UZvCp+3ENj4CNZMW+Sp/yulQt9+32hNdjC8hI4Cwhvme5eQrgyQmgDjaMfWT/CxGHqbQWrkpc1YChGgVPqvtgdgvtI1HrAYCF3TGN4mLewAckzdH5H5olDGj3r5klrvRQck6fLroWSdG7gIYjgTAWVqL1+7aIPGLCkjTQxmX51F61jxb90FYE4cUO0CE4/FoDLV8WnLcArfL/JToc+L7V9bHVk2t1NmAAdXXATJbJRxH4sf8HbglnYc1Mqbs6Vm4NWtIruCMTGhad/0Id3jJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwaaJ+RCq05NNKQRaVnTMGrIzheUtVaAl1mwwv2W3vw=;
 b=Oy9ZNCPm0gVoggoh+VM1G+7+uilFpfN6ZA8KoISLqTdP706uRJsKIttIrwasrC5ivXjWHe2nRDqllFOK+NgBlnqjyiUo6Q8hAFAXfyrZRrMsZ4Q1F9QTZEGQeTRMGDSfrEeWeHBjuy1QB4tBKjPfScaJIZjnYJp5Mwwck9LRhcXK1UuUwm/lMT9EBgLhzacOHpDm42+HW3Q+6N6XjfEl/pcLpCskIAqUXm4nkaQUymwftLhoH7YCeoadhs15oc2tcLE/wc9uP6//D6NSL8hwieZpl9mZJ4fmcOmQRRAE6EZ3nw+dVHp+MJAjDe0fSzPj2AGrP0c2Jgw0LguHgCRONQ==
Received: from DM6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:5:1e0::27)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:31:47 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::76) by DM6PR08CA0053.outlook.office365.com
 (2603:10b6:5:1e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:31:33 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:31:27 -0700
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
Subject: [PATCH net-next v5 09/10] ethtool: Add ability to flash transceiver modules' firmware
Date: Wed, 24 Apr 2024 16:30:22 +0300
Message-ID: <20240424133023.4150624-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eae5a8-c925-4309-987b-08dc6462e3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F5ySQnmkkFv6muUPZ9lnKkQYceAkbfKLLQ8b6MbGqqKK8ZoPevXdCUOG4sPt?=
 =?us-ascii?Q?APHHksmRwhs1qjvGbQ9dLmRUgYOikYowGwKLoYMdHRhz1EV77U54vIQwyTQS?=
 =?us-ascii?Q?4BvuGH28MtdrjyTLHFK8fdfyFJIWqOjTMDiyq9ZLwhN+pMRwpS54P2eYnR1f?=
 =?us-ascii?Q?M04Z4MrVPCBpiThVqknpZjIV+21zYE7GmUwPNLsXVr/o7s3Gt4d3NtTJTZns?=
 =?us-ascii?Q?4o2S7JOXsv+Zj9T3pVMVOM11lX+k9OKcyWiV4v5gyypfUeX6N6viKaSoxKr/?=
 =?us-ascii?Q?+oilL2dx05wWyNnm8rI5SrRzFUgTGDkDQzMw3I85tLhi0O3nUD6h6/LX5oTS?=
 =?us-ascii?Q?fRb5kFNVhMW4zmzRayAw9JPzv82hCOwyzc/e3Wta29aQesf5PNimSpI+l0kT?=
 =?us-ascii?Q?bcR4N9/gwLLv5HGlqKa9k5PovHZ1eEpjfaZy2BjONvba+VyDEUqjehR9LYGG?=
 =?us-ascii?Q?Bj6wEHzhC4ZIiWns4M3X47iha8EVFHSxyeAbJjdH6d/Qu1DAou0qErU0HNi+?=
 =?us-ascii?Q?M5yZ2Em17csMfNViN82J6X9iPVdnQPc5Te30bvqtcEwcKq+A5IOGLMyFmyq7?=
 =?us-ascii?Q?VAkcBnHr/EvlSchCNz7y9QstzX8RJggTryBUybV2fBEXtcb3ThOgm/8ivTe1?=
 =?us-ascii?Q?XR3xSm7tGvJlh7p79grQZJ7VeBYsZMsS8ZJ4C5QVpH5uM6yX7Etvd8/1O7C0?=
 =?us-ascii?Q?8n4X1FZoVgV/lhj2jyFsci2rv3MTVEIau/d364h27BDRqsCJwQqZpHMBYz5k?=
 =?us-ascii?Q?MaGV9+BoaEsK7k1+9Hnneh66TW+pQ5Cl5v/WlIpcFvWfwAt0b5BSrSJsr87w?=
 =?us-ascii?Q?knXtJGIp9kOWSAfami1HbR5RdenYylvAMfF3yHMowFDRuKMYlp37Iv6ttVYF?=
 =?us-ascii?Q?p1YYpig3JYsUtxns2yQ1aU9REAR8iFVDnBd/coGPHJmAcZrKfJH6W85LvGMW?=
 =?us-ascii?Q?8aG2Qz1PKPgz/mL4tQLuAhlz+6QuyiHN4ymOtAZZEB5c+zKfylsYeT0U+VBU?=
 =?us-ascii?Q?8mms5odAxMpudhsHrUS5vAo6IRDfvO4o6hPtRqIxQXEyXz7b1TlPWlek07bd?=
 =?us-ascii?Q?4XDQph3Hu2vQ4bF87TBeXdQnHsJLLff9XogcFcwSsHDARUQS8kztevMKeVrl?=
 =?us-ascii?Q?HCChBP5/ey6UC8DEx4sGXhJcd5Gr7iyOKnV6TJ4I55B6Jq2CZpuGC0Q+3T0H?=
 =?us-ascii?Q?raqgyZ5Ca+pwdox6IdFk5EZOrR6Q40SxDe/TfS5/t2FFLgP815byHS0UYb4R?=
 =?us-ascii?Q?2lDJJQgP4vgqBaQIfQyadvx3ESLSks+XddfGj4KB06Z1uVo7mJfrOU12EypX?=
 =?us-ascii?Q?cP0iIw33pcYlcDOjt+BGsY0xsYASreY8bevigAg/pVvcDwQpTzgtKcTB9dgl?=
 =?us-ascii?Q?lZ0l9ib8iUGmXhNe7zkGMfJ/z1qF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:47.2104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eae5a8-c925-4309-987b-08dc6462e3f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

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
index 114a2ec986fe..f42e9a9a1ab8 100644
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


