Return-Path: <linux-kernel+bounces-124997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E9891E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C111C24157
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD341B2C0A;
	Fri, 29 Mar 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHRn5aAt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAC16DD36;
	Fri, 29 Mar 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716587; cv=none; b=cdnhAtLj3tiPhVAC92UArB5Iyh0cheqDDO1wk0C69Vh6SsiWR9vydPnmw7f9XrSX16Lr1MmWpwEvB6yz/EwTOO+d23xANQnZLWgJZNG4F9NxGXGfB91wmvZw5y0wJK512nCGLY7KXVmDd9sIKJoKcSJCY74JCIYme58qqp6HGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716587; c=relaxed/simple;
	bh=8wYWk+lnFSA1f2NjZ4HWprJzO1phQiGDLipkeklGi8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzxUWZLXK0OZ9TWkVWoJX+hjw8GEg9IiF+FDC/6nEQP2iU251+WMn55t8pgoqxinfz97bY1Eoc26pXDbJQr4ScwP2PFzC2UtQTYzifFkHdpOyFu2gmpRhKaVrg80+VbjFmL5Cute6P6g+bDFoI3FiYfj/FhYiY+lTJnGZLmofy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHRn5aAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20C0C43394;
	Fri, 29 Mar 2024 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716587;
	bh=8wYWk+lnFSA1f2NjZ4HWprJzO1phQiGDLipkeklGi8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHRn5aAt/PoRiJIrw4OIUpfcVcOIbjlUrrGAqVvR6fvn5+PkbMaRt5fUZGslZRdS5
	 /z9s1UvnxkQnD7IiAUiMz+kb8VHab+/7ZZHMIbc7Q7NDd6P+XMWdfqzFyh9uA9CKtx
	 BwJzJlHFn6R1UQgTYiWqpeAl0esyx0GKzGcsZw03CTwqFtuOfg4GeK2veRBG/9kpeN
	 U9cfMy+Xr0qvoQAFsfOQpkCashocHiIYsKtO+HlKRWTy/NAS+0/HIRIqHSChBHlrhu
	 12R6HCD5GeBIBfQMNkZzjxPzEdkrkjb6/wFW4HYzZJgmCMLhJwGHCtZHRK/69X7AJw
	 hgj0Y1UqT8xMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 26/31] block: prevent division by zero in blk_rq_stat_sum()
Date: Fri, 29 Mar 2024 08:48:43 -0400
Message-ID: <20240329124903.3093161-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 93f52fbeaf4b676b21acfe42a5152620e6770d02 ]

The expression dst->nr_samples + src->nr_samples may
have zero value on overflow. It is necessary to add
a check to avoid division by zero.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240305134509.23108-1-r.smirnov@omp.ru
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index ae3dd1fb8e61d..6e602f9b966e4 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -28,7 +28,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
-	if (!src->nr_samples)
+	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
 		return;
 
 	dst->min = min(dst->min, src->min);
-- 
2.43.0


