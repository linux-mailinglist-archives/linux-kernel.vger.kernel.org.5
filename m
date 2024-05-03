Return-Path: <linux-kernel+bounces-167811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C0D8BAF6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A305284C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2D715625B;
	Fri,  3 May 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw6b2kQJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C115535A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748890; cv=none; b=NlznyBx8ZIpdxt1UOyDr1GZ62SCuqc2kOlK0Ak4b4N5y98EyRybK4BDnhoOruKhftpKKdm8py/hejMPLHY9cT0H65Edn44f72SfalKp5GG4fdvvPJpHFhL8H5LXpQgZNLil1cU1OAy4M2ZjMLl4AVN6nPKEbWD6HAlY0anMBlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748890; c=relaxed/simple;
	bh=DuTNKRrHMhyGQpIg62Kb5bTSXicrmNuhWjlQllGZmro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0aocTTcPKzkfuGtyBgSbd1hpjjljQb2Ujmljs1DNAL7fCXR5wZOlslAki6vvn981rF2XRNmOldOVD1gO5YQBpQ3MFKzZvFik57Ve8r/F1HbaFiUAAGo8SOyPbe9Q6uTPJSKEYK+JT9JShIWmGyZyglCP731oPbAzxdC/AxlebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw6b2kQJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q81tRT2uTaTBxg18TEDOYg+MWHfHGT+jbt/JaKsoXVk=;
	b=Fw6b2kQJN0CgBijeNi7s16gsDBq5wvlv6CeO243dUTLvRkaFXEeaYWujroTw9QkOUvkD5B
	NoSxYUdSMP9Sb6GLxvDJRf9ZWD1/yay+qEX+oLHKfeQqnH/stkWFEacqDibclJsrGnc053
	VnWWiu7GQ6S2/9QZwRLJia1wVTVcTFw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-0qgMMmr8MaW5Z7uHMQr8Gw-1; Fri,
 03 May 2024 11:08:05 -0400
X-MC-Unique: 0qgMMmr8MaW5Z7uHMQr8Gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B96EC380009F;
	Fri,  3 May 2024 15:08:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4FB0200A3BB;
	Fri,  3 May 2024 15:08:03 +0000 (UTC)
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
Subject: [PATCH net 5/5] rxrpc: Request an ACK on impending Tx stall
Date: Fri,  3 May 2024 16:07:43 +0100
Message-ID: <20240503150749.1001323-6-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Set the REQUEST-ACK flag on the DATA packet we're about to send if we're
about to stall transmission because the app layer isn't keeping up
supplying us with data to transmit.

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
 include/trace/events/rxrpc.h | 1 +
 net/rxrpc/ar-internal.h      | 2 +-
 net/rxrpc/output.c           | 2 ++
 net/rxrpc/proc.c             | 5 +++--
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 7b6c1db53401..dca9f4759dcb 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -449,6 +449,7 @@
 
 #define rxrpc_req_ack_traces \
 	EM(rxrpc_reqack_ack_lost,		"ACK-LOST  ")	\
+	EM(rxrpc_reqack_app_stall,		"APP-STALL ")	\
 	EM(rxrpc_reqack_more_rtt,		"MORE-RTT  ")	\
 	EM(rxrpc_reqack_no_srv_last,		"NO-SRVLAST")	\
 	EM(rxrpc_reqack_old_rtt,		"OLD-RTT   ")	\
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c11a6043c8f2..08de24658f4f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -110,7 +110,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_acks[256];
 	atomic_t		stat_rx_acks[256];
 
-	atomic_t		stat_why_req_ack[7];
+	atomic_t		stat_why_req_ack[8];
 
 	atomic_t		stat_io_loop;
 };
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 4ebd0bd40a02..32626ff377e1 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -372,6 +372,8 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 		why = rxrpc_reqack_more_rtt;
 	else if (ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000), ktime_get_real()))
 		why = rxrpc_reqack_old_rtt;
+	else if (!more && !last)
+		why = rxrpc_reqack_app_stall;
 	else
 		goto dont_set_request_ack;
 
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 3b7e34dd4385..1bab7f5a7d0f 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -519,10 +519,11 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_DELAY]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]));
 	seq_printf(seq,
-		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u\n",
+		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u stall=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_more_rtt]),
-		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]));
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]),
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_app_stall]));
 	seq_printf(seq,
 		   "Why-Req-A: nolast=%u retx=%u slows=%u smtxw=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_no_srv_last]),


