Return-Path: <linux-kernel+bounces-94813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960E874584
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019F628434E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE861D524;
	Thu,  7 Mar 2024 01:06:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6021BF3A;
	Thu,  7 Mar 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773587; cv=none; b=Y3codxeYbR/+WiqGvTkOoyXGeULP388H1ugZ5ovnVaokqC9nNrZHlxqnSjcT2qahVpoVf8m4X8bPnV02GO3IQ/9VYTrNBRen1+sgjtwszBoOTR1/+s2U4FknaseuaAx3oox/Cfxdn8693V1ynqNWCDFK5OUz0zp4MmTJD8SwtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773587; c=relaxed/simple;
	bh=jKU5Dbc8Lw9pdFRvsoh3LxZdq4suvLyOOTg538V9Y1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=humGs+2+ty30SA6GFKKjJOmlYZ2IzZrU57ybec0gQzAESlIn78S5rqgN7rg+6LbnFSc/5XymHpkJR8ZGVIiiEAGZYSW/2IIqBf51pUwGIOvUUbwAJzXUxaqHsIRtve+Lq9s+0iZIGoxBP+ELgu/H7DbcE9YSOKGwbTxYQA+LHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tqrht6XQKz1FLxK;
	Thu,  7 Mar 2024 09:06:06 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A737A1402E0;
	Thu,  7 Mar 2024 09:06:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/8] net: hns3: add new 200G link modes for hisilicon device
Date: Thu, 7 Mar 2024 09:01:09 +0800
Message-ID: <20240307010115.3054770-3-shaojijie@huawei.com>
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

The hisilicon device now supports a new 200G link interface,
which query from firmware in a new bit. Therefore,
the HCLGE_SUPPORT_200G_R4_BIT capability bit has been added.
The HCLGE_SUPPORT_200G_BIT has been renamed as
HCLGE_SUPPORT_200G_R4_EXT_BIT, and the firmware has
extended support for this mode.

Fixes: ae6f010cb1a7 ("net: hns3: add support for 200G device")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 28 ++++++++++++-------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  5 +++-
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5ea9e59569ef..21f3e2bf5ef8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -884,7 +884,7 @@ static const struct hclge_speed_bit_map speed_bit_map[] = {
 	{HCLGE_MAC_SPEED_40G, HCLGE_SUPPORT_40G_BIT},
 	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BITS},
 	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BITS},
-	{HCLGE_MAC_SPEED_200G, HCLGE_SUPPORT_200G_BIT},
+	{HCLGE_MAC_SPEED_200G, HCLGE_SUPPORT_200G_BITS},
 };
 
 static int hclge_get_speed_bit(u32 speed, u32 *speed_bit)
@@ -940,7 +940,7 @@ static void hclge_update_fec_support(struct hclge_mac *mac)
 				 mac->supported);
 }
 
-static const struct hclge_link_mode_bmap hclge_sr_link_mode_bmap[8] = {
+static const struct hclge_link_mode_bmap hclge_sr_link_mode_bmap[] = {
 	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseSR_Full_BIT},
 	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseSR_Full_BIT},
 	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT},
@@ -948,10 +948,12 @@ static const struct hclge_link_mode_bmap hclge_sr_link_mode_bmap[8] = {
 	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseSR_Full_BIT},
 	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT},
 	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT},
-	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_EXT_BIT,
+	 ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_BIT, ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT},
 };
 
-static const struct hclge_link_mode_bmap hclge_lr_link_mode_bmap[6] = {
+static const struct hclge_link_mode_bmap hclge_lr_link_mode_bmap[] = {
 	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseLR_Full_BIT},
 	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT},
 	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT},
@@ -959,11 +961,13 @@ static const struct hclge_link_mode_bmap hclge_lr_link_mode_bmap[6] = {
 	 ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT},
 	{HCLGE_SUPPORT_100G_R2_BIT,
 	 ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT},
-	{HCLGE_SUPPORT_200G_BIT,
+	{HCLGE_SUPPORT_200G_R4_EXT_BIT,
+	 ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_BIT,
 	 ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT},
 };
 
-static const struct hclge_link_mode_bmap hclge_cr_link_mode_bmap[8] = {
+static const struct hclge_link_mode_bmap hclge_cr_link_mode_bmap[] = {
 	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseCR_Full_BIT},
 	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseCR_Full_BIT},
 	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT},
@@ -971,10 +975,12 @@ static const struct hclge_link_mode_bmap hclge_cr_link_mode_bmap[8] = {
 	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseCR_Full_BIT},
 	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT},
 	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT},
-	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_EXT_BIT,
+	 ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_BIT, ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT},
 };
 
-static const struct hclge_link_mode_bmap hclge_kr_link_mode_bmap[9] = {
+static const struct hclge_link_mode_bmap hclge_kr_link_mode_bmap[] = {
 	{HCLGE_SUPPORT_1G_BIT, ETHTOOL_LINK_MODE_1000baseKX_Full_BIT},
 	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseKR_Full_BIT},
@@ -983,7 +989,9 @@ static const struct hclge_link_mode_bmap hclge_kr_link_mode_bmap[9] = {
 	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseKR_Full_BIT},
 	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT},
 	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT},
-	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_EXT_BIT,
+	 ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT},
+	{HCLGE_SUPPORT_200G_R4_BIT, ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT},
 };
 
 static void hclge_convert_setting_sr(u16 speed_ability,
@@ -1154,7 +1162,7 @@ static void hclge_parse_link_mode(struct hclge_dev *hdev, u16 speed_ability)
 
 static u32 hclge_get_max_speed(u16 speed_ability)
 {
-	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
+	if (speed_ability & HCLGE_SUPPORT_200G_BITS)
 		return HCLGE_MAC_SPEED_200G;
 
 	if (speed_ability & HCLGE_SUPPORT_100G_BITS)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 51979cf71262..a2877b64e085 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -191,9 +191,10 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_SUPPORT_40G_BIT		BIT(5)
 #define HCLGE_SUPPORT_100M_BIT		BIT(6)
 #define HCLGE_SUPPORT_10M_BIT		BIT(7)
-#define HCLGE_SUPPORT_200G_BIT		BIT(8)
+#define HCLGE_SUPPORT_200G_R4_EXT_BIT	BIT(8)
 #define HCLGE_SUPPORT_50G_R1_BIT	BIT(9)
 #define HCLGE_SUPPORT_100G_R2_BIT	BIT(10)
+#define HCLGE_SUPPORT_200G_R4_BIT	BIT(11)
 
 #define HCLGE_SUPPORT_GE \
 	(HCLGE_SUPPORT_1G_BIT | HCLGE_SUPPORT_100M_BIT | HCLGE_SUPPORT_10M_BIT)
@@ -201,6 +202,8 @@ enum HLCGE_PORT_TYPE {
 	(HCLGE_SUPPORT_50G_R2_BIT | HCLGE_SUPPORT_50G_R1_BIT)
 #define HCLGE_SUPPORT_100G_BITS \
 	(HCLGE_SUPPORT_100G_R4_BIT | HCLGE_SUPPORT_100G_R2_BIT)
+#define HCLGE_SUPPORT_200G_BITS \
+	(HCLGE_SUPPORT_200G_R4_EXT_BIT | HCLGE_SUPPORT_200G_R4_BIT)
 
 enum HCLGE_DEV_STATE {
 	HCLGE_STATE_REINITING,
-- 
2.30.0


