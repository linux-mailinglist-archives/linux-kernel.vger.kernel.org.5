Return-Path: <linux-kernel+bounces-144993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC028A4DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10081C22387
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D5679E5;
	Mon, 15 Apr 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKrh9CiP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC15FDA5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180906; cv=none; b=N7xNBjvdGSDeycey987m7k2qtCferfyHSV40YayclISE7pObDRiBHAUwEQpGYOhpA+8Y/4/ZaP8QKa5MRQg+8f8fu5Ey1FBmPj32u4b1sp7gjmKYm6LqQh5n9n1euakgjWiky4MHBADFXGRP1L0p0mXG1ySow0V7ogDpbE19IWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180906; c=relaxed/simple;
	bh=tYQjaVztYSLksCUGTNtr0f1PS0mrayvCCU6iPNxYEsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X52T2+3GM/exzUgRMJjh7CMtuXfc2Ds0rfCj62vc5N3oKUAnmb8BuJ0+kjFccsn6pQfK/Fn/broKv9nmAZdp6r+s5uI8XK6Z1ic7/JBGe9xq0dLWt4J1ZZ+nr0JDDaHCnfBLdXCQW4ll9KhYTF1V9GFp3RqmArEfqw6zAUlFy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKrh9CiP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713180903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7f1OoUgw4H495Xl3fEpds6BjBxuOUZU0DulXURwGAsY=;
	b=AKrh9CiPbGw7+tX5b9yoKc9h3xzbRpLy8HcYyAdBzGzrk8oMRQDg7WOPXjp8oFDfxzcuIB
	mB/qR4C24Bw0qMMpGP1fGRFi1X8Vtl5KwO9NpED+EwshqpJ2HdWpcPPQDwan5xWNUR9gxH
	V5Td/UjOwXHuNXwU4AVqyW7DLiR1vGQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636--qhKjR8DOYursTvlK__Fjg-1; Mon, 15 Apr 2024 07:34:59 -0400
X-MC-Unique: -qhKjR8DOYursTvlK__Fjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 301CD1049BC9;
	Mon, 15 Apr 2024 11:34:59 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D6D991C06889;
	Mon, 15 Apr 2024 11:34:56 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: dccp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	mleitner@redhat.com,
	David Ahern <dsahern@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 1/2] SQUASH: tcp/dcpp: Convert timewait timer into a delayed_work
Date: Mon, 15 Apr 2024 13:34:35 +0200
Message-ID: <20240415113436.3261042-2-vschneid@redhat.com>
In-Reply-To: <20240415113436.3261042-1-vschneid@redhat.com>
References: <20240415113436.3261042-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

!NOTE! this changes behaviour, as the tw_timer is TIMER_PINNED and delayed
works currently cannot behave as such. TIMER_PINNED timers are enqueued
onto the local base, whereas delayed_works have their timer enqueued on the
global base AND also check for HK_TYPE_TIMER isolation.

The split between this commit and the next is mainly there for ease of
reviewing. This commit should be squashed with the next one.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/net/inet_timewait_sock.h                 |  2 +-
 net/ipv4/inet_diag.c                             |  2 +-
 net/ipv4/inet_timewait_sock.c                    | 16 +++++++++-------
 net/ipv4/tcp_ipv4.c                              |  2 +-
 net/ipv6/tcp_ipv6.c                              |  2 +-
 .../testing/selftests/bpf/progs/bpf_iter_tcp4.c  |  2 +-
 .../testing/selftests/bpf/progs/bpf_iter_tcp6.c  |  2 +-
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index f28da08a37b4e..c4d64f1f8d415 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -72,7 +72,7 @@ struct inet_timewait_sock {
 				tw_tos		: 8;
 	u32			tw_txhash;
 	u32			tw_priority;
-	struct timer_list	tw_timer;
+	struct delayed_work     tw_expiry_work;
 	struct inet_bind_bucket	*tw_tb;
 	struct inet_bind2_bucket	*tw_tb2;
 };
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 7adace541fe29..ab11b688f1eeb 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -444,7 +444,7 @@ static int inet_twsk_diag_fill(struct sock *sk,
 
 	r->idiag_state	      = tw->tw_substate;
 	r->idiag_timer	      = 3;
-	tmo = tw->tw_timer.expires - jiffies;
+	tmo = tw->tw_expiry_work.timer.expires - jiffies;
 	r->idiag_expires      = jiffies_delta_to_msecs(tmo);
 	r->idiag_rqueue	      = 0;
 	r->idiag_wqueue	      = 0;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e8de45d34d56a..7a2dcbaa1a61e 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -150,11 +150,13 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
 
-static void tw_timer_handler(struct timer_list *t)
+static void tw_expiry_workfn(struct work_struct *work)
 {
-	struct inet_timewait_sock *tw = from_timer(tw, t, tw_timer);
-
+	struct inet_timewait_sock *tw = container_of(
+		work, struct inet_timewait_sock, tw_expiry_work.work);
+	local_bh_disable();
 	inet_twsk_kill(tw);
+	local_bh_enable();
 }
 
 struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
@@ -192,7 +194,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		INIT_DELAYED_WORK(&tw->tw_expiry_work, tw_expiry_workfn);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
@@ -217,7 +219,7 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (del_timer_sync(&tw->tw_timer))
+	if (cancel_delayed_work_sync(&tw->tw_expiry_work))
 		inet_twsk_kill(tw);
 	inet_twsk_put(tw);
 }
@@ -255,10 +257,10 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 
 		__NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILLED :
 						     LINUX_MIB_TIMEWAITED);
-		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
+		BUG_ON(!queue_delayed_work(system_unbound_wq, &tw->tw_expiry_work, timeo));
 		refcount_inc(&tw->tw_dr->tw_refcount);
 	} else {
-		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
+		mod_delayed_work(system_unbound_wq, &tw->tw_expiry_work, timeo);
 	}
 }
 EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a22ee58387518..4b106f017a81f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2920,7 +2920,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 static void get_timewait4_sock(const struct inet_timewait_sock *tw,
 			       struct seq_file *f, int i)
 {
-	long delta = tw->tw_timer.expires - jiffies;
+	long delta = tw->tw_expiry_work.timer.expires - jiffies;
 	__be32 dest, src;
 	__u16 destp, srcp;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee6..58cd12fdc91a5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2242,7 +2242,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 static void get_timewait6_sock(struct seq_file *seq,
 			       struct inet_timewait_sock *tw, int i)
 {
-	long delta = tw->tw_timer.expires - jiffies;
+	long delta = tw->tw_expiry_work.timer.expires - jiffies;
 	const struct in6_addr *dest, *src;
 	__u16 destp, srcp;
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 92267abb462fc..a429f4eb9939c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -152,7 +152,7 @@ static int dump_tw_sock(struct seq_file *seq, struct tcp_timewait_sock *ttw,
 	__be32 dest, src;
 	long delta;
 
-	delta = tw->tw_timer.expires - bpf_jiffies64();
+	delta = tw->tw_expiry_work.timer.expires - bpf_jiffies64();
 	dest = tw->tw_daddr;
 	src  = tw->tw_rcv_saddr;
 	destp = bpf_ntohs(tw->tw_dport);
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 943f7bba180e7..795bb34c95f72 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -157,7 +157,7 @@ static int dump_tw_sock(struct seq_file *seq, struct tcp_timewait_sock *ttw,
 	__u16 destp, srcp;
 	long delta;
 
-	delta = tw->tw_timer.expires - bpf_jiffies64();
+	delta = tw->tw_expiry_work.timer.expires - bpf_jiffies64();
 	dest = &tw->tw_v6_daddr;
 	src  = &tw->tw_v6_rcv_saddr;
 	destp = bpf_ntohs(tw->tw_dport);
-- 
2.43.0


