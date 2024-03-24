Return-Path: <linux-kernel+bounces-112785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97760887E18
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0228AB22C43
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D76CDB4;
	Sun, 24 Mar 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVhSEMVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926A6BFCE;
	Sun, 24 Mar 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300066; cv=none; b=mqs7sbK3+wNCBZUX8ZhI6Vj+T3Pa4yjq1JsyjiE2W45NTv7cvKVkdkyqhjVBYgTrgD8Bjkz+cjij9ZZ6z2kcQjDVCcRdDcJfQHxhPCt7fSJgxZwrsdUtc7DwV8tNWVuPLKT1ObRnMFGwCEyoZOwfILMvHuEF3alQVX65yQ744jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300066; c=relaxed/simple;
	bh=fwh2m7sCn29cG90OCu3PIuTxTxnWk5RXZjAseQsIl/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5oz+2eGikJDgpe6xS2hs++XCSSIxhQewuZaKql9ZbKg31SmBwqO8LcSi21VpBzrsDUMPK6xWSnwOp+8LunZ17T13uvlBDmD0yfYcW6PelZ7qb+3wHjKvPmWwStI4MOLKOT20aMXWqM1LyUUZJhp/PdhLjhnjBwzhp8PcWvgr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVhSEMVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92380C433A6;
	Sun, 24 Mar 2024 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300066;
	bh=fwh2m7sCn29cG90OCu3PIuTxTxnWk5RXZjAseQsIl/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVhSEMVlezb5LZIrxLbfT+qdL7l9a8+wo8/Z/ZzXhhf8w6T6QB9e6w02CYViDMM/C
	 aIW7pmISbfdz1rv2IeOfQzXTzm+vLvqv8nq1Li/bMDIa7B5i3figc4iGQsKDnkr8vY
	 3tk4+i+FQoAmzxcNJX4iQWZowKDd1rBnEl8vSg8Rk3hZX4SA8y2+rG61m1smA+keyE
	 1Rc8bp+U1jnMQ5ksMR2W91Y2QcBSVP3drTxSLHalCbajWebZ5T/oN/1BHpev289vCu
	 +/Q1rRbj7Lrb8I030a3hKVjT5epiQrztsYs/Op05WViiRCMARhqdmSBYZvvi52wL2u
	 lBkNtpoLwJIrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/2] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:07:41 -0400
Message-ID: <20240324170743.546858-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170743.546858-1-sashal@kernel.org>
References: <20240324170743.546858-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.310
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


