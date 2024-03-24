Return-Path: <linux-kernel+bounces-112774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E127887DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32011F213E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666F59B7A;
	Sun, 24 Mar 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhu/ugFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DA59158;
	Sun, 24 Mar 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300038; cv=none; b=hiNC7NcX7yhzLs0IvMHomkPpd6S7gdfUuBhgx5hiO4th2lusP/+8Jl6bCI1yP86xbiIJip2U1pKreKAdXIBxP4kglDGS5uTFYac0AT+U8VYneVf6v74kRirQnpKh3p3TZPgZ832WW2HSI2aqN6I1vvEepUbaBP+aOgxREN41Kso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300038; c=relaxed/simple;
	bh=Yx4z1c+Bu5s+V0sWrTPLA22MMO08Ob0bgjwlHnhaN5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVsGUFxeyM/TV7tZIGlobBAZdbEqMq5UXBR5SbNWl1nxQaCQzs+B2WtPU9zWuvDe4EPm2uK944UnZCKdyDoB/VPgDoC8UEntgO/w4GFh1T/oILOp4oHtwjagCrEUZ6F2oK++LEdqrgGi5MiLcK5LQSnh+GK3r+569YVOMtkBoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhu/ugFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8492FC43390;
	Sun, 24 Mar 2024 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300038;
	bh=Yx4z1c+Bu5s+V0sWrTPLA22MMO08Ob0bgjwlHnhaN5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qhu/ugFC8g/wEVOzJigUxqLi/1qWbze92wf2LX3jVZlgpVzlbiItR9syCTUtCTuAr
	 O9utODEWKrrocjKMELrCo9gDJx2P7pnZ59yUfBRMCuAKzqKIZPy/Eto15NluIk508+
	 w6zy5A1c6w0Hb4qwWqzV3lwSYeh3ifs6ShHL/fmQCoANefco6v7L6WJT016hUV22B/
	 h70hs+t/ZQt+7Htw70obce4lsXzpk+aklVb/3bKjvFN4YZTIq/9BRv8SMXxbSWzm+l
	 QbzLkYi/+k9eL69ns9FiyTFDqYcP074Fj0b+BSzl2lojmEPC2NOGrjI7zUGXC8loL/
	 gY/EunlTvl+rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/7] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:07:05 -0400
Message-ID: <20240324170709.546465-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170709.546465-1-sashal@kernel.org>
References: <20240324170709.546465-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.82
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


