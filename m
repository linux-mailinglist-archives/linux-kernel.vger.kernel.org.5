Return-Path: <linux-kernel+bounces-90233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4F86FC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F9F1C2140D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BCE3AC34;
	Mon,  4 Mar 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3/KD4HT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BF3A1CA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541845; cv=none; b=JC6ZJuH1NzfVpM9H3PLAe2Ov4NCugXpB6E5QULCeH0kBjsGWqPIwuFYdCsbrM80k4r4mkP8lUh7GMecGIQslsjVmWTphtwpC9KA3DxvhKnJCi82w0wD4dXixWTYUsuYBrz/6n8eRlsB6SkqqUIaFNcYEniYq6lPQxhAbdyebGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541845; c=relaxed/simple;
	bh=ljMsL1C2LYCeeJeMBEdzm9LuanQgXWoC+/BDvOiBmDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqRhd6r9GYJJGCFUNlzsh0+RhnykEHbAfCIXgHInNDvjbyUvvDlzYvcN9GToZwK4NJA/67v1hfrt/EiGCAcY/ld7cmdyeNK+fYkZnQvUrlV1ku5pYAGgU7IVA2ktKPX6epAn8YJa+OquuU2619umDqmdQ63SlUVPWPuI3FTfC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3/KD4HT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5AUx7yIzfKd4QjuMWluENnnnPZkBpDZmSme9BhaoSY=;
	b=L3/KD4HTLahncmtBvuKJbDaGKoWEyRIgGq7mdzhAf8JXOq9ZLiGHGfYm28QkAfA0LzTK2l
	kYj2Dim+qNBjfBEPiT/lQ63c2H2jC6fYITYahe78P84y+RsP6KhBs7hXORxhGYAavhNoAT
	tO/ZSldWm88+48E+ls8cgmS8slCkCGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-1xZjqKa6M8iAdCauiNNf6w-1; Mon, 04 Mar 2024 03:43:59 -0500
X-MC-Unique: 1xZjqKa6M8iAdCauiNNf6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ED3C185A782;
	Mon,  4 Mar 2024 08:43:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C71B7422A9;
	Mon,  4 Mar 2024 08:43:56 +0000 (UTC)
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
Subject: [PATCH net-next v2 15/21] rxrpc: Parse received packets before dealing with timeouts
Date: Mon,  4 Mar 2024 08:43:12 +0000
Message-ID: <20240304084322.705539-16-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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


