Return-Path: <linux-kernel+bounces-113152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FC8881E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B481F216DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D62171E4E;
	Sun, 24 Mar 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUWSHjh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB117166F;
	Sun, 24 Mar 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319955; cv=none; b=bLfUAnZKwIBbmTKt6sOROtA+Gt96OeJmAlscExEaMjpCLbhJ1uyHQ3SkkLpCuLANSo7gfIBmlci9t4JnytIcSyTvvR3nzzW+Bu1wPunaaoU9AE7XoAuPv7z9Ip1ilWwWTX9CyPenazTACoOtVB5A++MXhGO0z5NJk49qnBeQAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319955; c=relaxed/simple;
	bh=983g+75i0F3kiQCRwasLkkri3umIsFUdvvOJTOdXjMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+VMo23CqJC2E4xSuyOO9gVAMqsQfxOXQbriD5UUUvP6Nq/xiGzPMMZg6kJpCFnxPiOeRToOzWOBTO8gC4gnp6nBNr0G/IQNf9tHXnrfi3Cm1oeysxnDL6vh9yo5nDz/UPIRAHI3ixQ42c2bAKRCg2p13NHRLvN6fiYubNA7/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUWSHjh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A2FC43390;
	Sun, 24 Mar 2024 22:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319954;
	bh=983g+75i0F3kiQCRwasLkkri3umIsFUdvvOJTOdXjMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUWSHjh1Ir4JtEewXa5YVzIwh5uKLbacbpyBSP6C9Fhv/usKFWjURQ4YBoKVESMUE
	 QJrDy5ysyJcMO939JQM6mfb43vpIUdKoRpcgumcoej8sRf1ck9LDth+xIaL2l6XGcL
	 oZfM/kma4Xn1a3mm/7FtnHW+24MSFWbPDxdJFdI+/oKO1GcYont4gYYinZuGkcR4jW
	 xu/GIPALrfRTx4D0yo3RZBxd6MMDWwmkZt6ZVpXO2imTlFo0tvAncvHxaADpZOXYW/
	 XDS4p1AjDtcsJbvtanI1JoGPB1UgwWXH3BN/qlUi3p5ufULP7T4HJ5CLvv/+rOm7GU
	 us5/Xas2dhaIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Jian Zhang <zhangjian.3032@bytedance.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 261/715] net: mctp: copy skb ext data when fragmenting
Date: Sun, 24 Mar 2024 18:27:20 -0400
Message-ID: <20240324223455.1342824-262-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index edbbef563d4d9..71dee435d549d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6736,6 +6736,14 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
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


