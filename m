Return-Path: <linux-kernel+bounces-115738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A134889D65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AB429F8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20D366AC2;
	Mon, 25 Mar 2024 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtGCfsp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98C21D158;
	Sun, 24 Mar 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321852; cv=none; b=Kg0pVODsig+jfFB+fEtdFhf5+r6uivZrJfY2NYATNfIExl3JgC5+SbAz2OFb33JJA19fToE/u921/fNvUu8rQGFo4hfvRlTpHKFepR6ti5q2B9KZbHLpjlFljYtpDXu3a/kKOqiQmkFtEczZNJZm1OqQDnkw9rFDPj3/0JaHy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321852; c=relaxed/simple;
	bh=B8oGi9dfAaBRt2j+HYNsW/8VQ3WhUGEvKoxAv6ORkPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ1SXOeroI9AQH7bOrJXEZM3xbhVKXdMYk/V/4wXtWf27C4cmoRulWBPXUwQ/Kef1+JKLp/2hXTV7QlCQFKy/ifJPbKlNsyVG0bDv41bpIaR4p6I7yOASgb3FWXNdZ/dpdoip/Ii3SiDsZL2DTs+e78KcezShIoCx9wVoEdXEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtGCfsp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC22DC433C7;
	Sun, 24 Mar 2024 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321852;
	bh=B8oGi9dfAaBRt2j+HYNsW/8VQ3WhUGEvKoxAv6ORkPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtGCfsp+YQ3dCWqKnprR2QJAmywjLJi6CFi1QSJ2vDz5VZc8rAlIlRBnI31Y7+i31
	 a59piuawT57hDHULfFDmAFHjp5WGPDc5TcyeUkdvQQ53X1jr+b3bRxsqovMbiHWSAC
	 DF4vmhWPWfcs72gpB1aCBgWr8ZZQmLT00ncUA6GGRungg9AycoD54Hanc5nLmelcUM
	 4+I2nQF1ugsm7qcSNFGp/HmpIdDO58I/QS9fgerQUGMcl4DBO3LAaf1KjkajZT18w7
	 H8r34eNk3/IrK3T4nUUe4IDCl6xLZDwJFhyDXa7whZq9j4LqSqMWbEBBV/UxiWSCh9
	 8WqetckqFSnJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 581/638] tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
Date: Sun, 24 Mar 2024 19:00:18 -0400
Message-ID: <20240324230116.1348576-582-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1c4e97dd2d3c9a3e84f7e26346aa39bc426d3249 ]

inet_twsk_purge() uses rcu to find TIME_WAIT and NEW_SYN_RECV
objects to purge.

These objects use SLAB_TYPESAFE_BY_RCU semantic and need special
care. We need to use refcount_inc_not_zero(&sk->sk_refcnt).

Reuse the existing correct logic I wrote for TIME_WAIT,
because both structures have common locations for
sk_state, sk_family, and netns pointer.

If after the refcount_inc_not_zero() the object fields longer match
the keys, use sock_gen_put(sk) to release the refcount.

Then we can call inet_twsk_deschedule_put() for TIME_WAIT,
inet_csk_reqsk_queue_drop_and_put() for NEW_SYN_RECV sockets,
with BH disabled.

Then we need to restart the loop because we had drop rcu_read_lock().

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
Link: https://lore.kernel.org/netdev/CANn89iLvFuuihCtt9PME2uS1WJATnf5fKjDToa1WzVnRzHnPfg@mail.gmail.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240308200122.64357-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_timewait_sock.c | 41 ++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index dd37a5bf68811..757ae3a4e2f1a 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -278,12 +278,12 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 }
 EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 
+/* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
 void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 {
-	struct inet_timewait_sock *tw;
-	struct sock *sk;
 	struct hlist_nulls_node *node;
 	unsigned int slot;
+	struct sock *sk;
 
 	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
 		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
@@ -292,38 +292,35 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 		rcu_read_lock();
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
-			if (sk->sk_state != TCP_TIME_WAIT) {
-				/* A kernel listener socket might not hold refcnt for net,
-				 * so reqsk_timer_handler() could be fired after net is
-				 * freed.  Userspace listener and reqsk never exist here.
-				 */
-				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
-					     hashinfo->pernet)) {
-					struct request_sock *req = inet_reqsk(sk);
-
-					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
-				}
+			int state = inet_sk_state_load(sk);
 
+			if ((1 << state) & ~(TCPF_TIME_WAIT |
+					     TCPF_NEW_SYN_RECV))
 				continue;
-			}
 
-			tw = inet_twsk(sk);
-			if ((tw->tw_family != family) ||
-				refcount_read(&twsk_net(tw)->ns.count))
+			if (sk->sk_family != family ||
+			    refcount_read(&sock_net(sk)->ns.count))
 				continue;
 
-			if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)))
+			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				continue;
 
-			if (unlikely((tw->tw_family != family) ||
-				     refcount_read(&twsk_net(tw)->ns.count))) {
-				inet_twsk_put(tw);
+			if (unlikely(sk->sk_family != family ||
+				     refcount_read(&sock_net(sk)->ns.count))) {
+				sock_gen_put(sk);
 				goto restart;
 			}
 
 			rcu_read_unlock();
 			local_bh_disable();
-			inet_twsk_deschedule_put(tw);
+			if (state == TCP_TIME_WAIT) {
+				inet_twsk_deschedule_put(inet_twsk(sk));
+			} else {
+				struct request_sock *req = inet_reqsk(sk);
+
+				inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
+								  req);
+			}
 			local_bh_enable();
 			goto restart_rcu;
 		}
-- 
2.43.0


