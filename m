Return-Path: <linux-kernel+bounces-125023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6EF891EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A947428B1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9441B9F78;
	Fri, 29 Mar 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaFAEigd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2EA1B9F5B;
	Fri, 29 Mar 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716647; cv=none; b=mNWA+mv0k1P/McqGRHDr7+qTnig6n19KGrzse9Vj7EFyF2PzkphcsluNBe1rtLOXZvRy7xk6FP82sy07nmn+/OFiomMWPAzmksPBClyYnRzq0hPMdQPwaGYlt22juk1pCAuVMfmwiS4DgaX9P5pbfF+Yg3uhayioyCGetcJjzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716647; c=relaxed/simple;
	bh=dfl4B/oMFy0pf7PoHFZ/dpH6YryXARkBv/Ll0Q4yQLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McSq9k7FAJuwlnxC9trqsmzdH1WP6wChAZp7bNBGbXgbp0fcqPTAcCEGkGR5k9n2piJjZJRk97qG8ps+XIM71DHWZaNPpamfdCEIykglffEFvXnePV5Vg3oCJRwhFN80hbfGKBcTRu1IP8Ls25CACMFgZTFI+t1esej6xLWDvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaFAEigd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5875BC433B1;
	Fri, 29 Mar 2024 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716647;
	bh=dfl4B/oMFy0pf7PoHFZ/dpH6YryXARkBv/Ll0Q4yQLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaFAEigd6ol45LM6vPEBu0FNimS6sJ17gZD+eZ0dBx1VnOe3lW74R9Rl5+fywmBxn
	 bhersesu3RfD+pDaTdukvQIhRJu2fgNysF3uoMI4CshePNGXmbjTA+1JP3XY+s1L7t
	 ko6GwS3r0JcRyg8QyVxa1+eCvdmjg8QKxrgcQx9LbROxVBul7ttwfhJ0lhi/136wqJ
	 oU2Q59UiNyFAcgAaW452MJ9lYSB1i8dNVYG6PzXHtrK/srXu78NamDGvUY+agooY/n
	 w8OQjjhhtlOnDbir3hCGIzHytZlubKLhcEsTONaETV4KQuPKykaFDk6JnV3hCK1dik
	 7uCjj8kr9BD9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 21/23] block: prevent division by zero in blk_rq_stat_sum()
Date: Fri, 29 Mar 2024 08:49:54 -0400
Message-ID: <20240329125009.3093845-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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


