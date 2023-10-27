Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8E7D948F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbjJ0KAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjJ0KAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A91B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698400791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TZ0xtpqTEhLFnw9/Pr4Oy+UYb54uDvsk+Fp9NNzZ9YA=;
        b=NwEs+7qNj/l57lPvn1GVV7achjLaDCjckO/GvWCPzVFHDwPxPZ7yptC2ZS3vKY8AV7XgVn
        vWKiqBSeUPGIkP3M76pMtz8FqIPN+0wnOnjc7XMZlEWbxIIMOJM+/zfu/n9zJyIvEBxBUL
        w9sSvQqbqjfENP9EVfuLeyHBXagET+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-a1feGKiGP7Gl7wRQ1yLo5w-1; Fri, 27 Oct 2023 05:59:46 -0400
X-MC-Unique: a1feGKiGP7Gl7wRQ1yLo5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46FD08966A6;
        Fri, 27 Oct 2023 09:59:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id C5C1F1121319;
        Fri, 27 Oct 2023 09:59:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Oct 2023 11:58:45 +0200 (CEST)
Date:   Fri, 27 Oct 2023 11:58:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather than
 read_seqbegin_or_lock()
Message-ID: <20231027095842.GA30868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_seqbegin_or_lock() makes no sense unless you make "seq" odd
after the lockless access failed. See thread_group_cputime() as
an example, note that it does nextseq = 1 for the 2nd round.

So this code can use read_seqbegin() without changing the current
behaviour.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 net/rxrpc/conn_service.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 89ac05a711a4..bfafe58681d9 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -25,7 +25,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -35,7 +35,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
-		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
+		seq = read_seqbegin(&peer->service_conn_lock);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);
 		while (p) {
@@ -49,9 +49,8 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 				break;
 			conn = NULL;
 		}
-	} while (need_seqretry(&peer->service_conn_lock, seq));
+	} while (read_seqretry(&peer->service_conn_lock, seq));
 
-	done_seqretry(&peer->service_conn_lock, seq);
 	_leave(" = %d", conn ? conn->debug_id : -1);
 	return conn;
 }
-- 
2.25.1.362.g51ebf55


