Return-Path: <linux-kernel+bounces-167807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29618BAF66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A765E2836F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32592154427;
	Fri,  3 May 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuJ0LbOL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCB4B5AE
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748884; cv=none; b=SY5YmFONnUaYEp565TEVuD3i8M1wN9tDGdABnohecN7SiMK4bKc0pzg1chq2AGoWIaCGWHM2zbhWB0jk7R2pixB3Fs12WbWYhnrJ1L2wzzfGAx5Ow1eBlPxUzj7OREc1X9dopq7isZpFh7U9vGp/kM1M19ezX+QqpsbrzWdry2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748884; c=relaxed/simple;
	bh=a04WY93wC1Q9u/Xp3wVEm1Z3RUbJZg15mw89IT36FKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5MkNiVx41qJpt+V5Uz6+Mw5ENoUC+iPYhfX5zXfACIIBiASpn+iKvxT4ZBlST0FKbYqVzFl/Q+dd8xqlquY1ItPd708GXPyFqVfV8HBi3Ory9uKFsKXSczM1cpx+4YQcrT4+Mk1GtPuO8uF7Pzpfi/cElepo+6aLrXbq4fy1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuJ0LbOL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73Lu2SMlm6S7EXBslNAOC6FYTkN/2uFJHjtyqGevXGA=;
	b=RuJ0LbOLmuFcDrfa0R4UIm6hSJCtO0p5ozsANGb0N6G+OLmo+MSGLjD04Rqin93FJGMMSC
	4MwS2nRNCo4rOsF/racSn1p/lCqyXjOtEa/zjOw0+LSJFcTZGEA9LRDol+uRuzbsX1GZOI
	LLTsl5aGjqknvtZR4i4BRQmYbySKEW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-lc_6foBeMTmz1E8PofoNIQ-1; Fri, 03 May 2024 11:07:58 -0400
X-MC-Unique: lc_6foBeMTmz1E8PofoNIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF0C886F03;
	Fri,  3 May 2024 15:07:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2AA22166B31;
	Fri,  3 May 2024 15:07:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Wilkinson <sxw@auristor.com>
Subject: [PATCH net 1/5] rxrpc: Fix congestion control algorithm
Date: Fri,  3 May 2024 16:07:39 +0100
Message-ID: <20240503150749.1001323-2-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Make the following fixes to the congestion control algorithm:

 (1) Don't vary the cwnd starting value by the size of RXRPC_TX_SMSS since
     that's currently held constant - set to the size of a jumbo subpacket
     payload so that we can create jumbo packets on the fly.  The current
     code invariably picks 3 as the starting value.

     Further, the starting cwnd needs to be an even number because we ack
     every other packet, so set it to 4.

 (2) Don't cut ssthresh when we see an ACK come from the peer with a
     receive window (rwind) less than ssthresh.  ssthresh keeps track of
     characteristics of the connection whereas rwind may be reduced by the
     peer for any reason - and may be reduced to 0.

Fixes: 1fc4fa2ac93d ("rxrpc: Fix congestion management")
Fixes: 0851115090a3 ("rxrpc: Reduce ssthresh to peer's receive window")
Signed-off-by: David Howells <dhowells@redhat.com>
Suggested-by: Simon Wilkinson <sxw@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 2 +-
 net/rxrpc/call_object.c | 7 +------
 net/rxrpc/input.c       | 3 ---
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 08c0a32db8c7..08de24658f4f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -697,7 +697,7 @@ struct rxrpc_call {
 	 * packets) rather than bytes.
 	 */
 #define RXRPC_TX_SMSS		RXRPC_JUMBO_DATALEN
-#define RXRPC_MIN_CWND		(RXRPC_TX_SMSS > 2190 ? 2 : RXRPC_TX_SMSS > 1095 ? 3 : 4)
+#define RXRPC_MIN_CWND		4
 	u8			cong_cwnd;	/* Congestion window size */
 	u8			cong_extra;	/* Extra to send for congestion management */
 	u8			cong_ssthresh;	/* Slow-start threshold */
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 01fa71e8b1f7..f9e983a12c14 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -174,12 +174,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	call->rx_winsize = rxrpc_rx_window_size;
 	call->tx_winsize = 16;
 
-	if (RXRPC_TX_SMSS > 2190)
-		call->cong_cwnd = 2;
-	else if (RXRPC_TX_SMSS > 1095)
-		call->cong_cwnd = 3;
-	else
-		call->cong_cwnd = 4;
+	call->cong_cwnd = RXRPC_MIN_CWND;
 	call->cong_ssthresh = RXRPC_TX_MAX_WINDOW;
 
 	call->rxnet = rxnet;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 3dedb8c0618c..860075f1290b 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -685,9 +685,6 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		call->tx_winsize = rwind;
 	}
 
-	if (call->cong_ssthresh > rwind)
-		call->cong_ssthresh = rwind;
-
 	mtu = min(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
 
 	peer = call->peer;


