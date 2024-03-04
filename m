Return-Path: <linux-kernel+bounces-90221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9586FC22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEF41F22BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A7225DA;
	Mon,  4 Mar 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP8G97u6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CF20B33
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541820; cv=none; b=pX8taL3QtFtBz5ED3MKhPE78n+R/otXKuvC8IZZHmP9WAD8pSqGk0lu76+XtTNa+iaN2uAd8zJyAZ9wmFML+p+UcpA5vEMWjYNM3gP3ErIlfqKVco3/STs4eWPE0HmTrXWiZI5lQXwh9blS6h1ysQV95CVoFhNnem54p4ppNqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541820; c=relaxed/simple;
	bh=MQ2ZFjtue/mlbT3gPUeVjpfqMS/NxZ1JCX8pts1RXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTKn83n441FJkrUwXkmVPl6mYGtHcS2K5Pn4VKivHM6BDjrUcH3yYm10jEpzfiYeU/Fm7VA6kVfJ418hlK4V8RhFmrb0SSL3q7z64R9wSH2EldxlHlqCMqZ5yxUC3S0t4xW0YmawtEocJiHlkYd++wVVUuZLpDfbJj6vggM5544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OP8G97u6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccm9SVhd+bAluRvWjYsOnhrUMg2QaaHeYK4kvnT54uM=;
	b=OP8G97u6mFthM1KctO1oBB6sjrIUpmTmdZ/NyhYwCSr+w2zxaU+udYsNlnXjVUiNtOTnU9
	AjyMennTYHdX/p6U/oWx7XvchZdZiOsFicPPDeX2HGBYDzIH6Uofj63AVXB1zka6Oay3WA
	vFQktdhKrStZFz6AdLDwCHTganTWswg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-8tstsTf1Mc6VqNP5HQCJ2g-1; Mon,
 04 Mar 2024 03:43:35 -0500
X-MC-Unique: 8tstsTf1Mc6VqNP5HQCJ2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17BF738212C1;
	Mon,  4 Mar 2024 08:43:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E91CD40C6EBA;
	Mon,  4 Mar 2024 08:43:33 +0000 (UTC)
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
Subject: [PATCH net-next v2 05/21] rxrpc: Strip barriers and atomics off of timer tracking
Date: Mon,  4 Mar 2024 08:43:02 +0000
Message-ID: <20240304084322.705539-6-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Strip the atomic ops and barriering off of the call timer tracking as this
is handled solely within the I/O thread, except for expect_term_by which is
set by sendmsg().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c  | 32 ++++++++++++++++----------------
 net/rxrpc/conn_client.c |  4 ++--
 net/rxrpc/input.c       | 15 ++++++---------
 net/rxrpc/output.c      | 18 ++++++++----------
 4 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 77eacbfc5d45..84eedbb49fcb 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -27,7 +27,7 @@ void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 	unsigned long ping_at = now + rxrpc_idle_ack_delay;
 
 	if (time_before(ping_at, call->ping_at)) {
-		WRITE_ONCE(call->ping_at, ping_at);
+		call->ping_at = ping_at;
 		rxrpc_reduce_call_timer(call, ping_at, now,
 					rxrpc_timer_set_for_ping);
 		trace_rxrpc_propose_ack(call, why, RXRPC_ACK_PING, serial);
@@ -53,7 +53,7 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	ack_at += READ_ONCE(call->tx_backoff);
 	ack_at += now;
 	if (time_before(ack_at, call->delay_ack_at)) {
-		WRITE_ONCE(call->delay_ack_at, ack_at);
+		call->delay_ack_at = ack_at;
 		rxrpc_reduce_call_timer(call, ack_at, now,
 					rxrpc_timer_set_for_ack);
 	}
@@ -220,7 +220,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
 	resend_at += jiffies + rxrpc_get_rto_backoff(call->peer,
 						     !list_empty(&retrans_queue));
-	WRITE_ONCE(call->resend_at, resend_at);
+	call->resend_at = resend_at;
 
 	if (unacked)
 		rxrpc_congestion_timeout(call);
@@ -260,7 +260,7 @@ static void rxrpc_begin_service_reply(struct rxrpc_call *call)
 	unsigned long now = jiffies;
 
 	rxrpc_set_call_state(call, RXRPC_CALL_SERVER_SEND_REPLY);
-	WRITE_ONCE(call->delay_ack_at, now + MAX_JIFFY_OFFSET);
+	call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 	if (call->ackr_reason == RXRPC_ACK_DELAY)
 		call->ackr_reason = 0;
 	trace_rxrpc_timer(call, rxrpc_timer_init_for_send_reply, now);
@@ -399,13 +399,13 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = jiffies;
-	t = READ_ONCE(call->expect_rx_by);
+	t = call->expect_rx_by;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_normal, now);
 		expired = true;
 	}
 
-	t = READ_ONCE(call->expect_req_by);
+	t = call->expect_req_by;
 	if (__rxrpc_call_state(call) == RXRPC_CALL_SERVER_RECV_REQUEST &&
 	    time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_idle, now);
@@ -418,41 +418,41 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		expired = true;
 	}
 
-	t = READ_ONCE(call->delay_ack_at);
+	t = call->delay_ack_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ack, now);
-		cmpxchg(&call->delay_ack_at, t, now + MAX_JIFFY_OFFSET);
+		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 	}
 
-	t = READ_ONCE(call->ack_lost_at);
+	t = call->ack_lost_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_lost_ack, now);
-		cmpxchg(&call->ack_lost_at, t, now + MAX_JIFFY_OFFSET);
+		call->ack_lost_at = now + MAX_JIFFY_OFFSET;
 		set_bit(RXRPC_CALL_EV_ACK_LOST, &call->events);
 	}
 
-	t = READ_ONCE(call->keepalive_at);
+	t = call->keepalive_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_keepalive, now);
-		cmpxchg(&call->keepalive_at, t, now + MAX_JIFFY_OFFSET);
+		call->keepalive_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	t = READ_ONCE(call->ping_at);
+	t = call->ping_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ping, now);
-		cmpxchg(&call->ping_at, t, now + MAX_JIFFY_OFFSET);
+		call->ping_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	t = READ_ONCE(call->resend_at);
+	t = call->resend_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_resend, now);
-		cmpxchg(&call->resend_at, t, now + MAX_JIFFY_OFFSET);
+		call->resend_at = now + MAX_JIFFY_OFFSET;
 		resend = true;
 	}
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 3b9b267a4431..d25bf1cf3670 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -636,7 +636,7 @@ void rxrpc_disconnect_client_call(struct rxrpc_bundle *bundle, struct rxrpc_call
 	    test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
 		unsigned long final_ack_at = jiffies + 2;
 
-		WRITE_ONCE(chan->final_ack_at, final_ack_at);
+		chan->final_ack_at = final_ack_at;
 		smp_wmb(); /* vs rxrpc_process_delayed_final_acks() */
 		set_bit(RXRPC_CONN_FINAL_ACK_0 + channel, &conn->flags);
 		rxrpc_reduce_conn_timer(conn, final_ack_at);
@@ -770,7 +770,7 @@ void rxrpc_discard_expired_client_conns(struct rxrpc_local *local)
 
 		conn_expires_at = conn->idle_timestamp + expiry;
 
-		now = READ_ONCE(jiffies);
+		now = jiffies;
 		if (time_after(conn_expires_at, now))
 			goto not_yet_expired;
 	}
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index ea2df62e05e7..e53a49accc16 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -288,14 +288,12 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 {
 	struct rxrpc_ack_summary summary = { 0 };
-	unsigned long now, timo;
+	unsigned long now;
 	rxrpc_seq_t top = READ_ONCE(call->tx_top);
 
 	if (call->ackr_reason) {
 		now = jiffies;
-		timo = now + MAX_JIFFY_OFFSET;
-
-		WRITE_ONCE(call->delay_ack_at, timo);
+		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 		trace_rxrpc_timer(call, rxrpc_timer_init_for_reply, now);
 	}
 
@@ -594,7 +592,7 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
 		if (timo) {
 			now = jiffies;
 			expect_req_by = now + timo;
-			WRITE_ONCE(call->expect_req_by, expect_req_by);
+			call->expect_req_by = now + timo;
 			rxrpc_reduce_call_timer(call, expect_req_by, now,
 						rxrpc_timer_set_for_idle);
 		}
@@ -1048,11 +1046,10 @@ void rxrpc_input_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
 
 	timo = READ_ONCE(call->next_rx_timo);
 	if (timo) {
-		unsigned long now = jiffies, expect_rx_by;
+		unsigned long now = jiffies;
 
-		expect_rx_by = now + timo;
-		WRITE_ONCE(call->expect_rx_by, expect_rx_by);
-		rxrpc_reduce_call_timer(call, expect_rx_by, now,
+		call->expect_rx_by = now + timo;
+		rxrpc_reduce_call_timer(call, call->expect_rx_by, now,
 					rxrpc_timer_set_for_normal);
 	}
 
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 3803bf900a46..2386b01b2231 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -67,11 +67,10 @@ static void rxrpc_tx_backoff(struct rxrpc_call *call, int ret)
  */
 static void rxrpc_set_keepalive(struct rxrpc_call *call)
 {
-	unsigned long now = jiffies, keepalive_at = call->next_rx_timo / 6;
+	unsigned long now = jiffies;
 
-	keepalive_at += now;
-	WRITE_ONCE(call->keepalive_at, keepalive_at);
-	rxrpc_reduce_call_timer(call, keepalive_at, now,
+	call->keepalive_at = now + call->next_rx_timo / 6;
+	rxrpc_reduce_call_timer(call, call->keepalive_at, now,
 				rxrpc_timer_set_for_keepalive);
 }
 
@@ -449,7 +448,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 				ack_lost_at = rxrpc_get_rto_backoff(call->peer, false);
 				ack_lost_at += nowj;
-				WRITE_ONCE(call->ack_lost_at, ack_lost_at);
+				call->ack_lost_at = ack_lost_at;
 				rxrpc_reduce_call_timer(call, ack_lost_at, nowj,
 							rxrpc_timer_set_for_lost_ack);
 			}
@@ -458,11 +457,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		if (txb->seq == 1 &&
 		    !test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER,
 				      &call->flags)) {
-			unsigned long nowj = jiffies, expect_rx_by;
+			unsigned long nowj = jiffies;
 
-			expect_rx_by = nowj + call->next_rx_timo;
-			WRITE_ONCE(call->expect_rx_by, expect_rx_by);
-			rxrpc_reduce_call_timer(call, expect_rx_by, nowj,
+			call->expect_rx_by = nowj + call->next_rx_timo;
+			rxrpc_reduce_call_timer(call, call->expect_rx_by, nowj,
 						rxrpc_timer_set_for_normal);
 		}
 
@@ -724,7 +722,7 @@ void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		unsigned long now = jiffies;
 		unsigned long resend_at = now + call->peer->rto_j;
 
-		WRITE_ONCE(call->resend_at, resend_at);
+		call->resend_at = resend_at;
 		rxrpc_reduce_call_timer(call, resend_at, now,
 					rxrpc_timer_set_for_send);
 	}


