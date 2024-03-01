Return-Path: <linux-kernel+bounces-88730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D015386E5E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35995282A51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA33C064;
	Fri,  1 Mar 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfX7g/Om"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88E3B794
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311125; cv=none; b=Qp8AT5wvcQhv4R6qYJ2IImLt3DqZ1clF21yVAdypfSeiyWeI2p4t6Llp29VlwyjDP7ivWxkoO095gVKf+17Shq1pzGK+KDs8C4EdmFfETYM1zhig7NpZvzrloL8SpyDeB0tbMYqzbbz8k17hT4O0N/Kub8PDKvX9AkA7sssNmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311125; c=relaxed/simple;
	bh=ljMsL1C2LYCeeJeMBEdzm9LuanQgXWoC+/BDvOiBmDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEc+iyTtATWhrW6EXxhngop9zrtSYzeYHmylU9zrX6JBmQUF8r1xfzLkJFsTGdHTMAFCJ2p7gP4+WtFLD+y9Vgx+Rj/zI2sMDjfxLtlUflHahy72/C3Rn9/b6mSXPuAssVW2QWJ9+PhoS/eg/+po80NlL2Mn71j4ik3KCap+dGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfX7g/Om; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5AUx7yIzfKd4QjuMWluENnnnPZkBpDZmSme9BhaoSY=;
	b=hfX7g/Omcx1oP4n2aU6JWdn7yHOvSCUCYrRhI5GOppJvxBcZbxrVye/ep9G4kru54h0lKe
	Yu6YCvi1T1BOeWJGtJf6Mh6FbIY5XDtCMluQ3grUsE7fZmBARcCRVVLiTKR6tmxOkkJGvV
	lu6ZnzHyvXJUUA+rPNFxvKgO6om69u4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-daCcSKz9MLKmcO5-yRQspg-1; Fri,
 01 Mar 2024 11:38:39 -0500
X-MC-Unique: daCcSKz9MLKmcO5-yRQspg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F17B3C2E0A4;
	Fri,  1 Mar 2024 16:38:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2554492BE8;
	Fri,  1 Mar 2024 16:38:37 +0000 (UTC)
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
Subject: [PATCH net-next 15/21] rxrpc: Parse received packets before dealing with timeouts
Date: Fri,  1 Mar 2024 16:37:47 +0000
Message-ID: <20240301163807.385573-16-dhowells@redhat.com>
In-Reply-To: <20240301163807.385573-1-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Parse the received packets before going and processing timeouts as the
timeouts may be reset by the reception of a packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index e19ea54dce54..58826710322d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -358,6 +358,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	if (skb && skb->mark == RXRPC_SKB_MARK_ERROR)
 		goto out;
 
+	if (skb)
+		rxrpc_input_call_packet(call, skb);
+
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = jiffies;
 	t = call->expect_rx_by;
@@ -417,9 +420,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		resend = true;
 	}
 
-	if (skb)
-		rxrpc_input_call_packet(call, skb);
-
 	rxrpc_transmit_some_data(call);
 
 	if (skb) {


