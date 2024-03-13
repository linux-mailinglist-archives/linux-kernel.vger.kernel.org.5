Return-Path: <linux-kernel+bounces-102070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B087AE26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAB81F2D208
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58D15B0FD;
	Wed, 13 Mar 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+Mq+JFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345C15AAD9;
	Wed, 13 Mar 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348450; cv=none; b=Af/LkMfGNl7ueCiA+j8TvqFTOlDGgPy5l0pjYyfuDJeFz6qkGML7HIgGkpSuOzPwsHRg6jilkNj2gz7xhwND8nrpD9tT5bDTiGJnJRlyf0vSU+0NEuct8kYLJwXzv0eMUlEG/E5cgAXdUnNyG+XuY/YoNeLqvN5w/mQjHMvv2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348450; c=relaxed/simple;
	bh=35fWejEZZKXvoDZx3BRorUFQb5CQmMP9lyAXTgMA5LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE0J9RzKz7u6Zz6nHjaNol0zf+zAh9hXtljBNFfSYJfOjebGi9dQEVitJo/K3WHOXgIK8b3He2iixxic7+ooTso15ZA0CRLQrIJ6IQwdyfutQaj1cJIK6VTh+pz6Iw4dR6SdpuwBUV0mh0WfjzTTnooH7CSY+kfyZm8HbdluMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+Mq+JFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE15BC433F1;
	Wed, 13 Mar 2024 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348450;
	bh=35fWejEZZKXvoDZx3BRorUFQb5CQmMP9lyAXTgMA5LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+Mq+JFRumLQlHx+esAqJA6Mx/vC5NEoYOkiM2VG53Ll7CiFe95Rv8V4fi6M+S9Vq
	 IKRROMkYSqk7qhCNQkO1YaMsYbRzybeXdHha5OR1d3RNejc4+JM5QCxVfNzpT14Ud0
	 BgWBjuOeXl0npTY6Y227d4b4S3pM8r7SeQgy37bS8QTBgwDI3WePvpt8wwgsUFSihD
	 x0QOfvdxcNFnhxxPvSfYG2MHbSb0VfHH6OIa9gYD4JTFTEXNVlFuLY9CzKtKyaYOIq
	 OI4ODXZeExo40K9UO1IbeiiYIrfkHolSe5gB+y5kNdkffRYPNz+vnilDYk1+dR8xjL
	 YX780hf/dDdxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 44/73] net: Change sock_getsockopt() to take the sk ptr instead of the sock ptr
Date: Wed, 13 Mar 2024 12:46:11 -0400
Message-ID: <20240313164640.616049-45-sashal@kernel.org>
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

[ Upstream commit ba74a7608dc12fbbd8ea36e660087f08a81ef26a ]

A latter patch refactors bpf_getsockopt(SOL_SOCKET) with the
sock_getsockopt() to avoid code duplication and code
drift between the two duplicates.

The current sock_getsockopt() takes sock ptr as the argument.
The very first thing of this function is to get back the sk ptr
by 'sk = sock->sk'.

bpf_getsockopt() could be called when the sk does not have
the sock ptr created.  Meaning sk->sk_socket is NULL.  For example,
when a passive tcp connection has just been established but has yet
been accept()-ed.  Thus, it cannot use the sock_getsockopt(sk->sk_socket)
or else it will pass a NULL ptr.

This patch moves all sock_getsockopt implementation to the newly
added sk_getsockopt().  The new sk_getsockopt() takes a sk ptr
and immediately gets the sock ptr by 'sock = sk->sk_socket'

The existing sock_getsockopt(sock) is changed to call
sk_getsockopt(sock->sk).  All existing callers have both sock->sk
and sk->sk_socket pointer.

The latter patch will make bpf_getsockopt(SOL_SOCKET) call
sk_getsockopt(sk) directly.  The bpf_getsockopt(SOL_SOCKET) does
not use the optnames that require sk->sk_socket, so it will
be safe.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20220902002756.2887884-1-kafai@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 5a287d3d2b9d ("lsm: fix default return value of the socket_getpeersec_*() hooks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 769e969cd1dc5..95559d088a169 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1293,10 +1293,10 @@ static int groups_to_user(gid_t __user *dst, const struct group_info *src)
 	return 0;
 }
 
-int sock_getsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, int __user *optlen)
+static int sk_getsockopt(struct sock *sk, int level, int optname,
+			 char __user *optval, int __user *optlen)
 {
-	struct sock *sk = sock->sk;
+	struct socket *sock = sk->sk_socket;
 
 	union {
 		int val;
@@ -1633,6 +1633,12 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 	return 0;
 }
 
+int sock_getsockopt(struct socket *sock, int level, int optname,
+		    char __user *optval, int __user *optlen)
+{
+	return sk_getsockopt(sock->sk, level, optname, optval, optlen);
+}
+
 /*
  * Initialize an sk_lock.
  *
-- 
2.43.0


