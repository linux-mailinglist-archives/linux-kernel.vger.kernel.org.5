Return-Path: <linux-kernel+bounces-116268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B3E8895D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DFE1C28849
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF29D18433F;
	Mon, 25 Mar 2024 03:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmEXhu1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38417F38F;
	Sun, 24 Mar 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324081; cv=none; b=WoqQ3mTxjBIFvIvtPPCtbRYPP/luldJVSRqtuVHYT3cuvLePLQGJ02qFNCGm/AipuByr0Bi9JnFxIM/P4FsfRY8zBwyEUiS02WdXLKOlZdxLm7RGwLy3kZPyCJkuJDN/bkd6XhGX2IDSqSsowS4afkE9QDxBhdJhzMUeudIWEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324081; c=relaxed/simple;
	bh=78i/RA49PesZ7YOjbsrbPRisIy940gQvj2kC6obZGY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPw8APwkT+MojnxHJrSzynkEYCbHhky3dRKfJW382A1uHwyjBCRMfe2oFl4fiwmvjD/+PHrRv5z3ke77F7LFmselMCq2sBz3poal7sWrtnKtcrcrmLYxdF2JDGupaTjzZ5F5yKEzk3/ZqtUPyNnCbhwavuJXyFEgq6CXvzz9gPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmEXhu1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A90C43390;
	Sun, 24 Mar 2024 23:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324081;
	bh=78i/RA49PesZ7YOjbsrbPRisIy940gQvj2kC6obZGY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmEXhu1hT6rvlvk33iF+nIaeu426WyxkfN2kM5+eCFtFxf3fUlICiSnAsno66YbWR
	 erj8+p/mJz7aDZDOurTR4Im8i0W8+pvj9yFg5NFtojZPXq+RMTq7h3Q0pQr/3PSSZt
	 jHQfz2p4/KSJrjJlW1ZNHU2Gg+3jqLIX+6IHg2PxpfLLhTrabKNCC/17ClX1IGYU8W
	 tPBU6luB1xvOkDzMIwfz1YMPC44yQQw18Kc3FPwZJw+Wcv32BN3H3b7gkr+H9jwTkG
	 NdRcDa4OIApaU461GCv95R4wEeGUPKvdgpLl0TV6/F/OtJi02MHFAYY8UTP1LDJdMS
	 GGQAn1G7wwFnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/183] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 19:44:54 -0400
Message-ID: <20240324234638.1355609-82-sashal@kernel.org>
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

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit d6eb8de2015f0c24822e47356f839167ebde2945 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 43dd489ad6db9..851096110b4d4 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -470,12 +470,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		goto out;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	rc = -EINVAL;
 	if (len < 0)
 		goto out;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	rc = -EFAULT;
 	if (put_user(len, optlen))
 		goto out;
-- 
2.43.0


