Return-Path: <linux-kernel+bounces-145032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDC8A4E84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E851F223C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF76995D;
	Mon, 15 Apr 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VI3lqkgz"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CF69946;
	Mon, 15 Apr 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182901; cv=fail; b=TGUqYxCflaegpKqwnOpPw1/N7vfiM+i8Jv0safVa8gzyGJ7P8bIXvs6d/rwmIIFxqNqroHOQ9YIrYD3eCrJ29c42e4TWGi44O/oqaHBFkJbHfzTuZjv8hDdbNQk+wPNJcgWQ6Im/uAHg4KeYFQAy/wFwd4GoJRi35EEPc8tzw4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182901; c=relaxed/simple;
	bh=OFdknu9ifl1dVUn93KjLhSo9144ESrNZYUFRA3j7NGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgAj63lB1NfynmXvcRBbtsozw82SwYEeJb3T4mGq52uPy928MOFXMiIs8FSl/IEH9nCFIbk1pSV0+JTkviQW7Axyxa93rbSfWjGbqvuwCxk4KT5d7lLOmoQ7UBIvGoEkxlrI1AbHyFA9eqCectE1WH+vSQRNDmvzC+/6XOXOLvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VI3lqkgz; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJZN0CNZ1VcfiDo4CwpXCZ95QEOhkBM8/AqHVloinFuPG1qvao0OWR+3+Lk+U4rBjLFvb073mWMlOK/nd5yB4CaYSlfl/Q/SMsss7ppWnQHRfsWp54AJvYTsKGCv/BXRIwpLUfiKCwhrea994Tbghx0zqJs5XFDH0r+3R86YAFOgtVewAMHK3xU4b4Kt9mqCy0FaSLKtS6trXTWh2FesC9ZmJ7H3nYn+XKGoR2moXU4MNQX0dq6T3dvLRqAYqNooW2gS/EHZltAqiIPgpKIBISmK4QF7kVgLIENiX922+fUom0SVhIkxN2/sieEXDMybOa3FbWd3vioUOsrvqrGNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Kbu2o11318dCt1qo3ckSYzDcjsotrcsFd1iZusCBM=;
 b=USSxgPWSJot3VkHwWs+yi8GTTqM2XA3YUn64J+QbOQ6s2+M5z/hbX+LjZo23ouWhOCpl6079SP7A4UhGyoJbzoY7SQeEeCSAw0Ch56kPmHwNtXe5j6oZdQ+IAwuWOniSjKZ4qFDD3elobKMoyobO41jeYS/XNR9qbWlkqkcSMfqa0XgUxI1axjyxBJaDicDywRtzdDty77a1khMj5SCvIBEEKERyjfs7FYXS05EyrIci5tIByi94AFTr1AF6K3LZ4xbJN258ubsvuAIVOw3d9K69t/4gYiHa2qHsr2WP187fCqrbIBxVajx26qhUTn7N4S9IyJ7mobJptKzhZZOweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Kbu2o11318dCt1qo3ckSYzDcjsotrcsFd1iZusCBM=;
 b=VI3lqkgzO07fODzlSDeDMP1MF/xWPjOfNO0WboWA0B1GiGWkcqa4Yy8tNa4Jlgwa79wQF8EeK//dpLHaK+tBUIRd4fghBF10xt6XxcDkrjT1cCdzmgugCr24/K1rj06tcY9uBsT5t4jcwQj/cOCmKbuoruASSSKPCMu8t8caKHSap9/r4U0gbyYHduEOm9Am5y5NZYjxOrBMyAa38rykAVRFBMFFaUaEAMmEvLczLw+wQJ2BOFU/EudGLbS6L8j+VrIqKVEHx0laNQUo9UbtLE1eQxXDSsoIsct90yyC+AD11isMcw6nz0cGRSNsrDMYNOSliFuJmWxOYPuBKr+49Q==
Received: from MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:08:16 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::78) by MN2PR07CA0019.outlook.office365.com
 (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Mon, 15 Apr 2024 12:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:08:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:08:00 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:07:54 -0700
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
Subject: [PATCH net-next v2 04/10] ethtool: Add flashing transceiver modules' firmware notifications ability
Date: Mon, 15 Apr 2024 15:07:11 +0300
Message-ID: <20240415120717.1251864-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: c84b3563-3a5a-4be3-09d4-08dc5d44baf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yjUAiAz1TEW0HniDMLIRRSptgL0aUc+07GlembrOZw3+0GtMyFbQW1Ztl19T4Pjcg5KDxrRncDzOA3F8iuuSDtK9dCiO7VL/kEcXodYA7OscnmhQj8DUBjdKP+IcX7Ug80A4ofvxJaRumjVK5NqqUhKluVMpVQwlpy/NYn8/F3252e/qD3Uc5SWCdfCzYnZoKUNCp9bDwBIUtbdV4cFDMQdA7kwne7J3YArg/F+TmINCXBJHixdSh85njyH4USj0IgoIoBiyrNOzG1OdETNSkXBao7uPu2ovtEyZmH+An50xYTfl54LIEbHnOyTC1yqifMKOf/fvmAFsvDApSHMwBxcNDQXY8xJPEfKqDqRyVNzmF8prF7xRBVcTiLHrAlQ/153mcd5/JVw5BJ8NIbbhRIrUelEynOy6zFuqrjqiCbu31ptk6PaDajFQhrGHlYB4i7bMRQtPl4LKkobczdLhWbCAsnvbiOiDJmr/WYwxVRmS6G+0bQDAC3bkyw8OqmWH54fJt4Uo/4NG4oclRP8Qz7TliOUsD6c19/jVVC4KXgbpWF66csBA9Tzc+hOWSYMmh89ZxjVhNf/NnI+L4Z3v45Y5ShABgwdOz5d+7bdhplWIfAGFYWQtYY8rmC6rdDvAnVQQfZeav9prnGXcJhM8wu4IiMKPDJ28LSSuC2wrWWepTSa91zcuYG6c7jyk3t8w1kjwkNdrfxdeIilXzQoojUNTsIL8JgVs8z8sg95hl7vwt/WSmc4pIJ2mYKweBKVq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:08:15.3426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84b3563-3a5a-4be3-09d4-08dc5d44baf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211

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


