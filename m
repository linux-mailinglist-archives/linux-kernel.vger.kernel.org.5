Return-Path: <linux-kernel+bounces-60405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DA850473
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6961F227C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE04C610;
	Sat, 10 Feb 2024 12:56:44 +0000 (UTC)
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F03D554;
	Sat, 10 Feb 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569804; cv=none; b=tnwcoi/fGiJ6+t5nI5qQ4UOzLoG/RCrflB+nWcwrI7ajVAd9S9e0lA1kXYkj5Uzsv6oiGEIycxCwkMtT+xhgrXM7RBUJf9Kzx21BQqtrO30Ohn2qSLFBkwycUA9T9A8Nekm0H4RSGggHeXjxxIpEBNPkEcs2rbNCkAZAW4Hodww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569804; c=relaxed/simple;
	bh=tP5NgIL70LcknVWnXEpL1M5b/5gVZ6befjCl0rPG4bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uwo3zMMhRsRZrATpo+cXEIVU836CY2XDWtbA97pB8exmy0XRS2YSy5C1xYzU2b4JsiigL9C7C5uZXJ3LmWK35fRlbulyDPgKw/WsafLHI6zPiTMu1zSiEI7bLKQfHXNWQi7ZXQ5tshpm681tH86swORKirQEaHxVY6rxoeWholg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from basile.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id 48C07C01A3;
	Sat, 10 Feb 2024 14:50:54 +0200 (EET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] phonet: take correct lock to peek at the RX queue
Date: Sat, 10 Feb 2024 14:50:53 +0200
Message-ID: <20240210125054.71391-1-remi@remlab.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rémi Denis-Courmont <courmisch@gmail.com>

Reported-by: Luosili <rootlab@huawei.com>
Signed-off-by: Rémi Denis-Courmont <courmisch@gmail.com>
---
 net/phonet/datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/phonet/datagram.c b/net/phonet/datagram.c
index 3aa50dc7535b..976fe250b509 100644
--- a/net/phonet/datagram.c
+++ b/net/phonet/datagram.c
@@ -34,10 +34,10 @@ static int pn_ioctl(struct sock *sk, int cmd, int *karg)
 
 	switch (cmd) {
 	case SIOCINQ:
-		lock_sock(sk);
+		spin_lock_bh(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
 		*karg = skb ? skb->len : 0;
-		release_sock(sk);
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
 		return 0;
 
 	case SIOCPNADDRESOURCE:
-- 
2.43.0


