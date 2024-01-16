Return-Path: <linux-kernel+bounces-28067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A582F9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09641F26D20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E0149ADE;
	Tue, 16 Jan 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKXRm4gZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2730149AC8;
	Tue, 16 Jan 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435028; cv=none; b=jnqe1berowOP4UgTvGJdLXW2dHyiDJOINqLbOmz4KuRSt/ZV0gO+5NAL9q6PTiv2U4QPC1eTuYOI1Ef47BJfLbJ+mtmT8t/2ylp1w4SsOiAz/2hS8c2v0eOClVx/BOQLEi4Z1uB7XxS1LCj4duc8v6NzOvowpq1u4daccajY26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435028; c=relaxed/simple;
	bh=np3/yuz7oBZWfjCiRNn4D+cG2FIKY1DprokDIKGvCSQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=WIbBcRY/k9uM2Q1Z6aytFGwX+hU8cGAEoLJere2ZjgfcPdq/cyt8IK0fWZRQXl0noGuKVXUvNWLHoJgTywRMWgywEKUVToGzOtPEnJbBF5pd1TwulEyXI9zptOyTFZXuVThJRUMx4iZ8BlGCAxhuWsw4vh8tCL+O1xQISDy9GCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKXRm4gZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CABC43399;
	Tue, 16 Jan 2024 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435028;
	bh=np3/yuz7oBZWfjCiRNn4D+cG2FIKY1DprokDIKGvCSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKXRm4gZp/GK2LGTkyPEM5yzqFKH3MMhaiC+ngtDeg7Tq7zzJRd/xWq99xNAeqghN
	 d6ijyu5yFW/jLg9arF7xlite83SCGaTQYQjG++mxp2CUEG6NlXGvxpJDc8tgaJwwjK
	 wK6/e1BW0Ygmr2eb4UCFDUwFAurJWttLEi4pjkTd3tY2O8Pc7Vj3IjThrs71sDUGkw
	 9tRPM86f59mKMvGZFrVsPLkeY2KckdQhknikZlwfK0QyaqrjM7Tb6IfXbNw0MbmsQk
	 toBUy2yjIMLJxTbMowiWzPTh/Q0FLeLXkar5Q68yoKmTxoj7/XaK/6r1lTq7wb7IAy
	 U+kXhJo29w7Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 49/68] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Tue, 16 Jan 2024 14:53:48 -0500
Message-ID: <20240116195511.255854-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 9ec72a78f114..832de693a44b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -927,7 +927,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
-- 
2.43.0


