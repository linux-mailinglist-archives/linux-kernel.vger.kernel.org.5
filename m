Return-Path: <linux-kernel+bounces-90224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3A86FC29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1131F22E46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFE28E3C;
	Mon,  4 Mar 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzYW9sCK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE924A04
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541825; cv=none; b=ENg2GjoKQ0KvxHtbiPeg2g73/e/vWymONcelNdh/FnSkazH9pffxDWoxjW4DMGkZu2ORfZba2hu31XIdAACt8VGm7Vg3rzFQ+SZSKkWp1S2ho0Qy0XAJd/qTSFHGfy62WMzYq18GghsEXQ5ILmGKx39gRzu/aF4Qse9731oWmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541825; c=relaxed/simple;
	bh=M4d/FB7CR6JSc+NPeVGOFj1bwk3Vsnoq4ewViEAq+Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnpbqBmDXA03zSEyVyptOjAfhGP5IeYFwnQsZcYLnMixV+SSlfRWR0qqQV6c5fNg4wDLTkqy8oDHZqhq1LpCzk8efYZ9NDUG+bkBZmUjgBXMTTUFybdFRjDrOF6SQU9HcEnVbU6ne0hoJf7ELn79ctrM9Qo9D/4SC4gZx71Y7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzYW9sCK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EZMFPUNWrXNVbCFwmPu2Cto1pVZS1f1ESdtHsSsnJ4=;
	b=ZzYW9sCKWkq8sSdtl6IXsD2jXESJ3cxhoSdRT5UYsQzuFoI2rX3+7vgZ3pvXtB2YJ7Qtvo
	xG+KmvZF0daY/69qRrbdBnNFmsXfYWMtv79B0HHnBSb80Q/T7DCdnLemKkzn6sMhOVz3eD
	gywicsspoKswomdL/+2H+dbjS3AczuQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-yWT9csKpOmmZF7f8PB4x5w-1; Mon,
 04 Mar 2024 03:43:39 -0500
X-MC-Unique: yWT9csKpOmmZF7f8PB4x5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A23C028EA6E4;
	Mon,  4 Mar 2024 08:43:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82129492BE2;
	Mon,  4 Mar 2024 08:43:37 +0000 (UTC)
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
Subject: [PATCH net-next v2 07/21] rxrpc: Do lazy DF flag resetting
Date: Mon,  4 Mar 2024 08:43:04 +0000
Message-ID: <20240304084322.705539-8-dhowells@redhat.com>
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

Don't reset the DF flag after transmission, but rather set it when needed
since it should be a fast op now that we call IP directly.

This includes turning it off for RESPONSE packets and, for the moment, ACK
packets.  In future, we will need to turn it on for ACK packets used to do
path MTU discovery.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 4 ++--
 net/rxrpc/rxkad.c  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 1e039b6f4494..8aa8ba32eacc 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -231,6 +231,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	txb->ack.previousPacket	= htonl(call->rx_highest_seq);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
+	rxrpc_local_dont_fragment(conn->local, false);
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	call->peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0) {
@@ -406,6 +407,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	 * think it's small enough */
 	if (txb->len >= call->peer->maxdata)
 		goto send_fragmentable;
+	rxrpc_local_dont_fragment(conn->local, true);
 
 	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	txb->last_sent = ktime_get_real();
@@ -492,8 +494,6 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_frag);
 		ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 		conn->peer->last_tx_at = ktime_get_seconds();
-
-		rxrpc_local_dont_fragment(conn->local, true);
 		break;
 
 	default:
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 28c9ce763be4..e451ac90bfee 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -726,7 +726,6 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 
 	rxrpc_local_dont_fragment(conn->local, false);
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 3, len);
-	rxrpc_local_dont_fragment(conn->local, true);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
 				    rxrpc_tx_point_rxkad_response);


