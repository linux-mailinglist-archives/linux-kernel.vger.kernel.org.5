Return-Path: <linux-kernel+bounces-134929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D927B89B8EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3681F2245B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B973C472;
	Mon,  8 Apr 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md8j7xyW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86051C27;
	Mon,  8 Apr 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562158; cv=none; b=b2B3UI8OrF1wynkmhGdEY608Ru2OVa4Z2JOt/oSNtRf2NA/vggW/Z37ZmOVJ7N2ZHD/yvgSIl/JJh3/57/TjYpd/Mr6rJVRql6yUAyiyluGSu8lIxp1enN2MOXXy4K2kG+4X7fvqtSQIp+5bBPVwhsRDfo9dKhh7j6Dq6hSkWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562158; c=relaxed/simple;
	bh=4XNXbnlu3pgIJgvcSWwVY2J6RQPD+Ti9vjQzVOe3IrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ex36PuidR7EOZN9jIyBZNaktrjp+38A96ikgE4gM0p8vllt54l45ucGgSDQZlwc0/iOMwHk6eurItbQ1nC3/pLpdP36F1JOOUISogYJ5OhyMpuJzYP4TmBxpnIFvNDOHWj1mVuN3DY3iNz9klEb7i07tfFMPSC1wmo8Xd75+soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md8j7xyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9FFC433F1;
	Mon,  8 Apr 2024 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562157;
	bh=4XNXbnlu3pgIJgvcSWwVY2J6RQPD+Ti9vjQzVOe3IrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Md8j7xyWDu2hiTGHgbgtFP8KZVoqBd3qX1u+RpjLbRY3uIKI5xKChshv/k8Cu7/pP
	 R+1jwa7b/MyGLWhz/hl9+WInFEWDboqAZkerJ6pn9B67b4Tjm0c7I6UGVcvpXPZFJm
	 hEBjYoBIhYD4yS+RAuzPNgYqvM87jk+FFGoTV7NhKWh+ZGdICUsNSFdc4L5rnwOaHj
	 JBJQVPJxNfTZKmrsc7ROcpeM3ZS68YgBYGTL6WmkKprFcGtzEJuzDj+/1nYwK8pc4k
	 jZxWkQfdiXJBh0DdntAtrZGmpF7uq5Hjn5Pn25CYvY81dHpZ4lgQ2SeMhq3zXhsKuX
	 EsT+XBTKebS+A==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kunwu Chan <chentao@kylinos.cn>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
	Maxime Bizon <mbizon@freebox.fr>,
	Joel Granados <joel.granados@gmail.com>,
	Kyle Zeng <zengyhkyle@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ipv4/route: avoid unused-but-set-variable warning
Date: Mon,  8 Apr 2024 09:42:03 +0200
Message-Id: <20240408074219.3030256-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408074219.3030256-1-arnd@kernel.org>
References: <20240408074219.3030256-1-arnd@kernel.org>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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


