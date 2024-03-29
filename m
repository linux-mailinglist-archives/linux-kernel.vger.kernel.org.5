Return-Path: <linux-kernel+bounces-124964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A126E891F28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2DB354FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493991AB876;
	Fri, 29 Mar 2024 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue8VvAXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45D1AB1FE;
	Fri, 29 Mar 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716518; cv=none; b=tZZSvimbJ3TvAlp3C1sNt/TCIEBbWuPaf9/Y4Xii5PhJ0VBzjFKtvkI8B/5MPJuMA25SMktHQPAzjuxgjKzdD0BkWfplC3ugrh9B2GjL0+SrAHW1LLYXez7q3SDLe01yfxpIthrjYcllDBPsQKr4qw2yPdiUaAcQXwSYqz1J4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716518; c=relaxed/simple;
	bh=8wYWk+lnFSA1f2NjZ4HWprJzO1phQiGDLipkeklGi8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGHm/fbey4poW9VZhBiKoJ9vU8yVhmdLpnETr6BH9ANYh6761Rn4cvvYI3/IAovlMByp4jwEASFb8Nw4PL3dv55TnCzvehnQqIFS+v1fr8XLt19ZP4b+ptd3qc28fSd77LfzbcXJcg9WvTxJn2+9ielPPNcLQgzjAhiTOA9vdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue8VvAXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED07C43399;
	Fri, 29 Mar 2024 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716518;
	bh=8wYWk+lnFSA1f2NjZ4HWprJzO1phQiGDLipkeklGi8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ue8VvAXdGUYKEp0byyc+LljIHECrgwyow6ELNCSQ1CU0dz4nTiQaOsSemfZjNYIqH
	 lGBuO/H820CkK/zPzU+0gzCPtKiIuJGGPcH6Z4DChZf4bdGD1pogWa3RunWP5dzylu
	 N3UtF+DVLOmXckMzEcTIaIDXr97MEdYGGpjybsorFvxYYUDs+FT4POOWgowuCVKA5s
	 eHFXyPaDQaenaJg/rns/5SztsxHSeUjvhYXZmInxFOcQnpbEC72m/sihthNmWUc8Ef
	 TETDC5diguG+8B4PMhDdbrFKkj4ZW28M16ePZUs/XDhWU0wvAdqMusOCabJ1C+nLiv
	 V3mn6uqBoE/1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 28/34] block: prevent division by zero in blk_rq_stat_sum()
Date: Fri, 29 Mar 2024 08:47:29 -0400
Message-ID: <20240329124750.3092394-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


