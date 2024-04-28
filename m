Return-Path: <linux-kernel+bounces-161396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0648B4B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046CDB210A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39256B81;
	Sun, 28 Apr 2024 11:19:14 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3A58AA4;
	Sun, 28 Apr 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714303154; cv=none; b=GYnBqGQrcJX/Rt9XYJUXhp+g5N5MFCHMD9lR/MRKnWVzivbzqAICF5n2cvB0UzqDaMQYIOKa+ZyDN5Hdk4UUrdTuJjrBw3w0YE/gC/A621WjfHKrLnekMS7qEco+Pj/reqdX/Ji7jeXC3hzT9TdWpVWEw8xeHE2hcdHvkhQTIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714303154; c=relaxed/simple;
	bh=4+r6r9mLcw3DG9xwAzvLFDmxGy+SCZxO28Cxfof2pZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QezDR5QEkDtNz5Jw2cRX0QcGfcl/IzHqvq/He4KedXQQqs2M5Y9HwzTibCHi8SE4zSR7hee3WY6akLTvhWb276VxA07P/2ASKsaRhxFztNYmDRFsrCz0+PAKmdFp6+sW6EXKUEnRb2QunOyK4Q3qXaRz/m2SSZpYKY5HeSSzUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VS3mW54lPz1RB0m;
	Sun, 28 Apr 2024 19:15:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 77B0F18007C;
	Sun, 28 Apr 2024 19:19:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 19:19:02 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: David Howells <dhowells@redhat.com>, Marc Dionne
	<marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, <linux-afs@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] rxrpc: Fix using alignmask being zero for __page_frag_alloc_align()
Date: Sun, 28 Apr 2024 19:16:38 +0800
Message-ID: <20240428111640.27306-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

rxrpc_alloc_data_txbuf() may be called with data_align being
zero in none_alloc_txbuf() and rxkad_alloc_txbuf(), data_align
is supposed to be an order-based alignment value, but zero is
not a valid order-based alignment value, and '~(data_align - 1)'
doesn't result in a valid mask-based alignment value for
__page_frag_alloc_align().

Fix it by passing a valid order-based alignment value in
none_alloc_txbuf() and rxkad_alloc_txbuf().

Also use page_frag_alloc_align() expecting an order-based
alignment value in rxrpc_alloc_data_txbuf() to avoid doing the
alignment converting operation and to catch possible invalid
alignment value in the future. Remove the 'if (data_align)'
checking too, as it is always true for a valid order-based
alignment value.

Fixes: 6b2536462fd4 ("rxrpc: Fix use of changed alignment param to page_frag_alloc_align()")
Fixes: 49489bb03a50 ("rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags")
CC: David Howells <dhowells@redhat.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: David Howells <dhowells@redhat.com>
---
V2: use 'umax' and drop 'U' as suggested by David.
---
 net/rxrpc/insecure.c |  2 +-
 net/rxrpc/rxkad.c    |  2 +-
 net/rxrpc/txbuf.c    | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index f2701068ed9e..6716c021a532 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -19,7 +19,7 @@ static int none_init_connection_security(struct rxrpc_connection *conn,
  */
 static struct rxrpc_txbuf *none_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
 {
-	return rxrpc_alloc_data_txbuf(call, min_t(size_t, remain, RXRPC_JUMBO_DATALEN), 0, gfp);
+	return rxrpc_alloc_data_txbuf(call, min_t(size_t, remain, RXRPC_JUMBO_DATALEN), 1, gfp);
 }
 
 static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index f1a68270862d..48a1475e6b06 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -155,7 +155,7 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t rem
 	switch (call->conn->security_level) {
 	default:
 		space = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
-		return rxrpc_alloc_data_txbuf(call, space, 0, gfp);
+		return rxrpc_alloc_data_txbuf(call, space, 1, gfp);
 	case RXRPC_SECURITY_AUTH:
 		shdr = sizeof(struct rxkad_level1_hdr);
 		break;
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index e0679658d9de..c3913d8a50d3 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -21,20 +21,20 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 {
 	struct rxrpc_wire_header *whdr;
 	struct rxrpc_txbuf *txb;
-	size_t total, hoff = 0;
+	size_t total, hoff;
 	void *buf;
 
 	txb = kmalloc(sizeof(*txb), gfp);
 	if (!txb)
 		return NULL;
 
-	if (data_align)
-		hoff = round_up(sizeof(*whdr), data_align) - sizeof(*whdr);
+	hoff = round_up(sizeof(*whdr), data_align) - sizeof(*whdr);
 	total = hoff + sizeof(*whdr) + data_size;
 
+	data_align = umax(data_align, L1_CACHE_BYTES);
 	mutex_lock(&call->conn->tx_data_alloc_lock);
-	buf = __page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
-				      ~(data_align - 1) & ~(L1_CACHE_BYTES - 1));
+	buf = page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
+				    data_align);
 	mutex_unlock(&call->conn->tx_data_alloc_lock);
 	if (!buf) {
 		kfree(txb);
-- 
2.33.0


