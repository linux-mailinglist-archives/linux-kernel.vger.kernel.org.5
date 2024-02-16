Return-Path: <linux-kernel+bounces-68391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D2A85799A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F588B26433
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996923753;
	Fri, 16 Feb 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="o/5KYOxQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D522EF8;
	Fri, 16 Feb 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077361; cv=none; b=PEQqjSyaEKkE70gFC5JwlL2p9gf7LhoykJC/NKmEBd8jgoF/GoINugmTxs7JIPDxyjgah0ZMXzlwQU1c5flxi75Tdu3MDS17U4ONl8cHMWhaWdHDM11KKM7Ad57Sr7JnWt+Q2ob29b53NZA9HTJPVySDMS4nldm4YhRpicCVkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077361; c=relaxed/simple;
	bh=xgYFhDkLlDkmJ2Peor8dKdjKgLIjBY3iAHIOx/cPJl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mfc6MP2hUrc6Or3m7ADmQSbNYdjOcF5DQF/32NPWwtfppo1ecQZNDu3QIZEounRfhvU31QSMG9zPRbJCCw13A7qaLWW0I4WTGhLJEGSky7jJ+EzCU+VwX8nrq8QfC/WjXwjUG6ZAsQfv6er1BZ2/4pits1vmbCT7ZjSlyTfm6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=o/5KYOxQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9550AD4A;
	Fri, 16 Feb 2024 10:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708077353;
	bh=xgYFhDkLlDkmJ2Peor8dKdjKgLIjBY3iAHIOx/cPJl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/5KYOxQpAi4Lp8fMy9+HijROs8YE02v5FnQdRTR5qJC6D19+tZt/b0XAnATP+A7B
	 Gw+g9IJyZdTNPdLY643SHvx8aWErinRiZF46z6Qh5HaNY6UH1Q6FkxYxTc/9o2H7lY
	 KZfwwJuFBidMdonJEQmQRcfbsLLrAVsFSlq5hjeY=
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
Subject: [PATCH v12 08/12] media: rkisp1: Support i.MX8MP's 34-bit DMA
Date: Fri, 16 Feb 2024 18:54:54 +0900
Message-Id: <20240216095458.2919694-9-paul.elder@ideasonboard.com>
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

On the ISP that is integrated in the i.MX8MP, DMA addresses have been
extended to 34 bits, with the 32 MSBs stored in the DMA address
registers and the 2 LSBs set to 0.

To support this:
- Shift the addresses to the right by 2 when writing to registers
- Set the dma mask to 34 bits
- Use dma_addr_t instead of u32 when storing the addresses

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes since v5:

- Improve the commit message

Changes since v4:

- Squash in fix from Tomi:
  - https://gitlab.com/ideasonboard/nxp/linux/-/commit/d6477fe673b1c0d05d12ae21d8db9a03b07e7fea

Changes since v2:

- Document the RKISP1_FEATURE_DMA_34BIT bit
- Use the rkisp1_has_feature() macro
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 20 ++++++++++---------
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  4 +++-
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  8 ++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index ca95f62822fa..1ee7639c42b7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -648,11 +648,13 @@ static void rkisp1_dummy_buf_destroy(struct rkisp1_capture *cap)
 
 static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 {
+	u8 shift = rkisp1_has_feature(cap->rkisp1, DMA_34BIT) ? 2 : 0;
+
 	cap->buf.curr = cap->buf.next;
 	cap->buf.next = NULL;
 
 	if (!list_empty(&cap->buf.queue)) {
-		u32 *buff_addr;
+		dma_addr_t *buff_addr;
 
 		cap->buf.next = list_first_entry(&cap->buf.queue, struct rkisp1_buffer, queue);
 		list_del(&cap->buf.next->queue);
@@ -660,7 +662,7 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 		buff_addr = cap->buf.next->buff_addr;
 
 		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
-			     buff_addr[RKISP1_PLANE_Y]);
+			     buff_addr[RKISP1_PLANE_Y] >> shift);
 		/*
 		 * In order to support grey format we capture
 		 * YUV422 planar format from the camera and
@@ -669,17 +671,17 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 		if (cap->pix.cfg->fourcc == V4L2_PIX_FMT_GREY) {
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cb_base_ad_init,
-				     cap->buf.dummy.dma_addr);
+				     cap->buf.dummy.dma_addr >> shift);
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cr_base_ad_init,
-				     cap->buf.dummy.dma_addr);
+				     cap->buf.dummy.dma_addr >> shift);
 		} else {
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cb_base_ad_init,
-				     buff_addr[RKISP1_PLANE_CB]);
+				     buff_addr[RKISP1_PLANE_CB] >> shift);
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cr_base_ad_init,
-				     buff_addr[RKISP1_PLANE_CR]);
+				     buff_addr[RKISP1_PLANE_CR] >> shift);
 		}
 	} else {
 		/*
@@ -687,11 +689,11 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 		 * throw data if there is no available buffer.
 		 */
 		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
-			     cap->buf.dummy.dma_addr);
+			     cap->buf.dummy.dma_addr >> shift);
 		rkisp1_write(cap->rkisp1, cap->config->mi.cb_base_ad_init,
-			     cap->buf.dummy.dma_addr);
+			     cap->buf.dummy.dma_addr >> shift);
 		rkisp1_write(cap->rkisp1, cap->config->mi.cr_base_ad_init,
-			     cap->buf.dummy.dma_addr);
+			     cap->buf.dummy.dma_addr >> shift);
 	}
 
 	/* Set plane offsets */
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 69940014d597..26573f6ae575 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -114,6 +114,7 @@ enum rkisp1_isp_pad {
  * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
  * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
  * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
+ * @RKISP1_FEATURE_DMA_34BIT: The ISP uses 34-bit DMA addresses
  *
  * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
  * the driver to implement support for features present in some ISP versions
@@ -124,6 +125,7 @@ enum rkisp1_feature {
 	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
 	RKISP1_FEATURE_SELF_PATH = BIT(2),
 	RKISP1_FEATURE_DUAL_CROP = BIT(3),
+	RKISP1_FEATURE_DMA_34BIT = BIT(4),
 };
 
 #define rkisp1_has_feature(rkisp1, feature) \
@@ -239,7 +241,7 @@ struct rkisp1_vdev_node {
 struct rkisp1_buffer {
 	struct vb2_v4l2_buffer vb;
 	struct list_head queue;
-	u32 buff_addr[VIDEO_MAX_PLANES];
+	dma_addr_t buff_addr[VIDEO_MAX_PLANES];
 };
 
 /*
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index d0a3a13d9dd7..54a62487a4e8 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -552,6 +552,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rkisp1_device *rkisp1;
 	struct v4l2_device *v4l2_dev;
+	unsigned long long dma_mask;
 	unsigned int i;
 	int ret, irq;
 	u32 cif_id;
@@ -566,6 +567,13 @@ static int rkisp1_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, rkisp1);
 	rkisp1->dev = dev;
 
+	dma_mask = rkisp1_has_feature(rkisp1, DMA_34BIT) ? DMA_BIT_MASK(34) :
+							   DMA_BIT_MASK(32);
+
+	ret = dma_set_mask_and_coherent(dev, dma_mask);
+	if (ret)
+		return ret;
+
 	mutex_init(&rkisp1->stream_lock);
 
 	rkisp1->base_addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.39.2


