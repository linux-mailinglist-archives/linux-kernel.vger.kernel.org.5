Return-Path: <linux-kernel+bounces-90229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B586FC34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CC31C21238
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB38376F2;
	Mon,  4 Mar 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvKb0+gU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295B381BF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541835; cv=none; b=RArOkdzAT1yoDuScp1S9T6C7oolMewIiX50+iJ9HSrRERtFafaAq5PMi+c1q0cOJiG1byyB7iVXZBQq9jYmb8sRJYqEeYEQxdDUlqjW4I9WygB0f0opPT0xAAS/Zuc/HBy4gUOL2L09zHC5rxxub6DYfC59BZBd6/ERsE9Gay0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541835; c=relaxed/simple;
	bh=HPT1/Otm7HC3lWXqMPZL6qX9ql3qTr8GnyMTVbuei7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhgMTHsWRKzb+1LCoiD5eqqW/j4dyCfRUyPmVdqDJeyuK+70WUVawwzfH8EAtSeHVsBCtnUAC5p/BLmeP7D9VQVBtE6hxtYMptj1JoomfHWwcYuP/CSJwSlG4YHrAS+6S8JPQvxsBzChJke7xcd2lJH0+r6MsqaSNNwqy+FLI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvKb0+gU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0j3g3jFYPBuEOmQrpIsH83jKP4pkLZUnpgeZVLL69Gc=;
	b=GvKb0+gU2uz83a2HIVm1puWZbiU4OV7k+cV9r936eDFdWYaeGGWwrn/a5UNhOEA4zIgUTI
	4p001SfLltFvXibZ7lABDDHTn/kqLBPkA7tiKa0/Go+WoSPZsVJF5qVhFrqQkaqxP7ieMx
	zT0Ar/U8UAz9Bw/MV7JzAR8iY93dLio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-130P9ETdPrSyRiQdHL1zsg-1; Mon, 04 Mar 2024 03:43:48 -0500
X-MC-Unique: 130P9ETdPrSyRiQdHL1zsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C509811E81;
	Mon,  4 Mar 2024 08:43:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A57324D;
	Mon,  4 Mar 2024 08:43:46 +0000 (UTC)
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
Subject: [PATCH net-next v2 12/21] rxrpc: Move rxrpc_send_ACK() to output.c with rxrpc_send_ack_packet()
Date: Mon,  4 Mar 2024 08:43:09 +0000
Message-ID: <20240304084322.705539-13-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Move rxrpc_send_ACK() to output.c to so that it is with
rxrpc_send_ack_packet() prior to merging the two.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  4 ++--
 net/rxrpc/call_event.c  | 37 -------------------------------------
 net/rxrpc/output.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 54550ab62adc..a8795ef0d669 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -873,7 +873,6 @@ int rxrpc_user_charge_accept(struct rxrpc_sock *, unsigned long);
  */
 void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 			enum rxrpc_propose_ack_trace why);
-void rxrpc_send_ACK(struct rxrpc_call *, u8, rxrpc_serial_t, enum rxrpc_propose_ack_trace);
 void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 			     enum rxrpc_propose_ack_trace);
 void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *);
@@ -1164,7 +1163,8 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
 /*
  * output.c
  */
-int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb);
+void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
+		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why);
 int rxrpc_send_abort_packet(struct rxrpc_call *);
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 1184518dcdb8..e19ea54dce54 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -61,43 +61,6 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	trace_rxrpc_propose_ack(call, why, RXRPC_ACK_DELAY, serial);
 }
 
-/*
- * Queue an ACK for immediate transmission.
- */
-void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
-		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
-{
-	struct rxrpc_txbuf *txb;
-
-	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
-		return;
-
-	rxrpc_inc_stat(call->rxnet, stat_tx_acks[ack_reason]);
-
-	txb = rxrpc_alloc_txbuf(call, RXRPC_PACKET_TYPE_ACK,
-				rcu_read_lock_held() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);
-	if (!txb) {
-		kleave(" = -ENOMEM");
-		return;
-	}
-
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
-
-	trace_rxrpc_send_ack(call, why, ack_reason, serial);
-	rxrpc_send_ack_packet(call, txb);
-	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
-}
-
 /*
  * Handle congestion being detected by the retransmit timeout.
  */
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 25b8fc9aef97..ec9ae9c6c492 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -185,7 +185,7 @@ static void rxrpc_cancel_rtt_probe(struct rxrpc_call *call,
 /*
  * Transmit an ACK packet.
  */
-int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
 	struct rxrpc_connection *conn;
 	struct msghdr msg;
@@ -248,6 +248,43 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	return ret;
 }
 
+/*
+ * Queue an ACK for immediate transmission.
+ */
+void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
+		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
+{
+	struct rxrpc_txbuf *txb;
+
+	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
+		return;
+
+	rxrpc_inc_stat(call->rxnet, stat_tx_acks[ack_reason]);
+
+	txb = rxrpc_alloc_txbuf(call, RXRPC_PACKET_TYPE_ACK,
+				rcu_read_lock_held() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);
+	if (!txb) {
+		kleave(" = -ENOMEM");
+		return;
+	}
+
+	txb->ack_why		= why;
+	txb->wire.seq		= 0;
+	txb->wire.type		= RXRPC_PACKET_TYPE_ACK;
+	txb->flags		|= RXRPC_SLOW_START_OK;
+	txb->ack.bufferSpace	= 0;
+	txb->ack.maxSkew	= 0;
+	txb->ack.firstPacket	= 0;
+	txb->ack.previousPacket	= 0;
+	txb->ack.serial		= htonl(serial);
+	txb->ack.reason		= ack_reason;
+	txb->ack.nAcks		= 0;
+
+	trace_rxrpc_send_ack(call, why, ack_reason, serial);
+	rxrpc_send_ack_packet(call, txb);
+	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
+}
+
 /*
  * Send an ABORT call packet.
  */


