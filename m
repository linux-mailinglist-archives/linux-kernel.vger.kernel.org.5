Return-Path: <linux-kernel+bounces-50013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13E847302
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B47C282C4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA8145B25;
	Fri,  2 Feb 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGAeD4Qs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523A1474AC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887214; cv=none; b=Ld48WMafvrHzxDSRwIBclrbboKlMWIoOVMJWgH7EiFL6hWiRLjwj+s8IeQRuuF6mmlaeLOy3PLU51fjvIUNoBv6OLUrvwxd4xWl6cWzsfXCMacOulKSjh71HDk1YRBO8YHBAj7AOrOFZlVeVNRBj0jxSr3QhWonfSZGYDUwdoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887214; c=relaxed/simple;
	bh=r7Nry9oL9TkD4iL++0wjmJRlASXSaQRwNQreDpD18DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4QMbt28nfAQahGG3V5nWjZJIXVyWeXc2T6jvhlltB6r6qMHtwldSOOgnsIz6j2JjE7WQXZN5JuUAXXuZOLKBCTD2QJV/Ce0zL8318+kI9ZQ+MxfVSLFVdmZz++Dn+sHKOS8g7xFYsl/6DuXQ42J6RJ4IfnC15I1beUv/Fj/Zbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGAeD4Qs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1WveAHZlbT2Jr8SpAue0DFDakkoJsIm8keFO2yBAaw=;
	b=PGAeD4QsLIr0OnDsCa8XHTOOCEaXKjDadP1W+VdJf3EkClH0fY7tqoXPYjrgUL1FBpvzqh
	YvTHuk7IZQcv8nw6s+7JkCg4fCKMJgCjpHg3cgH7pvIyAPRmGqKMUSm4V8Ypg09XCIDnvj
	sOFTcMzPbg/RJtrmXQzr7YnK3wvpps8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-S6Cdw6QnOlixQ6GwBf46pA-1; Fri, 02 Feb 2024 10:20:06 -0500
X-MC-Unique: S6Cdw6QnOlixQ6GwBf46pA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F3483FC23;
	Fri,  2 Feb 2024 15:20:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECEA9492BE2;
	Fri,  2 Feb 2024 15:20:03 +0000 (UTC)
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
Subject: [PATCH net 3/4] rxrpc: Fix response to PING RESPONSE ACKs to a dead call
Date: Fri,  2 Feb 2024 15:19:15 +0000
Message-ID: <20240202151920.2760446-4-dhowells@redhat.com>
In-Reply-To: <20240202151920.2760446-1-dhowells@redhat.com>
References: <20240202151920.2760446-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Stop rxrpc from sending a DUP ACK in response to a PING RESPONSE ACK on a
dead call.  We may have initiated the ping but the call may have beaten the
response to completion.

Fixes: 18bfeba50dfd ("rxrpc: Perform terminal call ACK/ABORT retransmission from conn processor")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/conn_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index ec5eae60ab0c..1f251d758cb9 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -95,6 +95,14 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	_enter("%d", conn->debug_id);
 
+	if (sp && sp->hdr.type == RXRPC_PACKET_TYPE_ACK) {
+		if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
+				  &pkt.ack, sizeof(pkt.ack)) < 0)
+			return;
+		if (pkt.ack.reason == RXRPC_ACK_PING_RESPONSE)
+			return;
+	}
+
 	chan = &conn->channels[channel];
 
 	/* If the last call got moved on whilst we were waiting to run, just


