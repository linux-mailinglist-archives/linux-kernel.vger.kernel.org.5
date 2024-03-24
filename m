Return-Path: <linux-kernel+bounces-114574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05625889307
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5ACB28A55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46E13C9D3;
	Sun, 24 Mar 2024 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/pLSpJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1122F8ED;
	Sun, 24 Mar 2024 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322217; cv=none; b=FRvcrwk/Bm41hX+oCRuf34Xs+Bb+tmX+htWMWjzwkxg2Hoz24LLpTB1nVZlaQk+6Ssj7zCAUiFxCYP2cEcVoe7yBLoNghCAdILuen2B75mqvkL+oVADqQu+bNznQxXrcBUhITu2lsU5vO05J/9iICUkNNZ5jm1t0IPoRYWbeF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322217; c=relaxed/simple;
	bh=Thd1UxPbAFXowHqBXHL8tbKu0QDXRIcfI3gDkgtUakw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1m03rAV6p4im62SPHRhPr3EZBwbaEUIBTd3jAUsKIHk369+qk/cDX9MBB86Zxk3UR6+/jGVyOCrh1NwL4CQK8bkdPdqRyrfhGTdCd9EnUqRe5JNNUH3ZSQRLinaIGEZqrrnNzluKinAMnk3EZxneZZt/ngGURm8aPxe0iX7mH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/pLSpJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6494C433C7;
	Sun, 24 Mar 2024 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322216;
	bh=Thd1UxPbAFXowHqBXHL8tbKu0QDXRIcfI3gDkgtUakw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/pLSpJaXqcG1WMSEBvbok2tYCqrBOkd+nTc/O2RjWNG3tVfymaFDNjFraGdfmzOz
	 HyhUAxCKKOC788Mo9wanABF3OuimPeRvY33xno2LdnFuLOMH3lBGk7SIDKP59OERDP
	 kTzA1mRY5I9zmLJTDzTrxRpArSNMJ34XfhS5R2t1aPYHZPrjrw1/PHw45ApWDQ6TN/
	 RIZN+8k7T8TCOC4ASFbZa014wSln+2Hr7ga9r1F+oJjCU+KITmZlzEEFbP9emrZ5LR
	 1Uy1spbYbiNUXQDSVhb4vS+dkGA8lO3BTD2YH8g4rAuBlj4gEeFCdg1TwKDo4ZR/+d
	 GJfstHfgfMikw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 296/451] media: cedrus: h265: Associate mv col buffers with buffer
Date: Sun, 24 Mar 2024 19:09:32 -0400
Message-ID: <20240324231207.1351418-297-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit 0ee952c2f484ee0059f7ce4951aaa3cb0eda96dd ]

Currently mv col aux buffers are allocated as a pool. This is not
optimal because pool size equals number of buffers before stream is
started. Buffers can easily be allocated afterwards. In such cases,
invalid pointer is assigned to the decoding frame and Cedrus might
overwrite memory location which is allocated to different task.

Solve this issue with allocating mv col buffer once capture buffer is
actually used.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 3a11887f7f11 ("media: cedrus: h265: Fix configuring bitstream size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  9 +--
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 63 ++++++++++---------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 93a2196006f73..cb99610f3e128 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -109,6 +109,11 @@ struct cedrus_buffer {
 			unsigned int			position;
 			enum cedrus_h264_pic_type	pic_type;
 		} h264;
+		struct {
+			void		*mv_col_buf;
+			dma_addr_t	mv_col_buf_dma;
+			ssize_t		mv_col_buf_size;
+		} h265;
 	} codec;
 };
 
@@ -142,10 +147,6 @@ struct cedrus_ctx {
 			ssize_t		intra_pred_buf_size;
 		} h264;
 		struct {
-			void		*mv_col_buf;
-			dma_addr_t	mv_col_buf_addr;
-			ssize_t		mv_col_buf_size;
-			ssize_t		mv_col_buf_unit_size;
 			void		*neighbor_info_buf;
 			dma_addr_t	neighbor_info_buf_addr;
 			void		*entry_points_buf;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 625f77a8c5bde..7a438cd22c341 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -90,12 +90,13 @@ static void cedrus_h265_sram_write_data(struct cedrus_dev *dev, void *data,
 }
 
 static inline dma_addr_t
-cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
-				       unsigned int index, unsigned int field)
+cedrus_h265_frame_info_mv_col_buf_addr(struct vb2_buffer *buf,
+				       unsigned int field)
 {
-	return ctx->codec.h265.mv_col_buf_addr + index *
-	       ctx->codec.h265.mv_col_buf_unit_size +
-	       field * ctx->codec.h265.mv_col_buf_unit_size / 2;
+	struct cedrus_buffer *cedrus_buf = vb2_to_cedrus_buffer(buf);
+
+	return cedrus_buf->codec.h265.mv_col_buf_dma +
+	       field * cedrus_buf->codec.h265.mv_col_buf_size / 2;
 }
 
 static void cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,
@@ -108,9 +109,8 @@ static void cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,
 	dma_addr_t dst_luma_addr = cedrus_dst_buf_addr(ctx, buf, 0);
 	dma_addr_t dst_chroma_addr = cedrus_dst_buf_addr(ctx, buf, 1);
 	dma_addr_t mv_col_buf_addr[2] = {
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, 0),
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
-						       field_pic ? 1 : 0)
+		cedrus_h265_frame_info_mv_col_buf_addr(buf, 0),
+		cedrus_h265_frame_info_mv_col_buf_addr(buf, field_pic ? 1 : 0)
 	};
 	u32 offset = VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
 		     VE_DEC_H265_SRAM_OFFSET_FRAME_INFO_UNIT * index;
@@ -412,6 +412,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	unsigned int width_in_ctb_luma, ctb_size_luma;
 	unsigned int log2_max_luma_coding_block_size;
 	unsigned int ctb_addr_x, ctb_addr_y;
+	struct cedrus_buffer *cedrus_buf;
 	dma_addr_t src_buf_addr;
 	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
@@ -428,6 +429,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	decode_params = run->h265.decode_params;
 	pred_weight_table = &slice_params->pred_weight_table;
 	num_entry_point_offsets = slice_params->num_entry_point_offsets;
+	cedrus_buf = vb2_to_cedrus_buffer(&run->dst->vb2_buf);
 
 	/*
 	 * If entry points offsets are present, we should get them
@@ -445,31 +447,25 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 		DIV_ROUND_UP(sps->pic_width_in_luma_samples, ctb_size_luma);
 
 	/* MV column buffer size and allocation. */
-	if (!ctx->codec.h265.mv_col_buf_size) {
-		unsigned int num_buffers =
-			run->dst->vb2_buf.vb2_queue->num_buffers;
-
+	if (!cedrus_buf->codec.h265.mv_col_buf_size) {
 		/*
 		 * Each CTB requires a MV col buffer with a specific unit size.
 		 * Since the address is given with missing lsb bits, 1 KiB is
 		 * added to each buffer to ensure proper alignment.
 		 */
-		ctx->codec.h265.mv_col_buf_unit_size =
+		cedrus_buf->codec.h265.mv_col_buf_size =
 			DIV_ROUND_UP(ctx->src_fmt.width, ctb_size_luma) *
 			DIV_ROUND_UP(ctx->src_fmt.height, ctb_size_luma) *
 			CEDRUS_H265_MV_COL_BUF_UNIT_CTB_SIZE + SZ_1K;
 
-		ctx->codec.h265.mv_col_buf_size = num_buffers *
-			ctx->codec.h265.mv_col_buf_unit_size;
-
 		/* Buffer is never accessed by CPU, so we can skip kernel mapping. */
-		ctx->codec.h265.mv_col_buf =
+		cedrus_buf->codec.h265.mv_col_buf =
 			dma_alloc_attrs(dev->dev,
-					ctx->codec.h265.mv_col_buf_size,
-					&ctx->codec.h265.mv_col_buf_addr,
+					cedrus_buf->codec.h265.mv_col_buf_size,
+					&cedrus_buf->codec.h265.mv_col_buf_dma,
 					GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
-		if (!ctx->codec.h265.mv_col_buf) {
-			ctx->codec.h265.mv_col_buf_size = 0;
+		if (!cedrus_buf->codec.h265.mv_col_buf) {
+			cedrus_buf->codec.h265.mv_col_buf_size = 0;
 			return -ENOMEM;
 		}
 	}
@@ -816,9 +812,6 @@ static int cedrus_h265_start(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
 
-	/* The buffer size is calculated at setup time. */
-	ctx->codec.h265.mv_col_buf_size = 0;
-
 	/* Buffer is never accessed by CPU, so we can skip kernel mapping. */
 	ctx->codec.h265.neighbor_info_buf =
 		dma_alloc_attrs(dev->dev, CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE,
@@ -845,14 +838,24 @@ static int cedrus_h265_start(struct cedrus_ctx *ctx)
 static void cedrus_h265_stop(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
+	struct cedrus_buffer *buf;
+	struct vb2_queue *vq;
+	unsigned int i;
 
-	if (ctx->codec.h265.mv_col_buf_size > 0) {
-		dma_free_attrs(dev->dev, ctx->codec.h265.mv_col_buf_size,
-			       ctx->codec.h265.mv_col_buf,
-			       ctx->codec.h265.mv_col_buf_addr,
-			       DMA_ATTR_NO_KERNEL_MAPPING);
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
+	for (i = 0; i < vq->num_buffers; i++) {
+		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
 
-		ctx->codec.h265.mv_col_buf_size = 0;
+		if (buf->codec.h265.mv_col_buf_size > 0) {
+			dma_free_attrs(dev->dev,
+				       buf->codec.h265.mv_col_buf_size,
+				       buf->codec.h265.mv_col_buf,
+				       buf->codec.h265.mv_col_buf_dma,
+				       DMA_ATTR_NO_KERNEL_MAPPING);
+
+			buf->codec.h265.mv_col_buf_size = 0;
+		}
 	}
 
 	dma_free_attrs(dev->dev, CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE,
-- 
2.43.0


