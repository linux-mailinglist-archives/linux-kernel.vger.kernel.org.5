Return-Path: <linux-kernel+bounces-93142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF64872B85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2E91F29536
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744001C28F;
	Wed,  6 Mar 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjm9jBrl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7E1BDDB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683645; cv=none; b=PZjK4f9G2UNPBu+T7JD/8pr748JH5XTnpdR9mAvAW9DiLyrVvUkOuFAHn0lF4SnPfdjAcS4afE1jbwq2FXLffsvobv8ay6DsDWCvSV08FMXgdqcdchsdImzWFm071J77NY4zSshzzD6sUB9AMDpBTxxMmWifUs4QmyMqgDi3GLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683645; c=relaxed/simple;
	bh=1yskpCVzWiHGiofGxGLw9LLF25f7okHA+AFw/Vlb7/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2ZNq+gzAdHtCMmCPuKElEJwBRjpbuNPppOO3/4lgjk0lPaB84wdrCJK+HKJdUioSwbY8Yytk/8hZQFZawoqfJIN5xpZicU60JUYhnm4RKrCH5xdualq58SJEK4Aufbd15Wyw5d0+Vz+gDXoOOR0HyDEV5sgsqoM9xefyQODv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjm9jBrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRdqimspnMZVPKymX1p9GQpRQzRORSRvhQalJQ51PVE=;
	b=hjm9jBrlTWyMSH/9cKftl7prCxTjqeGcbodw8aWkhGb4huPEBVH8heSmHbBAQDmGne7JSJ
	MvSkdoh+JciN5PR4HFbAaDtZeY+THruOdfgzXDJ2oq+wGtZ5KgPt7zVwGcXR+62do9I4c5
	jCg4zT4FJrJju7mmG1oCMU3E8F4dhfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-t43blaZDM_KVdGsWeA5fNA-1; Tue, 05 Mar 2024 19:07:19 -0500
X-MC-Unique: t43blaZDM_KVdGsWeA5fNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B8B2185A78E;
	Wed,  6 Mar 2024 00:07:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B64AF37F6;
	Wed,  6 Mar 2024 00:07:17 +0000 (UTC)
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
Subject: [PATCH net-next v3 09/21] rxrpc: Add a kvec[] to the rxrpc_txbuf struct
Date: Wed,  6 Mar 2024 00:06:39 +0000
Message-ID: <20240306000655.1100294-10-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add a kvec[] to the rxrpc_txbuf struct to point to the contributory buffers
for a packet.  Start with just a single element for now, but this will be
expanded later.

Make the ACK sending function use it, which means that rxrpc_fill_out_ack()
doesn't need to return the size of the sack table, padding and trailer.

Make the data sending code use it, both in where sendmsg() packages code up
into txbufs and where those txbufs are transmitted.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  2 ++
 net/rxrpc/output.c      | 33 ++++++++++++---------------------
 net/rxrpc/sendmsg.c     |  8 +++++---
 net/rxrpc/txbuf.c       |  3 +++
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c9a2882627aa..c6731f43a2d5 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -805,6 +805,8 @@ struct rxrpc_txbuf {
 #define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
 	__be16			cksum;		/* Checksum to go in header */
 	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
+	u8			nr_kvec;
+	struct kvec		kvec[1];
 	struct {
 		/* The packet for encrypting and DMA'ing.  We align it such
 		 * that data[] aligns correctly for any crypto blocksize.
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index e2c9e645fcfb..f2b10c3e4cc2 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -77,10 +77,10 @@ static void rxrpc_set_keepalive(struct rxrpc_call *call)
 /*
  * Fill out an ACK packet.
  */
-static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
-				 struct rxrpc_call *call,
-				 struct rxrpc_txbuf *txb,
-				 u16 *_rwind)
+static void rxrpc_fill_out_ack(struct rxrpc_connection *conn,
+			       struct rxrpc_call *call,
+			       struct rxrpc_txbuf *txb,
+			       u16 *_rwind)
 {
 	struct rxrpc_acktrailer trailer;
 	unsigned int qsize, sack, wrap, to;
@@ -134,7 +134,9 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 	*ackp++ = 0;
 	*ackp++ = 0;
 	memcpy(ackp, &trailer, sizeof(trailer));
-	return txb->ack.nAcks + 3 + sizeof(trailer);
+	txb->kvec[0].iov_len = sizeof(txb->wire) +
+		sizeof(txb->ack) + txb->ack.nAcks + 3 + sizeof(trailer);
+	txb->len = txb->kvec[0].iov_len;
 }
 
 /*
@@ -187,8 +189,6 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
 	struct rxrpc_connection *conn;
 	struct msghdr msg;
-	struct kvec iov[1];
-	size_t len, n;
 	int ret, rtt_slot = -1;
 	u16 rwind;
 
@@ -207,13 +207,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		txb->flags |= RXRPC_REQUEST_ACK;
 	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 
-	n = rxrpc_fill_out_ack(conn, call, txb, &rwind);
-	if (n == 0)
-		return 0;
-
-	iov[0].iov_base	= &txb->wire;
-	iov[0].iov_len	= sizeof(txb->wire) + sizeof(txb->ack) + n;
-	len = iov[0].iov_len;
+	rxrpc_fill_out_ack(conn, call, txb, &rwind);
 
 	txb->serial = rxrpc_get_next_serial(conn);
 	txb->wire.serial = htonl(txb->serial);
@@ -230,9 +224,9 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	/* Grab the highest received seq as late as possible */
 	txb->ack.previousPacket	= htonl(call->rx_highest_seq);
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, txb->len);
 	rxrpc_local_dont_fragment(conn->local, false);
-	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
+	ret = do_udp_sendmsg(conn->local->socket, &msg, txb->len);
 	call->peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
@@ -327,7 +321,6 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	enum rxrpc_req_ack_trace why;
 	enum rxrpc_tx_point frag;
 	struct msghdr msg;
-	struct kvec iov[1];
 	size_t len;
 	int ret, rtt_slot = -1;
 
@@ -342,10 +335,8 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	    txb->seq == 1)
 		txb->wire.userStatus = RXRPC_USERSTATUS_SERVICE_UPGRADE;
 
-	iov[0].iov_base = &txb->wire;
-	iov[0].iov_len = sizeof(txb->wire) + txb->len;
-	len = iov[0].iov_len;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
+	len = txb->kvec[0].iov_len;
+	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, len);
 
 	msg.msg_name = &call->peer->srx.transport;
 	msg.msg_namelen = call->peer->srx.transport_len;
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 25c7c1d4f4c6..1e81046ea8a6 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -362,7 +362,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			if (!txb)
 				goto maybe_error;
 
-			txb->offset = offset;
+			txb->offset = offset + sizeof(struct rxrpc_wire_header);
 			txb->space -= offset;
 			txb->space = min_t(size_t, chunk, txb->space);
 		}
@@ -374,8 +374,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			size_t copy = min_t(size_t, txb->space, msg_data_left(msg));
 
 			_debug("add %zu", copy);
-			if (!copy_from_iter_full(txb->data + txb->offset, copy,
-						 &msg->msg_iter))
+			if (!copy_from_iter_full(txb->kvec[0].iov_base + txb->offset,
+						 copy, &msg->msg_iter))
 				goto efault;
 			_debug("added");
 			txb->space -= copy;
@@ -404,6 +404,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			if (ret < 0)
 				goto out;
 
+			txb->kvec[0].iov_len += txb->len;
+			txb->len = txb->kvec[0].iov_len;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			txb = NULL;
 		}
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 7273615afe94..91e96cda6dc7 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -36,6 +36,9 @@ struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 		txb->seq		= call->tx_prepared + 1;
 		txb->serial		= 0;
 		txb->cksum		= 0;
+		txb->nr_kvec		= 1;
+		txb->kvec[0].iov_base	= &txb->wire;
+		txb->kvec[0].iov_len	= sizeof(txb->wire);
 		txb->wire.epoch		= htonl(call->conn->proto.epoch);
 		txb->wire.cid		= htonl(call->cid);
 		txb->wire.callNumber	= htonl(call->call_id);


