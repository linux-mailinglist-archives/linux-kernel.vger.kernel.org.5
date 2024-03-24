Return-Path: <linux-kernel+bounces-114311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B08889AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11200289A41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02413C3D9;
	Sun, 24 Mar 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/mHW+Fn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52015153576;
	Sun, 24 Mar 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321690; cv=none; b=WWB25nMh3zvn/WP6iRiLQd+vqC4LlvgOoK1qpWUrlgIIaF8zcLt5IfxcVokDav14pM0TZR5/ruVvK2UjLXj93ZCUpkQCbhf6Bf6ZlRDOAkwbNkKjSoh6+KQs1uITA82Vqwt1gaNQZXxkYVqG8G2b28gt/cXn77q3FST/GsmUIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321690; c=relaxed/simple;
	bh=c5uf/Q9F27X3x1EsJkrtqlk02vwMsZglIgOetVWKTvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URBPheiYWCu/jyv3oqV3m2K+YaZ1/S6tiiEBd8S6O+DbAdEykH5Dl/yLWH5mgwu7NKw9S49r3vU2BJDLo5FKFWVWoYnT2giWJodyhJUAH5hb4CR6XWMW0f43KTZXcf4tpc/pKeavPZTVM0DXyhmOD5nnlGliLMLvu82dWuXlFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/mHW+Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CF1C433C7;
	Sun, 24 Mar 2024 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321689;
	bh=c5uf/Q9F27X3x1EsJkrtqlk02vwMsZglIgOetVWKTvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/mHW+FnTiO8FFlm02dcRs/OzpjFeX2/DhEuztdejTfiXtU3IfzGL1CtdpIUSCiTF
	 WW87wImE4iGU0FT5K5nN97+5I6QgehWSkHduixsn0d2eTguAuc49XDAH1k3LnIBlcz
	 NIK35lkeUsH5bkU2IDlgaBDqims/NwcGJ/8rs5duT9npaPo1ULymlGan8Rf4P+zHw3
	 8vfH5sr0XXPxrGdoHrdokVMUBrXrzYOJlc9arMvpAwaXjcxlUNNGtYkEa3CWithn+R
	 hOShB0QTwKe5Wy0shHGvtFYOJ3D2oUcxWDfTCV2D9GgJApl3h4YyjZmNcqidbYZ+GZ
	 h+oHM81t6hzqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 417/638] media: cedrus: h265: Fix configuring bitstream size
Date: Sun, 24 Mar 2024 18:57:34 -0400
Message-ID: <20240324230116.1348576-418-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


