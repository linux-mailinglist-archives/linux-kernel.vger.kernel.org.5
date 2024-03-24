Return-Path: <linux-kernel+bounces-115908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2CC889897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C05E1C31A79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7838893A;
	Mon, 25 Mar 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpvolXkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F001474CE;
	Sun, 24 Mar 2024 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322097; cv=none; b=Fq+F2S9BV5gUsVMWtHmVcN1deoTLZ47hQ+o5++dkl8UYG4jGV2WHiv/H+CDSjPatBvYB5N4HxxRwW4Ek1GDIVJUi/HzKSxlZLPsZXNSzGOgnjL1zhyaIY1LzKFnvogV9hio3nSvnLVy/w/gSZrrYzuVFFJWFCVsT+vxrZgIGJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322097; c=relaxed/simple;
	bh=L8+OyzxkHOvk3tcBoqBAuAXpIEzLwMUIv9/BEeN180I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq4J9RzgkWmhEMBETg6CnNpXFlFDbCUbtDXsYIHVZC5FbkPBpVyXnI99syt/uY9PdzkL88BAinpPlEZzKj6tNVymWq85F7sVYnxJaNR4q3+xiXzPYCE/uKhkil+VCzQ2ewiDVosQVs8TiVA3SPcfoLr/atFyE5jKCN3t9mtxR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpvolXkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0589DC43394;
	Sun, 24 Mar 2024 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322097;
	bh=L8+OyzxkHOvk3tcBoqBAuAXpIEzLwMUIv9/BEeN180I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpvolXklESfNLxMOFDPO0JSbjy5nK27Tl/iGcyjP6MkenQzesTxaLB4JoCgdDmmb5
	 k4GKLgNmyJ05DUijS9EoMw1xE67ecT4QF9k1sUVpFRrMHNdaIXquBn+O5vRjXd26/F
	 l14bK8X1ZN8eHdFEo7Q6gpaIEuXb/hEYMjV0DCjVUOZZ2Fr4AKEMzj6u6xxMX2aQ0a
	 AWYdSPU6bhQ+CX3qLGX8C9bCnCxN70s+e2evyVKdrpy5iK98/Zm7QCLqCjBY7ZOOE/
	 3Bfz78iBAYg7GqjK6TECIBBuhNIfRV4gMczQhVt8+UGcOS/MgP2HrG9oCWFL0HWiYL
	 6ywKE25cB8sOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Jian Zhang <zhangjian.3032@bytedance.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 172/451] net: mctp: copy skb ext data when fragmenting
Date: Sun, 24 Mar 2024 19:07:28 -0400
Message-ID: <20240324231207.1351418-173-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index d4bd10f8723df..e38a4c7449f62 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6500,6 +6500,14 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
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
index 0144d8ebdaefb..05ab4fddc82e9 100644
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


