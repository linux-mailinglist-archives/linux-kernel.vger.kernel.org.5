Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6873B7EE126
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjKPNNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKPNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F38D56
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pni06L1Erygx16Uv1x1PI2n1eAvBA/ceTvUPGaZmGjw=;
        b=EnucxyMqfplZsKGIswrfuxvUBdYtWSFqSW8AUG3ynyH51LCQLi/t5eLwYOfow77Eqb6c1w
        Ro/MaFJ2UuFuWksuV9GVKm/Fqc5COoWTtc98pvxKaXdgEcYqmWgZNXN4gWCY/gxohU3hHw
        8sN4an6NMQIzBpLISEPfmqiUcVRtd/Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-5lcP13W_Nei-aSb7UBKm-Q-1; Thu,
 16 Nov 2023 08:13:07 -0500
X-MC-Unique: 5lcP13W_Nei-aSb7UBKm-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541263C14903;
        Thu, 16 Nov 2023 13:13:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5EF2026D66;
        Thu, 16 Nov 2023 13:13:06 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] rxrpc: Defer the response to a PING ACK until we've parsed it
Date:   Thu, 16 Nov 2023 13:12:59 +0000
Message-ID: <20231116131259.103513-3-dhowells@redhat.com>
In-Reply-To: <20231116131259.103513-1-dhowells@redhat.com>
References: <20231116131259.103513-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer the generation of a PING RESPONSE ACK in response to a PING ACK until
we've parsed the PING ACK so that we pick up any changes to the packet
queue so that we can update ackinfo.

This is also applied to an ACK generated in response to an ACK with the
REQUEST_ACK flag set.

Note that whilst the problem was added in commit 248f219cb8bc, it didn't
really matter at that point because the ACK was proposed in softirq mode
and generated asynchronously later in process context, taking the latest
values at the time.  But this fix is only needed since the move to parse
incoming packets in an I/O thread rather than in softirq and generate the
ACK at point of proposal (b0346843b1076b34a0278ff601f8f287535cb064).

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/input.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 3f9594d12519..92495e73b869 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -814,14 +814,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		}
 	}
 
-	if (ack.reason == RXRPC_ACK_PING) {
-		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, ack_serial,
-			       rxrpc_propose_ack_respond_to_ping);
-	} else if (sp->hdr.flags & RXRPC_REQUEST_ACK) {
-		rxrpc_send_ACK(call, RXRPC_ACK_REQUESTED, ack_serial,
-			       rxrpc_propose_ack_respond_to_ack);
-	}
-
 	/* If we get an EXCEEDS_WINDOW ACK from the server, it probably
 	 * indicates that the client address changed due to NAT.  The server
 	 * lost the call because it switched to a different peer.
@@ -832,7 +824,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	    rxrpc_is_client_call(call)) {
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
 					  0, -ENETRESET);
-		return;
+		goto send_response;
 	}
 
 	/* If we get an OUT_OF_SEQUENCE ACK from the server, that can also
@@ -846,7 +838,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	    rxrpc_is_client_call(call)) {
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
 					  0, -ENETRESET);
-		return;
+		goto send_response;
 	}
 
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
@@ -854,7 +846,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		trace_rxrpc_rx_discard_ack(call->debug_id, ack_serial,
 					   first_soft_ack, call->acks_first_seq,
 					   prev_pkt, call->acks_prev_seq);
-		return;
+		goto send_response;
 	}
 
 	info.rxMTU = 0;
@@ -894,7 +886,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		break;
 	default:
-		return;
+		goto send_response;
 	}
 
 	if (before(hard_ack, call->acks_hard_ack) ||
@@ -906,7 +898,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (after(hard_ack, call->acks_hard_ack)) {
 		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
 			rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ack);
-			return;
+			goto send_response;
 		}
 	}
 
@@ -924,6 +916,14 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 				   rxrpc_propose_ack_ping_for_lost_reply);
 
 	rxrpc_congestion_management(call, skb, &summary, acked_serial);
+
+send_response:
+	if (ack.reason == RXRPC_ACK_PING)
+		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, ack_serial,
+			       rxrpc_propose_ack_respond_to_ping);
+	else if (sp->hdr.flags & RXRPC_REQUEST_ACK)
+		rxrpc_send_ACK(call, RXRPC_ACK_REQUESTED, ack_serial,
+			       rxrpc_propose_ack_respond_to_ack);
 }
 
 /*

