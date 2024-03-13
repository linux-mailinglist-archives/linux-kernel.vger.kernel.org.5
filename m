Return-Path: <linux-kernel+bounces-102135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A487AEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA70B21304
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25B70CC8;
	Wed, 13 Mar 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpP7dDI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615670CA7;
	Wed, 13 Mar 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349352; cv=none; b=ua9ZJkeyrsDjXiw8XSllOzipUjU9OQO7XfezAccXj+SNgwOiIxytFUM5w23qsFUkkWHl/nWEHw/kS9/poD3RrjqGwHGMCy56DGTi7Y6P7Ok1R3ZZQl4UXIEcfl6Rn4GrPSIm86e+P+yHg8ufoQCj4xN5bdFtCzQG9eRtiHoVphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349352; c=relaxed/simple;
	bh=HUYOQZh7wqp8HnHVD3lHLRvny4DgdiUuaH1mbu/eXzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIrlq+4CZyUi0GsDMoleDI9rVNiuSnlfbknHtj53Q9H+jgxZ8QlqqZBvg72wSQmeeEzGVLvGfB/LRtAobKSxioCN3U5KoJBJ0ZnDAyg1PKhHqxIHIcty0DOetHl4e1cJNpXQtfC1h/PPnO8PaGnY3P6UHVeawOojNDiB+NZQfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpP7dDI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0C8C433F1;
	Wed, 13 Mar 2024 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349350;
	bh=HUYOQZh7wqp8HnHVD3lHLRvny4DgdiUuaH1mbu/eXzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpP7dDI+wvfhLAPe+qlcE/C4cfss1WnPIfK9qZNm+An1nQzE1z9VwhGOucY1c11qC
	 BP8pMpAZ5NxXRrjCWPoTtaEmGlO7nOkRpspjoi3jij2f55Cg9jTFcQLVBulnfAYZ9v
	 nnyFVJjDF8nfX+EaTnHJ2hEQzfOwnQTID6HWhlliO4PIGRvV6Rxls1oxTEoZpo1X7x
	 VcDI/O00lmFg6vWRA3XWYETKHMDGAyzbvPneWBAyKdXy21k+/NquUSSiED4Mb4QxLY
	 KpRwt+auvDdC19TgMMsSq9Aj3dooOT/Ma27DJ38js0JKUvi2LPGzmOzh6BKYM2nfrk
	 nNCiYuCVqQfnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 14/51] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 13:01:35 -0400
Message-ID: <20240313170212.616443-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit cfd9f4a740f772298308b2e6070d2c744fb5cf79 ]

We need to protect the reader reading the sysctl value
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b7be86d41d965..7859217249124 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -763,7 +763,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


