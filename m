Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A47B63C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbjJCIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbjJCIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444BFF;
        Tue,  3 Oct 2023 01:07:37 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:b6df:b784:6a0f:8451])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A6A4660735A;
        Tue,  3 Oct 2023 09:07:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696320455;
        bh=bradh2DjPo+ZZEdsMUYFEpcwZsisivarvW4Ps2cAzgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0D2D57CrGK1Vq6Jq3MCmxNDB3FLxQo+v75pWD0P0s3SCtGQUQcxEk9usaKmnDiys
         gSF2R3qROSVKa4G3IT6cdmCDuVcqzHumgPwCYUCZDXQ7v6IH4gyoPcJcxtNWZn8rTY
         kEB5lY0+on/qdl8+1CvBWeyqYJsAxMbpSPfrit0OSoxgLWqhg2JMgEX4CVLDrb7ZQs
         Y1ve9v38b4WmErZeO3BOjZS4TVBKvf2O83U4Cnve8g8CuuhRxXoqFmob4H5+tqtI/K
         l7B/Bl+AOo13I56EKpTlbxs3hOLHHilPqu3OryGEEFKLOHQ2hHJdGAFsRv+Vegk9PA
         ViiWuDk4JHlPA==
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
Subject: [PATCH v10 43/54] media: imx: Stop direct calls to queue num_buffers field
Date:   Tue,  3 Oct 2023 10:06:52 +0200
Message-Id: <20231003080704.43911-44-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/imx/imx-media-capture.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 4846078315ff..ce02199e7b1b 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -605,6 +605,7 @@ static int capture_queue_setup(struct vb2_queue *vq,
 {
 	struct capture_priv *priv = vb2_get_drv_priv(vq);
 	struct v4l2_pix_format *pix = &priv->vdev.fmt;
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned int count = *nbuffers;
 
 	if (vq->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
@@ -613,14 +614,14 @@ static int capture_queue_setup(struct vb2_queue *vq,
 	if (*nplanes) {
 		if (*nplanes != 1 || sizes[0] < pix->sizeimage)
 			return -EINVAL;
-		count += vq->num_buffers;
+		count += q_num_bufs;
 	}
 
 	count = min_t(__u32, VID_MEM_LIMIT / pix->sizeimage, count);
 
 	if (*nplanes)
-		*nbuffers = (count < vq->num_buffers) ? 0 :
-			count - vq->num_buffers;
+		*nbuffers = (count < q_num_bufs) ? 0 :
+			count - q_num_bufs;
 	else
 		*nbuffers = count;
 
-- 
2.39.2

