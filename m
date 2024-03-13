Return-Path: <linux-kernel+bounces-101748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AA87AB40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C251F2176D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE34C62B;
	Wed, 13 Mar 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFniQbpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B65914B;
	Wed, 13 Mar 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347570; cv=none; b=FSU6Mv/7G7J595dozJOYzQP+bHcG/Y8trS1Tb8zFlLYayWeW5iQQTJ6nsrTlRpzncYoXXIqyk8iPhfvIHNlWoE5roG00IJBgCFwyVwl6BO9nDLlCstoUfsLbk6xswpipgzSMmxJggZ5H3cenR4KtXeP0VXytdXiJtDCfy8bV688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347570; c=relaxed/simple;
	bh=mER1yfa1dH9o/9mw+NAa4OwuQlcgdGWtxZnPh2QN7k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H64VD8WqH8qFisSBOGJ9hiButr05T9+AjOiOUqHCvd/FRXuCaGHnMqwSPG+JBRLO3yCjwO3d3SZl1tOA5fx2PhMRwJuB+rMtYRrvrqeFmnWqdQQdjZWVgZBeA9pWlhQmcKHv3rL1Gurkm6g1vsFTbID6k7QsD5jpMSFLQ2N9kIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFniQbpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53B0C433F1;
	Wed, 13 Mar 2024 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347569;
	bh=mER1yfa1dH9o/9mw+NAa4OwuQlcgdGWtxZnPh2QN7k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFniQbpMy28SxrVYYCxhFkXOrTh3sFNnzgZI7d3H2qF8hpLEDHDFdLNtPlAYB/Ehs
	 vQe9Ov1Qj5Rc9gfSKg5oYISJMtUZ1XgtcxISIwH3P9a+j9znRg9gtX1B7YG6XSi5pS
	 X11+Pv1St36SydMMIhQ3mNy9QjsBanOTgzXAaiWvpWrDHRsjTuu4SF4TY5hZ8HkdRX
	 ozjuFbkFyFcSc2nJ2V9eaKtyOoqge6l7ooK2dPav4b4CfxBnR2w4X3NeOz4c+emup1
	 VnvIWgH9uCu56XYAGFU0hcA01q/tTmOOSE+LokeMFUU4qtaxrNj2rUlrAUgeQJeF+J
	 EBPk6Sx8xHDEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Mike Yu <yumike@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 09/61] xfrm: Pass UDP encapsulation in TX packet offload
Date: Wed, 13 Mar 2024 12:31:44 -0400
Message-ID: <20240313163236.613880-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


