Return-Path: <linux-kernel+bounces-41346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CFC83EF29
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF23C1F21947
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6062D05C;
	Sat, 27 Jan 2024 17:50:49 +0000 (UTC)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96022D043;
	Sat, 27 Jan 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377849; cv=none; b=s/MPSi6aW+rvhgXhkXKvVehSAF1Yxe5ZNJYkRKIV2A5K2PguzmRMhl5fNwyAy2VMDBrbooGnJlbO7y4y0wl30muxLnRM3jKpWCp1HPAQT/0JclBb5T+W/3G9CySjR3hDKi8j335OLY8Hr9Gl9Gl+JE8HI5ZyFxABox097QiB2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377849; c=relaxed/simple;
	bh=gH9nNY+9TpVvPc6avD4dvJHTd9c7E4jxuwHISjX5lNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMe+sLnKJm17KWGxwybWlXkoQiINNP1OT2AbBt+pu+90ec4Cl0I9nv26m05tPOHK5cVq8wk6dCqsE87dlIypN9pCPYSjYsihSCgoVFwUwRelG+6HCk/cyVrD5cP90WOSGBkowo+H3tsND3t5juxqrOnnaiRRrWET+vxvmL6R3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F18A40D6C;
	Sat, 27 Jan 2024 18:50:35 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net v2] bridge: mcast: fix disabled snooping after long uptime
Date: Sat, 27 Jan 2024 18:50:32 +0100
Message-ID: <20240127175033.9640-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The original idea of the delay_time check was to not apply multicast
snooping too early when an MLD querier appears. And to instead wait at
least for MLD reports to arrive before switching from flooding to group
based, MLD snooped forwarding, to avoid temporary packet loss.

However in a batman-adv mesh network it was noticed that after 248 days of
uptime 32bit MIPS based devices would start to signal that they had
stopped applying multicast snooping due to missing queriers - even though
they were the elected querier and still sending MLD queries themselves.

While time_is_before_jiffies() generally is safe against jiffies
wrap-arounds, like the code comments in jiffies.h explain, it won't
be able to track a difference larger than ULONG_MAX/2. With a 32bit
large jiffies and one jiffies tick every 10ms (CONFIG_HZ=100) on these MIPS
devices running OpenWrt this would result in a difference larger than
ULONG_MAX/2 after 248 (= 2^32/100/60/60/24/2) days and
time_is_before_jiffies() would then start to return false instead of
true. Leading to multicast snooping not being applied to multicast
packets anymore.

Fix this issue by using a proper timer_list object which won't have this
ULONG_MAX/2 difference limitation.

Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog v2:
* removed "inline" from br_multicast_query_delay_expired()

 net/bridge/br_multicast.c | 20 +++++++++++++++-----
 net/bridge/br_private.h   |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d7d021af1029..2d7b73242958 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1762,6 +1762,10 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
+static void br_multicast_query_delay_expired(struct timer_list *t)
+{
+}
+
 static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 					    struct br_ip *ip,
 					    struct sk_buff *skb)
@@ -3198,7 +3202,7 @@ br_multicast_update_query_timer(struct net_bridge_mcast *brmctx,
 				unsigned long max_delay)
 {
 	if (!timer_pending(&query->timer))
-		query->delay_time = jiffies + max_delay;
+		mod_timer(&query->delay_timer, jiffies + max_delay);
 
 	mod_timer(&query->timer, jiffies + brmctx->multicast_querier_interval);
 }
@@ -4041,13 +4045,11 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_querier_interval = 255 * HZ;
 	brmctx->multicast_membership_interval = 260 * HZ;
 
-	brmctx->ip4_other_query.delay_time = 0;
 	brmctx->ip4_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
-	brmctx->ip6_other_query.delay_time = 0;
 	brmctx->ip6_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
@@ -4056,6 +4058,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.timer,
 		    br_ip4_multicast_querier_expired, 0);
+	timer_setup(&brmctx->ip4_other_query.delay_timer,
+		    br_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip4_own_query.timer,
 		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4063,6 +4067,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 		    br_ip6_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip6_other_query.timer,
 		    br_ip6_multicast_querier_expired, 0);
+	timer_setup(&brmctx->ip6_other_query.delay_timer,
+		    br_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip6_own_query.timer,
 		    br_ip6_multicast_query_expired, 0);
 #endif
@@ -4197,10 +4203,12 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 {
 	del_timer_sync(&brmctx->ip4_mc_router_timer);
 	del_timer_sync(&brmctx->ip4_other_query.timer);
+	del_timer_sync(&brmctx->ip4_other_query.delay_timer);
 	del_timer_sync(&brmctx->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
 	del_timer_sync(&brmctx->ip6_mc_router_timer);
 	del_timer_sync(&brmctx->ip6_other_query.timer);
+	del_timer_sync(&brmctx->ip6_other_query.delay_timer);
 	del_timer_sync(&brmctx->ip6_own_query.timer);
 #endif
 }
@@ -4643,13 +4651,15 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 	max_delay = brmctx->multicast_query_response_interval;
 
 	if (!timer_pending(&brmctx->ip4_other_query.timer))
-		brmctx->ip4_other_query.delay_time = jiffies + max_delay;
+		mod_timer(&brmctx->ip4_other_query.delay_timer,
+			  jiffies + max_delay);
 
 	br_multicast_start_querier(brmctx, &brmctx->ip4_own_query);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (!timer_pending(&brmctx->ip6_other_query.timer))
-		brmctx->ip6_other_query.delay_time = jiffies + max_delay;
+		mod_timer(&brmctx->ip6_other_query.delay_timer,
+			  jiffies + max_delay);
 
 	br_multicast_start_querier(brmctx, &brmctx->ip6_own_query);
 #endif
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b0a92c344722..86ea5e6689b5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -78,7 +78,7 @@ struct bridge_mcast_own_query {
 /* other querier */
 struct bridge_mcast_other_query {
 	struct timer_list		timer;
-	unsigned long			delay_time;
+	struct timer_list		delay_timer;
 };
 
 /* selected querier */
@@ -1159,7 +1159,7 @@ __br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
 		own_querier_enabled = false;
 	}
 
-	return time_is_before_jiffies(querier->delay_time) &&
+	return !timer_pending(&querier->delay_timer) &&
 	       (own_querier_enabled || timer_pending(&querier->timer));
 }
 
-- 
2.43.0


