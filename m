Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D997B6415
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbjJCIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbjJCIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74A124;
        Tue,  3 Oct 2023 01:07:31 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:b6df:b784:6a0f:8451])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 808EF6607327;
        Tue,  3 Oct 2023 09:07:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696320449;
        bh=MYUuJWbv+ZXdDCGlYiYfyK0RcIjAuLHGgJwZJ+iw65U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aouIgfHUpZ34XMtP486egUVR8pDgPO7TclzgII3ekgLNikTOpAI2UpcEAC7LLwSH7
         D89yIlTrqRBJBVUgNynJm4jABlV9JXe8NwU3MkdLvU9JqpuHZwKHVSAM20+UN7E4my
         vKBNekMVXQKK9IE3rXLp1doGJvHzdnpJ1+xR+Dzymw6uxxaPDMrfW7jVt/vYpPO8K5
         ars2ELVawrq7HymAUbvuO8AMNUOY+KSjHyZ6JDRCTCdefdAFOLaEDfCox2pFrE1LOb
         sJ4DaKDcGlWcLGARps36iPnYBSgpqrvOEyDft22Ox0RqD5qVZJI963hREHDylSiUhj
         JIsaci3tkkXQw==
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
Subject: [PATCH v10 32/54] media: mediatek: vcodec: Stop direct calls to queue num_buffers field
Date:   Tue,  3 Oct 2023 10:06:41 +0200
Message-Id: <20231003080704.43911-33-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
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

se vb2_get_num_buffers() to avoid using queue num_buffers field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
index 04948d3eb011..8c580956b905 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
@@ -923,7 +923,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 		mtk_v4l2_venc_err(ctx, "pm_runtime_put fail %d", pm_ret);
 
 err_start_stream:
-	for (i = 0; i < q->num_buffers; ++i) {
+	for (i = 0; i < q->max_num_buffers; ++i) {
 		struct vb2_buffer *buf = vb2_get_buffer(q, i);
 
 		/*
-- 
2.39.2

