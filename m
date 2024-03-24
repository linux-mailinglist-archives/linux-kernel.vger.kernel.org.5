Return-Path: <linux-kernel+bounces-114503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D4888ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1CE1F23F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E712261AF;
	Sun, 24 Mar 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aACjLFEJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26512D77B;
	Sun, 24 Mar 2024 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321951; cv=none; b=kvAxtjCWR2+KcE7eLruX3Jk+rPWGI6shCjRthjFSgZ79BipmmYT5jrsYZGfKT/Uy1vkju6mQp2RRN/j9BHOx4/QFMUjUwloF3Qh0QfqATWDmpTSDmcHzpBc4JREJT/vy3DcpcfdmSTUP/ypFHI2kOqeHwTsGpJdaI0HAZXIiQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321951; c=relaxed/simple;
	bh=k7GFb6/TvOGC/i81ZOJPpaXASgmoQdLymtrJI639qzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny82pPNEHERa4P3sfEqIOw9D22zQh/Nd1lp71dx+kDYTOkQVQXUTEaTJ7V6sPKRc1htZW67Wdwc0zmTCBzVUaO6qgVrTwu9NCJneeup5ndGWe1qa3EB/JAeOx4PrCaAzbjZuWyR6vEYOa/bkuk2F7rO4irXgoIUW/sFaiVCTK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aACjLFEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1E9C433C7;
	Sun, 24 Mar 2024 23:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321949;
	bh=k7GFb6/TvOGC/i81ZOJPpaXASgmoQdLymtrJI639qzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aACjLFEJi0y3eVTdoblZdELmHKI2nHxgaK7VouOWcHYhe3Ei/Z7DzDYL/TXvf9Uvn
	 L8Bx7HEjMB6rp5PHjTRXTm1WVz9XBluGlBjxdIw981RDnDNcc+LMgd4gru7hntnS/X
	 wjKfT8xLcd8WJv0L2ZPwRoVs8jW3AUh0BWzr9PQLoCH8azaOusylmRaHMfj3t6iWIe
	 aElQM35hlMtl3JmUrnMvMH8bKBvv4PR6Xa9WBkU9UIlEakybSVizfQzpjy++007/wE
	 diESrCtO39Du3b/HTVTCxnFxqUpN53sMISRWlxfkVKPFU1LicetVuWVCSEdC4rh8Gr
	 XZMes2kFH5p7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/451] selftests: tls: use exact comparison in recv_partial
Date: Sun, 24 Mar 2024 19:04:57 -0400
Message-ID: <20240324231207.1351418-22-sashal@kernel.org>
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
index 5b80fb155d549..d89ee6e1926c7 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -926,12 +926,12 @@ TEST_F(tls, recv_partial)
 
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


