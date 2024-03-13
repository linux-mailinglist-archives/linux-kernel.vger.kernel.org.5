Return-Path: <linux-kernel+bounces-101812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2F87ABD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D45B24F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2F5DF27;
	Wed, 13 Mar 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzRAJaP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9DA5D757;
	Wed, 13 Mar 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347842; cv=none; b=RLJuqFE8LbXTiBOoZfMMqyF9/cvLV3VMri1yoy6UcsSXmBdhYzEk4mveXn9ND3ezpIUWzIvl9EgcQnynkpCT2vswC2xx/CFslsCenl1l8Vmhi2R9RFebq0CgKywLCAelxZsswWJ6RaE8PuJweb6nnmhzH2KPei39hRuz1dS1/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347842; c=relaxed/simple;
	bh=mER1yfa1dH9o/9mw+NAa4OwuQlcgdGWtxZnPh2QN7k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bguRyvdeUm9wHM2oWj5jz8ke6UpRG3IWh5W6EjoBM0a115/6O4ZX1MlIJDLiUuy5jKM9DMLz6b0BlCiWtcDPcHgHh/3HXWt8Isxqh/4SeCDflgsIgcYzYEMaPnTy+sEsw95S4zSF5wF26SCwOVkjqrppsLKVaSFMek3vN95tkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzRAJaP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400BEC433F1;
	Wed, 13 Mar 2024 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347842;
	bh=mER1yfa1dH9o/9mw+NAa4OwuQlcgdGWtxZnPh2QN7k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzRAJaP681MEuBSvoIfGJzD1SjNOWL2hrpit8wzSkpbMYw8VtMd47LkngvMAk59Gt
	 L6+ZQ55+IrqSfOGEvEPYKqjvxH88aeNGiCnn1gV9UzlOs7dQTcTTSHGnTx5W/3to2h
	 kN4f5i15V7WYXoA0lxQyk3bHVlNVklLAOAZBWQbvYKMi3UM/3wiffr27zQgWjPha64
	 DzrJkES0UPGqfqD0ZwKzckN4TP6+gnT8+l0qg3irMTbIuHqWhcI7w4zOclPB/vGCt/
	 3m9ZIDWWPoPlGCAvOcgui0fe8weiznLMwCYTXa9bAfMW1ndg1rtTsLZM2wvtQW6QdN
	 KcCfYkL0eJThw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Mike Yu <yumike@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 09/60] xfrm: Pass UDP encapsulation in TX packet offload
Date: Wed, 13 Mar 2024 12:36:16 -0400
Message-ID: <20240313163707.615000-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 983a73da1f996faee9997149eb05b12fa7bd8cbf ]

In addition to citied commit in Fixes line, allow UDP encapsulation in
TX path too.

Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
CC: Steffen Klassert <steffen.klassert@secunet.com>
Reported-by: Mike Yu <yumike@google.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 3784534c91855..653e51ae39648 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload || x->encap)
+	if (!x->type_offload)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.43.0


