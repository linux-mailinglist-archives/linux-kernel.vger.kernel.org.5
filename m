Return-Path: <linux-kernel+bounces-114987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E2888C61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172C91F28D88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543F2E359E;
	Mon, 25 Mar 2024 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGjUcDrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710217AFA0;
	Sun, 24 Mar 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323730; cv=none; b=U4StVO5Yvb6knniiwZP7ZLDaPNG8UBpdhW/XfFOhqX2MdCPLJkeIf3viAB+9LaQ3sptgn+uUT78cUIvJB/pLLdUw3knqbZJXM57gKWjMVWQntM+P6bJmmagC9P7v1A6Mye6msLU9jOamspoDxbpvXYOsNqDknZcUbywsOXtcHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323730; c=relaxed/simple;
	bh=04JXsG15q47bxJ2l1x5tF5lHZqAY//KUUy2ZJRWCw7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmhxVGN1X9w6x5yDKK6t3xtWF0a1lLU2su8JxbkXUvNRHVraMcd+f4zakPvc6HNETF4c5uXyevhCKGHY0PPigyoiR0xcrqEp/MHWVI9r4xHXKXcal2ee9wPvllWHBY4rls7NQ/sjMunSBhw/zf7Ls8D1KdFQO7dGUhcVNr0+R+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGjUcDrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3730AC433A6;
	Sun, 24 Mar 2024 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323728;
	bh=04JXsG15q47bxJ2l1x5tF5lHZqAY//KUUy2ZJRWCw7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGjUcDrDQ3f+UA+7wHqKnyCJR+wyZtn4MljbNsO6O/gzyBarlz4/0XLTLWd//kLRV
	 M4TWR3BNnNoMNGYmAXFxPc+DlRw6u/7dY7e9RAu12p6xLqn1pctG3ARgZkjjsnkHJM
	 Ef4y4jSIXlxq+/AhesBNp5vWaj6rtg+Ybv6cQFo9wtKgXhnbWEPzPqTSgIEfEvl/5q
	 wW7YBSx+hlt/CxcdjozWormtC4B2P3VgYxhqC11Jcgya1BBBOceoux2QYE7zNE1/kc
	 ZUDNFraeHnnExphJwCuCsTTf9TX6Fj5WRF/pFleb6gq4pwxanH1+YCmSNRAPJZg+tm
	 oPUmSPqDoZZAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 102/238] net/ipv4: Revert use of struct_size() helper
Date: Sun, 24 Mar 2024 19:38:10 -0400
Message-ID: <20240324234027.1354210-103-sashal@kernel.org>
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

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 4167a960574fcadc9067f4280951a35b8c021c68 ]

Revert the use of structr_size() and stay with IP_MSFILTER_SIZE() for
now, as in this case, the size of struct ip_msfilter didn't change with
the addition of the flexible array imsf_slist_flex[]. So, if we use
struct_size() we will be allocating and calculating the size of
struct ip_msfilter with one too many items for imsf_slist_flex[].

We might use struct_size() in the future, but for now let's stay
with IP_MSFILTER_SIZE().

Fixes: 2d3e5caf96b9 ("net/ipv4: Replace one-element array with flexible-array member")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5c3be3e0eb44 ("ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/igmp.c        |  4 ++--
 net/ipv4/ip_sockglue.c | 12 +++++-------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 134f1682a7e9b..4ba1c92fb3524 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2573,8 +2573,8 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 	copycount = count < msf->imsf_numsrc ? count : msf->imsf_numsrc;
 	len = flex_array_size(psl, sl_addr, copycount);
 	msf->imsf_numsrc = count;
-	if (put_user(struct_size(optval, imsf_slist_flex, copycount), optlen) ||
-	    copy_to_user(optval, msf, struct_size(optval, imsf_slist_flex, 0))) {
+	if (put_user(IP_MSFILTER_SIZE(copycount), optlen) ||
+	    copy_to_user(optval, msf, IP_MSFILTER_SIZE(0))) {
 		return -EFAULT;
 	}
 	if (len &&
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 2cfc507712300..28b9b2e85f0be 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -674,7 +674,7 @@ static int set_mcast_msfilter(struct sock *sk, int ifindex,
 	struct sockaddr_in *psin;
 	int err, i;
 
-	msf = kmalloc(struct_size(msf, imsf_slist_flex, numsrc), GFP_KERNEL);
+	msf = kmalloc(IP_MSFILTER_SIZE(numsrc), GFP_KERNEL);
 	if (!msf)
 		return -ENOBUFS;
 
@@ -1235,7 +1235,7 @@ static int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	{
 		struct ip_msfilter *msf;
 
-		if (optlen < struct_size(msf, imsf_slist_flex, 0))
+		if (optlen < IP_MSFILTER_SIZE(0))
 			goto e_inval;
 		if (optlen > READ_ONCE(sysctl_optmem_max)) {
 			err = -ENOBUFS;
@@ -1253,8 +1253,7 @@ static int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			err = -ENOBUFS;
 			break;
 		}
-		if (struct_size(msf, imsf_slist_flex, msf->imsf_numsrc) >
-		    optlen) {
+		if (IP_MSFILTER_SIZE(msf->imsf_numsrc) > optlen) {
 			kfree(msf);
 			err = -EINVAL;
 			break;
@@ -1667,12 +1666,11 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	{
 		struct ip_msfilter msf;
 
-		if (len < struct_size(&msf, imsf_slist_flex, 0)) {
+		if (len < IP_MSFILTER_SIZE(0)) {
 			err = -EINVAL;
 			goto out;
 		}
-		if (copy_from_user(&msf, optval,
-				   struct_size(&msf, imsf_slist_flex, 0))) {
+		if (copy_from_user(&msf, optval, IP_MSFILTER_SIZE(0))) {
 			err = -EFAULT;
 			goto out;
 		}
-- 
2.43.0


