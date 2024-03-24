Return-Path: <linux-kernel+bounces-113735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B0888FED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74497B2534B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CCF1EC62B;
	Sun, 24 Mar 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msp3UF/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE91DF10B;
	Sun, 24 Mar 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320745; cv=none; b=SA4biUFs3v4uzUJBSU8hI2WVDZX4Kfw2JLQHoYuW/x7a6wb4Ng2knGCGZfmIw5ddVtYQv9WEJnxC1upMtmvP8NtkVwUnmMWX1GBA9IHueykX+3kNv2VrzIOnfLHBHwX2yVcU42+TuWrV/9ROGcnWMw/JB9cULrLicCNtPJPoJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320745; c=relaxed/simple;
	bh=dnKtJv9o0MbAL+MDMRs+y5NYGE3Zb6APtJ9KUpq6zsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbn5w9v9Tx9b9bcgfJMi/PXre+ryvgK1UD5aVAdI54p4GIl2m3vAna+mFct41w/IAnaGcQQvXq9fxZzG8SGMVAeLIIePijNg4EK1FhCx/FDiSFtNi7SnxzqH7m2q2Zn3tEbFpkFvH2Hm+2/hYYh3SFq5zZwcPl8b6Jp5Rih+cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msp3UF/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3477C43394;
	Sun, 24 Mar 2024 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320744;
	bh=dnKtJv9o0MbAL+MDMRs+y5NYGE3Zb6APtJ9KUpq6zsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msp3UF/tbr7HuK5GsxFu4rEXCxZdYGSiapU2mo1g1hmFIaxTHapXeGfBEllxrpkPi
	 2tfjuwUa+0P+O3zLNO8GGbB7ocbUL/JZ8IelmkFJY6Zi1M1IBE82ts+fkp/7sw29K/
	 IqExkl9pi41ge5D+sFc3v7Ydthk4q0mfs0hibITlO5fBE0WQM7p4KxmyRJarAQNJb2
	 1/sF4pFJ/9lehqrpC4Uy8jVq8zQm0XWvlqyt01ZIEIpXvQqLSA7IlKr6zZ6iJS8py4
	 6GEZ5sc4xeWgIyHtRoXjhh5cdOwkcxH7pUHtCXcE0OXzKLYoyuALi3rcQPQISN/ksr
	 EoKJItn65UMkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Jian Zhang <zhangjian.3032@bytedance.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 308/713] net: mctp: copy skb ext data when fragmenting
Date: Sun, 24 Mar 2024 18:40:34 -0400
Message-ID: <20240324224720.1345309-309-sashal@kernel.org>
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

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit 1394c1dec1c619a46867ed32791a29695372bff8 ]

If we're fragmenting on local output, the original packet may contain
ext data for the MCTP flows. We'll want this in the resulting fragment
skbs too.

So, do a skb_ext_copy() in the fragmentation path, and implement the
MCTP-specific parts of an ext copy operation.

Fixes: 67737c457281 ("mctp: Pass flow data & flow release events to drivers")
Reported-by: Jian Zhang <zhangjian.3032@bytedance.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 8 ++++++++
 net/mctp/route.c  | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 94cc40a6f7975..78cb3304fb353 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6676,6 +6676,14 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 		for (i = 0; i < sp->len; i++)
 			xfrm_state_hold(sp->xvec[i]);
 	}
+#endif
+#ifdef CONFIG_MCTP_FLOWS
+	if (old_active & (1 << SKB_EXT_MCTP)) {
+		struct mctp_flow *flow = skb_ext_get_ptr(old, SKB_EXT_MCTP);
+
+		if (flow->key)
+			refcount_inc(&flow->key->refs);
+	}
 #endif
 	__skb_ext_put(old);
 	return new;
diff --git a/net/mctp/route.c b/net/mctp/route.c
index ceee44ea09d97..01c530dbc1a65 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -843,6 +843,9 @@ static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
 		/* copy message payload */
 		skb_copy_bits(skb, pos, skb_transport_header(skb2), size);
 
+		/* we need to copy the extensions, for MCTP flow data */
+		skb_ext_copy(skb2, skb);
+
 		/* do route */
 		rc = rt->output(rt, skb2);
 		if (rc)
-- 
2.43.0


