Return-Path: <linux-kernel+bounces-116324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0B889E42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36861F37515
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080833D52A3;
	Mon, 25 Mar 2024 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVl2O/Qg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0CC2944A1;
	Sun, 24 Mar 2024 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324287; cv=none; b=Rydr6EGhtqR+2dN7Eu6bE9/DzLfQYuc64A6H/6YxftJtesFy7SBfU/bL7BArIrmvBD7HNIS9gCkroM1ZefTbnIWwS5FU0F+3X/IZJiz8xGp81l4wFh3EBDlryV2NbfhLxD+sMuCHfYHj6NML16OiqVh1v1DHXsVDKX9jamkuCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324287; c=relaxed/simple;
	bh=AtFzqDVBmi7701nAnV2WFXR0J4wXEjsi4aMYf0fKSDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwdrtcFX/cGlTaDNZhcNA2Yrlad+cQE5a5iCKc56S4F5K5tKNznH/Va9quJqsCeDZomOtSYT8tUE6+n0pjDdN+a92wQtGwvYkwFTKvx3l5LX4PuZc8ftMi9k7f8rcCImDvIAa6SmFKg5R9qejEnojHJ7RWDmYi28onJm4R4t3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVl2O/Qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6683AC433A6;
	Sun, 24 Mar 2024 23:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324286;
	bh=AtFzqDVBmi7701nAnV2WFXR0J4wXEjsi4aMYf0fKSDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVl2O/QgvXYWUQm7eLnvGv1688zmcksbEdBX9aIBuvsXbkGCMor+X/HRR6YLSp33T
	 RkShRrOq2/N6uGSVwqLWyn4RdbB3hZ/Z/70xoEWKdHGXwRliw2A01EtsoyO6ls/giq
	 7stYlFkHx8GTALBgqiQTQU3zJlIO8t2xgocPuiejZ/mLjT+eyb5zYD8mcoommvmBfC
	 tSJiy3PDKBxAfIfcna+MTyo3e6zeJPLf/4L17Ik0aDToxbKg92e+wi4wid2SZxWuoe
	 94U3vyNt+RBtcm5iKPuCg0lPWKEQ+m0eFgob2DGNC1hgTs/gM9AHDT1yeMT8a7f7+R
	 iLLRy9mYBAsNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/148] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 19:48:46 -0400
Message-ID: <20240324235012.1356413-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 9d0328bb30ca1..8d78f204ba3c1 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -475,12 +475,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
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


