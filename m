Return-Path: <linux-kernel+bounces-115869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90B88985D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB791F35A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023001591EC;
	Mon, 25 Mar 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIXbUngG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2F145B29;
	Sun, 24 Mar 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322027; cv=none; b=d5UOMhFE4HRALpAYoKiOHtaBzN+oVixvkbtaGV3ma+0w6sycGRpEwSnI/CQRCVdAzAEH0CkKWfDfVcNb34SrIo2yGnytsDZ/XAuU+MUiGzWFl3xfwl8+Pl6HJ6BklvbAaHdfvwvk8LG88RPeFRXYxk+Dc+Ete6EVe4Gqr2IofcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322027; c=relaxed/simple;
	bh=40v7DOVjA7rwg/GnBHyYenR1x2eP7t8SduFzhGeItWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRPGAytlArRwP7lUoGNGU1xjXhqDrO80Ipv11jEYOF1nhC68U1PQ6jZGMnoNQ8cllL1K+rpEryJMeCg/3354iOHkZiJ/3sCZQQXA2qjmAH2K7z+4xtsBqtdbIPl/7qP1OGETSF3js+TFB8DoLUZHqAFXa2kmwSo/6jty6XkzRks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIXbUngG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E06BC433C7;
	Sun, 24 Mar 2024 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322027;
	bh=40v7DOVjA7rwg/GnBHyYenR1x2eP7t8SduFzhGeItWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIXbUngGbW4KWtWfvxOlMA5cyS0ZYemSj953Cnr5V3Xdih7eQFUjgMdpoz+k376Bn
	 zxw6I1W9yYoo3YHL8i2O+dgZncklbG/hP7UEqBLTj92xhH4pxrtpIIN1AWlO8SSdtv
	 sGCZoW4nKSYVz7bjBS3692o/c0YXbOI9ECf64UTA5e9KTMDREFryX2raKHRWxU2tsQ
	 aOqA457jGQ0QNjsDVkPOJ0Qd2x3dXfzhIkFYCa1o6fB0mhOJwPLPdNg2ixT7Jt446X
	 itYsIPKarfeARR0paCsGiRbtSaYimkSnfWpsMRWWjVRJNRQb5VsAHGWSNpZtLaaTfJ
	 8wWd4sIVCdbgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 099/451] inet_diag: annotate data-races around inet_diag_table[]
Date: Sun, 24 Mar 2024 19:06:15 -0400
Message-ID: <20240324231207.1351418-100-sashal@kernel.org>
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
index f7426926a1041..8f690a6e61baa 100644
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


