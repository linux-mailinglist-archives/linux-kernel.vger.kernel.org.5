Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE12C75E8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGXBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjGXBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E22D45;
        Sun, 23 Jul 2023 18:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D42761008;
        Mon, 24 Jul 2023 01:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF1DC433CA;
        Mon, 24 Jul 2023 01:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162423;
        bh=PFTIL8nbMNulWCIw5aHn23CZ5h7yHsMbod9OQrcI6B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hl/tU6k2IhXU7tcb1OlbuOwm1EZl4Pfgywj3fFBK2Z46mgsHUnccKt3xJZkG2T5uW
         pn0+cwgojnpYSo/fhc/bPLQ11jyZ4pJs3gdNhCj4jCnrJhvqO1mFMWSNjUkRi79MOL
         Tg1Xzj2YPWfW3XucHU7dPANIiOdWIjyBBa1Opa5070zot+0eId+6xH0d1KhpWV7vka
         uEgNJsneBfSPjTcephR89kNmVVmhvZ3X5KepPJDUl7XQWh8RxEpSe3lPsP0LRyr3vj
         BWGQ7m7XUCO8Ej7eZA7exH5am6k5bCL25UTDjwdgUP+eYRBlpaLhEAM9VI40WCb4QT
         vqSOD0uB2B03g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Sasha Levin <sashal@kernel.org>, stefanr@s5r6.in-berlin.de,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 12/24] firewire: net: fix use after free in fwnet_finish_incoming_packet()
Date:   Sun, 23 Jul 2023 21:33:13 -0400
Message-Id: <20230724013325.2332084-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 3ff256751a2853e1ffaa36958ff933ccc98c6cb5 ]

The netif_rx() function frees the skb so we can't dereference it to
save the skb->len.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 4c3fd2eed1da4..beba0a56bb9ae 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -488,7 +488,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	int status;
+	int status, len;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -542,13 +542,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		}
 		skb->protocol = protocol;
 	}
+
+	len = skb->len;
 	status = netif_rx(skb);
 	if (status == NET_RX_DROP) {
 		net->stats.rx_errors++;
 		net->stats.rx_dropped++;
 	} else {
 		net->stats.rx_packets++;
-		net->stats.rx_bytes += skb->len;
+		net->stats.rx_bytes += len;
 	}
 
 	return 0;
-- 
2.39.2

