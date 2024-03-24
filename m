Return-Path: <linux-kernel+bounces-115066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4888894B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCBBB33C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CEA1C320A;
	Mon, 25 Mar 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJgnNNXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257F2892C5;
	Sun, 24 Mar 2024 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324041; cv=none; b=XKjVb0pr9VTuXu2DbasqzD7o1LswNVua4sQzl1ClWC8eXzHK+jwKLUJ8nPgabGD7Wr373uxPqPRu6n0RYFgClvyd1IifNI/AAnWwfLqsArGtBAFJ9J/kZgcKCHKARoFziGUTEjaPuvsoXA3LBUadPsR8ArXY5zUi3sRI4Cmpu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324041; c=relaxed/simple;
	bh=3LozpwnbnWU3VCjQuiw9+8pmki9smLffvfOJBovQu50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh3Pw6NWBNXxshARbodgFP5hQyl7h874kWK1C3ABWRkXucqOIRHPfTNlchRw6go0SSi12Td1i16d8FmaZigcLzoxPjT4NfeR2BoC4tUVHyo6TsJzT2XRjTkwt9isvA4mCS1Nymr1LRiazcIqGTTp/lBYwJsTru+vdEfso0BzfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJgnNNXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A3C43390;
	Sun, 24 Mar 2024 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324040;
	bh=3LozpwnbnWU3VCjQuiw9+8pmki9smLffvfOJBovQu50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJgnNNXwd24AnOBBIgwTwfDI3qeKh6r8toL4eWVg2oFGj74b9WxiAV0sDfGbYeWtu
	 s5R3+BKrcE04GiRjUBLFsIOJZILeaLIjrDYABQMDSxin2dlgfY0JAMFD1Arv2Fb4Z3
	 2pus4oa9rw62H+2/CEgc7QHmTOxk/vWH8aVMIukSX4I6aZB098tsoXCP4ACRKs3VM6
	 Zd4lULv5NM2kIsnf+jY3z9DEj5N/u2r9N2PWCW3EPXNWPXkbGijAb0k5yFJIx8ytdS
	 FQ1/uztQnN3gt2fGc7/yYOYALH+TzOKeBWQxcxci3LGXzjHRlXl86f0dSH3zV4X0TS
	 aErI2dkvGWpFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/183] sock_diag: annotate data-races around sock_diag_handlers[family]
Date: Sun, 24 Mar 2024 19:44:14 -0400
Message-ID: <20240324234638.1355609-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit efd402537673f9951992aea4ef0f5ff51d858f4b ]

__sock_diag_cmd() and sock_diag_bind() read sock_diag_handlers[family]
without a lock held.

Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.

Fixes: 8ef874bfc729 ("sock_diag: Move the sock_ code to net/core/")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_diag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index c13ffbd33d8d6..315a5200d170b 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -188,7 +188,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -204,7 +204,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -222,7 +222,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -281,12 +281,12 @@ static int sock_diag_bind(struct net *net, int group)
 	switch (group) {
 	case SKNLGRP_INET_TCP_DESTROY:
 	case SKNLGRP_INET_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET])
+		if (!READ_ONCE(sock_diag_handlers[AF_INET]))
 			sock_load_diag_module(AF_INET, 0);
 		break;
 	case SKNLGRP_INET6_TCP_DESTROY:
 	case SKNLGRP_INET6_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET6])
+		if (!READ_ONCE(sock_diag_handlers[AF_INET6]))
 			sock_load_diag_module(AF_INET6, 0);
 		break;
 	}
-- 
2.43.0


