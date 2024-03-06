Return-Path: <linux-kernel+bounces-93150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A7872B96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE371F2BCAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6597526AD0;
	Wed,  6 Mar 2024 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5kASfM2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D81200C1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683660; cv=none; b=NybF8m82AFHrEzwVHJSrCBNKy9+wxrO+vgJF3DzdSSj5RLGC79DpP3O5x3DTKZRG1AAWERDvgz5jBKqp5A+6GkkTJ1fEvCIk5jKp8NKJEdXhAheooCYLV+TJt4Ap686WL8kegW+mbu1Xou6M1iOPy7EJOaeZZqBqEW+oN2aGkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683660; c=relaxed/simple;
	bh=xqU7TdJ6uMoTB6NE2LCdz37Pqfl01I9/rlA/Td1pBIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RscI6MfdF3fMY4+cCBgBik+7hrQ8HjTHQs/ayRKT5wapgCKZIlVlEa4Gy6QwG4TvV25bFKjwVY2zF/BK8ALNE3AEVGAKoNKWZJXTpp0Sh56OIauw/NVgapGmpHRockFK/UcOwiKK2ncxRYG3AisONBNKca0KtqkZsj1mP+VfCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5kASfM2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFZQL0DrD/luJDZ0nEKBrlgAEZrrkxfF6eLg9CJqo1A=;
	b=d5kASfM22+YogtcFre4TPFwtaaa9x27clV6tZhRpW6TLH+JmxWPxNXnbeZajdlOzb95oTG
	+TjkxqMquovES0FS3ufq4XlcPXjt/aXgFxqm1aVjOpEnXO0IrEqEFZ2C4R+bQdfEng4Yt1
	xeJX5ZxZnWJoS6vch/FH3VKHoXqtRqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-lMuXae96MTqJPVPfWMJ_ag-1; Tue, 05 Mar 2024 19:07:34 -0500
X-MC-Unique: lMuXae96MTqJPVPfWMJ_ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 443D7810471;
	Wed,  6 Mar 2024 00:07:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1671200AFA2;
	Wed,  6 Mar 2024 00:07:31 +0000 (UTC)
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
Subject: [PATCH net-next v3 16/21] rxrpc: Don't permit resending after all Tx packets acked
Date: Wed,  6 Mar 2024 00:06:46 +0000
Message-ID: <20240306000655.1100294-17-dhowells@redhat.com>
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

Once all the packets transmitted as part of a call have been acked, don't
permit any resending.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 58826710322d..ef28ebf37c7d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -450,7 +450,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 
-	if (resend && __rxrpc_call_state(call) != RXRPC_CALL_CLIENT_RECV_REPLY)
+	if (resend &&
+	    __rxrpc_call_state(call) != RXRPC_CALL_CLIENT_RECV_REPLY &&
+	    !test_bit(RXRPC_CALL_TX_ALL_ACKED, &call->flags))
 		rxrpc_resend(call, NULL);
 
 	if (test_and_clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags))


