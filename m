Return-Path: <linux-kernel+bounces-28122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4582FA75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F8528B4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6962F156221;
	Tue, 16 Jan 2024 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAZfk40f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DA15620B;
	Tue, 16 Jan 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435186; cv=none; b=qI3rBuGsoyh0OWS8swJFzKNTkfo9ylTkBf2cZkhGTHiYTXbj5OQlq7UbJcA570QcaX2Z0v7KHg0eydBcOmEwHqUkMZriGuUH6awHBoHLxdmhH0IQv76MEDrORbmb/IfjRtsrc72fpDSPC/lobdK6lWJikeZ7zTVVdTmDCTOhcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435186; c=relaxed/simple;
	bh=kTAPXA4UXMhjJdTrZ8viK7mQppsW3zTI7+g96n9KjcU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Tsv5D1QgTBwyiFwsxGh7734Q4BDa0aaHII+112WISl87oUDVtkijX8z3vNfxQ+flgfsgJ6IA2Cp4x4M02XcsPC5t7pkPYOzW+Y/GFnrUNOJtHjjXhMuZuZzC42A1++Y+rH66CgJzoLe7yeMrNanVImwk3ESdYxVO73vMdE9hWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAZfk40f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38482C433C7;
	Tue, 16 Jan 2024 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435186;
	bh=kTAPXA4UXMhjJdTrZ8viK7mQppsW3zTI7+g96n9KjcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAZfk40fWyTjdzIcRE+qNzRsdAaQL2wROqZNM/YI5tuMB9InqvxjUH7fyFKXtJuzY
	 56s2Km2NH3LWuoV9qNxPxZRoEfc/fgRwNsUUEG2W5CuCPvF6KmpjJiG74G3ejla97x
	 Z5K9GNXvaq7B4EU0Hu6LHVKD8IvwjFtnTsYdQruUKgXI8ke0RE6j7iFqe/eE+M/AVO
	 gyW34LaHvfK/Y1TKZNldeqS++CmA0WbR6NQlegPiIrYTzSKZhxZwgfppCDVAkAOZb3
	 YiCM+xmxpk1hTyrUWvtnohN/1sSS3FtUtkmCze+VaB5R9PiaG6lDiNb8urEvlgIuci
	 AnylBexEX9zIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 34/47] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Tue, 16 Jan 2024 14:57:37 -0500
Message-ID: <20240116195834.257313-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index ba9120d4fe49..8bd74ec45ac8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -809,7 +809,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
-- 
2.43.0


