Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC344810F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378852AbjLMLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378817AbjLMLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:07:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB190189
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:07:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF688C433C8;
        Wed, 13 Dec 2023 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702465672;
        bh=uKhd3JS1pFTqDv4Q8l75rLOBPsAgjlEdfaWWYPn6jXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUCcJyZgrU8hhbXX06TZyC9YJe/SITdnhAAiRBrbNF3MKXaxqu/+PF2g6/mhCNANP
         B7C+bcpiwzYw28pAcCHmSY7oxiBPZcY7BsxrAfjXUWzXr8wInwhDAmY2uDyPEDb/t8
         B2OJyyQyAaAOMUfFft6+Z6YUeQmYcyjiCET4RMjANoiOvZ/ylLjDKkJD5bQZ7ZQb9c
         EKPgBZsH4ELSqjjarQd1AhshBLnHGwAPq0xP8Blid3kmfq/BuGlVkdF/6njPDAFFuR
         GjmHVx25SWAxcIdKxeAUWcTHEJjgJJ8EhLvOewvKj26jphy3LvR0mZ7Y/UZAjyKSQE
         1sdVQOmQH0Img==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com,
        srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org
Subject: [PATCH v8 net-next 06/11] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date:   Wed, 13 Dec 2023 13:07:16 +0200
Message-Id: <20231213110721.69154-7-rogerq@kernel.org>
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

Move this code to the end to avoid forward declaration.
No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 86 ++++++++++++-------------
 1 file changed, 43 insertions(+), 43 deletions(-)

Changelog

v7: move am65_cpsw_qos_tx_rate_calc()
v6: no change
v5: no change
v4: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 2c97fa05a852..862a98211caa 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -56,6 +56,16 @@ enum timer_act {
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+static u32
+am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
+{
+	u32 ir;
+
+	bus_freq /= 1000000;
+	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
+	return ir;
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -772,49 +782,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
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
-	am65_cpsw_est_link_up(ndev, link_speed);
-	port->qos.link_down_time = 0;
-}
-
-void am65_cpsw_qos_link_down(struct net_device *ndev)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	if (!port->qos.link_down_time)
-		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
-}
-
-static u32
-am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
-{
-	u32 ir;
-
-	bus_freq /= 1000000;
-	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
-	return ir;
-}
-
 static void
 am65_cpsw_qos_tx_p0_rate_apply(struct am65_cpsw_common *common,
 			       int tx_ch, u32 rate_mbps)
@@ -916,3 +883,36 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
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
+	am65_cpsw_est_link_up(ndev, link_speed);
+	port->qos.link_down_time = 0;
+}
+
+void am65_cpsw_qos_link_down(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	if (!port->qos.link_down_time)
+		port->qos.link_down_time = ktime_get();
+
+	port->qos.link_speed = SPEED_UNKNOWN;
+}
-- 
2.34.1

