Return-Path: <linux-kernel+bounces-102209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19087AF72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9949628578B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FA1A00E5;
	Wed, 13 Mar 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgAAF/HO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E81A00D6;
	Wed, 13 Mar 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349503; cv=none; b=X5pX97WZq6OUp9EFILmZ1yOduEfPK6lf3ICIl9PdlYFLCvosSJ6wbpLRl5o6RV6dfwbmq32IIkwLoYC1HTG6n8Hv7cH+zyA8oQKrYFe3NhCTISJa6T4gHGuIalCpZ/y5/AF6EWPgLjrwfyvuRk4ANjouGezUwt9tj77p+aB17fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349503; c=relaxed/simple;
	bh=X6w2Pz8ARSb0A9skWuMw16BLD+2NNQB0U/SaQuVm0WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcUmz7+RMO19gXeF3DC7H701UtPzLD9VOy8J8ivMxOiTgb6tWfeMmfZjxxH6m1xf9H7ngYTZYf4GQj4Tc5uOmWhleA7TKMdU7rQEPNsSNat694BAv12ktSHZvHSVrhdtlT9tq6GYyaevAwvBiJ5yiFXxl4moRO28XKBEcE1cU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgAAF/HO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74814C433F1;
	Wed, 13 Mar 2024 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349502;
	bh=X6w2Pz8ARSb0A9skWuMw16BLD+2NNQB0U/SaQuVm0WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgAAF/HO+S5eNTOdDCaOu74CPTZymurPK4ln1HC6xvsR13/It1yFDwQMxs4gCicjn
	 ZbpRFZ5dWSerQ+E9u3rWAh46MsQKOifK42Do2tQiwNjDboKpOmCYjcKaDSj0Uf+qJM
	 pdnuZFcsb6ENxPLysOOtjtjX6qepYwqscMYxjHouqFzgwb6YkVJ+QUfD2Oi00H4Xgt
	 vWkjYyZaAKbM/hPnZXktiN2YYa4ZnKcv3tuDmZP15W1CI+NINgrlfEu1pvrWYAocih
	 8wyaIiLDqY//rtMb+DG0fsvi8wodLrpXQ6ZUB6rIHCqgZQd9Kpz/f9LRLxkKKaNrqo
	 begJt+6+jsrKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/41] netrom: Fix a data-race around sysctl_netrom_link_fails_count
Date: Wed, 13 Mar 2024 13:04:16 -0400
Message-ID: <20240313170435.616724-23-sashal@kernel.org>
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

[ Upstream commit bc76645ebdd01be9b9994dac39685a3d0f6f7985 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index eb285b12977b7..744c19a7a469c 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
-- 
2.43.0


