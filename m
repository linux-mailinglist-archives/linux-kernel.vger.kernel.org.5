Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BB810F78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378918AbjLMLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378857AbjLMLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:08:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027A124
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:08:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221EC433C8;
        Wed, 13 Dec 2023 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702465692;
        bh=zLuO6/75uYDIjN5N3SM8Ia80Qf1C89jN/8CZR3SxV6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1QYrjSVWVs98vp3dGJAOcfh1QmVxz2E+XOIHpC/0jUmxirlpTOhCMuE643wDu4J7
         HEMgMFpFDtP23AdUMaGNUqBgtKaheprkR0PQfxKsrJlz1o6IJj8TuSqZov/64rxqPJ
         aOwPzWWX1kXCeLscvxaPpGjFCYqTQC2KzUuZ3ODHirnAUP2U5QyCv+D2p8RVsa44tI
         hI5i8lEwQ30x0p8jBFMsrVYrpNfu+VkrNwmYacfz5IT2RnwWZ3TeBf3NlfDnI3EVxz
         4j73V/cgoXbntKfjzl4faw0U6yfpqG56NRylkHJZ1rJ5OkNGrCeg009YptFoSJJKTX
         ASKKHIwY1xsWg==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com,
        srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org
Subject: [PATCH v8 net-next 11/11] net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats
Date:   Wed, 13 Dec 2023 13:07:21 +0200
Message-Id: <20231213110721.69154-12-rogerq@kernel.org>
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

We do not support individual stats for PMAC and EMAC so
report only aggregate stats.

Fixes: 67372d7a85fc ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

Changelog:

v8: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index d2baffb05d55..35e318458b0c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -671,6 +671,9 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
 
 	stats = port->stat_base;
 
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
 	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
 	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
 	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
-- 
2.34.1

