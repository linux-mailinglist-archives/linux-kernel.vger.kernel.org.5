Return-Path: <linux-kernel+bounces-114822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5367388918D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853C01C2D386
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871D2C097F;
	Mon, 25 Mar 2024 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1LP8Iwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0D130A7D;
	Sun, 24 Mar 2024 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323443; cv=none; b=QDMo2yMNNnj1Ic/l3aLOIDPnJaFqfi/v6ctjqBBLiHTkHzAbmUfBUxe2iSDNSOuIxIhBwzVJ2UWT2xpxqJM2VnwvE7Y0TWVAtYlaN0AQSakuuhjgfBEyeEasM44TEt1kGvjPdmG2rb4jANdU/ttS5xdS8nuIy5v7gfBB7MKDx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323443; c=relaxed/simple;
	bh=wdEzb+r401JEaKCRXGC2/YEuoVFNI3mdo2XqI6sn6+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P30Jv2uYPcbKD32AMQP6VQbTt3RehyclcwvWtiCcOEDzOXgzr3BJfmEidR2wk1rYvgpQPWgtUmMgjtBgUd/NZbEV+XO9NvpGNZW+MA/v6LrzbzQAEzyJh5TqbOvFy/EiCQBCeSOWGjoF5dB24p8TBXBE4VK0yNtN6cvmpJbfvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1LP8Iwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B89C433C7;
	Sun, 24 Mar 2024 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323442;
	bh=wdEzb+r401JEaKCRXGC2/YEuoVFNI3mdo2XqI6sn6+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1LP8IwyK10v6FiPAVuKYKz8ylrhTSrBiqJUarU9gjuwHQ9FI2oNDtSxSDWwtDA5Y
	 t6UdUDo7H+KeElq9J9OcFdY3NUJP2Bpg4rr5ATGOM884va+fuCZV6v3I6hscY38Xa0
	 VmObDqklAVB5j1pAdmFIzmK3KcpxMPq9L9UvtdZ8W23ET5v/kQPHqhrMqePlNl3YMv
	 46y+fEEhpHPY1wwWYAtUdYCWrL6L4m2JIMKzkSZhODTkNJ0jc0kfR7P961/i6HHN1f
	 TPOPqKMXGa/Z2R65GE5Zettcxv7m75TNd/xk0rhNZY337rvgbDlTlRWY84QlL+diEa
	 V9cc7uZu807Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 145/317] net: Change sock_getsockopt() to take the sk ptr instead of the sock ptr
Date: Sun, 24 Mar 2024 19:32:05 -0400
Message-ID: <20240324233458.1352854-146-sashal@kernel.org>
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
Stable-dep-of: 5c3be3e0eb44 ("ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e254790d562ef..f8e3ba34e0a34 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1416,10 +1416,10 @@ static int groups_to_user(gid_t __user *dst, const struct group_info *src)
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
@@ -1780,6 +1780,12 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
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


