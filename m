Return-Path: <linux-kernel+bounces-114722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75B7889224
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157961C2DD44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B213CF90;
	Mon, 25 Mar 2024 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4sZcHZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0127210D;
	Sun, 24 Mar 2024 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323307; cv=none; b=XizuyVB5i9nO139HJelbkl2Lb8abJr5Tzz33dy3iSSJtQyWE7J7t6DbQ53mlabXnNXsb1mwShqKeFgrSC25s+YnfYQFFYFSCR8GkZwrwpo/qWE+OwMIClHpIEWCv5FcXaXMCm/QyCr7TWMcrPn5YzVUk7Eqh0wsxaFeopjGDQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323307; c=relaxed/simple;
	bh=quRhELaf4gAf9OEbPPzuRkgP1qmvcJtfgwZ/JQhXv8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWDoAE1FsJ/uYjjaz85nUplNpLlPULVh7J/3XdsDwGj9l2ljBgd45rvg/j7B1Uj/UIyEYbqkiF8+C+8o/nj9bewyPXOt/iSOClwnXPv90Ft5kTlJrzUd+VyqB1mUHLPxhxfoEDneyfH009rBmTIutnePqaFwNhSc4QuSvvAwP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4sZcHZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3241C433F1;
	Sun, 24 Mar 2024 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323306;
	bh=quRhELaf4gAf9OEbPPzuRkgP1qmvcJtfgwZ/JQhXv8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4sZcHZxrf7SonlCIqj3nL0Qx119QYowa02LBGDU3hdar2st46oMMaFAk82t+qSDb
	 5kmsLDk68PSumJs57uDcABKltWXM8eplYucLSnQ+s+cCiaI3+yW8rcHGkU+seaAZGJ
	 6Bir8ZhLKr95mxRWnNKzhTTs+YTSdbaF6NfeJCjeKyyXceoUtETQKKM+a+guqAhXIG
	 Uxl/ZEsUTFvEf3v1MZ4aj+4j7p4OGQl8TYGB/yIqX1V07cyX2wzaxlPqmtuW6PA9l1
	 YyEtrOKUvQOp0aYMza7VWoXyXVTbBoyYC+oBq00bRxEWI5NqYOm++TwJGuRnHFyM0J
	 niIqnYLP9liFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 006/317] selftests: tls: use exact comparison in recv_partial
Date: Sun, 24 Mar 2024 19:29:46 -0400
Message-ID: <20240324233458.1352854-7-sashal@kernel.org>
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
index 3bdb093731358..637f1b8ec13b4 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -716,12 +716,12 @@ TEST_F(tls, recv_partial)
 
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


