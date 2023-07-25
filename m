Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1C7624BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGYVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGYVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:46:50 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B81FDD;
        Tue, 25 Jul 2023 14:46:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3EF0A40737C9;
        Tue, 25 Jul 2023 21:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3EF0A40737C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1690321607;
        bh=wQZ+lrRE3oQnyK31lwk/xK6Rt/iFePrIWTkSITlap1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IapLk/WzMzB0LeUX1/U399YIXAH67f1o/o+ul/kZh3sDQszDWnGpRnvWqMQitoDL6
         rj47I66xhQJk/BzORiThu7kwqOF2Hp1ocIhjFxYqINMdRypPVgFMQ8mZHN+u8TQ3c1
         T15pDjqUfi8l/5xtFokIbvL0i7JzGS8LmNwODVRk=
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
Subject: [PATCH v2] tipc: stop tipc crypto on failure in tipc_node_create
Date:   Wed, 26 Jul 2023 00:46:25 +0300
Message-ID: <20230725214628.25246-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cyninzffkwhc7mqbxpwhhpm7bav67tp7a7rqkpeu5bh3kafbyo@wx3q2x5nm3he>
References: 
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

As the node ref is initialized to one to that point, just put the ref on
tipc_link_bc_create() error case that would lead to tipc_node_free() be
eventually executed and properly clean the node and its crypto resources.

Found by Linux Verification Center (linuxtesting.org).

Fixes: cb8092d70a6f ("tipc: move bc link creation back to tipc_node_create")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v1->v2: simplify the patch per Xin Long's advice: putting the ref on error
case would solve the problem more conveniently; update the patch
description accordingly.

 net/tipc/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 5e000fde8067..a9c5b6594889 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -583,7 +583,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
+		tipc_node_put(n);
 		n = NULL;
 		goto exit;
 	}
-- 
2.41.0

