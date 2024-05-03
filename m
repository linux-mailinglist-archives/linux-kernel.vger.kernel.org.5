Return-Path: <linux-kernel+bounces-167808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD48BAF69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4911F23150
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315915532B;
	Fri,  3 May 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZWNEuut"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB54154C0D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748887; cv=none; b=WzttNaVcRpvIT8rGkLxxXzNjliN6uG+oF0yQQum9PHJmcj+4+QNrxQ50SPaD2lZ0V4sttcShXudjEJhJhbEJuOn/CU8VZkoBv0hUTcxr8CxsVApbux7Ge/B0HK0ZR+8XUE89QSRsBBEa9u/dngbVZun8ycx9NK/hQDP14i6n/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748887; c=relaxed/simple;
	bh=xy1Hw4MswExN1OdkiPVvRVbqAuA98A/1etNQTA0FN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baHzquaY/7wYS2RHdA7pgkuwlxN4Cg9bTVRui/s1lqk2U8xx98h6Gl7AANGO7GndjHPgJ4BWXs6rF17Jx2Jyhd3BolAVTQ65Qy9PwuNR9d4hnxTOsZekFSwWhok2f/BGcIqdoNfvrt9ltwYxtASThW2s4GKg2f8LII8zB+koZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZWNEuut; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9dXy0rv6aK0Lq7IHhwyUaBVQj8j6zmf35k0APaTUmg=;
	b=cZWNEuutvthHJU2DK5Yrfk0DuOUYnPRj9/EwJkicHoOwla5d+1y9VzkORPAjGI/JXvcR9H
	2IuktZ8TI7k75XQQJTk0TapM6kafSvQuz0g6zC2lINjrS6QhCZv3TWIPHTTOMjMLCbm1Dj
	S4uuKl6W8Zq1tGMAZy3Hw2WsptMA0T0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-MU3OpqwHP4CISLIU_yRTww-1; Fri, 03 May 2024 11:08:03 -0400
X-MC-Unique: MU3OpqwHP4CISLIU_yRTww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 165818A9149;
	Fri,  3 May 2024 15:08:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0236D2031A45;
	Fri,  3 May 2024 15:08:01 +0000 (UTC)
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
Subject: [PATCH net 4/5] rxrpc: Change how the MORE-PACKETS rxrpc wire header flag is driven
Date: Fri,  3 May 2024 16:07:42 +0100
Message-ID: <20240503150749.1001323-5-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Currently, the MORE-PACKETS rxrpc header flag is set by sendmsg trying to
guess how it should be set by looking to see if there's space in the Tx
window and setting it if there is - long before the packet gets
transmitted (and it gets left in this state).  As a consequence, it's not
very meaningful.

Change this such that it is turned on at the point of transmission if we
have more packets after it in the send buffers and it is left clear if we
don't yet.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c  | 8 +++++++-
 net/rxrpc/sendmsg.c | 3 ---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index bf2d0f847cdb..4ebd0bd40a02 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -330,7 +330,7 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
-	bool last;
+	bool more, last;
 	u8 flags;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
@@ -345,6 +345,12 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	last = txb->flags & RXRPC_LAST_PACKET;
 
+	more = (!last &&
+		(!list_is_last(&txb->call_link, &call->tx_buffer) ||
+		 !list_empty(&call->tx_sendmsg)));
+	if (more)
+		flags |= RXRPC_MORE_PACKETS;
+
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 894b8fa68e5e..eaf4441a340b 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -384,9 +384,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		    (msg_data_left(msg) == 0 && !more)) {
 			if (msg_data_left(msg) == 0 && !more)
 				txb->flags |= RXRPC_LAST_PACKET;
-			else if (call->tx_top - call->acks_hard_ack <
-				 call->tx_winsize)
-				txb->flags |= RXRPC_MORE_PACKETS;
 
 			ret = call->security->secure_packet(call, txb);
 			if (ret < 0)


