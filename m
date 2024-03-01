Return-Path: <linux-kernel+bounces-88718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FA86E5CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C93A1C2295B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11701134CB;
	Fri,  1 Mar 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBGe/KIn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8642E543
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311103; cv=none; b=K1yuixH8C1Q2MdXIomjYj/xtlrdbWTapr7UgkKIej7Is6F8dBuE8vLW1pGwpN08Rg2U0WROIGLS13bARPS1/1rtmWHBFp3gh+eNfeibfyKMGjhCGpO9COqYtI6FCLWyitE5VKFHz2ebbYf6+uNIDHZO5NNg9Ga66iyYN07fM5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311103; c=relaxed/simple;
	bh=JYhx7DIciqCb/UTDwB/y/lo8NilCfgSTvNbJk+2L6qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSJGOf16eGXfUecsa+StKalMPugVBG3ptQ4Q4lHp+2N0evtMr2YQrBM4TuSRXrlgq+KXSuKC7srIxZ8hkcSKxCFuG2tjlHu2uQh710KX7NgztwQhh9kujhuZ2hg+xL6Yu40Bzv8PubBbIRdXkGStbeGVCnJtRsCI+bByqInq23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBGe/KIn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOtV4ZQuN/A4A5dBF0j3j04MO7mqMmmSLmh55RKub28=;
	b=aBGe/KIn/lbpaYFxUXfImdZNaKUP4wMcYkCgOnUSFAYc5E9ERgjmOXaCd1DAPMulEMEQhQ
	gl93VlkEZ6CjZinwW+mwPigebK/H0MyP1CmfJhYy69BjD3mlYQsMprXcMDl5F8rwvoqvn6
	Qf+jBnLVAjOUN0/wa4YzQ+jtke58A3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-5SZ6XF_pPLyHtaoarFHDJA-1; Fri, 01 Mar 2024 11:38:16 -0500
X-MC-Unique: 5SZ6XF_pPLyHtaoarFHDJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52FBC859558;
	Fri,  1 Mar 2024 16:38:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18DB1492BE2;
	Fri,  1 Mar 2024 16:38:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/21] rxrpc: Convert rxrpc_txbuf::flags into a mask and don't use atomics
Date: Fri,  1 Mar 2024 16:37:34 +0000
Message-ID: <20240301163807.385573-3-dhowells@redhat.com>
In-Reply-To: <20240301163807.385573-1-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Convert the transmission buffer flags into a mask and use | and & rather
than bitops functions (atomic ops are not required as only the I/O thread
can manipulate them once submitted for transmission).

The bottom byte can then correspond directly to the Rx protocol header
flags.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 12 +++++-------
 net/rxrpc/ar-internal.h      |  8 ++++----
 net/rxrpc/call_event.c       |  8 ++++----
 net/rxrpc/input.c            |  2 +-
 net/rxrpc/output.c           | 27 +++++++++++++--------------
 net/rxrpc/sendmsg.c          | 10 ++++------
 net/rxrpc/txbuf.c            |  4 ++--
 7 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 9add56980485..33888f688325 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1084,9 +1084,9 @@ TRACE_EVENT(rxrpc_tx_packet,
 
 TRACE_EVENT(rxrpc_tx_data,
 	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
-		     rxrpc_serial_t serial, u8 flags, bool retrans, bool lose),
+		     rxrpc_serial_t serial, unsigned int flags, bool lose),
 
-	    TP_ARGS(call, seq, serial, flags, retrans, lose),
+	    TP_ARGS(call, seq, serial, flags, lose),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -1094,8 +1094,7 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __field(rxrpc_serial_t,	serial)
 		    __field(u32,		cid)
 		    __field(u32,		call_id)
-		    __field(u8,			flags)
-		    __field(bool,		retrans)
+		    __field(u16,		flags)
 		    __field(bool,		lose)
 			     ),
 
@@ -1106,7 +1105,6 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __entry->seq = seq;
 		    __entry->serial = serial;
 		    __entry->flags = flags;
-		    __entry->retrans = retrans;
 		    __entry->lose = lose;
 			   ),
 
@@ -1116,8 +1114,8 @@ TRACE_EVENT(rxrpc_tx_data,
 		      __entry->call_id,
 		      __entry->serial,
 		      __entry->seq,
-		      __entry->flags,
-		      __entry->retrans ? " *RETRANS*" : "",
+		      __entry->flags & RXRPC_TXBUF_WIRE_FLAGS,
+		      __entry->flags & RXRPC_TXBUF_RESENT ? " *RETRANS*" : "",
 		      __entry->lose ? " *LOSE*" : "")
 	    );
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index f76125755810..54d1dc97cb0f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -800,9 +800,9 @@ struct rxrpc_txbuf {
 	unsigned int		len;		/* Amount of data in buffer */
 	unsigned int		space;		/* Remaining data space */
 	unsigned int		offset;		/* Offset of fill point */
-	unsigned long		flags;
-#define RXRPC_TXBUF_LAST	0		/* Set if last packet in Tx phase */
-#define RXRPC_TXBUF_RESENT	1		/* Set if has been resent */
+	unsigned int		flags;
+#define RXRPC_TXBUF_WIRE_FLAGS	0xff		/* The wire protocol flags */
+#define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
 	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
 	struct {
 		/* The packet for encrypting and DMA'ing.  We align it such
@@ -822,7 +822,7 @@ struct rxrpc_txbuf {
 
 static inline bool rxrpc_sending_to_server(const struct rxrpc_txbuf *txb)
 {
-	return txb->wire.flags & RXRPC_CLIENT_INITIATED;
+	return txb->flags & RXRPC_CLIENT_INITIATED;
 }
 
 static inline bool rxrpc_sending_to_client(const struct rxrpc_txbuf *txb)
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index a4c309976719..77eacbfc5d45 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -84,7 +84,7 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 	txb->ack_why		= why;
 	txb->wire.seq		= 0;
 	txb->wire.type		= RXRPC_PACKET_TYPE_ACK;
-	txb->wire.flags		|= RXRPC_SLOW_START_OK;
+	txb->flags		|= RXRPC_SLOW_START_OK;
 	txb->ack.bufferSpace	= 0;
 	txb->ack.maxSkew	= 0;
 	txb->ack.firstPacket	= 0;
@@ -167,7 +167,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 
 			if (list_empty(&txb->tx_link)) {
 				list_add_tail(&txb->tx_link, &retrans_queue);
-				set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
+				txb->flags |= RXRPC_TXBUF_RESENT;
 			}
 
 			trace_rxrpc_retransmit(call, txb->seq, txb->serial,
@@ -210,7 +210,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 		unacked = true;
 		if (list_empty(&txb->tx_link)) {
 			list_add_tail(&txb->tx_link, &retrans_queue);
-			set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
+			txb->flags |= RXRPC_TXBUF_RESENT;
 			rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
 		}
 	}
@@ -320,7 +320,7 @@ static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
 		call->tx_top = txb->seq;
 		list_add_tail(&txb->call_link, &call->tx_buffer);
 
-		if (txb->wire.flags & RXRPC_LAST_PACKET)
+		if (txb->flags & RXRPC_LAST_PACKET)
 			rxrpc_close_tx_phase(call);
 
 		rxrpc_transmit_one(call, txb);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9691de00ade7..c435b50c33f4 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -212,7 +212,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 	list_for_each_entry_rcu(txb, &call->tx_buffer, call_link, false) {
 		if (before_eq(txb->seq, call->acks_hard_ack))
 			continue;
-		if (test_bit(RXRPC_TXBUF_LAST, &txb->flags)) {
+		if (txb->flags & RXRPC_LAST_PACKET) {
 			set_bit(RXRPC_CALL_TX_LAST, &call->flags);
 			rot_last = true;
 		}
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index bad96a983e12..8344ece5358a 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -205,7 +205,8 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	msg.msg_flags	= 0;
 
 	if (txb->ack.reason == RXRPC_ACK_PING)
-		txb->wire.flags |= RXRPC_REQUEST_ACK;
+		txb->flags |= RXRPC_REQUEST_ACK;
+	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 
 	n = rxrpc_fill_out_ack(conn, call, txb, &rwind);
 	if (n == 0)
@@ -239,7 +240,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
 				      rxrpc_tx_point_call_ack);
-		if (txb->wire.flags & RXRPC_REQUEST_ACK)
+		if (txb->flags & RXRPC_REQUEST_ACK)
 			call->peer->rtt_last_req = ktime_get_real();
 	}
 	rxrpc_tx_backoff(call, ret);
@@ -357,13 +358,13 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	 * service call, lest OpenAFS incorrectly send us an ACK with some
 	 * soft-ACKs in it and then never follow up with a proper hard ACK.
 	 */
-	if (txb->wire.flags & RXRPC_REQUEST_ACK)
+	if (txb->flags & RXRPC_REQUEST_ACK)
 		why = rxrpc_reqack_already_on;
-	else if (test_bit(RXRPC_TXBUF_LAST, &txb->flags) && rxrpc_sending_to_client(txb))
+	else if ((txb->flags & RXRPC_LAST_PACKET) && rxrpc_sending_to_client(txb))
 		why = rxrpc_reqack_no_srv_last;
 	else if (test_and_clear_bit(RXRPC_CALL_EV_ACK_LOST, &call->events))
 		why = rxrpc_reqack_ack_lost;
-	else if (test_bit(RXRPC_TXBUF_RESENT, &txb->flags))
+	else if (txb->flags & RXRPC_TXBUF_RESENT)
 		why = rxrpc_reqack_retrans;
 	else if (call->cong_mode == RXRPC_CALL_SLOW_START && call->cong_cwnd <= 2)
 		why = rxrpc_reqack_slow_start;
@@ -379,7 +380,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	rxrpc_inc_stat(call->rxnet, stat_why_req_ack[why]);
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
 	if (why != rxrpc_reqack_no_srv_last)
-		txb->wire.flags |= RXRPC_REQUEST_ACK;
+		txb->flags |= RXRPC_REQUEST_ACK;
 dont_set_request_ack:
 
 	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
@@ -387,15 +388,12 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		if ((lose++ & 7) == 7) {
 			ret = 0;
 			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
-					    txb->wire.flags,
-					    test_bit(RXRPC_TXBUF_RESENT, &txb->flags),
-					    true);
+					    txb->flags, true);
 			goto done;
 		}
 	}
 
-	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->wire.flags,
-			    test_bit(RXRPC_TXBUF_RESENT, &txb->flags), false);
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags, false);
 
 	/* Track what we've attempted to transmit at least once so that the
 	 * retransmission algorithm doesn't try to resend what we haven't sent
@@ -411,8 +409,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	if (txb->len >= call->peer->maxdata)
 		goto send_fragmentable;
 
+	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	txb->last_sent = ktime_get_real();
-	if (txb->wire.flags & RXRPC_REQUEST_ACK)
+	if (txb->flags & RXRPC_REQUEST_ACK)
 		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
 
 	/* send the packet by UDP
@@ -442,7 +441,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 done:
 	if (ret >= 0) {
 		call->tx_last_sent = txb->last_sent;
-		if (txb->wire.flags & RXRPC_REQUEST_ACK) {
+		if (txb->flags & RXRPC_REQUEST_ACK) {
 			call->peer->rtt_last_req = txb->last_sent;
 			if (call->peer->rtt_count > 1) {
 				unsigned long nowj = jiffies, ack_lost_at;
@@ -486,7 +485,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	_debug("send fragment");
 
 	txb->last_sent = ktime_get_real();
-	if (txb->wire.flags & RXRPC_REQUEST_ACK)
+	if (txb->flags & RXRPC_REQUEST_ACK)
 		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
 
 	switch (conn->local->srx.transport.family) {
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 5677d5690a02..25c7c1d4f4c6 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -240,7 +240,7 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 			       rxrpc_notify_end_tx_t notify_end_tx)
 {
 	rxrpc_seq_t seq = txb->seq;
-	bool last = test_bit(RXRPC_TXBUF_LAST, &txb->flags), poke;
+	bool poke, last = txb->flags & RXRPC_LAST_PACKET;
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_data);
 
@@ -394,13 +394,11 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		/* add the packet to the send queue if it's now full */
 		if (!txb->space ||
 		    (msg_data_left(msg) == 0 && !more)) {
-			if (msg_data_left(msg) == 0 && !more) {
-				txb->wire.flags |= RXRPC_LAST_PACKET;
-				__set_bit(RXRPC_TXBUF_LAST, &txb->flags);
-			}
+			if (msg_data_left(msg) == 0 && !more)
+				txb->flags |= RXRPC_LAST_PACKET;
 			else if (call->tx_top - call->acks_hard_ack <
 				 call->tx_winsize)
-				txb->wire.flags |= RXRPC_MORE_PACKETS;
+				txb->flags |= RXRPC_MORE_PACKETS;
 
 			ret = call->security->secure_packet(call, txb);
 			if (ret < 0)
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index f2903c81cf5b..48d5a8f644e5 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -31,7 +31,7 @@ struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 		txb->space		= sizeof(txb->data);
 		txb->len		= 0;
 		txb->offset		= 0;
-		txb->flags		= 0;
+		txb->flags		= call->conn->out_clientflag;
 		txb->ack_why		= 0;
 		txb->seq		= call->tx_prepared + 1;
 		txb->serial		= 0;
@@ -40,7 +40,7 @@ struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 		txb->wire.callNumber	= htonl(call->call_id);
 		txb->wire.seq		= htonl(txb->seq);
 		txb->wire.type		= packet_type;
-		txb->wire.flags		= call->conn->out_clientflag;
+		txb->wire.flags		= 0;
 		txb->wire.userStatus	= 0;
 		txb->wire.securityIndex	= call->security_ix;
 		txb->wire._rsvd		= 0;


