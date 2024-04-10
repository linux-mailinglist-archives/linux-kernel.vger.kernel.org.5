Return-Path: <linux-kernel+bounces-138550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD289F33E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10741C273D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1815EFA4;
	Wed, 10 Apr 2024 12:59:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83D15ECD2;
	Wed, 10 Apr 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753942; cv=none; b=T2Qxi+KpGpi9dxaNZxewH5WEBJ+AR7gvnABmSYjr0zBZpaXgM0v0VHGtW1anEr3iw3XU0FiZjlQOGYs9mMwmwEhG6iNEaGLaLMta5OYf8FiuFnYekYllHNHM3m/gPRQQwTwD2KK0C08M+gSlxmNBFYAWG2OVORyq/NE6vxlWyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753942; c=relaxed/simple;
	bh=jv/pgS1SJO38B/Xr7ZsJWndgzVy/EbjDklNQIfLO0pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzBb+tE+TBXPieCkF74kE7q3HrwiSYSaRUOQgWnID0OuIlJTXT2VVteRnug55tINqXQDrHLAvSufGnWz5dG55b3HULxa2b0wjGn+G4xXGC3bhnZDXpDPDfSejYm8YZA+0g3f4AX3PvpEcpm4aSgTiuZhP4mrObcYI55r2bu9BSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VF2tV0lMVzShMC;
	Wed, 10 Apr 2024 20:57:54 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AEAE18005D;
	Wed, 10 Apr 2024 20:58:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 20:58:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<rkannoth@marvell.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V7 net-next 4/4] net: hns3: add support to query scc version by devlink info
Date: Wed, 10 Apr 2024 20:53:54 +0800
Message-ID: <20240410125354.2177067-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240410125354.2177067-1-shaojijie@huawei.com>
References: <20240410125354.2177067-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Hao Chen <chenhao418@huawei.com>

Add support to query scc version by devlink info for device V3.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 Documentation/networking/devlink/hns3.rst     |  3 ++
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  9 ++++
 .../hns3/hns3_common/hclge_comm_cmd.h         |  8 ++++
 .../hisilicon/hns3/hns3pf/hclge_devlink.c     | 44 +++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_devlink.h     |  2 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 18 ++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
 7 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
index 4562a6e4782f..e19dea8ef924 100644
--- a/Documentation/networking/devlink/hns3.rst
+++ b/Documentation/networking/devlink/hns3.rst
@@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
    * - ``fw``
      - running
      - Used to represent the firmware version.
+   * - ``fw.scc``
+     - running
+     - Used to represent the soft congestion control firmware version.
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index e9266c65b331..7c2c8bea4c06 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -366,6 +366,15 @@ struct hnae3_vector_info {
 #define HNAE3_FW_VERSION_BYTE0_SHIFT	0
 #define HNAE3_FW_VERSION_BYTE0_MASK	GENMASK(7, 0)
 
+#define HNAE3_SCC_VERSION_BYTE3_SHIFT	24
+#define HNAE3_SCC_VERSION_BYTE3_MASK	GENMASK(31, 24)
+#define HNAE3_SCC_VERSION_BYTE2_SHIFT	16
+#define HNAE3_SCC_VERSION_BYTE2_MASK	GENMASK(23, 16)
+#define HNAE3_SCC_VERSION_BYTE1_SHIFT	8
+#define HNAE3_SCC_VERSION_BYTE1_MASK	GENMASK(15, 8)
+#define HNAE3_SCC_VERSION_BYTE0_SHIFT	0
+#define HNAE3_SCC_VERSION_BYTE0_MASK	GENMASK(7, 0)
+
 struct hnae3_ring_chain_node {
 	struct hnae3_ring_chain_node *next;
 	u32 tqp_index;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index a2bc5a9adaa3..2c2a2f1e0d7a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -247,6 +247,9 @@ enum hclge_opcode_type {
 	HCLGE_OPC_QCN_AJUST_INIT	= 0x1A07,
 	HCLGE_OPC_QCN_DFX_CNT_STATUS    = 0x1A08,
 
+	/* SCC commands */
+	HCLGE_OPC_QUERY_SCC_VER		= 0x1A84,
+
 	/* Mailbox command */
 	HCLGEVF_OPC_MBX_PF_TO_VF	= 0x2000,
 	HCLGEVF_OPC_MBX_VF_TO_PF	= 0x2001,
@@ -394,6 +397,11 @@ struct hclge_comm_query_version_cmd {
 	__le32 caps[HCLGE_COMM_QUERY_CAP_LENGTH]; /* capabilities of device */
 };
 
+struct hclge_comm_query_scc_cmd {
+	__le32 scc_version;
+	u8 rsv[20];
+};
+
 #define HCLGE_DESC_DATA_LEN		6
 struct hclge_desc {
 	__le16 opcode;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
index 9a939c0b217f..a1571c108678 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
@@ -5,6 +5,34 @@
 
 #include "hclge_devlink.h"
 
+static int hclge_devlink_scc_info_get(struct devlink *devlink,
+				      struct devlink_info_req *req)
+{
+	struct hclge_devlink_priv *priv = devlink_priv(devlink);
+	char scc_version[HCLGE_DEVLINK_FW_SCC_LEN];
+	struct hclge_dev *hdev = priv->hdev;
+	u32 scc_version_tmp;
+	int ret;
+
+	ret = hclge_query_scc_version(hdev, &scc_version_tmp);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"failed to get scc version, ret = %d\n", ret);
+		return ret;
+	}
+
+	snprintf(scc_version, sizeof(scc_version), "%lu.%lu.%lu.%lu",
+		 hnae3_get_field(scc_version_tmp, HNAE3_SCC_VERSION_BYTE3_MASK,
+				 HNAE3_FW_VERSION_BYTE3_SHIFT),
+		 hnae3_get_field(scc_version_tmp, HNAE3_SCC_VERSION_BYTE2_MASK,
+				 HNAE3_FW_VERSION_BYTE2_SHIFT),
+		 hnae3_get_field(scc_version_tmp, HNAE3_SCC_VERSION_BYTE1_MASK,
+				 HNAE3_FW_VERSION_BYTE1_SHIFT),
+		 hnae3_get_field(scc_version_tmp, HNAE3_SCC_VERSION_BYTE0_MASK,
+				 HNAE3_FW_VERSION_BYTE0_SHIFT));
+	return devlink_info_version_running_put(req, "fw.scc", scc_version);
+}
+
 static int hclge_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -13,6 +41,7 @@ static int hclge_devlink_info_get(struct devlink *devlink,
 	struct hclge_devlink_priv *priv = devlink_priv(devlink);
 	char version_str[HCLGE_DEVLINK_FW_STRING_LEN];
 	struct hclge_dev *hdev = priv->hdev;
+	int ret;
 
 	snprintf(version_str, sizeof(version_str), "%lu.%lu.%lu.%lu",
 		 hnae3_get_field(hdev->fw_version, HNAE3_FW_VERSION_BYTE3_MASK,
@@ -24,9 +53,18 @@ static int hclge_devlink_info_get(struct devlink *devlink,
 		 hnae3_get_field(hdev->fw_version, HNAE3_FW_VERSION_BYTE0_MASK,
 				 HNAE3_FW_VERSION_BYTE0_SHIFT));
 
-	return devlink_info_version_running_put(req,
-						DEVLINK_INFO_VERSION_GENERIC_FW,
-						version_str);
+	ret = devlink_info_version_running_put(req,
+					       DEVLINK_INFO_VERSION_GENERIC_FW,
+					       version_str);
+	if (ret) {
+		dev_err(&hdev->pdev->dev, "failed to set running version of fw\n");
+		return ret;
+	}
+
+	if (hdev->pdev->revision > HNAE3_DEVICE_VERSION_V2)
+		ret = hclge_devlink_scc_info_get(devlink, req);
+
+	return ret;
 }
 
 static int hclge_devlink_reload_down(struct devlink *devlink, bool netns_change,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.h
index 918be04507a5..148effa5ea89 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.h
@@ -6,6 +6,8 @@
 
 #include "hclge_main.h"
 
+#define	HCLGE_DEVLINK_FW_SCC_LEN	32
+
 struct hclge_devlink_priv {
 	struct hclge_dev *hdev;
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index eb31a7e9c8fc..28336cf17170 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10883,6 +10883,24 @@ static u32 hclge_get_fw_version(struct hnae3_handle *handle)
 	return hdev->fw_version;
 }
 
+int hclge_query_scc_version(struct hclge_dev *hdev, u32 *scc_version)
+{
+	struct hclge_comm_query_scc_cmd *resp;
+	struct hclge_desc desc;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_SCC_VER, 1);
+	resp = (struct hclge_comm_query_scc_cmd *)desc.data;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		return ret;
+
+	*scc_version = le32_to_cpu(resp->scc_version);
+
+	return 0;
+}
+
 static void hclge_set_flowctrl_adv(struct hclge_dev *hdev, u32 rx_en, u32 tx_en)
 {
 	struct phy_device *phydev = hdev->hw.mac.phydev;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index e821dd2f1528..df3c10098349 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -1169,4 +1169,5 @@ int hclge_enable_vport_vlan_filter(struct hclge_vport *vport, bool request_en);
 int hclge_mac_update_stats(struct hclge_dev *hdev);
 struct hclge_vport *hclge_get_vf_vport(struct hclge_dev *hdev, int vf);
 int hclge_inform_vf_reset(struct hclge_vport *vport, u16 reset_type);
+int hclge_query_scc_version(struct hclge_dev *hdev, u32 *scc_version);
 #endif
-- 
2.30.0


