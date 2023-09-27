Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66917B08D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjI0Phb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjI0Pg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C7CC6;
        Wed, 27 Sep 2023 08:36:20 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D437E6607353;
        Wed, 27 Sep 2023 16:36:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828979;
        bh=uLtpgbM1S6TEQd3BheD+tuaw3lVo9oisDECpkyjdDDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+L84mcHo60rVTDABPpaqi9turpx6HRLsClDamnQGpQrKfTz+xkRtnEbxp/La5GHI
         Ljl25UOwbiCeibBWFAKjFVz/TAeZJfA1JARxGSiyrUxI9JrczK5IcWpncpQ3PSH/bi
         Se3jPRQNPSBmTLcExTEJe6AcwgkVMxfPLBxoG0+TUhWm2PbJzg9x/cHeJJ+VHvDkKA
         Sb920qcy5xUk83izC9jTaNrun3MxL71COaloMEcHwupLV1xnh5W5eN8vCXGUl7uQwu
         SiH+oRyBYyvgzzDhaxS+o+837rtORFjoHodqSzZymuWfGlbYOi6rKig+j+n5aMdP9z
         uSJUnAeJ4Ir0g==
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
Subject: [PATCH v8 24/53] media: video-i2c: Set min_buffers_needed to 2
Date:   Wed, 27 Sep 2023 17:35:29 +0200
Message-Id: <20230927153558.159278-25-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
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

vb2 queue_setup checks for a minimum number of buffers so set
min_buffers_needed to 2 and remove the useless check in video-i2c
queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/i2c/video-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 537ebd9fa8d7..5692d0b529d7 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -406,9 +406,6 @@ static int queue_setup(struct vb2_queue *vq,
 	struct video_i2c_data *data = vb2_get_drv_priv(vq);
 	unsigned int size = data->chip->buffer_size;
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2;
-
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
 
@@ -798,7 +795,7 @@ static int video_i2c_probe(struct i2c_client *client)
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->drv_priv = data;
 	queue->buf_struct_size = sizeof(struct video_i2c_buffer);
-	queue->min_buffers_needed = 1;
+	queue->min_buffers_needed = 2;
 	queue->ops = &video_i2c_video_qops;
 	queue->mem_ops = &vb2_vmalloc_memops;
 
-- 
2.39.2

