Return-Path: <linux-kernel+bounces-116160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D738899D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22A41F33DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E63B35EA;
	Mon, 25 Mar 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6mwb/Rn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4E17B51C;
	Sun, 24 Mar 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323728; cv=none; b=VUQCgjz9VdwMrUHPFe5ZxFxJrgcV5vq8bhY9BvIu0voCpveK54A7eXFWNOF0Qgud+oFRppkOhZon7B0+JmjqRGJaUpX38e5k9tkvUn4slkP1faOjnTNDnTHEZncgMxc25nlQ7Z00R6UaRElbRbZnRoIfuEhX8LVGA5ZDIIQA6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323728; c=relaxed/simple;
	bh=pBN8wGTb52OpC2M3BNQFLcBGO3yJdW0XR67v5gpuFRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AymjoFzLt0VIfvwiiOMyLvyywARiMjcNCnrN68mvFP8IMXCabAvQBlt1aFT19ZI4+Yz2VlkscQQnxIqQuUtOncLLt8lEUjlqBImjGYqZARKSwIWAgZpAz0KcPdWmH8AfFwEX7Wk1fPSsim8J8lSefGQFTGH2ClEzvOP06yPxI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6mwb/Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5361CC43394;
	Sun, 24 Mar 2024 23:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323727;
	bh=pBN8wGTb52OpC2M3BNQFLcBGO3yJdW0XR67v5gpuFRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6mwb/Rnli0sj5sRkKhPqxIgMQWcRJSZ9PJl8DDcw2QLVpmhWBfW7cDshqllX8Tab
	 8fKGrs16Pj+m3ZiAjiS0lHHLnnEDFzMnbbcsrUTUgo/4R35MFofv2cjW1WbCyb6WGZ
	 1zkItveAdS96RH6jsULm0CX+j+avVmsvEIujO+TR1iUZHAEUxyYRRl6wfdk68ezQzD
	 Job0NJEqGr8eGcSHwoNDdcUlNtekPiPWgetABJCRJtr67pdGd5i6e/KjwxZScUzJ9S
	 IkR7T+U7RcN3NpoJfwljYTi4gYUGTI+RoLiVgbdg7lMENUckTOAF+ozeDEmlX7kfqN
	 aSdNQ1FgmZi4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 100/238] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 19:38:08 -0400
Message-ID: <20240324234027.1354210-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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

[ Upstream commit 716edc9706deb3bb2ff56e2eeb83559cea8f22db ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a5c15e2d193f6..2e874ec859715 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3742,11 +3742,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-- 
2.43.0


