Return-Path: <linux-kernel+bounces-28203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF782FB89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53FF1C26B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A6167448;
	Tue, 16 Jan 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ3LrlhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2893167430;
	Tue, 16 Jan 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435438; cv=none; b=nHi0XoiaigDRb0SOBfr7sjeN+CQnAOsUzJtU+1kDBysQKwZTvhDNijIowmi5JMehMr8nKpbrCmAGwh/JihwHvg+AJQHMj/sL0ZLydsoBarkCaIamdDtNN6DS//hSAC8roJx2ziItCJw8XDSPLpdwh8TylvdjH8RfKh18fL8dIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435438; c=relaxed/simple;
	bh=sQuBLIJZ61zGZVQAbYy/TB3/42ntXDLxwmsaFHwIFmg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=rb2GMmszXr1GsvaN59mHZpG02puy4GUpq9hZlCKSybrq0GAJj6Hm4n6aXfwx4BR2ii5texQ/fsEBoXRG9JUs5Qy8c/YZqjQ3pBxgruNqjdP1LihcPea45Sj4EUq+6zQxtncbv5FLXpbwcBeOLTczCrF3rpf++rnztllvtFmSHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ3LrlhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B79CC43390;
	Tue, 16 Jan 2024 20:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435437;
	bh=sQuBLIJZ61zGZVQAbYy/TB3/42ntXDLxwmsaFHwIFmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZ3LrlhIk+30wep91Vk3+ZR4qzplJo+fpR38jekRelx32jXFE/gA6vKBY20yu5xOS
	 gzQR+GoQ9XCxMWGJRgUFa9XwZ53f5fYpp5QgjEYOcDnfyPiMsuSAfmFfk3VnkA9vB9
	 EbNMURA3+FGUiJvFjWvfWdt9LG/Iglg5pkjk4N0CPv7gwxT0b71Jd7AATp8v1+IZtZ
	 tToQC8ksip3cftILDWi2c5ehweVn0fhV+/o2KzOLPbJy0M+GrXJQnrg/gFrWWdN8is
	 zUTwZiwT/EhBszOBEayDwxRYO7R0aNsymDgIilx4adLWxnjBYcP4sea4CdosQy50tE
	 SPhR1jOUws48g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/31] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Tue, 16 Jan 2024 15:02:32 -0500
Message-ID: <20240116200310.259340-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3f034c374ad55773c12dd8f3c1607328e17c0072 ]

Reordered a check to avoid a possible overflow when adding len to bv_len.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20231204173419.782378-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 08dbdc32ceaa..17d64539819e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -710,7 +710,7 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
-- 
2.43.0


