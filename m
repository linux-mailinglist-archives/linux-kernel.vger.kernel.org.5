Return-Path: <linux-kernel+bounces-167810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1C8BAF6B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D741F23084
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E31553A8;
	Fri,  3 May 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6E1rbym"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3F4B5AE
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748889; cv=none; b=UIVuwqKYC42SM5YFzuhRb6wKR0updXAWM9wXH5UesUAT2rIEt83xLIIFG8wLI17IRVM8VbErlWRlLGPgRwBiYc2nLKQv/eOGvhdDAXkQf5GiRIeQFcO35K/f9K1iLLbgvasgVY1gMQNzdoLsMjzDXaA9kuM73jJ99EjZdj6NhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748889; c=relaxed/simple;
	bh=xn2rh9LlyhaIGPpFG0e9zYiDwcKZ6C21cwDR9eSrdE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1OktE58Ki2GlswcUYQrtfh1B+T+/1R0tV3dsh4nrfegT21Vk6LaFQhzRBOLNB1tpqVaUSsf3NUMB+BTISRewZzN6D8XmnsaUHq3wPPVs/w5wLYDgzGbR+N2hX9nXtlMegBKoB7wTnN/HTr5oDt3nvgoqf5KYXv7kdrP6YwBCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6E1rbym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMlLjUMMdAc0lcwR3TeSZQ/924Wu+brmgbf1rQ5fXnk=;
	b=S6E1rbymcHqX4SoRodpvSiS3FhfMnQuIZZXk5qTfXefLnCY8Isj1ssKD4Hj+S3SeF1CgPQ
	EqeIY7UbbfB1fNNGG9awykhKKxnLVlTJt2lxotLy3jHb8IghokL0wWQo7FuyS34zzXC9qq
	T40QUMKmx4eorJMcSjajt1roQn/QtdI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-mU8dl95jPaOJmPb_-padEA-1; Fri,
 03 May 2024 11:08:01 -0400
X-MC-Unique: mU8dl95jPaOJmPb_-padEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D9C01C05AE4;
	Fri,  3 May 2024 15:08:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4872E40C6CC1;
	Fri,  3 May 2024 15:08:00 +0000 (UTC)
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
Subject: [PATCH net 3/5] rxrpc: Clean up Tx header flags generation handling
Date: Fri,  3 May 2024 16:07:41 +0100
Message-ID: <20240503150749.1001323-4-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Clean up the generation of the header flags when building packet headers
for transmission:

 (1) Assemble the flags in a local variable rather than in the txb->flags.

 (2) Do the flags masking and JUMBO-PACKET setting in one bit of code for
     both the main header and the jumbo headers.

 (3) Generate the REQUEST-ACK flag afresh each time.  There's a possibility
     we might want to do jumbo retransmission packets in future.

 (4) Pass the local flags variable to the rxrpc_tx_data tracepoint rather
     than the combination of the txb flags and the wire header flags (the
     latter belong only to the first subpacket).

This makes it easier to clean up setting the MORE-PACKETS flag

Fixes: 44125d5aadda ("rxrpc: Split up the DATA packet transmission function")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  1 -
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/output.c           | 18 ++++++++++++------
 net/rxrpc/proc.c             |  3 +--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index a1b126a6b0d7..7b6c1db53401 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -449,7 +449,6 @@
 
 #define rxrpc_req_ack_traces \
 	EM(rxrpc_reqack_ack_lost,		"ACK-LOST  ")	\
-	EM(rxrpc_reqack_already_on,		"ALREADY-ON")	\
 	EM(rxrpc_reqack_more_rtt,		"MORE-RTT  ")	\
 	EM(rxrpc_reqack_no_srv_last,		"NO-SRVLAST")	\
 	EM(rxrpc_reqack_old_rtt,		"OLD-RTT   ")	\
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 08de24658f4f..c11a6043c8f2 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -110,7 +110,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_acks[256];
 	atomic_t		stat_rx_acks[256];
 
-	atomic_t		stat_why_req_ack[8];
+	atomic_t		stat_why_req_ack[7];
 
 	atomic_t		stat_io_loop;
 };
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5ea9601efd05..bf2d0f847cdb 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -330,6 +330,8 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
+	bool last;
+	u8 flags;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
 
@@ -339,6 +341,10 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	    txb->seq == 1)
 		whdr->userStatus = RXRPC_USERSTATUS_SERVICE_UPGRADE;
 
+	txb->flags &= ~RXRPC_REQUEST_ACK;
+	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
+	last = txb->flags & RXRPC_LAST_PACKET;
+
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
@@ -346,9 +352,7 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	 * service call, lest OpenAFS incorrectly send us an ACK with some
 	 * soft-ACKs in it and then never follow up with a proper hard ACK.
 	 */
-	if (txb->flags & RXRPC_REQUEST_ACK)
-		why = rxrpc_reqack_already_on;
-	else if ((txb->flags & RXRPC_LAST_PACKET) && rxrpc_sending_to_client(txb))
+	if (last && rxrpc_sending_to_client(txb))
 		why = rxrpc_reqack_no_srv_last;
 	else if (test_and_clear_bit(RXRPC_CALL_EV_ACK_LOST, &call->events))
 		why = rxrpc_reqack_ack_lost;
@@ -367,15 +371,17 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 
 	rxrpc_inc_stat(call->rxnet, stat_why_req_ack[why]);
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
-	if (why != rxrpc_reqack_no_srv_last)
+	if (why != rxrpc_reqack_no_srv_last) {
 		txb->flags |= RXRPC_REQUEST_ACK;
+		flags |= RXRPC_REQUEST_ACK;
+	}
 dont_set_request_ack:
 
-	whdr->flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
+	whdr->flags	= flags;
 	whdr->serial	= htonl(txb->serial);
 	whdr->cksum	= txb->cksum;
 
-	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags, false);
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
 }
 
 /*
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 263a2251e3d2..3b7e34dd4385 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -519,9 +519,8 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_DELAY]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]));
 	seq_printf(seq,
-		   "Why-Req-A: acklost=%u already=%u mrtt=%u ortt=%u\n",
+		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),
-		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_already_on]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_more_rtt]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]));
 	seq_printf(seq,


