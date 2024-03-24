Return-Path: <linux-kernel+bounces-113857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCFD8886FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9828D28DD13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C661514DF;
	Sun, 24 Mar 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI2J5+qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA01E9F7D;
	Sun, 24 Mar 2024 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320904; cv=none; b=EDYocDMKdVdlw3Xhl3Cw9M1ZymwBzFPgEA+94DJycO3F9Rpzpew8006+OE0mi4bf3oTRFznSpX3vWGR82bgLRrufQZqkEaiH0m0r+Khp8BgyldjCGlAyCWcLZcFzAiQ0EXrPD8pQMj9+3Q8bgIxX+t//gyvsrXHWlBF29kE4SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320904; c=relaxed/simple;
	bh=c5uf/Q9F27X3x1EsJkrtqlk02vwMsZglIgOetVWKTvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI5oELKpQB0jyxgM+0swgf6Qmjje7R8u2o/qL600fztrK33jqiMVSulnSZhtlN9waUp7DDTyc8bkuIc78jfh8LMQ5LtmkWKwt1KbxjzWVslpwGPaTTAy1GSX5lJvcstCMi8PstrH0AwWJEyxKrVMdb+NXjzEs/wJY/t30I4J+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI2J5+qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995CDC43399;
	Sun, 24 Mar 2024 22:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320902;
	bh=c5uf/Q9F27X3x1EsJkrtqlk02vwMsZglIgOetVWKTvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jI2J5+qtLDkkgi5TMkulqkZ7tnBnYj9910atRh9pMdSqztXKM+HefNEYLteEstLYc
	 KRNahw5o3vLqOdDWXh2hra6oIgZpMKJvohNZNmYxEFO016Cki1fxnTpbZEnkaeCI1T
	 JDr/2dcOyGfYFBzOXGI4M0EhhPBNPfk6nz288r5z92XmfGF9JBD9ddSZVRXvHFH41V
	 ouemB4ymJwu6k0F2Nbc/DKKpX47UlrtD8MogurHKdeCDLRKxgTLd+8paPlht2guevh
	 5eakKgY4qfR7hjFB5YGbYdOvnMoGItUBf4MBB9d0d931buhg3gv3VHceI9LcwWzJ02
	 AKtgz+TKtiXPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 465/713] media: cedrus: h265: Fix configuring bitstream size
Date: Sun, 24 Mar 2024 18:43:11 -0400
Message-ID: <20240324224720.1345309-466-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 3a11887f7f11a6bb1f05e7f67b3ea20dadfec443 ]

bit_size field holds size of slice, not slice + header. Because of HW
quirks, driver can't program in just slice, but also preceding header.
But that means that currently used bit_size is wrong (too small).
Instead, just use size of whole buffer. There is no harm in doing this.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Suggested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index fc9297232456f..16c822637dc6e 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -427,11 +427,11 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	unsigned int ctb_addr_x, ctb_addr_y;
 	struct cedrus_buffer *cedrus_buf;
 	dma_addr_t src_buf_addr;
-	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
 	u32 num_entry_point_offsets;
 	u32 output_pic_list_index;
 	u32 pic_order_cnt[2];
+	size_t slice_bytes;
 	u8 padding;
 	int count;
 	u32 reg;
@@ -443,6 +443,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	pred_weight_table = &slice_params->pred_weight_table;
 	num_entry_point_offsets = slice_params->num_entry_point_offsets;
 	cedrus_buf = vb2_to_cedrus_buffer(&run->dst->vb2_buf);
+	slice_bytes = vb2_get_plane_payload(&run->src->vb2_buf, 0);
 
 	/*
 	 * If entry points offsets are present, we should get them
@@ -490,7 +491,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
 
-	reg = slice_params->bit_size;
+	reg = slice_bytes * 8;
 	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
 
 	/* Source beginning and end addresses. */
@@ -504,10 +505,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
 
-	src_buf_end_addr = src_buf_addr +
-			   DIV_ROUND_UP(slice_params->bit_size, 8);
-
-	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
+	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
 
 	/* Coding tree block address */
-- 
2.43.0


