Return-Path: <linux-kernel+bounces-90220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F786FC1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09601C20FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935B20DF4;
	Mon,  4 Mar 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmvjlrG8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6701B965
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541818; cv=none; b=grZMlN3cYbp0sNnc7vhyR9wgGoaWC8eZTw1CSajQyJcZX7A2sPHwmSqdCk6pQijevM6XXcvpPAdBdnEMWZnEv3hB0llkZsVjXMXqbrll+xtdCyUC+70B4s6rzsefn7STg4QNGFkVFepi8WAZPXosNPi7nWzvTDEQQVhyPdCqtOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541818; c=relaxed/simple;
	bh=YWox0hlkKOXJP+Kviv9g4eZURamiy3zXGc3RHcp1fE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtHNTMkpMyhF9B+HAEGoQyMX5Atf+AiUBh1+Dd8U86JvspWBGsyDhZX9G4BqG1FooVdWKwfuq2X5H8kDBA29vwOySXkhjGV9w7KcLonC+bT79akNjABzNSE8hxZxTaKEbxMc+8UjVIGPAJl30yjD9FHNU5Y1oOtFoKlxbQkKfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmvjlrG8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMQOrfq9a6ADqnlPZTTmLOdel6QUSyVccUmRoxVrLQY=;
	b=bmvjlrG8RWICeSsJlLn8RFfuQCQ0Doij3kPe8UyIJBOE4t/wJC3yAiSn0Olv3NSZngP54N
	FsOqyr8ybVvNm2WefnMOIkNamp6l6D6NKrJ4aKMbkpy90Px1Qq2xRv8lB3Ffp9UdcXMGTH
	qVxIgDE3/HF+j1HJmV2lAPnr8/FdWC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-Vqfie6JjOu2z3gaRoWZK8g-1; Mon, 04 Mar 2024 03:43:32 -0500
X-MC-Unique: Vqfie6JjOu2z3gaRoWZK8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B06F106D06C;
	Mon,  4 Mar 2024 08:43:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5811C060AF;
	Mon,  4 Mar 2024 08:43:30 +0000 (UTC)
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
Subject: [PATCH net-next v2 03/21] rxrpc: Note cksum in txbuf
Date: Mon,  4 Mar 2024 08:43:00 +0000
Message-ID: <20240304084322.705539-4-dhowells@redhat.com>
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

Add a field to rxrpc_txbuf in which to store the checksum to go in the
header as this may get overwritten in the wire header struct when
transmitting as part of a jumbo packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 1 +
 net/rxrpc/output.c      | 1 +
 net/rxrpc/rxkad.c       | 2 +-
 net/rxrpc/txbuf.c       | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 54d1dc97cb0f..c9a2882627aa 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -803,6 +803,7 @@ struct rxrpc_txbuf {
 	unsigned int		flags;
 #define RXRPC_TXBUF_WIRE_FLAGS	0xff		/* The wire protocol flags */
 #define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
+	__be16			cksum;		/* Checksum to go in header */
 	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
 	struct {
 		/* The packet for encrypting and DMA'ing.  We align it such
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8344ece5358a..828b145edc56 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -335,6 +335,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	/* Each transmission of a Tx packet+ needs a new serial number */
 	txb->serial = rxrpc_get_next_serial(conn);
 	txb->wire.serial = htonl(txb->serial);
+	txb->wire.cksum = txb->cksum;
 
 	if (test_bit(RXRPC_CONN_PROBING_FOR_UPGRADE, &conn->flags) &&
 	    txb->seq == 1)
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 6b32d61d4cdc..28c9ce763be4 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -378,7 +378,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	y = (y >> 16) & 0xffff;
 	if (y == 0)
 		y = 1; /* zero checksums are not permitted */
-	txb->wire.cksum = htons(y);
+	txb->cksum = htons(y);
 
 	switch (call->conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 48d5a8f644e5..7273615afe94 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -35,6 +35,7 @@ struct rxrpc_txbuf *rxrpc_alloc_txbuf(struct rxrpc_call *call, u8 packet_type,
 		txb->ack_why		= 0;
 		txb->seq		= call->tx_prepared + 1;
 		txb->serial		= 0;
+		txb->cksum		= 0;
 		txb->wire.epoch		= htonl(call->conn->proto.epoch);
 		txb->wire.cid		= htonl(call->cid);
 		txb->wire.callNumber	= htonl(call->call_id);


