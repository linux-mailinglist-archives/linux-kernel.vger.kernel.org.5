Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FBA7EE122
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjKPNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKPNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C71AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amx7SkdxhyQZBIZGSORR2hEtLgqQ9WgEbAgze3egzOA=;
        b=aN4//HQ20gc1T0/0nGjCxvk0gGgNnnhPTzvh/PoLrYgcapj4rFJDuqZxoV6sr/zPsuJBSM
        0S2g+lyqw0TZgLQq3STANA8VAEc3ASq3Z53ZtJgFh7EsOWWTDbSxR8mOyWckjDtQBJ1EkJ
        LcSVmzRAaiR88vRhxGNJv1N/VP4Ns94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ujvchDHtOmae_nRX8S1YUw-1; Thu, 16 Nov 2023 08:13:05 -0500
X-MC-Unique: ujvchDHtOmae_nRX8S1YUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6704D811E7D;
        Thu, 16 Nov 2023 13:13:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5431121306;
        Thu, 16 Nov 2023 13:13:04 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] rxrpc: Fix RTT determination to use any ACK as a source
Date:   Thu, 16 Nov 2023 13:12:58 +0000
Message-ID: <20231116131259.103513-2-dhowells@redhat.com>
In-Reply-To: <20231116131259.103513-1-dhowells@redhat.com>
References: <20231116131259.103513-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix RTT determination to be able to use any type of ACK as the response
from which RTT can be calculated provided its ack.serial is non-zero and
matches the serial number of an outgoing DATA or ACK packet.  This
shouldn't be limited to REQUESTED-type ACKs as these can have other types
substituted for them for things like duplicate or out-of-order packets.

Fixes: 4700c4d80b7b ("rxrpc: Fix loss of RTT samples due to interposed ACK")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/input.c            | 35 ++++++++++++++++-------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4c53a5ef6257..f7e537f64db4 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -328,7 +328,7 @@
 	E_(rxrpc_rtt_tx_ping,			"PING")
 
 #define rxrpc_rtt_rx_traces \
-	EM(rxrpc_rtt_rx_cancel,			"CNCL") \
+	EM(rxrpc_rtt_rx_other_ack,		"OACK") \
 	EM(rxrpc_rtt_rx_obsolete,		"OBSL") \
 	EM(rxrpc_rtt_rx_lost,			"LOST") \
 	EM(rxrpc_rtt_rx_ping_response,		"PONG") \
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 030d64f282f3..3f9594d12519 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -643,12 +643,8 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 			clear_bit(i + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
 			smp_mb(); /* Read data before setting avail bit */
 			set_bit(i, &call->rtt_avail);
-			if (type != rxrpc_rtt_rx_cancel)
-				rxrpc_peer_add_rtt(call, type, i, acked_serial, ack_serial,
-						   sent_at, resp_time);
-			else
-				trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_cancel, i,
-						   orig_serial, acked_serial, 0, 0);
+			rxrpc_peer_add_rtt(call, type, i, acked_serial, ack_serial,
+					   sent_at, resp_time);
 			matched = true;
 		}
 
@@ -801,20 +797,21 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 			   summary.ack_reason, nr_acks);
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[ack.reason]);
 
-	switch (ack.reason) {
-	case RXRPC_ACK_PING_RESPONSE:
-		rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-					 rxrpc_rtt_rx_ping_response);
-		break;
-	case RXRPC_ACK_REQUESTED:
-		rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-					 rxrpc_rtt_rx_requested_ack);
-		break;
-	default:
-		if (acked_serial != 0)
+	if (acked_serial != 0) {
+		switch (ack.reason) {
+		case RXRPC_ACK_PING_RESPONSE:
 			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-						 rxrpc_rtt_rx_cancel);
-		break;
+						 rxrpc_rtt_rx_ping_response);
+			break;
+		case RXRPC_ACK_REQUESTED:
+			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
+						 rxrpc_rtt_rx_requested_ack);
+			break;
+		default:
+			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
+						 rxrpc_rtt_rx_other_ack);
+			break;
+		}
 	}
 
 	if (ack.reason == RXRPC_ACK_PING) {

