Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2080877A7D2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjHMPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjHMPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380561716;
        Sun, 13 Aug 2023 08:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5FC46308C;
        Sun, 13 Aug 2023 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F8C433C7;
        Sun, 13 Aug 2023 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941825;
        bh=ySZLsf9RtmrTPiZ0OE31mAdhA4GkF9k0uIoMr3k1e6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJY+QBeB7ee52YGivxo05UdGujCtUZO6YciAkU8y94qqWHHZ7mwMGnhKslls0xX8w
         MdlBUVGiIn2x2vohoyOuhH7rn+LsnEgrTeuKf/0idlVKCDD73Qoz6dbOnRFBabIZ7E
         zScPGCgjfOw+XLr/P1Pb+ezGzabxd3LsmogLKHyp55GmTtBsdLqZWhdnW36n3tnfhd
         Pb1xvthZEd3BCA5Sn0+BOXTDzwGlBMJImSS3It5bYQzGcVdOmYWZZP3lbwzsErXpJJ
         IP44a32BTeNWnQ3kj59+39sK7jw4J+0uNdNUcm5pQu/AK283qsf1fbSybPdTygo99h
         fc4kyJKYw31ow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Lan <lanhao@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, huangguangbin2@huawei.com,
        simon.horman@corigine.com, chenhao418@huawei.com,
        wangjie125@huawei.com, shenjian15@huawei.com, leon@kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 19/54] net: hns3: add tm flush when setting tm
Date:   Sun, 13 Aug 2023 11:48:58 -0400
Message-Id: <20230813154934.1067569-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Lan <lanhao@huawei.com>

[ Upstream commit 6d2336120aa6e1a8a64fa5d6ee5c3f3d0809fe9b ]

When the tm module is configured with traffic, traffic
may be abnormal. This patch fixes this problem.
Before the tm module is configured, traffic processing
should be stopped. After the tm module is configured,
traffic processing is enabled.

Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  4 +++
 .../hns3/hns3_common/hclge_comm_cmd.c         |  1 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  2 ++
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  3 ++
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 34 ++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 31 ++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  4 +++
 7 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 9c9c72dc57e00..0f01e58f95c99 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -101,6 +101,7 @@ enum HNAE3_DEV_CAP_BITS {
 	HNAE3_DEV_SUPPORT_FEC_STATS_B,
 	HNAE3_DEV_SUPPORT_LANE_NUM_B,
 	HNAE3_DEV_SUPPORT_WOL_B,
+	HNAE3_DEV_SUPPORT_TM_FLUSH_B,
 };
 
 #define hnae3_ae_dev_fd_supported(ae_dev) \
@@ -172,6 +173,9 @@ enum HNAE3_DEV_CAP_BITS {
 #define hnae3_ae_dev_wol_supported(ae_dev) \
 	test_bit(HNAE3_DEV_SUPPORT_WOL_B, (ae_dev)->caps)
 
+#define hnae3_ae_dev_tm_flush_supported(hdev) \
+	test_bit(HNAE3_DEV_SUPPORT_TM_FLUSH_B, (hdev)->ae_dev->caps)
+
 enum HNAE3_PF_CAP_BITS {
 	HNAE3_PF_SUPPORT_VLAN_FLTR_MDF_B = 0,
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index b85c412683ddc..40684743a4c6c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -156,6 +156,7 @@ static const struct hclge_comm_caps_bit_map hclge_pf_cmd_caps[] = {
 	{HCLGE_COMM_CAP_FEC_STATS_B, HNAE3_DEV_SUPPORT_FEC_STATS_B},
 	{HCLGE_COMM_CAP_LANE_NUM_B, HNAE3_DEV_SUPPORT_LANE_NUM_B},
 	{HCLGE_COMM_CAP_WOL_B, HNAE3_DEV_SUPPORT_WOL_B},
+	{HCLGE_COMM_CAP_TM_FLUSH_B, HNAE3_DEV_SUPPORT_TM_FLUSH_B},
 };
 
 static const struct hclge_comm_caps_bit_map hclge_vf_cmd_caps[] = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index 18f1b4bf362da..2b7197ce0ae8f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -153,6 +153,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_TM_INTERNAL_STS	= 0x0850,
 	HCLGE_OPC_TM_INTERNAL_CNT	= 0x0851,
 	HCLGE_OPC_TM_INTERNAL_STS_1	= 0x0852,
+	HCLGE_OPC_TM_FLUSH		= 0x0872,
 
 	/* Packet buffer allocate commands */
 	HCLGE_OPC_TX_BUFF_ALLOC		= 0x0901,
@@ -349,6 +350,7 @@ enum HCLGE_COMM_CAP_BITS {
 	HCLGE_COMM_CAP_FEC_STATS_B = 25,
 	HCLGE_COMM_CAP_LANE_NUM_B = 27,
 	HCLGE_COMM_CAP_WOL_B = 28,
+	HCLGE_COMM_CAP_TM_FLUSH_B = 31,
 };
 
 enum HCLGE_COMM_API_CAP_BITS {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 32bb14303473b..0811f9a4f9ee2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -411,6 +411,9 @@ static struct hns3_dbg_cap_info hns3_dbg_cap[] = {
 	}, {
 		.name = "support wake on lan",
 		.cap_bit = HNAE3_DEV_SUPPORT_WOL_B,
+	}, {
+		.name = "support tm flush",
+		.cap_bit = HNAE3_DEV_SUPPORT_TM_FLUSH_B,
 	}
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index c4aded65e848b..cda7e0d0ba56e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -216,6 +216,10 @@ static int hclge_notify_down_uinit(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
+	ret = hclge_tm_flush_cfg(hdev, true);
+	if (ret)
+		return ret;
+
 	return hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 }
 
@@ -227,6 +231,10 @@ static int hclge_notify_init_up(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
+	ret = hclge_tm_flush_cfg(hdev, false);
+	if (ret)
+		return ret;
+
 	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 }
 
@@ -313,6 +321,7 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	struct net_device *netdev = h->kinfo.netdev;
 	struct hclge_dev *hdev = vport->back;
 	u8 i, j, pfc_map, *prio_tc;
+	int last_bad_ret = 0;
 	int ret;
 
 	if (!(hdev->dcbx_cap & DCB_CAP_DCBX_VER_IEEE))
@@ -350,13 +359,28 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	if (ret)
 		return ret;
 
-	ret = hclge_buffer_alloc(hdev);
-	if (ret) {
-		hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	ret = hclge_tm_flush_cfg(hdev, true);
+	if (ret)
 		return ret;
-	}
 
-	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	/* No matter whether the following operations are performed
+	 * successfully or not, disabling the tm flush and notify
+	 * the network status to up are necessary.
+	 * Do not return immediately.
+	 */
+	ret = hclge_buffer_alloc(hdev);
+	if (ret)
+		last_bad_ret = ret;
+
+	ret = hclge_tm_flush_cfg(hdev, false);
+	if (ret)
+		last_bad_ret = ret;
+
+	ret = hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	if (ret)
+		last_bad_ret = ret;
+
+	return last_bad_ret;
 }
 
 static int hclge_ieee_setapp(struct hnae3_handle *h, struct dcb_app *app)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 922c0da3660c7..c40ea6b8c8ec6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1484,7 +1484,11 @@ int hclge_tm_schd_setup_hw(struct hclge_dev *hdev)
 		return ret;
 
 	/* Cfg schd mode for each level schd */
-	return hclge_tm_schd_mode_hw(hdev);
+	ret = hclge_tm_schd_mode_hw(hdev);
+	if (ret)
+		return ret;
+
+	return hclge_tm_flush_cfg(hdev, false);
 }
 
 static int hclge_pause_param_setup_hw(struct hclge_dev *hdev)
@@ -2113,3 +2117,28 @@ int hclge_tm_get_port_shaper(struct hclge_dev *hdev,
 
 	return 0;
 }
+
+int hclge_tm_flush_cfg(struct hclge_dev *hdev, bool enable)
+{
+	struct hclge_desc desc;
+	int ret;
+
+	if (!hnae3_ae_dev_tm_flush_supported(hdev))
+		return 0;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_TM_FLUSH, false);
+
+	desc.data[0] = cpu_to_le32(enable ? HCLGE_TM_FLUSH_EN_MSK : 0);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"failed to config tm flush, ret = %d\n", ret);
+		return ret;
+	}
+
+	if (enable)
+		msleep(HCLGE_TM_FLUSH_TIME_MS);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index dd6f1fd486cf2..45dcfef3f90cc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -33,6 +33,9 @@ enum hclge_opcode_type;
 #define HCLGE_DSCP_MAP_TC_BD_NUM	2
 #define HCLGE_DSCP_TC_SHIFT(n)		(((n) & 1) * 4)
 
+#define HCLGE_TM_FLUSH_TIME_MS	10
+#define HCLGE_TM_FLUSH_EN_MSK	BIT(0)
+
 struct hclge_pg_to_pri_link_cmd {
 	u8 pg_id;
 	u8 rsvd1[3];
@@ -272,4 +275,5 @@ int hclge_tm_get_port_shaper(struct hclge_dev *hdev,
 			     struct hclge_tm_shaper_para *para);
 int hclge_up_to_tc_map(struct hclge_dev *hdev);
 int hclge_dscp_to_tc_map(struct hclge_dev *hdev);
+int hclge_tm_flush_cfg(struct hclge_dev *hdev, bool enable);
 #endif
-- 
2.40.1

