Return-Path: <linux-kernel+bounces-102073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47387AE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4F283037
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5B15B99A;
	Wed, 13 Mar 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfoxGFMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32515B985;
	Wed, 13 Mar 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348454; cv=none; b=Ubx6arMBHE89zELhhvGEWTtQcueDwmMaluLeLcTAYOBzwy7QrVfmsXV71+8z1wu6tclnnYPM7V2AvmeHaDvOld2dM1CWovm4+oTHDPNcsfX58uvMHC/8IytE2Au48GpBjgT7Ebe+HVle6ZUsgOrLQcVrm3Kp0tIQygYUbzRtGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348454; c=relaxed/simple;
	bh=36tOWfFuzG3HhdjxZYdrj+qn15FcF4TnU7zWvxXyEQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNnhGQPypS+qatoHZVQgB/LohuZTRqXaTo3yLKdPEl9MehVA2ZIOyfzORMRGJ4NTAGWI/8iRmBmngRBnOkLT1i4kqjTXiwJb4W5zXIRcnHLh/xqq1uvrJ2l3DjxtfysRRX8evxHy+wo8I59ZToREIJwvEKBYGCQXeJyqUdS26wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfoxGFMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BEBC43399;
	Wed, 13 Mar 2024 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348453;
	bh=36tOWfFuzG3HhdjxZYdrj+qn15FcF4TnU7zWvxXyEQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfoxGFMT3msQRmbeyptykW34vb2JaN5ZgslhKv/e8NvpZwaI21PX7LO9cNPwDC2ag
	 ctQyeevzlxCeEjUhay21dVJ5csbBGFtxTjhcML3gtFrszYDt5UFA4ifIE7EDOyMHry
	 YSSFZtVV0mn+F6qbFwBC/fbdBbg+IYFAl6NLrQhq79+bTTg7ZAXZteL04lb1wtdRZU
	 qKVvwpz3hpLxR6IyQWHDBUyLputE7I0Oh4TFa5QIDNJ4YsT9gIkThWQSstC6EWAKBx
	 Mk2AV4xPjjA5cDR0hq5Y3MvWY/1cLxOBy1JNkKVN12MhKVUnqyKvNJQ9m/gZbGSYd0
	 +OP5Q3AIak0jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 47/73] lsm: fix default return value of the socket_getpeersec_*() hooks
Date: Wed, 13 Mar 2024 12:46:14 -0400
Message-ID: <20240313164640.616049-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 5a287d3d2b9de2b3e747132c615599907ba5c3c1 ]

For these hooks the true "neutral" value is -EOPNOTSUPP, which is
currently what is returned when no LSM provides this hook and what LSMs
return when there is no security context set on the socket. Correct the
value in <linux/lsm_hooks.h> and adjust the dispatch functions in
security/security.c to avoid issues when the BPF LSM is enabled.

Cc: stable@vger.kernel.org
Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
[PM: subject line tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/lsm_hook_defs.h |  4 ++--
 security/security.c           | 31 +++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9f550eab8ebdb..07abcd384975b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -293,9 +293,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
 	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
diff --git a/security/security.c b/security/security.c
index e9dcde3c4f14b..0bbcb100ba8e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2227,14 +2227,37 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-			     optval, optlen, len);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+						       len);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_stream);
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.43.0


