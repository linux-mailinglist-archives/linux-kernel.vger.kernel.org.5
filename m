Return-Path: <linux-kernel+bounces-114960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A898F888C35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CED1C29D52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C32DE245;
	Mon, 25 Mar 2024 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI6+96z6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EFC2811D9;
	Sun, 24 Mar 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323680; cv=none; b=gCrmj+7YA2zd2aWELObV+1/8E+6eTpuUnLZq/5ALypOFuoPqANwgLUL2lF8iXMEvgD0YnNqeaIdof4CQWSBTfaLWiN0meaJ1jsiq7NE9OlTK3QuJ8PTGgN0SMd9I+rKzWbpvZgZiFjooOWY8/mmy1MfP0UGyrVIjek8NeyCz5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323680; c=relaxed/simple;
	bh=75RTwF1RiKRiyBcXXdqr/7omHTpdRTEVzn66ZABF4OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpMoZuybVPXxPk+rROZ0ZdMF7vUPb5MLJJ4APyUr5rNZYVEE4qYDG7PPexxVEME1DGxylWRhmW5Kgk0qfJC+lPHHcZZhgOK+A8wOEeM9ji3XZlUe4gHPkap5Xr6z0JbeI6IKcboQj3m2SoSaHPg/1b+4rkj7f/RucbfyKfClpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI6+96z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18939C4166D;
	Sun, 24 Mar 2024 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323679;
	bh=75RTwF1RiKRiyBcXXdqr/7omHTpdRTEVzn66ZABF4OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NI6+96z6PGttmaFzKx0pV/pkgPVIvh8Q65dzySzYOC9TJT0ApFRo6Ijw4k9353XKV
	 +mUMAkLl3SWqCHAM8/vVP6ZTOjDPt1Uex8QmaiOpJQOoGGJ+F3Ora3iYve/LFQKlMD
	 LxjCqihyl2XQDqZDGK+pOGWRh4EgfzL0/3P0NTxt366p11NiSrA/XTLsqTs/oic6/W
	 MtTWbLkrHuTWRVfOu1qIuLN5c8Vk/kju5PCcE1SwZ757GYRG/Fw7/8qCmuqASCiZQf
	 zF4OcaeclJJF/HWRtkidk5TLuixZiGJRLNPK6BUmUFdHOq3BdL7IQvth0NsurTC+Y8
	 u3oMfqqh1e/Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 051/238] sock_diag: annotate data-races around sock_diag_handlers[family]
Date: Sun, 24 Mar 2024 19:37:19 -0400
Message-ID: <20240324234027.1354210-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index c9c45b935f990..bce65b519ee80 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -189,7 +189,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -205,7 +205,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -223,7 +223,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -282,12 +282,12 @@ static int sock_diag_bind(struct net *net, int group)
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


