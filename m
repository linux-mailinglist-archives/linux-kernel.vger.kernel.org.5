Return-Path: <linux-kernel+bounces-114014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A16888F10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22371C2B44A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CD227E1D;
	Sun, 24 Mar 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqTSstGk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2A1FA832;
	Sun, 24 Mar 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321288; cv=none; b=cKiYcLF7NAsp1d9j4R0nuvkGTsizMdpiQh0+rMl/7O2VLrJX1Lfi5T5wAUgCl/UOfGQ6fnO5k+pH6oDkrSVVSqPyUxnPsLWpfaJwnek5smdAl92akDPYl5E+leAtHyAZvy5Xhg4eEUZx0kRx54Q/SpkqOAMxzteXlDvhtiDie0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321288; c=relaxed/simple;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1k+CyJGXk+Di9cVSdBPENBitJb+foTg+5j3yVTgeUdrB8OsO3aEEDHYzOqKhhmmu6R/9iMe9ag74Vf6dJI5Qu6gkZdyYqPLp5tHlqWbEIv2EWRrOfwoOMmZx7aXkKN0zaur11EzgphAoF2Ju8dNKkqtkl+GmiUQ43GL4dVVyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqTSstGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D50C433A6;
	Sun, 24 Mar 2024 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321288;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqTSstGksmou24Dl4qqlHJ+IzcX0m+HkmugQHfEbNBFA2PAAsDqhC8FN+j6Khy1fy
	 +WwdGEULPMIU48/UPUBYaS+VldSosw6CbJiFNE8FYzxIjR9+gb9fidojRVWqPKojE2
	 X60h32Xq/CNpw5c+UH0mnleZJF9QXFfgEQh/CBNnoa4muaxQP9u61HZTn6ONxSpwwb
	 lH4E4sZOakqMzPiMISzC/NpZI+X+BbD5TldUiXGlTkrJ55UzZjn0c46bbBpH+7qwsl
	 YHVCSIlgdhKqHauGq8xUjntjAwFjpqWv87koPDb6zmIvZFMkKFfIBZQlmuZ+jjdGB8
	 EYP1a2HcVVEKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/638] selftests: tls: use exact comparison in recv_partial
Date: Sun, 24 Mar 2024 18:50:47 -0400
Message-ID: <20240324230116.1348576-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 464853a7f9829..ad993ab3ac181 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -988,12 +988,12 @@ TEST_F(tls, recv_partial)
 
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


