Return-Path: <linux-kernel+bounces-115825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C8A889829
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D2B291277
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774437829B;
	Mon, 25 Mar 2024 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBhB7dBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49316145B23;
	Sun, 24 Mar 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322026; cv=none; b=MsHr2yJUyTw9IHh0PYCN4X4ovqeIfvc7psAs/r3DEdjKOPT2EIpKi3YrcCX08UnZpGOD6kV4NQNeoBeoAgYnWj94y0cXnCp9pHRo00rkIeh0Y/wb1hybyw/KQViQi3CHqA3UsQSAr1NVn3xOGXtpFnKY1Uf3mTH/+qSjA2xHNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322026; c=relaxed/simple;
	bh=4znchTOCYaUr/IgrKzKS6ujbqx5EWo0s2CArLmL8vzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT/TDFCFW1uc6m4by7Djn+TmQerYxLdIlxsGkrexLo3NlwSr0OcLK4K4Xw6lVplZb+6Rr1Lvi8RA5TUhN3tE8UgOKhEaRLMHSkZSmVlCqzaDay2YpdsVTGFCW/10QjxYbfrmVhPDnamK2QYiipmsVfN/McM6aV4FC3zOQCUSfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBhB7dBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAEAC433F1;
	Sun, 24 Mar 2024 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322026;
	bh=4znchTOCYaUr/IgrKzKS6ujbqx5EWo0s2CArLmL8vzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBhB7dBmF82uzsE/PkNg0MJl4ujD6H7leU5pU/R5EiTRkC6ApQNyHdDIzn3t6Kkf3
	 /0KkOyBCjQzuZ+leyskgpROijoUj39AiS9s0bZrbDf3iuqR+a7X22PbTD/dAML8G+o
	 yyItpEV+XQLr5Szn6IQ/4fSHaopU3uFtYoXo1gGH8xUrtktFjpwK1Eo4uk/z2+lRVa
	 1sZDYWxqfXLc+cVV1qNOZvYyfK1RXv4a6MKp/2tz80fi8a6JsCnGevdcWu00TFxf85
	 5S3PqfIwA2/52auN9W42pbcgPlRnWbg3GMx8yUPUPVo9ek7TqFeF2Ij/25oU1v6Ket
	 2fSFdl/Dwwf4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 098/451] sock_diag: annotate data-races around sock_diag_handlers[family]
Date: Sun, 24 Mar 2024 19:06:14 -0400
Message-ID: <20240324231207.1351418-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index f7cf74cdd3db1..e6ea6764d10ab 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -190,7 +190,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -206,7 +206,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -224,7 +224,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -283,12 +283,12 @@ static int sock_diag_bind(struct net *net, int group)
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


