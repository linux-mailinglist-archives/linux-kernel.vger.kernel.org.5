Return-Path: <linux-kernel+bounces-116048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6A889522
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE6F29644D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A92745E9;
	Mon, 25 Mar 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjh4ds18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FA130A77;
	Sun, 24 Mar 2024 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323443; cv=none; b=pkw/V+APX1csaaQ5AV19/XJm5SAxUA5A/ZuCsVfBrUUAyYxXNhtdISVqUeUEjYIhyO4KxNNtitX3QYoU4XcEAuEtH6gFjMgiiT11D842JFWw0rRI0ftL4uhXp5WLqnVzTXALuWcTXFsQmYwKbTb0fnKdMdP2AWlbVnaMBTg0pvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323443; c=relaxed/simple;
	bh=ZQKYH0zfiHgPG7eaYpqeQo2xkINccJ6hyEvMKz+eHcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npma3Jx8yVS694ANTnv8VGJs+sGws66VAVi2o5GgPQAVghV0I37l5knpd2ENBwPFzOOQerdFfpJP/Oapcm10N3MMEpLLBptCcepwN+ja5Nf6YcmtyeQEV7EiNUqpRm29nOcJybc8u4HTbPUDxw8RmzUzS/qChSXsp2NX4Zn4zbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjh4ds18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D5C433A6;
	Sun, 24 Mar 2024 23:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323441;
	bh=ZQKYH0zfiHgPG7eaYpqeQo2xkINccJ6hyEvMKz+eHcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjh4ds18t4XhbL6NLMy81nJvFcHcwQ9RosU4gp+ygE7sQTI6IJXj8kWU98YaO+Kmg
	 9uqwR432JJQq9nt8cWGf/aPVh6boPeblykQl7kwnSe4s+tFNWRKNGJvaKhGdlna2dM
	 hOLyY+jLLCbDGbeeI29HMyB5Yyu6/Vh4bAIT51H9i+y3kux0+4Gy89I2lAoLkDCQ9M
	 rFd89aEte30fGA45jkQhvpkJdx0aoJUZ5yROfnwhcIhWEk4zJrGs3BmT2kCPbmJXI1
	 60Kf4iL7rNRt7LEfCw/T++o4dYzpQh85dviFhgPOmlC51G5cjEOIwyo+ZAiZLcDUPT
	 6RhDt5TLqcXKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 144/317] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 19:32:04 -0400
Message-ID: <20240324233458.1352854-145-sashal@kernel.org>
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
index 626cef75afe7a..521c15962c719 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3965,11 +3965,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
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


