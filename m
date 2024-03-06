Return-Path: <linux-kernel+bounces-93135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA51872B78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C99BB22378
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0696846B;
	Wed,  6 Mar 2024 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUEIk4Hv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F1646
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683629; cv=none; b=rhvs7t8GjZLLrQQ76PoSmpf/Qv8VfxNNkfx4oti0mAeNRrtzM5uW/n7u4no8aTaeTffayqE5lW0EG3GdrtagxlG/4GXG0fCO5HWuKXLHIlx8S2wCg+AGkr8WY/FFYUE9atqw1JHqmFwxd9Zjs12Np6y6eWUbCTu7tbqYn/vFGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683629; c=relaxed/simple;
	bh=buGQQIqwfDOjT2V25LdvmamRLILtg2fDY6qrTYz9e6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBC2LTbacvJQeMrx90xv7JcZx3rgP0OT/26jVyFNZsQ5ODY021ddLVFvuLNsDrtHd0KpW0if5DxDU4y7Xi6g3GjZp8pXjsjEyBhoAHRfH/i1mK1xkP7xQgIfjlfuxsmI5P76m0zJnn5QfmQdWu66KPlGjsMOXH4IAAOLFEe3Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUEIk4Hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SInqaLs7+HuZGhZ5JkGiSMY+PTSraJJ+xEdb815D0Ac=;
	b=CUEIk4HvH7GyVwBVmRR2zfMGuQ+mfsI4lYRR2O0DDbjFO3btlCTUhgrOFf7PQhZ76YC43g
	4HnsFxoUkY18wrQPwnzi5hJM8kh85AZ+we52c7YZQhEig2TebJTwTCWJZWhQJLNITHxF1u
	PCt23ikgBxCFSo9YoCgqbKiubFo5TrU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-NCA8E2K_NOiSguKHB664pQ-1; Tue,
 05 Mar 2024 19:07:03 -0500
X-MC-Unique: NCA8E2K_NOiSguKHB664pQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BEB2380009F;
	Wed,  6 Mar 2024 00:07:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B82B416A9B;
	Wed,  6 Mar 2024 00:07:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 01/21] rxrpc: Record the Tx serial in the rxrpc_txbuf and retransmit trace
Date: Wed,  6 Mar 2024 00:06:31 +0000
Message-ID: <20240306000655.1100294-2-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Each Rx protocol packet contains a per-connection monotonically increasing
serial number used to correlate outgoing messages with their replies -
something that can be used for RTT calculation.

Note this value in the rxrpc_txbuf struct in addition to the wire header
and then log it in the rxrpc_retransmit trace for reference.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 10 +++++++---
 net/rxrpc/ar-internal.h      |  1 +
 net/rxrpc/call_event.c       |  6 +++---
 net/rxrpc/output.c           | 36 +++++++++++++++++-------------------
 net/rxrpc/txbuf.c            |  1 +
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 87b8de9b6c1c..9add56980485 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1506,25 +1506,29 @@ TRACE_EVENT(rxrpc_drop_ack,
 	    );
 
 TRACE_EVENT(rxrpc_retransmit,
-	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq, s64 expiry),
+	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
+		     rxrpc_serial_t serial, s64 expiry),
 
-	    TP_ARGS(call, seq, expiry),
+	    TP_ARGS(call, seq, serial, expiry),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
 		    __field(rxrpc_seq_t,	seq)
+		    __field(rxrpc_serial_t,	serial)
 		    __field(s64,		expiry)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
 		    __entry->seq = seq;
+		    __entry->serial = serial;
 		    __entry->expiry = expiry;
 			   ),
 
-	    TP_printk("c=%08x q=%x xp=%lld",
+	    TP_printk("c=%08x q=%x r=%x xp=%lld",
 		      __entry->call,
 		      __entry->seq,
+		      __entry->serial,
 		      __entry->expiry)
 	    );
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 7818aae1be8e..f76125755810 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -794,6 +794,7 @@ struct rxrpc_txbuf {
 	ktime_t			last_sent;	/* Time at which last transmitted */
 	refcount_t		ref;
 	rxrpc_seq_t		seq;		/* Sequence number of this packet */
+	rxrpc_serial_t		serial;		/* Last serial number transmitted with */
 	unsigned int		call_debug_id;
 	unsigned int		debug_id;
 	unsigned int		len;		/* Amount of data in buffer */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 0f78544d043b..a4c309976719 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -160,7 +160,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 			goto no_further_resend;
 
 		found_txb:
-			if (after(ntohl(txb->wire.serial), call->acks_highest_serial))
+			if (after(txb->serial, call->acks_highest_serial))
 				continue; /* Ack point not yet reached */
 
 			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
@@ -170,7 +170,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 				set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
 			}
 
-			trace_rxrpc_retransmit(call, txb->seq,
+			trace_rxrpc_retransmit(call, txb->seq, txb->serial,
 					       ktime_to_ns(ktime_sub(txb->last_sent,
 								     max_age)));
 
@@ -197,7 +197,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 			break; /* Not transmitted yet */
 
 		if (ack && ack->reason == RXRPC_ACK_PING_RESPONSE &&
-		    before(ntohl(txb->wire.serial), ntohl(ack->serial)))
+		    before(txb->serial, ntohl(ack->serial)))
 			goto do_resend; /* Wasn't accounted for by a more recent ping. */
 
 		if (ktime_after(txb->last_sent, max_age)) {
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 4a292f860ae3..bad96a983e12 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -189,7 +189,6 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	struct rxrpc_connection *conn;
 	struct msghdr msg;
 	struct kvec iov[1];
-	rxrpc_serial_t serial;
 	size_t len, n;
 	int ret, rtt_slot = -1;
 	u16 rwind;
@@ -216,15 +215,15 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	iov[0].iov_len	= sizeof(txb->wire) + sizeof(txb->ack) + n;
 	len = iov[0].iov_len;
 
-	serial = rxrpc_get_next_serial(conn);
-	txb->wire.serial = htonl(serial);
-	trace_rxrpc_tx_ack(call->debug_id, serial,
+	txb->serial = rxrpc_get_next_serial(conn);
+	txb->wire.serial = htonl(txb->serial);
+	trace_rxrpc_tx_ack(call->debug_id, txb->serial,
 			   ntohl(txb->ack.firstPacket),
 			   ntohl(txb->ack.serial), txb->ack.reason, txb->ack.nAcks,
 			   rwind);
 
 	if (txb->ack.reason == RXRPC_ACK_PING)
-		rtt_slot = rxrpc_begin_rtt_probe(call, serial, rxrpc_rtt_tx_ping);
+		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_ping);
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 
@@ -235,7 +234,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	call->peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0) {
-		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
 				    rxrpc_tx_point_call_ack);
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
@@ -247,7 +246,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	if (!__rxrpc_call_is_complete(call)) {
 		if (ret < 0)
-			rxrpc_cancel_rtt_probe(call, serial, rtt_slot);
+			rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
 		rxrpc_set_keepalive(call);
 	}
 
@@ -327,15 +326,14 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	struct rxrpc_connection *conn = call->conn;
 	struct msghdr msg;
 	struct kvec iov[1];
-	rxrpc_serial_t serial;
 	size_t len;
 	int ret, rtt_slot = -1;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
 
-	/* Each transmission of a Tx packet needs a new serial number */
-	serial = rxrpc_get_next_serial(conn);
-	txb->wire.serial = htonl(serial);
+	/* Each transmission of a Tx packet+ needs a new serial number */
+	txb->serial = rxrpc_get_next_serial(conn);
+	txb->wire.serial = htonl(txb->serial);
 
 	if (test_bit(RXRPC_CONN_PROBING_FOR_UPGRADE, &conn->flags) &&
 	    txb->seq == 1)
@@ -388,7 +386,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		static int lose;
 		if ((lose++ & 7) == 7) {
 			ret = 0;
-			trace_rxrpc_tx_data(call, txb->seq, serial,
+			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
 					    txb->wire.flags,
 					    test_bit(RXRPC_TXBUF_RESENT, &txb->flags),
 					    true);
@@ -396,7 +394,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		}
 	}
 
-	trace_rxrpc_tx_data(call, txb->seq, serial, txb->wire.flags,
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->wire.flags,
 			    test_bit(RXRPC_TXBUF_RESENT, &txb->flags), false);
 
 	/* Track what we've attempted to transmit at least once so that the
@@ -415,7 +413,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	txb->last_sent = ktime_get_real();
 	if (txb->wire.flags & RXRPC_REQUEST_ACK)
-		rtt_slot = rxrpc_begin_rtt_probe(call, serial, rxrpc_rtt_tx_data);
+		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
 
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet
@@ -429,8 +427,8 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
-		rxrpc_cancel_rtt_probe(call, serial, rtt_slot);
-		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+		rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
+		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
 				    rxrpc_tx_point_call_data_nofrag);
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
@@ -489,7 +487,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	txb->last_sent = ktime_get_real();
 	if (txb->wire.flags & RXRPC_REQUEST_ACK)
-		rtt_slot = rxrpc_begin_rtt_probe(call, serial, rxrpc_rtt_tx_data);
+		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
 
 	switch (conn->local->srx.transport.family) {
 	case AF_INET6:
@@ -508,8 +506,8 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
-		rxrpc_cancel_rtt_probe(call, serial, rtt_slot);
-		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
+		rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
+		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
 				    rxrpc_tx_point_call_data_frag);
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index d43be8512386..f2903c81cf5b 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -34,6 +34,7 @@ struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 		txb->flags		= 0;
 		txb->ack_why		= 0;
 		txb->seq		= call->tx_prepared + 1;
+		txb->serial		= 0;
 		txb->wire.epoch		= htonl(call->conn->proto.epoch);
 		txb->wire.cid		= htonl(call->cid);
 		txb->wire.callNumber	= htonl(call->call_id);


