Return-Path: <linux-kernel+bounces-90232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E886FC3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580DAB21459
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120D93A1C1;
	Mon,  4 Mar 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjsinsKD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBE39876
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541842; cv=none; b=OAZSPIP+K3plXL8HKMc9AglurhQF+Lexy6SXLhNwdtwand0CWn7YfEjm53aB6SuQaU7TaAGo62yqqK2AndFLpg+1bKWSq0u+TqWx+kk++MKM1hMGyMbuaZgqF+TnmNdrp1qD2JvicjnbDAFrXemYCdebOsYivqYeshc46zQZfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541842; c=relaxed/simple;
	bh=OJcJA2NR+2/fo1YKX1vNDZR/ZNy+Z7pPwFh8+cMi/q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNWWUAh7Of/6zn+jdpLhHCYQHyvpr7bQL3nhK6zSDMUQ68mMUmdo8x2UHNBhtqz5CdNktOi3CuVpJ9rAsyqssZf6U5HAdDGMnF8E6s8r3+7i2YwncBPTAzyvE9VHFZzDz6eDIUEWjgRONnkNEwg8NvJULhar9lMiBAkAA/8brpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjsinsKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uLl3dHGB02GCDwAqlUq57TZldij+SfvwDd2Vrtxbq8=;
	b=UjsinsKD59cFUIRKthV1SXKK7kGy9j5zNPupQTprBwgSDJUskAphygq2eZDY2z/q53+lKY
	6DKoxxqrzl7FUaxLdEETAUJKf4PBLRVxCPKtpbDMW7H4iwzidxURBsRSQ6JZDIxeDKUpPC
	uOrQATCNK2KOlIUm+tQegTOcqahthlg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-q7N4skMbPZqmrR2vaiAOBg-1; Mon,
 04 Mar 2024 03:43:56 -0500
X-MC-Unique: q7N4skMbPZqmrR2vaiAOBg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC6E91C03D88;
	Mon,  4 Mar 2024 08:43:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60C49492BC8;
	Mon,  4 Mar 2024 08:43:53 +0000 (UTC)
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
Subject: [PATCH net-next v2 14/21] rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags
Date: Mon,  4 Mar 2024 08:43:11 +0000
Message-ID: <20240304084322.705539-15-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Switch from keeping the transmission buffers in the rxrpc_txbuf struct and
allocated from the slab, to allocating them using page fragment allocators
(which uses raw pages), thereby allowing them to be passed to
MSG_SPLICE_PAGES and avoid copying into the UDP buffers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h  |  32 +++----
 net/rxrpc/conn_object.c  |   4 +
 net/rxrpc/insecure.c     |  11 +--
 net/rxrpc/local_object.c |   3 +
 net/rxrpc/output.c       |  65 +++++++-------
 net/rxrpc/rxkad.c        |  47 +++++-----
 net/rxrpc/sendmsg.c      |  22 ++---
 net/rxrpc/txbuf.c        | 180 ++++++++++++++++++++++++++++++---------
 8 files changed, 219 insertions(+), 145 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9ea4e7e9d9f7..47f4689379ca 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -248,10 +248,9 @@ struct rxrpc_security {
 					struct rxrpc_key_token *);
 
 	/* Work out how much data we can store in a packet, given an estimate
-	 * of the amount of data remaining.
+	 * of the amount of data remaining and allocate a data buffer.
 	 */
-	int (*how_much_data)(struct rxrpc_call *, size_t,
-			     size_t *, size_t *, size_t *);
+	struct rxrpc_txbuf *(*alloc_txbuf)(struct rxrpc_call *call, size_t remaining, gfp_t gfp);
 
 	/* impose security on a packet */
 	int (*secure_packet)(struct rxrpc_call *, struct rxrpc_txbuf *);
@@ -292,6 +291,7 @@ struct rxrpc_local {
 	struct socket		*socket;	/* my UDP socket */
 	struct task_struct	*io_thread;
 	struct completion	io_thread_ready; /* Indication that the I/O thread started */
+	struct page_frag_cache	tx_alloc;	/* Tx control packet allocation (I/O thread only) */
 	struct rxrpc_sock	*service;	/* Service(s) listening on this endpoint */
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	struct sk_buff_head	rx_delay_queue;	/* Delay injection queue */
@@ -500,6 +500,8 @@ struct rxrpc_connection {
 	struct list_head	proc_link;	/* link in procfs list */
 	struct list_head	link;		/* link in master connection list */
 	struct sk_buff_head	rx_queue;	/* received conn-level packets */
+	struct page_frag_cache	tx_data_alloc;	/* Tx DATA packet allocation */
+	struct mutex		tx_data_alloc_lock;
 
 	struct mutex		security_lock;	/* Lock for security management */
 	const struct rxrpc_security *security;	/* applied security module */
@@ -788,7 +790,6 @@ struct rxrpc_send_params {
  * Buffer of data to be output as a packet.
  */
 struct rxrpc_txbuf {
-	struct rcu_head		rcu;
 	struct list_head	call_link;	/* Link in call->tx_sendmsg/tx_buffer */
 	struct list_head	tx_link;	/* Link in live Enc queue or Tx queue */
 	ktime_t			last_sent;	/* Time at which last transmitted */
@@ -806,22 +807,8 @@ struct rxrpc_txbuf {
 	__be16			cksum;		/* Checksum to go in header */
 	unsigned short		ack_rwind;	/* ACK receive window */
 	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
-	u8			nr_kvec;
-	struct kvec		kvec[1];
-	struct {
-		/* The packet for encrypting and DMA'ing.  We align it such
-		 * that data[] aligns correctly for any crypto blocksize.
-		 */
-		u8		pad[64 - sizeof(struct rxrpc_wire_header)];
-		struct rxrpc_wire_header _wire;	/* Network-ready header */
-		union {
-			u8	data[RXRPC_JUMBO_DATALEN]; /* Data packet */
-			struct {
-				struct rxrpc_ackpacket _ack;
-				DECLARE_FLEX_ARRAY(u8, acks);
-			};
-		};
-	} __aligned(64);
+	u8			nr_kvec;	/* Amount of kvec[] used */
+	struct kvec		kvec[3];
 };
 
 static inline bool rxrpc_sending_to_server(const struct rxrpc_txbuf *txb)
@@ -1299,8 +1286,9 @@ static inline void rxrpc_sysctl_exit(void) {}
  * txbuf.c
  */
 extern atomic_t rxrpc_nr_txbuf;
-struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
-				      gfp_t gfp);
+struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_size,
+					   size_t data_align, gfp_t gfp);
+struct rxrpc_txbuf *rxrpc_alloc_ack_txbuf(struct rxrpc_call *call, size_t sack_size);
 void rxrpc_get_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 void rxrpc_see_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 void rxrpc_put_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index df8a271948a1..0af4642aeec4 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -68,6 +68,7 @@ struct rxrpc_connection *rxrpc_alloc_connection(struct rxrpc_net *rxnet,
 		INIT_LIST_HEAD(&conn->proc_link);
 		INIT_LIST_HEAD(&conn->link);
 		mutex_init(&conn->security_lock);
+		mutex_init(&conn->tx_data_alloc_lock);
 		skb_queue_head_init(&conn->rx_queue);
 		conn->rxnet = rxnet;
 		conn->security = &rxrpc_no_security;
@@ -341,6 +342,9 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	 */
 	rxrpc_purge_queue(&conn->rx_queue);
 
+	if (conn->tx_data_alloc.va)
+		__page_frag_cache_drain(virt_to_page(conn->tx_data_alloc.va),
+					conn->tx_data_alloc.pagecnt_bias);
 	call_rcu(&conn->rcu, rxrpc_rcu_free_connection);
 }
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 34353b6e584b..f2701068ed9e 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -15,14 +15,11 @@ static int none_init_connection_security(struct rxrpc_connection *conn,
 }
 
 /*
- * Work out how much data we can put in an unsecured packet.
+ * Allocate an appropriately sized buffer for the amount of data remaining.
  */
-static int none_how_much_data(struct rxrpc_call *call, size_t remain,
-			       size_t *_buf_size, size_t *_data_size, size_t *_offset)
+static struct rxrpc_txbuf *none_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
 {
-	*_buf_size = *_data_size = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
-	*_offset = 0;
-	return 0;
+	return rxrpc_alloc_data_txbuf(call, min_t(size_t, remain, RXRPC_JUMBO_DATALEN), 0, gfp);
 }
 
 static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
@@ -79,7 +76,7 @@ const struct rxrpc_security rxrpc_no_security = {
 	.exit				= none_exit,
 	.init_connection_security	= none_init_connection_security,
 	.free_call_crypto		= none_free_call_crypto,
-	.how_much_data			= none_how_much_data,
+	.alloc_txbuf			= none_alloc_txbuf,
 	.secure_packet			= none_secure_packet,
 	.verify_packet			= none_verify_packet,
 	.respond_to_challenge		= none_respond_to_challenge,
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 34d307368135..504453c688d7 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -452,6 +452,9 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
 	rxrpc_purge_client_connections(local);
+	if (local->tx_alloc.va)
+		__page_frag_cache_drain(virt_to_page(local->tx_alloc.va),
+					local->tx_alloc.pagecnt_bias);
 }
 
 /*
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5398aa24bb8e..0a317498b8e0 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -83,18 +83,16 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 			       rxrpc_serial_t serial)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxrpc_acktrailer *trailer = txb->kvec[2].iov_base + 3;
 	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
-	struct rxrpc_acktrailer trailer;
 	unsigned int qsize, sack, wrap, to;
 	rxrpc_seq_t window, wtop;
 	int rsize;
 	u32 mtu, jmax;
-	u8 *ackp = txb->acks;
+	u8 *filler = txb->kvec[2].iov_base;
+	u8 *sackp = txb->kvec[1].iov_base;
 
-	call->ackr_nr_unacked = 0;
-	atomic_set(&call->ackr_nr_consumed, 0);
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_fill);
-	clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags);
 
 	window = call->ackr_window;
 	wtop   = call->ackr_wtop;
@@ -110,20 +108,27 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 	ack->serial		= htonl(serial);
 	ack->reason		= ack_reason;
 	ack->nAcks		= wtop - window;
+	filler[0]		= 0;
+	filler[1]		= 0;
+	filler[2]		= 0;
+
+	if (ack_reason == RXRPC_ACK_PING)
+		txb->flags |= RXRPC_REQUEST_ACK;
 
 	if (after(wtop, window)) {
+		txb->len += ack->nAcks;
+		txb->kvec[1].iov_base = sackp;
+		txb->kvec[1].iov_len = ack->nAcks;
+
 		wrap = RXRPC_SACK_SIZE - sack;
 		to = min_t(unsigned int, ack->nAcks, RXRPC_SACK_SIZE);
 
 		if (sack + ack->nAcks <= RXRPC_SACK_SIZE) {
-			memcpy(txb->acks, call->ackr_sack_table + sack, ack->nAcks);
+			memcpy(sackp, call->ackr_sack_table + sack, ack->nAcks);
 		} else {
-			memcpy(txb->acks, call->ackr_sack_table + sack, wrap);
-			memcpy(txb->acks + wrap, call->ackr_sack_table,
-			       to - wrap);
+			memcpy(sackp, call->ackr_sack_table + sack, wrap);
+			memcpy(sackp + wrap, call->ackr_sack_table, to - wrap);
 		}
-
-		ackp += to;
 	} else if (before(wtop, window)) {
 		pr_warn("ack window backward %x %x", window, wtop);
 	} else if (ack->reason == RXRPC_ACK_DELAY) {
@@ -135,18 +140,11 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 	jmax = rxrpc_rx_jumbo_max;
 	qsize = (window - 1) - call->rx_consumed;
 	rsize = max_t(int, call->rx_winsize - qsize, 0);
-	txb->ack_rwind		= rsize;
-	trailer.maxMTU		= htonl(rxrpc_rx_mtu);
-	trailer.ifMTU		= htonl(mtu);
-	trailer.rwind		= htonl(rsize);
-	trailer.jumbo_max	= htonl(jmax);
-
-	*ackp++ = 0;
-	*ackp++ = 0;
-	*ackp++ = 0;
-	memcpy(ackp, &trailer, sizeof(trailer));
-	txb->kvec[0].iov_len += sizeof(*ack) + ack->nAcks + 3 + sizeof(trailer);
-	txb->len = txb->kvec[0].iov_len;
+	txb->ack_rwind = rsize;
+	trailer->maxMTU		= htonl(rxrpc_rx_mtu);
+	trailer->ifMTU		= htonl(mtu);
+	trailer->rwind		= htonl(rsize);
+	trailer->jumbo_max	= htonl(jmax);
 }
 
 /*
@@ -195,7 +193,7 @@ static void rxrpc_cancel_rtt_probe(struct rxrpc_call *call,
 /*
  * Transmit an ACK packet.
  */
-static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_connection *conn;
@@ -204,7 +202,7 @@ static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *tx
 	int ret, rtt_slot = -1;
 
 	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
-		return -ECONNRESET;
+		return;
 
 	conn = call->conn;
 
@@ -212,10 +210,8 @@ static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *tx
 	msg.msg_namelen	= call->peer->srx.transport_len;
 	msg.msg_control	= NULL;
 	msg.msg_controllen = 0;
-	msg.msg_flags	= 0;
+	msg.msg_flags	= MSG_SPLICE_PAGES;
 
-	if (ack->reason == RXRPC_ACK_PING)
-		txb->flags |= RXRPC_REQUEST_ACK;
 	whdr->flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 
 	txb->serial = rxrpc_get_next_serial(conn);
@@ -250,8 +246,6 @@ static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *tx
 			rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
 		rxrpc_set_keepalive(call);
 	}
-
-	return ret;
 }
 
 /*
@@ -267,16 +261,19 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_acks[ack_reason]);
 
-	txb = rxrpc_alloc_txbuf(call, RXRPC_PACKET_TYPE_ACK,
-				rcu_read_lock_held() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);
+	txb = rxrpc_alloc_ack_txbuf(call, call->ackr_wtop - call->ackr_window);
 	if (!txb) {
 		kleave(" = -ENOMEM");
 		return;
 	}
 
+	txb->ack_why = why;
+
 	rxrpc_fill_out_ack(call, txb, ack_reason, serial);
+	call->ackr_nr_unacked = 0;
+	atomic_set(&call->ackr_nr_consumed, 0);
+	clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags);
 
-	txb->ack_why = why;
 	trace_rxrpc_send_ack(call, why, ack_reason, serial);
 	rxrpc_send_ack_packet(call, txb);
 	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
@@ -465,7 +462,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	msg.msg_namelen	= call->peer->srx.transport_len;
 	msg.msg_control	= NULL;
 	msg.msg_controllen = 0;
-	msg.msg_flags	= 0;
+	msg.msg_flags	= MSG_SPLICE_PAGES;
 
 	/* Track what we've attempted to transmit at least once so that the
 	 * retransmission algorithm doesn't try to resend what we haven't sent
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index ef0849c8329c..e540501a20ad 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -145,16 +145,17 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn,
 /*
  * Work out how much data we can put in a packet.
  */
-static int rxkad_how_much_data(struct rxrpc_call *call, size_t remain,
-			       size_t *_buf_size, size_t *_data_size, size_t *_offset)
+static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
 {
-	size_t shdr, buf_size, chunk;
+	struct rxrpc_txbuf *txb;
+	size_t shdr, space;
+
+	remain = min(remain, 65535 - sizeof(struct rxrpc_wire_header));
 
 	switch (call->conn->security_level) {
 	default:
-		buf_size = chunk = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
-		shdr = 0;
-		goto out;
+		space = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
+		return rxrpc_alloc_data_txbuf(call, space, 0, GFP_KERNEL);
 	case RXRPC_SECURITY_AUTH:
 		shdr = sizeof(struct rxkad_level1_hdr);
 		break;
@@ -163,17 +164,15 @@ static int rxkad_how_much_data(struct rxrpc_call *call, size_t remain,
 		break;
 	}
 
-	buf_size = round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN);
-
-	chunk = buf_size - shdr;
-	if (remain < chunk)
-		buf_size = round_up(shdr + remain, RXKAD_ALIGN);
+	space = min_t(size_t, round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN), remain + shdr);
+	space = round_up(space, RXKAD_ALIGN);
 
-out:
-	*_buf_size = buf_size;
-	*_data_size = chunk;
-	*_offset = shdr;
-	return 0;
+	txb = rxrpc_alloc_data_txbuf(call, space, RXKAD_ALIGN, GFP_KERNEL);
+	if (txb) {
+		txb->offset += shdr;
+		txb->space -= shdr;
+	}
+	return txb;
 }
 
 /*
@@ -251,7 +250,8 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 				    struct rxrpc_txbuf *txb,
 				    struct skcipher_request *req)
 {
-	struct rxkad_level1_hdr *hdr = (void *)txb->data;
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxkad_level1_hdr *hdr = (void *)(whdr + 1);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
 	size_t pad;
@@ -267,14 +267,14 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 	pad = RXKAD_ALIGN - pad;
 	pad &= RXKAD_ALIGN - 1;
 	if (pad) {
-		memset(txb->data + txb->offset, 0, pad);
+		memset(txb->kvec[0].iov_base + txb->offset, 0, pad);
 		txb->len += pad;
 	}
 
 	/* start the encryption afresh */
 	memset(&iv, 0, sizeof(iv));
 
-	sg_init_one(&sg, txb->data, 8);
+	sg_init_one(&sg, hdr, 8);
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
@@ -293,7 +293,8 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 				       struct skcipher_request *req)
 {
 	const struct rxrpc_key_token *token;
-	struct rxkad_level2_hdr *rxkhdr = (void *)txb->data;
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxkad_level2_hdr *rxkhdr = (void *)(whdr + 1);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
 	size_t pad;
@@ -312,7 +313,7 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 	pad = RXKAD_ALIGN - pad;
 	pad &= RXKAD_ALIGN - 1;
 	if (pad) {
-		memset(txb->data + txb->offset, 0, pad);
+		memset(txb->kvec[0].iov_base + txb->offset, 0, pad);
 		txb->len += pad;
 	}
 
@@ -320,7 +321,7 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 	token = call->conn->key->payload.data[0];
 	memcpy(&iv, token->kad->session_key, sizeof(iv));
 
-	sg_init_one(&sg, txb->data, txb->len);
+	sg_init_one(&sg, rxkhdr, txb->len);
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, txb->len, iv.x);
@@ -1255,7 +1256,7 @@ const struct rxrpc_security rxkad = {
 	.free_preparse_server_key	= rxkad_free_preparse_server_key,
 	.destroy_server_key		= rxkad_destroy_server_key,
 	.init_connection_security	= rxkad_init_connection_security,
-	.how_much_data			= rxkad_how_much_data,
+	.alloc_txbuf			= rxkad_alloc_txbuf,
 	.secure_packet			= rxkad_secure_packet,
 	.verify_packet			= rxkad_verify_packet,
 	.free_call_crypto		= rxkad_free_call_crypto,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 1e81046ea8a6..4d152f06b039 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -336,7 +336,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 	do {
 		if (!txb) {
-			size_t remain, bufsize, chunk, offset;
+			size_t remain;
 
 			_debug("alloc");
 
@@ -348,23 +348,11 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			 * region (enc blocksize), but the trailer is not.
 			 */
 			remain = more ? INT_MAX : msg_data_left(msg);
-			ret = call->conn->security->how_much_data(call, remain,
-								  &bufsize, &chunk, &offset);
-			if (ret < 0)
-				goto maybe_error;
-
-			_debug("SIZE: %zu/%zu @%zu", chunk, bufsize, offset);
-
-			/* create a buffer that we can retain until it's ACK'd */
-			ret = -ENOMEM;
-			txb = rxrpc_alloc_txbuf(call, RXRPC_PACKET_TYPE_DATA,
-						GFP_KERNEL);
-			if (!txb)
+			txb = call->conn->security->alloc_txbuf(call, remain, sk->sk_allocation);
+			if (IS_ERR(txb)) {
+				ret = PTR_ERR(txb);
 				goto maybe_error;
-
-			txb->offset = offset + sizeof(struct rxrpc_wire_header);
-			txb->space -= offset;
-			txb->space = min_t(size_t, chunk, txb->space);
+			}
 		}
 
 		_debug("append");
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 2e8c5b15a84f..b2a82ab756c2 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -14,53 +14,146 @@ static atomic_t rxrpc_txbuf_debug_ids;
 atomic_t rxrpc_nr_txbuf;
 
 /*
- * Allocate and partially initialise an I/O request structure.
+ * Allocate and partially initialise a data transmission buffer.
  */
-struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
-				      gfp_t gfp)
+struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_size,
+					   size_t data_align, gfp_t gfp)
 {
 	struct rxrpc_wire_header *whdr;
 	struct rxrpc_txbuf *txb;
+	size_t total, hoff = 0;
+	void *buf;
 
 	txb = kmalloc(sizeof(*txb), gfp);
-	if (txb) {
-		whdr = &txb->_wire;
-
-		INIT_LIST_HEAD(&txb->call_link);
-		INIT_LIST_HEAD(&txb->tx_link);
-		refcount_set(&txb->ref, 1);
-		txb->call_debug_id	= call->debug_id;
-		txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
-		txb->space		= sizeof(txb->data);
-		txb->len		= 0;
-		txb->offset		= 0;
-		txb->flags		= call->conn->out_clientflag;
-		txb->ack_why		= 0;
-		txb->seq		= call->tx_prepared + 1;
-		txb->serial		= 0;
-		txb->cksum		= 0;
-		txb->nr_kvec		= 1;
-		txb->kvec[0].iov_base	= whdr;
-		txb->kvec[0].iov_len	= sizeof(*whdr);
-		whdr->epoch		= htonl(call->conn->proto.epoch);
-		whdr->cid		= htonl(call->cid);
-		whdr->callNumber	= htonl(call->call_id);
-		whdr->seq		= htonl(txb->seq);
-		whdr->type		= packet_type;
-		whdr->flags		= 0;
-		whdr->userStatus	= 0;
-		whdr->securityIndex	= call->security_ix;
-		whdr->_rsvd		= 0;
-		whdr->serviceId		= htons(call->dest_srx.srx_service);
-
-		trace_rxrpc_txbuf(txb->debug_id,
-				  txb->call_debug_id, txb->seq, 1,
-				  packet_type == RXRPC_PACKET_TYPE_DATA ?
-				  rxrpc_txbuf_alloc_data :
-				  rxrpc_txbuf_alloc_ack);
-		atomic_inc(&rxrpc_nr_txbuf);
+	if (!txb)
+		return NULL;
+
+	if (data_align)
+		hoff = round_up(sizeof(*whdr), data_align) - sizeof(*whdr);
+	total = hoff + sizeof(*whdr) + data_size;
+
+	mutex_lock(&call->conn->tx_data_alloc_lock);
+	buf = page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
+				    ~(data_align - 1) & ~(L1_CACHE_BYTES - 1));
+	mutex_unlock(&call->conn->tx_data_alloc_lock);
+	if (!buf) {
+		kfree(txb);
+		return NULL;
+	}
+
+	whdr = buf + hoff;
+
+	INIT_LIST_HEAD(&txb->call_link);
+	INIT_LIST_HEAD(&txb->tx_link);
+	refcount_set(&txb->ref, 1);
+	txb->last_sent		= KTIME_MIN;
+	txb->call_debug_id	= call->debug_id;
+	txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
+	txb->space		= data_size;
+	txb->len		= 0;
+	txb->offset		= sizeof(*whdr);
+	txb->flags		= call->conn->out_clientflag;
+	txb->ack_why		= 0;
+	txb->seq		= call->tx_prepared + 1;
+	txb->serial		= 0;
+	txb->cksum		= 0;
+	txb->nr_kvec		= 1;
+	txb->kvec[0].iov_base	= whdr;
+	txb->kvec[0].iov_len	= sizeof(*whdr);
+
+	whdr->epoch		= htonl(call->conn->proto.epoch);
+	whdr->cid		= htonl(call->cid);
+	whdr->callNumber	= htonl(call->call_id);
+	whdr->seq		= htonl(txb->seq);
+	whdr->type		= RXRPC_PACKET_TYPE_DATA;
+	whdr->flags		= 0;
+	whdr->userStatus	= 0;
+	whdr->securityIndex	= call->security_ix;
+	whdr->_rsvd		= 0;
+	whdr->serviceId		= htons(call->dest_srx.srx_service);
+
+	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 1,
+			  rxrpc_txbuf_alloc_data);
+
+	atomic_inc(&rxrpc_nr_txbuf);
+	return txb;
+}
+
+/*
+ * Allocate and partially initialise an ACK packet.
+ */
+struct rxrpc_txbuf *rxrpc_alloc_ack_txbuf(struct rxrpc_call *call, size_t sack_size)
+{
+	struct rxrpc_wire_header *whdr;
+	struct rxrpc_acktrailer *trailer;
+	struct rxrpc_ackpacket *ack;
+	struct rxrpc_txbuf *txb;
+	gfp_t gfp = rcu_read_lock_held() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS;
+	void *buf, *buf2 = NULL;
+	u8 *filler;
+
+	txb = kmalloc(sizeof(*txb), gfp);
+	if (!txb)
+		return NULL;
+
+	buf = page_frag_alloc(&call->local->tx_alloc,
+			      sizeof(*whdr) + sizeof(*ack) + 1 + 3 + sizeof(*trailer), gfp);
+	if (!buf) {
+		kfree(txb);
+		return NULL;
+	}
+
+	if (sack_size) {
+		buf2 = page_frag_alloc(&call->local->tx_alloc, sack_size, gfp);
+		if (!buf2) {
+			page_frag_free(buf);
+			kfree(txb);
+			return NULL;
+		}
 	}
 
+	whdr	= buf;
+	ack	= buf + sizeof(*whdr);
+	filler	= buf + sizeof(*whdr) + sizeof(*ack) + 1;
+	trailer	= buf + sizeof(*whdr) + sizeof(*ack) + 1 + 3;
+
+	INIT_LIST_HEAD(&txb->call_link);
+	INIT_LIST_HEAD(&txb->tx_link);
+	refcount_set(&txb->ref, 1);
+	txb->call_debug_id	= call->debug_id;
+	txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
+	txb->space		= 0;
+	txb->len		= sizeof(*whdr) + sizeof(*ack) + 3 + sizeof(*trailer);
+	txb->offset		= 0;
+	txb->flags		= call->conn->out_clientflag;
+	txb->ack_rwind		= 0;
+	txb->seq		= 0;
+	txb->serial		= 0;
+	txb->cksum		= 0;
+	txb->nr_kvec		= 3;
+	txb->kvec[0].iov_base	= whdr;
+	txb->kvec[0].iov_len	= sizeof(*whdr) + sizeof(*ack);
+	txb->kvec[1].iov_base	= buf2;
+	txb->kvec[1].iov_len	= sack_size;
+	txb->kvec[2].iov_base	= filler;
+	txb->kvec[2].iov_len	= 3 + sizeof(*trailer);
+
+	whdr->epoch		= htonl(call->conn->proto.epoch);
+	whdr->cid		= htonl(call->cid);
+	whdr->callNumber	= htonl(call->call_id);
+	whdr->seq		= 0;
+	whdr->type		= RXRPC_PACKET_TYPE_ACK;
+	whdr->flags		= 0;
+	whdr->userStatus	= 0;
+	whdr->securityIndex	= call->security_ix;
+	whdr->_rsvd		= 0;
+	whdr->serviceId		= htons(call->dest_srx.srx_service);
+
+	get_page(virt_to_head_page(trailer));
+
+	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 1,
+			  rxrpc_txbuf_alloc_ack);
+	atomic_inc(&rxrpc_nr_txbuf);
 	return txb;
 }
 
@@ -79,12 +172,15 @@ void rxrpc_see_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what)
 	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, r, what);
 }
 
-static void rxrpc_free_txbuf(struct rcu_head *rcu)
+static void rxrpc_free_txbuf(struct rxrpc_txbuf *txb)
 {
-	struct rxrpc_txbuf *txb = container_of(rcu, struct rxrpc_txbuf, rcu);
+	int i;
 
 	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 0,
 			  rxrpc_txbuf_free);
+	for (i = 0; i < txb->nr_kvec; i++)
+		if (txb->kvec[i].iov_base)
+			page_frag_free(txb->kvec[i].iov_base);
 	kfree(txb);
 	atomic_dec(&rxrpc_nr_txbuf);
 }
@@ -103,7 +199,7 @@ void rxrpc_put_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what)
 		dead = __refcount_dec_and_test(&txb->ref, &r);
 		trace_rxrpc_txbuf(debug_id, call_debug_id, seq, r - 1, what);
 		if (dead)
-			call_rcu(&txb->rcu, rxrpc_free_txbuf);
+			rxrpc_free_txbuf(txb);
 	}
 }
 


