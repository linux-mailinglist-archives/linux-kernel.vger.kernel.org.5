Return-Path: <linux-kernel+bounces-100924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E85879FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E78A283283
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406024F88B;
	Tue, 12 Mar 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YY2GEu+V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F4482CD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286657; cv=none; b=UViR0UP3Jtpk/6oH2WApW7hZ4huR+cVpuG7MLYRlYrTDmpU0doris1/tPGRwxEc+a6pC66OjDj0llB43LjJkmtXbS48fZH2bE6JKCQqYaycA5eibll1MC+XnyZaGedXM3Wjl24mpMUELwyZGgGSm/115YVxK/skqBeXhB+LYSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286657; c=relaxed/simple;
	bh=yTIXu/sKqhCcK9sGsntr53/cH4qNlYidw+7xA1m4oXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RR1+dUmPozS3i9OibuOSUWndZXyrvYLZFmODLdJAkIJ9nIfYw258vsTnZx13467+lycjyGOex+mnMWTvUxlgWtEY/9mou/Cqlhb8RMMZ9H1cazbCdspPYZ3rgmC7Do7bOwcgYjDKflAnJZZDFEgs80Yz3yQPvCoxrgYDuuecA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YY2GEu+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710286654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOZDJSFUKIYqUSyAe6A//0kKA0XOQ3CbpICjDSiEJvc=;
	b=YY2GEu+VIpQuFhkKIMYM1fRnLtQnyZQeH/6HlkIHdg0Vdvkt57y1aUeYwfKh5vb+Kyak5m
	iSlC0n3mD9khL4m4bzFaxnDsHIHYTup+599FI5SNMcERlimSB6ozpXP/qKUEzr5ls3JdnN
	0cofTMhKE0HlBtgkEJu33OP5Ij6B4nU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-knBeSS_CMTGWUtT_AjoIhg-1; Tue,
 12 Mar 2024 19:37:31 -0400
X-MC-Unique: knBeSS_CMTGWUtT_AjoIhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED29C38035A6;
	Tue, 12 Mar 2024 23:37:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 49E0A2166BB6;
	Tue, 12 Mar 2024 23:37:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next 1/2] rxrpc: Fix use of changed alignment param to page_frag_alloc_align()
Date: Tue, 12 Mar 2024 23:37:17 +0000
Message-ID: <20240312233723.2984928-2-dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-1-dhowells@redhat.com>
References: <20240312233723.2984928-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Commit 411c5f36805c ("mm/page_alloc: modify page_frag_alloc_align() to
accept align as an argument") changed the way page_frag_alloc_align()
worked, but it didn't fix AF_RXRPC as that use of that allocator function
hadn't been merged yet at the time.  Now, when the AFS filesystem is used,
this results in:

  WARNING: CPU: 4 PID: 379 at include/linux/gfp.h:323 rxrpc_alloc_data_txbuf+0x9d/0x2b0 [rxrpc]

Fix this by using __page_frag_alloc_align() instead.

Note that it might be better to use an order-based alignment rather than a
mask-based alignment.

Fixes: 49489bb03a50 ("rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags")
Signed-off-by: David Howells <dhowells@redhat.com>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
cc: Yunsheng Lin <linyunsheng@huawei.com>
cc: Alexander Duyck <alexander.duyck@gmail.com>
cc: Michael S. Tsirkin <mst@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/txbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index b2a82ab756c2..e0679658d9de 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -33,8 +33,8 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 	total = hoff + sizeof(*whdr) + data_size;
 
 	mutex_lock(&call->conn->tx_data_alloc_lock);
-	buf = page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
-				    ~(data_align - 1) & ~(L1_CACHE_BYTES - 1));
+	buf = __page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
+				      ~(data_align - 1) & ~(L1_CACHE_BYTES - 1));
 	mutex_unlock(&call->conn->tx_data_alloc_lock);
 	if (!buf) {
 		kfree(txb);


