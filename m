Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F277A7A5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjHMPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjHMPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9110E3;
        Sun, 13 Aug 2023 08:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1E46303A;
        Sun, 13 Aug 2023 15:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FD0C433CA;
        Sun, 13 Aug 2023 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941783;
        bh=I1SeGGlnw2WDZ8a5wUbG1+UT7SVqUtc+aQgmW2Z8XWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXVosyAXfycTTkJGWCmfx8jRw41bsUVBFzWlDl/74QbWKDVA9hR7Sq+MBtMbSsEJa
         jVC16HFpOKOniDJrgapNFHuhsK0lcd1qdBgy6pUhOoP8ybMzwuZjusW2RdKUM0A4Uu
         vhzdAX8ZNmEqrUft+pKuqVAS3UsmsmkkJ2XSy7Vx+YblaGdCeX7GeOL3B4RDVWKz/v
         FixFG2W1izuM7zQlMyhRGB9tVX18Mj3I2scd6DSgs+9YHxuFYWwI0LBa8iW4zKt752
         lR03hWvMHzY5mFBXzXdVkS9mC8fxUJfnGfQs7DYrNNwshqSDr9OzgDq64i7NH0o8Up
         7ohzNwr5vkPWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, mirela.rabulea@nxp.com,
        shawnguo@kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 05/54] media: imx-jpeg: Support to assign slot for encoder/decoder
Date:   Sun, 13 Aug 2023 11:48:44 -0400
Message-Id: <20230813154934.1067569-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 53ebeea50599c1ed05277d7a57e331a34e6d6a82 ]

imx jpeg encoder and decoder support 4 slots each,
aim to support some virtualization scenarios.

driver should only enable one slot one time.

but due to some hardware issue,
only slot 0 can be enabled in imx8q platform,
and they may be fixed in imx9 platform.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   1 -
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 135 +++++++++---------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   5 +-
 3 files changed, 68 insertions(+), 73 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ed15ea348f97b..a2b4fb9e29e7d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -58,7 +58,6 @@
 #define CAST_OFBSIZE_LO			CAST_STATUS18
 #define CAST_OFBSIZE_HI			CAST_STATUS19
 
-#define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
 /* JPEG-Decoder Wrapper Slot Registers 0..3 */
 #define SLOT_BASE			0x10000
 #define SLOT_STATUS			0x0
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index c0e49be42450a..9512c0a619667 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -745,87 +745,77 @@ static void notify_src_chg(struct mxc_jpeg_ctx *ctx)
 	v4l2_event_queue_fh(&ctx->fh, &ev);
 }
 
-static int mxc_get_free_slot(struct mxc_jpeg_slot_data slot_data[], int n)
+static int mxc_get_free_slot(struct mxc_jpeg_slot_data *slot_data)
 {
-	int free_slot = 0;
-
-	while (slot_data[free_slot].used && free_slot < n)
-		free_slot++;
-
-	return free_slot; /* >=n when there are no more free slots */
+	if (!slot_data->used)
+		return slot_data->slot;
+	return -1;
 }
 
-static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
-				     unsigned int slot)
+static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
 {
 	struct mxc_jpeg_desc *desc;
 	struct mxc_jpeg_desc *cfg_desc;
 	void *cfg_stm;
 
-	if (jpeg->slot_data[slot].desc)
+	if (jpeg->slot_data.desc)
 		goto skip_alloc; /* already allocated, reuse it */
 
 	/* allocate descriptor for decoding/encoding phase */
 	desc = dma_alloc_coherent(jpeg->dev,
 				  sizeof(struct mxc_jpeg_desc),
-				  &jpeg->slot_data[slot].desc_handle,
+				  &jpeg->slot_data.desc_handle,
 				  GFP_ATOMIC);
 	if (!desc)
 		goto err;
-	jpeg->slot_data[slot].desc = desc;
+	jpeg->slot_data.desc = desc;
 
 	/* allocate descriptor for configuration phase (encoder only) */
 	cfg_desc = dma_alloc_coherent(jpeg->dev,
 				      sizeof(struct mxc_jpeg_desc),
-				      &jpeg->slot_data[slot].cfg_desc_handle,
+				      &jpeg->slot_data.cfg_desc_handle,
 				      GFP_ATOMIC);
 	if (!cfg_desc)
 		goto err;
-	jpeg->slot_data[slot].cfg_desc = cfg_desc;
+	jpeg->slot_data.cfg_desc = cfg_desc;
 
 	/* allocate configuration stream */
 	cfg_stm = dma_alloc_coherent(jpeg->dev,
 				     MXC_JPEG_MAX_CFG_STREAM,
-				     &jpeg->slot_data[slot].cfg_stream_handle,
+				     &jpeg->slot_data.cfg_stream_handle,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
-	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
+	jpeg->slot_data.cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
-	jpeg->slot_data[slot].used = true;
+	jpeg->slot_data.used = true;
 
 	return true;
 err:
-	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", slot);
+	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", jpeg->slot_data.slot);
 
 	return false;
 }
 
-static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg,
-				    unsigned int slot)
+static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
 {
-	if (slot >= MXC_MAX_SLOTS) {
-		dev_err(jpeg->dev, "Invalid slot %d, nothing to free.", slot);
-		return;
-	}
-
 	/* free descriptor for decoding/encoding phase */
 	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data[slot].desc,
-			  jpeg->slot_data[slot].desc_handle);
+			  jpeg->slot_data.desc,
+			  jpeg->slot_data.desc_handle);
 
 	/* free descriptor for encoder configuration phase / decoder DHT */
 	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data[slot].cfg_desc,
-			  jpeg->slot_data[slot].cfg_desc_handle);
+			  jpeg->slot_data.cfg_desc,
+			  jpeg->slot_data.cfg_desc_handle);
 
 	/* free configuration stream */
 	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
-			  jpeg->slot_data[slot].cfg_stream_vaddr,
-			  jpeg->slot_data[slot].cfg_stream_handle);
+			  jpeg->slot_data.cfg_stream_vaddr,
+			  jpeg->slot_data.cfg_stream_handle);
 
-	jpeg->slot_data[slot].used = false;
+	jpeg->slot_data.used = false;
 }
 
 static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
@@ -855,7 +845,7 @@ static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx, enum vb2_buffer_state
 	v4l2_m2m_buf_done(dst_buf, state);
 
 	mxc_jpeg_disable_irq(reg, ctx->slot);
-	ctx->mxc_jpeg->slot_data[ctx->slot].used = false;
+	jpeg->slot_data.used = false;
 	if (reset)
 		mxc_jpeg_sw_reset(reg);
 }
@@ -919,7 +909,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		goto job_unlock;
 	}
 
-	if (!jpeg->slot_data[slot].used)
+	if (!jpeg->slot_data.used)
 		goto job_unlock;
 
 	dec_ret = readl(reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
@@ -1179,13 +1169,13 @@ static void mxc_jpeg_config_dec_desc(struct vb2_buffer *out_buf,
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	void __iomem *reg = jpeg->base_reg;
 	unsigned int slot = ctx->slot;
-	struct mxc_jpeg_desc *desc = jpeg->slot_data[slot].desc;
-	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data[slot].cfg_desc;
-	dma_addr_t desc_handle = jpeg->slot_data[slot].desc_handle;
-	dma_addr_t cfg_desc_handle = jpeg->slot_data[slot].cfg_desc_handle;
-	dma_addr_t cfg_stream_handle = jpeg->slot_data[slot].cfg_stream_handle;
-	unsigned int *cfg_size = &jpeg->slot_data[slot].cfg_stream_size;
-	void *cfg_stream_vaddr = jpeg->slot_data[slot].cfg_stream_vaddr;
+	struct mxc_jpeg_desc *desc = jpeg->slot_data.desc;
+	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data.cfg_desc;
+	dma_addr_t desc_handle = jpeg->slot_data.desc_handle;
+	dma_addr_t cfg_desc_handle = jpeg->slot_data.cfg_desc_handle;
+	dma_addr_t cfg_stream_handle = jpeg->slot_data.cfg_stream_handle;
+	unsigned int *cfg_size = &jpeg->slot_data.cfg_stream_size;
+	void *cfg_stream_vaddr = jpeg->slot_data.cfg_stream_vaddr;
 	struct mxc_jpeg_src_buf *jpeg_src_buf;
 
 	jpeg_src_buf = vb2_to_mxc_buf(src_buf);
@@ -1245,18 +1235,18 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	void __iomem *reg = jpeg->base_reg;
 	unsigned int slot = ctx->slot;
-	struct mxc_jpeg_desc *desc = jpeg->slot_data[slot].desc;
-	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data[slot].cfg_desc;
-	dma_addr_t desc_handle = jpeg->slot_data[slot].desc_handle;
-	dma_addr_t cfg_desc_handle = jpeg->slot_data[slot].cfg_desc_handle;
-	void *cfg_stream_vaddr = jpeg->slot_data[slot].cfg_stream_vaddr;
+	struct mxc_jpeg_desc *desc = jpeg->slot_data.desc;
+	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data.cfg_desc;
+	dma_addr_t desc_handle = jpeg->slot_data.desc_handle;
+	dma_addr_t cfg_desc_handle = jpeg->slot_data.cfg_desc_handle;
+	void *cfg_stream_vaddr = jpeg->slot_data.cfg_stream_vaddr;
 	struct mxc_jpeg_q_data *q_data;
 	enum mxc_jpeg_image_format img_fmt;
 	int w, h;
 
 	q_data = mxc_jpeg_get_q_data(ctx, src_buf->vb2_queue->type);
 
-	jpeg->slot_data[slot].cfg_stream_size =
+	jpeg->slot_data.cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
 						  q_data->crop.width,
@@ -1265,7 +1255,7 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
 
-	cfg_desc->buf_base0 = jpeg->slot_data[slot].cfg_stream_handle;
+	cfg_desc->buf_base0 = jpeg->slot_data.cfg_stream_handle;
 	cfg_desc->buf_base1 = 0;
 	cfg_desc->line_pitch = 0;
 	cfg_desc->stm_bufbase = 0; /* no output expected */
@@ -1408,7 +1398,7 @@ static void mxc_jpeg_device_run_timeout(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
-	if (ctx->slot < MXC_MAX_SLOTS && ctx->mxc_jpeg->slot_data[ctx->slot].used) {
+	if (ctx->mxc_jpeg->slot_data.used) {
 		dev_warn(jpeg->dev, "%s timeout, cancel it\n",
 			 ctx->mxc_jpeg->mode == MXC_JPEG_DECODE ? "decode" : "encode");
 		mxc_jpeg_job_finish(ctx, VB2_BUF_STATE_ERROR, true);
@@ -1476,12 +1466,12 @@ static void mxc_jpeg_device_run(void *priv)
 	mxc_jpeg_enable(reg);
 	mxc_jpeg_set_l_endian(reg, 1);
 
-	ctx->slot = mxc_get_free_slot(jpeg->slot_data, MXC_MAX_SLOTS);
-	if (ctx->slot >= MXC_MAX_SLOTS) {
+	ctx->slot = mxc_get_free_slot(&jpeg->slot_data);
+	if (ctx->slot < 0) {
 		dev_err(dev, "No more free slots\n");
 		goto end;
 	}
-	if (!mxc_jpeg_alloc_slot_data(jpeg, ctx->slot)) {
+	if (!mxc_jpeg_alloc_slot_data(jpeg)) {
 		dev_err(dev, "Cannot allocate slot data\n");
 		goto end;
 	}
@@ -2101,7 +2091,7 @@ static int mxc_jpeg_open(struct file *file)
 	}
 	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
 	mxc_jpeg_set_default_params(ctx);
-	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
+	ctx->slot = -1; /* slot not allocated yet */
 	INIT_DELAYED_WORK(&ctx->task_timer, mxc_jpeg_device_run_timeout);
 
 	if (mxc_jpeg->mode == MXC_JPEG_DECODE)
@@ -2677,6 +2667,11 @@ static int mxc_jpeg_attach_pm_domains(struct mxc_jpeg_dev *jpeg)
 		dev_err(dev, "No power domains defined for jpeg node\n");
 		return jpeg->num_domains;
 	}
+	if (jpeg->num_domains == 1) {
+		/* genpd_dev_pm_attach() attach automatically if power domains count is 1 */
+		jpeg->num_domains = 0;
+		return 0;
+	}
 
 	jpeg->pd_dev = devm_kmalloc_array(dev, jpeg->num_domains,
 					  sizeof(*jpeg->pd_dev), GFP_KERNEL);
@@ -2718,7 +2713,6 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	int ret;
 	int mode;
 	const struct of_device_id *of_id;
-	unsigned int slot;
 
 	of_id = of_match_node(mxc_jpeg_match, dev->of_node);
 	if (!of_id)
@@ -2742,19 +2736,22 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	if (IS_ERR(jpeg->base_reg))
 		return PTR_ERR(jpeg->base_reg);
 
-	for (slot = 0; slot < MXC_MAX_SLOTS; slot++) {
-		dec_irq = platform_get_irq(pdev, slot);
-		if (dec_irq < 0) {
-			ret = dec_irq;
-			goto err_irq;
-		}
-		ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
-				       0, pdev->name, jpeg);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
-				dec_irq, ret);
-			goto err_irq;
-		}
+	ret = of_property_read_u32_index(pdev->dev.of_node, "slot", 0, &jpeg->slot_data.slot);
+	if (ret)
+		jpeg->slot_data.slot = 0;
+	dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
+	dec_irq = platform_get_irq(pdev, 0);
+	if (dec_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
+		ret = dec_irq;
+		goto err_irq;
+	}
+	ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
+			       0, pdev->name, jpeg);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
+			dec_irq, ret);
+		goto err_irq;
 	}
 
 	jpeg->pdev = pdev;
@@ -2914,11 +2911,9 @@ static const struct dev_pm_ops	mxc_jpeg_pm_ops = {
 
 static void mxc_jpeg_remove(struct platform_device *pdev)
 {
-	unsigned int slot;
 	struct mxc_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
-	for (slot = 0; slot < MXC_MAX_SLOTS; slot++)
-		mxc_jpeg_free_slot_data(jpeg, slot);
+	mxc_jpeg_free_slot_data(jpeg);
 
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->dec_vdev);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 87157db780826..d80e94cc9d992 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -97,7 +97,7 @@ struct mxc_jpeg_ctx {
 	struct mxc_jpeg_q_data		cap_q;
 	struct v4l2_fh			fh;
 	enum mxc_jpeg_enc_state		enc_state;
-	unsigned int			slot;
+	int				slot;
 	unsigned int			source_change;
 	bool				header_parsed;
 	struct v4l2_ctrl_handler	ctrl_handler;
@@ -106,6 +106,7 @@ struct mxc_jpeg_ctx {
 };
 
 struct mxc_jpeg_slot_data {
+	int slot;
 	bool used;
 	struct mxc_jpeg_desc *desc; // enc/dec descriptor
 	struct mxc_jpeg_desc *cfg_desc; // configuration descriptor
@@ -128,7 +129,7 @@ struct mxc_jpeg_dev {
 	struct v4l2_device		v4l2_dev;
 	struct v4l2_m2m_dev		*m2m_dev;
 	struct video_device		*dec_vdev;
-	struct mxc_jpeg_slot_data	slot_data[MXC_MAX_SLOTS];
+	struct mxc_jpeg_slot_data	slot_data;
 	int				num_domains;
 	struct device			**pd_dev;
 	struct device_link		**pd_link;
-- 
2.40.1

