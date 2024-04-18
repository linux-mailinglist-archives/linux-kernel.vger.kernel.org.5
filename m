Return-Path: <linux-kernel+bounces-149896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB08A9783
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3536A286AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B9015E80C;
	Thu, 18 Apr 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+exhtZa"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0E15E7E7;
	Thu, 18 Apr 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436553; cv=fail; b=HixsfySiIRJiue6g7VLlvwHDGnK51OBBn1YfkCqroQjlf35M1kvScCX4sxeom5LuNKJlVOjf22TWZOAokdrgJsML64Z7S/wT5wrSlmvuVvWqVXezN8lMAw6JtqaIkjGNZlMXMSvdip5dsY6ZqKTNGvcH5alqI4lf+3d7z/ewz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436553; c=relaxed/simple;
	bh=OFdknu9ifl1dVUn93KjLhSo9144ESrNZYUFRA3j7NGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPnIlIxdKFT0RitOxFaOWVFbzZTdVFwVyBoHhJpbYDPV0G2KFwc9OHWx8G0bkWhLXKdpTP3B4dRiyp8oFS/9izpZAOjO5cGZNOrBwVaBjnyime5MTszkZ4JVHNnUxBFjV8gTYQMpTawiyXdx9JOl2sQATjIhFnBth4dXQiHZ+SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+exhtZa; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEJFi/w5X3Ft3PoHVKgpANz1+7nGFbHxAMA+XwSwRUHLRyars0a5BZVzdXPIVmf4VsYtVCosoXolpKkrW0XVe+mjcjMjX8wmPFNYX9uP3TYWVpKLbZQSdG3WtTKrYklorMec5BaVXzCPnIWFLKO8ubof+0cqgPiv44B2gEtgw2zYKwzCK+UIht9rYUqZeyqbjDeb0RJ4XJX36Nr3OZSQ0jpaa1pj3eLDQmgrrGoflrOkMVUYQV+C525XPrEEhtkSd2ZNKKZJHj1wIWw1jmc6tCyg2bs+ntnrFGN2sNOBPydtZj1IRHfLi+jHkTJb/IctQKcQVG0WawYZyfjMgJJkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Kbu2o11318dCt1qo3ckSYzDcjsotrcsFd1iZusCBM=;
 b=diocDhSUxmf4r0v5WKdwmthhWSpxl9sMP60jmMU5Qo1ssHIBWRZPnkKuoQPHNjSxh+qNfnxRxRA4uVB2wwCFAXfPwBqDML8GFfBsJTrEcnsuSbrKBD1Jt8TV2x8Cue06aMQBytM9rQY9dy/vGx9UGWEQxtZYo7seaz4g1AQ85yAJz79ZfArOyPp+HcGewYJOxSyiUczLHFynVGavbRf5Ml+KRPdO9hnZcXCm1sD9u7IK3hu87qiNIKxOc8YFF3FfqS8gFpYZk2o+DBJ9u0J8QArtL/+It4hiwNIyPcxaO7bTmd/+0O0omHrAbnNknD6p94fGJ5i0k0mcUBzx/kvdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Kbu2o11318dCt1qo3ckSYzDcjsotrcsFd1iZusCBM=;
 b=r+exhtZamWrbOjRquar7dwmsHElTk8LdzUSKNEvnWH1UghSdb7YVuOS1ciSOwTy88yYfS/0ECWwOPGPp1Zxr49x2IaeHnSzVP8iSdNIJoGkPz+UY4O0qRkZc5IlUlyqMfYfYQmrfLHfv5WkfjQrvrqKb6YJCoJvbWq3nOUS/xl905iZGlLu6CApil1kX3oBKP60GBHKpa8aqLeV/aglMXum1pjKW1HMZ7xTnYpS6Q0bWBakM7vz6aXKbQEZI5lLkPGEY928hRBiKvU0PYrMeE2BOu8VOrr/gC2gYSap/XQtsQWjhJkilu4AOksKUucpkiHf2oeRbLnozpSILpUyI5g==
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 10:35:48 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::66) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:35:35 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:35:29 -0700
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
Subject: [PATCH net-next v4 04/10] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Thu, 18 Apr 2024 13:34:49 +0300
Message-ID: <20240418103455.3297870-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418103455.3297870-1-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf0fefb-3a0c-4ef7-a16b-08dc5f935010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S2GSTHR5FJ+HOAZVJstScveIHt49+eiXd5oyq991e1zfT67YPaQB9wCgz3Sz2nieYnjxRlkqaV4QULRf4+074zjLaHAftQHSlvJu8GaTV866pWjmzOngp1ugR1oOXeIpL8N5TTd7BIgavdRpkPrPDdcJUMYF3AobBqDeN8Y8MBXQFmp4oe47IKcOoGFqDEWXm9yFJvknta8BnVk82QdhySvKRoT4tXUT3HMeG03PnluQduwsp0Ffcw7QgHTdFTQb8Fc07Ow1dgmtaFWrRWSGQ3pbVWwyI6dmPJY7faA+ikSHGWTi+18jccUTKRZAqKBDb0tDxlYiaSjUsUMwR+8GjdUcxNAjHomYmAp+s0T+mR3q5CeDcNkW2pxT4gjuVTUEec/tClDdkFTsgVJXpLnMg0W67Rok1VRhs0WG3TxLd9qdyQc6N0JKSCfP7MaG4/OPAKDJarWTPPI58xZQZsf7QsbQuXtWvxiQeTJ9jJVHGxNBIpkRXrCvs6TBVkHzO9LlMHyEScI9trozdAJIe4TU6wg+uz1bRpxfLH0qZST+fRzghyyiwANQ6F6aXNpvcMFPWlVqQJ30PQVtPCNehD4iVRNVzXYy2gf0MTYOn7aWc1PuzCe9VxkxLq4+ScPSSzm18iVOOfemUiFAFPPWfiCuZRdbTRM0d9dg2OuQlmzVsfTDjFmBOOCZa1BtgkOhhKFrMDC0jEsei3BoCSwBHVXGvyXU3tgI2avj2io2c5miGiWV4976ZtaD1Xffx+cty5Ul
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:48.6303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf0fefb-3a0c-4ef7-a16b-08dc5f935010
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

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
index ceb575efc290..1c659bd85160 100644
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


