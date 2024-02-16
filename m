Return-Path: <linux-kernel+bounces-68385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96F857988
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653461C20A53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA781CD1E;
	Fri, 16 Feb 2024 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="btOcickR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E31CAB0;
	Fri, 16 Feb 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077329; cv=none; b=hLBoc/DDANJiLVcpui+C/Xi1+rofvuHSbs1qGTA84a/+ticN4d564YhOUf19hcifZknpyx7/F+EzSC+DKIcz0wH4hp6E4Bz2qo2tFls0MoEidNluzwjnh59OEDYRpM7QrzgJSt4WR5FgP1LRsMTi86Y8T+Wrsv/0VabRwDwbvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077329; c=relaxed/simple;
	bh=OPA9G2afJn3S9j/5SlNBvjfPy51p5PL0UkiWC2TuA0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZxeKHGskfBl7i093Mk1DBBx8zZSkaVtcXxUbcggaEwhPD5RHmJpSjGJUOjCXsmnPcXnMRJ5B1y5D2i4k/MIyd7FJ7/FMwtZ5HU7aVj39kM8qhjjhKO9gKTeT6R0ytg0GgSonOh6h6XCPxZBWpr8uOyyKtwjQqOtvbjP7xYGhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=btOcickR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20D8DD4A;
	Fri, 16 Feb 2024 10:55:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708077321;
	bh=OPA9G2afJn3S9j/5SlNBvjfPy51p5PL0UkiWC2TuA0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btOcickRwCVWKf/sFBgST1moz08pRvyHJp4TYxpSdLXBi+29cT9+wzQf4w2jC3WNv
	 VOBpiyBapoMJ8W3hawdianPVPN4kXA1yRVN/J0P7w6Al2hgaROZ977FmAnCYLW1Sck
	 KCpWt8Go7HpRf7FQiBbH7AeufGNFwVFpyTXOflyc=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Paul Elder <paul.elder@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 02/12] media: rkisp1: Support setting memory stride for main path
Date: Fri, 16 Feb 2024 18:54:48 +0900
Message-Id: <20240216095458.2919694-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some versions of the ISP supported by the rkisp1 driver, such as the ISP
in the i.MX8MP, implement configurable memory stride for the main path
the same way as already implemented by the driver for the self path.
Support this feature by adding a main stride feature flag and program
the corresponding registers accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes since v3:

- Implement memory stride support
- Squash patch that adds register bits definitions
- Reword the commit message

Changes since v2:

- Document the RKISP1_FEATURE_MAIN_STRIDE bit
- Use the rkisp1_has_feature() macro
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 34 ++++++++++++-------
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  6 ++--
 .../platform/rockchip/rkisp1/rkisp1-regs.h    | 27 +++++++++++++++
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index c381c22135a2..83a968487f24 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -442,6 +442,14 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
 	rkisp1_write(rkisp1, cap->config->mi.cr_size_init,
 		     rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CR));
 
+	if (rkisp1_has_feature(rkisp1, MAIN_STRIDE)) {
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_LLENGTH, cap->stride);
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_PIC_WIDTH, pixm->width);
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_PIC_HEIGHT, pixm->height);
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_PIC_SIZE,
+			     cap->stride * pixm->height);
+	}
+
 	rkisp1_irq_frame_end_enable(cap);
 
 	/* set uv swapping for semiplanar formats */
@@ -479,11 +487,11 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
 	rkisp1_write(rkisp1, cap->config->mi.cr_size_init,
 		     rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CR));
 
-	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_LLENGTH, cap->sp_y_stride);
+	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_LLENGTH, cap->stride);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_PIC_WIDTH, pixm->width);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_PIC_HEIGHT, pixm->height);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_PIC_SIZE,
-		     cap->sp_y_stride * pixm->height);
+		     cap->stride * pixm->height);
 
 	rkisp1_irq_frame_end_enable(cap);
 
@@ -1095,8 +1103,8 @@ static const struct vb2_ops rkisp1_vb2_ops = {
  */
 
 static const struct v4l2_format_info *
-rkisp1_fill_pixfmt(struct v4l2_pix_format_mplane *pixm,
-		   enum rkisp1_stream_id id)
+rkisp1_fill_pixfmt(const struct rkisp1_capture *cap,
+		   struct v4l2_pix_format_mplane *pixm)
 {
 	struct v4l2_plane_pix_format *plane_y = &pixm->plane_fmt[0];
 	const struct v4l2_format_info *info;
@@ -1109,10 +1117,13 @@ rkisp1_fill_pixfmt(struct v4l2_pix_format_mplane *pixm,
 
 	/*
 	 * The SP supports custom strides, expressed as a number of pixels for
-	 * the Y plane. Clamp the stride to a reasonable value to avoid integer
-	 * overflows when calculating the bytesperline and sizeimage values.
+	 * the Y plane, and so does the MP in ISP versions that have the
+	 * MAIN_STRIDE feature. Clamp the stride to a reasonable value to avoid
+	 * integer overflows when calculating the bytesperline and sizeimage
+	 * values.
 	 */
-	if (id == RKISP1_SELFPATH)
+	if (cap->id == RKISP1_SELFPATH ||
+	    rkisp1_has_feature(cap->rkisp1, MAIN_STRIDE))
 		stride = clamp(DIV_ROUND_UP(plane_y->bytesperline, info->bpp[0]),
 			       pixm->width, 65536U);
 	else
@@ -1187,7 +1198,7 @@ static void rkisp1_try_fmt(const struct rkisp1_capture *cap,
 	pixm->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	pixm->quantization = V4L2_QUANTIZATION_DEFAULT;
 
-	info = rkisp1_fill_pixfmt(pixm, cap->id);
+	info = rkisp1_fill_pixfmt(cap, pixm);
 
 	if (fmt_cfg)
 		*fmt_cfg = fmt;
@@ -1199,12 +1210,9 @@ static void rkisp1_set_fmt(struct rkisp1_capture *cap,
 			   struct v4l2_pix_format_mplane *pixm)
 {
 	rkisp1_try_fmt(cap, pixm, &cap->pix.cfg, &cap->pix.info);
-	cap->pix.fmt = *pixm;
 
-	/* SP supports custom stride in number of pixels of the Y plane */
-	if (cap->id == RKISP1_SELFPATH)
-		cap->sp_y_stride = pixm->plane_fmt[0].bytesperline /
-				   cap->pix.info->bpp[0];
+	cap->pix.fmt = *pixm;
+	cap->stride = pixm->plane_fmt[0].bytesperline / cap->pix.info->bpp[0];
 }
 
 static int rkisp1_try_fmt_vid_cap_mplane(struct file *file, void *fh,
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index be6cb42776b0..6a811b7ef1b9 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -110,6 +110,7 @@ enum rkisp1_isp_pad {
  * enum rkisp1_feature - ISP features
  *
  * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
+ * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
  *
  * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
  * the driver to implement support for features present in some ISP versions
@@ -117,6 +118,7 @@ enum rkisp1_isp_pad {
  */
 enum rkisp1_feature {
 	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
+	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
 };
 
 #define rkisp1_has_feature(rkisp1, feature) \
@@ -266,7 +268,7 @@ struct rkisp1_device;
  *		  handler to stop the streaming by waiting on the 'done' wait queue.
  *		  If the irq handler is not called, the stream is stopped by the callback
  *		  after timeout.
- * @sp_y_stride:  the selfpath allows to configure a y stride that is longer than the image width.
+ * @stride:       the line stride for the first plane, in pixel units
  * @buf.lock:	  lock to protect buf.queue
  * @buf.queue:	  queued buffer list
  * @buf.dummy:	  dummy space to store dropped data
@@ -287,7 +289,7 @@ struct rkisp1_capture {
 	bool is_streaming;
 	bool is_stopping;
 	wait_queue_head_t done;
-	unsigned int sp_y_stride;
+	unsigned int stride;
 	struct {
 		/* protects queue, curr and next */
 		spinlock_t lock;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
index bea69a0d766a..3b19c8411360 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
@@ -207,6 +207,24 @@
 #define RKISP1_CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP	BIT(1)
 #define RKISP1_CIF_MI_XTD_FMT_CTRL_DMA_CB_CR_SWAP	BIT(2)
 
+/* MI_OUTPUT_ALIGN_FORMAT */
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_LSB_ALIGNMENT			BIT(0)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES		BIT(1)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_WORDS		BIT(2)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_DWORDS		BIT(3)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES		BIT(4)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_WORDS		BIT(5)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_DWORDS		BIT(6)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_DMA_BYTE_SWAP_BYTES		BIT(7)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_DMA_BYTE_SWAP_WORDS		BIT(8)
+#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_DMA_BYTE_SWAP_DWORDS		BIT(9)
+
+/* MI_MP_OUTPUT_FIFO_SIZE */
+#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_FULL	(0 << 0)
+#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_HALF	(1 << 0)
+#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_QUARTER	(2 << 0)
+#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_EIGHT	(3 << 0)
+
 /* VI_CCL */
 #define RKISP1_CIF_CCL_CIF_CLK_DIS			BIT(2)
 /* VI_ISP_CLK_CTRL */
@@ -1000,6 +1018,15 @@
 #define RKISP1_CIF_MI_SP_CB_BASE_AD_INIT2	(RKISP1_CIF_MI_BASE + 0x00000140)
 #define RKISP1_CIF_MI_SP_CR_BASE_AD_INIT2	(RKISP1_CIF_MI_BASE + 0x00000144)
 #define RKISP1_CIF_MI_XTD_FORMAT_CTRL		(RKISP1_CIF_MI_BASE + 0x00000148)
+#define RKISP1_CIF_MI_MP_HANDSHAKE_0		(RKISP1_CIF_MI_BASE + 0x0000014C)
+#define RKISP1_CIF_MI_MP_Y_LLENGTH		(RKISP1_CIF_MI_BASE + 0x00000150)
+#define RKISP1_CIF_MI_MP_Y_SLICE_OFFSET		(RKISP1_CIF_MI_BASE + 0x00000154)
+#define RKISP1_CIF_MI_MP_C_SLICE_OFFSET		(RKISP1_CIF_MI_BASE + 0x00000158)
+#define RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT	(RKISP1_CIF_MI_BASE + 0x0000015C)
+#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE	(RKISP1_CIF_MI_BASE + 0x00000160)
+#define RKISP1_CIF_MI_MP_Y_PIC_WIDTH		(RKISP1_CIF_MI_BASE + 0x00000164)
+#define RKISP1_CIF_MI_MP_Y_PIC_HEIGHT		(RKISP1_CIF_MI_BASE + 0x00000168)
+#define RKISP1_CIF_MI_MP_Y_PIC_SIZE		(RKISP1_CIF_MI_BASE + 0x0000016C)
 
 #define RKISP1_CIF_SMIA_BASE			0x00001a00
 #define RKISP1_CIF_SMIA_CTRL			(RKISP1_CIF_SMIA_BASE + 0x00000000)
-- 
2.39.2


