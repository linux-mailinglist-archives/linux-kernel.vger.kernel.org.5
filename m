Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE97763AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjHIP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjHIP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:28:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711B5E7F;
        Wed,  9 Aug 2023 08:28:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7382CE000B;
        Wed,  9 Aug 2023 15:28:10 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        stable@vger.kernel.org
Subject: [PATCH net] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
Date:   Wed,  9 Aug 2023 17:29:13 +0200
Message-Id: <20230809152913.27218-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When batadv_v_ogm_aggr_send is called for an inactive interface, the skb
is silently dropped by batadv_v_ogm_send_to_if() but never freed causing
the following memory leak:

  unreferenced object 0xffff00000c164800 (size 512):
    comm "kworker/u8:1", pid 2648, jiffies 4295122303 (age 97.656s)
    hex dump (first 32 bytes):
      00 80 af 09 00 00 ff ff e1 09 00 00 75 01 60 83  ............u.`.
      1f 00 00 00 b8 00 00 00 15 00 05 00 da e3 d3 64  ...............d
    backtrace:
      [<0000000007ad20f6>] __kmalloc_track_caller+0x1a8/0x310
      [<00000000d1029e55>] kmalloc_reserve.constprop.0+0x70/0x13c
      [<000000008b9d4183>] __alloc_skb+0xec/0x1fc
      [<00000000c7af5051>] __netdev_alloc_skb+0x48/0x23c
      [<00000000642ee5f5>] batadv_v_ogm_aggr_send+0x50/0x36c
      [<0000000088660bd7>] batadv_v_ogm_aggr_work+0x24/0x40
      [<0000000042fc2606>] process_one_work+0x3b0/0x610
      [<000000002f2a0b1c>] worker_thread+0xa0/0x690
      [<0000000059fae5d4>] kthread+0x1fc/0x210
      [<000000000c587d3a>] ret_from_fork+0x10/0x20

Free the skb in that case to fix this leak.

Cc: stable@vger.kernel.org
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/bat_v_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e710e9afe78f..445b06fc0d90 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -123,8 +123,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
-- 
2.40.0

