Return-Path: <linux-kernel+bounces-99383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699587879A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6782285CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003759155;
	Mon, 11 Mar 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv8irJzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018C58AA6;
	Mon, 11 Mar 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182224; cv=none; b=hegDgh+sRn94bqRhKYUu/1FPK/vVXWx5nSlvjUIHIOvy11Bpayn/IuhhpACpQkkAMcz7K/ZQSX5B3VmPUIoOc7q7pO1RU0t1yboeYzpPJ2NzOdr66kXuDm4rqy/rvEfxNcxUoEr9Y/B37g6SayHmTN0GTUNAfByWBJofYywPPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182224; c=relaxed/simple;
	bh=6XEEDqdkY65lGlx6HiiOD0G5ChxNS9thJ7xpJUYHhH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxfQ6j+O+vTtHBfxtotmSXn4AUer+6fNOruF6iWpws53zzWhov8RSSfTC6IulCDfeIosUAzLvt9v0RL4YKab8KhDfKW7CeMdVxqQbIbiQuoXDRhldt4YISqeDh/JVd66V4BHWqTYJUCw+yAvGU/CzrqjwxQlmVOgxVxEZPPm8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv8irJzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA240C43394;
	Mon, 11 Mar 2024 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182224;
	bh=6XEEDqdkY65lGlx6HiiOD0G5ChxNS9thJ7xpJUYHhH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kv8irJzHWX1fqYtUM4wNqihr0rGEj1Ln/fNu6mENwt4vYTp6Ae7CRQFTZTg4n7Sia
	 F/4azAynlBmM8HXPyiGydfbRYdNbqAwwI2B8iiW9QI8Mt95Q2xBZ8OO5hzwOEnS+UF
	 nD7ZtrQ+5PbWJdlPWLdqOwzTlkN7OJhPT1nKSBx0iqMx5y+oN99gPSd5ctFG6wlDjC
	 GVT50WpdnyLQN07h4WEka6CdWOu11wdUjaWbRg4xirhft40xsIimZYgxr+Ie3KUUE6
	 iDWfw7M5pdRhOaOLfjelIGpq9wz4xPmCXv8SHlTTh9qP9YJQQUdrtqcoN6l0SRwDj9
	 +pEQM9hejn2QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/14] xfrm: fix xfrm child route lookup for packet offload
Date: Mon, 11 Mar 2024 14:36:12 -0400
Message-ID: <20240311183618.327694-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Mike Yu <yumike@google.com>

[ Upstream commit d4872d70fc6feabfc8e897edad993a81096ade9f ]

In current code, xfrm_bundle_create() always uses the matched
SA's family type to look up a xfrm child route for the skb.
The route returned by xfrm_dst_lookup() will eventually be
used in xfrm_output_resume() (skb_dst(skb)->ops->local_out()).

If packet offload is used, the above behavior can lead to
calling ip_local_out() for an IPv6 packet or calling
ip6_local_out() for an IPv4 packet, which is likely to fail.

This change fixes the behavior by checking if the matched SA
has packet offload enabled. If not, keep the same behavior;
if yes, use the matched SP's family type for the lookup.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef79107..3c666dee04fcf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2694,7 +2694,9 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
 				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
-			family = xfrm[i]->props.family;
+			if (xfrm[i]->xso.type != XFRM_DEV_OFFLOAD_PACKET)
+				family = xfrm[i]->props.family;
+
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
 			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
 					      &saddr, &daddr, family, mark);
-- 
2.43.0


