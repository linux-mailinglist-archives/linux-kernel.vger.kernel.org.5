Return-Path: <linux-kernel+bounces-50012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FF847300
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089D41C20DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E91474BD;
	Fri,  2 Feb 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+1FgJpt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D40146919
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887206; cv=none; b=fF+iqCDeT6QuDNx7pPZu3JJw9Uyigf4v8YVMzjPjCgw07nR23CkXB4gSd7bEEnfO8rh0wJn3OJje5A6W3XAWQGSnCI3ua/nSjBGpM2+AqUUT2NvrRWPNaOEgExODwaubQedYTx4tv0I6vTBUKAcN5Wx2wAy/gXtNvN0IJV4LIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887206; c=relaxed/simple;
	bh=g70kvg+2yQ1zKRNsdNMS9QyV7HAs9pZbGrvsb7CLgvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTmOVOhoQtoWvmcCpQbZ9SW3rz2NPExZMhLuiDszRY9LWCbhMqiYU9xgx42cDgZblL7VqsiIvMScoQpThjHPgpzR42Olr/z8sqdbUZtZboLHsumBUKRlmDSwSh87K++ir4YGHq3rek08rOqszTZ4ItTPAdWKIo3Z88ARmRK+LzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+1FgJpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkPuxqYCe+q2CWuOk+GPjQMQA8TndT8v7AjuDLV1dT4=;
	b=J+1FgJpthsP7ujiKnRySiPZreNx6HykUXBTneWFY36R3lnV27+0tDoZo+jcLutbco9j//P
	dcpQj8nDNJaH4jbvJJULbzLDItRLl9/EYMFA//PK7AaNB8lv9SRDRZGI0BJqPxWWjY4o/T
	7L6rZQ3crl8ZOWX/Ym/u3V+w0sr0rNo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-xenkD8LiNhaB3ZLViFTDIw-1; Fri,
 02 Feb 2024 10:20:00 -0500
X-MC-Unique: xenkD8LiNhaB3ZLViFTDIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5536929AB3EF;
	Fri,  2 Feb 2024 15:19:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34C3D2026D66;
	Fri,  2 Feb 2024 15:19:58 +0000 (UTC)
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
Subject: [PATCH net 2/4] rxrpc: Fix delayed ACKs to not set the reference serial number
Date: Fri,  2 Feb 2024 15:19:14 +0000
Message-ID: <20240202151920.2760446-3-dhowells@redhat.com>
In-Reply-To: <20240202151920.2760446-1-dhowells@redhat.com>
References: <20240202151920.2760446-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Fix the construction of delayed ACKs to not set the reference serial number
as they can't be used as an RTT reference.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 1 -
 net/rxrpc/call_event.c  | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 31b0dd8c9b2d..b4ab26c3718a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -696,7 +696,6 @@ struct rxrpc_call {
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
 	u16			ackr_sack_base;	/* Starting slot in SACK table ring */
-	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
 	rxrpc_seq_t		ackr_window;	/* Base of SACK window */
 	rxrpc_seq_t		ackr_wtop;	/* Base of SACK window */
 	unsigned int		ackr_nr_unacked; /* Number of unacked packets */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index e363f21a2014..c61efe08695d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -43,8 +43,6 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	unsigned long expiry = rxrpc_soft_ack_delay;
 	unsigned long now = jiffies, ack_at;
 
-	call->ackr_serial = serial;
-
 	if (rxrpc_soft_ack_delay < expiry)
 		expiry = rxrpc_soft_ack_delay;
 	if (call->peer->srtt_us != 0)
@@ -373,7 +371,6 @@ static void rxrpc_send_initial_ping(struct rxrpc_call *call)
 bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	unsigned long now, next, t;
-	rxrpc_serial_t ackr_serial;
 	bool resend = false, expired = false;
 	s32 abort_code;
 
@@ -423,8 +420,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ack, now);
 		cmpxchg(&call->delay_ack_at, t, now + MAX_JIFFY_OFFSET);
-		ackr_serial = xchg(&call->ackr_serial, 0);
-		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, ackr_serial,
+		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 	}
 


