Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76976FD85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjHDJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjHDJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:38:48 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5249F0;
        Fri,  4 Aug 2023 02:38:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC33724000B;
        Fri,  4 Aug 2023 09:38:36 +0000 (UTC)
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
Subject: [PATCH net] batman-adv: Fix TT global entry leak when client roamed back
Date:   Fri,  4 Aug 2023 11:39:36 +0200
Message-Id: <20230804093936.22257-1-repk@triplefau.lt>
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

When a client roamed back to a node before it got time to destroy the
pending local entry (i.e. within the same originator interval) the old
global one is directly removed from hash table and left as such.

But because this entry had an extra reference taken at lookup (i.e using
batadv_tt_global_hash_find) there is no way its memory will be reclaimed
at any time causing the following memory leak:

  unreferenced object 0xffff0000073c8000 (size 18560):
    comm "softirq", pid 0, jiffies 4294907738 (age 228.644s)
    hex dump (first 32 bytes):
      06 31 ac 12 c7 7a 05 00 01 00 00 00 00 00 00 00  .1...z..........
      2c ad be 08 00 80 ff ff 6c b6 be 08 00 80 ff ff  ,.......l.......
    backtrace:
      [<00000000ee6e0ffa>] kmem_cache_alloc+0x1b4/0x300
      [<000000000ff2fdbc>] batadv_tt_global_add+0x700/0xe20
      [<00000000443897c7>] _batadv_tt_update_changes+0x21c/0x790
      [<000000005dd90463>] batadv_tt_update_changes+0x3c/0x110
      [<00000000a2d7fc57>] batadv_tt_tvlv_unicast_handler_v1+0xafc/0xe10
      [<0000000011793f2a>] batadv_tvlv_containers_process+0x168/0x2b0
      [<00000000b7cbe2ef>] batadv_recv_unicast_tvlv+0xec/0x1f4
      [<0000000042aef1d8>] batadv_batman_skb_recv+0x25c/0x3a0
      [<00000000bbd8b0a2>] __netif_receive_skb_core.isra.0+0x7a8/0xe90
      [<000000004033d428>] __netif_receive_skb_one_core+0x64/0x74
      [<000000000f39a009>] __netif_receive_skb+0x48/0xe0
      [<00000000f2cd8888>] process_backlog+0x174/0x344
      [<00000000507d6564>] __napi_poll+0x58/0x1f4
      [<00000000b64ef9eb>] net_rx_action+0x504/0x590
      [<00000000056fa5e4>] _stext+0x1b8/0x418
      [<00000000878879d6>] run_ksoftirqd+0x74/0xa4
  unreferenced object 0xffff00000bae1a80 (size 56):
    comm "softirq", pid 0, jiffies 4294910888 (age 216.092s)
    hex dump (first 32 bytes):
      00 78 b1 0b 00 00 ff ff 0d 50 00 00 00 00 00 00  .x.......P......
      00 00 00 00 00 00 00 00 50 c8 3c 07 00 00 ff ff  ........P.<.....
    backtrace:
      [<00000000ee6e0ffa>] kmem_cache_alloc+0x1b4/0x300
      [<00000000d9aaa49e>] batadv_tt_global_add+0x53c/0xe20
      [<00000000443897c7>] _batadv_tt_update_changes+0x21c/0x790
      [<000000005dd90463>] batadv_tt_update_changes+0x3c/0x110
      [<00000000a2d7fc57>] batadv_tt_tvlv_unicast_handler_v1+0xafc/0xe10
      [<0000000011793f2a>] batadv_tvlv_containers_process+0x168/0x2b0
      [<00000000b7cbe2ef>] batadv_recv_unicast_tvlv+0xec/0x1f4
      [<0000000042aef1d8>] batadv_batman_skb_recv+0x25c/0x3a0
      [<00000000bbd8b0a2>] __netif_receive_skb_core.isra.0+0x7a8/0xe90
      [<000000004033d428>] __netif_receive_skb_one_core+0x64/0x74
      [<000000000f39a009>] __netif_receive_skb+0x48/0xe0
      [<00000000f2cd8888>] process_backlog+0x174/0x344
      [<00000000507d6564>] __napi_poll+0x58/0x1f4
      [<00000000b64ef9eb>] net_rx_action+0x504/0x590
      [<00000000056fa5e4>] _stext+0x1b8/0x418
      [<00000000878879d6>] run_ksoftirqd+0x74/0xa4

Releasing the extra reference from batadv_tt_global_hash_find even at
roam back when batadv_tt_global_free is called fixes this memory leak.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 36ca31252a73..b95c36765d04 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -774,7 +774,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose
-- 
2.40.0

