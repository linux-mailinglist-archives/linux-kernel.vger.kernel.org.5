Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE07DD1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjJaQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345426AbjJaQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:31:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3824133;
        Tue, 31 Oct 2023 09:31:31 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c562:2ef4:80c0:92f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4998266073B3;
        Tue, 31 Oct 2023 16:31:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698769890;
        bh=U25RUhgn4wrEJgYWeqq/JM19FcBBlklJam1nCiVEFHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM6SdU764gmV7W9zfq0bWi+KO5x5LCplcW8lcbaj+kCna2NqXwR+POH8B9lgZ8CBF
         ZOrCUSZ4glH3rnDjNIsBkXAJVBbInrLLhqelhLgweIRRVR79Os61k6cSEPZrKm/bqR
         E8Q1mM3fs/b3Y/1xGUAFN6k0jD9CfC1AhsQo+JoE3jA6gjfXwBEtEWIzvqnx0LO1ZD
         fRe6oCJWD9Tc1GS971+1Of4OxNKQQZbdFZ0OnGEkFnrnIUrMGAq2n/nve9P0aXnOU9
         jKvUVk+huaTfo0gvDxLQKTuf1I+WrplWm9VGO1LyOrQhflErW1TGORrpYWtSibyhOz
         BkoNQ/ZGU839A==
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
Subject: [PATCH v14 11/56] media: mediatek: jpeg: Use vb2_get_buffer() instead of directly access to buffers array
Date:   Tue, 31 Oct 2023 17:30:19 +0100
Message-Id: <20231031163104.112469-12-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

