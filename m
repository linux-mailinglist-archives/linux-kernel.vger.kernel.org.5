Return-Path: <linux-kernel+bounces-114768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C204889246
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F761F21154
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21631B1AA0;
	Mon, 25 Mar 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWaNirCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A6275530;
	Sun, 24 Mar 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323366; cv=none; b=NbTBJ8hsNmRLY6ALPQfwHkEfJxTITdSi3/jK1VNBJq+teqL2fiJf4QL/dfm2/RLf87esQmUfjGj9LfVsU/tp2zQhSKglpy2YwpbiKxmfo1p8fcRWS0WsdcMTxo4ORqDsriNvJkg5ZRl3clkpLbWOfNFT8mHOE0NrX2ZNEERod+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323366; c=relaxed/simple;
	bh=H8zz5ZcHDr1oPz9K7S6HANhlVpDysfbtPJ+bRmjTSj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg1OCZL1qiPxXImo52dxdgTvXEWw6oYv6CvEFq2vfav5XI+LZNBn+aYVsuJEyHQrkj5QU5DAkAoJWMljU9vzQSIpPd9PBrIst55xlSjTYXTIF2d1C4JPjqonYM0m6gfKqUVc9LKKM/J9aU8VSoDabb1O54k8hUtGajCxCmwKdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWaNirCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A464EC43394;
	Sun, 24 Mar 2024 23:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323365;
	bh=H8zz5ZcHDr1oPz9K7S6HANhlVpDysfbtPJ+bRmjTSj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWaNirCGEWxC2D0uQ31qz/TNsYDN5EHBBmbYcU+NfwUztlIHbAA1DBZkh1FBAzgWR
	 nG6C7Px0ZHrC+KyyanubBnjWn6NKf638P7V9aZw4nqqNgrPjE7AOnzdHiSM3YDPsf5
	 +kB/PLYRVE+uXYEqvyl4kglOW9t6GJArnMuf4zKN+x0ePgzWsvBc2tU4Ybq49etRRx
	 hm2Q47r1tlsjNVGwKdUqRJIGG+LwPL+cPH6OoMICc3/lKeAe1J8MN9Ql2OG0LvI7yR
	 egr4TlWU0D71E/bczZ3ron9DiZIEIweqRzVcw/JuxDnXApli8LGhaHM4mlLVgfzPF0
	 RD43i1RVkBuHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 065/317] inet_diag: annotate data-races around inet_diag_table[]
Date: Sun, 24 Mar 2024 19:30:45 -0400
Message-ID: <20240324233458.1352854-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

[ Upstream commit e50e10ae5d81ddb41547114bfdc5edc04422f082 ]

inet_diag_lock_handler() reads inet_diag_table[proto] locklessly.

Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.

Fixes: d523a328fb02 ("[INET]: Fix inet_diag dead-lock regression")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_diag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 09cabed358fd0..3aeba9e2b22cd 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -57,7 +57,7 @@ static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 		return ERR_PTR(-ENOENT);
 	}
 
-	if (!inet_diag_table[proto])
+	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
 	mutex_lock(&inet_diag_table_mutex);
@@ -1419,7 +1419,7 @@ int inet_diag_register(const struct inet_diag_handler *h)
 	mutex_lock(&inet_diag_table_mutex);
 	err = -EEXIST;
 	if (!inet_diag_table[type]) {
-		inet_diag_table[type] = h;
+		WRITE_ONCE(inet_diag_table[type], h);
 		err = 0;
 	}
 	mutex_unlock(&inet_diag_table_mutex);
@@ -1436,7 +1436,7 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 		return;
 
 	mutex_lock(&inet_diag_table_mutex);
-	inet_diag_table[type] = NULL;
+	WRITE_ONCE(inet_diag_table[type], NULL);
 	mutex_unlock(&inet_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
-- 
2.43.0


