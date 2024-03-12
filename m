Return-Path: <linux-kernel+bounces-100925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB157879FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1E11C219CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62752F7A;
	Tue, 12 Mar 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCWQxzBK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C050A6C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286660; cv=none; b=qUxTwO53HPCKx6GakDyp8AgBcY55y7cKziK+3VGbp5JfCtD46dtUpXPUZ802rkIdOP0DaeHTWqGex5T+r1xUNxVbXBB13bbCE7fMeqz060uCLNgeqYyX4Qb3JfzzhNq2KwFgpjruAWJJMDFYWzuEK88lNtjp9vDLdY92ri0fsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286660; c=relaxed/simple;
	bh=w8JCsLSjSA3OkQoV28nEFem36dFCa/7sa9d7M6Kmb8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwynpUz6BCg3Ek5zrlCVfOJnwe5s3cYCUPJIdIbGakWtNkKab8UMHDZl+R5+aaILWXF7Dx/tGkiN/FgB+wE/pV2hpeeoXqt7Or4/vyrbmx3I7cBHFnHQH4NnvwI+XaNbpBolOakpAqhHyYJpguzau1Hqqk9YsgTU6ZzMFyJlv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCWQxzBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710286657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OX7Txmvz9CCuXto10fOD2XvYnGo3IOMbl07Vyopd3Y=;
	b=gCWQxzBK4bjeQgt9MWyK4JBIE1EQAvzHDs8/43eD5Zo0mUByPq1u25EdEBBRLy3kyt8fu4
	RnPpGw7FwiSyCACzv+OMnZn++7M6KhsRiIz1VCP7dwTCcb9N9nVDTyjRFo+obZ3cTP2vFk
	+g7DWRTnS656So4mrS+5FHicucxrphk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-uMavIwFdNDGV7jNNc5g8HA-1; Tue, 12 Mar 2024 19:37:33 -0400
X-MC-Unique: uMavIwFdNDGV7jNNc5g8HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4527101A552;
	Tue, 12 Mar 2024 23:37:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C54F10F53;
	Tue, 12 Mar 2024 23:37:31 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] rxrpc: Fix error check on ->alloc_txbuf()
Date: Tue, 12 Mar 2024 23:37:18 +0000
Message-ID: <20240312233723.2984928-3-dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-1-dhowells@redhat.com>
References: <20240312233723.2984928-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

rxrpc_alloc_*_txbuf() and ->alloc_txbuf() return NULL to indicate no
memory, but rxrpc_send_data() uses IS_ERR().

Fix rxrpc_send_data() to check for NULL only and set -ENOMEM if it sees
that.

Fixes: 49489bb03a50 ("rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags")
Signed-off-by: David Howells <dhowells@redhat.com>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/sendmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 6f765768c49c..894b8fa68e5e 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -349,8 +349,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			 */
 			remain = more ? INT_MAX : msg_data_left(msg);
 			txb = call->conn->security->alloc_txbuf(call, remain, sk->sk_allocation);
-			if (IS_ERR(txb)) {
-				ret = PTR_ERR(txb);
+			if (!txb) {
+				ret = -ENOMEM;
 				goto maybe_error;
 			}
 		}


