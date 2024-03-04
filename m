Return-Path: <linux-kernel+bounces-90238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33986FC4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39561C21FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797673D547;
	Mon,  4 Mar 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFpPD3FQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A901C2AE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541859; cv=none; b=i4Nw+ojYalhOB/mJraWWkp2Xe21TqHOMXfpWUL8Gb8q90Xs6kZphQWAdHqPWq9cTQ+pOMs/UdlGUY4+f61nLX2bopb8nNxxKxdLIKG5aC02270HicdU0HPktw21ZGJj5EUCaDHupqHuxz6j9p3o/EcJg0/3MnoefrMMTevr9/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541859; c=relaxed/simple;
	bh=3W1tGWYV3aFDXvrf37HRbAw1JRDsqeWSwvyhDoPXG2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDIr5NlV65C9XVTKclQ4QSQUTWusd+JgEs09cRW/wgIhRVw/FVoPCuUgMWa/1/EsgEAMQDjSjbZFxrdOETk5NFAqTkV5rBkUqJjMMVVN/Cay+/8itjibKMlghBOdrXCUJ8eBN6JwD1BjZcLBZCpbGtsM25T86l7HgHC3XMEeafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFpPD3FQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw1mJ1KMDj2Xrl/dCIVrkP2L8ZbK2rHywBCTVXbbrs8=;
	b=QFpPD3FQdpPwzm7TOR1JJQwVWMoi+qfUVqsFow1xYpCyLF3NT8OcnqWmryHJH0x364M0mq
	/LSzspC1QcPYRrtLMZ18oDvNczQvJ1j6v0JN2dFh+XkB617Dp2N72tAgYUP9mk2/KTkwov
	JpjhbOfLyvTEcT/IBxITuz6mhi+I2GM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-pU0f7eogM_qXfOc54oR9_A-1; Mon, 04 Mar 2024 03:44:11 -0500
X-MC-Unique: pU0f7eogM_qXfOc54oR9_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21881185A782;
	Mon,  4 Mar 2024 08:44:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5632D492BD7;
	Mon,  4 Mar 2024 08:44:09 +0000 (UTC)
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
Subject: [PATCH net-next v2 19/21] rxrpc: Record probes after transmission and reduce number of time-gets
Date: Mon,  4 Mar 2024 08:43:16 +0000
Message-ID: <20240304084322.705539-20-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Move the recording of a successfully transmitted DATA or ACK packet that
will provide RTT probing to after the transmission.  With the I/O thread
model, this can be done because parsing of the responding ACK can no longer
race with the post-transmission code.

Move the various timeout-settings done after successfully transmitting a
DATA packet into rxrpc_tstamp_data_packets() and eliminate a number of
calls to get the current time.

As a consequence we no longer need to cancel a proposed RTT probe on
transmission failure.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 105 +++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 65 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ec82193e5681..5ea9601efd05 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -63,7 +63,7 @@ static void rxrpc_tx_backoff(struct rxrpc_call *call, int ret)
  * Receiving a response to the ping will prevent the ->expect_rx_by timer from
  * expiring.
  */
-static void rxrpc_set_keepalive(struct rxrpc_call *call)
+static void rxrpc_set_keepalive(struct rxrpc_call *call, ktime_t now)
 {
 	ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo) / 6);
 
@@ -147,8 +147,8 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 /*
  * Record the beginning of an RTT probe.
  */
-static int rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial,
-				 enum rxrpc_rtt_tx_trace why)
+static void rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial,
+				  ktime_t now, enum rxrpc_rtt_tx_trace why)
 {
 	unsigned long avail = call->rtt_avail;
 	int rtt_slot = 9;
@@ -161,30 +161,15 @@ static int rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial,
 		goto no_slot;
 
 	call->rtt_serial[rtt_slot] = serial;
-	call->rtt_sent_at[rtt_slot] = ktime_get_real();
+	call->rtt_sent_at[rtt_slot] = now;
 	smp_wmb(); /* Write data before avail bit */
 	set_bit(rtt_slot + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
 
 	trace_rxrpc_rtt_tx(call, why, rtt_slot, serial);
-	return rtt_slot;
+	return;
 
 no_slot:
 	trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_no_slot, rtt_slot, serial);
-	return -1;
-}
-
-/*
- * Cancel an RTT probe.
- */
-static void rxrpc_cancel_rtt_probe(struct rxrpc_call *call,
-				   rxrpc_serial_t serial, int rtt_slot)
-{
-	if (rtt_slot != -1) {
-		clear_bit(rtt_slot + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
-		smp_wmb(); /* Clear pending bit before setting slot */
-		set_bit(rtt_slot, &call->rtt_avail);
-		trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_cancel, rtt_slot, serial);
-	}
 }
 
 /*
@@ -196,7 +181,8 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	struct rxrpc_connection *conn;
 	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
 	struct msghdr msg;
-	int ret, rtt_slot = -1;
+	ktime_t now;
+	int ret;
 
 	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
 		return;
@@ -218,9 +204,6 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 			   ntohl(ack->serial), ack->reason, ack->nAcks,
 			   txb->ack_rwind);
 
-	if (ack->reason == RXRPC_ACK_PING)
-		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_ping);
-
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, txb->len);
@@ -233,16 +216,14 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, whdr,
 				      rxrpc_tx_point_call_ack);
+		now = ktime_get_real();
+		if (ack->reason == RXRPC_ACK_PING)
+			rxrpc_begin_rtt_probe(call, txb->serial, now, rxrpc_rtt_tx_ping);
 		if (txb->flags & RXRPC_REQUEST_ACK)
-			call->peer->rtt_last_req = ktime_get_real();
+			call->peer->rtt_last_req = now;
+		rxrpc_set_keepalive(call, now);
 	}
 	rxrpc_tx_backoff(call, ret);
-
-	if (!__rxrpc_call_is_complete(call)) {
-		if (ret < 0)
-			rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
-		rxrpc_set_keepalive(call);
-	}
 }
 
 /*
@@ -413,18 +394,36 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_tx
 }
 
 /*
- * Set the times on a packet before transmission
+ * Set timeouts after transmitting a packet.
  */
-static int rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
-	ktime_t tstamp = ktime_get_real();
-	int rtt_slot = -1;
+	ktime_t now = ktime_get_real();
+	bool ack_requested = txb->flags & RXRPC_REQUEST_ACK;
 
-	txb->last_sent = tstamp;
-	if (txb->flags & RXRPC_REQUEST_ACK)
-		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
+	call->tx_last_sent = now;
+	txb->last_sent = now;
+
+	if (ack_requested) {
+		rxrpc_begin_rtt_probe(call, txb->serial, now, rxrpc_rtt_tx_data);
+
+		call->peer->rtt_last_req = now;
+		if (call->peer->rtt_count > 1) {
+			ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
 
-	return rtt_slot;
+			call->ack_lost_at = ktime_add(now, delay);
+			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
+		}
+	}
+
+	if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags)) {
+		ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo));
+
+		call->expect_rx_by = ktime_add(now, delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
+	}
+
+	rxrpc_set_keepalive(call, now);
 }
 
 /*
@@ -437,7 +436,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	enum rxrpc_tx_point frag;
 	struct msghdr msg;
 	size_t len;
-	int ret, rtt_slot = -1;
+	int ret;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
 
@@ -479,8 +478,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	}
 
 retry:
-	rtt_slot = rxrpc_tstamp_data_packets(call, txb);
-
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet
 	 *   to go out of the interface
@@ -493,7 +490,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
-		rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret, frag);
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, whdr, frag);
@@ -508,28 +504,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 done:
 	if (ret >= 0) {
-		call->tx_last_sent = txb->last_sent;
-		if (txb->flags & RXRPC_REQUEST_ACK) {
-			call->peer->rtt_last_req = txb->last_sent;
-			if (call->peer->rtt_count > 1) {
-				ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
-				ktime_t now = ktime_get_real();
-
-				call->ack_lost_at = ktime_add(now, delay);
-				trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
-			}
-		}
-
-		if (txb->seq == 1 &&
-		    !test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER,
-				      &call->flags)) {
-			ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo));
-
-			call->expect_rx_by = ktime_add(ktime_get_real(), delay);
-			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
-		}
-
-		rxrpc_set_keepalive(call);
+		rxrpc_tstamp_data_packets(call, txb);
 	} else {
 		/* Cancel the call if the initial transmission fails,
 		 * particularly if that's due to network routing issues that


