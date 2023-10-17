Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F247CC7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJQPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbjJQOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C5A1AD;
        Tue, 17 Oct 2023 07:48:24 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC2E86607367;
        Tue, 17 Oct 2023 15:48:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554103;
        bh=4+G+ZvYPKr/Dnh+XVk1Qk/BAjD/ZzHkZphjgv/jA4CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD/Pl8C5XYpEYERlgScQlBCeYSobkd5BQbAx7O/zBNm9vOOVh4ql2NVYhazOis4fi
         oofj0PqV/hBXs/rhcY3TugHdtx5VlDxdTYTcnsWBwhduTmp/xLyboinAYgrSv9CGdQ
         6hWThQ6Ow3+K2kp6LL2yYe8sb42RTDMHcVnO07AB8f11XiMx3lQszkv/d0MyN7tuwv
         D9TVanqFRnZcw4iWCzRW9gyKqXfikhbyXzYOetatzq5V28fQkA/Oxiq8qTgT1MJY9k
         yUUtk9BTqrUm+hbZYSk7+2iTxNNytrXOtLo4NOTlU/olasrzFvtQ+MKOJe8CQIsxT0
         0LDvVwkLCCg/Q==
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
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v12 37/56] media: renesas: Stop direct calls to queue num_buffers field
Date:   Tue, 17 Oct 2023 16:47:37 +0200
Message-Id: <20231017144756.34719-38-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
futur.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/media/platform/renesas/rcar_drif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index 292c5bf9e50c..f21d05054341 100644
--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -424,10 +424,11 @@ static int rcar_drif_queue_setup(struct vb2_queue *vq,
 			unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct rcar_drif_sdr *sdr = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	/* Need at least 16 buffers */
-	if (vq->num_buffers + *num_buffers < 16)
-		*num_buffers = 16 - vq->num_buffers;
+	if (q_num_bufs + *num_buffers < 16)
+		*num_buffers = 16 - q_num_bufs;
 
 	*num_planes = 1;
 	sizes[0] = PAGE_ALIGN(sdr->fmt->buffersize);
-- 
2.39.2

