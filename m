Return-Path: <linux-kernel+bounces-112766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96AD887DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D46F1F21374
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7777524DC;
	Sun, 24 Mar 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwrTO9CS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119544DA08;
	Sun, 24 Mar 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300022; cv=none; b=KQppHwnGaZNKLzf4nYkKofJoW3KCV9OkwZISGMhbm3aPPsO5pfRQMtjCuU++SuuFjr8JiQEEEyAJBRxrXUUuRR/zxa45FCFNIZ/Tzduohfj7d9pVuLw3iyyAXV4hbRy0KUl00ZkdFnOnnYfon2HGpAo5Qc9bRXRKSGSiCETiG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300022; c=relaxed/simple;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlwI9amhXVm3nw/jaZZzetoTbj5J4WNQbJ5CyucFwH4jV6TYiFdXDW5PeBoXHX814XLhHM/1jwHrLM5M6R7GMdL6lsNKz9TFh1AggQgmhJziCwwX1ZIt4O57rmzhmgDRHyseCJ507kJEBnDEE7klNEU0tyIf/vaNiyP+3RgoRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwrTO9CS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D5EC433C7;
	Sun, 24 Mar 2024 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300021;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwrTO9CSvjw20UMYXP+bFtReZ1r2FWF5/c2hh7lhPfJMkqUQFKJf+KZ6J9Mc54xKB
	 +MilP0PL+tfbL5cbUav8ZRRS9Jw+qiyHgFh29bowwPibdaUjZyBaS5Sq1D/uly5Rjz
	 TAMqus0b7X5B6mzbO3qgpyNxBnIU5mqVAgSxx3qESIjCDrZ2ZdOo/xnmoe0lFD7waa
	 U9TJRIrM2G2DRdqFYsTdZcyPL4nwtEgb8Um1+FRaWdmrp7rM7LBNwTIHlvPNqJqdTs
	 A/GfmgUT1xhkmrmttX548It8W6ifa89t4e9dODERqHjqpN1X3JeuqiVaq1tIcQlSBg
	 OPCgGVQZQ8Kjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/11] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:06:38 -0400
Message-ID: <20240324170645.546220-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170645.546220-1-sashal@kernel.org>
References: <20240324170645.546220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.22
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


