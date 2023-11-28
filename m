Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AC7FC896
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376338AbjK1VGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376308AbjK1VGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BED61988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A163C43391;
        Tue, 28 Nov 2023 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205587;
        bh=9ytLVkmHZqvhfNXT/1h9vXWCr39HinFs1JKWjyuBsgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUWKB/EvZSdranSeWkj3qv0jRl1NsnXnHx4GpG6Y1leyYQx9sDbOWbipKYYUTMiA5
         tTqRUBVenr2hKJoKS3Hy4Z6ZSfRGQJVTI2OprxAE6JkvhjH1qeyFk2DyUwBmgeoBoY
         P+ThFK+jrYwqouMP5G6B1ee+XRKhJSjATbnttaLmul/MzzzvJSdTNI/UeaC1lqcB+W
         hz446MDNT4Bg6AnDz2DCTJ9LO0kg0xqFrkg63Q+WeG6dulPd33atqUZhJdPQQOJqZ6
         zs4iKUJVS+aHeFPk0rNNPlHAx+Op8m+ceNsBtcMK2UtwUvcgEt+zd1dSc0sbHqJdDO
         qsAWxnmb8NCmQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 04/40] rxrpc: Fix some minor issues with bundle tracing
Date:   Tue, 28 Nov 2023 16:05:10 -0500
Message-ID: <20231128210615.875085-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0c3bd086d12d185650d095a906662593ec607bd0 ]

Fix some superficial issues with the tracing of rxrpc_bundle structs,
including:

 (1) Set the debug_id when the bundle is allocated rather than when it is
     set up so that the "NEW" trace line displays the correct bundle ID.

 (2) Show the refcount when emitting the "FREE" traceline.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 981ca5b98bcb9..1d95f8bc769fa 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -73,6 +73,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 					       gfp_t gfp)
 {
+	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle;
 
 	bundle = kzalloc(sizeof(*bundle), gfp);
@@ -85,6 +86,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);
 		bundle->service_id	= call->dest_srx.srx_service;
 		bundle->security_level	= call->security_level;
+		bundle->debug_id	= atomic_inc_return(&rxrpc_bundle_id);
 		refcount_set(&bundle->ref, 1);
 		atomic_set(&bundle->active, 1);
 		INIT_LIST_HEAD(&bundle->waiting_calls);
@@ -105,7 +107,8 @@ struct rxrpc_bundle *rxrpc_get_bundle(struct rxrpc_bundle *bundle,
 
 static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 {
-	trace_rxrpc_bundle(bundle->debug_id, 1, rxrpc_bundle_free);
+	trace_rxrpc_bundle(bundle->debug_id, refcount_read(&bundle->ref),
+			   rxrpc_bundle_free);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
 	kfree(bundle);
@@ -239,7 +242,6 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
  */
 int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 {
-	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle, *candidate;
 	struct rxrpc_local *local = call->local;
 	struct rb_node *p, **pp, *parent;
@@ -306,7 +308,6 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 	}
 
 	_debug("new bundle");
-	candidate->debug_id = atomic_inc_return(&rxrpc_bundle_id);
 	rb_link_node(&candidate->local_node, parent, pp);
 	rb_insert_color(&candidate->local_node, &local->client_bundles);
 	call->bundle = rxrpc_get_bundle(candidate, rxrpc_bundle_get_client_call);
-- 
2.42.0

