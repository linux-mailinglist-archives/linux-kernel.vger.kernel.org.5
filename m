Return-Path: <linux-kernel+bounces-102071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E987AE29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0965A1C22136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29315B979;
	Wed, 13 Mar 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzOlrD1I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5D15B113;
	Wed, 13 Mar 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348452; cv=none; b=DXIU9yyGGCCbRjXrIzrnMC5aAvcRGEGatRnOEoRq8tpsDqxh6jAUwThflmDxXl2ZhjCEYOr5wre2URs2B1zQo1IkDjwMF8MGc/Jb5wA3V4Cjwhc0rKovaJyh6lZ3bsBx9B3/JB2pThkxIZUOl5X3CClBhKlt0ljHq7JLqeZ1P6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348452; c=relaxed/simple;
	bh=lhW0E9o8xdX5sdzcKG/6y7daJkXyEql2FjTYwNEWdO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goFtx8VLh5sTmJEA6aKsLxsueViS9I7iqK6WR66WMmGZEMSM61s1wOsGf3zeSuKrfS9u0yHWuP1Hf/czCBIMX8VuAlNjtfki8+MJpRWLeboXqGpmRGpMiYkvozpmSmn9o2eGhF4km416I2qorh/L7ZbolxG6G0J8GyAjnP+skas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzOlrD1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34B9C43390;
	Wed, 13 Mar 2024 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348451;
	bh=lhW0E9o8xdX5sdzcKG/6y7daJkXyEql2FjTYwNEWdO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzOlrD1IPpvB11k7AVSlyqIIEW+WdyQbWc8uaytuFosSaImNlV996w9KgGEnndNOa
	 skcBNayVsqnbp68yxeOQy915/IopOQF2JkdmB8AFG156+MuPaWLI2ReBWOUAX/oDZx
	 HW2lG0yJDwalgt62HP7hJVKWEs7IIBc+87q900pprW4Ve2vOnpNL6A14d7NHVi2/hp
	 AvGnTxGh8Vqm9y4CCeiwz4C61j01ugFsgxAapai1i2bFM4mPY2uFiGy/G0ff1ou2BU
	 bQDdGHIA6Qjp7TX6yfVHTFWyu5Ta/XCKX4sWVQIWUXS0/UGXYhGDlgxqs8ZfS6rF1L
	 AUxl/tLq2blZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 45/73] bpf: net: Change sk_getsockopt() to take the sockptr_t argument
Date: Wed, 13 Mar 2024 12:46:12 -0400
Message-ID: <20240313164640.616049-46-sashal@kernel.org>
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

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 4ff09db1b79b98b4a2a7511571c640b76cab3beb ]

This patch changes sk_getsockopt() to take the sockptr_t argument
such that it can be used by bpf_getsockopt(SOL_SOCKET) in a
latter patch.

security_socket_getpeersec_stream() is not changed.  It stays
with the __user ptr (optval.user and optlen.user) to avoid changes
to other security hooks.  bpf_getsockopt(SOL_SOCKET) also does not
support SO_PEERSEC.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20220902002802.2888419-1-kafai@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 5a287d3d2b9d ("lsm: fix default return value of the socket_getpeersec_*() hooks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h  |  3 +--
 include/linux/sockptr.h |  5 +++++
 net/core/filter.c       |  5 ++---
 net/core/sock.c         | 43 +++++++++++++++++++++++------------------
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bc6ce4b202a80..cd56e53bd42e2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -892,8 +892,7 @@ int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
 void sk_reuseport_prog_free(struct bpf_prog *prog);
 int sk_detach_filter(struct sock *sk);
-int sk_get_filter(struct sock *sk, struct sock_filter __user *filter,
-		  unsigned int len);
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
 
 bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index ea193414298b7..38862819e77a1 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -64,6 +64,11 @@ static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
 	return 0;
 }
 
+static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t size)
+{
+	return copy_to_sockptr_offset(dst, 0, src, size);
+}
+
 static inline void *memdup_sockptr(sockptr_t src, size_t len)
 {
 	void *p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
diff --git a/net/core/filter.c b/net/core/filter.c
index 6cfc8fb0562a2..49e4d1535cc82 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9903,8 +9903,7 @@ int sk_detach_filter(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_detach_filter);
 
-int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
-		  unsigned int len)
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
 	struct sock_fprog_kern *fprog;
 	struct sk_filter *filter;
@@ -9935,7 +9934,7 @@ int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
 		goto out;
 
 	ret = -EFAULT;
-	if (copy_to_user(ubuf, fprog->filter, bpf_classic_proglen(fprog)))
+	if (copy_to_sockptr(optval, fprog->filter, bpf_classic_proglen(fprog)))
 		goto out;
 
 	/* Instead of bytes, the API requests to return the number
diff --git a/net/core/sock.c b/net/core/sock.c
index 95559d088a169..42da46965b16f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -644,8 +644,8 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 	return ret;
 }
 
-static int sock_getbindtodevice(struct sock *sk, char __user *optval,
-				int __user *optlen, int len)
+static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
+				sockptr_t optlen, int len)
 {
 	int ret = -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -668,12 +668,12 @@ static int sock_getbindtodevice(struct sock *sk, char __user *optval,
 	len = strlen(devname) + 1;
 
 	ret = -EFAULT;
-	if (copy_to_user(optval, devname, len))
+	if (copy_to_sockptr(optval, devname, len))
 		goto out;
 
 zero:
 	ret = -EFAULT;
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		goto out;
 
 	ret = 0;
@@ -1281,20 +1281,23 @@ static void cred_to_ucred(struct pid *pid, const struct cred *cred,
 	}
 }
 
-static int groups_to_user(gid_t __user *dst, const struct group_info *src)
+static int groups_to_user(sockptr_t dst, const struct group_info *src)
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int i;
 
-	for (i = 0; i < src->ngroups; i++)
-		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
+	for (i = 0; i < src->ngroups; i++) {
+		gid_t gid = from_kgid_munged(user_ns, src->gid[i]);
+
+		if (copy_to_sockptr_offset(dst, i * sizeof(gid), &gid, sizeof(gid)))
 			return -EFAULT;
+	}
 
 	return 0;
 }
 
 static int sk_getsockopt(struct sock *sk, int level, int optname,
-			 char __user *optval, int __user *optlen)
+			 sockptr_t optval, sockptr_t optlen)
 {
 	struct socket *sock = sk->sk_socket;
 
@@ -1312,7 +1315,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 	int lv = sizeof(int);
 	int len;
 
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1445,7 +1448,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
-		if (copy_to_user(optval, &peercred, len))
+		if (copy_to_sockptr(optval, &peercred, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1463,11 +1466,11 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		if (len < n * sizeof(gid_t)) {
 			len = n * sizeof(gid_t);
 			put_cred(cred);
-			return put_user(len, optlen) ? -EFAULT : -ERANGE;
+			return copy_to_sockptr(optlen, &len, sizeof(int)) ? -EFAULT : -ERANGE;
 		}
 		len = n * sizeof(gid_t);
 
-		ret = groups_to_user((gid_t __user *)optval, cred->group_info);
+		ret = groups_to_user(optval, cred->group_info);
 		put_cred(cred);
 		if (ret)
 			return ret;
@@ -1483,7 +1486,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_user(optval, address, len))
+		if (copy_to_sockptr(optval, address, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1500,7 +1503,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval, optlen, len);
+		return security_socket_getpeersec_stream(sock, optval.user, optlen.user, len);
 
 	case SO_MARK:
 		v.val = sk->sk_mark;
@@ -1528,7 +1531,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		return sock_getbindtodevice(sk, optval, optlen, len);
 
 	case SO_GET_FILTER:
-		len = sk_get_filter(sk, (struct sock_filter __user *)optval, len);
+		len = sk_get_filter(sk, optval, len);
 		if (len < 0)
 			return len;
 
@@ -1575,7 +1578,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		sk_get_meminfo(sk, meminfo);
 
 		len = min_t(unsigned int, len, sizeof(meminfo));
-		if (copy_to_user(optval, &meminfo, len))
+		if (copy_to_sockptr(optval, &meminfo, len))
 			return -EFAULT;
 
 		goto lenout;
@@ -1625,10 +1628,10 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	if (len > lv)
 		len = lv;
-	if (copy_to_user(optval, &v, len))
+	if (copy_to_sockptr(optval, &v, len))
 		return -EFAULT;
 lenout:
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		return -EFAULT;
 	return 0;
 }
@@ -1636,7 +1639,9 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 int sock_getsockopt(struct socket *sock, int level, int optname,
 		    char __user *optval, int __user *optlen)
 {
-	return sk_getsockopt(sock->sk, level, optname, optval, optlen);
+	return sk_getsockopt(sock->sk, level, optname,
+			     USER_SOCKPTR(optval),
+			     USER_SOCKPTR(optlen));
 }
 
 /*
-- 
2.43.0


