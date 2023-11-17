Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167197EF27B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjKQMSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKQMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA4D8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:18:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688B6C433C9;
        Fri, 17 Nov 2023 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700223486;
        bh=lpWLTDXadMFB1ljUCDUxsx9qfZtjOHFn7HN2op9Hkwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6GogXYjcn1Frj2lwUchKWgxvK5RDTx7Mgg2j0upL+IZ728HKrcCN3IDC/p5JAlTI
         AF5dqSYAJG9c6KMC+7s0xIzn23/hpA6wajWhuQIJG8CcV0Ly0seWW5GipTJmJ3H3Ff
         zpvig7jIcuht85I/gVqczDQj4A98MMGS9iaueHo9TLOdBPMIVLQSY80dPAcbT5Yhyn
         EzNZbfRTEKx2jwOkxwtnUT3qbFkUKKyL/oVVkdKe0uS5nPWL5mt2Bjif1YSzo6VJ7r
         abA/Jeo4dp7nbT0VA3cDKswDPcqPoA+CV3+zqCL+goz/2O5L59k48quyjM5g/8gDrM
         zKGWPAIC6hIMg==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, andrew@lunn.ch,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 1/4] net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
Date:   Fri, 17 Nov 2023 14:17:52 +0200
Message-Id: <20231117121755.104547-2-rogerq@kernel.org>
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

Gets 'ethtool -S eth0 --groups eth-mac' command to work.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index c51e2af91f69..b9e1d568604b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -662,6 +662,31 @@ static void am65_cpsw_get_ethtool_stats(struct net_device *ndev,
 					hw_stats[i].offset);
 }
 
+static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
+					struct ethtool_eth_mac_stats *s)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_stats_regs __iomem *stats;
+
+	stats = port->stat_base;
+
+	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
+	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
+	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
+	s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
+	s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
+	s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
+	s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
+	s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
+	s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
+	s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
+	s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
+	s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
+	s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
+	s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
+	s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
+};
+
 static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 					 struct ethtool_ts_info *info)
 {
@@ -729,6 +754,7 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_sset_count		= am65_cpsw_get_sset_count,
 	.get_strings		= am65_cpsw_get_strings,
 	.get_ethtool_stats	= am65_cpsw_get_ethtool_stats,
+	.get_eth_mac_stats	= am65_cpsw_get_eth_mac_stats,
 	.get_ts_info		= am65_cpsw_get_ethtool_ts_info,
 	.get_priv_flags		= am65_cpsw_get_ethtool_priv_flags,
 	.set_priv_flags		= am65_cpsw_set_ethtool_priv_flags,
-- 
2.34.1

