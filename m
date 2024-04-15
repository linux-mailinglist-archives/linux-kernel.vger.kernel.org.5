Return-Path: <linux-kernel+bounces-145253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3E8A5178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FC61F22C64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D786642;
	Mon, 15 Apr 2024 13:22:22 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1812A170;
	Mon, 15 Apr 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187341; cv=none; b=a5LhcRVyoWaCSX27BGaId/9UWCaDSPKbeqUbiCCtl6xe0/l7UOhEafEQst/ClBZKUK/s2Q7Gg7+EbpQ0Lu3UmkrMX1S/TtLs4WVMEdMtPvRIWhbWIP72OO9DgNcDu11NtNST3ft9fs58n3yACIFs8myGaLLrCGb7En74TFPVhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187341; c=relaxed/simple;
	bh=77TAy3kea4Va3Is1I0qN4USj8ONZ6KixwSmbOIBXyLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBv/NIOvQ9DEiH7aTyMT6EiCxcj6Eznay6IOLwVDHJAVuXbUyZ/Fbkpi1r5XFX5Vl94BXN94IL1zfsU4lF1HpIIzch0jt93Vf5YijYt7zznJqtEAbXvTxCOlREXrUoMLHnCu9EcaizsAaxOE6DZ41SkFgIOOND3L5gmXFzOenXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VJ76Y514PzTmQ5;
	Mon, 15 Apr 2024 21:19:01 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id AD24918005D;
	Mon, 15 Apr 2024 21:22:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:22:17 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2 11/15] net: introduce the skb_copy_to_va_nocache() helper
Date: Mon, 15 Apr 2024 21:19:36 +0800
Message-ID: <20240415131941.51153-12-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240415131941.51153-1-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

introduce the skb_copy_to_va_nocache() helper to avoid
calling virt_to_page() and skb_copy_to_page_nocache().

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index a495330c5c49..d214aeca72ad 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2272,6 +2272,21 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
 	return 0;
 }
 
+static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
+					 struct sk_buff *skb, char *va, int copy)
+{
+	int err;
+
+	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
+	if (err)
+		return err;
+
+	skb_len_add(skb, copy);
+	sk_wmem_queued_add(sk, copy);
+	sk_mem_charge(sk, copy);
+	return 0;
+}
+
 /**
  * sk_wmem_alloc_get - returns write allocations
  * @sk: socket
-- 
2.33.0


