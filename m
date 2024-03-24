Return-Path: <linux-kernel+bounces-112782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0D887E11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564982817AA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC024B59;
	Sun, 24 Mar 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtgG+kDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5D5D8E0;
	Sun, 24 Mar 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300059; cv=none; b=ZEMymTb4dNwDjM+nyuwu9K41IwMXsnF+q2/eQ6j0zbzGiVb8bXYr+1oZpj6LnIwIL5Sk3EG9oai8l4aDg1dQM4xy07rK6mOf2ktvlUk062yD3KYajJZXQlArM/cOL8rnFjS3xBlPu5c8tz0ZX8sOFoNO3Y0IDtVY0Hj1XzdP9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300059; c=relaxed/simple;
	bh=dfl4B/oMFy0pf7PoHFZ/dpH6YryXARkBv/Ll0Q4yQLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP6goi/UJGExCrRKZAil6ml+wiBp7HEEaRs0m7DOqAopLlrPw1a/4Soju9rrPl2/ZnRDL9GiVxa7ucX+DsCxoGIOcbrt8t92NedNW/Dnj8dPL49YWeBoKziAjRYIASnhe0/URsLIRkAW981QjpnHkbuhe9CwMRrKyPgdPuhjbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtgG+kDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59761C43390;
	Sun, 24 Mar 2024 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300059;
	bh=dfl4B/oMFy0pf7PoHFZ/dpH6YryXARkBv/Ll0Q4yQLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtgG+kDs6N9Yd6M4wad5JIl0uuRCBlI3Kok6LoCFEN7IgPC5z464xnpR5BEO+GmlN
	 owLqxUAQ8X3mCaqBGSLVF1lFu5r7AAmdZBZUCjJGICTbbx/NNbOZcW8MholNtc0Ird
	 6ND6ftEVNTj4KqeHno+ng/3PrILGMzDgjrAOLL8SQE+OSPP8C23vsVe2mnu6O3+j4J
	 GDgeNCS2HYi3rIcUaR/GdQWC1PWJ4RgZQ5acAJ9STpucbLchxQ/kjU1sLadqk1BWE3
	 +EIaNkWm/b9oAXtUfqo9K3TV+BHVKRIIOuD3/3RSxY1258mtnd+k/0hi/g7qhSoZBZ
	 3kydDqZsd/ybQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/3] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:07:32 -0400
Message-ID: <20240324170735.546735-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170735.546735-1-sashal@kernel.org>
References: <20240324170735.546735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.272
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
index 940f15d600f8a..af482d8f9f7a4 100644
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


