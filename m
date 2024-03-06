Return-Path: <linux-kernel+bounces-93145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD380872B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC02B28F41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5818C05;
	Wed,  6 Mar 2024 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID/Iz5jS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF31BF40
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683650; cv=none; b=k0S5zSM7M43RSWRKMbg33aALXtvQ/VVF2Rvn6hphTrK+rpKOHyDAgnI6de9v3X3Om8NFOflOyY9myXRd8bJamM3t1IEa7bPAZXs0OhYhhCnUOKrNCHxPZVjof/TXMqYn8WGi9VSbceX2Ag3IBBWEjg005vdjBbeKgKsvUySG7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683650; c=relaxed/simple;
	bh=OQhrdRbsy6dNNd/zZSQhmGvtRjzZYE4Nim/ssYLKPhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/l0CMRwXY0YbtB+4biY+yYOamJLfgF0yi0fNfintrInBQ+M6lngOIYW0Gf+VqVzHFrI7KwGVR65ORI4BXJzdSZpaSyjZBDPF4mF/5RWbW0EVjMqFKLhBlN9X0fmpmxDToKRvEZvaqJOcWzqKgDwf2oq/Y14uQluVmyYoQTE1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID/Iz5jS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xts3XtVON9I71sFj7FzOone2ONVNFLRmYJBbj5l1ezs=;
	b=ID/Iz5jSP7Wd6X1Um6XVmqie0Wvxet7Cn2RMLAl8bjCCoSl2qXwUBpJ9UTNtOnRindwVTC
	zy7nklsGqzzz99xXxpilxF9VgG0DeiG7Zf8sX0h92+HBQjWCqYjhz0n5mjbe5Q6Yy1xyJW
	bgi6LALZm/5qOIYBLvnpquGHypgHSYs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-sHbOeqp8MgiORDYP7s2xCg-1; Tue,
 05 Mar 2024 19:07:23 -0500
X-MC-Unique: sHbOeqp8MgiORDYP7s2xCg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB4313C02457;
	Wed,  6 Mar 2024 00:07:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A1C9B492BCB;
	Wed,  6 Mar 2024 00:07:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 11/21] rxrpc: Don't pick values out of the wire header when setting up security
Date: Wed,  6 Mar 2024 00:06:41 +0000
Message-ID: <20240306000655.1100294-12-dhowells@redhat.com>
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

Don't pick values out of the wire header in rxkad when setting up DATA
packet security, but rather use other sources.  This makes it easier to get
rid of txb->wire.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/rxkad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index e451ac90bfee..ef0849c8329c 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -259,7 +259,7 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 
 	_enter("");
 
-	check = txb->seq ^ ntohl(txb->wire.callNumber);
+	check = txb->seq ^ call->call_id;
 	hdr->data_size = htonl((u32)check << 16 | txb->len);
 
 	txb->len += sizeof(struct rxkad_level1_hdr);
@@ -302,7 +302,7 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 
 	_enter("");
 
-	check = txb->seq ^ ntohl(txb->wire.callNumber);
+	check = txb->seq ^ call->call_id;
 
 	rxkhdr->data_size = htonl(txb->len | (u32)check << 16);
 	rxkhdr->checksum = 0;
@@ -362,9 +362,9 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	memcpy(&iv, call->conn->rxkad.csum_iv.x, sizeof(iv));
 
 	/* calculate the security checksum */
-	x = (ntohl(txb->wire.cid) & RXRPC_CHANNELMASK) << (32 - RXRPC_CIDSHIFT);
+	x = (call->cid & RXRPC_CHANNELMASK) << (32 - RXRPC_CIDSHIFT);
 	x |= txb->seq & 0x3fffffff;
-	crypto.buf[0] = txb->wire.callNumber;
+	crypto.buf[0] = htonl(call->call_id);
 	crypto.buf[1] = htonl(x);
 
 	sg_init_one(&sg, crypto.buf, 8);


