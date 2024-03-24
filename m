Return-Path: <linux-kernel+bounces-114108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9388888876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265411C277F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357F23C401;
	Sun, 24 Mar 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGBosb5T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1AB1E7DE5;
	Sun, 24 Mar 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321411; cv=none; b=Iy1l/KfxncxrQQUpQaVjVuTFqnEDKQj0ETPvpcBw0Xe72KBrA+0hlKxaLDdsA3td/2dVijO11Z0HpFtrH9TWT+YXUyt0jjmndfklCQGYt/wD0lReE/oAIEOXLLZsrIBLtwaH+dQIrmHHkdnHPA3+USzFBhPVcvil2Dd17tSEsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321411; c=relaxed/simple;
	bh=D57pdJksZDNWerhEQsBg1nHrR5mUgawKpu8fiJ1v6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/O5spFvT+4JD1UCUkBU6OJ2m8a230KlD5owkv04DLVote2Pmlc0he7H6HG0i3w+l3JB4SUVDQfJ2emWJqEOVDhcT3RbWUHYUhcsUjZD/XsQJOC4D7W/bppVVqP+33LCOCZwef+Xx4UPifJqE1M+GWnwOWSJdDjdOrG22h207CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGBosb5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A7AC43394;
	Sun, 24 Mar 2024 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321409;
	bh=D57pdJksZDNWerhEQsBg1nHrR5mUgawKpu8fiJ1v6ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGBosb5Tg+CImmbs0+6/lYKAev1F+3qhLQWOY3CI49+p8zOzGeV1l+ECoprFQrI1T
	 kP5kfMZeYwfDftUT/iua2v7sd4fYA7EmY5l2Pbn3b/1NBtl5aAy5Q/j5agGIv14YNK
	 yjjDVQbQ3SJ8ND87a6uFCgDFa/C5yddsqmxKFyOGO6THBkR+fLGpdDy9EDm8BrHnn3
	 hiewSrBQQm5NLYzgAciYssE+AK+EP+HQhWjEasQdsgrQ9orMu7H29IoaAd9+BrtHTR
	 6Ot7lkvSPCZBpw4ht2XWnvqP58caSROaQ++uBCahLY3H2HwRQY+GQ83pUlGzm54pMI
	 WxycnagEoROZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 134/638] sock_diag: annotate data-races around sock_diag_handlers[family]
Date: Sun, 24 Mar 2024 18:52:51 -0400
Message-ID: <20240324230116.1348576-135-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index b1e29e18d1d60..c53b731f2d672 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -193,7 +193,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -209,7 +209,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -227,7 +227,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -286,12 +286,12 @@ static int sock_diag_bind(struct net *net, int group)
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


