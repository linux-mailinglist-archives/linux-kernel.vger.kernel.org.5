Return-Path: <linux-kernel+bounces-116161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD28899DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2648E1F34819
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11683B3DED;
	Mon, 25 Mar 2024 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjgWxqAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F117B51D;
	Sun, 24 Mar 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323730; cv=none; b=EhfU9bWRPiKcx591Elu31oUBtPju9Cbo0z+fhPGvka6Dxxfmw+1zTW4BpLSIm1lYbvo/pjWWu3mFTrQ5iWcFADO0XiDlN3ceOwms0TEZ3oN9Gdk/ZAK4ppQqYEkb0x/u4gsx2HitqPA+qmmT+v24OdihjG5GGniNRKgl3QXQKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323730; c=relaxed/simple;
	bh=6VinoPuNgON923fXroetocZufo3yJ31R1R0fzgXBo7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd4Q5q3xAyNcKKNFIMQILesjD54/NSWapR2nRq4KgCW54pis3M5to160kUkpHDxJoFue05VhYB9jAWyzS4C8XB04NistVrYrPYnSM3w6tGSWsxaaYB+XQ5eVLdMJNMQjdvGqxgpA7HPMcTfVNIyp8wgyb6dx6PFpkVjCAeMUipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjgWxqAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1FCC433F1;
	Sun, 24 Mar 2024 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323729;
	bh=6VinoPuNgON923fXroetocZufo3yJ31R1R0fzgXBo7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjgWxqAFEieeu/ouA95AcOpZo93L1mK5TwjCsEtMuXUUWvZrf1i8iTxbejE7E1UGG
	 h+GBkY0v+hoDPNbAQGXBmkh9iGcoiaC/vVeCEgCy3uLfjRdbVXXQzfgVd1HNxhb9a6
	 iH305cvuAZVB3CkzXQyUUm6pEn1K93j84l34CHdP/j6h80hgTTn0GZHEpO/EQG9fXp
	 9ZSV4XlelJmxMT44dred8IXd5yo//Oie01vD6M/QMAV5DiqmoClZ3uqV+7VW90NoTf
	 MIWCS28hxY8a1bwD0Iil2KzzxVOKglttiUqkBlEqRyDnWCaLVF8cDtaGhpTaHxEoyw
	 OE5ShQVlVmrkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 103/238] net/ipv4/ipv6: Replace one-element arraya with flexible-array members
Date: Sun, 24 Mar 2024 19:38:11 -0400
Message-ID: <20240324234027.1354210-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit db243b796439c0caba47865564d8acd18a301d18 ]

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use an anonymous union with a couple of anonymous structs in order to
keep userspace unchanged and refactor the related code accordingly:

$ pahole -C group_filter net/ipv4/ip_sockglue.o
struct group_filter {
	union {
		struct {
			__u32      gf_interface_aux;     /*     0     4 */

			/* XXX 4 bytes hole, try to pack */

			struct __kernel_sockaddr_storage gf_group_aux; /*     8   128 */
			/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
			__u32      gf_fmode_aux;         /*   136     4 */
			__u32      gf_numsrc_aux;        /*   140     4 */
			struct __kernel_sockaddr_storage gf_slist[1]; /*   144   128 */
		};                                       /*     0   272 */
		struct {
			__u32      gf_interface;         /*     0     4 */

			/* XXX 4 bytes hole, try to pack */

			struct __kernel_sockaddr_storage gf_group; /*     8   128 */
			/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
			__u32      gf_fmode;             /*   136     4 */
			__u32      gf_numsrc;            /*   140     4 */
			struct __kernel_sockaddr_storage gf_slist_flex[0]; /*   144     0 */
		};                                       /*     0   144 */
	};                                               /*     0   272 */

	/* size: 272, cachelines: 5, members: 1 */
	/* last cacheline: 16 bytes */
};

$ pahole -C compat_group_filter net/ipv4/ip_sockglue.o
struct compat_group_filter {
	union {
		struct {
			__u32      gf_interface_aux;     /*     0     4 */
			struct __kernel_sockaddr_storage gf_group_aux __attribute__((__aligned__(4))); /*     4   128 */
			/* --- cacheline 2 boundary (128 bytes) was 4 bytes ago --- */
			__u32      gf_fmode_aux;         /*   132     4 */
			__u32      gf_numsrc_aux;        /*   136     4 */
			struct __kernel_sockaddr_storage gf_slist[1] __attribute__((__aligned__(4))); /*   140   128 */
		} __attribute__((__packed__)) __attribute__((__aligned__(4)));                     /*     0   268 */
		struct {
			__u32      gf_interface;         /*     0     4 */
			struct __kernel_sockaddr_storage gf_group __attribute__((__aligned__(4))); /*     4   128 */
			/* --- cacheline 2 boundary (128 bytes) was 4 bytes ago --- */
			__u32      gf_fmode;             /*   132     4 */
			__u32      gf_numsrc;            /*   136     4 */
			struct __kernel_sockaddr_storage gf_slist_flex[0] __attribute__((__aligned__(4))); /*   140     0 */
		} __attribute__((__packed__)) __attribute__((__aligned__(4)));                     /*     0   140 */
	} __attribute__((__aligned__(1)));               /*     0   268 */

	/* size: 268, cachelines: 5, members: 1 */
	/* forced alignments: 1 */
	/* last cacheline: 12 bytes */
} __attribute__((__packed__));

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5c3be3e0eb44 ("ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/compat.h     | 27 ++++++++++++++++++++-------
 include/uapi/linux/in.h  | 21 ++++++++++++++++-----
 net/ipv4/ip_sockglue.c   | 19 ++++++++++---------
 net/ipv6/ipv6_sockglue.c | 18 +++++++++---------
 4 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/include/net/compat.h b/include/net/compat.h
index 745db0d605b62..52bf5f0ee236b 100644
--- a/include/net/compat.h
+++ b/include/net/compat.h
@@ -81,13 +81,26 @@ struct compat_group_source_req {
 } __packed;
 
 struct compat_group_filter {
-	__u32				 gf_interface;
-	struct __kernel_sockaddr_storage gf_group
-		__aligned(4);
-	__u32				 gf_fmode;
-	__u32				 gf_numsrc;
-	struct __kernel_sockaddr_storage gf_slist[1]
-		__aligned(4);
+	union {
+		struct {
+			__u32				 gf_interface_aux;
+			struct __kernel_sockaddr_storage gf_group_aux
+				__aligned(4);
+			__u32				 gf_fmode_aux;
+			__u32				 gf_numsrc_aux;
+			struct __kernel_sockaddr_storage gf_slist[1]
+				__aligned(4);
+		} __packed;
+		struct {
+			__u32				 gf_interface;
+			struct __kernel_sockaddr_storage gf_group
+				__aligned(4);
+			__u32				 gf_fmode;
+			__u32				 gf_numsrc;
+			struct __kernel_sockaddr_storage gf_slist_flex[]
+				__aligned(4);
+		} __packed;
+	};
 } __packed;
 
 #endif /* NET_COMPAT_H */
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 066098a5b9360..c4702fff64d3a 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -224,11 +224,22 @@ struct group_source_req {
 };
 
 struct group_filter {
-	__u32				 gf_interface;	/* interface index */
-	struct __kernel_sockaddr_storage gf_group;	/* multicast address */
-	__u32				 gf_fmode;	/* filter mode */
-	__u32				 gf_numsrc;	/* number of sources */
-	struct __kernel_sockaddr_storage gf_slist[1];	/* interface index */
+	union {
+		struct {
+			__u32				 gf_interface_aux; /* interface index */
+			struct __kernel_sockaddr_storage gf_group_aux;	   /* multicast address */
+			__u32				 gf_fmode_aux;	   /* filter mode */
+			__u32				 gf_numsrc_aux;	   /* number of sources */
+			struct __kernel_sockaddr_storage gf_slist[1];	   /* interface index */
+		};
+		struct {
+			__u32				 gf_interface;	  /* interface index */
+			struct __kernel_sockaddr_storage gf_group;	  /* multicast address */
+			__u32				 gf_fmode;	  /* filter mode */
+			__u32				 gf_numsrc;	  /* number of sources */
+			struct __kernel_sockaddr_storage gf_slist_flex[]; /* interface index */
+		};
+	};
 };
 
 #define GROUP_FILTER_SIZE(numsrc) \
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 28b9b2e85f0be..9bea014309ded 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -797,7 +797,8 @@ static int ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval, int optlen)
 		goto out_free_gsf;
 
 	err = set_mcast_msfilter(sk, gsf->gf_interface, gsf->gf_numsrc,
-				 gsf->gf_fmode, &gsf->gf_group, gsf->gf_slist);
+				 gsf->gf_fmode, &gsf->gf_group,
+				 gsf->gf_slist_flex);
 out_free_gsf:
 	kfree(gsf);
 	return err;
@@ -806,7 +807,7 @@ static int ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval, int optlen)
 static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		int optlen)
 {
-	const int size0 = offsetof(struct compat_group_filter, gf_slist);
+	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter *gf32;
 	unsigned int n;
 	void *p;
@@ -820,7 +821,7 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	p = kmalloc(optlen + 4, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
-	gf32 = p + 4; /* we want ->gf_group and ->gf_slist aligned */
+	gf32 = p + 4; /* we want ->gf_group and ->gf_slist_flex aligned */
 
 	err = -EFAULT;
 	if (copy_from_sockptr(gf32, optval, optlen))
@@ -833,7 +834,7 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		goto out_free_gsf;
 
 	err = -EINVAL;
-	if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen)
+	if (offsetof(struct compat_group_filter, gf_slist_flex[n]) > optlen)
 		goto out_free_gsf;
 
 	/* numsrc >= (4G-140)/128 overflow in 32 bits */
@@ -841,7 +842,7 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	if (n > READ_ONCE(sock_net(sk)->ipv4.sysctl_igmp_max_msf))
 		goto out_free_gsf;
 	err = set_mcast_msfilter(sk, gf32->gf_interface, n, gf32->gf_fmode,
-				 &gf32->gf_group, gf32->gf_slist);
+				 &gf32->gf_group, gf32->gf_slist_flex);
 out_free_gsf:
 	kfree(p);
 	return err;
@@ -1462,7 +1463,7 @@ static bool getsockopt_needs_rtnl(int optname)
 static int ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 		int __user *optlen, int len)
 {
-	const int size0 = offsetof(struct group_filter, gf_slist);
+	const int size0 = offsetof(struct group_filter, gf_slist_flex);
 	struct group_filter __user *p = optval;
 	struct group_filter gsf;
 	int num;
@@ -1474,7 +1475,7 @@ static int ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 		return -EFAULT;
 
 	num = gsf.gf_numsrc;
-	err = ip_mc_gsfget(sk, &gsf, p->gf_slist);
+	err = ip_mc_gsfget(sk, &gsf, p->gf_slist_flex);
 	if (err)
 		return err;
 	if (gsf.gf_numsrc < num)
@@ -1488,7 +1489,7 @@ static int ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 		int __user *optlen, int len)
 {
-	const int size0 = offsetof(struct compat_group_filter, gf_slist);
+	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter __user *p = optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
@@ -1505,7 +1506,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 	num = gf.gf_numsrc = gf32.gf_numsrc;
 	gf.gf_group = gf32.gf_group;
 
-	err = ip_mc_gsfget(sk, &gf, p->gf_slist);
+	err = ip_mc_gsfget(sk, &gf, p->gf_slist_flex);
 	if (err)
 		return err;
 	if (gf.gf_numsrc < num)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 7b4b457a8b87a..0ac527cd5d56d 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -225,7 +225,7 @@ static int ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
 		goto out_free_gsf;
 
-	ret = ip6_mc_msfilter(sk, gsf, gsf->gf_slist);
+	ret = ip6_mc_msfilter(sk, gsf, gsf->gf_slist_flex);
 out_free_gsf:
 	kfree(gsf);
 	return ret;
@@ -234,7 +234,7 @@ static int ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 static int compat_ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		int optlen)
 {
-	const int size0 = offsetof(struct compat_group_filter, gf_slist);
+	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter *gf32;
 	void *p;
 	int ret;
@@ -249,7 +249,7 @@ static int compat_ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	if (!p)
 		return -ENOMEM;
 
-	gf32 = p + 4; /* we want ->gf_group and ->gf_slist aligned */
+	gf32 = p + 4; /* we want ->gf_group and ->gf_slist_flex aligned */
 	ret = -EFAULT;
 	if (copy_from_sockptr(gf32, optval, optlen))
 		goto out_free_p;
@@ -261,14 +261,14 @@ static int compat_ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		goto out_free_p;
 
 	ret = -EINVAL;
-	if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen)
+	if (offsetof(struct compat_group_filter, gf_slist_flex[n]) > optlen)
 		goto out_free_p;
 
 	ret = ip6_mc_msfilter(sk, &(struct group_filter){
 			.gf_interface = gf32->gf_interface,
 			.gf_group = gf32->gf_group,
 			.gf_fmode = gf32->gf_fmode,
-			.gf_numsrc = gf32->gf_numsrc}, gf32->gf_slist);
+			.gf_numsrc = gf32->gf_numsrc}, gf32->gf_slist_flex);
 
 out_free_p:
 	kfree(p);
@@ -1051,7 +1051,7 @@ static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions *opt,
 static int ipv6_get_msfilter(struct sock *sk, void __user *optval,
 		int __user *optlen, int len)
 {
-	const int size0 = offsetof(struct group_filter, gf_slist);
+	const int size0 = offsetof(struct group_filter, gf_slist_flex);
 	struct group_filter __user *p = optval;
 	struct group_filter gsf;
 	int num;
@@ -1065,7 +1065,7 @@ static int ipv6_get_msfilter(struct sock *sk, void __user *optval,
 		return -EADDRNOTAVAIL;
 	num = gsf.gf_numsrc;
 	lock_sock(sk);
-	err = ip6_mc_msfget(sk, &gsf, p->gf_slist);
+	err = ip6_mc_msfget(sk, &gsf, p->gf_slist_flex);
 	if (!err) {
 		if (num > gsf.gf_numsrc)
 			num = gsf.gf_numsrc;
@@ -1080,7 +1080,7 @@ static int ipv6_get_msfilter(struct sock *sk, void __user *optval,
 static int compat_ipv6_get_msfilter(struct sock *sk, void __user *optval,
 		int __user *optlen)
 {
-	const int size0 = offsetof(struct compat_group_filter, gf_slist);
+	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter __user *p = optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
@@ -1103,7 +1103,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk, void __user *optval,
 		return -EADDRNOTAVAIL;
 
 	lock_sock(sk);
-	err = ip6_mc_msfget(sk, &gf, p->gf_slist);
+	err = ip6_mc_msfget(sk, &gf, p->gf_slist_flex);
 	release_sock(sk);
 	if (err)
 		return err;
-- 
2.43.0


