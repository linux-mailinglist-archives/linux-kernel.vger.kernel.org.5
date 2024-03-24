Return-Path: <linux-kernel+bounces-115096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EC888D16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D021C2A948
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC22F962F;
	Mon, 25 Mar 2024 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvHL5XmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03E181329;
	Sun, 24 Mar 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324078; cv=none; b=JZTMWi0WFhpMFEWxSbicAci8K4mHi2GAhslEvZJXwTs7IzajeUFcPRPDPp2DaiYiBfNZLHFI69317CrQbM8JnbbNhaZBdRZoBie3kkBfUBg4p299rsDrhhGxzLuBtpMz4wthlKw1twSU5XX0k6lMCphNcoDk2t2xqky+kcxke9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324078; c=relaxed/simple;
	bh=4DaxpUzWlRp6+J1iAwHH9aJOrxqrNkhArjxWeuBu49s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiWsPcHBuKjPIhxwjKdwXWAHcx9KJ4j7ZaQfqmbs6KPyUHvi7joxOz5RJt2C1QQFwhZiWm7IYuRnieZakGRykZg/E4yuZOy+w3lq6WYJtERTw8GkR/8Vm5IweHDJKZflXoWlIQtnd0Ga/blataoRJE6FrYnvsd6XVSGgQ3kFUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvHL5XmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BA1C433F1;
	Sun, 24 Mar 2024 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324077;
	bh=4DaxpUzWlRp6+J1iAwHH9aJOrxqrNkhArjxWeuBu49s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvHL5XmMnCuKAEA2sj3NISX+y55TToVoWak5z7DEs/m1eVwl+5tt462xuVH8MpzX5
	 mDPXdOu/9cdh/lXj58dg9QlA8KWLcvXK8ib1JkvNuQvS1bLmYj1qRW6YmJfottBTna
	 28KR30CDOE8Y+iAsCYBkAfEQza7tVLqMfO11MmGDqQgGoY5RrNrukGRbkN6eB7WXuu
	 kM/V51tmdTasz1nbqSOSkJCfwgwjMiRyrefw7HtbkH/3spIMq6b8hUpkeaZZShx09n
	 at8rY6n2QP8903f85ZS263aM+/N1ghgViTwl/w7vnGnlFUEvzrPdd6LgTLbW7ETXic
	 xhL0c4cNs0tPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 077/183] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 19:44:50 -0400
Message-ID: <20240324234638.1355609-78-sashal@kernel.org>
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
index 8d7933989de0e..8ebcff40bc5ac 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3451,11 +3451,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
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


