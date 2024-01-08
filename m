Return-Path: <linux-kernel+bounces-20015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95049827840
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF6E1C239A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D225579B;
	Mon,  8 Jan 2024 19:14:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFE5577E;
	Mon,  8 Jan 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso2042582e87.3;
        Mon, 08 Jan 2024 11:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741237; x=1705346037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mr96nxSAtnMpewJ+DXMrz+M3YAm7Ob7BgC6wNF70L3c=;
        b=qtAB/alXUpeZFY4KNtiAq7/jOL3Z/GYvGkUWymTtCmiJef1T+xdaTaU7msHxYMQ3Mb
         wVGQoNc5PoAdPPiWN5boYi3E9Dfq1Cc8S//0ihuGQ6yNzjTTt2qsg10Q5sZf2KU8TO6B
         HQ2Ke/wlOfzhNvhsxA3d+0ZdQd2lZ8kxr9xtBcNsuQ7N2VNxA08S5268rxJ5NHWHxq8l
         e81K/PR44pV6K081RXSu0/yiAwrHLqCSy+MjIK1MVIiEXBKzW18geI9KLLzuPMwXUGG8
         5djMRvrY+mNrrM1Us8NZHnw66wKS+kYSIA7a2Hy2PLg+z3taOirqn8lzff3H7X7Ajei6
         9Uhg==
X-Gm-Message-State: AOJu0YyZD67MakvcOlLb+b5tRsNkCja9b7hUqbF9ZajP9PBUGZM4224+
	udE8WacREraj016iiTTO4UM=
X-Google-Smtp-Source: AGHT+IFDiy+QOQxWuTe0Q+Zc2cXSKhuHy2tgz3hY0eyco1iXKHjvGzZ6t0YVlvIKg/NwcCvxrhQgzA==
X-Received: by 2002:a05:6512:15a1:b0:50e:a15c:6b64 with SMTP id bp33-20020a05651215a100b0050ea15c6b64mr1732321lfb.26.1704741236851;
        Mon, 08 Jan 2024 11:13:56 -0800 (PST)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402180700b0055706e6b1f5sm130501edy.89.2024.01.08.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:13:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: dsahern@kernel.org,
	weiwan@google.com,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net/ipv6: resolve warning in ip6_fib.c
Date: Mon,  8 Jan 2024 11:12:54 -0800
Message-Id: <20240108191254.3422696-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108191254.3422696-1-leitao@debian.org>
References: <20240108191254.3422696-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some configurations, the 'iter' variable in function
fib6_repair_tree() is unused, resulting the following warning when
compiled with W=1.

    net/ipv6/ip6_fib.c:1781:6: warning: variable 'iter' set but not used [-Wunused-but-set-variable]
     1781 |         int iter = 0;
	  |             ^

It is unclear what is the advantage of this RT6_TRACE() macro[1], since
users can control pr_debug() in runtime, which is better than at
compilation time. Moreover, pr_debug() has no overhead when disabled.

Remove the RT6_TRACE() in favor of simple pr_debug() helpers.

[1] Link: https://lore.kernel.org/all/ZZwSEJv2HgI0cD4J@gmail.com/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/ip6_fib.h |  6 ------
 net/ipv6/ip6_fib.c    | 15 +++++++++------
 net/ipv6/route.c      |  8 ++++----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 9ba6413fd2e3..360b12e61850 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -30,12 +30,6 @@
 
 #define RT6_DEBUG 2
 
-#if RT6_DEBUG >= 3
-#define RT6_TRACE(x...) pr_debug(x)
-#else
-#define RT6_TRACE(x...) do { ; } while (0)
-#endif
-
 struct rt6_info;
 struct fib6_info;
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index fb41bec6b4b5..38a0348b1d17 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1801,7 +1801,7 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 					    lockdep_is_held(&table->tb6_lock));
 		struct fib6_info *new_fn_leaf;
 
-		RT6_TRACE("fixing tree: plen=%d iter=%d\n", fn->fn_bit, iter);
+		pr_debug("fixing tree: plen=%d iter=%d\n", fn->fn_bit, iter);
 		iter++;
 
 		WARN_ON(fn->fn_flags & RTN_RTINFO);
@@ -1864,7 +1864,8 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 		FOR_WALKERS(net, w) {
 			if (!child) {
 				if (w->node == fn) {
-					RT6_TRACE("W %p adjusted by delnode 1, s=%d/%d\n", w, w->state, nstate);
+					pr_debug("W %p adjusted by delnode 1, s=%d/%d\n",
+						 w, w->state, nstate);
 					w->node = pn;
 					w->state = nstate;
 				}
@@ -1872,10 +1873,12 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 				if (w->node == fn) {
 					w->node = child;
 					if (children&2) {
-						RT6_TRACE("W %p adjusted by delnode 2, s=%d\n", w, w->state);
+						pr_debug("W %p adjusted by delnode 2, s=%d\n",
+							 w, w->state);
 						w->state = w->state >= FWS_R ? FWS_U : FWS_INIT;
 					} else {
-						RT6_TRACE("W %p adjusted by delnode 2, s=%d\n", w, w->state);
+						pr_debug("W %p adjusted by delnode 2, s=%d\n",
+							 w, w->state);
 						w->state = w->state >= FWS_C ? FWS_U : FWS_INIT;
 					}
 				}
@@ -1951,7 +1954,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 	read_lock(&net->ipv6.fib6_walker_lock);
 	FOR_WALKERS(net, w) {
 		if (w->state == FWS_C && w->leaf == rt) {
-			RT6_TRACE("walker %p adjusted by delroute\n", w);
+			pr_debug("walker %p adjusted by delroute\n", w);
 			w->leaf = rcu_dereference_protected(rt->fib6_next,
 					    lockdep_is_held(&table->tb6_lock));
 			if (!w->leaf)
@@ -2289,7 +2292,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 
 	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
 		if (time_after(now, rt->expires)) {
-			RT6_TRACE("expiring %p\n", rt);
+			pr_debug("expiring %p\n", rt);
 			return -1;
 		}
 		gc_args->more++;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ea1dec8448fc..63b4c6056582 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2085,12 +2085,12 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 	 */
 	if (!(rt->rt6i_flags & RTF_EXPIRES)) {
 		if (time_after_eq(now, rt->dst.lastuse + gc_args->timeout)) {
-			RT6_TRACE("aging clone %p\n", rt);
+			pr_debug("aging clone %p\n", rt);
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
 	} else if (time_after(jiffies, rt->dst.expires)) {
-		RT6_TRACE("purging expired route %p\n", rt);
+		pr_debug("purging expired route %p\n", rt);
 		rt6_remove_exception(bucket, rt6_ex);
 		return;
 	}
@@ -2101,8 +2101,8 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 		neigh = __ipv6_neigh_lookup_noref(rt->dst.dev, &rt->rt6i_gateway);
 
 		if (!(neigh && (neigh->flags & NTF_ROUTER))) {
-			RT6_TRACE("purging route %p via non-router but gateway\n",
-				  rt);
+			pr_debug("purging route %p via non-router but gateway\n",
+				 rt);
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
-- 
2.39.3


