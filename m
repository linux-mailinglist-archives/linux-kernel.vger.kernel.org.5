Return-Path: <linux-kernel+bounces-88723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B886E5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D89D286DFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65439ACB;
	Fri,  1 Mar 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdg78dNn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06928382
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311111; cv=none; b=L71ZAOq+FWELNC3RtQxKfDDwgBpPPrFs3LW6XWL8lBBU1m37H2AnsvxzFQVpv5PJ7xIBZrtrSZb3UBYesgqiSIK4pffqPI0JQfQMumTjYQHp2g5PlfqZgWi4q5Zax836MjAgBS9DxG8iz+BAqjXC8VYWqNCUMMzddtDtItsCc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311111; c=relaxed/simple;
	bh=LvSy9gNlA8Evtz0FnjAtQm8C7Ali9u71Ylg0oxye8RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEQ8aH102CHV31lvMmQaNvKCRlVR/lo89282vN5ddV9AUInZKutHlQ16PU7fCzXRyJscTBPSfwPK2OdvbUMbyTmL8aATYvX+317tgRdaembqlCKosQwtrMbd9jccdU5iPdyl/ycVaiQpNiZxmzjWRsGX5IABgpWlFul9oTS0eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdg78dNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4F3hxevbUmT5YKtRkYbrij6YAin9EXQUXbHYdfqk2aI=;
	b=fdg78dNn/vX4KZLnqu/acpk+dr++267ytzXq1MZkWEpablzMU6jrCrfggIods0ISIyvzsM
	5gp5pL+sX2dO8NkIfwH2ajclYbP5cSrlvXwczhw6nLCdq4Ix8DvoCZT9rOIHxa9BAa7k02
	aDn8PN4jV7ZsBXofn8J96KZ8A8zXPBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-YTdGUTvPO9yDr_ZQO4AhiQ-1; Fri, 01 Mar 2024 11:38:26 -0500
X-MC-Unique: YTdGUTvPO9yDr_ZQO4AhiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15D7987DC02;
	Fri,  1 Mar 2024 16:38:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA44B1C06532;
	Fri,  1 Mar 2024 16:38:24 +0000 (UTC)
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
Subject: [PATCH net-next 08/21] rxrpc: Merge together DF/non-DF branches of data Tx function
Date: Fri,  1 Mar 2024 16:37:40 +0000
Message-ID: <20240301163807.385573-9-dhowells@redhat.com>
In-Reply-To: <20240301163807.385573-1-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Merge together the DF and non-DF branches of the transmission function and
always set the flag to the right thing before transmitting.  If we see
-EMSGSIZE from udp_sendmsg(), turn off DF and retry.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 54 +++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8aa8ba32eacc..e2c9e645fcfb 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -323,8 +323,9 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
  */
 int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
-	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
+	enum rxrpc_req_ack_trace why;
+	enum rxrpc_tx_point frag;
 	struct msghdr msg;
 	struct kvec iov[1];
 	size_t len;
@@ -405,11 +406,16 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */
-	if (txb->len >= call->peer->maxdata)
-		goto send_fragmentable;
-	rxrpc_local_dont_fragment(conn->local, true);
+	if (txb->len >= call->peer->maxdata) {
+		rxrpc_local_dont_fragment(conn->local, false);
+		frag = rxrpc_tx_point_call_data_frag;
+	} else {
+		rxrpc_local_dont_fragment(conn->local, true);
+		frag = rxrpc_tx_point_call_data_nofrag;
+	}
 
 	txb->wire.flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
+retry:
 	txb->last_sent = ktime_get_real();
 	if (txb->flags & RXRPC_REQUEST_ACK)
 		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
@@ -435,8 +441,11 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	}
 
 	rxrpc_tx_backoff(call, ret);
-	if (ret == -EMSGSIZE)
-		goto send_fragmentable;
+	if (ret == -EMSGSIZE && frag == rxrpc_tx_point_call_data_frag) {
+		rxrpc_local_dont_fragment(conn->local, false);
+		frag = rxrpc_tx_point_call_data_frag;
+		goto retry;
+	}
 
 done:
 	if (ret >= 0) {
@@ -478,39 +487,6 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	_leave(" = %d [%u]", ret, call->peer->maxdata);
 	return ret;
-
-send_fragmentable:
-	/* attempt to send this message with fragmentation enabled */
-	_debug("send fragment");
-
-	txb->last_sent = ktime_get_real();
-	if (txb->flags & RXRPC_REQUEST_ACK)
-		rtt_slot = rxrpc_begin_rtt_probe(call, txb->serial, rxrpc_rtt_tx_data);
-
-	switch (conn->local->srx.transport.family) {
-	case AF_INET6:
-	case AF_INET:
-		rxrpc_local_dont_fragment(conn->local, false);
-		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_frag);
-		ret = do_udp_sendmsg(conn->local->socket, &msg, len);
-		conn->peer->last_tx_at = ktime_get_seconds();
-		break;
-
-	default:
-		BUG();
-	}
-
-	if (ret < 0) {
-		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
-		rxrpc_cancel_rtt_probe(call, txb->serial, rtt_slot);
-		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
-				    rxrpc_tx_point_call_data_frag);
-	} else {
-		trace_rxrpc_tx_packet(call->debug_id, &txb->wire,
-				      rxrpc_tx_point_call_data_frag);
-	}
-	rxrpc_tx_backoff(call, ret);
-	goto done;
 }
 
 /*


