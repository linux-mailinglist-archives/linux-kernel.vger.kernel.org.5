Return-Path: <linux-kernel+bounces-116159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C98899D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E221D29E4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E93B3611;
	Mon, 25 Mar 2024 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5E64E31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278517B50D;
	Sun, 24 Mar 2024 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323728; cv=none; b=M0rrTVere2km7xoNkLiCYWfr6MZWwFRhD9/UKqEK8nzgRdWcGqyOxKt+kLdW0OW/dmqREqARgi9vucuHcP1+RtdjE992U4Xwk43utLw3mEc3RttM1zQvJMkBt1mbFENPnpsaPt/DY8reUW5wvJUXFekIS6WF6Emc2iX7XdepsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323728; c=relaxed/simple;
	bh=PdOvL4VS4V6WgvoHtkQ6c36uNe2suX72HRehuZnE9xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbdiCplNd6euXu78qBSCC4cRCInYMEOINq7D3MIc2uXPARPH3sxfUHTRc8oahkkDrecWSiFFBEeEWw7BxBliirKIpKBm5yMbQBR50udn3G6nAzmA98hpGY7IbDWuTRMZIac9gvu8mYhFJrOx6OP+uGRlrCZwnMvy2CvVczI+m0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5E64E31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50258C433B1;
	Sun, 24 Mar 2024 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323727;
	bh=PdOvL4VS4V6WgvoHtkQ6c36uNe2suX72HRehuZnE9xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5E64E31SVKICn5rmCMk3qlVbOsRa4JppEOcuR7+Hj5VXqqMvrHTi3cl7mXh3Ij7r
	 Z5U75Bh4QP3dITvYnloVnj7zuyccVxwQCBQDBx+ofbU6Pe7SxwwYPVumCvREIQGYBT
	 2I7hVjFzh8SZgIqW0mHwGTnhftW6vur610t4X3y7Mk0FyNWEi/gY5d8bEzMvChIZBY
	 1xCrkMfhc0QDxSNeZxTN0fHsywAF51JDolEePN6cnXSNcK9t9Af6jGgCe7DtJj6GuS
	 uxleg9Qs3I+OlNY+S5B8cVNC6BjEoyDmmwWuONMXa3LLhksB8nMj6TQA/og+q8J+E1
	 zeMceUCBs/MeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 101/238] net/ipv4: Replace one-element array with flexible-array member
Date: Sun, 24 Mar 2024 19:38:09 -0400
Message-ID: <20240324234027.1354210-102-sashal@kernel.org>
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

[ Upstream commit 2d3e5caf96b9449af951e63476657acd759c1a30 ]

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use an anonymous union with a couple of anonymous structs in order to
keep userspace unchanged:

$ pahole -C ip_msfilter net/ipv4/ip_sockglue.o
struct ip_msfilter {
	union {
		struct {
			__be32     imsf_multiaddr_aux;   /*     0     4 */
			__be32     imsf_interface_aux;   /*     4     4 */
			__u32      imsf_fmode_aux;       /*     8     4 */
			__u32      imsf_numsrc_aux;      /*    12     4 */
			__be32     imsf_slist[1];        /*    16     4 */
		};                                       /*     0    20 */
		struct {
			__be32     imsf_multiaddr;       /*     0     4 */
			__be32     imsf_interface;       /*     4     4 */
			__u32      imsf_fmode;           /*     8     4 */
			__u32      imsf_numsrc;          /*    12     4 */
			__be32     imsf_slist_flex[0];   /*    16     0 */
		};                                       /*     0    16 */
	};                                               /*     0    20 */

	/* size: 20, cachelines: 1, members: 1 */
	/* last cacheline: 20 bytes */
};

Also, refactor the code accordingly and make use of the struct_size()
and flex_array_size() helpers.

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
 include/uapi/linux/in.h | 21 ++++++++++++++++-----
 net/ipv4/igmp.c         | 12 ++++++------
 net/ipv4/ip_sockglue.c  | 15 ++++++++-------
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 3960bc3da6b30..066098a5b9360 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -190,11 +190,22 @@ struct ip_mreq_source {
 };
 
 struct ip_msfilter {
-	__be32		imsf_multiaddr;
-	__be32		imsf_interface;
-	__u32		imsf_fmode;
-	__u32		imsf_numsrc;
-	__be32		imsf_slist[1];
+	union {
+		struct {
+			__be32		imsf_multiaddr_aux;
+			__be32		imsf_interface_aux;
+			__u32		imsf_fmode_aux;
+			__u32		imsf_numsrc_aux;
+			__be32		imsf_slist[1];
+		};
+		struct {
+			__be32		imsf_multiaddr;
+			__be32		imsf_interface;
+			__u32		imsf_fmode;
+			__u32		imsf_numsrc;
+			__be32		imsf_slist_flex[];
+		};
+	};
 };
 
 #define IP_MSFILTER_SIZE(numsrc) \
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index cb55fede03c04..134f1682a7e9b 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2493,8 +2493,8 @@ int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
 			goto done;
 		}
 		newpsl->sl_max = newpsl->sl_count = msf->imsf_numsrc;
-		memcpy(newpsl->sl_addr, msf->imsf_slist,
-			msf->imsf_numsrc * sizeof(msf->imsf_slist[0]));
+		memcpy(newpsl->sl_addr, msf->imsf_slist_flex,
+		       flex_array_size(msf, imsf_slist_flex, msf->imsf_numsrc));
 		err = ip_mc_add_src(in_dev, &msf->imsf_multiaddr,
 			msf->imsf_fmode, newpsl->sl_count, newpsl->sl_addr, 0);
 		if (err) {
@@ -2571,14 +2571,14 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 		count = psl->sl_count;
 	}
 	copycount = count < msf->imsf_numsrc ? count : msf->imsf_numsrc;
-	len = copycount * sizeof(psl->sl_addr[0]);
+	len = flex_array_size(psl, sl_addr, copycount);
 	msf->imsf_numsrc = count;
-	if (put_user(IP_MSFILTER_SIZE(copycount), optlen) ||
-	    copy_to_user(optval, msf, IP_MSFILTER_SIZE(0))) {
+	if (put_user(struct_size(optval, imsf_slist_flex, copycount), optlen) ||
+	    copy_to_user(optval, msf, struct_size(optval, imsf_slist_flex, 0))) {
 		return -EFAULT;
 	}
 	if (len &&
-	    copy_to_user(&optval->imsf_slist[0], psl->sl_addr, len))
+	    copy_to_user(&optval->imsf_slist_flex[0], psl->sl_addr, len))
 		return -EFAULT;
 	return 0;
 done:
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 1b35afd326b8d..2cfc507712300 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -670,12 +670,11 @@ static int set_mcast_msfilter(struct sock *sk, int ifindex,
 			      struct sockaddr_storage *group,
 			      struct sockaddr_storage *list)
 {
-	int msize = IP_MSFILTER_SIZE(numsrc);
 	struct ip_msfilter *msf;
 	struct sockaddr_in *psin;
 	int err, i;
 
-	msf = kmalloc(msize, GFP_KERNEL);
+	msf = kmalloc(struct_size(msf, imsf_slist_flex, numsrc), GFP_KERNEL);
 	if (!msf)
 		return -ENOBUFS;
 
@@ -691,7 +690,7 @@ static int set_mcast_msfilter(struct sock *sk, int ifindex,
 
 		if (psin->sin_family != AF_INET)
 			goto Eaddrnotavail;
-		msf->imsf_slist[i] = psin->sin_addr.s_addr;
+		msf->imsf_slist_flex[i] = psin->sin_addr.s_addr;
 	}
 	err = ip_mc_msfilter(sk, msf, ifindex);
 	kfree(msf);
@@ -1236,7 +1235,7 @@ static int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	{
 		struct ip_msfilter *msf;
 
-		if (optlen < IP_MSFILTER_SIZE(0))
+		if (optlen < struct_size(msf, imsf_slist_flex, 0))
 			goto e_inval;
 		if (optlen > READ_ONCE(sysctl_optmem_max)) {
 			err = -ENOBUFS;
@@ -1254,7 +1253,8 @@ static int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			err = -ENOBUFS;
 			break;
 		}
-		if (IP_MSFILTER_SIZE(msf->imsf_numsrc) > optlen) {
+		if (struct_size(msf, imsf_slist_flex, msf->imsf_numsrc) >
+		    optlen) {
 			kfree(msf);
 			err = -EINVAL;
 			break;
@@ -1667,11 +1667,12 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	{
 		struct ip_msfilter msf;
 
-		if (len < IP_MSFILTER_SIZE(0)) {
+		if (len < struct_size(&msf, imsf_slist_flex, 0)) {
 			err = -EINVAL;
 			goto out;
 		}
-		if (copy_from_user(&msf, optval, IP_MSFILTER_SIZE(0))) {
+		if (copy_from_user(&msf, optval,
+				   struct_size(&msf, imsf_slist_flex, 0))) {
 			err = -EFAULT;
 			goto out;
 		}
-- 
2.43.0


