Return-Path: <linux-kernel+bounces-94998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE68747EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FD5B20B81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83F1BC56;
	Thu,  7 Mar 2024 06:12:26 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D61B962;
	Thu,  7 Mar 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791945; cv=none; b=YCmWIFbN2u7Icluh+dMa5s8mR+mt6hKZZ5AmvxFqZaOKMT3s02aHj3mESPTeR0dRNU5sW77BPfMhQIlND2TzIm9NeW626zHOYNh4Mha+HfC7MXTqy0boh8b8rQ6ZSRbqmMNvxFKty/5lRzHe5yFEMavp/g86DsnhxSZrz9CxF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791945; c=relaxed/simple;
	bh=DRo6eJeGQJ00JVz4D2h95vwOL6LeG1q9aZotWKYLrUw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KzyR7Ob+/bp21/ZvlUhf3BhtvWM+gCZxwV8abStD59KM+2+GWv2Wu2ITzCK6AJyUmkkfuqZ/oXtpOImAuHV9uvLoe/CBYRWjIjLxbVSWpuinm5mIJxfXflEuucxezqY9aaYMwx3Intkr0qRUveOW6b8m0kIR/UPHBfUNUrvGJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TqzSK3P1hzNlwD;
	Thu,  7 Mar 2024 14:10:41 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FCD51404F3;
	Thu,  7 Mar 2024 14:12:20 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 14:12:19 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>
CC: <liaichun@huawei.com>, <yanan@huawei.com>
Subject: [PATCH] net: fix print in skb_panic()
Date: Thu, 7 Mar 2024 14:11:43 +0800
Message-ID: <20240307061143.989505-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd500003.china.huawei.com (7.185.36.29)

skb->len and sz are printed as negative numbers during the panic:
skbuff: skb_under_panic: text:ffffffff8e2d3eac len:-1961180312 put:-1961180408 head:ffff88800b6ac000 data:ffff887f804ffe78 tail:0x1e0 end:0xec0 dev:team0

Use %u to print skb->len and sz,because they are defined as unsigned int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83af8aaeb893..55173b4b3ec7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -186,7 +186,7 @@ EXPORT_SYMBOL_GPL(drop_reasons_unregister_subsys);
 static void skb_panic(struct sk_buff *skb, unsigned int sz, void *addr,
 		      const char msg[])
 {
-	pr_emerg("%s: text:%px len:%d put:%d head:%px data:%px tail:%#lx end:%#lx dev:%s\n",
+	pr_emerg("%s: text:%px len:%u put:%u head:%px data:%px tail:%#lx end:%#lx dev:%s\n",
 		 msg, addr, skb->len, sz, skb->head, skb->data,
 		 (unsigned long)skb->tail, (unsigned long)skb->end,
 		 skb->dev ? skb->dev->name : "<NULL>");
-- 
2.27.0


