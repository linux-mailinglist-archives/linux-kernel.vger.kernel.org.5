Return-Path: <linux-kernel+bounces-94808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F4874579
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86531C21A58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAD6AA7;
	Thu,  7 Mar 2024 01:06:22 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C45221;
	Thu,  7 Mar 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773581; cv=none; b=J4b0IDmWVOC2JsJk1fOB7bt52VbLkf8Cb5L/9/IP0V68g2UVghzC1JduhEuI54RCT9DfYHXmO7j9LQIMmumkOajMaEVJ9sLYNAX40Yx9745UbvhrPNOPDZLSqw0j3Ue2i7uaVamHLctBsKAQdu7LnLXkDoy+z10fmmSRhFLytnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773581; c=relaxed/simple;
	bh=Y5/N+ukv6C9w/+IlVu52YgJyi8zlNy6mSu6Hje3Ar7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCh61oWa6al+gq+pjHQ3MAEuMxF+GtgA7wZBVwf2iXBXO12MZ+7uUBlMiXLZIxNZ8vUqoY28aU+EV1YJi+YMvdl0S/mwPHmi/f95u9ir8KNVR5OO5WUho072Bvs72VAwIPstxrUJham7iL8bcR8dIzrN5qoSqUhQOsygxQuOISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TqrhH5ThKz27g14;
	Thu,  7 Mar 2024 09:05:35 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B00518001B;
	Thu,  7 Mar 2024 09:06:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/8] net: hns3: Disable SerDes serial loopback for HiLink H60
Date: Thu, 7 Mar 2024 09:01:10 +0800
Message-ID: <20240307010115.3054770-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240307010115.3054770-1-shaojijie@huawei.com>
References: <20240307010115.3054770-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Hao Lan <lanhao@huawei.com>

When the hilink version is H60, the serdes serial loopback test is not
supported. This patch add hilink version detection. When the version
is H60, the serdes serial loopback test will be disable.

Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c      | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 3 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 9 +++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 6 ++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index d7e175a9cb49..a72caaf05475 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -388,6 +388,7 @@ struct hnae3_dev_specs {
 	u16 mc_mac_size;
 	u32 mac_stats_num;
 	u8 tnl_num;
+	u8 hilink_version;
 };
 
 struct hnae3_client_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index c083d1d10767..807eb3bbb11c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1097,6 +1097,8 @@ hns3_dbg_dev_specs(struct hnae3_handle *h, char *buf, int len, int *pos)
 	*pos += scnprintf(buf + *pos, len - *pos,
 			  "TX timeout threshold: %d seconds\n",
 			  dev->watchdog_timeo / HZ);
+	*pos += scnprintf(buf + *pos, len - *pos, "Hilink Version: %u\n",
+			  dev_specs->hilink_version);
 }
 
 static int hns3_dbg_dev_info(struct hnae3_handle *h, char *buf, int len)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 4d15eb73b972..9bb708fa42f2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -828,7 +828,8 @@ struct hclge_dev_specs_1_cmd {
 	__le16 mc_mac_size;
 	u8 rsv1[6];
 	u8 tnl_num;
-	u8 rsv2[5];
+	u8 hilink_version;
+	u8 rsv2[4];
 };
 
 /* mac speed type defined in firmware command */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 21f3e2bf5ef8..16860eea9800 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -645,8 +645,12 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 			handle->flags |= HNAE3_SUPPORT_APP_LOOPBACK;
 		}
 
-		count += 1;
-		handle->flags |= HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK;
+		if (hdev->ae_dev->dev_specs.hilink_version !=
+		    HCLGE_HILINK_H60) {
+			count += 1;
+			handle->flags |= HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK;
+		}
+
 		count += 1;
 		handle->flags |= HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK;
 		count += 1;
@@ -1358,6 +1362,7 @@ static void hclge_parse_dev_specs(struct hclge_dev *hdev,
 	ae_dev->dev_specs.umv_size = le16_to_cpu(req1->umv_size);
 	ae_dev->dev_specs.mc_mac_size = le16_to_cpu(req1->mc_mac_size);
 	ae_dev->dev_specs.tnl_num = req1->tnl_num;
+	ae_dev->dev_specs.hilink_version = req1->hilink_version;
 }
 
 static void hclge_check_dev_specs(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index a2877b64e085..e821dd2f1528 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -256,6 +256,12 @@ enum HCLGE_MAC_DUPLEX {
 	HCLGE_MAC_FULL
 };
 
+/* hilink version */
+enum hclge_hilink_version {
+	HCLGE_HILINK_H32 = 0,
+	HCLGE_HILINK_H60 = 1,
+};
+
 #define QUERY_SFP_SPEED		0
 #define QUERY_ACTIVE_SPEED	1
 
-- 
2.30.0


