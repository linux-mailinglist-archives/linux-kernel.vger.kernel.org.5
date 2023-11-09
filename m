Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBF7E6FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjKIQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjKIQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742E4219;
        Thu,  9 Nov 2023 08:38:17 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8CD7766076BE;
        Thu,  9 Nov 2023 16:38:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547896;
        bh=8T4DdeHs6mpVgqmMv5KtofAn83k7sC5nyycBFLf4ldc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKwccqycl6+A3/fK7/ZrNuDxedUiPPpD3vwjj461IqxQF3phnExhMpTyZnPXSUWet
         U91MMOLQkF8qRR4iSM4ivpjWz+/bElQNcXHG0ZenSjshoBazaBgkMn1Y7i6z6dv5Z/
         NYScCpxIkrLTtu0zzcUmYSODbOu5RYKOMOa4gSfnvYS/O0lu0ndsp0xMcmlvEyIaWQ
         yXj5Wo5gnSzhE40X/j5TvDFO5A0LblgWgWdeoVEJphVbzPEmNRVGlQ4KIjqJ5igkGX
         HUWSCtB1OkgnN12uv8s7Ft4FLpibFkO7P9pou2YR3KfPlbfSz0NelSOM/qOmJiWiyT
         /gR13o7etPugQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v15 35/56] media: cedrus: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:51 +0100
Message-Id: <20231109163512.179524-36-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.
While at it, check the return value of vb2_get_buffer().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC: Maxime Ripard <mripard@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 9 +++++++--
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index dfb401df138a..3e2843ef6cce 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -653,8 +653,13 @@ static void cedrus_h264_stop(struct cedrus_ctx *ctx)
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-	for (i = 0; i < vq->num_buffers; i++) {
-		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
+	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
+
+		if (!vb)
+			continue;
+
+		buf = vb2_to_cedrus_buffer(vb);
 
 		if (buf->codec.h264.mv_col_buf_size > 0) {
 			dma_free_attrs(dev->dev,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index fc9297232456..52e94c8f2f01 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -869,8 +869,13 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-	for (i = 0; i < vq->num_buffers; i++) {
-		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
+	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
+
+		if (!vb)
+			continue;
+
+		buf = vb2_to_cedrus_buffer(vb);
 
 		if (buf->codec.h265.mv_col_buf_size > 0) {
 			dma_free_attrs(dev->dev,
-- 
2.39.2

