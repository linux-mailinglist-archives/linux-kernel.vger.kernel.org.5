Return-Path: <linux-kernel+bounces-93154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CD872B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FB91C2142F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A384E1CC;
	Wed,  6 Mar 2024 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWBr1A5X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B4D502
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683668; cv=none; b=lJh+yVzjE3U7Z4axx5zMI+hj28RUnP8IbyO6boROYbgSk2pwMpK6LfWy8z6EwLUzlIt0g5hY++s/BpHVjjWL1U/ea2Pav4hgnyyMZxGBs9PWR60Qf7XpbFJCU3S4w0nRkZpgnBfB0AvOOBmeZUSO0ID0NwWqW6TUtYaB5UQlyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683668; c=relaxed/simple;
	bh=Hm+gxW/kHadxtc48yXaukCqMew6ym1016BnoNle9pNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiQK7muPJItF5y3A2lL6HG5Pk3ubJG4YxzFbzfF7abZcCJ1seCHw+0gi2PCTEn+SFkL0YoTvHoUt0t0npDPZGghJaQOODoJekQ6sONR6rntUIubXphkmWxcnthw44/Kpx+Jhh6VPniml2PZIpc42rY+GvoyceTo8eUvI3GP2aWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWBr1A5X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXvJfV7xY8fIppX1WMGYdHo1z+U7+tMRhsEec3It9fE=;
	b=fWBr1A5XZVV55rr8RTBeRMpRjPiMRWNk6VYq7SWOYOxCz62Ha2ZtlzI1EDDNHD0jY5OT+O
	xyHyfoeGepx6y96OSqikmkyWy/HUP2QY+FHtBHZmuiTjU5Vt6Hyoan0CCzKrpUTyF+x2N3
	ZH+L5qcjXJcfO0zc56j+GFfziKZAFOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-wQVqNQJKOfu2zPalyVWiFQ-1; Tue, 05 Mar 2024 19:07:42 -0500
X-MC-Unique: wQVqNQJKOfu2zPalyVWiFQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AB67800266;
	Wed,  6 Mar 2024 00:07:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3102B492BCB;
	Wed,  6 Mar 2024 00:07:40 +0000 (UTC)
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
Subject: [PATCH net-next v3 20/21] rxrpc: Clean up the resend algorithm
Date: Wed,  6 Mar 2024 00:06:50 +0000
Message-ID: <20240306000655.1100294-21-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Clean up the DATA packet resending algorithm to retransmit packets as we
come across them whilst walking the transmission buffer rather than queuing
them for retransmission at the end.  This can be done as ACK parsing - and
thus the discarding of successful packets - is now done in the same thread
rather than separately in softirq context and a locked section is no longer
required.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 79 ++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 2a9f74eb7c46..6c5e3054209b 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -71,23 +71,18 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_txbuf *txb;
 	rxrpc_seq_t transmitted = call->tx_transmitted;
-	ktime_t now, max_age, oldest, ack_ts, delay;
-	bool unacked = false;
+	ktime_t next_resend = KTIME_MAX, rto = ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
+	ktime_t resend_at = KTIME_MAX, now, delay;
+	bool unacked = false, did_send = false;
 	unsigned int i;
-	LIST_HEAD(retrans_queue);
 
 	_enter("{%d,%d}", call->acks_hard_ack, call->tx_top);
 
 	now = ktime_get_real();
-	max_age = ktime_sub_us(now, call->peer->rto_us);
-	oldest = now;
 
 	if (list_empty(&call->tx_buffer))
 		goto no_resend;
 
-	if (list_empty(&call->tx_buffer))
-		goto no_further_resend;
-
 	trace_rxrpc_resend(call, ack_skb);
 	txb = list_first_entry(&call->tx_buffer, struct rxrpc_txbuf, call_link);
 
@@ -115,19 +110,23 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 			goto no_further_resend;
 
 		found_txb:
-			if (after(txb->serial, call->acks_highest_serial))
+			resend_at = ktime_add(txb->last_sent, rto);
+			if (after(txb->serial, call->acks_highest_serial)) {
+				if (ktime_after(resend_at, now) &&
+				    ktime_before(resend_at, next_resend))
+					next_resend = resend_at;
 				continue; /* Ack point not yet reached */
+			}
 
 			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
 
-			if (list_empty(&txb->tx_link)) {
-				list_add_tail(&txb->tx_link, &retrans_queue);
-				txb->flags |= RXRPC_TXBUF_RESENT;
-			}
-
 			trace_rxrpc_retransmit(call, txb->seq, txb->serial,
-					       ktime_to_ns(ktime_sub(txb->last_sent,
-								     max_age)));
+					       ktime_sub(resend_at, now));
+
+			txb->flags |= RXRPC_TXBUF_RESENT;
+			rxrpc_transmit_one(call, txb);
+			did_send = true;
+			now = ktime_get_real();
 
 			if (list_is_last(&txb->call_link, &call->tx_buffer))
 				goto no_further_resend;
@@ -144,6 +143,8 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 		goto no_further_resend;
 
 	list_for_each_entry_from(txb, &call->tx_buffer, call_link) {
+		resend_at = ktime_add(txb->last_sent, rto);
+
 		if (before_eq(txb->seq, call->acks_prev_seq))
 			continue;
 		if (after(txb->seq, call->tx_transmitted))
@@ -153,25 +154,30 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 		    before(txb->serial, ntohl(ack->serial)))
 			goto do_resend; /* Wasn't accounted for by a more recent ping. */
 
-		if (ktime_after(txb->last_sent, max_age)) {
-			if (ktime_before(txb->last_sent, oldest))
-				oldest = txb->last_sent;
+		if (ktime_after(resend_at, now)) {
+			if (ktime_before(resend_at, next_resend))
+				next_resend = resend_at;
 			continue;
 		}
 
 	do_resend:
 		unacked = true;
-		if (list_empty(&txb->tx_link)) {
-			list_add_tail(&txb->tx_link, &retrans_queue);
-			txb->flags |= RXRPC_TXBUF_RESENT;
-			rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
-		}
+
+		txb->flags |= RXRPC_TXBUF_RESENT;
+		rxrpc_transmit_one(call, txb);
+		did_send = true;
+		rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
+		now = ktime_get_real();
 	}
 
 no_further_resend:
 no_resend:
-	delay = rxrpc_get_rto_backoff(call->peer, !list_empty(&retrans_queue));
-	call->resend_at = ktime_add(oldest, delay);
+	if (resend_at < KTIME_MAX) {
+		delay = rxrpc_get_rto_backoff(call->peer, did_send);
+		resend_at = ktime_add(resend_at, delay);
+		trace_rxrpc_timer_set(call, resend_at - now, rxrpc_timer_trace_resend_reset);
+	}
+	call->resend_at = resend_at;
 
 	if (unacked)
 		rxrpc_congestion_timeout(call);
@@ -180,24 +186,15 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * that an ACK got lost somewhere.  Send a ping to find out instead of
 	 * retransmitting data.
 	 */
-	if (list_empty(&retrans_queue)) {
-		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend_reset);
-		ack_ts = ktime_sub(now, call->acks_latest_ts);
-		if (ktime_to_us(ack_ts) < (call->peer->srtt_us >> 3))
-			goto out;
-		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
-			       rxrpc_propose_ack_ping_for_0_retrans);
-		goto out;
-	}
+	if (!did_send) {
+		ktime_t next_ping = ktime_add_us(call->acks_latest_ts,
+						 call->peer->srtt_us >> 3);
 
-	/* Retransmit the queue */
-	while ((txb = list_first_entry_or_null(&retrans_queue,
-					       struct rxrpc_txbuf, tx_link))) {
-		list_del_init(&txb->tx_link);
-		rxrpc_transmit_one(call, txb);
+		if (ktime_sub(next_ping, now) <= 0)
+			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
+				       rxrpc_propose_ack_ping_for_0_retrans);
 	}
 
-out:
 	_leave("");
 }
 


