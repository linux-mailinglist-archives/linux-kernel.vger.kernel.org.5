Return-Path: <linux-kernel+bounces-124927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC161891F35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3204B2D296
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270416C439;
	Fri, 29 Mar 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSyjNtUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE471A33BF;
	Fri, 29 Mar 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716441; cv=none; b=W2s/X1ZdqvKXQ0ZV/UJElCHyY9u8FZ4KyrP3ssNOgLfHJBRhUepTfhURy7N0c31B490nCVisleu/JvCi6N+YoQOHu6s68jtHtxzh7BOwxHnuwmebXCNMEkYJX47RBQFC1A5OmQzdqvvAYI/jEgrdx5hHzmO6lvNo+VQAjOxrldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716441; c=relaxed/simple;
	bh=Yx4z1c+Bu5s+V0sWrTPLA22MMO08Ob0bgjwlHnhaN5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRnieWKjGmv805vYHA69xDH8P90effrPKomgElb6ex8/8jsddFdX87PYKmAy+hKS02/TCJk2aWxMEtF/yvobbDDL2GFNoBjrONs2NKR2BhGQbkcqCG/t294k9wKdSTXag0pi6951cB6Tga81dntJf5SuQeukZCRfkYk/AyUs6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSyjNtUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A39FC43330;
	Fri, 29 Mar 2024 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716441;
	bh=Yx4z1c+Bu5s+V0sWrTPLA22MMO08Ob0bgjwlHnhaN5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSyjNtUkO5NPXkWufLgjgmhXxI5TEQ3T4jKj8KlamkU5RB2GlJCiudK5IfbzvaoMi
	 66xUuOkL1DS52e8PtCSTKtlqF75sxoLSlvf2tNyH2NHECGJbRn/BBUD0ER/cdjbfYn
	 EEYAcPY6FlbaTPY6q0hm5BZFdfW+XwaANRZtz7k/1D4aQuH+4vBPJm4/nHm/v/tthV
	 qdXg8+TfNhim1rTWj3oPKVIHnowzU+e7umbBjvHQj4n6aUkV3zwR5HJNdfPlvFtpNU
	 NAexU79Bmo1Sug8LM9pyCl5wpfwN4Qwtj1Co/lID6gl3Mhp6BbYtBtIqvNzQN4rALD
	 uoSZRD5I2EclQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 43/52] block: prevent division by zero in blk_rq_stat_sum()
Date: Fri, 29 Mar 2024 08:45:37 -0400
Message-ID: <20240329124605.3091273-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index da9407b7d4abf..41be89ecaf20e 100644
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


