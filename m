Return-Path: <linux-kernel+bounces-20728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B94082844C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E01F24DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8B381A5;
	Tue,  9 Jan 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frodQ1WO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2937162
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704797489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/CmNWkbqIDFvIDkl3GMiU6nPWomwdJGXPThbRcMa9Q8=;
	b=frodQ1WO2ZBVVj17KpQfNmyYuSKxU6rZLatIi7Jrsc2GWRdEbVotMsplLdNwDntjpfdA3Y
	n5FNr2VOcsXRlIMg3V5ViWrKHK88cSphuLdTt8uhYUbLSJWc7KXNFNMw4E9Wl9MxPTecjG
	1QSEWhUwOwLxS4b3iz9RqCpTRKXxFlc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-n2x_G9qcPN-bYUOpldvIQw-1; Tue,
 09 Jan 2024 05:51:26 -0500
X-MC-Unique: n2x_G9qcPN-bYUOpldvIQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 130E738C6240;
	Tue,  9 Jan 2024 10:51:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AECDC1C060AF;
	Tue,  9 Jan 2024 10:51:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix use of Don't Fragment flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1570780.1704797483.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jan 2024 10:51:23 +0000
Message-ID: <1570781.1704797483@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

rxrpc normally has the Don't Fragment flag set on the UDP packets it
transmits, except when it has decided that DATA packets aren't getting
through - in which case it turns it off just for the DATA transmissions.
This can be a problem, however, for RESPONSE packets that convey
authentication and crypto data from the client to the server as ticket may
be larger than can fit in the MTU.

In such a case, rxrpc gets itself into an infinite loop as the sendmsg
returns an error (EMSGSIZE), which causes rxkad_send_response() to return
-EAGAIN - and the CHALLENGE packet is put back on the Rx queue to retry,
leading to the I/O thread endlessly attempting to perform the transmission=
.

Fix this by disabling DF on RESPONSE packets for now.  The use of DF and
best data MTU determination needs reconsidering at some point in the
future.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h  |    1 +
 net/rxrpc/local_object.c |   13 ++++++++++++-
 net/rxrpc/output.c       |    6 ++----
 net/rxrpc/rxkad.c        |    2 ++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e8e14c6f904d..e8b43408136a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1076,6 +1076,7 @@ void rxrpc_send_version_request(struct rxrpc_local *=
local,
 /*
  * local_object.c
  */
+void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set)=
;
 struct rxrpc_local *rxrpc_lookup_local(struct net *, const struct sockadd=
r_rxrpc *);
 struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *, enum rxrpc_loca=
l_trace);
 struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *, enum rxrp=
c_local_trace);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index c553a30e9c83..7a3150482e37 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -36,6 +36,17 @@ static void rxrpc_encap_err_rcv(struct sock *sk, struct=
 sk_buff *skb, int err,
 		return ipv6_icmp_error(sk, skb, err, port, info, payload);
 }
 =

+/*
+ * Set or clear the Don't Fragment flag on a socket.
+ */
+void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set)
+{
+	if (set)
+		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DONT);
+	else
+		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DO);
+}
+
 /*
  * Compare a local to an address.  Return -ve, 0 or +ve to indicate less =
than,
  * same or greater than.
@@ -203,7 +214,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local=
, struct net *net)
 		ip_sock_set_recverr(usk);
 =

 		/* we want to set the don't fragment bit */
-		ip_sock_set_mtu_discover(usk, IP_PMTUDISC_DO);
+		rxrpc_local_dont_fragment(local, true);
 =

 		/* We want receive timestamps. */
 		sock_enable_timestamps(usk);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5e53429c6922..a0906145e829 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -494,14 +494,12 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, =
struct rxrpc_txbuf *txb)
 	switch (conn->local->srx.transport.family) {
 	case AF_INET6:
 	case AF_INET:
-		ip_sock_set_mtu_discover(conn->local->socket->sk,
-					 IP_PMTUDISC_DONT);
+		rxrpc_local_dont_fragment(conn->local, false);
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_frag);
 		ret =3D do_udp_sendmsg(conn->local->socket, &msg, len);
 		conn->peer->last_tx_at =3D ktime_get_seconds();
 =

-		ip_sock_set_mtu_discover(conn->local->socket->sk,
-					 IP_PMTUDISC_DO);
+		rxrpc_local_dont_fragment(conn->local, true);
 		break;
 =

 	default:
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 1bf571a66e02..b52dedcebce0 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -724,7 +724,9 @@ static int rxkad_send_response(struct rxrpc_connection=
 *conn,
 	serial =3D atomic_inc_return(&conn->serial);
 	whdr.serial =3D htonl(serial);
 =

+	rxrpc_local_dont_fragment(conn->local, false);
 	ret =3D kernel_sendmsg(conn->local->socket, &msg, iov, 3, len);
+	rxrpc_local_dont_fragment(conn->local, true);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
 				    rxrpc_tx_point_rxkad_response);


