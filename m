Return-Path: <linux-kernel+bounces-32550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2158C835D00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF3B1C23A18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B539FF5;
	Mon, 22 Jan 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3jFBZaF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EC37168;
	Mon, 22 Jan 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913191; cv=fail; b=DVgwOmWmi/2i/Ui7a0L+6r1/3HFyw7OwvCV9LbwIdhss14vk6wtKj6HWEEUA2aZuQZBC/bjFewG9f8FMNPoCFwTm5oabRPS11MwTgAS1pPxzx08hB0vk2Mv5ygtIAm2SE9V1fpdL0PHvdSTEMpma/vr66F50Y9UoI/mMj45a9VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913191; c=relaxed/simple;
	bh=EAkfmtUOBzV0QVAoEUuRt2lt623wUvAoV+i80jPNMCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNYuuA8UHWtgQXi621Nlt69/XwGgEHyXxFsiqxCs7gXuQa9E3xGPnU9LA47wP61EH0BAQn7DPaZhYyKsJDMOEgeGZTL6tC2IvCUBViTWikZgzPH1PalaQrv5Y5ssh8FafFWB2P4/ya31VZ303M9RSc/ydzhELeLjPScMyzzVHHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3jFBZaF; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcAHIMjr2YUU1n3J+aFEoAIHJ3eThfnD0DFS78pSC9yl1jQPFpG6f8lgdRYl6ecbfg1BF4f6OaoWvgxxiReuG/hWi8FSgdyIOrPeiXIiT1HGkvgyh0La5G8mIQeRagYC4AuxdVriXPqsZuBj/p5JNEr1LG6QkKh3is1/Z5rmeRa95MZBJwRG68L8mQ/UgrzkHhYVKVxnd1e0yIQ2t/JPCm9dJM1nfikNeGYRYvJwnUtv1u2TSNuGsrP2DhxrnuFEeXEuue2SLgJMolkcMOk6nwpckeX+uqVHoZm06Y5HRkQP0l8PXcFDKhmbGMdCvXzk0et6kYSFeb9M1hqCl+IhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNFL1/pk7STUDTmFiWqOmm0U+rpuF31f/Gt61/+3l00=;
 b=GEXG8QNHs3zhm8mU5y/T7DmWb8yyVndytluV2d+z5yEWmvOu55V6z0AiwUU4yI/sg4ywvXYnEOJjgT6c2BTBEWAJdlpoumQ0ahqcFSZQm2VqRgRBcieT3jmVkPUT1UAL0/bYvRDXxLNwTdy4vz2dHhnpGt/wSYBp5EB9eoK0exNKjsxxsTeEANKch4IajfARnN9XXP63DIBiDZ8RztRC+ajlW5Z+lgOZ4YsUHtNf0YCySlG1i499/noU5v/lVAZ4cxR4SilZTBp2wM53IRCH1EHRvFl2/BPp7guLlCBc2CToan0lNCfnJzNs+SeV15mMqOlbGp0XSG1FzgO2EjIJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNFL1/pk7STUDTmFiWqOmm0U+rpuF31f/Gt61/+3l00=;
 b=c3jFBZaFiuBGFKfbsTlDMm/ZvwvJCHz8miWepl3JRfMZqErCAekkwfqBjOk0Ks3Ji0VDy0ouxH886VHw5KSKv+UFMuVKNJbmXccU2cbVQn2tNj4uQolCD2wF5H0k6KppTR1MIWuxKs7VwGDtd+IYYPjOXi05pLuDbx1ur6+iufqgr+Wcr4hJiNXDl/thjvNMRxj0Nk+ORr3tOuGRQ0MUvN37JNfmVuTY6CMm/ESUb1Ds/XLt2n7O+KlOfjqq8Y8cMthVywoI0Bd4WquyDY4Tlkn/F7CTzEm6yQYIDFynLY00SSF+2Kni2/+fZVKPf9zhtm3ckvsVa9wdm+F5AVmwrQ==
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 08:46:27 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::5b) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:46:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:46:12 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:46:06 -0800
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
Subject: [RFC PATCH net-next 4/9] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Mon, 22 Jan 2024 10:45:25 +0200
Message-ID: <20240122084530.32451-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: e43b5906-ff02-474e-e023-08dc1b269f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vtsmDP7a3Ioe4shdZ0rJqK3Xkl0pLI86bMyYk/p7i4YgV2hfKaOZWRObND0/Jrp//OJkT5txO5RO3GhSFSqXQwtrXPaYICHTc74wnZVn9zyoPOzEB71/ai7Q6RuNONJPushCdFee+sOVlCHDWzdqZKZuA2Mk2qowfYA78kn3vMhbf5tpapXA9YNjT70djIz5zFEXFwWvmhWZxtYPfkdl6hHal6aoJ5gYcWivDTla1VOCBuIQw9x92n3GJ3gv+Hf2V1CD9zo8378lQHwNcz+4M8H9d8BKC75Yb3dBKXNLmOPWQLtECiyV2E0sXEWQSeOKOSlq9h0WAATkr9dqrQ4iSc0ZQgCOQVtl4oQsCNKwmVBBnIPDbNqX0gKCq72Dy3X2s0dFMgPHUxLfGteFNuMtVpBlG+hiI7CsbqlxnRN83CEIUAomjKZ9dqBCmSIGRQHVP3X6vYLQFjX93Y9IXnIDS0oVHzbxxc3i5vCiXMuwKlLxyNQOl4LE8EewVVdxddaoXUYzxAM1u5HgFox3bsXpEVgVCgYNEWr6VQjDcu5FrMQrCPtpKa0PJ8v9WklY7d9i2iQWNo6wOJ1k0DEsmHnC+nopKcwbtRTBhM6Qy11FNxBP/8YVQ9g6tbx7bHJu6cqvE3wgxM9FOFZbvgQ5zEgohGUzV/9Djch742FBP4oA+gN7RzAv1cu8CzOOGK5S2TyFvqSoG8r+wxy3VfwGDeOS65TqQQ/ws9/DphiviW8xATOo+mCwmCxmJHmEo+bmO9eB
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(426003)(15650500001)(5660300002)(16526019)(54906003)(70206006)(7416002)(70586007)(2906002)(26005)(6916009)(478600001)(316002)(6666004)(4326008)(8676002)(8936002)(2616005)(1076003)(107886003)(36860700001)(336012)(82740400003)(356005)(7636003)(83380400001)(47076005)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:26.9530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43b5906-ff02-474e-e023-08dc1b269f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826

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
2.40.1


