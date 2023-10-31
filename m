Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E27DD1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbjJaQe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346157AbjJaQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:34:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC321BFC;
        Tue, 31 Oct 2023 09:32:31 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c562:2ef4:80c0:92f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 921DD66073AF;
        Tue, 31 Oct 2023 16:32:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698769949;
        bh=ctJwIFCoy8onwGJKVxQ8/AgSsQL3q8AbAm0x7jyK8jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpTYYjoec2BVqLecNDQ9vK9qYIrv/wDzLm84b8cncKHIDPVneanEdSkC2ebz3VEh3
         UgxjEdt+xXVIiSlDpARUTv+vRR4Xi57cDsiyT+byAI+Hsu7QnN3k0Mky00LmFg3zEv
         gFv72iWCN+J15cGp/lonk42hCYjHdUvggeCYoVq4vPeN7rJChOFFiJ57m+pm4ddOXU
         dQ9sqlITzxWVeNjnjmtoUgjEn35SFiR5VN4R6fU8XnF3zShsrmF3DxQO9jrtLrkzgX
         DCQnLl5mgrO+Fag6FYfQCWW/0sGkm3FnFDAQ0e3s3tiUYI1uyhrmjqgY4uIDdnyqiB
         1XFGoCWF5Y4tQ==
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
Subject: [PATCH v14 40/56] media: usb: cx231xx: Stop direct calls to queue num_buffers field
Date:   Tue, 31 Oct 2023 17:30:48 +0100
Message-Id: <20231031163104.112469-41-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/usb/cx231xx/cx231xx-417.c   | 5 +++--
 drivers/media/usb/cx231xx/cx231xx-video.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index fe4410a5e128..45973fe690b2 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1218,12 +1218,13 @@ static int queue_setup(struct vb2_queue *vq,
 {
 	struct cx231xx *dev = vb2_get_drv_priv(vq);
 	unsigned int size = mpeglinesize * mpeglines;
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	dev->ts1.ts_packet_size  = mpeglinesize;
 	dev->ts1.ts_packet_count = mpeglines;
 
-	if (vq->num_buffers + *nbuffers < CX231XX_MIN_BUF)
-		*nbuffers = CX231XX_MIN_BUF - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < CX231XX_MIN_BUF)
+		*nbuffers = CX231XX_MIN_BUF - q_num_bufs;
 
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
index e23b8ccd79d4..c8eb4222319d 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -714,11 +714,12 @@ static int queue_setup(struct vb2_queue *vq,
 		       unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct cx231xx *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	dev->size = (dev->width * dev->height * dev->format->depth + 7) >> 3;
 
-	if (vq->num_buffers + *nbuffers < CX231XX_MIN_BUF)
-		*nbuffers = CX231XX_MIN_BUF - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < CX231XX_MIN_BUF)
+		*nbuffers = CX231XX_MIN_BUF - q_num_bufs;
 
 	if (*nplanes)
 		return sizes[0] < dev->size ? -EINVAL : 0;
-- 
2.39.2

