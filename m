Return-Path: <linux-kernel+bounces-48400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87EA845B78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35601B2CA11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F621158D73;
	Thu,  1 Feb 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ju5itGKz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9477A1B;
	Thu,  1 Feb 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801170; cv=fail; b=Q9IG2UA1AeZn7uYq2HKxtXpsY/4q/TSXZiwNdNhrZoP0D5XpVNXdotO3c4iH5n4ZORj2nEeRfmkD+4RawnWM2Gwzr9fPPaf9acefOWc/Nohtlr4rBRaFNjGvPcyLvQYgEGlmvT8bLEaGqUHNDL8L7clfi4tqga/msxkugrbeFWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801170; c=relaxed/simple;
	bh=TBSwkPTQP40RZC5fqHwDMYBnRUPtFEibhFzzRGpPCHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt6YyBloWVQ2WTK7wGwlxQE3X6yWk0Vq8/xHGxUK2J1mvfCwNVUZb6G3Da7Te2NulNzP+fMdiEHB0+JumQ+ZKgNWexSqfc3VtwS1SZDtx4ARf55d7jxY7RI7r8TI5ft9llplcJ7DKEBbh1NkKiO8uhVuYbVBfb6ACZ34aBlT8wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ju5itGKz; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6KBCbcarffQzKAj/Cjbx70zqjyu7gi7VEk6rpi0mqzNqGVsawEsDcyFqP8flOdabrRHBMX8V8yPEcoX+Izy37EOlXgoRef5XFpMcZou1wF2vpEPZf2Gw4RK86m3Og4k18TMHpxHiYtrlzJy4wzWl4Qrt/PkZ2cjYFgmJPMQ1WTxlUZxTOfmvBdj8SU04cygoaQOEOsFGhrzyaU5oKwUOp0VGPns/Bs57pMyGxoN/n4CHhQ9IywuX0CKDmaKpeyWYY3t/OHwdnsf4Tc6E6KSvF/YeTDJ9d+BsfSgqDl97H2GGf/m3VVGm3OsL8YkEC/z4LKM3nxgu2x0GY5NbZF1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWPDCsYso46zBksEAdJqyXz6pkKjks9CRjCua79qY0U=;
 b=JDY9rsC0Tm6pQj7y8rjmMj2OWHIGTtWlkMuZFEVT1Ryi59Y0N4YOQCvNcQ/uv1i7bYyIW3/ND0yThF4lAjK/3wHaZpywWpPDaYqtbtztq1QVA4g9Wk5ZHUY2kqHqoIHkFtAXd6YRrcnen16ztuuRCt/HWdtAQSNuGc90i9DdM2Dx11hra8cmIr1qSrCpNiXb2xi4ynX8yaV22XIYZvVBTpZdxd4/0zP3DhHiBZMHtRX/CLvrr+GkvY1J8lFO2huaVKDHMaIVGFyZci90pVOokcWiaWBdca3WRGwv9opC56kWbOXnvj1SeNw5ToF2hKhI5BmT2zSD3jvMQssr1hHcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWPDCsYso46zBksEAdJqyXz6pkKjks9CRjCua79qY0U=;
 b=Ju5itGKzH3DraxNI/SpxSZXCSE6bCzNET4rNDJZTM7c4anSfM0VHZn5U2HT1cP80p9u9ag5cSbS/zJZI8gx8ixTIEhcoK6miYDHjqA+3izmRxqlPQzGD2TQiGbQhnN3kakPxGgcwG0tPpdbRAEOmrNu8WpS3lV/9cJvZ5iKkuAaqemoK8gQCY2IRaRCdRGjqZ4iQkIWBfxsjXz7L+Ts/9F+yM0vBtvAue3GUkGGoIUwiz1RgOxzzMOPzcY+Wv/F3CQdFLA4hKqpTLmgsDd6om8lDveS8L66DLf2vtmxia7qUyJqj/lSy4o2AOn9vKijp8mEB9wEOzFty/inQwCfsUQ==
Received: from BN9PR03CA0571.namprd03.prod.outlook.com (2603:10b6:408:10d::6)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 15:26:05 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::49) by BN9PR03CA0571.outlook.office365.com
 (2603:10b6:408:10d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 15:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:26:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:44 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:39 -0800
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
Subject: [RFC PATCH net-next v2 4/9] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Thu, 1 Feb 2024 17:24:56 +0200
Message-ID: <20240201152501.3955887-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 9832897e-3666-44e7-9866-08dc233a1b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+8MptD7/NXG7Ij1wCuIc7z8bOh+Yfw8KiRwd+/+MJmnw1hcU8KqcuAFQ25bAw0bXFbW+uLP7yW6ui9m1gsb2Tdc86Hthn65cxJqJshd5N8QBjQUuiYYOsIUs+UjJg8qb5XzePaVas/0UC5B6CAWFSXyyCnIpDU7CWe7CrcUDHHsXY7aH/8j4z4efdao+pYkeifq0hl5oNojOyf2evlws0ehhOlhXh1jEZrLQdGi3Fm6Om2D2ce6dxp51YaK2B59MPl3Wo25S5Lh9JjBWc4Nayt4i6amV5abJQ/kOALuW6hbjJpM5Ws20RBo8Qev2YRqIhCChXAD9lZz5wzbY3RNJYtEJMmImvJ0Ixt61IIStWMVLbGZACc9NHarLEUzLNr/8awjKDRahSL4GMrYjynWot+4Q0Ljk07j0vduclPP9SBWdOGavOwwlH5/l6d2kxb1unKkbD5hKc9HyIUnlecf/aC+Q8dO8EVRfRZi8y/pvbubaYxLJxvkbRNaZ3+qTv5hbj2hAgvpN4q7WzB/zFDRfDUoy5AKwod0bacAqXFs6UdiPkFTyr3XQHavBKN1QLDCZZR9VXFD6/0Xybzcisk15QrhFIa1ZCs+tNX+JLQ8W9we2WoQTv+YOy+u4IqrsfU3Owmx6a/ghbbCxLq54cBUa8F33C8BssKrQCJwtMPYsOQqp0hZiJSGi28rUYAMYvzY3CwF9IjYGs+WFgmPUN+RgpAc2LkMjAygS917WGUmht1aNzNaZFb/+A3xlI0+AKjYS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(107886003)(41300700001)(2616005)(426003)(1076003)(26005)(16526019)(336012)(40460700003)(40480700001)(47076005)(36756003)(36860700001)(83380400001)(478600001)(6666004)(7636003)(82740400003)(356005)(86362001)(316002)(5660300002)(2906002)(70206006)(70586007)(54906003)(6916009)(7416002)(4326008)(8676002)(15650500001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:26:04.6949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9832897e-3666-44e7-9866-08dc233a1b11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

Add progress notifications ability to user space while flashing modules'
firmware by implementing the interface between the user space and the
kernel.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/ethtool/module.c    | 76 +++++++++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h | 10 ++++++
 2 files changed, 86 insertions(+)
 create mode 100644 net/ethtool/module_fw.h

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ceb575efc290..09cf11564840 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -5,6 +5,7 @@
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
+#include "module_fw.h"
 
 struct module_req_info {
 	struct ethnl_req_info base;
@@ -158,3 +159,78 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
 	.set			= ethnl_set_module,
 	.set_ntf_cmd		= ETHTOOL_MSG_MODULE_NTF,
 };
+
+/* MODULE_FW_FLASH_NTF */
+
+static void
+ethnl_module_fw_flash_ntf(struct net_device *dev,
+			  enum ethtool_module_fw_flash_status status,
+			  const char *status_msg, u64 done, u64 total)
+{
+	struct sk_buff *skb;
+	void *hdr;
+	int ret;
+
+	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	hdr = ethnl_bcastmsg_put(skb, ETHTOOL_MSG_MODULE_FW_FLASH_NTF);
+	if (!hdr)
+		goto err_skb;
+
+	ret = ethnl_fill_reply_header(skb, dev,
+				      ETHTOOL_A_MODULE_FW_FLASH_HEADER);
+	if (ret < 0)
+		goto err_skb;
+
+	if (nla_put_u8(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS, status))
+		goto err_skb;
+
+	if (status_msg &&
+	    nla_put_string(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,
+			   status_msg))
+		goto err_skb;
+
+	if (nla_put_u64_64bit(skb, ETHTOOL_A_MODULE_FW_FLASH_DONE, done,
+			      ETHTOOL_A_MODULE_FW_FLASH_PAD))
+		goto err_skb;
+
+	if (nla_put_u64_64bit(skb, ETHTOOL_A_MODULE_FW_FLASH_TOTAL,
+			      total, ETHTOOL_A_MODULE_FW_FLASH_PAD))
+		goto err_skb;
+
+	genlmsg_end(skb, hdr);
+	ethnl_multicast(skb, dev);
+	return;
+
+err_skb:
+	nlmsg_free(skb);
+}
+
+void ethnl_module_fw_flash_ntf_err(struct net_device *dev,
+				   const char *status_msg)
+{
+	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
+				  status_msg, 0, 0);
+}
+
+void ethnl_module_fw_flash_ntf_start(struct net_device *dev)
+{
+	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED,
+				  NULL, 0, 0);
+}
+
+void ethnl_module_fw_flash_ntf_complete(struct net_device *dev)
+{
+	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED,
+				  NULL, 0, 0);
+}
+
+void ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev, u64 done,
+					   u64 total)
+{
+	ethnl_module_fw_flash_ntf(dev,
+				  ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS,
+				  NULL, done, total);
+}
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
new file mode 100644
index 000000000000..36cb0bc85526
--- /dev/null
+++ b/net/ethtool/module_fw.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <uapi/linux/ethtool.h>
+
+void ethnl_module_fw_flash_ntf_err(struct net_device *dev,
+				   const char *status_msg);
+void ethnl_module_fw_flash_ntf_start(struct net_device *dev);
+void ethnl_module_fw_flash_ntf_complete(struct net_device *dev);
+void ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev, u64 done,
+					   u64 total);
-- 
2.43.0


