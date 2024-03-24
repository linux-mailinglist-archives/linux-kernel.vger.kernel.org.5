Return-Path: <linux-kernel+bounces-116050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021D889527
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630871C2F32F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5A2275501;
	Mon, 25 Mar 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coy1wYhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC381130A76;
	Sun, 24 Mar 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323444; cv=none; b=KK9445IRQj/3GT1Nnl2gXPGZglTNjiiMdRu9aQU58EOYgB2mvevNZQwfLY49nYUctmzzpShQR0eBVWRYrW867Td1f1KGuzHCE0Xcc0FSWua/FdWNNydxf0f8LLc38xUnX2IDW8Qnic4edY/xPUNlu8WzbeoI1MIp/5sOkLQ25/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323444; c=relaxed/simple;
	bh=OGgpAW3CwXQyDm1f2enAospRQ0zFdOVdHC4x5aOwh7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUTiL6T1CWdEIUKo8IMdvF1E0qweUS2QJXiEmoVFX5YtZaCN8KuhokD5gHKA+7J1vx+F5hxI9sENeq/c2XaVPW0H8lsfITfjVvNDagkX9SZ1bAZNp0q+fszgHUNBHYd8P1dsqvRAYyA1uP/vpJgByvmrwdUZI5vr/ShqJBllTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coy1wYhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E76C433F1;
	Sun, 24 Mar 2024 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323443;
	bh=OGgpAW3CwXQyDm1f2enAospRQ0zFdOVdHC4x5aOwh7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Coy1wYhx0568CCmo74SZtD9G46jvzg8Ohnx9W2xg2bjnNHfbNkJKvhFa6lKo5SHYy
	 UEH8nKxrq1ihqplW/VgAaUfo3FVMVi5osLgdMtglrSTBJ/CZ0zdst/fxtHZ5BvHEZj
	 klfUPCp3sHEYr6qJ3uUYx5LxEbVxTpmIet+fPgDf+mYQcXsJ+MFykKK5wTZyOfs3FQ
	 uSnn4rvWhsD+PD5eLWmnqCQgyrBlVz2tK64umF98DAnHigvrjqkJvNBevSvoDh49lw
	 7Il9Dqaz9bqvluDdisU46NwZvIg0xgh8RlLmn8rKyL9zW5O07b1ExnEnzUvceOUW6u
	 TrDP78rH3aftA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 146/317] bpf: net: Change sk_getsockopt() to take the sockptr_t argument
Date: Sun, 24 Mar 2024 19:32:06 -0400
Message-ID: <20240324233458.1352854-147-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Stable-dep-of: 5c3be3e0eb44 ("ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h  |  3 +--
 include/linux/sockptr.h |  5 +++++
 net/core/filter.c       |  5 ++---
 net/core/sock.c         | 43 +++++++++++++++++++++++------------------
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2b6da8e356aab..ddaeb2afc022f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -943,8 +943,7 @@ int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
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
index f0a3cdc4d4961..457d1a164ad5d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10316,8 +10316,7 @@ int sk_detach_filter(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_detach_filter);
 
-int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
-		  unsigned int len)
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
 	struct sock_fprog_kern *fprog;
 	struct sk_filter *filter;
@@ -10348,7 +10347,7 @@ int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
 		goto out;
 
 	ret = -EFAULT;
-	if (copy_to_user(ubuf, fprog->filter, bpf_classic_proglen(fprog)))
+	if (copy_to_sockptr(optval, fprog->filter, bpf_classic_proglen(fprog)))
 		goto out;
 
 	/* Instead of bytes, the API requests to return the number
diff --git a/net/core/sock.c b/net/core/sock.c
index f8e3ba34e0a34..6f761f3c272aa 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -671,8 +671,8 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 	return ret;
 }
 
-static int sock_getbindtodevice(struct sock *sk, char __user *optval,
-				int __user *optlen, int len)
+static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
+				sockptr_t optlen, int len)
 {
 	int ret = -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -695,12 +695,12 @@ static int sock_getbindtodevice(struct sock *sk, char __user *optval,
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
@@ -1404,20 +1404,23 @@ static void cred_to_ucred(struct pid *pid, const struct cred *cred,
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
 
@@ -1436,7 +1439,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 	int lv = sizeof(int);
 	int len;
 
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1578,7 +1581,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
-		if (copy_to_user(optval, &peercred, len))
+		if (copy_to_sockptr(optval, &peercred, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1596,11 +1599,11 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
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
@@ -1616,7 +1619,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_user(optval, address, len))
+		if (copy_to_sockptr(optval, address, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1633,7 +1636,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval, optlen, len);
+		return security_socket_getpeersec_stream(sock, optval.user, optlen.user, len);
 
 	case SO_MARK:
 		v.val = sk->sk_mark;
@@ -1661,7 +1664,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		return sock_getbindtodevice(sk, optval, optlen, len);
 
 	case SO_GET_FILTER:
-		len = sk_get_filter(sk, (struct sock_filter __user *)optval, len);
+		len = sk_get_filter(sk, optval, len);
 		if (len < 0)
 			return len;
 
@@ -1711,7 +1714,7 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		sk_get_meminfo(sk, meminfo);
 
 		len = min_t(unsigned int, len, sizeof(meminfo));
-		if (copy_to_user(optval, &meminfo, len))
+		if (copy_to_sockptr(optval, &meminfo, len))
 			return -EFAULT;
 
 		goto lenout;
@@ -1772,10 +1775,10 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 
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
@@ -1783,7 +1786,9 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
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


