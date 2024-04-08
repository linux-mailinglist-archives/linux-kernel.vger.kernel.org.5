Return-Path: <linux-kernel+bounces-135367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBAB89BF92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BE71C21404
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2B7D09D;
	Mon,  8 Apr 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePF6y6Pg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED97C6EB;
	Mon,  8 Apr 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580889; cv=fail; b=GiiaGKS4oYYkQXAHsU5EqJUoVodSgFvREv24KklaayaXlp2JkaCQeklU7jOXzcBpohgVdOtKogIIpRaoTP1YO9ucQ3UphPc/5yYRJJV7o1FBRaQdvMYZO4qSPyPpOc4dW8pqBWnmP3/ZCPAAr/AQUJMumCjLScBSE+7ZXk9Lbxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580889; c=relaxed/simple;
	bh=Fxd2CSjySZuEivCLcWPz+sHq2iXkTmlTekwx8soZ//Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKigpqau+Ec8heP4rJ2r01vQjpOURyufpp7C4FzC60ekzMAVbk4WehkM5wb6RN8kZTMeDhnqpPXCggCD3Le3nuZUpjXkA+RL4JY+S29NgC7/5DgfrZHWLr7z99wGdhWjiwE3QOS95ZQp0pH0tFw344oNSGrrzELNmyowfnuHbQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ePF6y6Pg; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VReM6L45rXK7Gd3WojXn6iwvuV/0HRINBF8otr8SdYp+9SZi6Xaq2uNL73vjdL+dosVv+DSTwgE8+jn9bFE7gN9ne6V04coI0wKctVBO+bTJ8uBR9E5Y8EeC/c6Uh0ef4F+WXIII0DoHA6vpSffXI+zsB97puEf7CMWx+a+iM8651sHvf2p3D6K589vUAQSboa+oVQK31SJVRd261xuax7aL6sqDxtq916M/FoSM4dhNOErHn8J0GviTTqNSekbx4iAgc63T+4pjShYgGL1/IAXZ7Q5dPzVOarDRIHX2Cg0UQzFdlDBWiBu2+K8l8wwQOYWNpjPnhx3R62xsUgDamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC3BIYcjNHn6m0CA4k+V5t83ADwsoVITyCNVCia+Szk=;
 b=lb32zTTJn/KgJ3y33sVpx5oKOqlWYBPA4rYMCnzeSSqeLxqQ0mT7oh4uCWQj6MbUShZ49U3WFZbUPlAl0ulfY/q6Re6g7E4VYqvcwDQhkUbtHJTGtR/y3ziQMKTTGtbY7lyR3A/l335rIpUw5JQnSzhLKQEtuE/0coms6OuajHwbw0nP/4BT/SAdkO+vFhqfFlUw5kXW+a/n/ZWPXD7Y3Z9malKiFJB/yrF5PT0WwwqQ+EPhEC5GZ0lR3JUS+W/tCr2BqZ4QPyRaf8SWRfUyjg8Onl/XiCKMi3wgiLyC0vc/R/zCsDfChthq+zvoJ/tU8pLaQbB7P/5WqysSOcIzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC3BIYcjNHn6m0CA4k+V5t83ADwsoVITyCNVCia+Szk=;
 b=ePF6y6Pgcl+ovOFS4jsks5tcgHs8CV9i8ZG7dyIqAPjdUN6AUlRXh1sGzAeHVfb6/5R10jQPUwUk857iYnIUc8aiq4NvL/tnjd7PalfxtpZEbXCTjJ2xL6fmD/aTOnD4eKJLa1+Irf6HU06Y96N4EnHsSQkXkJAGYM3X7fNSxgJKQQnMGTUx+X9/ZVzFtIsN1Q1oN/l3VJLQ7J6M0CTJSlB2uVTRK3+0YAM2z1npqavDZwSd8eK49oJrpB8SMp4G5tckS3uhvBfZgHHAIbRZGXhkLl9vW5P8NTERjb/OdTMFWTptP/Vh3ym9dwAK0yqhd0ieqmTBeGUsqon8iB4CuA==
Received: from PH8PR20CA0009.namprd20.prod.outlook.com (2603:10b6:510:23c::23)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:54:40 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::4b) by PH8PR20CA0009.outlook.office365.com
 (2603:10b6:510:23c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Mon, 8 Apr 2024 12:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:54:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:26 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:20 -0700
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
Subject: [PATCH net-next 04/10] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Mon, 8 Apr 2024 15:53:34 +0300
Message-ID: <20240408125340.2084269-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a164566-0f36-4086-22c1-08dc57cb0dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pAA6jMqt8Jov7YZXp9qH1xMWk4JdJDXud0LnwPk++Chf5RJWR9Y5jYNsRa5lmigYUyqH9X/MFv58a0P+m/GvhBCYH/aCpzZ7SVF3zgOJEtNKqok/eJYffIksMM40TPtHbviCDr0QI4UzUVZYMHrNCQMJ3w1o+y+/WALO6t4zjLEvB8GR+Ux+663shOvN7UeaD/DV1nH8NveCuh9siEqql99LXq4MX8ABJF24Vm0aOrEI7u92TCAmDG4nH8ctRbMUHrgLj/NjmZbi9VJtCEHjnNCuQ0RTX5Z+zXoPTrLcbJVlMRyNcO2BQ3ebQNxAfCDcPj2OuXxGRcuHWsf68rXVensT8vCinqcoKs2StFK+nVB0ZjIBJ8VLxI/VSqdjs5CNNEXWT1Af0VQRlJeSG4ckJ2bFfX4qcI4JtdV79hZjd3VojMRuwSD8YTsIuLdN/4OUiqOkPzFdj8D0Kpx52Ax0aBJvOuEIt2vIozHGP7uEKz3jkp0cLO8Q5wddaTJYZKYj2a/LVYMvRRP1KnCcW2X/LwhozOpe9B7g7r5nDUs2Sh80jagNaIMMFdCVb8W/cWk2ZiCNkNly3Tcp06VgYFbHIwQoqdOQ6FUX8DhRXsxJaVs7tmClaH3ETQfTErsSohHAaT5OUs1VMwD0oC72zNNxEax6TGkHX3+xTgCcnjG06cXZGSFnhVeO89GaYX2YyPyhUXuFkgvmygmkcxT56y7NvodUgKNPMeoUoV2Ie98ybyvqiNffQ2BgqqcRHTpd1mKX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:39.9009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a164566-0f36-4086-22c1-08dc57cb0dc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

Add progress notifications ability to user space while flashing modules'
firmware by implementing the interface between the user space and the
kernel.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/ethtool/module.c    | 83 +++++++++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h | 10 +++++
 2 files changed, 93 insertions(+)
 create mode 100644 net/ethtool/module_fw.h

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ceb575efc290..34e2f75c9e2d 100644
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
+	char status_msg[100];
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


