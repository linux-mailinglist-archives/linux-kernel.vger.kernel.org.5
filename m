Return-Path: <linux-kernel+bounces-112969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF03888024
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495912804D1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D34129A92;
	Sun, 24 Mar 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2ZyWgqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B002129A7D;
	Sun, 24 Mar 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319781; cv=none; b=WR3p9FcpXqeNDeubCkiXPqa7OVcXdbEavC2OpifJ7UAzAEI4cRL9qdfuLWv7uMkTgZXDhUVHO/HT6+i+1aeglF2kH/IT2b7yry7vGIAdCuloVnhvAapHgGib/njYvqlnhs5ZDWyVwwMofEUkHV9GkIbZKDhUTFriBtMTK2Kuy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319781; c=relaxed/simple;
	bh=06FpT3mRKSJTpgTZHFDze+IrA6YW+8cePTPaBKN39AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kedkT3XB1DpRtXqTWdcoz+Oc1rNDbas6IgUBDs8onNP1bwOn+G5qSvGD77/OLbESlpVOWOiGAgTc0b5MZrqUtObA6pnM5qoXKYt7G1JzFVv3Zd9h1ejWw8KSzqZiVdOUVAXwAAhJ19rvOr6MJI/A2RO01u5oDrbh7aU1dIB3vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2ZyWgqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2763EC433C7;
	Sun, 24 Mar 2024 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319781;
	bh=06FpT3mRKSJTpgTZHFDze+IrA6YW+8cePTPaBKN39AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2ZyWgqazo7hKazo4zZ2y32RDv5fd1BkQgm2Wm5cny98oZ6LQkrbFwIQfPeJ+BrSR
	 /+6q2THE5S/+wyJs/OOLTD06ohlxcv1vrFArNHczBbVOCCu59dQ4s2u7GC85/e8TP2
	 YYrdX+eVGu/Avio95wUyyi0PdFP1i5xhcZTukG562vmCy0EmoYbaJ5lrvi/5eYEdzj
	 L0LD+jkcQG+NfgbRDe668Eb7bRjRZzwRlltiibguqeS4s/XVn0THxo4i+uB1lYNWWb
	 1oCgbiI0kAwIWBXbuTXf+LAIIl7bg9rC2nGtkL/zUhLfZRDiwCL1M9BKzgRSoQSq4B
	 +Y1LSGHWtp73w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 082/715] inet_diag: annotate data-races around inet_diag_table[]
Date: Sun, 24 Mar 2024 18:24:21 -0400
Message-ID: <20240324223455.1342824-83-sashal@kernel.org>
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
index 8e6b6aa0579e1..9804e9608a5a0 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -57,7 +57,7 @@ static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 		return ERR_PTR(-ENOENT);
 	}
 
-	if (!inet_diag_table[proto])
+	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
 	mutex_lock(&inet_diag_table_mutex);
@@ -1503,7 +1503,7 @@ int inet_diag_register(const struct inet_diag_handler *h)
 	mutex_lock(&inet_diag_table_mutex);
 	err = -EEXIST;
 	if (!inet_diag_table[type]) {
-		inet_diag_table[type] = h;
+		WRITE_ONCE(inet_diag_table[type], h);
 		err = 0;
 	}
 	mutex_unlock(&inet_diag_table_mutex);
@@ -1520,7 +1520,7 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 		return;
 
 	mutex_lock(&inet_diag_table_mutex);
-	inet_diag_table[type] = NULL;
+	WRITE_ONCE(inet_diag_table[type], NULL);
 	mutex_unlock(&inet_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
-- 
2.43.0


