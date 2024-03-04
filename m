Return-Path: <linux-kernel+bounces-90227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857586FC2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC42F1C20C39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E84374F7;
	Mon,  4 Mar 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9z+oph8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BB36AFD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541831; cv=none; b=aAfqX8bB1oJpdHWmsRNtjfA1uSezBw3HTSZJkqEEzwp5JPFBhVJKP1ZkqXLjfImwnAmaksamf7avQKrNscL9KrniusnBfA4WVphfP/ebJxK7oQIbvljbFvD/iUjirVD4TjFcvTX3yE8lIMe2B1oAwpcrvQcFxG9AyIKBChYUte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541831; c=relaxed/simple;
	bh=Fb3EEdeGG6hr40pcfHcbrnPc71Su9PqpTX7U2qzg2NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN1NTDq7miR6ZjGK2/D/9CTk8gz9DtVCtlCC4r/L4X23yF1SnJeyCD/zsOgn+739DOGawdVq3Ek39VO20VHN0EKCMC88BlE24fsiSDJRg0/PUyno8rnBfs1B1Yn11JoAKCBHG8Ow5xACYLhpw6ax09PbxmslREkjQzx0mK5Lj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9z+oph8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2jcthewAMVGdt4V/a8GGyr1bztrZf6ReP981b5efaE=;
	b=c9z+oph8fZMs4aH2w+d+3xtoEAWfYZL/W1i68JJsTcf86yV4pB1o0+1P3KEhUKoKCeoUfv
	THHj0mxNAIkcTv+Y9AAAAhs+rwCKoHaap/9JlA6qaOV0h82voiQdpH85FORqxANr4fuqAw
	xtPMt7gP14iwQmuZkMsOEA6OVhBjzC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-bgL59sUCNkKk_ZH8_3r9Ig-1; Mon, 04 Mar 2024 03:43:44 -0500
X-MC-Unique: bgL59sUCNkKk_ZH8_3r9Ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A84F8489AB;
	Mon,  4 Mar 2024 08:43:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 320981121313;
	Mon,  4 Mar 2024 08:43:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 10/21] rxrpc: Split up the DATA packet transmission function
Date: Mon,  4 Mar 2024 08:43:07 +0000
Message-ID: <20240304084322.705539-11-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Split (sub)packet preparation and timestamping out of the DATA packet
transmission function to make it easier to glue multiple txbufs together
into a jumbo DATA packet.  This will require preparation and timestamping
of all the subpackets in a txbuf, and these functions provide convenient
points to place the required iteration.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  1 -
 net/rxrpc/output.c      | 98 +++++++++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c6731f43a2d5..54550ab62adc 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1166,7 +1166,6 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
  */
 int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb);
 int rxrpc_send_abort_packet(struct rxrpc_call *);
-int rxrpc_send_data_packet(struct rxrpc_call *, struct rxrpc_txbuf *);
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
 void rxrpc_send_keepalive(struct rxrpc_peer *);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index f2b10c3e4cc2..25b8fc9aef97 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -313,37 +313,23 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 }
 
 /*
- * send a packet through the transport endpoint
+ * Prepare a (sub)packet for transmission.
  */
-int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
+					 rxrpc_serial_t serial)
 {
-	struct rxrpc_connection *conn = call->conn;
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
-	enum rxrpc_tx_point frag;
-	struct msghdr msg;
-	size_t len;
-	int ret, rtt_slot = -1;
+	struct rxrpc_connection *conn = call->conn;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
 
-	/* Each transmission of a Tx packet+ needs a new serial number */
-	txb->serial = rxrpc_get_next_serial(conn);
-	txb->wire.serial = htonl(txb->serial);
-	txb->wire.cksum = txb->cksum;
+	txb->serial = serial;
 
 	if (test_bit(RXRPC_CONN_PROBING_FOR_UPGRADE, &conn->flags) &&
 	    txb->seq == 1)
 		txb->wire.userStatus = RXRPC_USERSTATUS_SERVICE_UPGRADE;
 
-	len = txb->kvec[0].iov_len;
-	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, len);
-
-	msg.msg_name = &call->peer->srx.transport;
-	msg.msg_namelen = call->peer->srx.transport_len;
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
-	msg.msg_flags = 0;
-
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
@@ -376,6 +362,59 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		txb->flags |= RXRPC_REQUEST_ACK;
 dont_set_request_ack:
 
+	whdr->flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
+	whdr->serial	= htonl(txb->serial);
+	whdr->cksum	= txb->cksum;
+
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags, false);
+}
+
+/*
+ * Prepare a packet for transmission.
+ */
+static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+{
+	rxrpc_serial_t serial;
+
+	/* Each transmission of a Tx packet needs a new serial number */
+	serial = rxrpc_get_next_serial(call->conn);
+
+	rxrpc_prepare_data_subpacket(call, txb, serial);
+
+	return txb->len;
+}
+
+/*
+ * Set the times on a packet before transmission
+ */
+static int rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+{
+	ktime_t tstamp = ktime_get_real();
+	int rtt_slot = -1;
+
+	txb->last_sent = tstamp;
+	if (txb->flags & RXRPC_REQUEST_ACK)
+		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
+
+	return rtt_slot;
+}
+
+/*
+ * send a packet through the transport endpoint
+ */
+static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+{
+	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxrpc_connection *conn = call->conn;
+	enum rxrpc_tx_point frag;
+	struct msghdr msg;
+	size_t len;
+	int ret, rtt_slot = -1;
+
+	_enter("%x,{%d}", txb->seq, txb->len);
+
+	len = rxrpc_prepare_data_packet(call, txb);
+
 	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
 		static int lose;
 		if ((lose++ & 7) == 7) {
@@ -386,7 +425,13 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		}
 	}
 
-	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags, false);
+	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, len);
+
+	msg.msg_name	= &call->peer->srx.transport;
+	msg.msg_namelen	= call->peer->srx.transport_len;
+	msg.msg_control	= NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags	= 0;
 
 	/* Track what we've attempted to transmit at least once so that the
 	 * retransmission algorithm doesn't try to resend what we haven't sent
@@ -405,11 +450,8 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		frag = rxrpc_tx_point_call_data_nofrag;
 	}
 
-	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 retry:
-	txb->last_sent = ktime_get_real();
-	if (txb->flags & RXRPC_REQUEST_ACK)
-		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
+	rtt_slot = rxrpc_tstamp_data_packets(call, txb);
 
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet
@@ -424,11 +466,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
 		rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
-		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
-				    rxrpc_tx_point_call_data_nofrag);
+		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret, frag);
 	} else {
-		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
-				      rxrpc_tx_point_call_data_nofrag);
+		trace_rxrpc_tx_packet(call->debug_id, whdr, frag);
 	}
 
 	rxrpc_tx_backoff(call, ret);


