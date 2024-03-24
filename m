Return-Path: <linux-kernel+bounces-112778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78B887E06
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64081F213B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46A5CDF0;
	Sun, 24 Mar 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3aOr89c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D55C911;
	Sun, 24 Mar 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300047; cv=none; b=S0O8SQn5M03GR6624ePBIuNGeWU95DxxctC+vmkqpYKZNgyg0U4H3P2e9P4W29PdzZWGT+0JUJdnkG0LVrex8gyH2YGnfo4RFy70geIsOb/UqoipIoRmmK/qbzXamAfbe1VaqfIVpjGI2dMpyeDsOBgm9w/W58/jfbyUZIGplM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300047; c=relaxed/simple;
	bh=8wYWk+lnFSA1f2NjZ4HWprJzO1phQiGDLipkeklGi8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpno1KISq2HPIgMwibeJhaTDLOgzZwarMTx3UcG2sIyyiZ14dofUDYfPRNOczbgu0B4NpEa0eiDbXT3NpP/BJCUIPSJagyYroXU/wlKVTwW8k0OdMrJ1ylhWnA7PqfRrbFGk94nj8MAppeRoMLZz1ZeanaD1tu3VPQhkXwpoTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3aOr89c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3227EC433A6;
	Sun, 24 Mar 2024 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300047;
	bh=8wYWk+lnFSA1f2NjZ4HWprJzO1phQiGDLipkeklGi8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3aOr89cCIjamz1LAElFZ+F7k9dml16ZYpAdUKfVUeGC2EH89Jl50S2ClQlmc74O1
	 Vspa6ewxwtBdKM2XSkJQvdjLYUsOGg3Z84d3mWvY6gQm6RFU0CozIFHIQ6M71LHjQW
	 ZbZ/E+DFm0GZJnBJ83le+Y0j1Ghp2YpRuUAwIp2oPjWmWqR+oHHZiEtt21Mff5CxQD
	 a+ERsbs2oqvUVXw+D7cqnUYAydOWweDijCIbzeLNMwVUYcEDzRFuD2A2QWrBmOrRJj
	 AZCC9lNMGOAg6nHhHhAuwgAYTQ1G/9PPp7UKTczUUF96syXItt3Twv8jsbkQppRw91
	 D+olhDStmXDrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/2] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:07:21 -0400
Message-ID: <20240324170723.546623-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170723.546623-1-sashal@kernel.org>
References: <20240324170723.546623-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.152
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


