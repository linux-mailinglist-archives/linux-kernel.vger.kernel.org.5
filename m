Return-Path: <linux-kernel+bounces-102198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F387AF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139481F267E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD21509FC;
	Wed, 13 Mar 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM2r9NZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D41509DC;
	Wed, 13 Mar 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349493; cv=none; b=ZJI0BWZqU4KaQnBpnS7M2bvbJIoErShNyaBE7cmqnSgJoFN/4BwfnGTfGZFK0NcgfJziN0XlWBptBXqls9muOCGdjXBKo9IDNnWp6dOOHn8iXkqO7zvw6QiJnFptvBFIn8ZGmCweii08cD/q+Vc1p9dyZiMCfzhtcOkyIot/zI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349493; c=relaxed/simple;
	bh=KEoXA3QZ1u93FxZu44O9SkHaOFwzRsDovRJ+kK13oCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVoy3Oxy41HHWxyYncbRP/ztbfBmgZw3i1AXFVqE89UiVMOXaAmXbXBdU1KxOYrdLOlzqmXx2yqLnRgXo0ZcCklMj7oRzDotN+S5473uK4/dEV2H7nGGqy77eFB7bhObLk5k2ClIzdtHguqHFBMk2EMl9PFs+15F77QYh3xiVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM2r9NZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310E4C43390;
	Wed, 13 Mar 2024 17:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349492;
	bh=KEoXA3QZ1u93FxZu44O9SkHaOFwzRsDovRJ+kK13oCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MM2r9NZKHlpQiix1PUIYv2Afk5QTy6BFL25lH6NKpfVIPhJCZD7Ll0UBEsYr3t9ou
	 VdsLicFb4XZQHOL4mvEvjKb/I52HXQoppSXPoirRsAeizaonItgHdmHTPS1UqcqYp+
	 p9m2+cyi6XixFG/JXJOpbYCKPx6s+N6PStlRG7AIjgmlbhRhEzLNEsDSAG3laoECdH
	 km2Rl1WnJcBSIQzEbS1LIvfMqHMJEKV14kj4hW2oRffa8tsN6ggAGWpjaBXVB+yf6k
	 LYkrH0nffV2nMFIhSV2us77qy3ktNtQ3bdn1GVn7xfDDx96prTqgw/El5AxiMyRLH+
	 JiIjB1bTbCnvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/41] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 13:04:07 -0400
Message-ID: <20240313170435.616724-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index e3ce3531608c4..929446e246b36 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
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


