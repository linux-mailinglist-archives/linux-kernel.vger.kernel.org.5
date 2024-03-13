Return-Path: <linux-kernel+bounces-102072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970187AE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D1E1F2D2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312E815AAD9;
	Wed, 13 Mar 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIQh/mQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FD15B96C;
	Wed, 13 Mar 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348453; cv=none; b=EE7oe0KwQ7yj+zUB3rw6vSAQAMqIiqrk+ji//7xvDLAIAAjqQGGhKryFg1VKJ+2KBjO963GIrbNhsIyUK9XNEHQDGiDolmsx33pFs/gFyjpIJgo4LLuA7NEb5BJijB8bZ93ZfaH2laxYRufPW+W9R4DgEpTchJKZyZZMNBa51hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348453; c=relaxed/simple;
	bh=QjxLFRsGdo57Hkre15eaMsp+MhCn58/hHstYIjAHJCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq8+dG6emYctGHsfVwumTjGf/x/mP3TycuCvaGSIJyVGALMgqSgEtvt+XRE0+NKWPWHPeIsaIbkty5MEc/SoFziJjhVOY03DJGDA6FNJfauMuk3X5BWMDL45eIX0hmqnAm20rr4nhwJ+/LfYJZSrhG/yFNJ5Fi+dthcgiMJWS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIQh/mQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16123C433F1;
	Wed, 13 Mar 2024 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348452;
	bh=QjxLFRsGdo57Hkre15eaMsp+MhCn58/hHstYIjAHJCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIQh/mQ3ZIaJtFH65nPq21mUgS5DqSXG1+utIUtr6dWhRszDiPajDaE6Zzrl7Vgow
	 0gKXtGrJbkZc9j0fu5eraTkMCZWRPWRGJ/iL1pjTTuYTd8+KQHTRBD0X46aTBfCjLX
	 95KNsvh5mJ9Jf3YS/YHGpn3f9ego2GXP/h6JY7xH5g7uT/U/Ql/LI3nrtXT+8Dk+Qz
	 cr9jDURzZgGwXL+0Ns8TUV4TeNwX3TtKCNLDy0aUjV7wgfMXCGvlmjJDER8ZOq/l9Z
	 pCA+5Cu3Wlv3CF1YVIMoYEtRRTbWSY5Lr/Jaz2GA5QaW0vhavqIDnqEBy4DLEN7HQJ
	 8tXeIcM8toXFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 46/73] lsm: make security_socket_getpeersec_stream() sockptr_t safe
Date: Wed, 13 Mar 2024 12:46:13 -0400
Message-ID: <20240313164640.616049-47-sashal@kernel.org>
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

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit b10b9c342f7571f287fd422be5d5c0beb26ba974 ]

Commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
sockptr_t argument") made it possible to call sk_getsockopt()
with both user and kernel address space buffers through the use of
the sockptr_t type.  Unfortunately at the time of conversion the
security_socket_getpeersec_stream() LSM hook was written to only
accept userspace buffers, and in a desire to avoid having to change
the LSM hook the commit author simply passed the sockptr_t's
userspace buffer pointer.  Since the only sk_getsockopt() callers
at the time of conversion which used kernel sockptr_t buffers did
not allow SO_PEERSEC, and hence the
security_socket_getpeersec_stream() hook, this was acceptable but
also very fragile as future changes presented the possibility of
silently passing kernel space pointers to the LSM hook.

There are several ways to protect against this, including careful
code review of future commits, but since relying on code review to
catch bugs is a recipe for disaster and the upstream eBPF maintainer
is "strongly against defensive programming", this patch updates the
LSM hook, and all of the implementations to support sockptr_t and
safely handle both user and kernel space buffers.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: 5a287d3d2b9d ("lsm: fix default return value of the socket_getpeersec_*() hooks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/lsm_hooks.h     |  4 ++--
 include/linux/security.h      | 11 +++++++----
 net/core/sock.c               |  3 ++-
 security/apparmor/lsm.c       | 29 +++++++++++++----------------
 security/security.c           |  6 +++---
 security/selinux/hooks.c      | 13 ++++++-------
 security/smack/smack_lsm.c    | 19 ++++++++++---------
 8 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 92a76ce0c382d..9f550eab8ebdb 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -294,7 +294,7 @@ LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
-	 char __user *optval, int __user *optlen, unsigned len)
+	 sockptr_t optval, sockptr_t optlen, unsigned int len)
 LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 64cdf4d7bfb30..bbf9c8c7bd9c5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -926,8 +926,8 @@
  *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
+ *	@optval memory where the security state is to be copied.
+ *	@optlen memory where the module should copy the actual length
  *	of the security state.
  *	@len as input is the maximum length to copy to userspace provided
  *	by the caller.
diff --git a/include/linux/security.h b/include/linux/security.h
index e388b1666bcfc..5b61aa19fac66 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/sockptr.h>
 
 struct linux_binprm;
 struct cred;
@@ -1366,8 +1367,8 @@ int security_socket_getsockopt(struct socket *sock, int level, int optname);
 int security_socket_setsockopt(struct socket *sock, int level, int optname);
 int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
-int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
+int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
+				      sockptr_t optlen, unsigned int len);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
@@ -1501,8 +1502,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    sockptr_t optval,
+						    sockptr_t optlen,
+						    unsigned int len)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 42da46965b16f..016c0b9e01b70 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1503,7 +1503,8 @@ static int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval.user, optlen.user, len);
+		return security_socket_getpeersec_stream(sock,
+							 optval, optlen, len);
 
 	case SO_MARK:
 		v.val = sk->sk_mark;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 585edcc6814d2..052f1b920e43f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1070,11 +1070,10 @@ static struct aa_label *sk_peer_label(struct sock *sk)
  * Note: for tcp only valid if using ipsec or cipso on lan
  */
 static int apparmor_socket_getpeersec_stream(struct socket *sock,
-					     char __user *optval,
-					     int __user *optlen,
+					     sockptr_t optval, sockptr_t optlen,
 					     unsigned int len)
 {
-	char *name;
+	char *name = NULL;
 	int slen, error = 0;
 	struct aa_label *label;
 	struct aa_label *peer;
@@ -1091,23 +1090,21 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	/* don't include terminating \0 in slen, it breaks some apps */
 	if (slen < 0) {
 		error = -ENOMEM;
-	} else {
-		if (slen > len) {
-			error = -ERANGE;
-		} else if (copy_to_user(optval, name, slen)) {
-			error = -EFAULT;
-			goto out;
-		}
-		if (put_user(slen, optlen))
-			error = -EFAULT;
-out:
-		kfree(name);
-
+		goto done;
+	}
+	if (slen > len) {
+		error = -ERANGE;
+		goto done_len;
 	}
 
+	if (copy_to_sockptr(optval, name, slen))
+		error = -EFAULT;
+done_len:
+	if (copy_to_sockptr(optlen, &slen, sizeof(slen)))
+		error = -EFAULT;
 done:
 	end_current_label_crit_section(label);
-
+	kfree(name);
 	return error;
 }
 
diff --git a/security/security.c b/security/security.c
index 269c3965393f4..e9dcde3c4f14b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2224,11 +2224,11 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
-int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len)
+int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
+				      sockptr_t optlen, unsigned int len)
 {
 	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+			     optval, optlen, len);
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 50d3ddfe15fd1..46c00a68bb4bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5110,11 +5110,12 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-					    int __user *optlen, unsigned len)
+static int selinux_socket_getpeersec_stream(struct socket *sock,
+					    sockptr_t optval, sockptr_t optlen,
+					    unsigned int len)
 {
 	int err = 0;
-	char *scontext;
+	char *scontext = NULL;
 	u32 scontext_len;
 	struct sk_security_struct *sksec = sock->sk->sk_security;
 	u32 peer_sid = SECSID_NULL;
@@ -5130,17 +5131,15 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 				      &scontext_len);
 	if (err)
 		return err;
-
 	if (scontext_len > len) {
 		err = -ERANGE;
 		goto out_len;
 	}
 
-	if (copy_to_user(optval, scontext, scontext_len))
+	if (copy_to_sockptr(optval, scontext, scontext_len))
 		err = -EFAULT;
-
 out_len:
-	if (put_user(scontext_len, optlen))
+	if (copy_to_sockptr(optlen, &scontext_len, sizeof(scontext_len)))
 		err = -EFAULT;
 	kfree(scontext);
 	return err;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e1669759403a6..5388f143eecd8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4022,12 +4022,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
  * returns zero on success, an error code otherwise
  */
 static int smack_socket_getpeersec_stream(struct socket *sock,
-					  char __user *optval,
-					  int __user *optlen, unsigned len)
+					  sockptr_t optval, sockptr_t optlen,
+					  unsigned int len)
 {
 	struct socket_smack *ssp;
 	char *rcp = "";
-	int slen = 1;
+	u32 slen = 1;
 	int rc = 0;
 
 	ssp = sock->sk->sk_security;
@@ -4035,15 +4035,16 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
 	}
-
-	if (slen > len)
+	if (slen > len) {
 		rc = -ERANGE;
-	else if (copy_to_user(optval, rcp, slen) != 0)
-		rc = -EFAULT;
+		goto out_len;
+	}
 
-	if (put_user(slen, optlen) != 0)
+	if (copy_to_sockptr(optval, rcp, slen))
+		rc = -EFAULT;
+out_len:
+	if (copy_to_sockptr(optlen, &slen, sizeof(slen)))
 		rc = -EFAULT;
-
 	return rc;
 }
 
-- 
2.43.0


