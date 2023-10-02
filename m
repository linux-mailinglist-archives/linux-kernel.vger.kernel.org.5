Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0167B5285
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbjJBMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbjJBMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:06:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A1E9;
        Mon,  2 Oct 2023 05:06:44 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D7C1660731B;
        Mon,  2 Oct 2023 13:06:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696248403;
        bh=RTtrEWB+iCCua3F+YDyTtBODpNsAwbuQk2kDkvELWIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9MuuvaVQBy3u93YZ05RdLvVIEA1QanG9CwU5BFxKw/t0UKzW6lgYKXVUrP/KywYl
         YXJnIvA+mLA3Siz+tZXcwej+IZWL4FXiyF4MigqKKTHRIQTsNhWBcazE90GS1OJC2d
         iXzfeKvuJz+Hw+JjUvJPm4yimqdteLwQ+yK61uPjmP4AnkmKd6/R8s1xWn2+FZFY7F
         MEQaND3XzxBSgmFI9p4hAXGH2FF48PcDuOFiSSW9TXBkFeOEStLujzEjBCU9+lxuMP
         VWziQzsPm1VwGE68326/W9ljDyFXdtfJcBf+a1wZqNNwTpBldQaGAukGI4wGQs6HHJ
         B45TrPB7Rcnqg==
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
Subject: [PATCH v9 34/53] media: renesas: Set min_buffers_needed to 16
Date:   Mon,  2 Oct 2023 14:05:58 +0200
Message-Id: <20231002120617.119602-35-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
References: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
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
---
 drivers/media/platform/renesas/rcar_drif.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index 163a4ba61c17..8a9a70565d3f 100644
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
@@ -1311,6 +1307,8 @@ static int rcar_drif_sdr_probe(struct rcar_drif_sdr *sdr)
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

