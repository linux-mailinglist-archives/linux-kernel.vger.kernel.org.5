Return-Path: <linux-kernel+bounces-88720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D469886E5CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E5E1F2842E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90062208C4;
	Fri,  1 Mar 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RifoaMDC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF4F9E4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311105; cv=none; b=cvfviWanGWPiAadRBTxOuzMmdPvkc3GTTk5ojnzrSlbavw3DABKyw9nZBo7A+L90JAZlNOabU6R1X/DFx1EvEQtrK/ykzYL9D6FfpkBWaLip9aJEIMxh84P9uFGKwJ0owZpdMBNECaeqiRD2Jz3BhH87UpawtvTwFk03ug8gxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311105; c=relaxed/simple;
	bh=i3aV9zJdURdXtYV6Ok20ZUsYSMXKtbojlDZd884F27M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qURZwuhy0/8yh70+oYKRt3VGxM/dQKG9HLogiXnSTXiBal0y6cuCXxqwKzZdsQCTShu7qSDkLVZyfNu+5px2cik//POdEaYMTsyuNLK17Lff5WOfoZEJI4f3E1AkqQSgXjsJKQLC6ynFtSgKOMQevbdEsDVpH9p6CuANottwXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RifoaMDC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5CCiqcXzsrLEjGrVegk9RIULtgWof6gfdvznJIRmrE=;
	b=RifoaMDCEOfd8wZuAJPUbiU7DjbcWn+Vyow0uTE10yafTB2P1lswYrrECpVqH1gNipdLvK
	92bc7dLrvFzFaDI4Z5ur0+dShFyQW2TSSEYFnj/rKLGor26CRwoM73gvW5jb5bHgHbZ0rt
	OAZpNWd0acu0Wgo2SIJBSAEekuu3AQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-tbYWxxgtNImEfrnLbyyjqA-1; Fri, 01 Mar 2024 11:38:19 -0500
X-MC-Unique: tbYWxxgtNImEfrnLbyyjqA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB1C6185A784;
	Fri,  1 Mar 2024 16:38:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4EA3492BE8;
	Fri,  1 Mar 2024 16:38:17 +0000 (UTC)
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
Subject: [PATCH net-next 04/21] rxrpc: Fix the names of the fields in the ACK trailer struct
Date: Fri,  1 Mar 2024 16:37:36 +0000
Message-ID: <20240301163807.385573-5-dhowells@redhat.com>
In-Reply-To: <20240301163807.385573-1-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From AFS-3.3 a trailer containing extra info was added to the ACK packet
format - but AF_RXRPC has the names of some of the fields mixed up compared
to other AFS implementations.

Rename the struct and the fields to make them match.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/conn_event.c       | 16 ++++++++--------
 net/rxrpc/input.c            | 22 +++++++++++-----------
 net/rxrpc/output.c           | 14 +++++++-------
 net/rxrpc/protocol.h         |  6 +++---
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 33888f688325..c730cd732348 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -83,7 +83,7 @@
 	EM(rxrpc_badmsg_bad_abort,		"bad-abort")		\
 	EM(rxrpc_badmsg_bad_jumbo,		"bad-jumbo")		\
 	EM(rxrpc_badmsg_short_ack,		"short-ack")		\
-	EM(rxrpc_badmsg_short_ack_info,		"short-ack-info")	\
+	EM(rxrpc_badmsg_short_ack_trailer,	"short-ack-trailer")	\
 	EM(rxrpc_badmsg_short_hdr,		"short-hdr")		\
 	EM(rxrpc_badmsg_unsupported_packet,	"unsup-pkt")		\
 	EM(rxrpc_badmsg_zero_call,		"zero-call")		\
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 1f251d758cb9..598b4ee389fc 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -88,7 +88,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 			struct rxrpc_ackpacket ack;
 		};
 	} __attribute__((packed)) pkt;
-	struct rxrpc_ackinfo ack_info;
+	struct rxrpc_acktrailer trailer;
 	size_t len;
 	int ret, ioc;
 	u32 serial, mtu, call_id, padding;
@@ -122,8 +122,8 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	iov[0].iov_len	= sizeof(pkt.whdr);
 	iov[1].iov_base	= &padding;
 	iov[1].iov_len	= 3;
-	iov[2].iov_base	= &ack_info;
-	iov[2].iov_len	= sizeof(ack_info);
+	iov[2].iov_base	= &trailer;
+	iov[2].iov_len	= sizeof(trailer);
 
 	serial = rxrpc_get_next_serial(conn);
 
@@ -158,14 +158,14 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		pkt.ack.serial		= htonl(skb ? sp->hdr.serial : 0);
 		pkt.ack.reason		= skb ? RXRPC_ACK_DUPLICATE : RXRPC_ACK_IDLE;
 		pkt.ack.nAcks		= 0;
-		ack_info.rxMTU		= htonl(rxrpc_rx_mtu);
-		ack_info.maxMTU		= htonl(mtu);
-		ack_info.rwind		= htonl(rxrpc_rx_window_size);
-		ack_info.jumbo_max	= htonl(rxrpc_rx_jumbo_max);
+		trailer.maxMTU		= htonl(rxrpc_rx_mtu);
+		trailer.ifMTU		= htonl(mtu);
+		trailer.rwind		= htonl(rxrpc_rx_window_size);
+		trailer.jumbo_max	= htonl(rxrpc_rx_jumbo_max);
 		pkt.whdr.flags		|= RXRPC_SLOW_START_OK;
 		padding			= 0;
 		iov[0].iov_len += sizeof(pkt.ack);
-		len += sizeof(pkt.ack) + 3 + sizeof(ack_info);
+		len += sizeof(pkt.ack) + 3 + sizeof(trailer);
 		ioc = 3;
 
 		trace_rxrpc_tx_ack(chan->call_debug_id, serial,
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index c435b50c33f4..ea2df62e05e7 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -670,14 +670,14 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 /*
  * Process the extra information that may be appended to an ACK packet
  */
-static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
-				struct rxrpc_ackinfo *ackinfo)
+static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb,
+				    struct rxrpc_acktrailer *trailer)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_peer *peer;
 	unsigned int mtu;
 	bool wake = false;
-	u32 rwind = ntohl(ackinfo->rwind);
+	u32 rwind = ntohl(trailer->rwind);
 
 	if (rwind > RXRPC_TX_MAX_WINDOW)
 		rwind = RXRPC_TX_MAX_WINDOW;
@@ -691,7 +691,7 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
 	if (call->cong_ssthresh > rwind)
 		call->cong_ssthresh = rwind;
 
-	mtu = min(ntohl(ackinfo->rxMTU), ntohl(ackinfo->maxMTU));
+	mtu = min(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
 
 	peer = call->peer;
 	if (mtu < peer->maxdata) {
@@ -837,7 +837,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_ack_summary summary = { 0 };
 	struct rxrpc_ackpacket ack;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_ackinfo info;
+	struct rxrpc_acktrailer trailer;
 	rxrpc_serial_t ack_serial, acked_serial;
 	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt, since;
 	int nr_acks, offset, ioffset;
@@ -917,11 +917,11 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		goto send_response;
 	}
 
-	info.rxMTU = 0;
+	trailer.maxMTU = 0;
 	ioffset = offset + nr_acks + 3;
-	if (skb->len >= ioffset + sizeof(info) &&
-	    skb_copy_bits(skb, ioffset, &info, sizeof(info)) < 0)
-		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_info);
+	if (skb->len >= ioffset + sizeof(trailer) &&
+	    skb_copy_bits(skb, ioffset, &trailer, sizeof(trailer)) < 0)
+		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_trailer);
 
 	if (nr_acks > 0)
 		skb_condense(skb);
@@ -950,8 +950,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	}
 
 	/* Parse rwind and mtu sizes if provided. */
-	if (info.rxMTU)
-		rxrpc_input_ackinfo(call, skb, &info);
+	if (trailer.maxMTU)
+		rxrpc_input_ack_trailer(call, skb, &trailer);
 
 	if (first_soft_ack == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 828b145edc56..3803bf900a46 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -83,7 +83,7 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 				 struct rxrpc_txbuf *txb,
 				 u16 *_rwind)
 {
-	struct rxrpc_ackinfo ackinfo;
+	struct rxrpc_acktrailer trailer;
 	unsigned int qsize, sack, wrap, to;
 	rxrpc_seq_t window, wtop;
 	int rsize;
@@ -126,16 +126,16 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 	qsize = (window - 1) - call->rx_consumed;
 	rsize = max_t(int, call->rx_winsize - qsize, 0);
 	*_rwind = rsize;
-	ackinfo.rxMTU		= htonl(rxrpc_rx_mtu);
-	ackinfo.maxMTU		= htonl(mtu);
-	ackinfo.rwind		= htonl(rsize);
-	ackinfo.jumbo_max	= htonl(jmax);
+	trailer.maxMTU		= htonl(rxrpc_rx_mtu);
+	trailer.ifMTU		= htonl(mtu);
+	trailer.rwind		= htonl(rsize);
+	trailer.jumbo_max	= htonl(jmax);
 
 	*ackp++ = 0;
 	*ackp++ = 0;
 	*ackp++ = 0;
-	memcpy(ackp, &ackinfo, sizeof(ackinfo));
-	return txb->ack.nAcks + 3 + sizeof(ackinfo);
+	memcpy(ackp, &trailer, sizeof(trailer));
+	return txb->ack.nAcks + 3 + sizeof(trailer);
 }
 
 /*
diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index e8ee4af43ca8..4fe6b4d20ada 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -135,9 +135,9 @@ struct rxrpc_ackpacket {
 /*
  * ACK packets can have a further piece of information tagged on the end
  */
-struct rxrpc_ackinfo {
-	__be32		rxMTU;		/* maximum Rx MTU size (bytes) [AFS 3.3] */
-	__be32		maxMTU;		/* maximum interface MTU size (bytes) [AFS 3.3] */
+struct rxrpc_acktrailer {
+	__be32		maxMTU;		/* maximum Rx MTU size (bytes) [AFS 3.3] */
+	__be32		ifMTU;		/* maximum interface MTU size (bytes) [AFS 3.3] */
 	__be32		rwind;		/* Rx window size (packets) [AFS 3.4] */
 	__be32		jumbo_max;	/* max packets to stick into a jumbo packet [AFS 3.5] */
 };


