Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3376218D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGYShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGYShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:37:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92142A3;
        Tue, 25 Jul 2023 11:37:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2441A40737C9;
        Tue, 25 Jul 2023 18:37:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2441A40737C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1690310260;
        bh=Fab9GIRqttp0ydbdVKfgoFyEoFMbYfoPhmXpg6WhCHs=;
        h=From:To:Cc:Subject:Date:From;
        b=ddcaE4I/VzTy3aKJgfWeYWGmrOmkYBy5F4v+Tl+RBOJ4vPinRUv3me4AIANvpFpp6
         qDUn/b4SzwGhpEM8P/5uR1E5bbFFMp/VVoRtPBnyF6iZQunyUm/M4jZ54Zx17SFmrI
         uQSU26BsLa6BiIW0ScfzrLMgyhKKX8SY13BqBhTI=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Jon Maloy <jmaloy@redhat.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] tipc: stop tipc crypto on failure in tipc_node_create
Date:   Tue, 25 Jul 2023 21:36:44 +0300
Message-ID: <20230725183646.5668-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tipc_link_bc_create() fails inside tipc_node_create() for a newly
allocated tipc node then we should stop its tipc crypto and free the
resources allocated with a call to tipc_crypto_start().

Call tipc_crypto_stop() in that case. Also extract the similar error exit
paths into a goto statement.

Found by Linux Verification Center (linuxtesting.org).

Fixes: cb8092d70a6f ("tipc: move bc link creation back to tipc_node_create")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/tipc/node.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 5e000fde8067..0d64005a803b 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -546,9 +546,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 #ifdef CONFIG_TIPC_CRYPTO
 	if (unlikely(tipc_crypto_start(&n->crypto_rx, net, n))) {
 		pr_warn("Failed to start crypto RX(%s)!\n", n->peer_id_string);
-		kfree(n);
-		n = NULL;
-		goto exit;
+		goto free_node;
 	}
 #endif
 	n->addr = addr;
@@ -583,9 +581,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
-		n = NULL;
-		goto exit;
+		goto stop_crypto;
 	}
 	tipc_node_get(n);
 	timer_setup(&n->timer, tipc_node_timeout, 0);
@@ -610,6 +606,15 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 exit:
 	spin_unlock_bh(&tn->node_list_lock);
 	return n;
+stop_crypto:
+
+#ifdef CONFIG_TIPC_CRYPTO
+	tipc_crypto_stop(&n->crypto_rx);
+free_node:
+#endif
+	kfree(n);
+	spin_unlock_bh(&tn->node_list_lock);
+	return NULL;
 }
 
 static void tipc_node_calculate_timer(struct tipc_node *n, struct tipc_link *l)
-- 
2.41.0

