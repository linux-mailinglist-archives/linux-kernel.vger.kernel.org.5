Return-Path: <linux-kernel+bounces-114930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002D888C04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18B41C29463
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070DA1BE26A;
	Mon, 25 Mar 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja6ifQli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDC280209;
	Sun, 24 Mar 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323636; cv=none; b=KMuljLvmPUI5VwXdsJ0jWYMRiPD7jAigquB3iQFkLapQ6nLUf4d36AwM48unRq36152a1fcnntK7SnArx+fht22pwUA8i4HohXKsBefse4nsRfKnAiTerZBYrDyibrVdVvYutalv9Pwzpsh/LlYcUkuBZldzfF0IBeN2ybzVQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323636; c=relaxed/simple;
	bh=Yo+IjX1HMF7yDU/yvovsGvcfnMLDjmAxJteTj1nN9MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjmRIRyPOn6BkRGYpjtIrk/nKQojIcnUj8UjcmCaN0fqvtqS0HTw2caKk57THmgXyv7QNkUwp3QOyC2kDJRU6UkZItVGh2Op5/YKe/o3PhcxFQrB8riZuaQ04B2U28ZTKfPGHG2l45UyOVST3AK7hyde5RLc+V7s5J4Ht/fyHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja6ifQli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDCBC43394;
	Sun, 24 Mar 2024 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323635;
	bh=Yo+IjX1HMF7yDU/yvovsGvcfnMLDjmAxJteTj1nN9MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ja6ifQliUdwmqr9aWBMb59DdR/UJB+QPgiPOQIgbwXG0jphtpcn3sS3uFLf4RhLnu
	 f509v/NtelUCXWrsH3cf/54u0dNHpBpb5xG/XEgQhIEwYQKe321AKByyNZ7MH+pSSE
	 RKTY202J42HZ9Euquxty7A2XhHxl1m0akEm8r2KuMs01wnEzKLyYj0xg93sR5m85I4
	 LVmhrIzvrFjJv6a16C9KiZfyWO1K5SZXvrf4r5pAT6VjKyN+FTnOHZkFkyqKoY61f8
	 mKNO8NqF64CcijJV4Xne54dtENjM7jjfk6TqddTo2ZxaeCBVH2qA7+InkRIEH32AF3
	 O12C3QTXP0/bQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 006/238] selftests: tls: use exact comparison in recv_partial
Date: Sun, 24 Mar 2024 19:36:34 -0400
Message-ID: <20240324234027.1354210-7-sashal@kernel.org>
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
index 44a25a9f1f722..956ee3c01dd1a 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -653,12 +653,12 @@ TEST_F(tls, recv_partial)
 
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


