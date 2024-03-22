Return-Path: <linux-kernel+bounces-111459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F393886CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF6A286A06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB6245BFD;
	Fri, 22 Mar 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNjPHxbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC23B2AD;
	Fri, 22 Mar 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113504; cv=none; b=rgY3e5DSjod76lJRX3kayx9W1gAcg26Z28aDviahinbzGRx4krXnZ6YWsZi8gebhVcyGZSpx/JDp9njloM6DujD+pUGQTSY42BK/b2bSCnXC/flQjYlsoMS/Hi5PDA8VQIWvkeOMxOSqV5Asklv1ffk8uB5h1d5/LVQx3O49Xxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113504; c=relaxed/simple;
	bh=QkxlbL9Dz3q0VP2PaBOmanPcZ3wN5llL2k7kbQgmFS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kL6EI4OwF+xirxKhcxuCxFAXAaS5fMfe/Go452H9/qgHWNaFM5UdgakzOen1yuCU17WRFs9sMf7UXitx6A2ZabJAh4MN15wLV4ZAcmH4tSgpn8Z+Drv4vXio5PdZrzXjAFw7Q13mNKPpdriPeD1JDLQOddTXsBgRJBN1MFrl4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNjPHxbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDAEC433C7;
	Fri, 22 Mar 2024 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113503;
	bh=QkxlbL9Dz3q0VP2PaBOmanPcZ3wN5llL2k7kbQgmFS4=;
	h=From:To:Cc:Subject:Date:From;
	b=qNjPHxbBHGaPbBGHkNFLf5H/PUZMJpbo6UtkZvj0XJQu5FlNb281smi/D1927oI4l
	 mlktAC1BrW53lQl5cs5ENEotjKZQ+k1kB5LfBpOD1l8daFVEobHTbKvSeLa+N9C/6/
	 UsYGM+dDI9w0DUJaAdQO1Fgx4/pEoT+7hjyRc/Rk6tB8hljQwQhaspdO1JKKDJTSVi
	 lM1isxgLX/LsHWRwHGuwppXZwLvKwYwdOasHfFbucv8HLU2GvDxOkRtDlMOSAEWJGE
	 I0tGjNKYKZ3QibhF4o3BmHRh4p5uif229XV1HDinXxdeHutrprblfgFD7AB243BHe9
	 5gvzcw9tlV+uA==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kunwu Chan <chentao@kylinos.cn>,
	Joel Granados <joel.granados@gmail.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	Kyle Zeng <zengyhkyle@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv4/route: avoid unused-but-set-variable warning
Date: Fri, 22 Mar 2024 14:18:12 +0100
Message-Id: <20240322131817.905700-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The log_martians variable is only used in an #ifdef, causing a 'make W=1'
warning with gcc:

net/ipv4/route.c: In function 'ip_rt_send_redirect':
net/ipv4/route.c:880:13: error: variable 'log_martians' set but not used [-Werror=unused-but-set-variable]

Change the #ifdef to an equivalent IS_ENABLED() to let the compiler
see where the variable is used.

Fixes: 30038fc61adf ("net: ip_rt_send_redirect() optimization")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv4/route.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c8f76f56dc16..d36ace160d42 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -926,13 +926,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);
 		peer->rate_last = jiffies;
 		++peer->n_redirects;
-#ifdef CONFIG_IP_ROUTE_VERBOSE
-		if (log_martians &&
+		if (IS_ENABLED(CONFIG_IP_ROUTE_VERBOSE) && log_martians &&
 		    peer->n_redirects == ip_rt_redirect_number)
 			net_warn_ratelimited("host %pI4/if%d ignores redirects for %pI4 to %pI4\n",
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);
-#endif
 	}
 out_put_peer:
 	inet_putpeer(peer);
-- 
2.39.2


