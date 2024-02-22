Return-Path: <linux-kernel+bounces-76435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C271985F752
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0711F296E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492357336;
	Thu, 22 Feb 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WtlcC9am"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B856471;
	Thu, 22 Feb 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601639; cv=none; b=UlJALKChW7b+AR1pM+qNepFcS9/vPdNUZMVB8wgb9tzJrJEgFn/m6JrP5zYOi0fxb7b0IytBfpk3Ohl4SRbWG8aOiflbcziQd1tajIbk5nosZDiUFbc+5O6peYhVQ1jrIZUdly53OUoiA4tdTfhC9O4IsCV09ToVJS1hYxeQHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601639; c=relaxed/simple;
	bh=/GtmPjLiq5+SagkrfDQAkAZP5XRkWs7T9sGKIVhkkz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Qo7sSWTGa5/6ESs+jIpER050MymYdiU0sBVLo2xfbUCRFMmPRS66NHAmHFXa+iYqgM3xtQDehEc71wiuGMBLDHTL7fNHSk52n4M0qmlU/QheDQruuenx70rZHPhaMmPEE7yEv87N1xN9FY0mlJbzkwcdorL9UfrZLObthY7/4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WtlcC9am; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXk50027853;
	Thu, 22 Feb 2024 05:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601626;
	bh=Vlbz21goACtx1c8zMXtgD7uoZ9QnG6VdgKVSgHpupv8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=WtlcC9amfGGCuR1WryWRG8vcT8UQA4iOk70DW9csiMHCyI5cwdZ/Rp7cLPJfN43+i
	 owusU6Vw+I15sXQC5Mc2JEq+sWU42S/88MxS+rJzLeN0ai/BMQuxfwGpXzVMf86Iyj
	 yheibmUbAhRe6TyZq+du3OSEEuWi8I0CmmjPP5ps=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXkVR014493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:46 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:46 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXi5B091622;
	Thu, 22 Feb 2024 05:33:45 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:37 +0530
Subject: [PATCH RFC 21/21] media: ti: j721e-csi2rx: Submit all available
 buffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-21-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=/GtmPjLiq5+SagkrfDQAkAZP5XRkWs7T9sGKIVhkkz4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDuro/ycwjO5PCLQrJiQETtI9R/Rz8V16qhH
 NGhUvuH9NSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw7gAKCRBD3pH5JJpx
 RcEsEACXdlnzSwdPg09vRskjpB2V19aq2bTmJA5wMNKnsdqtyZms6Bks+K2NFIVccg7T1/kzOsW
 21J9BXbvl9kotNHmiC9Dym6GGPX8PwSeER9ta/k67oEp+jcLqNYx013SDvmirXcBYKYrDjOb+ZK
 PyW8Aey4CRxqsLVo84BfWikCJuU6HNIE2puO47t+iTEm106GAwZLJpPDLJZjUfHd5FmEtJmwf07
 GxK7+RFUfzaOkwgbNmg7qYMuL+UkMEBqONYDlMSopQhewlpGij1rsIVGsW5vLCcW1Dojq4WiPJj
 oItB+ePyFD9u5TGgSQM4oFeKZyDR5txG2VSuVbEkMlBWW6c/UVSIaNZppxUfDusr2DaOwYkpeJp
 LdfnNLEY75vdjHWlStzsNncC7n2ndrX3uHAs92XKsV8o7aXsfrHxOpl/xC/DbaPTVPVPMqt3Oce
 bTgrBXsX0fwr+um1f15uqHeXlGeDbEEtfBptF0zYPGutkfVdgDc1VcA5VP3NCHIVd7XCAIDinUT
 sNZWmtKUL5gU2x1/2bfEP7/C41y05IfuKLnqaTs4oTrkvp4QI7E1dA1+XZJiBo31NlTnxOuqKf+
 1s0zeZJK7Mk5e9BZ4FbNOSASxr64396RCo+TiU7XyvcpM2NKQ79DAybYUEbEzsIEDqPSXEY39rh
 +8lm46CyNyVOlnA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

We already make sure to submit all available buffers to DMA in each DMA
completion callback.

Move that logic in a separate function, and use it during stream start
as well, as most application queue all their buffers before stream on.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 43 ++++++++++++----------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 0b9e0852da9f..a682db099e6c 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -666,6 +666,27 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx)
 	return ret;
 }
 
+static int ti_csi2rx_dma_submit_pending(struct ti_csi2rx_ctx *ctx)
+{
+	struct ti_csi2rx_dma *dma = &ctx->dma;
+	struct ti_csi2rx_buffer *buf;
+	int ret = 0;
+
+	/* If there are more buffers to process then start their transfer. */
+	while (!list_empty(&dma->queue)) {
+		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
+		ret = ti_csi2rx_start_dma(ctx, buf);
+		if (ret) {
+			dev_err(ctx->csi->dev,
+				"Failed to queue the next buffer for DMA\n");
+			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+			break;
+		}
+		list_move_tail(&buf->list, &dma->submitted);
+	}
+	return ret;
+}
+
 static void ti_csi2rx_dma_callback(void *param)
 {
 	struct ti_csi2rx_buffer *buf = param;
@@ -686,18 +707,7 @@ static void ti_csi2rx_dma_callback(void *param)
 	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 	list_del(&buf->list);
 
-	/* If there are more buffers to process then start their transfer. */
-	while (!list_empty(&dma->queue)) {
-		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
-
-		if (ti_csi2rx_start_dma(ctx, buf)) {
-			dev_err(ctx->csi->dev,
-				"Failed to queue the next buffer for DMA\n");
-			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-		} else {
-			list_move_tail(&buf->list, &dma->submitted);
-		}
-	}
+	ti_csi2rx_dma_submit_pending(ctx);
 
 	if (list_empty(&dma->submitted))
 		dma->state = TI_CSI2RX_DMA_IDLE;
@@ -906,7 +916,6 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct ti_csi2rx_dma *dma = &ctx->dma;
-	struct ti_csi2rx_buffer *buf;
 	struct v4l2_subdev_krouting *routing;
 	struct v4l2_subdev_route *route = NULL;
 	struct media_pad *remote_pad;
@@ -972,16 +981,13 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	ctx->sequence = 0;
 
 	spin_lock_irqsave(&dma->lock, flags);
-	buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
 
-	ret = ti_csi2rx_start_dma(ctx, buf);
+	ret = ti_csi2rx_dma_submit_pending(ctx);
 	if (ret) {
-		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
 		spin_unlock_irqrestore(&dma->lock, flags);
-		goto err_pipeline;
+		goto err_dma;
 	}
 
-	list_move_tail(&buf->list, &dma->submitted);
 	dma->state = TI_CSI2RX_DMA_ACTIVE;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
@@ -995,7 +1001,6 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 err_dma:
 	ti_csi2rx_stop_dma(ctx);
-err_pipeline:
 	video_device_pipeline_stop(&ctx->vdev);
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));

-- 
2.43.0


