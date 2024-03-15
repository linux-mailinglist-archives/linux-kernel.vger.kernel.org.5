Return-Path: <linux-kernel+bounces-104357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02B87CC90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E07B213EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4737701;
	Fri, 15 Mar 2024 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iz5jHFZq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4C36B15;
	Fri, 15 Mar 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502751; cv=none; b=Qk3BeWUmizX9MdwR3KgBxrJ0gNCSTz2NT6KCxnhqC20DFb/cDOYPDkQIRUh9r+zTNFXhzjWxlJnFVRIxaSPx+DSIFi62V29ORmk3E2COZsKPa1dzzNNQ4tF+Yi6pbZGB5YxYHHvQwd3d92+n2HU6zjKBo6hlLGZjjMlQlYbFtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502751; c=relaxed/simple;
	bh=v58AhsmmQT/EbyS8YFz+dOXWE+1LCHneaLwzLK8avl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3bs5N+earuqQsw3+5hXSH5Nwsss8aCIBxtKHHxqsSZr6Pq6qqaVvKt8IIoc2PGbYx59xETqvGuvt/xUE4lRPbDoMIzX04UMeE/mK5svJn9SowhuvkJLdqcy7lGZ5c9++OA0zhlTszpkgI081tnqaqnkUbREEWYF9ZsZ+AVNFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iz5jHFZq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513da1c1f26so803715e87.3;
        Fri, 15 Mar 2024 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502748; x=1711107548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oep7fiSPFUB4mUGU2hN2D+vBrhzRF1VLsba4TSKYhR0=;
        b=iz5jHFZqVQ7paGV1QpmDKiLWSD0Qr2vOihEIItoQDzGZjUoH7px4N8/n0ZpRmeopFm
         OUfgbXaltNyWUtewR8Ec62PT0OMd7Ef+kZKkX1Db5/ylvhlB4zSjP5lxtDnIwz4kukXc
         i2RcvbrwpzBA2pedj90ZTg03x4Y3WCmB+DtjMbA0+XEeaRIEr/9gYYGBmqiLn7ZTIeSv
         JeTxXCh2fcPgquUBsy/Hu/HLnPR+o0XRY/yC46ALY3N265DGu/vkU1ZC4mmGa9k3nuq+
         MemcWkJ4AXol56UOQ+NNgl8ji0gYS1PdQjUY9Uca+v2RANtu+4/qO0Po1f7zpYEfNW4c
         37ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502748; x=1711107548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oep7fiSPFUB4mUGU2hN2D+vBrhzRF1VLsba4TSKYhR0=;
        b=AuixkN+UFFA71GTOPPqxV/Qs3lLjeLM+Kpg8pi2MkfSesgme4hxogXko9VlY3qkmnx
         lx8AQV0fJWk9wSLRUZFbOnxcOcwipO6eXia332wtUYqFqfksFhodq0SOXfSmZn8ZypbB
         yIXp8IHlZWgz06JOZMZwLAFlc4/79adY/QCfqvYHbxbs8g3GtOZbuxWZNz7BizV+tGbv
         /yNB+JF+iurLCih5hkkXSmOzRCM2hBTUORp5RMMAVOA/wEpfzFFWoOvRx2u2r6c40qv7
         AAW4FiOtpvoayJy2r0dLnXhU2XM8Dj8ZYOFhd1ycIKgnEKn8eLHbJfo/Q5uVOs/obdR5
         TTvg==
X-Forwarded-Encrypted: i=1; AJvYcCUXGOnskgvZP8AkqENjQmuBndmxCaOrtTKBOSgZVOvM3ikpzE83vma+fq9vkbxozkLwAmE+7tvFAzBZTDGWGIOtfqXixd6fd0La7gIWJeHFBkUAvI1WRdWasNEnnofVh11VE1eqwfnzxCPM+ReqjTA463sHoBXoJYWyHvoMdeIXL+l6e+IizBkx0Qs42CzyNFeWunn+6A==
X-Gm-Message-State: AOJu0YxT3NS4yotcAiIbc0w+vYJOG1DPsZwBSRczNsOxvkKx4YytdRBB
	twi2zScNwApSUV/hD/27n0wvUYfWZMGk3sHhi9Mo7Z7dcFwEkV8h98VEJtPLq8uG2g==
X-Google-Smtp-Source: AGHT+IH2SgThAHXr+8wzksbodsMSKaWmVuuNHL/aCI6V/7GnUQ8/ngvOSLVSaHYnNCgiKx6GrAZoQA==
X-Received: by 2002:a2e:a7c4:0:b0:2d4:83f9:2e21 with SMTP id x4-20020a2ea7c4000000b002d483f92e21mr1975031ljp.42.1710502747344;
        Fri, 15 Mar 2024 04:39:07 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:06 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	David Ahern <dsahern@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 08/10] net: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:29 +0100
Message-ID: <20240315113828.258005-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Add sock_ns_capable_any() wrapper similar to existing sock_ns_capable()
one.

Reorder CAP_SYS_ADMIN last.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> (ieee802154 portion)
---
v4:
  - introduce sockopt_ns_capable_any()
v3:
  - rename to capable_any()
  - make use of ns_capable_any
---
 include/net/sock.h       |  1 +
 net/caif/caif_socket.c   |  2 +-
 net/core/sock.c          | 15 +++++++++------
 net/ieee802154/socket.c  |  6 ++----
 net/ipv4/ip_sockglue.c   |  5 +++--
 net/ipv6/ipv6_sockglue.c |  3 +--
 net/unix/af_unix.c       |  2 +-
 7 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b5e00702acc1..2e64a80c8fca 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1736,6 +1736,7 @@ static inline void unlock_sock_fast(struct sock *sk, bool slow)
 void sockopt_lock_sock(struct sock *sk);
 void sockopt_release_sock(struct sock *sk);
 bool sockopt_ns_capable(struct user_namespace *ns, int cap);
+bool sockopt_ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
 bool sockopt_capable(int cap);
 
 /* Used by processes to "lock" a socket state, so that
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 039dfbd367c9..2d811037e378 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -1026,7 +1026,7 @@ static int caif_create(struct net *net, struct socket *sock, int protocol,
 		.usersize = sizeof_field(struct caifsock, conn_req.param)
 	};
 
-	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_NET_ADMIN))
+	if (!capable_any(CAP_NET_ADMIN, CAP_SYS_ADMIN))
 		return -EPERM;
 	/*
 	 * The sock->type specifies the socket type to use.
diff --git a/net/core/sock.c b/net/core/sock.c
index 43bf3818c19e..fa9edcc3e23d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1077,6 +1077,12 @@ bool sockopt_ns_capable(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(sockopt_ns_capable);
 
+bool sockopt_ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	return has_current_bpf_ctx() || ns_capable_any(ns, cap1, cap2);
+}
+EXPORT_SYMBOL(sockopt_ns_capable_any);
+
 bool sockopt_capable(int cap)
 {
 	return has_current_bpf_ctx() || capable(cap);
@@ -1118,8 +1124,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case SO_PRIORITY:
 		if ((val >= 0 && val <= 6) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		    sockopt_ns_capable_any(sock_net(sk)->user_ns, CAP_NET_RAW, CAP_NET_ADMIN)) {
 			sock_set_priority(sk, val);
 			return 0;
 		}
@@ -1422,8 +1427,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_MARK:
-		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (!sockopt_ns_capable_any(sock_net(sk)->user_ns, CAP_NET_RAW, CAP_NET_ADMIN)) {
 			ret = -EPERM;
 			break;
 		}
@@ -2813,8 +2817,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 
 	switch (cmsg->cmsg_type) {
 	case SO_MARK:
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		if (!ns_capable_any(sock_net(sk)->user_ns, CAP_NET_RAW, CAP_NET_ADMIN))
 			return -EPERM;
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 990a83455dcf..42b3b12eb493 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -902,8 +902,7 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
 		ro->want_lqi = !!val;
 		break;
 	case WPAN_SECURITY:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
-		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
+		if (!ns_capable_any(net->user_ns, CAP_NET_ADMIN, CAP_NET_RAW)) {
 			err = -EPERM;
 			break;
 		}
@@ -926,8 +925,7 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
 		}
 		break;
 	case WPAN_SECURITY_LEVEL:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
-		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
+		if (!ns_capable_any(net->user_ns, CAP_NET_ADMIN, CAP_NET_RAW)) {
 			err = -EPERM;
 			break;
 		}
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..5a1e5ee20ddd 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1008,8 +1008,9 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		inet_assign_bit(MC_ALL, sk, val);
 		return 0;
 	case IP_TRANSPARENT:
-		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		if (!!val &&
+		    !sockopt_ns_capable_any(sock_net(sk)->user_ns,
+					    CAP_NET_RAW, CAP_NET_ADMIN))
 			return -EPERM;
 		if (optlen < 1)
 			return -EINVAL;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d4c28ec1bc51..e46b11b5d3dd 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -773,8 +773,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_TRANSPARENT:
-		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		if (valbool && !sockopt_ns_capable_any(net->user_ns, CAP_NET_RAW, CAP_NET_ADMIN)) {
 			retv = -EPERM;
 			break;
 		}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5b41e2321209..acc36b2d25d7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1783,7 +1783,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
 	struct user_struct *user = current_user();
 
 	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
-		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+		return !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
 	return false;
 }
 
-- 
2.43.0


