Return-Path: <linux-kernel+bounces-115318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F08893F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EF4B29124
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BA7FBC4;
	Mon, 25 Mar 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRL6akHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550C80C00;
	Sun, 24 Mar 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320514; cv=none; b=fQfS5fui8YtwwLiLPb4eKkx9/Wk6oMhiP8F+0jxSni1Rakdgd3LEsQhc80FHzEK8BZuzYqDL4EUD50OcEf1wzuFCI8uXuZiblqCIzGBbemGbbZ9k78qH01TVxzUJnZpds0S4240/JCtzj/8CvaUSE7DFy2kgkkSV1MBxQgPWYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320514; c=relaxed/simple;
	bh=O9V6/TN435gODXHOlwJPy0OeVZD6dXtAzOUmJleT3mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzAMKD+ufvwcWbIxkQs3uY4rjV+BqZTYshoIh/62FbA4s4yi2KcSy69Z8mzDy4wXQpnig3n2EFAWncPooRhLXqPPRvV9i1aIp1Wav5RGasktu9Ij4CaANv4VmI++Wlvo6BC9IRX0bazY8vBz+du7LYWUHqpsH8CB2kSmRaj6TSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRL6akHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CECC43394;
	Sun, 24 Mar 2024 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320514;
	bh=O9V6/TN435gODXHOlwJPy0OeVZD6dXtAzOUmJleT3mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRL6akHwTf0eHYDm0T8Oof6S+hsD2PIl5EWYA1CQrbaaIc5QcCeD7O6SFTlR3NNJS
	 QvJW01Y7WnsETqaeEuM2e8jC8HdAcTVB4nP9GCBaqLrpntqNScCxcpPVu9nBud6+fn
	 /puFVIbm89nowG341m0vuRLnHFTHOtONWuAklp5YctEFkmUysypi4smYeyZZhZxLT8
	 NgR3CVakmlJ87pEqU8Yxd6Z64YJrwjFrS7bSDVV2ISFFLSrkZvxrQ4I3bVxaefQkYf
	 B3Z64Fhm+mxnCvHQ3LtQNiEPompe58Ks/CdDaOYTi2IRlMppF1L/jFSuFA22yPJpt4
	 ghoIVNCnidnZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 075/713] xfrm: fix xfrm child route lookup for packet offload
Date: Sun, 24 Mar 2024 18:36:41 -0400
Message-ID: <20240324224720.1345309-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index e69d588caa0c6..9c5f2efed3333 100644
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


