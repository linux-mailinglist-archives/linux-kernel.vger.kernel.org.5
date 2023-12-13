Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144B810F63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378602AbjLMLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378636AbjLMLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:07:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C54F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:07:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E951DC433CB;
        Wed, 13 Dec 2023 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702465660;
        bh=52ReVQRfMYa8eSEYp3Q551Bgs6BSsEBuYjMXwOgtZDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSYFysQB/jy7zZzwqlcMAbLLpBmLbquAsKPm4x6KMzPwIgQkNbfwPcfvGuxGksHa+
         75QsTM/swmTMq/q3E9uWMpLYhcfIopVw6y5v6RtN018LzD+tZvGvZlWrkwgqEBJMPb
         f7ZHMd8k9MA5yBov3Rj6Lib7g73iKOyiI3OVy6a+Qpe4KsDoTACyRDej0gdBSA6f21
         VfJrOJREZWn2FT1USknqInEbjjjFa0DJuf2C86xXZCKeRvlCP9msXY+FvULZ1xkg5l
         i15yf656KZfMOpQS8+beYL6JVle6LSruzCtGeacQzdbpnQm4/hGDyVQGIfe2IZ+k42
         6F9sVqYu7puEg==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com,
        srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org
Subject: [PATCH v8 net-next 03/11] net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
Date:   Wed, 13 Dec 2023 13:07:13 +0200
Message-Id: <20231213110721.69154-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213110721.69154-1-rogerq@kernel.org>
References: <20231213110721.69154-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build am65-cpsw-qos only if CONFIG_TI_AM65_CPSW_TAS is enabled.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/Makefile        |  3 ++-
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 12 ------------
 drivers/net/ethernet/ti/am65-cpsw-qos.h | 26 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

Changelog:

v8: no change
v7: no change
v6: initial commit

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 27de1d697134..9d7cd84d1e2d 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -26,7 +26,8 @@ keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o cpsw_ale.
 obj-$(CONFIG_TI_K3_CPPI_DESC_POOL) += k3-cppi-desc-pool.o
 
 obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o
-ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o am65-cpsw-qos.o
+ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o
+ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_TAS) += am65-cpsw-qos.o
 ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 9ac2ff05d501..4bc611cc4aad 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -571,9 +571,6 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 	    taprio->cmd != TAPRIO_CMD_DESTROY)
 		return -EOPNOTSUPP;
 
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return -ENODEV;
-
 	if (!netif_running(ndev)) {
 		dev_err(&ndev->dev, "interface is down, link speed unknown\n");
 		return -ENETDOWN;
@@ -599,9 +596,6 @@ static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
-		if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-			return -EOPNOTSUPP;
-
 		caps->gate_mask_per_txq = true;
 
 		return 0;
@@ -806,9 +800,6 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
 	am65_cpsw_est_link_up(ndev, link_speed);
 	port->qos.link_down_time = 0;
 }
@@ -817,9 +808,6 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 0cc2a3b3d7f9..898f13a4a112 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -31,11 +31,37 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
 };
 
+#if IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
 void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
 void am65_cpsw_qos_link_down(struct net_device *ndev);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
+#else
+static inline int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev,
+					     enum tc_setup_type type,
+					     void *type_data)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void am65_cpsw_qos_link_up(struct net_device *ndev,
+					 int link_speed)
+{ }
+
+static inline void am65_cpsw_qos_link_down(struct net_device *ndev)
+{ }
+
+static inline int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev,
+						      int queue,
+						      u32 rate_mbps)
+{
+	return 0;
+}
+
+static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
+{ }
+#endif
 
 #endif /* AM65_CPSW_QOS_H_ */
-- 
2.34.1

