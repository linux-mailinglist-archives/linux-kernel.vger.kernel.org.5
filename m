Return-Path: <linux-kernel+bounces-114826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08384889191
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D201C2D433
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF037176FBC;
	Mon, 25 Mar 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhDCFYsc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90A278998;
	Sun, 24 Mar 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323450; cv=none; b=uvRSPw0BuhNcVdVZVArs8cirsVZfaduozOi0KIZfNtaoiJsjD/EiZIwJsCV0E3RYVXajNKkUtCODRyXrGNmezkIKJS7WETqyo8MC9q7KFQUr4EfdiYluxqf4Fs14uPJFgr1GeE1ZypwQzielwO5U/S5aZGNW0Z6eDjHomMWZLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323450; c=relaxed/simple;
	bh=fRURc9EA+Wjz171uYkXIOhdPEisDxnzCuFLmzd7uGvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUhBmJk5RwoLLJZS2B2NluKf/Ss6GCjWm3v/agzRl6VMuwUStdKc7YR1B9UVZaTOadKj3tg++fGzmpQyfZ8ZhrvtUOJPuyLxuR31AANcJdqFHrG6D9MhpSnmI5CdfG4lgmOca9tKEMVNbbEZrFG4Pt7zqul8plp/9o0fUknTa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhDCFYsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECBEC43394;
	Sun, 24 Mar 2024 23:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323449;
	bh=fRURc9EA+Wjz171uYkXIOhdPEisDxnzCuFLmzd7uGvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhDCFYscYM8o+voEkqJdXEeA1t/zfVZ2X5NwQDrG+jfQrYscgLPjdIFsdBnC1Di5B
	 zuBD9LfgDvcngCb4KPvwnPAkJKSv0dfbtPRUv5OfJwZHv0AkNXzNECqCyuul6x0FMy
	 WtyKJ9cx5+DinhjKXJomJyQ9BCRKq8pLMjGqz1Q0VLva+NgA7JbVr/6BPw4FLG1gEu
	 I3h9vI4xLi7ufccaWK+FlcKQvG7PT8exXKJBB4OUucNyps1VnYFXgyGkFPBPe0IOjb
	 k1cusa3gfMVVYzKKJsRMm4LuTffPnV7wOejC+AE6eQFNElDlqAFdb8kSzeX1YCgmob
	 pjxhmqfJbqvNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 152/317] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 19:32:12 -0400
Message-ID: <20240324233458.1352854-153-sashal@kernel.org>
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
index 07f6206e7cb47..1e5152fdee589 100644
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


