Return-Path: <linux-kernel+bounces-167809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E191A8BAF6A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7187A283757
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43D15534D;
	Fri,  3 May 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo43FpnQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EE1552E6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748888; cv=none; b=l4BIrMT29QYPmpUSNQ51dvkjI64KJpbaPoH9+3lOtnce04jiT3I0DLeguOP+hdYcN2l70reg3HkFBJjzW5CvGRVlmZDDc6QTdIfI/TI3f8nJ0IAEKFmqJME5koVvE92Y+whXiwHEd9HHbMS4fSi4UF39KhJtmEdQ3Pp9Q1l46mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748888; c=relaxed/simple;
	bh=GnhpOLXvRLldnCIASPiLgroMYknUVlYXZj8RJslF1fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJWyTIT4abnvpvRK+4t1m5ZSXqdQhsL6Rzb9sn8p5FztOCJOvzOZ19j63E0EoPIxvfdtc5Y2MjTb9yoo1such5FHyxJiheoUk+yN0GIzHEQdYsFbOHXPIwvxtDQWcrC4PImnqcWJDM5pNhYR5YRrx91fx1/5JAWbv/QwVCiNxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fo43FpnQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTb9af+gzWhiLN/riMtCV8Co6848NoN7U7KAvhUbVSI=;
	b=Fo43FpnQQUIGYZiBhQqqpMCjMAyMMintQycjkmylYeC9CJx+9jPocz7RSn98qBl7nyGGLQ
	7Eorr2z6ggJZ0KowfIHAk3GsH8hsHPzH4B5xZiQ9Wlz3/eq7OzVaxNkxt8fIhRa+9fVuzX
	CA4XbsWHi7/4tA2MMrNz+3EP+NcXHT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-JvH7OHQwP-iKPzcoSL688g-1; Fri, 03 May 2024 11:08:00 -0400
X-MC-Unique: JvH7OHQwP-iKPzcoSL688g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 920B1800C8A;
	Fri,  3 May 2024 15:07:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C5F8AC68;
	Fri,  3 May 2024 15:07:58 +0000 (UTC)
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
Subject: [PATCH net 2/5] rxrpc: Only transmit one ACK per jumbo packet received
Date: Fri,  3 May 2024 16:07:40 +0100
Message-ID: <20240503150749.1001323-3-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Only generate one ACK packet for all the subpackets in a jumbo packet.  If
we would like to generate more than one ACK, we prioritise them base on
their reason code, in the order, highest first:

   OutOfSeq > NoSpace > ExceedsWin > Duplicate > Requested > Delay > Idle

For the first four, we reference the lowest offending subpacket; for the
last three, the highest.

This reduces the number of ACKs we end up transmitting to one per UDP
packet transmitted to reduce network loading and packet parsing.

Fixes: 5d7edbc9231e ("rxrpc: Get rid of the Rx ring")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/input.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 860075f1290b..16d49a861dbb 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -9,6 +9,17 @@
 
 #include "ar-internal.h"
 
+/* Override priority when generating ACKs for received DATA */
+static const u8 rxrpc_ack_priority[RXRPC_ACK__INVALID] = {
+	[RXRPC_ACK_IDLE]		= 1,
+	[RXRPC_ACK_DELAY]		= 2,
+	[RXRPC_ACK_REQUESTED]		= 3,
+	[RXRPC_ACK_DUPLICATE]		= 4,
+	[RXRPC_ACK_EXCEEDS_WINDOW]	= 5,
+	[RXRPC_ACK_NOSPACE]		= 6,
+	[RXRPC_ACK_OUT_OF_SEQUENCE]	= 7,
+};
+
 static void rxrpc_proto_abort(struct rxrpc_call *call, rxrpc_seq_t seq,
 			      enum rxrpc_abort_reason why)
 {
@@ -365,7 +376,7 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
  * Process a DATA packet.
  */
 static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
-				 bool *_notify)
+				 bool *_notify, rxrpc_serial_t *_ack_serial, int *_ack_reason)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct sk_buff *oos;
@@ -418,8 +429,6 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 		/* Send an immediate ACK if we fill in a hole */
 		else if (!skb_queue_empty(&call->rx_oos_queue))
 			ack_reason = RXRPC_ACK_DELAY;
-		else
-			call->ackr_nr_unacked++;
 
 		window++;
 		if (after(window, wtop)) {
@@ -497,12 +506,16 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 	}
 
 send_ack:
-	if (ack_reason >= 0)
-		rxrpc_send_ACK(call, ack_reason, serial,
-			       rxrpc_propose_ack_input_data);
-	else
-		rxrpc_propose_delay_ACK(call, serial,
-					rxrpc_propose_ack_input_data);
+	if (ack_reason >= 0) {
+		if (rxrpc_ack_priority[ack_reason] > rxrpc_ack_priority[*_ack_reason]) {
+			*_ack_serial = serial;
+			*_ack_reason = ack_reason;
+		} else if (rxrpc_ack_priority[ack_reason] == rxrpc_ack_priority[*_ack_reason] &&
+			   ack_reason == RXRPC_ACK_REQUESTED) {
+			*_ack_serial = serial;
+			*_ack_reason = ack_reason;
+		}
+	}
 }
 
 /*
@@ -513,9 +526,11 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 	struct rxrpc_jumbo_header jhdr;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb), *jsp;
 	struct sk_buff *jskb;
+	rxrpc_serial_t ack_serial = 0;
 	unsigned int offset = sizeof(struct rxrpc_wire_header);
 	unsigned int len = skb->len - offset;
 	bool notify = false;
+	int ack_reason = 0;
 
 	while (sp->hdr.flags & RXRPC_JUMBO_PACKET) {
 		if (len < RXRPC_JUMBO_SUBPKTLEN)
@@ -535,7 +550,7 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 		jsp = rxrpc_skb(jskb);
 		jsp->offset = offset;
 		jsp->len = RXRPC_JUMBO_DATALEN;
-		rxrpc_input_data_one(call, jskb, &notify);
+		rxrpc_input_data_one(call, jskb, &notify, &ack_serial, &ack_reason);
 		rxrpc_free_skb(jskb, rxrpc_skb_put_jumbo_subpacket);
 
 		sp->hdr.flags = jhdr.flags;
@@ -548,7 +563,16 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 
 	sp->offset = offset;
 	sp->len    = len;
-	rxrpc_input_data_one(call, skb, &notify);
+	rxrpc_input_data_one(call, skb, &notify, &ack_serial, &ack_reason);
+
+	if (ack_reason > 0) {
+		rxrpc_send_ACK(call, ack_reason, ack_serial,
+			       rxrpc_propose_ack_input_data);
+	} else {
+		call->ackr_nr_unacked++;
+		rxrpc_propose_delay_ACK(call, sp->hdr.serial,
+					rxrpc_propose_ack_input_data);
+	}
 	if (notify) {
 		trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
 		rxrpc_notify_socket(call);


