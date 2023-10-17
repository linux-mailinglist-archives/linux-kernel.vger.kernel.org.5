Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5547CC671
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjJQOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbjJQOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE83F5;
        Tue, 17 Oct 2023 07:48:10 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCE4D6607332;
        Tue, 17 Oct 2023 15:48:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554089;
        bh=U25RUhgn4wrEJgYWeqq/JM19FcBBlklJam1nCiVEFHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqZ9XsqiSxFieCoTOSfrwoM6jWbx6X6LXQX4J/a/Na6cA6rdj43RjZog9jDAy0uSJ
         YG3ePuhpjpKJ7SLzh4H5DkASJ8/evWIK0XBIyVWk1rgu9wV7abpAPl0QzviTnACro8
         iUL9HfBAbb8zPzTHlV+2CTDKbc9LGlCPJajN4gFFK0JAdbzk3U6WIkEKXlnxs5KwVt
         QT3Uxj4iaEvr46nalQQnTerHqnyICHRCoQRIi9CW0aFUK+nmn9TOMHLUMn8qZ+4CZ1
         o3UYTe1h/zA5PTutDYwyydSqdxWVQArnYj0O3ypesRNrFK58lFQPAvyFtOJnO+Ro7o
         l1NzedljNDEtA==
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
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v12 11/56] media: mediatek: jpeg: Use vb2_get_buffer() instead of directly access to buffers array
Date:   Tue, 17 Oct 2023 16:47:11 +0200
Message-Id: <20231017144756.34719-12-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_buffer() instead of direct access to the vb2_queue bufs array.
This allows us to change the type of the bufs in the future.
After each call to vb2_get_buffer() we need to be sure that we get
a valid pointer so check the return value of all of them.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Bin Liu <bin.liu@mediatek.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 7194f88edc0f..73a063b1569b 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -598,12 +598,11 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
 		goto end;
 
 	vq = v4l2_m2m_get_vq(fh->m2m_ctx, buf->type);
-	if (buf->index >= vq->num_buffers) {
-		dev_err(ctx->jpeg->dev, "buffer index out of range\n");
+	vb = vb2_get_buffer(vq, buf->index);
+	if (!vb) {
+		dev_err(ctx->jpeg->dev, "buffer not found\n");
 		return -EINVAL;
 	}
-
-	vb = vq->bufs[buf->index];
 	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
 	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
 
-- 
2.39.2

