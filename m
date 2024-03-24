Return-Path: <linux-kernel+bounces-115413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E4889B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BD81F34864
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00794204FDF;
	Mon, 25 Mar 2024 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BljaAypH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22659142E8B;
	Sun, 24 Mar 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320593; cv=none; b=NiCeGrDi5rmxpfpnXWbToZjzoDCWNuaObfggEkpzzsti8QgEHDNd9ctqu14qYc5cgF0e9WPGhEdUaF1tS/posf6hKjPWp0X7ChT1lkXx6xMs4Xa7MeQoKnURhL0MAb3zpfLglsag1G9sOVdnnMOePat/sU7vhkfgliu9AB8Ge20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320593; c=relaxed/simple;
	bh=0+48isTzNvrmKnyqjubuz+hXbpcC9TAg3X50SmYHahw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QayZ1/zyAPfXMWuw2Trnbp8E5HUYfLQGyNH/zTLd9kc9Ihe6CjoJKR5Q9WyoiYJWppJfidV0EMATx1K+FQeMxQIFhGXSlFJ0Y43grtjSJoXheHynCGJrIQdmMgax/lJodJHrSupoetmw9FXtFRgYaj7V49SPCcr/5IDYLoh2RYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BljaAypH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB6EC433F1;
	Sun, 24 Mar 2024 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320591;
	bh=0+48isTzNvrmKnyqjubuz+hXbpcC9TAg3X50SmYHahw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BljaAypH48eKhFHrIntztfUIYbuX6F0MkO4omcAwqUe8cErRTG/p/EHD13IUzwniO
	 8nVHFjuVYqdS8NII+hcG+FPI5a8whMyDyoEgTQLPbOUV9cPcFtD6TDBA8JAzdaziJL
	 GEdmiOmoUIuJw/U5A8U589xQGV0F7banO01K6BIkc+5gC6SZx0ypOmfYi6W9gDe2yk
	 kYj1bBrrpt55sEDzS7/X1nhhZfj0/LaxLCwULS+0/AOqZvDsQuoutVBeyTJnp7h1Ab
	 4FyigRLXxU37OSYqgk28J2vh+aIF6Cvo5ZRqLL+deJqdUKabzfZvOnxjkbM8RY5OPX
	 GpzV+J61uHymQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 153/713] inet_diag: annotate data-races around inet_diag_table[]
Date: Sun, 24 Mar 2024 18:37:59 -0400
Message-ID: <20240324224720.1345309-154-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 7d0e7aaa71e0a..5f7fdbd01cf9b 100644
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


