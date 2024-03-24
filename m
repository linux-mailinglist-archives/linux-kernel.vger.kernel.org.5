Return-Path: <linux-kernel+bounces-113800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE9888E93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257571F33653
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A001FA80F;
	Sun, 24 Mar 2024 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM3JDL3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71843146D61;
	Sun, 24 Mar 2024 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320819; cv=none; b=IM5QJNNFvjEpbjZT3uws9QnceJ9v1+UB1uAXH/VrTvhOYKj2iGBXa+R7i2HE9s4lVGqgvSaq3UWzvZr0sABr4NHiF2IB4CEqyCrgIyrC2hcjySirhsZaAzPI21S0i5qZDQt1GuhLnu2n34OZ4417NRzLs1Hl+0YfeMawQTqswJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320819; c=relaxed/simple;
	bh=AfZxNChh6nQgv6CiSACYtKJCz7TflBew/qgCzAtcdW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjmo6ZUgpZv7wkjtxAScdd24uzEHe/5dG3OwmPmjoPG60tiy+OcFpRX4nkoqANDJdTj1qujSb296vmOadMBIL3NNxLnBChgz4ohP59hPf1gSdU6R4iVXD8tE52R7QesiwQz6KMAlZ3gtXLfbp4vdi/XIbZ3Fe/1gnr2SzLpXlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM3JDL3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE30C43394;
	Sun, 24 Mar 2024 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320818;
	bh=AfZxNChh6nQgv6CiSACYtKJCz7TflBew/qgCzAtcdW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uM3JDL3ql0jC6rtunJaXe1kjBtlZgE6fw1PAlBXq5dBlfPCjf3Szrv3xYdSp7AmbH
	 srJJUUAXiU5GFAmZ0OKKKhG87w+Mj1IsIwncXd9JHxdpxAN+g/Xu1sVD4vK76ww4Pf
	 ki90/V0TC1r3bT9OK1YZ4FlWdv1M1XEl/9FxDGqNZqHkOF2RWtgx6xsY1867ybYkSp
	 FltuG9m/Bsz0lG8eycmJ2Jxvzm5GbQfVXnBbKfrKODcFFzHDP1UszhEEavbm6kAGcF
	 ne71OPn/JhjmZNSLyxylVI8sbgzLN0pu0HJrWPIHCX0Hw0u2bkD9u5uWmcfnJ3US65
	 3WNWke2HQ/ilg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 383/713] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 18:41:49 -0400
Message-ID: <20240324224720.1345309-384-sashal@kernel.org>
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
index aad8ffeaee041..ae90696efe929 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -460,12 +460,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
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


