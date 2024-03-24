Return-Path: <linux-kernel+bounces-113618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2A8885BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20C01C25169
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887301D2A99;
	Sun, 24 Mar 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm2KUXB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CA76402;
	Sun, 24 Mar 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320453; cv=none; b=XJGqGOAJWQZnJae3EhEJPrlDjKAhxdBXkPuPMxnIeKai7wYuEoQdpd73Ved4NTa1pm9w7L57In9on6NEwfYq7ZtdfDXKwUHJBwXRgyC1+0u1wqR32moDpEXZmkH0gV/DFOTfwgJSE8k647YYG/ZniEAMCwBPl7sPykOBO7vSyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320453; c=relaxed/simple;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBFjPWB5pX2exCN1wK/f5gt2CL0t5cl2WYSSk9axuDhFpJtAnJZeYB5cdLsFePrFLrf4a5E3u4LBzgX+2y8Cqr0/FOMZvK2jVBLBZAmhk3KXTg55Yjz/LJ6GJ9vLPDja2itGLZzHAqIaq7pp9eGdLtHBHXFOGEjorMxcVDRPYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm2KUXB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49339C433C7;
	Sun, 24 Mar 2024 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320453;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pm2KUXB7K1eLCm/01mmNbTfPiyVxRUCMfO/NZp73d5v73Jb1Gy3ZiO9RiYGKGBuJp
	 yp7VULQ/Iwk3jkqS3mc/oAFk4jjx/P1G8b4eM4uDYYV0Lytinli4Bu94dKyoA0DHM3
	 mnVof42lco0Kwgxu2ulMeWFce49d3rsRd6pAqzSDY+93Ypceu2KBKAfVvEK3gFHe3t
	 RkIEEnq/9bmFOZc0Qm9ixG8bnS1evzihta7u2drH80Is5GMZkeECngn1k6K63CI2WD
	 lO2D+nhjHjoKUJSMjhOQI7XTOternuJuf9D3ZujKqqkXRp3CkXhwcAWYFFmvI3tPvn
	 T4S1LpQlSosuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 011/713] selftests: tls: use exact comparison in recv_partial
Date: Sun, 24 Mar 2024 18:35:37 -0400
Message-ID: <20240324224720.1345309-12-sashal@kernel.org>
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


