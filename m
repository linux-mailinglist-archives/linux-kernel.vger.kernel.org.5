Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E1F7A7E27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjITMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjITMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:15:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B5D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:15:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAF2C433C8;
        Wed, 20 Sep 2023 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695212139;
        bh=1oPS4RXR1qRlYTWkwg8XCNynAbh4/P2cvwtE58r78yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOroctKLy1ic9YAW/t8Jr7+dtcE7JjAxchTjScAhKpFa5fcjrkyc/8mKUJie6Pjaf
         E/HkBMVKG1/1YYkdcKY4drxzyl1vmjadq0kz1ToSDQmsp/0epBgMAVPFks9bbThiKW
         Q7ko0Zhy21eqRyBtIXvvmGz0DiQTfrZq4dvid1RAUVxdCwKIlh+ozcvk9uKH52MRQC
         431yqxU2kXZPU3YMXR5ZDsl4BT1BcDxrzlAKxJ6VzU3381lZTzPxb7LC75RuxiXbHf
         F6jdCkbkw5ifMQtxQSkwBL+ktLsjTzCuTF12MKNGJIhQVhaCQWT970PGcbHKOoiaob
         EQRqs5zw5VIew==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
Subject: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date:   Wed, 20 Sep 2023 15:15:28 +0300
Message-Id: <20230920121530.4710-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920121530.4710-1-rogerq@kernel.org>
References: <20230920121530.4710-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move this code to the end to avoid forward declaration.
No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 78 ++++++++++++-------------
 1 file changed, 39 insertions(+), 39 deletions(-)

Changelog:
v4: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 9ac2ff05d501..f91137d8e73b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -787,45 +787,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
 					  port, port, true);
 }
 
-int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
-			       void *type_data)
-{
-	switch (type) {
-	case TC_QUERY_CAPS:
-		return am65_cpsw_tc_query_caps(ndev, type_data);
-	case TC_SETUP_QDISC_TAPRIO:
-		return am65_cpsw_setup_taprio(ndev, type_data);
-	case TC_SETUP_BLOCK:
-		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
-	am65_cpsw_est_link_up(ndev, link_speed);
-	port->qos.link_down_time = 0;
-}
-
-void am65_cpsw_qos_link_down(struct net_device *ndev)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
-	if (!port->qos.link_down_time)
-		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
-}
-
 static u32
 am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
 {
@@ -937,3 +898,42 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
 	}
 }
+
+int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			       void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return am65_cpsw_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_TAPRIO:
+		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_BLOCK:
+		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
+		return;
+
+	am65_cpsw_est_link_up(ndev, link_speed);
+	port->qos.link_down_time = 0;
+}
+
+void am65_cpsw_qos_link_down(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
+		return;
+
+	if (!port->qos.link_down_time)
+		port->qos.link_down_time = ktime_get();
+
+	port->qos.link_speed = SPEED_UNKNOWN;
+}
-- 
2.34.1

