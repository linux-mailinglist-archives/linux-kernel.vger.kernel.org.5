Return-Path: <linux-kernel+bounces-124873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763C891D50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AF4287E60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB3200104;
	Fri, 29 Mar 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhKPv51E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB01D2AA9;
	Fri, 29 Mar 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716325; cv=none; b=UcCx8f4m8U+Q/96VXogP+73ESek9bKPWFpXFbBXxKC5p8QArCXX4KEekjmyu6q47lSVHX579hCfsoskl3eS/2//juNatL7tnP70Z9zx5mqp6+pQTsMImRTtERkPi83nwixJLMMFhd5TCIK/5lncUWHX+QTQb1V1RLtnc6eydyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716325; c=relaxed/simple;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7k3fvpdMiEYJ9vozagacDodOzxrTPpa8Kf3XolpDpyXlEyNHUumJPYec0lh9MHgeVysFg2zvSH9fR0HbVWbhDH0xkofiwe79zKEFbvWXIwnmU6xpkUU9i03QR8OA+mUthm+UIRx2gchmklLAMLpoORLRbwt6PsBqNS0bKC4KXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhKPv51E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D20C43394;
	Fri, 29 Mar 2024 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716324;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhKPv51E2XB7HVb8KRfp4OVJevmWD2r0uUl8C1lrxx7/DaCXzD33zu86fCFTg3iCG
	 6qJUTIQXMNV5eeov2AqgftWk6i63VfTyRDyzFxy38nZrkPYHzaBAdY05A/Ept10hsC
	 7CPnRAyEPengM+sdqtpDYdeqpRbPRDIeuzpUgzEgfJJY34HJ3Fs80rz3whuTTnsMhn
	 nyXAVR+tDlF9J+4pF6b2NdA4iSBEK2gCjQm3F/qU3ZBsZjQc1iNTl6/iM3WKiv/tQu
	 rw5KyuaEGOCHa64unGfHYw+i8dRsUvPZ4ECGmPOT/TokmYd5UrehCKPzoTcAbLaHL/
	 5pOP5uqwr3CJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 64/75] block: prevent division by zero in blk_rq_stat_sum()
Date: Fri, 29 Mar 2024 08:42:45 -0400
Message-ID: <20240329124330.3089520-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


