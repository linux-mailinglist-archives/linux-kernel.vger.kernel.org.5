Return-Path: <linux-kernel+bounces-88737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6686E5F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609F81F21730
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E364697;
	Fri,  1 Mar 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L55A/PGG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C103D38D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311134; cv=none; b=GJ5icS8X9V7NmsVE/fx09pSWdChkC9wFvfcr+624X9rSJ2FZ2PlrR0+iVivEGwiesemBBFQx1EW1Ha00Y01CxIVzdbKzG6blLZ3AsEd2beUpR6VvJDBcRdwAmR3j3/DFI1svtzsPvETQoiHoIu3r3lE0bo3UswSc5MHj/8eOEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311134; c=relaxed/simple;
	bh=n62EFmLbwT7hssDA/fKMPrIBQQaO/qa+p8DZ8i+yies=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSY6yZe7pIhvFkiTPLHQK/nX+ETQcXlCTR/NNKUQNl3yXp76iTTw1YOwck9DFZqKY9VA9sfVchrLdvdEC70Z0Q0ejs8GiczShpRYGEUuM31Piu5YMJ+rmN3nEtsF/YSlG6tg+oZEqINA6SaKXeLa6e+wxbitIeA+TJJkKCtTvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L55A/PGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJv0qns4Trev3o3IMKOyFJbOr0f5dKogrEgc53xa71A=;
	b=L55A/PGG7DcJu4R1ZsnLQGpf8q0iNVzlkjscrIiGmUlbTfwDVTwEVMushjPFsqIMa6dWip
	4P3JesGGFiHWS3S0a4DBCrSLb3DrzvjAVN8LcdlYxA4ymekfGA9TqpE/+KySfT0mRkPnxW
	6My6dl/7sLxsGsw+eoneCFlpW/Nz7xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-3jy5nLeYOouna9QG4oEX3w-1; Fri, 01 Mar 2024 11:38:45 -0500
X-MC-Unique: 3jy5nLeYOouna9QG4oEX3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1A7087DC02;
	Fri,  1 Mar 2024 16:38:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5285111330;
	Fri,  1 Mar 2024 16:38:43 +0000 (UTC)
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
Subject: [PATCH net-next 18/21] rxrpc: Use ktimes for call timeout tracking and set the timer lazily
Date: Fri,  1 Mar 2024 16:37:50 +0000
Message-ID: <20240301163807.385573-19-dhowells@redhat.com>
In-Reply-To: <20240301163807.385573-1-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Track the call timeouts as ktimes rather than jiffies as the latter's
granularity is too high and only set the timer at the end of the event
handling function.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 174 +++++++++++++++++---------------
 net/rxrpc/af_rxrpc.c         |  12 +--
 net/rxrpc/ar-internal.h      |  35 +++----
 net/rxrpc/call_event.c       | 189 +++++++++++++++++------------------
 net/rxrpc/call_object.c      |  56 +++++------
 net/rxrpc/input.c            |  28 +++---
 net/rxrpc/misc.c             |   8 +-
 net/rxrpc/output.c           |  40 +++-----
 net/rxrpc/proc.c             |  10 +-
 net/rxrpc/rtt.c              |  36 +++----
 net/rxrpc/sendmsg.c          |  25 ++---
 net/rxrpc/sysctl.c           |  16 +--
 12 files changed, 307 insertions(+), 322 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 3b726a6c8c42..de3663280ee4 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -119,6 +119,7 @@
 	EM(rxrpc_call_poke_complete,		"Compl")	\
 	EM(rxrpc_call_poke_error,		"Error")	\
 	EM(rxrpc_call_poke_idle,		"Idle")		\
+	EM(rxrpc_call_poke_set_timeout,		"Set-timo")	\
 	EM(rxrpc_call_poke_start,		"Start")	\
 	EM(rxrpc_call_poke_timer,		"Timer")	\
 	E_(rxrpc_call_poke_timer_now,		"Timer-now")
@@ -340,27 +341,16 @@
 	E_(rxrpc_rtt_rx_requested_ack,		"RACK")
 
 #define rxrpc_timer_traces \
-	EM(rxrpc_timer_begin,			"Begin ") \
-	EM(rxrpc_timer_exp_ack,			"ExpAck") \
-	EM(rxrpc_timer_exp_hard,		"ExpHrd") \
-	EM(rxrpc_timer_exp_idle,		"ExpIdl") \
-	EM(rxrpc_timer_exp_keepalive,		"ExpKA ") \
-	EM(rxrpc_timer_exp_lost_ack,		"ExpLoA") \
-	EM(rxrpc_timer_exp_normal,		"ExpNml") \
-	EM(rxrpc_timer_exp_ping,		"ExpPng") \
-	EM(rxrpc_timer_exp_resend,		"ExpRsn") \
-	EM(rxrpc_timer_init_for_reply,		"IniRpl") \
-	EM(rxrpc_timer_init_for_send_reply,	"SndRpl") \
-	EM(rxrpc_timer_restart,			"Restrt") \
-	EM(rxrpc_timer_set_for_ack,		"SetAck") \
-	EM(rxrpc_timer_set_for_hard,		"SetHrd") \
-	EM(rxrpc_timer_set_for_idle,		"SetIdl") \
-	EM(rxrpc_timer_set_for_keepalive,	"KeepAl") \
-	EM(rxrpc_timer_set_for_lost_ack,	"SetLoA") \
-	EM(rxrpc_timer_set_for_normal,		"SetNml") \
-	EM(rxrpc_timer_set_for_ping,		"SetPng") \
-	EM(rxrpc_timer_set_for_resend,		"SetRTx") \
-	E_(rxrpc_timer_set_for_send,		"SetSnd")
+	EM(rxrpc_timer_trace_delayed_ack,	"DelayAck ") \
+	EM(rxrpc_timer_trace_expect_rx,		"ExpectRx ") \
+	EM(rxrpc_timer_trace_hard,		"HardLimit") \
+	EM(rxrpc_timer_trace_idle,		"IdleLimit") \
+	EM(rxrpc_timer_trace_keepalive,		"KeepAlive") \
+	EM(rxrpc_timer_trace_lost_ack,		"LostAck  ") \
+	EM(rxrpc_timer_trace_ping,		"DelayPing") \
+	EM(rxrpc_timer_trace_resend,		"Resend   ") \
+	EM(rxrpc_timer_trace_resend_reset,	"ResendRst") \
+	E_(rxrpc_timer_trace_resend_tx,		"ResendTx ")
 
 #define rxrpc_propose_ack_traces \
 	EM(rxrpc_propose_ack_client_tx_end,	"ClTxEnd") \
@@ -1314,90 +1304,112 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		      __entry->rto)
 	    );
 
-TRACE_EVENT(rxrpc_timer,
-	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_timer_trace why,
-		     unsigned long now),
+TRACE_EVENT(rxrpc_timer_set,
+	    TP_PROTO(struct rxrpc_call *call, ktime_t delay,
+		     enum rxrpc_timer_trace why),
 
-	    TP_ARGS(call, why, now),
+	    TP_ARGS(call, delay, why),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
 		    __field(enum rxrpc_timer_trace,	why)
-		    __field(long,			now)
-		    __field(long,			ack_at)
-		    __field(long,			ack_lost_at)
-		    __field(long,			resend_at)
-		    __field(long,			ping_at)
-		    __field(long,			expect_rx_by)
-		    __field(long,			expect_req_by)
-		    __field(long,			expect_term_by)
-		    __field(long,			timer)
+		    __field(ktime_t,			delay)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call		= call->debug_id;
 		    __entry->why		= why;
-		    __entry->now		= now;
-		    __entry->ack_at		= call->delay_ack_at;
-		    __entry->ack_lost_at	= call->ack_lost_at;
-		    __entry->resend_at		= call->resend_at;
-		    __entry->expect_rx_by	= call->expect_rx_by;
-		    __entry->expect_req_by	= call->expect_req_by;
-		    __entry->expect_term_by	= call->expect_term_by;
-		    __entry->timer		= call->timer.expires;
+		    __entry->delay		= delay;
 			   ),
 
-	    TP_printk("c=%08x %s a=%ld la=%ld r=%ld xr=%ld xq=%ld xt=%ld t=%ld",
+	    TP_printk("c=%08x %s to=%lld",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_timer_traces),
-		      __entry->ack_at - __entry->now,
-		      __entry->ack_lost_at - __entry->now,
-		      __entry->resend_at - __entry->now,
-		      __entry->expect_rx_by - __entry->now,
-		      __entry->expect_req_by - __entry->now,
-		      __entry->expect_term_by - __entry->now,
-		      __entry->timer - __entry->now)
+		      (long long)__entry->delay / 1000)
+	    );
+
+TRACE_EVENT(rxrpc_timer_exp,
+	    TP_PROTO(struct rxrpc_call *call, ktime_t delay,
+		     enum rxrpc_timer_trace why),
+
+	    TP_ARGS(call, delay, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(enum rxrpc_timer_trace,	why)
+		    __field(ktime_t,			delay)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call		= call->debug_id;
+		    __entry->why		= why;
+		    __entry->delay		= delay;
+			   ),
+
+	    TP_printk("c=%08x %s to=%lld",
+		      __entry->call,
+		      __print_symbolic(__entry->why, rxrpc_timer_traces),
+		      (long long)__entry->delay / 1000)
+	    );
+
+TRACE_EVENT(rxrpc_timer_can,
+	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_timer_trace why),
+
+	    TP_ARGS(call, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(enum rxrpc_timer_trace,	why)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call		= call->debug_id;
+		    __entry->why		= why;
+			   ),
+
+	    TP_printk("c=%08x %s",
+		      __entry->call,
+		      __print_symbolic(__entry->why, rxrpc_timer_traces))
+	    );
+
+TRACE_EVENT(rxrpc_timer_restart,
+	    TP_PROTO(struct rxrpc_call *call, ktime_t delay, unsigned long delayj),
+
+	    TP_ARGS(call, delay, delayj),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(unsigned long,		delayj)
+		    __field(ktime_t,			delay)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call		= call->debug_id;
+		    __entry->delayj		= delayj;
+		    __entry->delay		= delay;
+			   ),
+
+	    TP_printk("c=%08x to=%lld j=%ld",
+		      __entry->call,
+		      (long long)__entry->delay / 1000,
+		      __entry->delayj)
 	    );
 
 TRACE_EVENT(rxrpc_timer_expired,
-	    TP_PROTO(struct rxrpc_call *call, unsigned long now),
+	    TP_PROTO(struct rxrpc_call *call),
 
-	    TP_ARGS(call, now),
+	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
-		    __field(long,		now)
-		    __field(long,		ack_at)
-		    __field(long,		ack_lost_at)
-		    __field(long,		resend_at)
-		    __field(long,		ping_at)
-		    __field(long,		expect_rx_by)
-		    __field(long,		expect_req_by)
-		    __field(long,		expect_term_by)
-		    __field(long,		timer)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call		= call->debug_id;
-		    __entry->now		= now;
-		    __entry->ack_at		= call->delay_ack_at;
-		    __entry->ack_lost_at	= call->ack_lost_at;
-		    __entry->resend_at		= call->resend_at;
-		    __entry->expect_rx_by	= call->expect_rx_by;
-		    __entry->expect_req_by	= call->expect_req_by;
-		    __entry->expect_term_by	= call->expect_term_by;
-		    __entry->timer		= call->timer.expires;
 			   ),
 
-	    TP_printk("c=%08x EXPIRED a=%ld la=%ld r=%ld xr=%ld xq=%ld xt=%ld t=%ld",
-		      __entry->call,
-		      __entry->ack_at - __entry->now,
-		      __entry->ack_lost_at - __entry->now,
-		      __entry->resend_at - __entry->now,
-		      __entry->expect_rx_by - __entry->now,
-		      __entry->expect_req_by - __entry->now,
-		      __entry->expect_term_by - __entry->now,
-		      __entry->timer - __entry->now)
+	    TP_printk("c=%08x EXPIRED",
+		      __entry->call)
 	    );
 
 TRACE_EVENT(rxrpc_rx_lose,
@@ -1507,7 +1519,7 @@ TRACE_EVENT(rxrpc_drop_ack,
 
 TRACE_EVENT(rxrpc_retransmit,
 	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
-		     rxrpc_serial_t serial, s64 expiry),
+		     rxrpc_serial_t serial, ktime_t expiry),
 
 	    TP_ARGS(call, seq, serial, expiry),
 
@@ -1515,7 +1527,7 @@ TRACE_EVENT(rxrpc_retransmit,
 		    __field(unsigned int,	call)
 		    __field(rxrpc_seq_t,	seq)
 		    __field(rxrpc_serial_t,	serial)
-		    __field(s64,		expiry)
+		    __field(ktime_t,		expiry)
 			     ),
 
 	    TP_fast_assign(
@@ -1529,7 +1541,7 @@ TRACE_EVENT(rxrpc_retransmit,
 		      __entry->call,
 		      __entry->seq,
 		      __entry->serial,
-		      __entry->expiry)
+		      (long long)__entry->expiry / 1000)
 	    );
 
 TRACE_EVENT(rxrpc_congest,
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 465bfe5eb061..5222bc97d192 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -487,7 +487,7 @@ EXPORT_SYMBOL(rxrpc_kernel_new_call_notification);
  * rxrpc_kernel_set_max_life - Set maximum lifespan on a call
  * @sock: The socket the call is on
  * @call: The call to configure
- * @hard_timeout: The maximum lifespan of the call in jiffies
+ * @hard_timeout: The maximum lifespan of the call in ms
  *
  * Set the maximum lifespan of a call.  The call will end with ETIME or
  * ETIMEDOUT if it takes longer than this.
@@ -495,14 +495,14 @@ EXPORT_SYMBOL(rxrpc_kernel_new_call_notification);
 void rxrpc_kernel_set_max_life(struct socket *sock, struct rxrpc_call *call,
 			       unsigned long hard_timeout)
 {
-	unsigned long now;
+	ktime_t delay = ms_to_ktime(hard_timeout), expect_term_by;
 
 	mutex_lock(&call->user_mutex);
 
-	now = jiffies;
-	hard_timeout += now;
-	WRITE_ONCE(call->expect_term_by, hard_timeout);
-	rxrpc_reduce_call_timer(call, hard_timeout, now, rxrpc_timer_set_for_hard);
+	expect_term_by = ktime_add(ktime_get_real(), delay);
+	WRITE_ONCE(call->expect_term_by, expect_term_by);
+	trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_hard);
+	rxrpc_poke_call(call, rxrpc_call_poke_set_timeout);
 
 	mutex_unlock(&call->user_mutex);
 }
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 47f4689379ca..21ecac22b51d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -352,8 +352,8 @@ struct rxrpc_peer {
 	u32			mdev_us;	/* medium deviation			*/
 	u32			mdev_max_us;	/* maximal mdev for the last rtt period	*/
 	u32			rttvar_us;	/* smoothed mdev_max			*/
-	u32			rto_j;		/* Retransmission timeout in jiffies */
-	u8			backoff;	/* Backoff timeout */
+	u32			rto_us;		/* Retransmission timeout in usec */
+	u8			backoff;	/* Backoff timeout (as shift) */
 
 	u8			cong_ssthresh;	/* Congestion slow-start threshold */
 };
@@ -620,17 +620,17 @@ struct rxrpc_call {
 	const struct rxrpc_security *security;	/* applied security module */
 	struct mutex		user_mutex;	/* User access mutex */
 	struct sockaddr_rxrpc	dest_srx;	/* Destination address */
-	unsigned long		delay_ack_at;	/* When DELAY ACK needs to happen */
-	unsigned long		ack_lost_at;	/* When ACK is figured as lost */
-	unsigned long		resend_at;	/* When next resend needs to happen */
-	unsigned long		ping_at;	/* When next to send a ping */
-	unsigned long		keepalive_at;	/* When next to send a keepalive ping */
-	unsigned long		expect_rx_by;	/* When we expect to get a packet by */
-	unsigned long		expect_req_by;	/* When we expect to get a request DATA packet by */
-	unsigned long		expect_term_by;	/* When we expect call termination by */
-	u32			next_rx_timo;	/* Timeout for next Rx packet (jif) */
-	u32			next_req_timo;	/* Timeout for next Rx request packet (jif) */
-	u32			hard_timo;	/* Maximum lifetime or 0 (jif) */
+	ktime_t			delay_ack_at;	/* When DELAY ACK needs to happen */
+	ktime_t			ack_lost_at;	/* When ACK is figured as lost */
+	ktime_t			resend_at;	/* When next resend needs to happen */
+	ktime_t			ping_at;	/* When next to send a ping */
+	ktime_t			keepalive_at;	/* When next to send a keepalive ping */
+	ktime_t			expect_rx_by;	/* When we expect to get a packet by */
+	ktime_t			expect_req_by;	/* When we expect to get a request DATA packet by */
+	ktime_t			expect_term_by;	/* When we expect call termination by */
+	u32			next_rx_timo;	/* Timeout for next Rx packet (ms) */
+	u32			next_req_timo;	/* Timeout for next Rx request packet (ms) */
+	u32			hard_timo;	/* Maximum lifetime or 0 (s) */
 	struct timer_list	timer;		/* Combined event timer */
 	struct work_struct	destroyer;	/* In-process-context destroyer */
 	rxrpc_notify_rx_t	notify_rx;	/* kernel service Rx notification function */
@@ -675,7 +675,7 @@ struct rxrpc_call {
 	rxrpc_seq_t		tx_transmitted;	/* Highest packet transmitted */
 	rxrpc_seq_t		tx_prepared;	/* Highest Tx slot prepared. */
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
-	u16			tx_backoff;	/* Delay to insert due to Tx failure */
+	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
 	u8			tx_winsize;	/* Maximum size of Tx window */
 #define RXRPC_TX_MAX_WINDOW	128
 	ktime_t			tx_last_sent;	/* Last time a transmission occurred */
@@ -866,11 +866,6 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *);
 void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb);
 
-void rxrpc_reduce_call_timer(struct rxrpc_call *call,
-			     unsigned long expire_at,
-			     unsigned long now,
-			     enum rxrpc_timer_trace why);
-
 bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb);
 
 /*
@@ -1214,7 +1209,7 @@ static inline int rxrpc_abort_eproto(struct rxrpc_call *call,
  */
 void rxrpc_peer_add_rtt(struct rxrpc_call *, enum rxrpc_rtt_rx_trace, int,
 			rxrpc_serial_t, rxrpc_serial_t, ktime_t, ktime_t);
-unsigned long rxrpc_get_rto_backoff(struct rxrpc_peer *, bool);
+ktime_t rxrpc_get_rto_backoff(struct rxrpc_peer *peer, bool retrans);
 void rxrpc_peer_init_rtt(struct rxrpc_peer *);
 
 /*
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index bc1a5abb7d6f..2a9f74eb7c46 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -23,14 +23,14 @@
 void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 			enum rxrpc_propose_ack_trace why)
 {
-	unsigned long now = jiffies;
-	unsigned long ping_at = now + rxrpc_idle_ack_delay;
+	ktime_t delay = ms_to_ktime(READ_ONCE(rxrpc_idle_ack_delay));
+	ktime_t now = ktime_get_real();
+	ktime_t ping_at = ktime_add(now, delay);
 
-	if (time_before(ping_at, call->ping_at)) {
+	trace_rxrpc_propose_ack(call, why, RXRPC_ACK_PING, serial);
+	if (ktime_before(ping_at, call->ping_at)) {
 		call->ping_at = ping_at;
-		rxrpc_reduce_call_timer(call, ping_at, now,
-					rxrpc_timer_set_for_ping);
-		trace_rxrpc_propose_ack(call, why, RXRPC_ACK_PING, serial);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_ping);
 	}
 }
 
@@ -40,25 +40,18 @@ void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 			     enum rxrpc_propose_ack_trace why)
 {
-	unsigned long expiry = rxrpc_soft_ack_delay;
-	unsigned long now = jiffies, ack_at;
+	ktime_t now = ktime_get_real(), delay;
 
-	if (rxrpc_soft_ack_delay < expiry)
-		expiry = rxrpc_soft_ack_delay;
-	if (call->peer->srtt_us != 0)
-		ack_at = usecs_to_jiffies(call->peer->srtt_us >> 3);
+	trace_rxrpc_propose_ack(call, why, RXRPC_ACK_DELAY, serial);
+
+	if (call->peer->srtt_us)
+		delay = (call->peer->srtt_us >> 3) * NSEC_PER_USEC;
 	else
-		ack_at = expiry;
-
-	ack_at += READ_ONCE(call->tx_backoff);
-	ack_at += now;
-	if (time_before(ack_at, call->delay_ack_at)) {
-		call->delay_ack_at = ack_at;
-		rxrpc_reduce_call_timer(call, ack_at, now,
-					rxrpc_timer_set_for_ack);
-	}
+		delay = ms_to_ktime(READ_ONCE(rxrpc_soft_ack_delay));
+	ktime_add_ms(delay, call->tx_backoff);
 
-	trace_rxrpc_propose_ack(call, why, RXRPC_ACK_DELAY, serial);
+	call->delay_ack_at = ktime_add(now, delay);
+	trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_delayed_ack);
 }
 
 /*
@@ -77,9 +70,8 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	struct rxrpc_ackpacket *ack = NULL;
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_txbuf *txb;
-	unsigned long resend_at;
 	rxrpc_seq_t transmitted = call->tx_transmitted;
-	ktime_t now, max_age, oldest, ack_ts;
+	ktime_t now, max_age, oldest, ack_ts, delay;
 	bool unacked = false;
 	unsigned int i;
 	LIST_HEAD(retrans_queue);
@@ -87,7 +79,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	_enter("{%d,%d}", call->acks_hard_ack, call->tx_top);
 
 	now = ktime_get_real();
-	max_age = ktime_sub_us(now, jiffies_to_usecs(call->peer->rto_j));
+	max_age = ktime_sub_us(now, call->peer->rto_us);
 	oldest = now;
 
 	if (list_empty(&call->tx_buffer))
@@ -178,10 +170,8 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 
 no_further_resend:
 no_resend:
-	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
-	resend_at += jiffies + rxrpc_get_rto_backoff(call->peer,
-						     !list_empty(&retrans_queue));
-	call->resend_at = resend_at;
+	delay = rxrpc_get_rto_backoff(call->peer, !list_empty(&retrans_queue));
+	call->resend_at = ktime_add(oldest, delay);
 
 	if (unacked)
 		rxrpc_congestion_timeout(call);
@@ -191,8 +181,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * retransmitting data.
 	 */
 	if (list_empty(&retrans_queue)) {
-		rxrpc_reduce_call_timer(call, resend_at, jiffies,
-					rxrpc_timer_set_for_resend);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend_reset);
 		ack_ts = ktime_sub(now, call->acks_latest_ts);
 		if (ktime_to_us(ack_ts) < (call->peer->srtt_us >> 3))
 			goto out;
@@ -218,13 +207,11 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
  */
 static void rxrpc_begin_service_reply(struct rxrpc_call *call)
 {
-	unsigned long now = jiffies;
-
 	rxrpc_set_call_state(call, RXRPC_CALL_SERVER_SEND_REPLY);
-	call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 	if (call->ackr_reason == RXRPC_ACK_DELAY)
 		call->ackr_reason = 0;
-	trace_rxrpc_timer(call, rxrpc_timer_init_for_send_reply, now);
+	call->delay_ack_at = KTIME_MAX;
+	trace_rxrpc_timer_can(call, rxrpc_timer_trace_delayed_ack);
 }
 
 /*
@@ -333,8 +320,8 @@ static void rxrpc_send_initial_ping(struct rxrpc_call *call)
  */
 bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 {
-	unsigned long now, next, t;
-	bool resend = false, expired = false;
+	ktime_t now, t;
+	bool resend = false;
 	s32 abort_code;
 
 	rxrpc_see_call(call, rxrpc_call_see_input);
@@ -362,66 +349,69 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_input_call_packet(call, skb);
 
 	/* If we see our async-event poke, check for timeout trippage. */
-	now = jiffies;
-	t = call->expect_rx_by;
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_normal, now);
-		expired = true;
+	now = ktime_get_real();
+	t = ktime_sub(call->expect_rx_by, now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_expect_rx);
+		goto expired;
 	}
 
-	t = call->expect_req_by;
-	if (__rxrpc_call_state(call) == RXRPC_CALL_SERVER_RECV_REQUEST &&
-	    time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_idle, now);
-		expired = true;
+	t = ktime_sub(call->expect_req_by, now);
+	if (t <= 0) {
+		call->expect_req_by = KTIME_MAX;
+		if (__rxrpc_call_state(call) == RXRPC_CALL_SERVER_RECV_REQUEST) {
+			trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_idle);
+			goto expired;
+		}
 	}
 
-	t = READ_ONCE(call->expect_term_by);
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_hard, now);
-		expired = true;
+	t = ktime_sub(READ_ONCE(call->expect_term_by), now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_hard);
+		goto expired;
 	}
 
-	t = call->delay_ack_at;
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_ack, now);
-		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
+	t = ktime_sub(call->delay_ack_at, now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_delayed_ack);
+		call->delay_ack_at = KTIME_MAX;
 		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
 			       rxrpc_propose_ack_delayed_ack);
 	}
 
-	t = call->ack_lost_at;
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_lost_ack, now);
-		call->ack_lost_at = now + MAX_JIFFY_OFFSET;
+	t = ktime_sub(call->ack_lost_at, now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_lost_ack);
+		call->ack_lost_at = KTIME_MAX;
 		set_bit(RXRPC_CALL_EV_ACK_LOST, &call->events);
 	}
 
-	t = call->keepalive_at;
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_keepalive, now);
-		call->keepalive_at = now + MAX_JIFFY_OFFSET;
+	t = ktime_sub(call->ping_at, now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_ping);
+		call->ping_at = KTIME_MAX;
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	t = call->ping_at;
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_ping, now);
-		call->ping_at = now + MAX_JIFFY_OFFSET;
-		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
-			       rxrpc_propose_ack_ping_for_keepalive);
-	}
-
-	t = call->resend_at;
-	if (time_after_eq(now, t)) {
-		trace_rxrpc_timer(call, rxrpc_timer_exp_resend, now);
-		call->resend_at = now + MAX_JIFFY_OFFSET;
+	t = ktime_sub(call->resend_at, now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_resend);
+		call->resend_at = KTIME_MAX;
 		resend = true;
 	}
 
 	rxrpc_transmit_some_data(call);
 
+	now = ktime_get_real();
+	t = ktime_sub(call->keepalive_at, now);
+	if (t <= 0) {
+		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_keepalive);
+		call->keepalive_at = KTIME_MAX;
+		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
+			       rxrpc_propose_ack_ping_for_keepalive);
+	}
+
 	if (skb) {
 		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 
@@ -433,19 +423,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_send_initial_ping(call);
 
 	/* Process events */
-	if (expired) {
-		if (test_bit(RXRPC_CALL_RX_HEARD, &call->flags) &&
-		    (int)call->conn->hi_serial - (int)call->rx_serial > 0) {
-			trace_rxrpc_call_reset(call);
-			rxrpc_abort_call(call, 0, RX_CALL_DEAD, -ECONNRESET,
-					 rxrpc_abort_call_reset);
-		} else {
-			rxrpc_abort_call(call, 0, RX_CALL_TIMEOUT, -ETIME,
-					 rxrpc_abort_call_timeout);
-		}
-		goto out;
-	}
-
 	if (test_and_clear_bit(RXRPC_CALL_EV_ACK_LOST, &call->events))
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
@@ -474,23 +451,33 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 
 	/* Make sure the timer is restarted */
 	if (!__rxrpc_call_is_complete(call)) {
-		next = call->expect_rx_by;
+		ktime_t next = READ_ONCE(call->expect_term_by), delay;
 
-#define set(T) { t = READ_ONCE(T); if (time_before(t, next)) next = t; }
+#define set(T) { ktime_t _t = (T); if (ktime_before(_t, next)) next = _t; }
 
 		set(call->expect_req_by);
-		set(call->expect_term_by);
+		set(call->expect_rx_by);
 		set(call->delay_ack_at);
 		set(call->ack_lost_at);
 		set(call->resend_at);
 		set(call->keepalive_at);
 		set(call->ping_at);
 
-		now = jiffies;
-		if (time_after_eq(now, next))
+		now = ktime_get_real();
+		delay = ktime_sub(next, now);
+		if (delay <= 0) {
 			rxrpc_poke_call(call, rxrpc_call_poke_timer_now);
-
-		rxrpc_reduce_call_timer(call, next, now, rxrpc_timer_restart);
+		} else {
+			unsigned long nowj = jiffies, delayj, nextj;
+
+			delayj = max(nsecs_to_jiffies(delay), 1);
+			nextj = nowj + delayj;
+			if (time_before(nextj, call->timer.expires) ||
+			    !timer_pending(&call->timer)) {
+				trace_rxrpc_timer_restart(call, delay, delayj);
+				timer_reduce(&call->timer, nextj);
+			}
+		}
 	}
 
 out:
@@ -505,4 +492,16 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_shrink_call_tx_buffer(call);
 	_leave("");
 	return true;
+
+expired:
+	if (test_bit(RXRPC_CALL_RX_HEARD, &call->flags) &&
+	    (int)call->conn->hi_serial - (int)call->rx_serial > 0) {
+		trace_rxrpc_call_reset(call);
+		rxrpc_abort_call(call, 0, RX_CALL_DEAD, -ECONNRESET,
+				 rxrpc_abort_call_reset);
+	} else {
+		rxrpc_abort_call(call, 0, RX_CALL_TIMEOUT, -ETIME,
+				 rxrpc_abort_call_timeout);
+	}
+	goto out;
 }
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 9fc9a6c3f685..01fa71e8b1f7 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -70,20 +70,11 @@ static void rxrpc_call_timer_expired(struct timer_list *t)
 	_enter("%d", call->debug_id);
 
 	if (!__rxrpc_call_is_complete(call)) {
-		trace_rxrpc_timer_expired(call, jiffies);
+		trace_rxrpc_timer_expired(call);
 		rxrpc_poke_call(call, rxrpc_call_poke_timer);
 	}
 }
 
-void rxrpc_reduce_call_timer(struct rxrpc_call *call,
-			     unsigned long expire_at,
-			     unsigned long now,
-			     enum rxrpc_timer_trace why)
-{
-	trace_rxrpc_timer(call, why, now);
-	timer_reduce(&call->timer, expire_at);
-}
-
 static struct lock_class_key rxrpc_call_user_mutex_lock_class_key;
 
 static void rxrpc_destroy_call(struct work_struct *);
@@ -163,12 +154,20 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	spin_lock_init(&call->notify_lock);
 	spin_lock_init(&call->tx_lock);
 	refcount_set(&call->ref, 1);
-	call->debug_id = debug_id;
-	call->tx_total_len = -1;
-	call->next_rx_timo = 20 * HZ;
-	call->next_req_timo = 1 * HZ;
-	call->ackr_window = 1;
-	call->ackr_wtop = 1;
+	call->debug_id		= debug_id;
+	call->tx_total_len	= -1;
+	call->next_rx_timo	= 20 * HZ;
+	call->next_req_timo	= 1 * HZ;
+	call->ackr_window	= 1;
+	call->ackr_wtop		= 1;
+	call->delay_ack_at	= KTIME_MAX;
+	call->ack_lost_at	= KTIME_MAX;
+	call->resend_at		= KTIME_MAX;
+	call->ping_at		= KTIME_MAX;
+	call->keepalive_at	= KTIME_MAX;
+	call->expect_rx_by	= KTIME_MAX;
+	call->expect_req_by	= KTIME_MAX;
+	call->expect_term_by	= KTIME_MAX;
 
 	memset(&call->sock_node, 0xed, sizeof(call->sock_node));
 
@@ -226,11 +225,11 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 		__set_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
 
 	if (p->timeouts.normal)
-		call->next_rx_timo = min(msecs_to_jiffies(p->timeouts.normal), 1UL);
+		call->next_rx_timo = min(p->timeouts.normal, 1);
 	if (p->timeouts.idle)
-		call->next_req_timo = min(msecs_to_jiffies(p->timeouts.idle), 1UL);
+		call->next_req_timo = min(p->timeouts.idle, 1);
 	if (p->timeouts.hard)
-		call->hard_timo = p->timeouts.hard * HZ;
+		call->hard_timo = p->timeouts.hard;
 
 	ret = rxrpc_init_client_call_security(call);
 	if (ret < 0) {
@@ -253,18 +252,13 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
  */
 void rxrpc_start_call_timer(struct rxrpc_call *call)
 {
-	unsigned long now = jiffies;
-	unsigned long j = now + MAX_JIFFY_OFFSET;
-
-	call->delay_ack_at = j;
-	call->ack_lost_at = j;
-	call->resend_at = j;
-	call->ping_at = j;
-	call->keepalive_at = j;
-	call->expect_rx_by = j;
-	call->expect_req_by = j;
-	call->expect_term_by = j + call->hard_timo;
-	call->timer.expires = now;
+	if (call->hard_timo) {
+		ktime_t delay = ms_to_ktime(call->hard_timo * 1000);
+
+		call->expect_term_by = ktime_add(ktime_get_real(), delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_hard);
+	}
+	call->timer.expires = jiffies;
 }
 
 /*
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index e53a49accc16..09cce1d5d605 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -252,6 +252,9 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 {
 	ASSERT(test_bit(RXRPC_CALL_TX_LAST, &call->flags));
 
+	call->resend_at = KTIME_MAX;
+	trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
+
 	if (unlikely(call->cong_last_nack)) {
 		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
 		call->cong_last_nack = NULL;
@@ -288,13 +291,11 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 {
 	struct rxrpc_ack_summary summary = { 0 };
-	unsigned long now;
 	rxrpc_seq_t top = READ_ONCE(call->tx_top);
 
 	if (call->ackr_reason) {
-		now = jiffies;
-		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
-		trace_rxrpc_timer(call, rxrpc_timer_init_for_reply, now);
+		call->delay_ack_at = KTIME_MAX;
+		trace_rxrpc_timer_can(call, rxrpc_timer_trace_delayed_ack);
 	}
 
 	if (!test_bit(RXRPC_CALL_TX_LAST, &call->flags)) {
@@ -327,7 +328,7 @@ static void rxrpc_end_rx_phase(struct rxrpc_call *call, rxrpc_serial_t serial)
 
 	case RXRPC_CALL_SERVER_RECV_REQUEST:
 		rxrpc_set_call_state(call, RXRPC_CALL_SERVER_ACK_REQUEST);
-		call->expect_req_by = jiffies + MAX_JIFFY_OFFSET;
+		call->expect_req_by = KTIME_MAX;
 		rxrpc_propose_delay_ACK(call, serial, rxrpc_propose_ack_processing_op);
 		break;
 
@@ -587,14 +588,12 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
 
 	case RXRPC_CALL_SERVER_RECV_REQUEST: {
 		unsigned long timo = READ_ONCE(call->next_req_timo);
-		unsigned long now, expect_req_by;
 
 		if (timo) {
-			now = jiffies;
-			expect_req_by = now + timo;
-			call->expect_req_by = now + timo;
-			rxrpc_reduce_call_timer(call, expect_req_by, now,
-						rxrpc_timer_set_for_idle);
+			ktime_t delay = ms_to_ktime(timo);
+
+			call->expect_req_by = ktime_add(ktime_get_real(), delay);
+			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_idle);
 		}
 		break;
 	}
@@ -1046,11 +1045,10 @@ void rxrpc_input_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
 
 	timo = READ_ONCE(call->next_rx_timo);
 	if (timo) {
-		unsigned long now = jiffies;
+		ktime_t delay = ms_to_ktime(timo);
 
-		call->expect_rx_by = now + timo;
-		rxrpc_reduce_call_timer(call, call->expect_rx_by, now,
-					rxrpc_timer_set_for_normal);
+		call->expect_rx_by = ktime_add(ktime_get_real(), delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
 	}
 
 	switch (sp->hdr.type) {
diff --git a/net/rxrpc/misc.c b/net/rxrpc/misc.c
index 825b81183046..657cf35089a6 100644
--- a/net/rxrpc/misc.c
+++ b/net/rxrpc/misc.c
@@ -17,22 +17,22 @@
 unsigned int rxrpc_max_backlog __read_mostly = 10;
 
 /*
- * How long to wait before scheduling an ACK with subtype DELAY (in jiffies).
+ * How long to wait before scheduling an ACK with subtype DELAY (in ms).
  *
  * We use this when we've received new data packets.  If those packets aren't
  * all consumed within this time we will send a DELAY ACK if an ACK was not
  * requested to let the sender know it doesn't need to resend.
  */
-unsigned long rxrpc_soft_ack_delay = HZ;
+unsigned long rxrpc_soft_ack_delay = 1000;
 
 /*
- * How long to wait before scheduling an ACK with subtype IDLE (in jiffies).
+ * How long to wait before scheduling an ACK with subtype IDLE (in ms).
  *
  * We use this when we've consumed some previously soft-ACK'd packets when
  * further packets aren't immediately received to decide when to send an IDLE
  * ACK let the other end know that it can free up its Tx buffer space.
  */
-unsigned long rxrpc_idle_ack_delay = HZ / 2;
+unsigned long rxrpc_idle_ack_delay = 500;
 
 /*
  * Receive window size in packets.  This indicates the maximum number of
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 0a317498b8e0..ec82193e5681 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -48,12 +48,10 @@ static const char rxrpc_keepalive_string[] = "";
 static void rxrpc_tx_backoff(struct rxrpc_call *call, int ret)
 {
 	if (ret < 0) {
-		u16 tx_backoff = READ_ONCE(call->tx_backoff);
-
-		if (tx_backoff < HZ)
-			WRITE_ONCE(call->tx_backoff, tx_backoff + 1);
+		if (call->tx_backoff < 1000)
+			call->tx_backoff += 100;
 	} else {
-		WRITE_ONCE(call->tx_backoff, 0);
+		call->tx_backoff = 0;
 	}
 }
 
@@ -67,11 +65,10 @@ static void rxrpc_tx_backoff(struct rxrpc_call *call, int ret)
  */
 static void rxrpc_set_keepalive(struct rxrpc_call *call)
 {
-	unsigned long now = jiffies;
+	ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo) / 6);
 
-	call->keepalive_at = now + call->next_rx_timo / 6;
-	rxrpc_reduce_call_timer(call, call->keepalive_at, now,
-				rxrpc_timer_set_for_keepalive);
+	call->keepalive_at = ktime_add(ktime_get_real(), delay);
+	trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_keepalive);
 }
 
 /*
@@ -515,24 +512,21 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		if (txb->flags & RXRPC_REQUEST_ACK) {
 			call->peer->rtt_last_req = txb->last_sent;
 			if (call->peer->rtt_count > 1) {
-				unsigned long nowj = jiffies, ack_lost_at;
+				ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+				ktime_t now = ktime_get_real();
 
-				ack_lost_at = rxrpc_get_rto_backoff(call->peer, false);
-				ack_lost_at += nowj;
-				call->ack_lost_at = ack_lost_at;
-				rxrpc_reduce_call_timer(call, ack_lost_at, nowj,
-							rxrpc_timer_set_for_lost_ack);
+				call->ack_lost_at = ktime_add(now, delay);
+				trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
 			}
 		}
 
 		if (txb->seq == 1 &&
 		    !test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER,
 				      &call->flags)) {
-			unsigned long nowj = jiffies;
+			ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo));
 
-			call->expect_rx_by = nowj + call->next_rx_timo;
-			rxrpc_reduce_call_timer(call, call->expect_rx_by, nowj,
-						rxrpc_timer_set_for_normal);
+			call->expect_rx_by = ktime_add(ktime_get_real(), delay);
+			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
 		}
 
 		rxrpc_set_keepalive(call);
@@ -755,11 +749,9 @@ void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 			rxrpc_instant_resend(call, txb);
 		}
 	} else {
-		unsigned long now = jiffies;
-		unsigned long resend_at = now + call->peer->rto_j;
+		ktime_t delay = ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
 
-		call->resend_at = resend_at;
-		rxrpc_reduce_call_timer(call, resend_at, now,
-					rxrpc_timer_set_for_send);
+		call->resend_at = ktime_add(ktime_get_real(), delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend_tx);
 	}
 }
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 26dc2f26d92d..263a2251e3d2 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -52,9 +52,9 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_call *call;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	enum rxrpc_call_state state;
-	unsigned long timeout = 0;
 	rxrpc_seq_t acks_hard_ack;
 	char lbuff[50], rbuff[50];
+	long timeout = 0;
 
 	if (v == &rxnet->calls) {
 		seq_puts(seq,
@@ -76,10 +76,8 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	sprintf(rbuff, "%pISpc", &call->dest_srx.transport);
 
 	state = rxrpc_call_state(call);
-	if (state != RXRPC_CALL_SERVER_PREALLOC) {
-		timeout = READ_ONCE(call->expect_rx_by);
-		timeout -= jiffies;
-	}
+	if (state != RXRPC_CALL_SERVER_PREALLOC)
+		timeout = ktime_ms_delta(READ_ONCE(call->expect_rx_by), ktime_get_real());
 
 	acks_hard_ack = READ_ONCE(call->acks_hard_ack);
 	seq_printf(seq,
@@ -309,7 +307,7 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 		   peer->mtu,
 		   now - peer->last_tx_at,
 		   peer->srtt_us >> 3,
-		   jiffies_to_usecs(peer->rto_j));
+		   peer->rto_us);
 
 	return 0;
 }
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index be61d6f5be8d..cdab7b7d08a0 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -11,8 +11,8 @@
 #include <linux/net.h>
 #include "ar-internal.h"
 
-#define RXRPC_RTO_MAX	((unsigned)(120 * HZ))
-#define RXRPC_TIMEOUT_INIT ((unsigned)(1*HZ))	/* RFC6298 2.1 initial RTO value	*/
+#define RXRPC_RTO_MAX	(120 * USEC_PER_SEC)
+#define RXRPC_TIMEOUT_INIT ((unsigned int)(1 * MSEC_PER_SEC)) /* RFC6298 2.1 initial RTO value */
 #define rxrpc_jiffies32 ((u32)jiffies)		/* As rxrpc_jiffies32 */
 
 static u32 rxrpc_rto_min_us(struct rxrpc_peer *peer)
@@ -22,7 +22,7 @@ static u32 rxrpc_rto_min_us(struct rxrpc_peer *peer)
 
 static u32 __rxrpc_set_rto(const struct rxrpc_peer *peer)
 {
-	return usecs_to_jiffies((peer->srtt_us >> 3) + peer->rttvar_us);
+	return (peer->srtt_us >> 3) + peer->rttvar_us;
 }
 
 static u32 rxrpc_bound_rto(u32 rto)
@@ -124,7 +124,7 @@ static void rxrpc_set_rto(struct rxrpc_peer *peer)
 	/* NOTE: clamping at RXRPC_RTO_MIN is not required, current algo
 	 * guarantees that rto is higher.
 	 */
-	peer->rto_j = rxrpc_bound_rto(rto);
+	peer->rto_us = rxrpc_bound_rto(rto);
 }
 
 static void rxrpc_ack_update_rtt(struct rxrpc_peer *peer, long rtt_us)
@@ -163,33 +163,33 @@ void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 	spin_unlock(&peer->rtt_input_lock);
 
 	trace_rxrpc_rtt_rx(call, why, rtt_slot, send_serial, resp_serial,
-			   peer->srtt_us >> 3, peer->rto_j);
+			   peer->srtt_us >> 3, peer->rto_us);
 }
 
 /*
- * Get the retransmission timeout to set in jiffies, backing it off each time
- * we retransmit.
+ * Get the retransmission timeout to set in nanoseconds, backing it off each
+ * time we retransmit.
  */
-unsigned long rxrpc_get_rto_backoff(struct rxrpc_peer *peer, bool retrans)
+ktime_t rxrpc_get_rto_backoff(struct rxrpc_peer *peer, bool retrans)
 {
-	u64 timo_j;
-	u8 backoff = READ_ONCE(peer->backoff);
+	u64 timo_us;
+	u32 backoff = READ_ONCE(peer->backoff);
 
-	timo_j = peer->rto_j;
-	timo_j <<= backoff;
-	if (retrans && timo_j * 2 <= RXRPC_RTO_MAX)
+	timo_us = peer->rto_us;
+	timo_us <<= backoff;
+	if (retrans && timo_us * 2 <= RXRPC_RTO_MAX)
 		WRITE_ONCE(peer->backoff, backoff + 1);
 
-	if (timo_j < 1)
-		timo_j = 1;
+	if (timo_us < 1)
+		timo_us = 1;
 
-	return timo_j;
+	return ns_to_ktime(timo_us * NSEC_PER_USEC);
 }
 
 void rxrpc_peer_init_rtt(struct rxrpc_peer *peer)
 {
-	peer->rto_j	= RXRPC_TIMEOUT_INIT;
-	peer->mdev_us	= jiffies_to_usecs(RXRPC_TIMEOUT_INIT);
+	peer->rto_us	= RXRPC_TIMEOUT_INIT;
+	peer->mdev_us	= RXRPC_TIMEOUT_INIT;
 	peer->backoff	= 0;
 	//minmax_reset(&peer->rtt_min, rxrpc_jiffies32, ~0U);
 }
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 4d152f06b039..6f765768c49c 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -609,7 +609,6 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	__releases(&rx->sk.sk_lock.slock)
 {
 	struct rxrpc_call *call;
-	unsigned long now, j;
 	bool dropped_lock = false;
 	int ret;
 
@@ -687,25 +686,21 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 
 	switch (p.call.nr_timeouts) {
 	case 3:
-		j = msecs_to_jiffies(p.call.timeouts.normal);
-		if (p.call.timeouts.normal > 0 && j == 0)
-			j = 1;
-		WRITE_ONCE(call->next_rx_timo, j);
+		WRITE_ONCE(call->next_rx_timo, p.call.timeouts.normal);
 		fallthrough;
 	case 2:
-		j = msecs_to_jiffies(p.call.timeouts.idle);
-		if (p.call.timeouts.idle > 0 && j == 0)
-			j = 1;
-		WRITE_ONCE(call->next_req_timo, j);
+		WRITE_ONCE(call->next_req_timo, p.call.timeouts.idle);
 		fallthrough;
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = p.call.timeouts.hard * HZ;
-			now = jiffies;
-			j += now;
-			WRITE_ONCE(call->expect_term_by, j);
-			rxrpc_reduce_call_timer(call, j, now,
-						rxrpc_timer_set_for_hard);
+			ktime_t delay = ms_to_ktime(p.call.timeouts.hard * MSEC_PER_SEC);
+
+			WRITE_ONCE(call->expect_term_by,
+				   ktime_add(p.call.timeouts.hard,
+					     ktime_get_real()));
+			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_hard);
+			rxrpc_poke_call(call, rxrpc_call_poke_set_timeout);
+
 		}
 		break;
 	}
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index ecaeb4ecfb58..c9bedd0e2d86 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -15,6 +15,8 @@ static const unsigned int four = 4;
 static const unsigned int max_backlog = RXRPC_BACKLOG_MAX - 1;
 static const unsigned int n_65535 = 65535;
 static const unsigned int n_max_acks = 255;
+static const unsigned long one_ms = 1;
+static const unsigned long max_ms = 1000;
 static const unsigned long one_jiffy = 1;
 static const unsigned long max_jiffies = MAX_JIFFY_OFFSET;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
@@ -28,24 +30,24 @@ static const unsigned long max_500 = 500;
  * information on the individual parameters.
  */
 static struct ctl_table rxrpc_sysctl_table[] = {
-	/* Values measured in milliseconds but used in jiffies */
+	/* Values measured in milliseconds */
 	{
 		.procname	= "soft_ack_delay",
 		.data		= &rxrpc_soft_ack_delay,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= (void *)&one_ms,
+		.extra2		= (void *)&max_ms,
 	},
 	{
 		.procname	= "idle_ack_delay",
 		.data		= &rxrpc_idle_ack_delay,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= (void *)&one_ms,
+		.extra2		= (void *)&max_ms,
 	},
 	{
 		.procname	= "idle_conn_expiry",


