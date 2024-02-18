Return-Path: <linux-kernel+bounces-70284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10460859593
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9461BB213D0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7764FFBEA;
	Sun, 18 Feb 2024 08:18:42 +0000 (UTC)
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8AF4F1;
	Sun, 18 Feb 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244322; cv=none; b=sd5hujVQzNKRCWiWRqMt9haoRpjOEcMfG8/ZcPWOUsbMfMrXteOqshWCKfWHmugmnwFwQHMTvXzGv2TOaTV6aw/t4HkJLV8j3wbpvFEBlwt6gX8HvIWfi3WJeJq3v5siXdKB+BZbRY4r/AR8YtOosrSDNe/WMV6QQv3Li6etZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244322; c=relaxed/simple;
	bh=2BxMlDkylEFurkwztrKxyMnalnAGW1HP3gxdQbPTudc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lnm9Pk1NDVfsQmO2D1VjJQlD5/kJ0GlGIxx+9uhSXYjQG9TJ58xQMQDRKDUa1sDPborYyv/v9dQv9rolDQrvXdvt6dOQjY5g8YKrtlJASJa+krL25iqvTXdciOBD2UqZ9Ug/cAOaGcCqsboen732AExe3MuuVZdgR19wBafJgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from basile.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id AF07CC006F;
	Sun, 18 Feb 2024 10:12:14 +0200 (EET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/2] phonet: take correct lock to peek at the RX queue
Date: Sun, 18 Feb 2024 10:12:13 +0200
Message-ID: <20240218081214.4806-1-remi@remlab.net>
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

The receive queue is protected by its embedded spin-lock, not the
socket lock, so we need the former lock here (and only that one).

Fixes: 107d0d9b8d9a ("Phonet: Phonet datagram transport protocol")
Reported-by: Luosili <rootlab@huawei.com>
Signed-off-by: Rémi Denis-Courmont <courmisch@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


