Return-Path: <linux-kernel+bounces-93147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B1872B90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C78B290C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD331DA2F;
	Wed,  6 Mar 2024 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiaHqOOD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66191D531
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683654; cv=none; b=rZ5psXB6XHmlBA9x5CkSQy8JIrJ9N3JJfLB1s/m7bN1fs+iUEMGx2Ubqtx5Bdjt5ko1jK3+omcXJTRchhgSoJwjVqFMXSgm+nyN+XKbuz0LNiy1EcqDLBzInuJi1SPJzvuAQOqXVjS/5tIUHwsZ9ZWZ+gOBZO+FfpdnkV/BVofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683654; c=relaxed/simple;
	bh=JSAb75K5u7gBHHU2jfoUTctUJDfxxq41wkWofdDPz0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6and8vU+wwjL+/Tyw/fuM+p1APbTrS1pQwbgdoD6j3sYcvantZ6P6r9gtr5T6ELIbjel7ElVrZ8xhnJ8shDXQY6uqD2DB2mdAaF/iGukHsR+ox2H0MoCAjzP4+IHnUWPrPQUZiBExVGHl3pNOZIpQpHys7Qv0bVLgg9Im77Nb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiaHqOOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=au5j5ZW3rj6O9c0BmuDpUr2RzwJwFV//kP+rZhiY3eA=;
	b=XiaHqOODYMbxdEWxvb0YUfbLOYfQ6WVliUx3NudNKNJF4/MkSaI6eW1oL9GvPBy7vMaim8
	86BdYeXiWhz1LeTgrWgs6VbWkcmmkzTpkZAqWXaUx5jCWXnNEkzAaXKU4NMGQFDvX98Fdh
	QcQxrzDHOQkaFeUjeaj2i2TyixiBo+w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-olyePcLfNuSQhqMe3SzCHQ-1; Tue,
 05 Mar 2024 19:07:27 -0500
X-MC-Unique: olyePcLfNuSQhqMe3SzCHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 151683C0244F;
	Wed,  6 Mar 2024 00:07:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7A582022BD2;
	Wed,  6 Mar 2024 00:07:25 +0000 (UTC)
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
Subject: [PATCH net-next v3 13/21] rxrpc: Use rxrpc_txbuf::kvec[0] instead of rxrpc_txbuf::wire
Date: Wed,  6 Mar 2024 00:06:43 +0000
Message-ID: <20240306000655.1100294-14-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Use rxrpc_txbuf::kvec[0] instead of rxrpc_txbuf::wire to gain access to the
Rx protocol header.  In future, the wire header will be stored in a page
frag, not in the rxrpc_txbuf struct making it possible to use
MSG_SPLICE_PAGES when sending it.

Similarly, access the ack header as being immediately after the wire header
when filling out an ACK packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Remove unused variable.

 net/rxrpc/ar-internal.h |  5 +--
 net/rxrpc/output.c      | 79 ++++++++++++++++++++---------------------
 net/rxrpc/txbuf.c       | 27 +++++++-------
 3 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a8795ef0d669..9ea4e7e9d9f7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -804,6 +804,7 @@ struct rxrpc_txbuf {
 #define RXRPC_TXBUF_WIRE_FLAGS	0xff		/* The wire protocol flags */
 #define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
 	__be16			cksum;		/* Checksum to go in header */
+	unsigned short		ack_rwind;	/* ACK receive window */
 	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
 	u8			nr_kvec;
 	struct kvec		kvec[1];
@@ -812,11 +813,11 @@ struct rxrpc_txbuf {
 		 * that data[] aligns correctly for any crypto blocksize.
 		 */
 		u8		pad[64 - sizeof(struct rxrpc_wire_header)];
-		struct rxrpc_wire_header wire;	/* Network-ready header */
+		struct rxrpc_wire_header _wire;	/* Network-ready header */
 		union {
 			u8	data[RXRPC_JUMBO_DATALEN]; /* Data packet */
 			struct {
-				struct rxrpc_ackpacket ack;
+				struct rxrpc_ackpacket _ack;
 				DECLARE_FLEX_ARRAY(u8, acks);
 			};
 		};
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ec9ae9c6c492..5398aa24bb8e 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -77,11 +77,13 @@ static void rxrpc_set_keepalive(struct rxrpc_call *call)
 /*
  * Fill out an ACK packet.
  */
-static void rxrpc_fill_out_ack(struct rxrpc_connection *conn,
-			       struct rxrpc_call *call,
+static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 			       struct rxrpc_txbuf *txb,
-			       u16 *_rwind)
+			       u8 ack_reason,
+			       rxrpc_serial_t serial)
 {
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
 	struct rxrpc_acktrailer trailer;
 	unsigned int qsize, sack, wrap, to;
 	rxrpc_seq_t window, wtop;
@@ -97,15 +99,24 @@ static void rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 	window = call->ackr_window;
 	wtop   = call->ackr_wtop;
 	sack   = call->ackr_sack_base % RXRPC_SACK_SIZE;
-	txb->ack.firstPacket = htonl(window);
-	txb->ack.nAcks = wtop - window;
+
+	whdr->seq		= 0;
+	whdr->type		= RXRPC_PACKET_TYPE_ACK;
+	txb->flags		|= RXRPC_SLOW_START_OK;
+	ack->bufferSpace	= 0;
+	ack->maxSkew		= 0;
+	ack->firstPacket	= htonl(window);
+	ack->previousPacket	= htonl(call->rx_highest_seq);
+	ack->serial		= htonl(serial);
+	ack->reason		= ack_reason;
+	ack->nAcks		= wtop - window;
 
 	if (after(wtop, window)) {
 		wrap = RXRPC_SACK_SIZE - sack;
-		to = min_t(unsigned int, txb->ack.nAcks, RXRPC_SACK_SIZE);
+		to = min_t(unsigned int, ack->nAcks, RXRPC_SACK_SIZE);
 
-		if (sack + txb->ack.nAcks <= RXRPC_SACK_SIZE) {
-			memcpy(txb->acks, call->ackr_sack_table + sack, txb->ack.nAcks);
+		if (sack + ack->nAcks <= RXRPC_SACK_SIZE) {
+			memcpy(txb->acks, call->ackr_sack_table + sack, ack->nAcks);
 		} else {
 			memcpy(txb->acks, call->ackr_sack_table + sack, wrap);
 			memcpy(txb->acks + wrap, call->ackr_sack_table,
@@ -115,16 +126,16 @@ static void rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 		ackp += to;
 	} else if (before(wtop, window)) {
 		pr_warn("ack window backward %x %x", window, wtop);
-	} else if (txb->ack.reason == RXRPC_ACK_DELAY) {
-		txb->ack.reason = RXRPC_ACK_IDLE;
+	} else if (ack->reason == RXRPC_ACK_DELAY) {
+		ack->reason = RXRPC_ACK_IDLE;
 	}
 
-	mtu = conn->peer->if_mtu;
-	mtu -= conn->peer->hdrsize;
+	mtu = call->peer->if_mtu;
+	mtu -= call->peer->hdrsize;
 	jmax = rxrpc_rx_jumbo_max;
 	qsize = (window - 1) - call->rx_consumed;
 	rsize = max_t(int, call->rx_winsize - qsize, 0);
-	*_rwind = rsize;
+	txb->ack_rwind		= rsize;
 	trailer.maxMTU		= htonl(rxrpc_rx_mtu);
 	trailer.ifMTU		= htonl(mtu);
 	trailer.rwind		= htonl(rsize);
@@ -134,8 +145,7 @@ static void rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 	*ackp++ = 0;
 	*ackp++ = 0;
 	memcpy(ackp, &trailer, sizeof(trailer));
-	txb->kvec[0].iov_len = sizeof(txb->wire) +
-		sizeof(txb->ack) + txb->ack.nAcks + 3 + sizeof(trailer);
+	txb->kvec[0].iov_len += sizeof(*ack) + ack->nAcks + 3 + sizeof(trailer);
 	txb->len = txb->kvec[0].iov_len;
 }
 
@@ -187,10 +197,11 @@ static void rxrpc_cancel_rtt_probe(struct rxrpc_call *call,
  */
 static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_connection *conn;
+	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
 	struct msghdr msg;
 	int ret, rtt_slot = -1;
-	u16 rwind;
 
 	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
 		return -ECONNRESET;
@@ -203,27 +214,22 @@ static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *tx
 	msg.msg_controllen = 0;
 	msg.msg_flags	= 0;
 
-	if (txb->ack.reason == RXRPC_ACK_PING)
+	if (ack->reason == RXRPC_ACK_PING)
 		txb->flags |= RXRPC_REQUEST_ACK;
-	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
-
-	rxrpc_fill_out_ack(conn, call, txb, &rwind);
+	whdr->flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 
 	txb->serial = rxrpc_get_next_serial(conn);
-	txb->wire.serial = htonl(txb->serial);
+	whdr->serial = htonl(txb->serial);
 	trace_rxrpc_tx_ack(call->debug_id, txb->serial,
-			   ntohl(txb->ack.firstPacket),
-			   ntohl(txb->ack.serial), txb->ack.reason, txb->ack.nAcks,
-			   rwind);
+			   ntohl(ack->firstPacket),
+			   ntohl(ack->serial), ack->reason, ack->nAcks,
+			   txb->ack_rwind);
 
-	if (txb->ack.reason == RXRPC_ACK_PING)
+	if (ack->reason == RXRPC_ACK_PING)
 		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_ping);
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 
-	/* Grab the highest received seq as late as possible */
-	txb->ack.previousPacket	= htonl(call->rx_highest_seq);
-
 	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, txb->len);
 	rxrpc_local_dont_fragment(conn->local, false);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, txb->len);
@@ -232,7 +238,7 @@ static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *tx
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
 				    rxrpc_tx_point_call_ack);
 	} else {
-		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
+		trace_rxrpc_tx_packet(call->debug_id, whdr,
 				      rxrpc_tx_point_call_ack);
 		if (txb->flags & RXRPC_REQUEST_ACK)
 			call->peer->rtt_last_req = ktime_get_real();
@@ -268,18 +274,9 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 		return;
 	}
 
-	txb->ack_why		= why;
-	txb->wire.seq		= 0;
-	txb->wire.type		= RXRPC_PACKET_TYPE_ACK;
-	txb->flags		|= RXRPC_SLOW_START_OK;
-	txb->ack.bufferSpace	= 0;
-	txb->ack.maxSkew	= 0;
-	txb->ack.firstPacket	= 0;
-	txb->ack.previousPacket	= 0;
-	txb->ack.serial		= htonl(serial);
-	txb->ack.reason		= ack_reason;
-	txb->ack.nAcks		= 0;
+	rxrpc_fill_out_ack(call, txb, ack_reason, serial);
 
+	txb->ack_why = why;
 	trace_rxrpc_send_ack(call, why, ack_reason, serial);
 	rxrpc_send_ack_packet(call, txb);
 	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
@@ -365,7 +362,7 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 
 	if (test_bit(RXRPC_CONN_PROBING_FOR_UPGRADE, &conn->flags) &&
 	    txb->seq == 1)
-		txb->wire.userStatus = RXRPC_USERSTATUS_SERVICE_UPGRADE;
+		whdr->userStatus = RXRPC_USERSTATUS_SERVICE_UPGRADE;
 
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 91e96cda6dc7..2e8c5b15a84f 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -19,10 +19,13 @@ atomic_t rxrpc_nr_txbuf;
 struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 				      gfp_t gfp)
 {
+	struct rxrpc_wire_header *whdr;
 	struct rxrpc_txbuf *txb;
 
 	txb = kmalloc(sizeof(*txb), gfp);
 	if (txb) {
+		whdr = &txb->_wire;
+
 		INIT_LIST_HEAD(&txb->call_link);
 		INIT_LIST_HEAD(&txb->tx_link);
 		refcount_set(&txb->ref, 1);
@@ -37,18 +40,18 @@ struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 		txb->serial		= 0;
 		txb->cksum		= 0;
 		txb->nr_kvec		= 1;
-		txb->kvec[0].iov_base	= &txb->wire;
-		txb->kvec[0].iov_len	= sizeof(txb->wire);
-		txb->wire.epoch		= htonl(call->conn->proto.epoch);
-		txb->wire.cid		= htonl(call->cid);
-		txb->wire.callNumber	= htonl(call->call_id);
-		txb->wire.seq		= htonl(txb->seq);
-		txb->wire.type		= packet_type;
-		txb->wire.flags		= 0;
-		txb->wire.userStatus	= 0;
-		txb->wire.securityIndex	= call->security_ix;
-		txb->wire._rsvd		= 0;
-		txb->wire.serviceId	= htons(call->dest_srx.srx_service);
+		txb->kvec[0].iov_base	= whdr;
+		txb->kvec[0].iov_len	= sizeof(*whdr);
+		whdr->epoch		= htonl(call->conn->proto.epoch);
+		whdr->cid		= htonl(call->cid);
+		whdr->callNumber	= htonl(call->call_id);
+		whdr->seq		= htonl(txb->seq);
+		whdr->type		= packet_type;
+		whdr->flags		= 0;
+		whdr->userStatus	= 0;
+		whdr->securityIndex	= call->security_ix;
+		whdr->_rsvd		= 0;
+		whdr->serviceId		= htons(call->dest_srx.srx_service);
 
 		trace_rxrpc_txbuf(txb->debug_id,
 				  txb->call_debug_id, txb->seq, 1,


