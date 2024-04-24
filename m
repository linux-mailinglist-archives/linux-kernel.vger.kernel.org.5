Return-Path: <linux-kernel+bounces-156963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E017D8B0AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967C0288B13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659C15ECD0;
	Wed, 24 Apr 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nclORwzs"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391C15E801;
	Wed, 24 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965496; cv=fail; b=du6keWDnrmVqxbXVu/aBbqec6iG53kr7+EXtnaAohWEqsfYVG/XE0FwPjgcgt+rXYCI/rJg0rCO8P+FOINl9LTDqeeqsaf0X8z1O7MF5PUbwPb5x6ltIxHyS1+nJaXUnhXPKZFTHszc6jeVxKg2cPperBG1JmlOOR4QglfV88N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965496; c=relaxed/simple;
	bh=gmE//rE0DvfKXOWMWGKrOIVByOPcGPICFE7lFZa1rXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mcv23kLYP+jvrhD1wxs+9vYCCP828VQUWTveVJfTVyywxpPGeaLqQar7UhauYzw32HYtKSPhnwm4787K4RrXRKaiU1qWGH0cwm1X7M4Wyo6lB5cl56pdt0zSfrj6zKsTJWX+4Rve5SpehXzzyOMmrokorCS6+RNEQG5/Rjnh2SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nclORwzs; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an2tsRYXgen4JI8XMtFV2ZbM5Q04QslgbcJQRAhL4W2GhRmSwooJj5jNhyfUM5T42vtt3sjy21W1gvMHfmf27l8HBnh3uFwKq/nQ9WICFfBYZg4sy3jm/bwl56SSEMOiRt8Ibt1I1XmA4Em6tuQyktyp6R/1oBjOAJF8xnJSiOdm714nt/Bxa2olSHJ+ofdOxfEE4KwXUkvigqP2pW0KQbRdoFJ8n1GuR+c+tZ+rHNPwOLK0XQDgFgMtDvtsFgM/ImeGk+1mjnjyORhXJ9XEyyAPJMZOk41lDucBYb3UdCvsQXNYtoN1S81YDspQEXIfOxMfCCgnXvc8YK9U6jNy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/WxbKCLTwjrYRDa50HYPIDMYDUUEuvWIRZxm67SpHo=;
 b=kffq2IT0cs3qYV1gHc3VijRrramMznaILPtYCOCm65iykn5wCLGUYeampIv7AU5YznWBpdpQLBm/Ih2Z9qJolzM1BJo2xudXC040OAYS5QcXCZFf3/ZCA1zdsx60T4BrP1sqpKy7PbH5cmFkeJjm6JMTUurbDhNqP8GSAgIBvp8qeP7ZHjG7Huivjc/9bdSgyElvoriSBfflzLP6HJ2eXTwiq3Aq46IUFEpbWNfS+tqMI2kugjhgQd2HH86U2NIkOTOuqp0g/z/VD12L8S1Rp70AT5FTEiYP/HkJsrNTzcEkoCA6bvfX0rDtlUCF0XxyUIu7oN7/AYJRIRVdoweSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/WxbKCLTwjrYRDa50HYPIDMYDUUEuvWIRZxm67SpHo=;
 b=nclORwzsFbFsbCDeYBlKMK34veQL9MrPLHaZ2cQyhV5D66S9+txWpepyXnz+0wxcb5gD32lOF4X9jqfPlCQYDKcAtFxXnP3D8Y48uJgAQbIhOSMeKxiqqDLXbhadVxDA53kwPMyrEukIrLxxKrL+IljbpjQYlaT/dwuqa9O0YyPlJIJbxBkqANY+BY2Ng7Lh31dmQfKXQ9spAUwucw7kAnbqpSah7SIEDsgciJoVbQ0U+mLxd7dNnGhh38widYvuywqjuo2JGYfmMzy3JQC0Dxs56Fr5sssas41hzEAjjT1ab0pae9hDp3evuC6StpOFa2/ctes+ppAbbdDDx4Vpow==
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 13:31:31 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::8) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:31:04 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:30:59 -0700
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
Subject: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Wed, 24 Apr 2024 16:30:17 +0300
Message-ID: <20240424133023.4150624-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab44324-2cf2-4eb7-a5b2-08dc6462da14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rg3Zd4ffrBgWQmzzoza0agLDpewFZUgCyM2Xzsmai/atP8d7q9dUNHRqgxVt?=
 =?us-ascii?Q?e7Tqo/5XTuedLJ9a7hqTq7gCkUVjXyW5pap7XmcmLpcfwG9C1O8XDzOa6WCP?=
 =?us-ascii?Q?wyG/qH+i5y7FJXJvPl0/ns4JdFkJlH8c8Vf0H5pxouvmQ9jRNCEhkMbKAb+g?=
 =?us-ascii?Q?JO4rC5LGLvsJcc6tKMI5hySHz9lJOgOEgipQWxrQ1AXMe0KNTIjlaYFowew5?=
 =?us-ascii?Q?OKcO1zLkmeCkQr/xU7pSLpcVbVyM9nOLIdCFfa1WV26arfenwteXD6blgcIf?=
 =?us-ascii?Q?MZnvWAHuVf6OdpdqivI1vjW3tuTuWrRiwiBEWKRTwSn7cjrpFpQ+iT7FAc3O?=
 =?us-ascii?Q?2pjz5p3Ouuw3CJ84a9knUIDokauruVyEctuufxTPpxbpPY7064Ce2nXRwqrV?=
 =?us-ascii?Q?30227746GT4XLxqbQoj/0Z3+Ahwprd1Egx9ht+T04xVkhtQ8D2+h9/1LU5LI?=
 =?us-ascii?Q?HPEwxUX/Dr6ImFpUUAQ7/STtBICO/VVgZhqYOGlQKEhHj7oYBaWdBqijeGVu?=
 =?us-ascii?Q?OdgSAp0pcofpDq14a8OVugCrhGPPSGJeUE/iVO3j74LxE8OIOJwdBfzjt2PY?=
 =?us-ascii?Q?H433cqGmHFmiPlCiepOjbTC9h0ZnBB8cQnJsluBeMgQBwSumFX4V0CtXhy1N?=
 =?us-ascii?Q?ZJB1PBSeFv0BCO6A/8XlEc35azGMrwrae836kVcaz1NlNlf5lJgQh9pV0P4K?=
 =?us-ascii?Q?whI2fopmnk87QJuRjGz/ZbACRDu3EEjTmNodZqkMiYHOjdCCwsp3xk9q0ScF?=
 =?us-ascii?Q?FiXONTaQL2NX6Wf9ouFK8YtkfyzqRYzZZiMP5GAjvz1av9je5GOoFETCOqaa?=
 =?us-ascii?Q?dE8gRLnvvunbwNlKBiBP6h48XgjJwJdnuiN6mPk9sJtG/vj+zGyJD++wMOQY?=
 =?us-ascii?Q?ZtwFH1QFFXHlRP9MzEyE+XWNvA3PcS33NPgz7WQ0uKj5/NGh+ByUM0HPZdrx?=
 =?us-ascii?Q?bjrgP5sVqP5KXdNvaPqopZUzv/TnTkdbyfJ9nfACOJ3ktdTiksKWRGEPd9yH?=
 =?us-ascii?Q?XIZ/sYANVJhfYQsaPU3aOw9laCGLBdtEn+GVnPDjYbRUeDSKmFbMrCSVwecl?=
 =?us-ascii?Q?alD3zQHb+HUeaWuUIFKkba0DVYemwzSLcDmJ1O4daX0Fj2N71ELpHtRboVqN?=
 =?us-ascii?Q?7NaID94h7T1Ft10g4m0UILIUh5XtkhqdjzGSjNuIZCJpDUmVQ8g2eHPGO7HG?=
 =?us-ascii?Q?3Q2oBO00Tg0qEuHnWE9xnWK4IU1hgqOPDwxrdShIm2/28u2N+iBpj+j+CKOW?=
 =?us-ascii?Q?YKhcLrAa7LgG+8Imc4DzWymd5nErZAfu+b9tJOaQRb/NOhn5BJkWcDtYzFF1?=
 =?us-ascii?Q?yaaIX2mkea8Gk4u5vWl6/25cKXWgkpFw+cHa9v2roagt2QUj4O0PBtPBIotd?=
 =?us-ascii?Q?vzfAexihDY67l07O0S84VmionCWf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:30.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab44324-2cf2-4eb7-a5b2-08dc6462da14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

Add progress notifications ability to user space while flashing modules'
firmware by implementing the interface between the user space and the
kernel.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Increase err_msg length.

 net/ethtool/module.c    | 83 +++++++++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h | 10 +++++
 2 files changed, 93 insertions(+)
 create mode 100644 net/ethtool/module_fw.h

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ceb575efc290..114a2ec986fe 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -5,6 +5,7 @@
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
+#include "module_fw.h"
 
 struct module_req_info {
 	struct ethnl_req_info base;
@@ -158,3 +159,85 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
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
+	if (nla_put_u32(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS, status))
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
+	if (nla_put_u64_64bit(skb, ETHTOOL_A_MODULE_FW_FLASH_TOTAL, total,
+			      ETHTOOL_A_MODULE_FW_FLASH_PAD))
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
+				   char *err_msg, char *sub_err_msg)
+{
+	char status_msg[120];
+
+	if (sub_err_msg)
+		sprintf(status_msg, "%s, %s.", err_msg, sub_err_msg);
+	else
+		sprintf(status_msg, "%s.", err_msg);
+
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
index 000000000000..e40eae442741
--- /dev/null
+++ b/net/ethtool/module_fw.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <uapi/linux/ethtool.h>
+
+void ethnl_module_fw_flash_ntf_err(struct net_device *dev,
+				   char *err_msg, char *sub_err_msg);
+void ethnl_module_fw_flash_ntf_start(struct net_device *dev);
+void ethnl_module_fw_flash_ntf_complete(struct net_device *dev);
+void ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev, u64 done,
+					   u64 total);
-- 
2.43.0


