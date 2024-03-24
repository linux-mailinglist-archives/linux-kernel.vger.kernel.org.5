Return-Path: <linux-kernel+bounces-115676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA3889D68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1611C34DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F5258A13;
	Mon, 25 Mar 2024 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpzwtXUc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666A20AF80;
	Sun, 24 Mar 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321605; cv=none; b=oF6oPCBkPsNDClH41OwL94nQc4jdTzBH0ONeHr/h5Ne4UwrPrqRVh+Prk3IzKX7ZzWxzD6o9zVi+y7Z8nC0SB2Frvc1GM65y9rKyKJMUXJtzQ+VWZGow5bwXvpMvgsengUUzZFFDfYl123IAvm7dLf95c1dslMApyCwLjnALTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321605; c=relaxed/simple;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvIzmTb8CaQG6Fs5+d+IfFnk1IvpIDu/qCm5Wsxe7dNeXMU5dQea3voVJRR/yOy3Qqk3LJOo+Ap6xGVKD45ka9Y2AqCDLr5NRF4usUpjhvVKjeR/bFGtn+FIGtX9sJJu9JBAUt/+duUY09W6WC8BwCD0KWRWuaJz2b1bL9Qdpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpzwtXUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFC3C43399;
	Sun, 24 Mar 2024 23:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321605;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpzwtXUciKLlUeNeKSpZEs7pPH08FsjHB4n6Lha4NTKTsstPntV5G6RWeUm89ZTlf
	 myIEM/8lamIAERO4kCZvfapre6rnZfPUnHWrzAkvcBM1VEzrRC+O17xOU6fokTzUXa
	 IgduMBf2qk5F3K3smDAu3gxk+nCeXOI7dwMtSIJ2PGlXQaUnsiOdaVKqVYrEPb8tI3
	 MAQ0DW6MsIU35SpxdhjFcAvHNmH3sadotJjW33H68hulAxBYkjXNUUIeuZ2v3KWsm5
	 8XwB6GmzVxzoD0VBKRxrSLFzfkbllwrtYl2ChYEDvtwpka6QzGYlFUYAM3rNrjyLQk
	 O24PjJ8h6HORw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 335/638] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 18:56:12 -0400
Message-ID: <20240324230116.1348576-336-sashal@kernel.org>
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

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 955e9876ba4ee26eeaab1b13517f5b2c88e73d55 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Reviewed-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f011af6601c9c..6146e4e67bbb5 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1356,11 +1356,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (!sk->sk_user_data)
 		goto end;
-- 
2.43.0


