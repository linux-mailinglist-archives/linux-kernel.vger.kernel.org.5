Return-Path: <linux-kernel+bounces-112743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B5887DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EF71F212BB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC45249FC;
	Sun, 24 Mar 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfCIP953"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3713225CD;
	Sun, 24 Mar 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299969; cv=none; b=V2TLwG0HXH/W5xMx0hfHqY+lJrX9Wwpb1ujnVpjEp1YaqdO5DzJIhjrDusIOieeetgVYax/OlJDGu35tNoYVE50BfGtCFwviP459qZnprm+c4MSAeAhBt4rTvBepTff1bXhKhU7PTPPoGjFK9Eln12ycQdCEYhMH4ekSUrlExYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299969; c=relaxed/simple;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbSrAffPtWHCPhDdoq03udYWaDXlTuoBoKTqys1fajlaeZMr0H3Z2F2DwGedFcQL3U+deh87yK929XB4+o9w+eI4P3hyDSVGdE5aBp6HoWK1lPJtSSIXLfkMcNkKQdb3PYE92keuWme5Ds2MeI+mKJ9XZQvYkCl03d5YIlzLeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfCIP953; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5FEC433F1;
	Sun, 24 Mar 2024 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299969;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfCIP9536KgM62l08U4KERfYAuWN82hyZ//zgrxQyirMgSuHUi4dExo9Zmwuj+VH+
	 0Xl0YycYVCZtsx4aj75QVYcaIOw4YgX9ul+0H21uT6C6ApUOIQWTlsAFqYKGigVK8n
	 G++/Xogv/CLedQJEL1G+2sywWk1I1L9jT4HWxnXWnf5B88zd3BcR4CA2B/F64dnDae
	 5NtECnRQQDrJ8VN1AcMbPxy9ri3ePKYq44ye6Ykmxc2aQeGcntgL2Jm2KExHlfTRZF
	 43uT6g2xiIm1pp6OG/fe1unmjxSgIIq1ne8pqDdAIxmd9puePeW+q0nvKghsDkuZv9
	 UWzf0PPrwvKFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/11] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:05:43 -0400
Message-ID: <20240324170552.545730-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170552.545730-1-sashal@kernel.org>
References: <20240324170552.545730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.1
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
index 7ff76ae6c76a9..e42c263e53fb9 100644
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


