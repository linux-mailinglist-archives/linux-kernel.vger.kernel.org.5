Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F27E9AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjKMLH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjKMLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:07:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F010D7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:07:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58709C433C8;
        Mon, 13 Nov 2023 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699873643;
        bh=sHCRpYWlwN1++CWChUaVlOJq1vUhjh4oC5rKbeN65HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcVyKSsoOi4EGz1SVIaJoOdWkdYgJk+eGaUMj+OhwJibXvmBRYctyYYSwGm1ecXWS
         VeRffEN7ClWQZBmD1mfCZHzqS2wEHQGjHUh4FzGxxi9ebmRXRBVum/KCcwfjPb5AXe
         b7FyTWeVQXayqLvsOxk1e0p47dNGOIhislNZw8zZ8aeHULkHNw8U2BIhlFI4OLk/Wd
         wYAvUQ7x9YVvW59RgRmWdXhS2JwDBNRBvpPe8rKTcDxF60bDu+lUnVhaTKXt/JF1g7
         iZICMGQcBk4OPfJFHborcOpAb0FG9cxWf85cDpI2HHS7S3TtNdF0AFPPaiArgG/s6b
         gEEb7QXjhK5xA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 2/3] net: ethernet: am65-cpsw: Set default TX channels to maximum
Date:   Mon, 13 Nov 2023 13:07:07 +0200
Message-Id: <20231113110708.137379-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113110708.137379-1-rogerq@kernel.org>
References: <20231113110708.137379-1-rogerq@kernel.org>
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

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ece9f8df98ae..7c440899c93c 100644
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
@@ -2897,7 +2899,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	common->rx_flow_id_base = -1;
 	init_completion(&common->tdown_complete);
-	common->tx_ch_num = 1;
+	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin = false;
 	common->default_vlan = 1;
 
-- 
2.34.1

