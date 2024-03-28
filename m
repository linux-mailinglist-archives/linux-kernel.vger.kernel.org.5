Return-Path: <linux-kernel+bounces-122977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACF890099
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521B21F25F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764012FB39;
	Thu, 28 Mar 2024 13:41:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089D81AAB;
	Thu, 28 Mar 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633263; cv=none; b=VA3/B9M7kprqeBRNHapyiaK72oq5vA/2w+IfPViLVZur2YCf4XNjLmX4QRrU8PPzUPGHU6Ri0WRGBxQTfXYp6W26dXLuUeMcqawXUmhSyWMxKAb+igkIcH1TDyNNye85/J+E6309s05JQA1dUtq9z6L0f4/Hc6g/jwcyJSVffr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633263; c=relaxed/simple;
	bh=+YJ5YJDIpQk7oAx/oDARWJ5TozchVIOjINAEsH4F3GE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toL+PjiglsqG6YSKWe15wK5ab+jeRdVwcCzE7N8i1PiJpQL0x+4F0VkR7Q+QYAwCGqXlO/NYn/kNtD5AhklpNJBVFjqzDi0ZgoXXP0nOdzfvD84pBUIPal65DIsU7sDhIvcbOMR6481MBaTlzarbUo/drK4dHZy0z80Il1XJvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V54Ps4hZRz1xsXS;
	Thu, 28 Mar 2024 21:38:57 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 576261A016C;
	Thu, 28 Mar 2024 21:40:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:40:59 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH RFC 08/10] net: introduce the skb_copy_to_va_nocache() helper
Date: Thu, 28 Mar 2024 21:38:37 +0800
Message-ID: <20240328133839.13620-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240328133839.13620-1-linyunsheng@huawei.com>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

introduce the skb_copy_to_va_nocache() helper to avoid
calling virt_to_page() and skb_copy_to_page_nocache().

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index b5e00702acc1..20df93699b60 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2265,6 +2265,21 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
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


