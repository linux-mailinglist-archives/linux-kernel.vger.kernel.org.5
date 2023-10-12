Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F717C6D47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbjJLLsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378658AbjJLLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864D124;
        Thu, 12 Oct 2023 04:47:06 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D47F96607386;
        Thu, 12 Oct 2023 12:47:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111225;
        bh=51uRb95lmgtzN6hPPISI8XHQeJXuX3+AzrSS67M/f6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gt4nc0txfNVIZ5gk4/sqZ4qB2MaTfQYsWPhxWnma3yviaHOoARF6sXyzRJQqcO8Ou
         XTEAtThthuhUpmbSiRuoovR62A4gy/9MJ8/7brNgOXyfIqXGQCUcR/peYoJGA/2lV0
         Z9vAeqBAXyTu7CBu6KxUgbS2Q1gHaAfosZtAX6AwGHCqrpP1m1SXj17i8IzP5iDUGh
         G3OZaWgQg60lJGtoYrK7Ojy62GGP601fLQ42VL2fzdALe+zUaGUxyPvSFyNtKID3qP
         SR7pFSjVWzGBjGtXWYmY8LuPddgpfsOvoev0Wod6oVczcObQtZhTUb4igjZ1ftwAnC
         4roVOh35d8nIg==
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
Subject: [PATCH v11 29/56] media: renesas: Set min_buffers_needed to 16
Date:   Thu, 12 Oct 2023 13:46:15 +0200
Message-Id: <20231012114642.19040-30-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2 queue_setup checks for a minimum number of buffers so set
min_buffers_needed to 16 and remove the useless check in
rcar_drif_queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/renesas/rcar_drif.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index 292c5bf9e50c..bb84fc089d5d 100644
--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -425,13 +425,9 @@ static int rcar_drif_queue_setup(struct vb2_queue *vq,
 {
 	struct rcar_drif_sdr *sdr = vb2_get_drv_priv(vq);
 
-	/* Need at least 16 buffers */
-	if (vq->num_buffers + *num_buffers < 16)
-		*num_buffers = 16 - vq->num_buffers;
-
 	*num_planes = 1;
 	sizes[0] = PAGE_ALIGN(sdr->fmt->buffersize);
-	rdrif_dbg(sdr, "num_bufs %d sizes[0] %d\n", *num_buffers, sizes[0]);
+	rdrif_dbg(sdr, "num_bufs %u sizes[0] %d\n", vb2_get_num_buffers(vq), sizes[0]);
 
 	return 0;
 }
@@ -1310,6 +1306,8 @@ static int rcar_drif_sdr_probe(struct rcar_drif_sdr *sdr)
 	/* Init videobuf2 queue structure */
 	sdr->vb_queue.type = V4L2_BUF_TYPE_SDR_CAPTURE;
 	sdr->vb_queue.io_modes = VB2_READ | VB2_MMAP | VB2_DMABUF;
+	/* Need at least 16 buffers */
+	sdr->vb_queue.min_buffers_needed = 16;
 	sdr->vb_queue.drv_priv = sdr;
 	sdr->vb_queue.buf_struct_size = sizeof(struct rcar_drif_frame_buf);
 	sdr->vb_queue.ops = &rcar_drif_vb2_ops;
-- 
2.39.2

