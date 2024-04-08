Return-Path: <linux-kernel+bounces-134927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B1189B8E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9708283CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED07381DF;
	Mon,  8 Apr 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYuyjl1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FF51C21;
	Mon,  8 Apr 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562146; cv=none; b=FwQg1Bzho2WUlzPOG9RjiDKJjxN43S7YgrX0kZ4FjZpZGFaddwDEjRztFSnuvMl4rb/KDmWHGFVSTPwx2foDIAnIP5Ual6cwMsSPoumxSjnZzKLLD4d1Z+aOUQ+QvDBXOwUmtu//pLgEYuLr7uhSDhhl1eaVizqOsXa1RtjkLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562146; c=relaxed/simple;
	bh=QhZSuSB35MoMs+hEr1m1W8wVl9HJVIJmATUKFn2Whi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzQiHyNmPLKEfBU6V/R/lsEVQTrz6IsjRRealmuNLKLcmOp+TUlLVFG9psfxE+0rI0k6/B2mg0K+LhUDmIGi21TzTqS6XmJic2MOSI8nKk+C/j+OUofjRETBVGi0miMq+d0UmDeSHnjVlmjxwM6S3n6L5JS5ifacWitZ88QxraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYuyjl1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D91C43390;
	Mon,  8 Apr 2024 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562145;
	bh=QhZSuSB35MoMs+hEr1m1W8wVl9HJVIJmATUKFn2Whi4=;
	h=From:To:Cc:Subject:Date:From;
	b=GYuyjl1k7PzxB3Td7c9/D6mqAKqYgV6BQTSNzdVYylrzcV9Khtzn9Iv6koCaYagUP
	 +t+1VgA6y2wKCcbD+op0GdRlHBfVcbKpCzgkPK7ftAdK18rCmUzdVR1uC9tDdTOcJn
	 xu3PrbG1s6hVKwJq6yIwCO9svuq/jfgmkphMYPQEVol3ZFZ2Y6R2JY+m4hpFVl5NOd
	 3EEjhNC5hxivcG3yEasSuaptJFNdM9e9oHCoVWxzeF0eOBnsIBLCiB17AvRe9eDDvQ
	 OFlI7pWLgEQ54bDSj+GjZpNh6OgqshJZ77W6LWpR01xwFYUopNs3GBhake5/wk39J3
	 O8uaoxgGqm0ow==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Breno Leitao <leitao@debian.org>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ville Nuorvala <vnuorval@tcs.hut.fi>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ipv6: fib: hide unused 'pn' variable
Date: Mon,  8 Apr 2024 09:42:02 +0200
Message-Id: <20240408074219.3030256-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_IPV6_SUBTREES is disabled, the only user is hidden, causing
a 'make W=1' warning:

net/ipv6/ip6_fib.c: In function 'fib6_add':
net/ipv6/ip6_fib.c:1388:32: error: variable 'pn' set but not used [-Werror=unused-but-set-variable]

Add another #ifdef around the variable declaration, matching the other
uses in this file.

Fixes: 66729e18df08 ("[IPV6] ROUTE: Make sure we have fn->leaf when adding a node on subtree.")
Link: https://lore.kernel.org/netdev/20240322131746.904943-1-arnd@kernel.org/
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv6/ip6_fib.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index ddd8e3c2df4a..31d77885bcae 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1386,7 +1386,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	     struct nl_info *info, struct netlink_ext_ack *extack)
 {
 	struct fib6_table *table = rt->fib6_table;
-	struct fib6_node *fn, *pn = NULL;
+	struct fib6_node *fn;
+#ifdef CONFIG_IPV6_SUBTREES
+	struct fib6_node *pn = NULL;
+#endif
 	int err = -ENOMEM;
 	int allow_create = 1;
 	int replace_required = 0;
@@ -1410,9 +1413,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		goto out;
 	}
 
+#ifdef CONFIG_IPV6_SUBTREES
 	pn = fn;
 
-#ifdef CONFIG_IPV6_SUBTREES
 	if (rt->fib6_src.plen) {
 		struct fib6_node *sn;
 
-- 
2.39.2


