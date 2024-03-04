Return-Path: <linux-kernel+bounces-90240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55186FC50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7583CB2253C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBD3D38F;
	Mon,  4 Mar 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gatHDwSg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945133D3A0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541861; cv=none; b=RcIEVb5Vx0vCYgCEDXNBaSbfeobLq5rNnq8NwGwwbVVVK/idOa+8NLRmODv4g0eKfIJ7nWff0nhMjJawhlJKekw2xUhHgUBjtqyXkG1uXqF7P4kcRIJyBOKr/OhCawyRJOv6T7vpMClrYfAkiEuYs6wBuDr2ll32ccabmsF/JAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541861; c=relaxed/simple;
	bh=+YU+DFYa36t0XHlc/+xgZbyWimKd8RtBolX8Ff61bVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9IRU07e6z0Td32N99XyPGwo0KzdOam2WjjhPhqp/+pLSAZvXPchg/0s+N2FK06RpySM/cgQT4DvYNSCqOwAysglo+SbxVYrq8fRNzHygjbybuuFzembqIBckulZA1HoDxQ0zH+4PAywVgZTFDqoMCC/hNXpf3VTGKVmLmg3SGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gatHDwSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5jC1ywkJjQJ57JX0r0EDUWxh8r1trMoZVBFATzsPLw=;
	b=gatHDwSgrGF3vJr0xAXdTlLGPXA4rwNE70W3drCj1MJ9XsH7lxV7C13kSL9ERSGiZh9KGa
	Hn4Z8vPqULPhqHv8+JXzjTdE8BS0qLNblJqJecsog/uYRZjIPVUHetgfyhBzfvz4aXjyN1
	kcKmSZvgEX4GcgetcanNft3kx44RIuc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-IC7ggiR_N1a8xZzWEPyhnQ-1; Mon,
 04 Mar 2024 03:44:15 -0500
X-MC-Unique: IC7ggiR_N1a8xZzWEPyhnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 321C738212CC;
	Mon,  4 Mar 2024 08:44:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11A581C060B1;
	Mon,  4 Mar 2024 08:44:13 +0000 (UTC)
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
Subject: [PATCH net-next v2 21/21] rxrpc: Extract useful fields from a received ACK to skb priv data
Date: Mon,  4 Mar 2024 08:43:18 +0000
Message-ID: <20240304084322.705539-22-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Extract useful fields from a received ACK packet into the skb private data
early on in the process of parsing incoming packets.  This makes the ACK
fields available even before we've matched the ACK up to a call and will
allow us to deal with path MTU discovery probe responses even after the
relevant call has been completed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  7 +++--
 net/rxrpc/call_event.c  |  4 +--
 net/rxrpc/input.c       | 61 ++++++++++++++++++-----------------------
 net/rxrpc/io_thread.c   | 11 ++++++++
 4 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 21ecac22b51d..08c0a32db8c7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -198,8 +198,8 @@ struct rxrpc_host_header {
  * - max 48 bytes (struct sk_buff::cb)
  */
 struct rxrpc_skb_priv {
-	struct rxrpc_connection *conn;	/* Connection referred to (poke packet) */
 	union {
+		struct rxrpc_connection *conn;	/* Connection referred to (poke packet) */
 		struct {
 			u16		offset;		/* Offset of data */
 			u16		len;		/* Length of data */
@@ -208,9 +208,12 @@ struct rxrpc_skb_priv {
 		};
 		struct {
 			rxrpc_seq_t	first_ack;	/* First packet in acks table */
+			rxrpc_seq_t	prev_ack;	/* Highest seq seen */
+			rxrpc_serial_t	acked_serial;	/* Packet in response to (or 0) */
+			u8		reason;		/* Reason for ack */
 			u8		nr_acks;	/* Number of acks+nacks */
 			u8		nr_nacks;	/* Number of nacks */
-		};
+		} ack;
 	};
 	struct rxrpc_host_header hdr;	/* RxRPC packet header from this packet */
 };
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 6c5e3054209b..7bbb68504766 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -93,12 +93,12 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 		sp = rxrpc_skb(ack_skb);
 		ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
 
-		for (i = 0; i < sp->nr_acks; i++) {
+		for (i = 0; i < sp->ack.nr_acks; i++) {
 			rxrpc_seq_t seq;
 
 			if (ack->acks[i] & 1)
 				continue;
-			seq = sp->first_ack + i;
+			seq = sp->ack.first_ack + i;
 			if (after(txb->seq, transmitted))
 				break;
 			if (after(txb->seq, seq))
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 09cce1d5d605..3dedb8c0618c 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -710,20 +710,19 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 					      rxrpc_seq_t seq)
 {
 	struct sk_buff *skb = call->cong_last_nack;
-	struct rxrpc_ackpacket ack;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	unsigned int i, new_acks = 0, retained_nacks = 0;
-	rxrpc_seq_t old_seq = sp->first_ack;
-	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(ack);
+	rxrpc_seq_t old_seq = sp->ack.first_ack;
+	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
-	if (after_eq(seq, old_seq + sp->nr_acks)) {
-		summary->nr_new_acks += sp->nr_nacks;
-		summary->nr_new_acks += seq - (old_seq + sp->nr_acks);
+	if (after_eq(seq, old_seq + sp->ack.nr_acks)) {
+		summary->nr_new_acks += sp->ack.nr_nacks;
+		summary->nr_new_acks += seq - (old_seq + sp->ack.nr_acks);
 		summary->nr_retained_nacks = 0;
 	} else if (seq == old_seq) {
-		summary->nr_retained_nacks = sp->nr_nacks;
+		summary->nr_retained_nacks = sp->ack.nr_nacks;
 	} else {
-		for (i = 0; i < sp->nr_acks; i++) {
+		for (i = 0; i < sp->ack.nr_acks; i++) {
 			if (acks[i] == RXRPC_ACK_TYPE_NACK) {
 				if (before(old_seq + i, seq))
 					new_acks++;
@@ -736,7 +735,7 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 		summary->nr_retained_nacks = retained_nacks;
 	}
 
-	return old_seq + sp->nr_acks;
+	return old_seq + sp->ack.nr_acks;
 }
 
 /*
@@ -756,10 +755,10 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	unsigned int i, old_nacks = 0;
-	rxrpc_seq_t lowest_nak = seq + sp->nr_acks;
+	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
 	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
-	for (i = 0; i < sp->nr_acks; i++) {
+	for (i = 0; i < sp->ack.nr_acks; i++) {
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
 			summary->nr_acks++;
 			if (after_eq(seq, since))
@@ -771,7 +770,7 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 				old_nacks++;
 			} else {
 				summary->nr_new_nacks++;
-				sp->nr_nacks++;
+				sp->ack.nr_nacks++;
 			}
 
 			if (before(seq, lowest_nak))
@@ -832,7 +831,6 @@ static bool rxrpc_is_ack_valid(struct rxrpc_call *call,
 static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
-	struct rxrpc_ackpacket ack;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_acktrailer trailer;
 	rxrpc_serial_t ack_serial, acked_serial;
@@ -841,29 +839,24 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 
 	_enter("");
 
-	offset = sizeof(struct rxrpc_wire_header);
-	if (skb_copy_bits(skb, offset, &ack, sizeof(ack)) < 0)
-		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack);
-	offset += sizeof(ack);
-
-	ack_serial = sp->hdr.serial;
-	acked_serial = ntohl(ack.serial);
-	first_soft_ack = ntohl(ack.firstPacket);
-	prev_pkt = ntohl(ack.previousPacket);
-	hard_ack = first_soft_ack - 1;
-	nr_acks = ack.nAcks;
-	sp->first_ack = first_soft_ack;
-	sp->nr_acks = nr_acks;
-	summary.ack_reason = (ack.reason < RXRPC_ACK__INVALID ?
-			      ack.reason : RXRPC_ACK__INVALID);
+	offset = sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
+
+	ack_serial	= sp->hdr.serial;
+	acked_serial	= sp->ack.acked_serial;
+	first_soft_ack	= sp->ack.first_ack;
+	prev_pkt	= sp->ack.prev_ack;
+	nr_acks		= sp->ack.nr_acks;
+	hard_ack	= first_soft_ack - 1;
+	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
+			      sp->ack.reason : RXRPC_ACK__INVALID);
 
 	trace_rxrpc_rx_ack(call, ack_serial, acked_serial,
 			   first_soft_ack, prev_pkt,
 			   summary.ack_reason, nr_acks);
-	rxrpc_inc_stat(call->rxnet, stat_rx_acks[ack.reason]);
+	rxrpc_inc_stat(call->rxnet, stat_rx_acks[summary.ack_reason]);
 
 	if (acked_serial != 0) {
-		switch (ack.reason) {
+		switch (summary.ack_reason) {
 		case RXRPC_ACK_PING_RESPONSE:
 			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
 						 rxrpc_rtt_rx_ping_response);
@@ -883,7 +876,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	 * indicates that the client address changed due to NAT.  The server
 	 * lost the call because it switched to a different peer.
 	 */
-	if (unlikely(ack.reason == RXRPC_ACK_EXCEEDS_WINDOW) &&
+	if (unlikely(summary.ack_reason == RXRPC_ACK_EXCEEDS_WINDOW) &&
 	    first_soft_ack == 1 &&
 	    prev_pkt == 0 &&
 	    rxrpc_is_client_call(call)) {
@@ -896,7 +889,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	 * indicate a change of address.  However, we can retransmit the call
 	 * if we still have it buffered to the beginning.
 	 */
-	if (unlikely(ack.reason == RXRPC_ACK_OUT_OF_SEQUENCE) &&
+	if (unlikely(summary.ack_reason == RXRPC_ACK_OUT_OF_SEQUENCE) &&
 	    first_soft_ack == 1 &&
 	    prev_pkt == 0 &&
 	    call->acks_hard_ack == 0 &&
@@ -937,7 +930,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	call->acks_first_seq = first_soft_ack;
 	call->acks_prev_seq = prev_pkt;
 
-	switch (ack.reason) {
+	switch (summary.ack_reason) {
 	case RXRPC_ACK_PING:
 		break;
 	default:
@@ -994,7 +987,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	rxrpc_congestion_management(call, skb, &summary, acked_serial);
 
 send_response:
-	if (ack.reason == RXRPC_ACK_PING)
+	if (summary.ack_reason == RXRPC_ACK_PING)
 		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, ack_serial,
 			       rxrpc_propose_ack_respond_to_ping);
 	else if (sp->hdr.flags & RXRPC_REQUEST_ACK)
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 4a3a08a0e2cd..0300baa9afcd 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -124,6 +124,7 @@ static bool rxrpc_extract_header(struct rxrpc_skb_priv *sp,
 				 struct sk_buff *skb)
 {
 	struct rxrpc_wire_header whdr;
+	struct rxrpc_ackpacket ack;
 
 	/* dig out the RxRPC connection details */
 	if (skb_copy_bits(skb, 0, &whdr, sizeof(whdr)) < 0)
@@ -141,6 +142,16 @@ static bool rxrpc_extract_header(struct rxrpc_skb_priv *sp,
 	sp->hdr.securityIndex	= whdr.securityIndex;
 	sp->hdr._rsvd		= ntohs(whdr._rsvd);
 	sp->hdr.serviceId	= ntohs(whdr.serviceId);
+
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_ACK) {
+		if (skb_copy_bits(skb, sizeof(whdr), &ack, sizeof(ack)) < 0)
+			return rxrpc_bad_message(skb, rxrpc_badmsg_short_ack);
+		sp->ack.first_ack	= ntohl(ack.firstPacket);
+		sp->ack.prev_ack	= ntohl(ack.previousPacket);
+		sp->ack.acked_serial	= ntohl(ack.serial);
+		sp->ack.reason		= ack.reason;
+		sp->ack.nr_acks		= ack.nAcks;
+	}
 	return true;
 }
 


