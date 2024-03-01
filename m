Return-Path: <linux-kernel+bounces-88726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845586E5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57DB283A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB31FDB;
	Fri,  1 Mar 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhjSW31y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9039FDD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311121; cv=none; b=CJH/gDKVzhd7vbxQv5Z/FfMT1EVyobwyQ4/0LKUGmoLA5FoMLr6ZMDmZPga/Fd5YjFSkc2PnZyh1CGmXVGNT4shFQwlJfUYXSoaIg5s/NYyOtB7LnNTpocJiTHY7Cj2QWJPkCZEQOpbooHy+9isRl7vA2MDg7xstfUIGhaB3h4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311121; c=relaxed/simple;
	bh=OQhrdRbsy6dNNd/zZSQhmGvtRjzZYE4Nim/ssYLKPhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja65TpSmbCRF8qnuphOp6sHEEktm2DIG0XCfBacAPYy1gX1Mr5X90XcOI201IxYZM3ftu5Gj5G3VNrPx2NrO2unwCKrBtoQlMQMbTytkQSzFc8wmQg7YMMFSJxqosrsmZtYuyCuUcQDw8jM13ZvqjeSpGWpDG395Us+pYpifhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhjSW31y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xts3XtVON9I71sFj7FzOone2ONVNFLRmYJBbj5l1ezs=;
	b=DhjSW31yK14q5tOvKvNqMCmvzbAAUrTuqOy3DMGENGWsNq+rNfklwMGN5AH2YYDYVfRV1C
	xjr48XtKIQGMOGJcwk4PN1BrjExBNjPA9rretWv3nDr3d1YmV7sYiZBHrKfpX85YBFiezH
	74tKOZ6te+P93rqKk9y5GTYVEh23J3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532--gxOMAYONgKet0F_c8Pwcg-1; Fri, 01 Mar 2024 11:38:34 -0500
X-MC-Unique: -gxOMAYONgKet0F_c8Pwcg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76E0F185A78B;
	Fri,  1 Mar 2024 16:38:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5725F492BE2;
	Fri,  1 Mar 2024 16:38:30 +0000 (UTC)
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
Subject: [PATCH net-next 11/21] rxrpc: Don't pick values out of the wire header when setting up security
Date: Fri,  1 Mar 2024 16:37:43 +0000
Message-ID: <20240301163807.385573-12-dhowells@redhat.com>
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


