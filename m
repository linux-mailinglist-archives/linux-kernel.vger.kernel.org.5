Return-Path: <linux-kernel+bounces-32556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD059835D15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDDA1F2363B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CB3AC1B;
	Mon, 22 Jan 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QM3ZNe09"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686838FB7;
	Mon, 22 Jan 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913225; cv=fail; b=WQ2HIQzbv8dsK5oj8RouOD3PIIfGSHh8BuIGXSUtfynr1dBozlSOMjH33Bb8QtTrSqLqm+LOppHad4bFc/MKen8R/V9Wdz/xof0UEeEsoKtE+x8ICh3uV4HnUQD4AIc6xSE9qVx0Ibt64oNDffZHwWfeNUtVdNTFy2hgKbqqgR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913225; c=relaxed/simple;
	bh=MbRK6/zyypZDras7Ojni4hWbgIISVYMN8+1fiHTEfnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBgj+NWrfgdhVRBHvC5B7sPO9ethgEWRnsthiNIqXWJjxuGDPWeqgRxz8VzVsgCrWgTBdacsZeGSeHaJyCbAzBxRQ5xmbRPhUYD4Ly81HvXZQ2MsUS54bSbLZNNgrfuVm9UkK2w2dAeAaaekyfHUL0W2Agg687IlxR0MfUWdmJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QM3ZNe09; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbOtqSVIe67vuxG7Xlzjj8dP4uxtXojxgMKC5HYqRK5UIfF5B8BHy8HHRyoKHvUAtBkbf2tq11seQt4G+59zcNiE29zEUMBL4/zhkl2ePAM0Q5n6fKwGMbIfhBjZ3RmNCf8SEzyQuHrmpuqBVFu58HLshC8+qpqJlctreHQ/CJA6xsMySFoJMpNSi/HWC2t0Fq2UGXbIMj7mUbW1F7KNUTbGKXnIxBUFRmfGdR17FLK0oDLpdi27+eabOnqEgAnMHev9K5Z4vk8wDrw+X4BJlp2ppMN42pKrz1097MuOjudRDsDIr5LUVc5szlg2h5koq/ZyD2uPxxnt3M/t1VBAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlURVs4NqzvyjS99PltohAtgRthKnFTlg52pIs82LPo=;
 b=hTpE5fjZBbmEfyHHjgYkwF0kF6gvuEk7E0SaTjxZyUNGoAQ1OTmwJeUq4qK6pXQ/VQUNcNyOp1SxqRq1eDfm7UwjO+ptpG1aarwhSPLxmJjRxblESfxcReNYiAUZaD3F+QShZCrdgjhFi2QCDWyYMz5gIf4LmwG1r5yoxDee5GE5Nt+59i8uWpwx3spWAQShiUv5v8CLl+PljXHvq4IzzgkVTF03BAJvlQ68ZsGR7BtB29fg/T8MVFLe+5hGzOqDf9ts4FY4RfGx9v22bK9bYdtUDFrq53OkRQQoVt4H7b5xnLAvw0vDvdp8OhanPeh8zTfjko5sgFYmw88A13cALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlURVs4NqzvyjS99PltohAtgRthKnFTlg52pIs82LPo=;
 b=QM3ZNe09I0/QMJ97nuDqEAXKp/fMd6kX4q+SelETlcyeTkZ3vO+biwyS9lSZepUXFuqFN7/pthWsMcNqtPL7b65rxYWM28ouBLENzRmyrt5lBJmN66dD2WTiT+XgAfH4CmCWYklrJ900SOotUVrfjx0MrzTQx6hfc7hSqINfuI8/8dHWrZ/GojNsmN74kYlEk2r4R8hrdfJJU34VwxWLonbZ/WkUokTPpov4ZFklEKW33Z/zdcdXf1bG32f0zkijZmLEwc/sWf3LijMjEbRrGHwBi7R3mQ8YbB+IpKmCHASrl627wExWJ0gwNNFnazvV0ZS2jcJoPNOBfqUoKtiHBQ==
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:46:59 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::9b) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:46:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:46:42 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:46:36 -0800
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
Subject: [RFC PATCH net-next 9/9] ethtool: Add ability to flash transceiver modules' firmware
Date: Mon, 22 Jan 2024 10:45:30 +0200
Message-ID: <20240122084530.32451-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb4c890-756a-4df2-ff37-08dc1b26b23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5raV8CKTqI8AK9lMTCVnAb03/+u/QPGdsZ25O0dKlHf3+kirMXRO8/2ozT7KLSLrx6K8+8msTPDt9sLymsxcM8QVu6P9x6mO95KulS1HpP1uNjBpRl3/IWO8X2d2lKQatLeNbgokUbmE0qX3buY+yRNES2ffy6goRmAxANEZwTSTWSBoryTn8mLO+jap9pVUJe+4AlbK5JaAf/fJvTcTyhbpuUXWVmBvipe8BHuRBe3xRlwcOHS2CTD3gKKg2jHbVhcOL9V/9TCus35c5F8aXp+0U+NSANJ5IDXbZNvKy42UeSeJIfKy/osF2t3F5M/U2qRZGTfIccAhfKuMAT0W4W+pTzY7FyIS6nP45O81u4Qu49tng/xW0kVW7QeHZ2dae5LbKSonzbGr77BKDI41VmrQVDdAWgrIpgHay1uKunzMSkvzbW9AH1SvveBZ5VJ+dMeouDdj635cNauWKOkBNyXEkqRDHn3n5j5upoGccq0XPNe6YI/Nn8W2oYK3h70YF2M+U0FJX+Zql7lFja4CbBmglfNH7BEZ6mFEBxmgVex/w+0m1KUgCK/udcJMoNYKC4ca8QAOFssy1J30fkh57Kzwhy1jSNISezGSaTsM9MM41zW8bUxqYiNlRcLc1KKogBc1sITI2bpxVNw9YjGnm63v11IiIubSuS5M4RHxP73ziFEBHHvBgJP/qvl6bThF87l+KoebrsogUGn/6CGJYR3Q2FoOEhXD8y5MphFlonaDw0KyrH/Q17CStuUOMLF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(83380400001)(36756003)(86362001)(356005)(7636003)(82740400003)(36860700001)(5660300002)(8936002)(8676002)(4326008)(47076005)(2616005)(1076003)(336012)(107886003)(426003)(26005)(16526019)(70206006)(70586007)(6916009)(54906003)(316002)(41300700001)(6666004)(478600001)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:59.1319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb4c890-756a-4df2-ff37-08dc1b26b23d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

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
 net/ethtool/module.c  | 179 ++++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.c |   7 ++
 net/ethtool/netlink.h |   2 +
 3 files changed, 188 insertions(+)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 09cf11564840..69cedb3ede6d 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/ethtool.h>
+#include <linux/sfp.h>
+#include <linux/firmware.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -160,6 +162,183 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
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
+struct module_sff8024_id_rpl {
+	u8 id;
+};
+
+#define MODULE_EEPROM_PAGE	0
+#define MODULE_EEPROM_OFFSET	0
+#define MODULE_EEPROM_LENGTH	1
+#define MODULE_EEPROM_I2C_ADDR	0x50
+
+static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
+				     struct net_device *dev,
+				     struct netlink_ext_ack *extack)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page_data = {};
+	struct module_sff8024_id_rpl *rpl;
+	int err;
+
+	/* Fetch the SFF-8024 Identifier Value. For all supported standards, it
+	 * is located at I2C address 0x50, byte 0. See section 4.1 in SFF-8024,
+	 * revision 4.9.
+	 */
+	page_data.page = MODULE_EEPROM_PAGE;
+	page_data.offset = MODULE_EEPROM_OFFSET;
+	page_data.length = MODULE_EEPROM_LENGTH;
+	page_data.i2c_address = MODULE_EEPROM_I2C_ADDR;
+	page_data.data = kmalloc(page_data.length, GFP_KERNEL);
+	if (!page_data.data)
+		return -ENOMEM;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		goto out;
+
+	rpl = (struct module_sff8024_id_rpl *)page_data.data;
+	switch (rpl->id) {
+	case SFF8024_ID_QSFP_DD:
+	case SFF8024_ID_OSFP:
+	case SFF8024_ID_DSFP:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+	case SFF8024_ID_SFP_DD_CMIS:
+	case SFF8024_ID_SFP_PLUS_CMIS:
+		INIT_WORK(&module_fw->work, ethtool_cmis_fw_update);
+		goto out;
+	default:
+		NL_SET_ERR_MSG(extack,
+			       "Module type does not support firmware flashing");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+out:
+	kfree(page_data.data);
+	return err;
+}
+
+static int
+module_flash_fw_schedule(struct net_device *dev,
+			 struct ethtool_module_fw_flash_params *params,
+			 struct netlink_ext_ack *extack)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_fw_flash *module_fw;
+	int err;
+
+	if (!ops->set_module_eeprom_by_page ||
+	    !ops->get_module_eeprom_by_page) {
+		NL_SET_ERR_MSG(extack,
+			       "Flashing module firmware is not supported by this device");
+		return -EOPNOTSUPP;
+	}
+
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack, "Module firmware flashing already in progress");
+		return -EBUSY;
+	}
+
+	module_fw = kzalloc(sizeof(*module_fw), GFP_KERNEL);
+	if (!module_fw)
+		return -ENOMEM;
+
+	module_fw->params = *params;
+	err = request_firmware(&module_fw->fw, module_fw->params.file_name,
+			       &dev->dev);
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
+			   struct netlink_ext_ack *extack)
+{
+	struct ethtool_module_fw_flash_params params = {};
+	struct nlattr *attr;
+
+	if (!tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]) {
+		NL_SET_ERR_MSG_ATTR(extack,
+				    tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME],
+				    "File name attribute is missing");
+		return -EINVAL;
+	}
+
+	params.file_name =
+		nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);
+
+	attr = tb[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD];
+	if (attr) {
+		params.password = cpu_to_be32(nla_get_u32(attr));
+		params.password_valid = true;
+	}
+
+	return module_flash_fw_schedule(dev, &params, extack);
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
+	ret = module_flash_fw(dev, tb, info->extack);
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
index fe3553f60bf3..85e27bdb1f73 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1129,6 +1129,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
2.40.1


