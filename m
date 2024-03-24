Return-Path: <linux-kernel+bounces-114526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E3889045
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298B21F2AE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF428FEBE;
	Sun, 24 Mar 2024 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIOImOAf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E37149E0F;
	Sun, 24 Mar 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322151; cv=none; b=gPQfGZs/VkDYUUd8B7XJ6K/Qid3qXP5Em1C8Fwm9PLaaHPUeAwT2em5BRtcV8s6ry5mbCCCmfqBKtw7e6+G1P6pO2n4zgUqtmoSmxrSYOTm37FYZ6Ovo3lAWM/LKcnTTf1owQcx7w/v2aPqzoSePe3nqQ4Yjs5MjnXmiVytWGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322151; c=relaxed/simple;
	bh=fl7NnVGSSlcrH+GcOWmHYXsxcie4uE+LpNiwHizCaBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMrLRTiAW5+fmupgZ+oa44dEvzZVUqjkGzQPBrUxFz1frGe5c/J6ChYIRUY9/FpaoK7a7CVh6GBKkil7VVIVWLt6ju3DfchHE0DGx/RhzW9YEZ0ZG1QiYvCH1nhyCHvCxiftLwBao5x46p245ggVo1mUcRmlSGOfKIpNh3UANck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIOImOAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E397C433F1;
	Sun, 24 Mar 2024 23:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322150;
	bh=fl7NnVGSSlcrH+GcOWmHYXsxcie4uE+LpNiwHizCaBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIOImOAfMrgc99r8TYQy+VsvHErvxeZnQ1IK4LG3k7dNHp0bapGxan2PBy7ukK6ij
	 qxhP8zaiva9jQK3lbIt1gw8g1teYSgAu6ZGokHyHdtsrbF2zLy3HGPxkED4I4Lfua6
	 uLL2LUzBPSyt7HPereTvWCfMb+xCBtsqHJVuPCHmsUIu9zlDtzShIEBwfVLcG3toSV
	 4Mhtei8L/g2mU/3sRxWenLDTahxvHSdSxtwdPyLJkfNz3r3hQNTAr/ybcbZwT1kWTI
	 bnveHM7wofL8ATrIRaOKMX5aLoLmbRtC2I13YQr7k/3gpwi1hTktOcO+1TT4BaG0kn
	 dOTEiazCunlXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 227/451] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 19:08:23 -0400
Message-ID: <20240324231207.1351418-228-sashal@kernel.org>
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

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 4bb3ba7b74fceec6f558745b25a43c6521cf5506 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 87d759bab0012..7856b7a3e0ee9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2790,11 +2790,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case UDP_CORK:
 		val = udp_test_bit(CORK, sk);
-- 
2.43.0


