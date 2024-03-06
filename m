Return-Path: <linux-kernel+bounces-93151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CD872B98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60B81F2BDFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872B2AEE4;
	Wed,  6 Mar 2024 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5vWRqVs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5ED502
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683661; cv=none; b=mB/0866KaQ8+9O7nue5IZxZDsuym69dZaut0DCJsyvYB2MbNARfGwCMPZyG7kE3+tMfpM78PglDsbn8u/wwGNcjK3AJLJ8+MOH1FM1iR28Vlli8wk0CMWd2euqO4d0qnAgeg4D3pMxOP0bK1Hm+yoMn8246QrvNlb7POa8ISHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683661; c=relaxed/simple;
	bh=LtDaQEcUgwlyLQoeDa5Vdh8VqlUPSCUSWH4hyTU1oBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXt5mF6WEe5xVIn4vXQJ5sc7Al2maWAyp1h4Wsjg3mhkpBtW4lM4iF1jIr4r6y2mzYrBJ8ygqQrIdrQZ9omAAsV+7Es5rtcY+ggWgzTXvh1KNAjqZHifpxKMXNele9BGvAK6ApdmnWczvQYuEgI+BRKhJDDCxy0HhBxCE5OPT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5vWRqVs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkwsEs6LGiGvvVcBvR5BaMQvRZjXx8qXujYu/a9gwf0=;
	b=C5vWRqVsYIUxIu1w6vYntVJ24VBRvXsopHnLtc5DRBu4Xrq5HaZjwseGMhyPC/XcPQ8tiw
	JcjfHdJa/POP/UqZmbGyzMYCrmxJKy/WYdXCWjMfj9AILrwYTRKBCVgXP1UFe5K2dfqwUo
	iA3g8AcVMoCfdwpvwCMoDKQjekmAv+E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-qUo52Z1HML-XfWeUHlZUrw-1; Tue,
 05 Mar 2024 19:07:36 -0500
X-MC-Unique: qUo52Z1HML-XfWeUHlZUrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3266A1C02D33;
	Wed,  6 Mar 2024 00:07:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF5BC2022AB6;
	Wed,  6 Mar 2024 00:07:33 +0000 (UTC)
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
Subject: [PATCH net-next v3 17/21] rxrpc: Differentiate PING ACK transmission traces.
Date: Wed,  6 Mar 2024 00:06:47 +0000
Message-ID: <20240306000655.1100294-18-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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


