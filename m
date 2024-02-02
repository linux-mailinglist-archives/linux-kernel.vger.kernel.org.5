Return-Path: <linux-kernel+bounces-50011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FC8472FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7B628D45B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FE1468FD;
	Fri,  2 Feb 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M72ybE9T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503F1468F5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887201; cv=none; b=uXuSFAxJrxQ+2uqmd9j9jm6/J/vZrBD36w5FOCqlIILSm2/MsoR91HsYYfimDH1EXbeDIeBNV7Mqmm7Qm+cXUMU+PpeGBCBMrxRj+2Tl4vyl2Ee4dz2s0NTBNnQ5PYKqp90/r/1tDew7OzNzuJfPXXyJMpkqHy8fC/z9Z0sJO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887201; c=relaxed/simple;
	bh=1E+6w2N5wsmKVyiiiDYhEZBNbV8HFqMK2hFS1Um4w2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkwcXreapIf9WnSPyt8pmJohz7meP0ObUw5tc7SkgB/XMRZ1RECz56t7ejaNUYr0vL1r8TUVqH4Qqz3qjPDDlU1hvRXvtem7YV1ncyVtWsK4T6J1sVF0p8BIzxNn32Rtul5MR3VoyxZvoy3eu7I5Zzsx7j0VNYDHOHopaNMEGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M72ybE9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcOk0tCCziI3vJhbOH1NSk8vxoJI3+Ui+TVJi/wrzSA=;
	b=M72ybE9Trc3OWTAfCG5x5Ior96yzToMjKPdqq17vXLlNkN3+86V/Dq/0oNBDtjs2PksN3B
	4sYmXPM53f5YlqIkTfcApxqmBGBVex1vo6uBIHP2joWOrOD0gLpw0YwFLjjknSjjj0NxRZ
	2IfGyt1hILaVUDdEKD+i1gDA8vaVvnc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-N2QewX3ENtyKSqmZSJpK1A-1; Fri,
 02 Feb 2024 10:19:54 -0500
X-MC-Unique: N2QewX3ENtyKSqmZSJpK1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 798363C0BE55;
	Fri,  2 Feb 2024 15:19:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 590AD40C9444;
	Fri,  2 Feb 2024 15:19:53 +0000 (UTC)
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
Subject: [PATCH net 1/4] rxrpc: Fix generation of serial numbers to skip zero
Date: Fri,  2 Feb 2024 15:19:13 +0000
Message-ID: <20240202151920.2760446-2-dhowells@redhat.com>
In-Reply-To: <20240202151920.2760446-1-dhowells@redhat.com>
References: <20240202151920.2760446-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

In the Rx protocol, every packet generated is marked with a per-connection
monotonically increasing serial number.  This number can be referenced in
an ACK packet generated in response to an incoming packet - thereby
allowing the sender to use this for RTT determination, amongst other
things.

However, if the reference field in the ACK is zero, it doesn't refer to any
incoming packet (it could be a ping to find out if a packet got lost, for
example) - so we shouldn't generate zero serial numbers.

Fix the generation of serial numbers to retry if it comes up with a zero.

Furthermore, since the serial numbers are only ever allocated within the
I/O thread this connection is bound to, there's no need for atomics so
remove that too.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 16 +++++++++++++++-
 net/rxrpc/conn_event.c  |  2 +-
 net/rxrpc/output.c      |  8 ++++----
 net/rxrpc/proc.c        |  2 +-
 net/rxrpc/rxkad.c       |  4 ++--
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index dbeb75c29857..31b0dd8c9b2d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -510,7 +510,7 @@ struct rxrpc_connection {
 	enum rxrpc_call_completion completion;	/* Completion condition */
 	s32			abort_code;	/* Abort code of connection abort */
 	int			debug_id;	/* debug ID for printks */
-	atomic_t		serial;		/* packet serial number counter */
+	rxrpc_serial_t		tx_serial;	/* Outgoing packet serial number counter */
 	unsigned int		hi_serial;	/* highest serial number received */
 	u32			service_id;	/* Service ID, possibly upgraded */
 	u32			security_level;	/* Security level selected */
@@ -822,6 +822,20 @@ static inline bool rxrpc_sending_to_client(const struct rxrpc_txbuf *txb)
 
 #include <trace/events/rxrpc.h>
 
+/*
+ * Allocate the next serial number on a connection.  0 must be skipped.
+ */
+static inline rxrpc_serial_t rxrpc_get_next_serial(struct rxrpc_connection *conn)
+{
+	rxrpc_serial_t serial;
+
+	serial = conn->tx_serial;
+	if (serial == 0)
+		serial = 1;
+	conn->tx_serial = serial + 1;
+	return serial;
+}
+
 /*
  * af_rxrpc.c
  */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 95f4bc206b3d..ec5eae60ab0c 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -117,7 +117,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	iov[2].iov_base	= &ack_info;
 	iov[2].iov_len	= sizeof(ack_info);
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 
 	pkt.whdr.epoch		= htonl(conn->proto.epoch);
 	pkt.whdr.cid		= htonl(conn->proto.cid | channel);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index a0906145e829..4a292f860ae3 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -216,7 +216,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	iov[0].iov_len	= sizeof(txb->wire) + sizeof(txb->ack) + n;
 	len = iov[0].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	txb->wire.serial = htonl(serial);
 	trace_rxrpc_tx_ack(call->debug_id, serial,
 			   ntohl(txb->ack.firstPacket),
@@ -302,7 +302,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 	iov[0].iov_base	= &pkt;
 	iov[0].iov_len	= sizeof(pkt);
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	pkt.whdr.serial = htonl(serial);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, sizeof(pkt));
@@ -334,7 +334,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	_enter("%x,{%d}", txb->seq, txb->len);
 
 	/* Each transmission of a Tx packet needs a new serial number */
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	txb->wire.serial = htonl(serial);
 
 	if (test_bit(RXRPC_CONN_PROBING_FOR_UPGRADE, &conn->flags) &&
@@ -558,7 +558,7 @@ void rxrpc_send_conn_abort(struct rxrpc_connection *conn)
 
 	len = iov[0].iov_len + iov[1].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 2, len);
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 6c86cbb98d1d..26dc2f26d92d 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -181,7 +181,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 		   atomic_read(&conn->active),
 		   state,
 		   key_serial(conn->key),
-		   atomic_read(&conn->serial),
+		   conn->tx_serial,
 		   conn->hi_serial,
 		   conn->channels[0].call_id,
 		   conn->channels[1].call_id,
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index b52dedcebce0..6b32d61d4cdc 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -664,7 +664,7 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 
 	len = iov[0].iov_len + iov[1].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 2, len);
@@ -721,7 +721,7 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 
 	len = iov[0].iov_len + iov[1].iov_len + iov[2].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
 	rxrpc_local_dont_fragment(conn->local, false);


