Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01BF7A0626
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbjINNfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbjINNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:35:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1D1FE5;
        Thu, 14 Sep 2023 06:33:55 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2AD386607397;
        Thu, 14 Sep 2023 14:33:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698434;
        bh=yoC4Zwhq5KTur5ZjSqFZrMNs6UvSbNFXWhR9MCqzlE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EN1kyPC5ZKZ0JvmFCHlIc1mglG9qMNrLetcPCcD67N4xE1hTklCKDCBTvVfTSBYtU
         4VNAqqLMDJojsiDBr9PfSg4Kt/L5wOkzMHIp7Usvkg/OS+8DY4qa1pvR2N7afmXPyC
         NPow5YjSKRGIxTyvDgTgfOMCCa1zzZFqt6bl9BATFAck5lp7Bimj7Aas9Pf+8xC0Tq
         3NLcbDX6LdHM4Xmh6JOa78HIpfZYGLmJWaZHRQGjuXwOpDpMKaH5y5+d9U+DCk+m8K
         9ABes+Pt0cxXhdedx+kGDyyVz/RVHpy946pJKhtX/sNhAZUv13kdwss33nLLep2094
         cH5Qa5D0y4jKg==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 44/49] media: cedrus: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:33:18 +0200
Message-Id: <20230914133323.198857-45-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 4 +++-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index dfb401df138a..bbe5802ea861 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -649,11 +649,13 @@ static void cedrus_h264_stop(struct cedrus_ctx *ctx)
 	struct cedrus_dev *dev = ctx->dev;
 	struct cedrus_buffer *buf;
 	struct vb2_queue *vq;
+	unsigned int q_num_bufs;
 	unsigned int i;
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	q_num_bufs = vb2_get_num_buffers(vq);
 
-	for (i = 0; i < vq->num_buffers; i++) {
+	for (i = 0; i < q_num_bufs; i++) {
 		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
 
 		if (buf->codec.h264.mv_col_buf_size > 0) {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index fc9297232456..533a38316686 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -865,11 +865,13 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
 	struct cedrus_dev *dev = ctx->dev;
 	struct cedrus_buffer *buf;
 	struct vb2_queue *vq;
+	unsigned int q_num_bufs;
 	unsigned int i;
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	q_num_bufs = vb2_get_num_buffers(vq);
 
-	for (i = 0; i < vq->num_buffers; i++) {
+	for (i = 0; i < q_num_bufs; i++) {
 		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
 
 		if (buf->codec.h265.mv_col_buf_size > 0) {
-- 
2.39.2

