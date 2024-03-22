Return-Path: <linux-kernel+bounces-111457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D131886CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1112A282B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81645BFC;
	Fri, 22 Mar 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8uGsZVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350783F9FD;
	Fri, 22 Mar 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113473; cv=none; b=bE/bzjYSSIsQ8DJQXxJyu5uqxRNkrgj0FBAuNZ80ZI4EXv9YiMIdZLbo21IuUPl6jJh2gVGxFzquaaGXrpPvtWA3hHx20BjgMWoMfTBpO8BniFpmuE9VWMd0M9xkkN5zKh9uHaT/gRCBlXPfZENnHObdNFIm7SHPKJkA/UULsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113473; c=relaxed/simple;
	bh=x8FKlYxdpZPEJEcYc42RZj3Ld0nf+hduPeef1yCM4KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=poUf1C9+/h35gdiY3n3IP4Quq2cAajxrm2E7Xzwmh3iymSOy1q0DsSuM3n2T66vT7yTRT5BKcw73Lcd1R/h9rnGg1niEUBQbKv2AnqoRHfIJFeq4l69buR8Fv3Eitey2WNR65tqY3iWSnfS0/JFLCCv/YiautH7NRMO4aiLKcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8uGsZVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A77C433C7;
	Fri, 22 Mar 2024 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113472;
	bh=x8FKlYxdpZPEJEcYc42RZj3Ld0nf+hduPeef1yCM4KU=;
	h=From:To:Cc:Subject:Date:From;
	b=b8uGsZVGj3oXY28nV8Jb6LRkI5oCnOJNKT/a2CGD2mW3FZ62N9JQD8oiVaiUMA2YP
	 +SyE4ZAeXyrrlfCZ3kgMdi5bVn0aVSsSP4VKKWWhR3DrTZY2djNcfggMQm/akMGW+U
	 k1jMY5/9LDO7nZVHRPmsPw0kTESEWtmXR09B5RRQPQdOaXXpUJHJJqfSVd5Vzr/xJS
	 wqb7KRrQjmqNgASJfEmmf16+96LMkfwpXdLkdVrc2i5Nxy80OwQ/x6cmf0xwt42q8T
	 JqvAFxlSxtOftdpCUh7kSfGRas6EIu4VDO1dfS9EuLSDefTHx6Ob19eoFtO+YB7Psg
	 GzIevVXEdVyrg==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Ville Nuorvala <vnuorval@tcs.hut.fi>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: fib: hide unused 'pn' variable
Date: Fri, 22 Mar 2024 14:14:10 +0100
Message-Id: <20240322131746.904943-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv6/ip6_fib.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 5c558dc1c683..a2888bda3a87 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1385,7 +1385,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
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
@@ -1409,9 +1412,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		goto out;
 	}
 
+#ifdef CONFIG_IPV6_SUBTREES
 	pn = fn;
 
-#ifdef CONFIG_IPV6_SUBTREES
 	if (rt->fib6_src.plen) {
 		struct fib6_node *sn;
 
-- 
2.39.2


