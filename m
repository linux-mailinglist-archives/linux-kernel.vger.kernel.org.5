Return-Path: <linux-kernel+bounces-114988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A287A888CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D52B26A23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCD2E35A0;
	Mon, 25 Mar 2024 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8NGYwXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948517AFA6;
	Sun, 24 Mar 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323731; cv=none; b=VrX4UzeoaSwNT6ISgZyAR+jOrZx9vbQsNW4Vlo5fAv+HvE/FKszky7HnexjHWhtE+4GzM5pFRo38lenWmV7WCfh5SuOWIvlAdaCRdnvZvIg02PVFlJmuSkSWhow5ObdrtmXsvIkKjlFY3UKLbyvLEcjUPZ/Og0DAxyoH8MhS+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323731; c=relaxed/simple;
	bh=WyfJLEpIpP2mlcQNBAXR0QanEuWmlGueOQTNKeAQ044=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKfSYcRO5cgZbifA4H0+YclEDKdPPb9ujES4nP0xsX2po/3ukCXsfZv/f2jTfcwstejFZFrlfvN1pUt4sb+LvRFFASR79ybVfQRq6XSVV8P/is76yozzgfn0GP/rRITUGt2S9J1Ir/sYMBR9DsgL/+SJGebh0K1CdRUnr2WYngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8NGYwXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03253C43390;
	Sun, 24 Mar 2024 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323730;
	bh=WyfJLEpIpP2mlcQNBAXR0QanEuWmlGueOQTNKeAQ044=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8NGYwXliurlzVj7VWSDL4XdmrFnQPpkAxgLuwKjF6HCmxmLuKiVQsVfIvDfBVGus
	 pdKAm/CaAb9ONFpUD1g0WvJbGW/F+sBkZo2k8QGxjWakkMtLHdvwBEbetJtUpK+NzJ
	 ZRhqzDhpoGXG0Z5AzCv9QWYY2xesFLDU2dZd+/dbsQ8QexsEOnkjZtUdBuQKtuV5R2
	 D+xEFdghWo75a1xq0sjt3jabHwTlworoq0KcUOkc7oEnWbJBpoix90RkFEl+Lc4zG7
	 BHnv+ijWao0IS2yDrLFdhcpq/Shwc8drSRejIgo/sUvsSLEUeVmnn5MKw+uMj+mp/B
	 3U1ALq0Fzd5eQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 104/238] bpf: net: Change do_ip_getsockopt() to take the sockptr_t argument
Date: Sun, 24 Mar 2024 19:38:12 -0400
Message-ID: <20240324234027.1354210-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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

[ Upstream commit 728f064cd7ebea8c182e99e6f152c8b4a0a6b071 ]

Similar to the earlier patch that changes sk_getsockopt() to
take the sockptr_t argument.  This patch also changes
do_ip_getsockopt() to take the sockptr_t argument such that
a latter patch can make bpf_getsockopt(SOL_IP) to reuse
do_ip_getsockopt().

Note on the change in ip_mc_gsfget().  This function is to
return an array of sockaddr_storage in optval.  This function
is shared between ip_get_mcast_msfilter() and
compat_ip_get_mcast_msfilter().  However, the sockaddr_storage
is stored at different offset of the optval because of
the difference between group_filter and compat_group_filter.
Thus, a new 'ss_offset' argument is added to ip_mc_gsfget().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20220902002828.2890585-1-kafai@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 5c3be3e0eb44 ("ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/igmp.h   |  4 +--
 include/linux/mroute.h |  6 ++--
 net/ipv4/igmp.c        | 22 +++++++-----
 net/ipv4/ip_sockglue.c | 80 ++++++++++++++++++++++++------------------
 net/ipv4/ipmr.c        |  9 ++---
 5 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 64ce8cd1cfaf1..4adab8ada85af 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -121,9 +121,9 @@ extern int ip_mc_source(int add, int omode, struct sock *sk,
 		struct ip_mreq_source *mreqs, int ifindex);
 extern int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf,int ifindex);
 extern int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-		struct ip_msfilter __user *optval, int __user *optlen);
+			sockptr_t optval, sockptr_t optlen);
 extern int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-			struct sockaddr_storage __user *p);
+			sockptr_t optval, size_t offset);
 extern int ip_mc_sf_allow(struct sock *sk, __be32 local, __be32 rmt,
 			  int dif, int sdif);
 extern void ip_mc_init_dev(struct in_device *);
diff --git a/include/linux/mroute.h b/include/linux/mroute.h
index 6cbbfe94348ce..80b8400ab8b24 100644
--- a/include/linux/mroute.h
+++ b/include/linux/mroute.h
@@ -17,7 +17,7 @@ static inline int ip_mroute_opt(int opt)
 }
 
 int ip_mroute_setsockopt(struct sock *, int, sockptr_t, unsigned int);
-int ip_mroute_getsockopt(struct sock *, int, char __user *, int __user *);
+int ip_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_t);
 int ipmr_ioctl(struct sock *sk, int cmd, void __user *arg);
 int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 int ip_mr_init(void);
@@ -29,8 +29,8 @@ static inline int ip_mroute_setsockopt(struct sock *sock, int optname,
 	return -ENOPROTOOPT;
 }
 
-static inline int ip_mroute_getsockopt(struct sock *sock, int optname,
-				       char __user *optval, int __user *optlen)
+static inline int ip_mroute_getsockopt(struct sock *sk, int optname,
+				       sockptr_t optval, sockptr_t optlen)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 4ba1c92fb3524..f0a313747b950 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2526,11 +2526,10 @@ int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
 		err = ip_mc_leave_group(sk, &imr);
 	return err;
 }
-
 int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-	struct ip_msfilter __user *optval, int __user *optlen)
+		 sockptr_t optval, sockptr_t optlen)
 {
-	int err, len, count, copycount;
+	int err, len, count, copycount, msf_size;
 	struct ip_mreqn	imr;
 	__be32 addr = msf->imsf_multiaddr;
 	struct ip_mc_socklist *pmc;
@@ -2573,12 +2572,15 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 	copycount = count < msf->imsf_numsrc ? count : msf->imsf_numsrc;
 	len = flex_array_size(psl, sl_addr, copycount);
 	msf->imsf_numsrc = count;
-	if (put_user(IP_MSFILTER_SIZE(copycount), optlen) ||
-	    copy_to_user(optval, msf, IP_MSFILTER_SIZE(0))) {
+	msf_size = IP_MSFILTER_SIZE(copycount);
+	if (copy_to_sockptr(optlen, &msf_size, sizeof(int)) ||
+	    copy_to_sockptr(optval, msf, IP_MSFILTER_SIZE(0))) {
 		return -EFAULT;
 	}
 	if (len &&
-	    copy_to_user(&optval->imsf_slist_flex[0], psl->sl_addr, len))
+	    copy_to_sockptr_offset(optval,
+				   offsetof(struct ip_msfilter, imsf_slist_flex),
+				   psl->sl_addr, len))
 		return -EFAULT;
 	return 0;
 done:
@@ -2586,7 +2588,7 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 }
 
 int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-	struct sockaddr_storage __user *p)
+		 sockptr_t optval, size_t ss_offset)
 {
 	int i, count, copycount;
 	struct sockaddr_in *psin;
@@ -2616,15 +2618,17 @@ int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
 	count = psl ? psl->sl_count : 0;
 	copycount = count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
 	gsf->gf_numsrc = count;
-	for (i = 0; i < copycount; i++, p++) {
+	for (i = 0; i < copycount; i++) {
 		struct sockaddr_storage ss;
 
 		psin = (struct sockaddr_in *)&ss;
 		memset(&ss, 0, sizeof(ss));
 		psin->sin_family = AF_INET;
 		psin->sin_addr.s_addr = psl->sl_addr[i];
-		if (copy_to_user(p, &ss, sizeof(ss)))
+		if (copy_to_sockptr_offset(optval, ss_offset,
+					   &ss, sizeof(ss)))
 			return -EFAULT;
+		ss_offset += sizeof(ss);
 	}
 	return 0;
 }
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 9bea014309ded..b300d0988d525 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1460,37 +1460,37 @@ static bool getsockopt_needs_rtnl(int optname)
 	return false;
 }
 
-static int ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
-		int __user *optlen, int len)
+static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
+				 sockptr_t optlen, int len)
 {
 	const int size0 = offsetof(struct group_filter, gf_slist_flex);
-	struct group_filter __user *p = optval;
 	struct group_filter gsf;
-	int num;
+	int num, gsf_size;
 	int err;
 
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gsf, p, size0))
+	if (copy_from_sockptr(&gsf, optval, size0))
 		return -EFAULT;
 
 	num = gsf.gf_numsrc;
-	err = ip_mc_gsfget(sk, &gsf, p->gf_slist_flex);
+	err = ip_mc_gsfget(sk, &gsf, optval,
+			   offsetof(struct group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gsf.gf_numsrc < num)
 		num = gsf.gf_numsrc;
-	if (put_user(GROUP_FILTER_SIZE(num), optlen) ||
-	    copy_to_user(p, &gsf, size0))
+	gsf_size = GROUP_FILTER_SIZE(num);
+	if (copy_to_sockptr(optlen, &gsf_size, sizeof(int)) ||
+	    copy_to_sockptr(optval, &gsf, size0))
 		return -EFAULT;
 	return 0;
 }
 
-static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
-		int __user *optlen, int len)
+static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
+					sockptr_t optlen, int len)
 {
 	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
-	struct compat_group_filter __user *p = optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
 	int num;
@@ -1498,7 +1498,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gf32, p, size0))
+	if (copy_from_sockptr(&gf32, optval, size0))
 		return -EFAULT;
 
 	gf.gf_interface = gf32.gf_interface;
@@ -1506,21 +1506,24 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 	num = gf.gf_numsrc = gf32.gf_numsrc;
 	gf.gf_group = gf32.gf_group;
 
-	err = ip_mc_gsfget(sk, &gf, p->gf_slist_flex);
+	err = ip_mc_gsfget(sk, &gf, optval,
+			   offsetof(struct compat_group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gf.gf_numsrc < num)
 		num = gf.gf_numsrc;
 	len = GROUP_FILTER_SIZE(num) - (sizeof(gf) - sizeof(gf32));
-	if (put_user(len, optlen) ||
-	    put_user(gf.gf_fmode, &p->gf_fmode) ||
-	    put_user(gf.gf_numsrc, &p->gf_numsrc))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_fmode),
+				   &gf.gf_fmode, sizeof(gf.gf_fmode)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_numsrc),
+				   &gf.gf_numsrc, sizeof(gf.gf_numsrc)))
 		return -EFAULT;
 	return 0;
 }
 
 static int do_ip_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
+			    sockptr_t optval, sockptr_t optlen)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	bool needs_rtnl = getsockopt_needs_rtnl(optname);
@@ -1533,7 +1536,7 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	if (ip_mroute_opt(optname))
 		return ip_mroute_getsockopt(sk, optname, optval, optlen);
 
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1558,15 +1561,17 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			       inet_opt->opt.optlen);
 		release_sock(sk);
 
-		if (opt->optlen == 0)
-			return put_user(0, optlen);
+		if (opt->optlen == 0) {
+			len = 0;
+			return copy_to_sockptr(optlen, &len, sizeof(int));
+		}
 
 		ip_options_undo(opt);
 
 		len = min_t(unsigned int, len, opt->optlen);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, opt->__data, len))
+		if (copy_to_sockptr(optval, opt->__data, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -1657,9 +1662,9 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		addr.s_addr = inet->mc_addr;
 		release_sock(sk);
 
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &addr, len))
+		if (copy_to_sockptr(optval, &addr, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -1671,12 +1676,11 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			err = -EINVAL;
 			goto out;
 		}
-		if (copy_from_user(&msf, optval, IP_MSFILTER_SIZE(0))) {
+		if (copy_from_sockptr(&msf, optval, IP_MSFILTER_SIZE(0))) {
 			err = -EFAULT;
 			goto out;
 		}
-		err = ip_mc_msfget(sk, &msf,
-				   (struct ip_msfilter __user *)optval, optlen);
+		err = ip_mc_msfget(sk, &msf, optval, optlen);
 		goto out;
 	}
 	case MCAST_MSFILTER:
@@ -1698,8 +1702,13 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		if (sk->sk_type != SOCK_STREAM)
 			return -ENOPROTOOPT;
 
-		msg.msg_control_is_user = true;
-		msg.msg_control_user = optval;
+		if (optval.is_kernel) {
+			msg.msg_control_is_user = false;
+			msg.msg_control = optval.kernel;
+		} else {
+			msg.msg_control_is_user = true;
+			msg.msg_control_user = optval.user;
+		}
 		msg.msg_controllen = len;
 		msg.msg_flags = in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
 
@@ -1720,7 +1729,7 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
 		}
 		len -= msg.msg_controllen;
-		return put_user(len, optlen);
+		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
 	case IP_FREEBIND:
 		val = inet->freebind;
@@ -1743,15 +1752,15 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
 		unsigned char ucval = (unsigned char)val;
 		len = 1;
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &ucval, 1))
+		if (copy_to_sockptr(optval, &ucval, 1))
 			return -EFAULT;
 	} else {
 		len = min_t(unsigned int, sizeof(int), len);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &val, len))
+		if (copy_to_sockptr(optval, &val, len))
 			return -EFAULT;
 	}
 	return 0;
@@ -1768,7 +1777,8 @@ int ip_getsockopt(struct sock *sk, int level,
 {
 	int err;
 
-	err = do_ip_getsockopt(sk, level, optname, optval, optlen);
+	err = do_ip_getsockopt(sk, level, optname,
+			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
 
 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index be1976536f1c0..cdc0a1781fd28 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1540,7 +1540,8 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 }
 
 /* Getsock opt support for the multicast routing system. */
-int ip_mroute_getsockopt(struct sock *sk, int optname, char __user *optval, int __user *optlen)
+int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
+			 sockptr_t optlen)
 {
 	int olr;
 	int val;
@@ -1571,14 +1572,14 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, char __user *optval, int
 		return -ENOPROTOOPT;
 	}
 
-	if (get_user(olr, optlen))
+	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
 	olr = min_t(unsigned int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
-	if (put_user(olr, optlen))
+	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
-	if (copy_to_user(optval, &val, olr))
+	if (copy_to_sockptr(optval, &val, olr))
 		return -EFAULT;
 	return 0;
 }
-- 
2.43.0


