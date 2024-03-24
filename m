Return-Path: <linux-kernel+bounces-116136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A95889EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E85DB287C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9A3AF2C2;
	Mon, 25 Mar 2024 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6YDQhwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98A2811DC;
	Sun, 24 Mar 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323680; cv=none; b=LiRYPfXdPKSmZ6WRFiBo+de2trfMwG/3D0xvqMiT4IHKgWCBrh9EWE/4DiDkgZ+Pvnon6ItVfHA1mludFSilopTcNBjkPap+8eonGEhyLzgHyum21p5nIJZnBQK9XwJbt0iJ2XE1dxz9dxXmXo8B9A2Uxw1DJ3LN5H1vJ6HBi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323680; c=relaxed/simple;
	bh=6m+hw0ytwK8q3A+8x1/O6dFDlxarc7SQSSmQSXbygAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAiDapxYRHykxgbaDicJM2yxwzrShV6TK05ibI4jHvzxRkvsFWGas3NQ2TpCv+4qv9PEHGFJJKWHKMPxpLrGtKnQTOEdlJrHH4m7PmFnYjcIS46fWaiwDkohloHBcQAae4h+JHq/h2aHj9AOi1slkkTF6FRcmT2c1LUCTc3oV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6YDQhwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D4FC43390;
	Sun, 24 Mar 2024 23:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323680;
	bh=6m+hw0ytwK8q3A+8x1/O6dFDlxarc7SQSSmQSXbygAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6YDQhwvcC+68Tf87qV1KYAWdKjkFx85pm4lN1QGizsmpuApoZGKG6wTMR5eA6QeO
	 E/yCd2YWCeCSduLqB5Q6be5VWaiVwZlVoo8NyPtNeEiRy33qEOQKJM0g7qvkBtkeJE
	 M/xGW5FMU4TvjsGNzYfZILlqhWa5Uyxh+zFLGvAJUNJGZ4TTozMLDL7Bmtkj8c0KMk
	 3PZ8n8ja/BqF6iMO+PFd85O+400G9bIORyn9lMwdGFjV+EAGOkEaPK0gQm5xgTqjpz
	 I9EhT1zZEUQQnSZ05WS28nup1yCS+iPfd/VI5ajWpwQuG06D1kH+mEpPJZ2/+fE/+M
	 KzozOTKl/PiPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 052/238] inet_diag: annotate data-races around inet_diag_table[]
Date: Sun, 24 Mar 2024 19:37:20 -0400
Message-ID: <20240324234027.1354210-53-sashal@kernel.org>
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
index fa9f1de58df46..27a5a7d66d184 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -57,7 +57,7 @@ static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 		return ERR_PTR(-ENOENT);
 	}
 
-	if (!inet_diag_table[proto])
+	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
 	mutex_lock(&inet_diag_table_mutex);
@@ -1413,7 +1413,7 @@ int inet_diag_register(const struct inet_diag_handler *h)
 	mutex_lock(&inet_diag_table_mutex);
 	err = -EEXIST;
 	if (!inet_diag_table[type]) {
-		inet_diag_table[type] = h;
+		WRITE_ONCE(inet_diag_table[type], h);
 		err = 0;
 	}
 	mutex_unlock(&inet_diag_table_mutex);
@@ -1430,7 +1430,7 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 		return;
 
 	mutex_lock(&inet_diag_table_mutex);
-	inet_diag_table[type] = NULL;
+	WRITE_ONCE(inet_diag_table[type], NULL);
 	mutex_unlock(&inet_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
-- 
2.43.0


