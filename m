Return-Path: <linux-kernel+bounces-27851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93382F6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D467E1F217AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DF20B35;
	Tue, 16 Jan 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asvSis/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3F20B21;
	Tue, 16 Jan 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434368; cv=none; b=Us4ghIWBjjlO3Y3s9W5nsBm3fScp2iOPx+EPJ309cyLuBOqJ8Y83qC9unXxuO99XD8pzPLLTKxmP6oOKhhA3HrPjcqrorsNSi78DhOlWPqsf6KPrh3fOYnUFtTqwfQZg8GLxSWnGhZsaHsvUOxJYikdMcPl6C5Mu4TfHuzbN3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434368; c=relaxed/simple;
	bh=KANHFBaqsOkmhse8jBTL8CuQiAWzvFMUgPyS2O7nW3M=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=dY0a2tmiQmbxCtBWyayDlwgEUkaRhPfGSP4n8l2PWb77nvvoKQhY1q59kue0lgp8V1fQm6Kh3WYvqru4xV7Mq/QZQa8PSq2H0AvrKFqCuYwRfdiVw62SzfySLsm7MMcOM68irvcIIJ4ctYgIVymrJKWjTpwX85xNyKUeQ4pG2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asvSis/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC43C43390;
	Tue, 16 Jan 2024 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434368;
	bh=KANHFBaqsOkmhse8jBTL8CuQiAWzvFMUgPyS2O7nW3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asvSis/Rrj7zUc8cQkcomMQs+ElEfXUXdyJP1kvbP/5xk1d7v/mq0Tc0NX8WlptYl
	 Ms+Sfmz/HhSxz+f1shhrcrkP4ABxhS+bviinAGOvZViPaEySCpCnQzW18F9gfrsUg4
	 VF5FekSULryozY1aC/RJ0MXaDzCVgnmanikkbcpnLJ6bfH+OpA80YX9i9c5To0Y+lU
	 vXBolBH9zermEQbPebKKwBr44rAt84LBqElQhYMAcmLxpPbDcDnm0a8OFueX5XDY/G
	 IpgXi3mLFoJrB/j+xI9CsVQSMGLaHP2QZW4L+AUTahMoUoqDSvHwF6AfP9/pXWtseo
	 JxSPH6z5KQ0UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 080/108] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Tue, 16 Jan 2024 14:39:46 -0500
Message-ID: <20240116194225.250921-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 816d412c06e9..cef830adbc06 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -944,7 +944,7 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
-- 
2.43.0


