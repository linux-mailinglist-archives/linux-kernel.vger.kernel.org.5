Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DBD7EF280
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbjKQMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345959AbjKQMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA3D5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:18:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF32EC433C8;
        Fri, 17 Nov 2023 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700223494;
        bh=WnhCZYkPXtS5MLDKBrXmXcdTGW8FI0vCOXfio8BzzM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRrg83rH3yeWbGrZDy9V4lmq8r0fXbVaEGB1TjNeUM+S0pxtDdaZVKwQEFNh1qg27
         COmS9gClLsgB91XKmiW04iINeynxFxu5QSJESUIdI7jRTCREOJsX+M4nKShVcaFjlh
         Oa7ftJ369Y2sPV99Lo0ZT6C9njM4XY0wrbd/rINqnWvt400T1+edLfCcwHc5ZhfAe5
         V6B9xbAik/RVxgQ4PfwGqVOSvZ1AJnzZwpmWtq0gImN1xB/fXqAo0Ezb2ylAXcxN9h
         k2ejnhc6iowZhljPQU0oLGu7q+9gY0yNVXgJdSEe5QpVCSSLZnDZ9FkhrzWoXEF4NY
         ICTaQkp1aQ9yQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, andrew@lunn.ch,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 3/4] net: ethernet: am65-cpsw: Set default TX channels to maximum
Date:   Fri, 17 Nov 2023 14:17:54 +0200
Message-Id: <20231117121755.104547-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117121755.104547-1-rogerq@kernel.org>
References: <20231117121755.104547-1-rogerq@kernel.org>
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

am65-cpsw supports 8 TX hardware queues. Set this as default.

The rationale is that some am65-cpsw devices can have up to 4 ethernet
ports. If the number of TX channels have to be changed then all
interfaces have to be brought down and up as the old default of 1
TX channel is too restrictive for any mqprio/taprio usage.

Another reason for this change is to allow testing using
kselftest:net/forwarding:ethtool_mm.sh out of the box.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index adb29e8e8026..78b3e69fbccb 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -136,6 +136,8 @@
 			 NETIF_MSG_IFUP	| NETIF_MSG_PROBE | NETIF_MSG_IFDOWN | \
 			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
 
+#define AM65_CPSW_DEFAULT_TX_CHNS	8
+
 static void am65_cpsw_port_set_sl_mac(struct am65_cpsw_port *slave,
 				      const u8 *dev_addr)
 {
@@ -2894,7 +2896,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	common->rx_flow_id_base = -1;
 	init_completion(&common->tdown_complete);
-	common->tx_ch_num = 1;
+	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin = false;
 	common->default_vlan = 1;
 
-- 
2.34.1

