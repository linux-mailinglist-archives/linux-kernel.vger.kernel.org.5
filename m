Return-Path: <linux-kernel+bounces-125044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD7891F26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FE41F2DD97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B261C08B9;
	Fri, 29 Mar 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7h5Kl4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627161C089A;
	Fri, 29 Mar 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716693; cv=none; b=p/t2YvnvgRMS1x1AIso2yYKiezrXWrLgIeSCCt48yvW2oJhdepGMiRAJQgggUyRk7Qx5WStGF51RK8NVXATmlhAXE9rDBk/VhqlpxvWCpbLCNGlknE4kbeAjtttzDQx3hoTPKO0Mtd0YK3XP2zoIXqeh9ErcdPuIjg7q3L/tOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716693; c=relaxed/simple;
	bh=fwh2m7sCn29cG90OCu3PIuTxTxnWk5RXZjAseQsIl/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoEIwo/+rMmXhQfJ/8tePJHea7jfYRzQwIZ+fWEKF4Gq1uhvShEUNlDvm0BX+h1Bxittj5TZDpVNVUqLsrwIzhbf1jz2ihhuA8ZIDXUCY1kDRJbeWa320Pg1z6AeGWTS3z0IBa754sUGIoXcRqGctG8rSfENgE4BQ3ZLxYa2R3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7h5Kl4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F54C433A6;
	Fri, 29 Mar 2024 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716691;
	bh=fwh2m7sCn29cG90OCu3PIuTxTxnWk5RXZjAseQsIl/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7h5Kl4qBrNDYVTaB0Ibj+/j+0dQ4P1n4IwVG0qmlAMSct0tmtwpzTRfGf+tzZvVD
	 lykhtgRvL50OypiFYH6l4P40uHIIXXUT8M4AxiFLnKn6r7xWjYp46wFNFpfMS+s4q6
	 G2AvtxDP/uvFtB/QJbTBVUtWqC4C44Hw2AUca0c7vIwN+BgT6XVjruLeXJIzzaAUKx
	 ZSlLoz2XF61Zz5NaIrM+K+ovNk4USkk9FSM1QZSUa4l7csYSMdyI039egry0IN0Mza
	 Zu5/hcVaVkq9Hx+gqe6bKNr9VOZRMsMqkbbAKvcHOQYdbp79NjWI2wbuF7gw5q8eIZ
	 Sdap+MnmqCMvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/19] block: prevent division by zero in blk_rq_stat_sum()
Date: Fri, 29 Mar 2024 08:50:49 -0400
Message-ID: <20240329125100.3094358-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 7587b1c3caaf5..507ac714423bd 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -27,7 +27,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
-	if (!src->nr_samples)
+	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
 		return;
 
 	dst->min = min(dst->min, src->min);
-- 
2.43.0


