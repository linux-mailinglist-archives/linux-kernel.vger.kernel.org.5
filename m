Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA17D8C55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjJZXuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5858590
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698364207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XraPJHpUz3iHlmRFAu43bZXLN3dhZLOzZ/zFKxawxmE=;
        b=KlY7IfFCcL0fAXb5V7AAM/d0dqdubAIr3NBjF93npaUW+/ZLcQ7e7N6mnKFx3XCMxJz32g
        TOV7gXIJTPuJcEnKenyPCwNE61gJPVdChZWlgAR/0Enf4Cl1wIYgWYC2mVoCXeUiTPEcn+
        MlnMH6XuKHp92BOVsaQBxGxYwq8n4IE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-_7LOw04eNOKN3_h6Jv-UZA-1; Thu, 26 Oct 2023 19:49:36 -0400
X-MC-Unique: _7LOw04eNOKN3_h6Jv-UZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F484811E7D;
        Thu, 26 Oct 2023 23:49:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083661121319;
        Thu, 26 Oct 2023 23:49:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix two connection reaping bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <783910.1698364174.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 27 Oct 2023 00:49:34 +0100
Message-ID: <783911.1698364174@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    =

Fix two connection reaping bugs:

 (1) rxrpc_connection_expiry is in units of seconds, so
     rxrpc_disconnect_call() needs to multiply it by HZ when adding it to
     jiffies.

 (2) rxrpc_client_conn_reap_timeout() should set RXRPC_CLIENT_REAP_TIMER i=
f
     local->kill_all_client_conns is clear, not if it is set (in which cas=
e
     we don't need the timer).  Without this, old client connections don't
     get cleaned up until the local endpoint is cleaned up.

Fixes: 5040011d073d ("rxrpc: Make the local endpoint hold a ref on a conne=
cted call")
Fixes: 0d6bf319bc5a ("rxrpc: Move the client conn cache management to the =
I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/conn_object.c  |    2 +-
 net/rxrpc/local_object.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index ac85d4644a3c..df8a271948a1 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -212,7 +212,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 		conn->idle_timestamp =3D jiffies;
 		if (atomic_dec_and_test(&conn->active))
 			rxrpc_set_service_reap_timer(conn->rxnet,
-						     jiffies + rxrpc_connection_expiry);
+						     jiffies + rxrpc_connection_expiry * HZ);
 	}
 =

 	rxrpc_put_call(call, rxrpc_call_put_io_thread);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 7d910aee4f8c..c553a30e9c83 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -87,7 +87,7 @@ static void rxrpc_client_conn_reap_timeout(struct timer_=
list *timer)
 	struct rxrpc_local *local =3D
 		container_of(timer, struct rxrpc_local, client_conn_reap_timer);
 =

-	if (local->kill_all_client_conns &&
+	if (!local->kill_all_client_conns &&
 	    test_and_set_bit(RXRPC_CLIENT_CONN_REAP_TIMER, &local->client_conn_f=
lags))
 		rxrpc_wake_up_io_thread(local);
 }

