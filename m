Return-Path: <linux-kernel+bounces-115205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9B888DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A34295C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DEA30D4B8;
	Mon, 25 Mar 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMi1MDye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CB29448E;
	Sun, 24 Mar 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324283; cv=none; b=NiZ7NzzBREGXXBsIpGQxGJarNIz1nPbFKFjymlxdMGWQ/vo63+wFsMVFExBG5uJcRcDLq1/nX5lUYIoNcJ4IKNgmxn1YAuErRA9u10hqE/yh7k4QvVhnzjkej4GBkqxw8ME36Z5B4gSKFHlJBl8Tl2K8OAKCaCig+6MTmZonpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324283; c=relaxed/simple;
	bh=lwzXxwSWoOLNU+zV6aEFEVRdKo2gqhEXmatN3mGmyDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7ri2A5oirSd2vAWVRWs93tCoDaEwCsaWq9hUDFdzHlb17luay3Lfd3+vxOTjFNECBQ/A7aXx2f2j1Y4DakcnxyscE8okez4jgqPIMw/nCkCQna3JiC9M8JXq426uJlROBwIiRN1Qz891OYZU39G4R0funGrC+0XzNpXhLxgeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMi1MDye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79F2C43390;
	Sun, 24 Mar 2024 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324282;
	bh=lwzXxwSWoOLNU+zV6aEFEVRdKo2gqhEXmatN3mGmyDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMi1MDyeQgiE/tl2v15zpxbbrg+aExXjvhp+cdfH7h5G2pgjzj7yjvlIAQdB860q6
	 3GjmFH5jTwJoGbD1DsDnYyi0x6/2RazHOgwrr5l+rE7huXBVTMcPdK8STqYxBUlGI6
	 J5lw5os1TyB6ScISBhREU/4+PifvY3nyFAl8CcPMozUdZYEBmCZa8t553YxZ5TIrx9
	 ANZj0IkcTIyhupww/hh3U4HxMC3G0or+L956fBC5/69h/dgRjV+CCW0S+bfLGhEt8l
	 N4f91t9ATwyBhhHUq6jfwp7/NWHyZ1jMNGOqyGTS0BU1f01cbIG9iEI+GhyfTT/9bU
	 puf5qKekKTHAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/148] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 19:48:43 -0400
Message-ID: <20240324235012.1356413-60-sashal@kernel.org>
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
index c0956781665e1..3ed3b85f30b6e 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1380,11 +1380,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (sk->sk_user_data == NULL)
 		goto end;
-- 
2.43.0


