Return-Path: <linux-kernel+bounces-88733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C486386E5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B8A1C22DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC553D56D;
	Fri,  1 Mar 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWfiPY7N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F493D386
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311131; cv=none; b=a8P+QPhUCbfxp7ty7RSnzI2UShvFGvc0eLFZ8cGT/4pihmKLWBrgjlKD2q0pUx7Bm/ni3CUqmt24j0hU5jEQVxcF7WbTruYrLdedD2iPOGV3tNmIT+iDN972l0NP10fxSmLhoVJS8EMU3t4SF9jWTJNXwAfgjSgNuN4gPFkZj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311131; c=relaxed/simple;
	bh=LtDaQEcUgwlyLQoeDa5Vdh8VqlUPSCUSWH4hyTU1oBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fsx74Sz1gab+MHFdVmgWWlpTFV2qmq3Q3kq2XX5WFEgKJWgY3AoxR4Bx56/A4uPi/od1QO2tal9hzn6HvXqghtBRy6PWIww1iaTfVi2xu0HgiJdhi80hcwk/f7XsEJr7yx3XkW1poLUrHoFTttojjLFcY4iW6KWjfZ8oXaC7gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWfiPY7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkwsEs6LGiGvvVcBvR5BaMQvRZjXx8qXujYu/a9gwf0=;
	b=WWfiPY7Nv9lhZmwT6EZRFn/l6dXnWMc2+fG3mLWhYksS6ne9ljWO8FpcnzAtgr7j4oNsZt
	8vgwP1Ha4ECawTKFWsj8bz/ypi2ZnY0A+9Q0P021q4QhriHRWmsQaW6Tda9/L1bEJbJLS3
	TgRP0eBzBIsurs8zXigSK84m5QyAqwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-ONwiM_IUMpOKitFw7wg-SQ-1; Fri, 01 Mar 2024 11:38:43 -0500
X-MC-Unique: ONwiM_IUMpOKitFw7wg-SQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9875985A58C;
	Fri,  1 Mar 2024 16:38:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC3E492BCD;
	Fri,  1 Mar 2024 16:38:41 +0000 (UTC)
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
Subject: [PATCH net-next 17/21] rxrpc: Differentiate PING ACK transmission traces.
Date: Fri,  1 Mar 2024 16:37:49 +0000
Message-ID: <20240301163807.385573-18-dhowells@redhat.com>
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

There are three points that transmit PING ACKs and all of them use the same
trace string.  Change two of them to use different strings.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 2 ++
 net/rxrpc/call_event.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index c730cd732348..3b726a6c8c42 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -364,11 +364,13 @@
 
 #define rxrpc_propose_ack_traces \
 	EM(rxrpc_propose_ack_client_tx_end,	"ClTxEnd") \
+	EM(rxrpc_propose_ack_delayed_ack,	"DlydAck") \
 	EM(rxrpc_propose_ack_input_data,	"DataIn ") \
 	EM(rxrpc_propose_ack_input_data_hole,	"DataInH") \
 	EM(rxrpc_propose_ack_ping_for_keepalive, "KeepAlv") \
 	EM(rxrpc_propose_ack_ping_for_lost_ack,	"LostAck") \
 	EM(rxrpc_propose_ack_ping_for_lost_reply, "LostRpl") \
+	EM(rxrpc_propose_ack_ping_for_0_retrans, "0-Retrn") \
 	EM(rxrpc_propose_ack_ping_for_old_rtt,	"OldRtt ") \
 	EM(rxrpc_propose_ack_ping_for_params,	"Params ") \
 	EM(rxrpc_propose_ack_ping_for_rtt,	"Rtt    ") \
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index ef28ebf37c7d..bc1a5abb7d6f 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -197,7 +197,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 		if (ktime_to_us(ack_ts) < (call->peer->srtt_us >> 3))
 			goto out;
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
-			       rxrpc_propose_ack_ping_for_lost_ack);
+			       rxrpc_propose_ack_ping_for_0_retrans);
 		goto out;
 	}
 
@@ -387,7 +387,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ack, now);
 		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
-			       rxrpc_propose_ack_ping_for_lost_ack);
+			       rxrpc_propose_ack_delayed_ack);
 	}
 
 	t = call->ack_lost_at;


