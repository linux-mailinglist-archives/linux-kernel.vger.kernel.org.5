Return-Path: <linux-kernel+bounces-99395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77658787CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A8A283121
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211245F847;
	Mon, 11 Mar 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5kP+Xiz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C25F554;
	Mon, 11 Mar 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182285; cv=none; b=EEmBIJV4KTi2mFpoOExTB7dnR7xjw2JmLjsTZcob4ICxiDPBhqZIRaylVdGsZci4LyBJHiy7jHDqgAsqDK+p+ywU+1DJ1ApSlJVtCFDf14PEuaDcCejFAHiq0PWyVbvCK/ZvVBiT6BjAuMnemBbkA4ppdYB5eabHd+Tg+OijZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182285; c=relaxed/simple;
	bh=5CPxsw81z44H+28IB3BVZsy+NDRz7gWFJc1ZSn5OheM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRHIWtcrHcwqGNpa/SbODlV1JDo/5phZu8uAadTujDdZZOvjeDfQWeGsmA03auRYe+K0Rp+9FBA1G7AoBIqeCHA3nhAHVWJW0I0CP7kpv7gIeCDRo5fD8xLHgTzRYtgumUyLNHgtCB06YBUZj9+qmT11ycNrkW5M0GtQxXtqhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5kP+Xiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC98C433F1;
	Mon, 11 Mar 2024 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182285;
	bh=5CPxsw81z44H+28IB3BVZsy+NDRz7gWFJc1ZSn5OheM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5kP+XiznyMyvRiCekSUJaK9RPBQNiFd3N9uwaiXyHJJJdc+/eO+W5loQUFBcXZ+o
	 5g9YNfzTa/T/OGdtkkMZ+2IlQtDzyo8jbU/J5SeY4qWj4FKe/30HBKOY2XVD4wn9rK
	 tpsZn5PTYhJPWFjcp2fDvq8NxZybOLWH+GxwuUAXQZTqHRXvfMP8hTG9RGbkMhFYnP
	 0TvMo4oS5Nrd+KXl3GFxcfrvEr8c4+12GlTSmMwdI329y7BITs8yI88FVDEJjrH7kY
	 z/EqEP7C0/IV28bSPAOAn1SOypRxYhmIgmT/mkR26pTIY54EUmW6XAPMGbam95BIIQ
	 y5toZ2R0AF5fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/12] xfrm: fix xfrm child route lookup for packet offload
Date: Mon, 11 Mar 2024 14:37:21 -0400
Message-ID: <20240311183727.328187-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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
index d24b4d4f620ea..97d69ec54ff9c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2679,7 +2679,9 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
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


