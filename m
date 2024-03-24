Return-Path: <linux-kernel+bounces-114252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F2888964
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B421F2995D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744E16B422;
	Sun, 24 Mar 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSImc9bu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA520AF79;
	Sun, 24 Mar 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321605; cv=none; b=FoxujyvOw8O4yva3Og0m4k71A1M0rnroXUiGGUM4emvgGx4pAbSuBWtZjw95X2VDeSEHZKw/v9aLz7R6zERZLOYCh6szVq7CbXGrRxl1Jmsyo5Ho16VgAX4dgcObcd53KKLba4OcZ1KijKnNEVkKrxyMUGH0KyraeplCPyPqjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321605; c=relaxed/simple;
	bh=3vTtX28rucjbfTd5sWuYFGppLriKKnpXEJG32VvP/6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seFYPVlnbTNIxzL+ZOoOnh8TkSf70gLkTWRwhN7QPKeqhdOGMtojzZGq1cc0wEKIWmyknyzE4V46/vq2mbcMJ9Sfq6DK8e2NxzrihUmAPMy1Shm8nP9Lmvoic3MLMRb9JdoNUPKx8mfQi3QRGeh88G8InQ9pdxoXFwwgRdqAuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSImc9bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14410C433C7;
	Sun, 24 Mar 2024 23:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321603;
	bh=3vTtX28rucjbfTd5sWuYFGppLriKKnpXEJG32VvP/6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSImc9buI2NRaYeoislxOE2xy52FNAqh710IW7Y0MM6rFzZoJstjiA44tYLP9EsHv
	 m4GK7qOpJz6NmHr/EkbPhAuyrRAX0hkE7WrwWaA/ODH3PDUNPvt14JsB7X17QaDk/e
	 x0UkDbXueq04eUNuPGFeCzWo1kjBHfsA64HtTn/EEm+/JHNbCzpOKI11Ti9OBCbNN9
	 BohCYTBPjpTcPI/rN41P2DCtKsRyDdE92xn1VjLjGsbovZmDxk1yeMR3HFkyuYOH14
	 95uahTnFsyygOSUFndR/ZhltRAcqmM/3RnzQNVl59KjEXijCeE7NlTmJJuhbbzgmKh
	 YosPtXl6NvG/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 333/638] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
Date: Sun, 24 Mar 2024 18:56:10 -0400
Message-ID: <20240324230116.1348576-334-sashal@kernel.org>
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
index ab1308affa08a..68bb8d6bcc113 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3967,11 +3967,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
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


