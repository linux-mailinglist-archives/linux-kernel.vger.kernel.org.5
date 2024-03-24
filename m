Return-Path: <linux-kernel+bounces-116243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A3C889DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829931C351BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D43C3912;
	Mon, 25 Mar 2024 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnBZ3zVA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BF17EB63;
	Sun, 24 Mar 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324004; cv=none; b=t95S/rLaHqZvhJHIqrQM41OZ/iQbGbK2nGz8yYgg/7dk9v5XGPHejT1Auvklk6NxpOCKxPWLPbcmzY6qj+EsQ5Tp8aRNHVFIBkrLxeJoFece3MqHEyKpTwnpSVJWSlUar0wgiKgu03vFgqXupPsGld/1RNstt2g6ldnMwdb/O1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324004; c=relaxed/simple;
	bh=GFFbQlzh6HC4SDDh95NsXiORtcwm6elGZF0AA+G9MdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV9z4aDI1XWt8N6ua7SaJS8Y9COtLapw0dRWdByOgQ3IOodMgwGo/U47ozpAMbxkYf5tPAnSzot9ib/12FsUPB9GJ+DUsoVcroyaQZGArLk8LuYkdQONs8SG48uOQ7BOI613SsBdF2dIAG05FKDE4X0Ioyp2ckHP+h7pXkFTJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnBZ3zVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401BFC43394;
	Sun, 24 Mar 2024 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324003;
	bh=GFFbQlzh6HC4SDDh95NsXiORtcwm6elGZF0AA+G9MdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnBZ3zVAhG+M6fEuOJnlP4PKU52wHFlAhRxTFXCy7jdjqTOX20MJVttveydTiKNAg
	 tTr8dWzKftpMieEhkzEHO0VbTcUJPtoR87UFZdMuosUhgNzAibQkF4KU3y45RUKkcS
	 8s5bR6iP/1UoGfK3alkFXn1xR2bBMEgN6+79mjq7YmQovpyT2H9DEfpwaCfIyypwWK
	 DqxI6o2Xy9yW1zcacnJft7oosIVZHbJvLKsffZPs+VDw0x7zqZg041IFA9ZB07pR5v
	 j5wQ5SLmDbu859dAhbIp+OcCvuZfZQt/fpZ5c1lKARX5F29D5N/TyAC0WEOAp6bUxu
	 ObYEMk5z5clhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/183] selftests: tls: use exact comparison in recv_partial
Date: Sun, 24 Mar 2024 19:43:36 -0400
Message-ID: <20240324234638.1355609-4-sashal@kernel.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 49d821064c44cb5ffdf272905236012ea9ce50e3 ]

This exact case was fail for async crypto and we weren't
catching it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/tls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 837206dbe5d6e..81bb3cc6704f8 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -580,12 +580,12 @@ TEST_F(tls, recv_partial)
 
 	memset(recv_mem, 0, sizeof(recv_mem));
 	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
-	EXPECT_NE(recv(self->cfd, recv_mem, strlen(test_str_first),
-		       MSG_WAITALL), -1);
+	EXPECT_EQ(recv(self->cfd, recv_mem, strlen(test_str_first),
+		       MSG_WAITALL), strlen(test_str_first));
 	EXPECT_EQ(memcmp(test_str_first, recv_mem, strlen(test_str_first)), 0);
 	memset(recv_mem, 0, sizeof(recv_mem));
-	EXPECT_NE(recv(self->cfd, recv_mem, strlen(test_str_second),
-		       MSG_WAITALL), -1);
+	EXPECT_EQ(recv(self->cfd, recv_mem, strlen(test_str_second),
+		       MSG_WAITALL), strlen(test_str_second));
 	EXPECT_EQ(memcmp(test_str_second, recv_mem, strlen(test_str_second)),
 		  0);
 }
-- 
2.43.0


