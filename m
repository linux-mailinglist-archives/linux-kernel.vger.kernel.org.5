Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12A47D27D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjJWBMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWBMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:12:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56027ED;
        Sun, 22 Oct 2023 18:12:11 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SDH9x6J5mzNpDk;
        Mon, 23 Oct 2023 09:08:05 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 09:12:06 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: hns3: add some link modes for hisilicon device
Date:   Mon, 23 Oct 2023 09:08:36 +0800
Message-ID: <20231023010836.507078-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

Add HCLGE_SUPPORT_50G_R1_BIT and HCLGE_SUPPORT_100G_R2_BIT two
capability bits and Corresponding link modes.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 162 +++++++++---------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  16 +-
 2 files changed, 96 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c42574e29747..d5ba56854ec8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -881,8 +881,8 @@ static const struct hclge_speed_bit_map speed_bit_map[] = {
 	{HCLGE_MAC_SPEED_10G, HCLGE_SUPPORT_10G_BIT},
 	{HCLGE_MAC_SPEED_25G, HCLGE_SUPPORT_25G_BIT},
 	{HCLGE_MAC_SPEED_40G, HCLGE_SUPPORT_40G_BIT},
-	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BIT},
-	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BIT},
+	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BITS},
+	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BITS},
 	{HCLGE_MAC_SPEED_200G, HCLGE_SUPPORT_200G_BIT},
 };
 
@@ -939,100 +939,102 @@ static void hclge_update_fec_support(struct hclge_mac *mac)
 				 mac->supported);
 }
 
+static const struct hclge_link_mode_bit_map hclge_sr_link_mode_bit_map[8] = {
+	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseSR_Full_BIT},
+	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseSR_Full_BIT},
+	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT},
+	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT},
+	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseSR_Full_BIT},
+	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT},
+	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT},
+	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT},
+};
+
+static const struct hclge_link_mode_bit_map hclge_lr_link_mode_bit_map[6] = {
+	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseLR_Full_BIT},
+	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT},
+	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT},
+	{HCLGE_SUPPORT_100G_R4_BIT,
+	 ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT},
+	{HCLGE_SUPPORT_100G_R2_BIT,
+	 ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT},
+	{HCLGE_SUPPORT_200G_BIT,
+	 ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT},
+};
+
+static const struct hclge_link_mode_bit_map hclge_cr_link_mode_bit_map[8] = {
+	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseCR_Full_BIT},
+	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseCR_Full_BIT},
+	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT},
+	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT},
+	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseCR_Full_BIT},
+	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT},
+	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT},
+	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT},
+};
+
+static const struct hclge_link_mode_bit_map hclge_kr_link_mode_bit_map[9] = {
+	{HCLGE_SUPPORT_1G_BIT, ETHTOOL_LINK_MODE_1000baseKX_Full_BIT},
+	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
+	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseKR_Full_BIT},
+	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT},
+	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT},
+	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseKR_Full_BIT},
+	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT},
+	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT},
+	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT},
+};
+
 static void hclge_convert_setting_sr(u16 speed_ability,
 				     unsigned long *link_mode)
 {
-	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
-				 link_mode);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hclge_sr_link_mode_bit_map); i++) {
+		if (speed_ability & hclge_sr_link_mode_bit_map[i].support_bit)
+			linkmode_set_bit(
+				hclge_sr_link_mode_bit_map[i].link_mode,
+				link_mode);
+	}
 }
 
 static void hclge_convert_setting_lr(u16 speed_ability,
 				     unsigned long *link_mode)
 {
-	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
-		linkmode_set_bit(
-			ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
-			link_mode);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hclge_lr_link_mode_bit_map); i++) {
+		if (speed_ability & hclge_lr_link_mode_bit_map[i].support_bit)
+			linkmode_set_bit(
+				hclge_lr_link_mode_bit_map[i].link_mode,
+				link_mode);
+	}
 }
 
 static void hclge_convert_setting_cr(u16 speed_ability,
 				     unsigned long *link_mode)
 {
-	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
-				 link_mode);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hclge_cr_link_mode_bit_map); i++) {
+		if (speed_ability & hclge_cr_link_mode_bit_map[i].support_bit)
+			linkmode_set_bit(
+				hclge_cr_link_mode_bit_map[i].link_mode,
+				link_mode);
+	}
 }
 
 static void hclge_convert_setting_kr(u16 speed_ability,
 				     unsigned long *link_mode)
 {
-	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
-				 link_mode);
-	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
-				 link_mode);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hclge_kr_link_mode_bit_map); i++) {
+		if (speed_ability & hclge_kr_link_mode_bit_map[i].support_bit)
+			linkmode_set_bit(
+				hclge_kr_link_mode_bit_map[i].link_mode,
+				link_mode);
+	}
 }
 
 static void hclge_convert_setting_fec(struct hclge_mac *mac)
@@ -1158,10 +1160,10 @@ static u32 hclge_get_max_speed(u16 speed_ability)
 	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
 		return HCLGE_MAC_SPEED_200G;
 
-	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
+	if (speed_ability & HCLGE_SUPPORT_100G_BITS)
 		return HCLGE_MAC_SPEED_100G;
 
-	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
+	if (speed_ability & HCLGE_SUPPORT_50G_BITS)
 		return HCLGE_MAC_SPEED_50G;
 
 	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7bc2049b723d..ef530b84eaa0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -185,15 +185,22 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_SUPPORT_1G_BIT		BIT(0)
 #define HCLGE_SUPPORT_10G_BIT		BIT(1)
 #define HCLGE_SUPPORT_25G_BIT		BIT(2)
-#define HCLGE_SUPPORT_50G_BIT		BIT(3)
-#define HCLGE_SUPPORT_100G_BIT		BIT(4)
+#define HCLGE_SUPPORT_50G_R2_BIT	BIT(3)
+#define HCLGE_SUPPORT_100G_R4_BIT	BIT(4)
 /* to be compatible with exsit board */
 #define HCLGE_SUPPORT_40G_BIT		BIT(5)
 #define HCLGE_SUPPORT_100M_BIT		BIT(6)
 #define HCLGE_SUPPORT_10M_BIT		BIT(7)
 #define HCLGE_SUPPORT_200G_BIT		BIT(8)
+#define HCLGE_SUPPORT_50G_R1_BIT	BIT(9)
+#define HCLGE_SUPPORT_100G_R2_BIT	BIT(10)
+
 #define HCLGE_SUPPORT_GE \
 	(HCLGE_SUPPORT_1G_BIT | HCLGE_SUPPORT_100M_BIT | HCLGE_SUPPORT_10M_BIT)
+#define HCLGE_SUPPORT_50G_BITS \
+	(HCLGE_SUPPORT_50G_R2_BIT | HCLGE_SUPPORT_50G_R1_BIT)
+#define HCLGE_SUPPORT_100G_BITS \
+	(HCLGE_SUPPORT_100G_R4_BIT | HCLGE_SUPPORT_100G_R2_BIT)
 
 enum HCLGE_DEV_STATE {
 	HCLGE_STATE_REINITING,
@@ -1076,6 +1083,11 @@ struct hclge_mac_speed_map {
 	u32 speed_fw; /* speed defined in firmware */
 };
 
+struct hclge_link_mode_bit_map {
+	u16 support_bit;
+	enum ethtool_link_mode_bit_indices link_mode;
+};
+
 int hclge_set_vport_promisc_mode(struct hclge_vport *vport, bool en_uc_pmc,
 				 bool en_mc_pmc, bool en_bc_pmc);
 int hclge_add_uc_addr_common(struct hclge_vport *vport,
-- 
2.30.0

