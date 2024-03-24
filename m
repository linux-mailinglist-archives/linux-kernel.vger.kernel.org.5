Return-Path: <linux-kernel+bounces-113563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA3888553
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97B32847A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE0B1C6AC8;
	Sun, 24 Mar 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFP7QoiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4A13E6DA;
	Sun, 24 Mar 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320365; cv=none; b=IGcLvPbqWOrH7LuhfhzX6KZxozF03yrIvxZ0N/6sGTeJX8sg0DEtphkxrDqk8DCyWqpRRZ4CdRmxHyf1GqoKZ4wmIG41TCtzMwOyMPeOLQh6sl83a1XoPlEsiIYOzZ+EDp08lS+/LI1RZdMZVEMw140wgvP2dsknYHIBoUyMNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320365; c=relaxed/simple;
	bh=IPQUPry+ITtcAdi3zYmL9JlqymXhYmP6surBfz44xq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2yzdBxXWqcUEUYt85N8Fu0o3/PVFMsib7lLqf6nYWSCVd8XMmd5+XzKkuv/OEmVNS6RYnrs2aPGwgz3n6HileTINzOPpnpn1LLGvkA3ZfbZ5cm3JCL4SKFgk3LunS8bouXkEPcmOsdtVu66feTCM1UktTgBYKXfaFYrZ9z1Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFP7QoiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5172C43394;
	Sun, 24 Mar 2024 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320365;
	bh=IPQUPry+ITtcAdi3zYmL9JlqymXhYmP6surBfz44xq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFP7QoiGcr51KOwOPNZZAUv0+pzkc5a7M3DA//+WXmLmdJUe/3TcBX9kHL/95kX/t
	 U2oCft87PkPm74/0fNL1yy0u3RlytrybrDt0abx9e4OnV0tXOeL7DD49+eIGQRIT1f
	 5xINV5T8+QE97rwUPWYjtBRVHitPqWm90kQpX8ufkCm//ls97aiHEE87zNfO6DMsEc
	 hqAo4V6TRwJ7+MeXiQ+dtrfweQxYut0rn7MWsNg0Iilbfh/9touvKh5lMUeVV4omMA
	 4TrKMPtDfbb2WXBIOHUtf4kj1BfLXG/P+o4UXEvv54FV4npI71VuPFxk7Gf3aAnj4+
	 NiuL5H3fn3vdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 672/715] xfrm: Allow UDP encapsulation only in offload modes
Date: Sun, 24 Mar 2024 18:34:11 -0400
Message-ID: <20240324223455.1342824-673-sashal@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 773bb766ca4a05bf363203030b72b10088869224 ]

The missing check of x->encap caused to the situation where GSO packets
were created with UDP encapsulation.

As a solution return the encap check for non-offloaded SA.

Fixes: 983a73da1f99 ("xfrm: Pass UDP encapsulation in TX packet offload")
Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae39648..6346690d5c699 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.43.0


