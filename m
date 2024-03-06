Return-Path: <linux-kernel+bounces-93143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39314872B88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4461C230F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F21C6A0;
	Wed,  6 Mar 2024 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUP+LOvG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAD1BF38
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683647; cv=none; b=HU5lWMIl2y98txQa7blV8EStSIV/8SStmjPzfAlsB34KufkCW6RRXH9Y3knrFWHkfs5T/by66RSomlYU6loejFNRQ23DY+Yud8W14V3cY2UvXBd6pJZb5SCFnjTotKc9olYWrVZlogRNhEs4fMeuqhthvXD1SNF+PMfOvz/yXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683647; c=relaxed/simple;
	bh=M4d/FB7CR6JSc+NPeVGOFj1bwk3Vsnoq4ewViEAq+Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLgJNSZhUZHFTsx16O0RvTADWj6eyEdS71SiTRK5QS6fiSR7NR+VHOXz6N0Tw6rpp5XzTwZhokCvc1KiVb1RiQBJL1IHvuMQqT44jCJGeLp9Q3nvOBWUSK180c690vr2ZK3ciT/vetyeWWYaHBuwtseTL2O917Me1jeLFHGLI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUP+LOvG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EZMFPUNWrXNVbCFwmPu2Cto1pVZS1f1ESdtHsSsnJ4=;
	b=LUP+LOvGXz7zUAjmR2D0NQrfFx2bixpTSfknc/gLk01EORdRPNmapRy8aSJdygKVaw4Nk3
	PsVwPnnK89aiA5Hp6Am16+KmohRcHs8p+mHaGSKdwJSKnXgPoWiq5M60YCq13Xic6y3Dd9
	EIEaVi6K/pqyQeHXzVeuMGQOK9+VlS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-vWX6O6QNMlm60D9BEIJqyQ-1; Tue,
 05 Mar 2024 19:07:17 -0500
X-MC-Unique: vWX6O6QNMlm60D9BEIJqyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C1862825BAC;
	Wed,  6 Mar 2024 00:07:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8379111DD02;
	Wed,  6 Mar 2024 00:07:13 +0000 (UTC)
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
Subject: [PATCH net-next v3 07/21] rxrpc: Do lazy DF flag resetting
Date: Wed,  6 Mar 2024 00:06:37 +0000
Message-ID: <20240306000655.1100294-8-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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


