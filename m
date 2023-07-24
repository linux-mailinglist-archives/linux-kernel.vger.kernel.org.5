Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F075E88A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGXBmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGXBlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563E49E8;
        Sun, 23 Jul 2023 18:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D2D60FE7;
        Mon, 24 Jul 2023 01:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11912C433C9;
        Mon, 24 Jul 2023 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162381;
        bh=cOLWExnC/FmQJuHc3FXNm2Vtso8Sg+kK8NYP7GxHDL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjCBj9HlDxegJirCmiG1s9uD2ACT7m3QF8gAQwtSdbWF6Qq0hHK2uPjvvbiUJYvIU
         +txv/acEtT7pDUG9pnYrnZkTQ9EJluQ5K0jZyA68JXvqWLya/nS0W+aQ9GP5nIl7UH
         W3KO20EosAhqx4RaEdwgLSKMn+sgSqdXEiZtuB6OuhSHAPDNWjS5CGpXXRwtvgtN5v
         fzblGEWfNbN4nYISrV9Ow6jc7NnCSy0cMaJgi76GhnPwBIPwQ7bQwlvyLomCR12mPW
         c4ZvppiHe1k3/OIhbnGa+C1HH4Rtb5G+ukaxwk9iu4WhrTTYBh1tromhSVGZmDhatG
         oluvMR5WqaAow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Sasha Levin <sashal@kernel.org>, stefanr@s5r6.in-berlin.de,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 17/34] firewire: net: fix use after free in fwnet_finish_incoming_packet()
Date:   Sun, 23 Jul 2023 21:32:20 -0400
Message-Id: <20230724013238.2329166-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index af22be84034bb..a53eacebca339 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -479,7 +479,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	int status;
+	int status, len;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -533,13 +533,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
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

