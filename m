Return-Path: <linux-kernel+bounces-114204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB6F888914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D66DB251E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398B24EDA0;
	Sun, 24 Mar 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTk3DAYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33E2081C7;
	Sun, 24 Mar 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321537; cv=none; b=rGGyTA5ZONw3CHvqdOVryjMzC3RWrPnVwHSt9bc6YqyksF4cYMyBV7WShV0l+5nDJE4A1nabyXkyQE2/xPY4EYTXh0OglZhgBF7sRS2VjB4CTGM5BfSYZGVSSzi9NV2jxYbxbWNXAOxTpvSWRPO8kEgNKPHTZ88CXb30gsZNTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321537; c=relaxed/simple;
	bh=7r+hqqR9aWBYbXhY4GOQIVpSC4uVIjfUGAu/CsCryA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3Q21ovRbOO5wtuODxJHeRWvfqDb44YHzI6UHXCFG1+1AqAO31wdV+n1ylHX9d0RLSoX1cLt7eFbST6YP87x8bsQbCty9Nwd977wzg+/R27LxpUTM+WlMtiHhgr3RZcwhEd2w3haFrcbhv1QhRnkFeJYSq519B6pT0JxxlI37Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTk3DAYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35464C433A6;
	Sun, 24 Mar 2024 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321535;
	bh=7r+hqqR9aWBYbXhY4GOQIVpSC4uVIjfUGAu/CsCryA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTk3DAYf5KgEJOhVfxQgPe+P0TnYBZihB1lNqAwIAD+FNZc5/68MV4z2RfQVK5inF
	 8dhhV0H2t2saPYxlyILm3Klxr3tmAelw28CypUKrC6pi+YN+Ma762TR3Py0UsERTPz
	 ZAXpeNRefOWBiufBXaHYFvam+aFoOwj8LCeiwV/zrJMU+2ahZbFUQDaPOjR57OToPI
	 0rc2sIDe7RImOgafB3NnSAjxLdUZRT0ojHDWws+iev8Th33CbXfKATrpAmBoU4EcqT
	 ntfIeITwXuVFfSF+3ccePXDs1jDYks3FQEX3hjy34Ez/y4foi1xYYHuqdUJY1GT+uY
	 BU46WwyWp7p5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Jian Zhang <zhangjian.3032@bytedance.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 263/638] net: mctp: copy skb ext data when fragmenting
Date: Sun, 24 Mar 2024 18:55:00 -0400
Message-ID: <20240324230116.1348576-264-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 011d69029112a..60876262b3fb3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6659,6 +6659,14 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
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


