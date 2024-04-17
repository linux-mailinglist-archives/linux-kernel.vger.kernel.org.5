Return-Path: <linux-kernel+bounces-148182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6588A7ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1C21F22B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F013AA42;
	Wed, 17 Apr 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVXmEzs9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD113A3EF;
	Wed, 17 Apr 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344088; cv=fail; b=cMAtMuy4ddQnxECOwMckxRen7bsZheCgRByWqT0v08ctX9SIChBYqZGYOymUOUbHtJu+LU6vvSBcw1NIESSS+fz0IKv5WdqkC4J6w2gRi4OiXaRAPaGOd2cpX85rdbLBVEQ/hZfFV8atvH9Zs96/DYcjoXgGLudSsWgtXTT8lcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344088; c=relaxed/simple;
	bh=OFdknu9ifl1dVUn93KjLhSo9144ESrNZYUFRA3j7NGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoznE7+ZV5PyD8iYR/Iz0ikIlalY+TzoxR3NsRnfxv7z46Ijt1aYula8VJtoxATX+UufFnPi/oOjrRHYLvW5To1UAFmlrf94lUQCW9RCsQ0Cqm90Zz28Kt8e+aubhytqaBQ5kDB9hfbo5eDUAewyxlTDb6IpSjrsz5cC4qLnWGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVXmEzs9; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiW6sDuo1TDA74vwjSNN7sGiYQIi/kR4cqhX0vq7HCAr5/LDIH1aiwtNQw0vzQHmWip1K8ozpfmMPiPI8ipT9x009ulETXzITNnVmXUaBjRmaP2OTuWvlKiOosOHckzua5pPLApTjDT0l7k1xJG+qf0juwLGPFW6h+EHpCMaBmKelWPNMpeJeENrXHxdZMttxxvojSzDAqVF4QpkLVy0QUBqhk5pIIzsZc8+rJ8TJRZTrro5Zilr3JZA6sPeSTRwq8SQLUQzS2FF+E22rj9dndKYZcWq/PoKFsm0/p0dSpNDUvsrGZuN8CKYxzn5ZZ7SSoN6BpUvwSIj+7aa0S9bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Kbu2o11318dCt1qo3ckSYzDcjsotrcsFd1iZusCBM=;
 b=QaLieoz21Rp9odGzegt6qfzYU1+/kw8dDp9NPy7iBq7W6kG/6HyBs6vZ3rf9IJ0VabzetfC/LqdnG7Bk21Nm+IcZGsSEHFt+2TUNFP0e5TZqzOt//lVqy+NTqx4l6+otSj6gIYwwqnWq1VXFVTUuBwN+8ShGB28lQETitC5VAX5jZFUjwbE2yhpAI43BypDUChyxn62yU5IKXGWTNgWvcCeOVz0TCoKFZkfsCuwXe66T2zvwwfKNZd9EIqFAnqd7j0l3OqxlwThYJVM9Q/pyR81cll6sz1PCocJG/XwP6axl86VtZXGCU4ReW/eCyOQRbjhoPeWGNDyjiVE3f2y2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Kbu2o11318dCt1qo3ckSYzDcjsotrcsFd1iZusCBM=;
 b=pVXmEzs9KNJy4DtAwpufdYfOmKBRD/HFiAHSoSAnirnqZ4oARa7lTZN5QR8azozJZ6N0Ap1dzygsXfUjuJrToaKrJZU7CGumLny7u750TmU2+4w4pCUjWj2vClaye9DcPvVn445EDZ6RvRrOuVBHkP4v8ZEz82Zl02RSo16pyRyNsnMXo1dobQ10CrKAxpCzfQZnDwfnNlpmBGVGr/QpZVFRKn4YLju8xNb+WYwdYyoD5ZXFxJ2a1va6RFG9Z/z9T5/D2wXOD0MEUfqp8q8Bl6fa5g6ih2tUkvE0aRFDWKBxZETf+Kr46UBhR3yYtaSGyy3XxXTHSNbpO/jlW25spw==
Received: from CH5P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::17)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Wed, 17 Apr 2024 08:54:44 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3d) by CH5P223CA0005.outlook.office365.com
 (2603:10b6:610:1f3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Wed, 17 Apr 2024 08:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:54:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:54:31 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:54:25 -0700
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
Subject: [PATCH net-next v3 04/10] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Wed, 17 Apr 2024 11:53:41 +0300
Message-ID: <20240417085347.2836385-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417085347.2836385-1-danieller@nvidia.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c5b927-946c-423d-a04a-08dc5ebc0726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kdHpUfUSGwKiBgBEAB77okEc9FGhHqrdjcQZfyPltGCtDsTJrtjkasbomKwvh0ARjUYgzFsxmBhTodPOjtuFcuEyD/1F7UyD3vSZw6UbmrACs0ZlTF3hajlkInyEkDyrsm9HQSrUmXAepTSNoV5I/UlokfTNrkVwOOi8PFYNGTCeNxa/ZboJ4ggNBa5272587gNn1T+U3toVImPrU2JKKCI6K9ml9anhKNqDa79VDJYTbbAEsDLw2aqFmq8AR5iMoyO51llJh+77PULPNF8oKOMiNBY8T5x2T2D1KwbORyQfi4T5zyKJjbC1ts1TI1qMztEibxROdQHPR8918xrq/u4IDXOKeZaUlCa6w0ZH8frfqvNNqjxcuprPljzQzrbpMLlXfTt2kqUbIAHSum9GnF09o6Ngzz2tn8wTvOKjEzpdPA0apriQHcqO+JygMZKFc1gm4qc9fj6wK13aYmSxLb59ne2pxpt5MeVqRAWOq6tqB/rnlyaZjx6qx2kUZDc/htfJb2a2+NFYPiSI2l+XXi1icQsxUZ6NvV6P648KR9luERo6P8wCt0BgMPIzslgCpvy6cdkV/aLN4uqa0vTmclajhzBGEyOV7QcwCpdTg5D8Ugi7Hhw8k6D41teaNLUonHPRAV8XDJX9zKkA82aEXckEryIZAyh2z5SsdRnjc6BpJjRO2IwJMu9Oqk4avV1GFDFJxZU3vQwNeNF+wpSGenVh9zM3eFeMBiOx2Ze6kZ9II6GZ+j2wthNdvDAt6YB3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:54:44.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c5b927-946c-423d-a04a-08dc5ebc0726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

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


