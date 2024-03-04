Return-Path: <linux-kernel+bounces-90228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FF86FC2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F054AB20F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A22376EB;
	Mon,  4 Mar 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/EJfGZP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB32942D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541832; cv=none; b=eynC/dz8DvBfrhVQQYKfdqIQ+9bfw6Hcwbfc3QLRX20WwxGWbJkjHmRTldgcE3rq8WQ7bz8WeWBgIPgieVHL5nQv9bUbUwiAYoqLv/PUvY99AF2OMPR5lDlgrw2RQdUd8WXziyteYG4gi2hIPBqAlQ3zX0MDpOzayXkU1HAzyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541832; c=relaxed/simple;
	bh=OQhrdRbsy6dNNd/zZSQhmGvtRjzZYE4Nim/ssYLKPhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFBOQoQiM7OGkNRvMTtURelJinGTIOPdAct9r4QZFT+U8+khoRWErzG/cc1Vk205Zjf9A4svTFF+fEKMBdPUrzdlAYu8Kt1SxOapCo2IuZ1ief+wFytSoUa/2pY06LOFQ33F0puBuL0UTqt3C0RCEr6wTAV1bcJsFrQvmudd5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/EJfGZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xts3XtVON9I71sFj7FzOone2ONVNFLRmYJBbj5l1ezs=;
	b=d/EJfGZPSglbGqOi5UOvuJvMwrDuO7ZtqJZSmnGzMK43YHiR57ZbsIOtMBkMjFkplY08oL
	JgMrQ45I/ZY8E7Erb5w6dLQC5+fkW5CUXW+tpVpR1cPrJPcLzFl4yPZl9fJNHNT2eoftZg
	7At1cvHLrH9FI1G9WQxuLkChGNWiNXc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-O92bpm_xN4y0qHaSFW0Q_Q-1; Mon,
 04 Mar 2024 03:43:46 -0500
X-MC-Unique: O92bpm_xN4y0qHaSFW0Q_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29B1428EA6E3;
	Mon,  4 Mar 2024 08:43:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB5212026D0A;
	Mon,  4 Mar 2024 08:43:44 +0000 (UTC)
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
Subject: [PATCH net-next v2 11/21] rxrpc: Don't pick values out of the wire header when setting up security
Date: Mon,  4 Mar 2024 08:43:08 +0000
Message-ID: <20240304084322.705539-12-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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


