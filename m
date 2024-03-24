Return-Path: <linux-kernel+bounces-112968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA6888022
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A6FB23611
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922D129A7C;
	Sun, 24 Mar 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN4g1ghd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D0129A68;
	Sun, 24 Mar 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319780; cv=none; b=sxh4/qxBlthx1jHkoZXV29H4+rVrDgVwV+RnW9iFfd0a/lK2IIizDaChS1+CYsjSghpDdec0lvZ2urfYHXz2syG3loFH93bGTnolnQ8JAuyeqMva3+/MtP1TYmkCfn3pl1GCRuVQIn1E5QKjuceTiauQqotsGq/T90W/s1cahlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319780; c=relaxed/simple;
	bh=D57pdJksZDNWerhEQsBg1nHrR5mUgawKpu8fiJ1v6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtiA/hEK/PZwq7nO4NkRDyZnHU0ZxF1IkMoFPCp7LTcnOLXef1dkPpmc06c0imyDjFzNnhRQWxf8SggJ/NpyHu9ZL0sAoEnTzz+PLIYtpilcl7DhNy78Cd9HFf8+hxqadAgAJfiLwUL4uh8dk4JaTtFrUEavJo1FCBjlq9fN5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN4g1ghd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7F9C433F1;
	Sun, 24 Mar 2024 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319779;
	bh=D57pdJksZDNWerhEQsBg1nHrR5mUgawKpu8fiJ1v6ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PN4g1ghdsv8GUxsHW50QHBIrH8eOinGnrFR6odlIZbL9UxLiHQtB0tFTfRz3tPR9u
	 9+Ic+EsMc/kKVGz91iFRrmEhR7lsMTafOkP1MTphdO8Svp5wA/SZ7FZkXcGNADftjB
	 L92KHvCGsxbT5lXzvuy+aG+BMVAG8xwFw5lJPNawge8ozZMyuN8NZTaLFnARb/M9z5
	 ShqHwqjLjOTuw785dr5zXPFr9TjCYbhDKyo3SRGHrYNRM2iIGCT0FeWlwLPUzImER6
	 axzZlFCjhnLwvKYw7znUF8vPUdBgxFjOcYEGD8/UXJEv390iqp6oBxpRLlcW+Ua/2j
	 BhUOVmgbB4Izg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 081/715] sock_diag: annotate data-races around sock_diag_handlers[family]
Date: Sun, 24 Mar 2024 18:24:20 -0400
Message-ID: <20240324223455.1342824-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


