Return-Path: <linux-kernel+bounces-93137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F021872B7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909D51C23638
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154B14267;
	Wed,  6 Mar 2024 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlZ0V9Oy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896DDDA8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683633; cv=none; b=dfih4lIqJ9CowqQuJCF9+rgu5X9mwASdMnXpa17jwHau1xoq0Dv73C3ANpfuDhf9muli9K2xolakn8We6QVPMygndak5w0I6qKbjaTRuEdavN9kvnFRv8//upqeJFrBLfsiaabGgtVtnBUF+AIuom75nqZVo5Ire4r/tsL8TZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683633; c=relaxed/simple;
	bh=YWox0hlkKOXJP+Kviv9g4eZURamiy3zXGc3RHcp1fE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6MtcLPgNKE7vYnVJ2TwU67hp9f3X2kQ2TlPbe7MZ02lgrvAGadhTmA/H8rr8xU2o3+uBZkTcDDF3TIUbzHFbd7y0DRKLEntb4ibj0oFwA3LMFryP5UmTnj+BDgkTgoWLgw5+fZoRHxRT1neIXKnEgaWOQkk5bJbxoPaPEghOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlZ0V9Oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMQOrfq9a6ADqnlPZTTmLOdel6QUSyVccUmRoxVrLQY=;
	b=AlZ0V9OyfASo6emT8U0Jmp2k9tXkoL9610SJ9/kEm/9BQE3iihkQwxbc6ofSQfvfFPjvEp
	5Jl30/oXlI06xqkKroB1m198FkL9lyxYIU26ykU97qwDKFY1VtT6ZUrAZ+KzuX7gleUCB7
	J8c/Nb3p1pyVUM23tkvmfpXoZvA8Z40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-MhKzk3A4Paywk8l8CA81tQ-1; Tue, 05 Mar 2024 19:07:07 -0500
X-MC-Unique: MhKzk3A4Paywk8l8CA81tQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 207BE101A586;
	Wed,  6 Mar 2024 00:07:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC3A0492BCB;
	Wed,  6 Mar 2024 00:07:05 +0000 (UTC)
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
Subject: [PATCH net-next v3 03/21] rxrpc: Note cksum in txbuf
Date: Wed,  6 Mar 2024 00:06:33 +0000
Message-ID: <20240306000655.1100294-4-dhowells@redhat.com>
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


