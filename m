Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E307FA74B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjK0Q6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjK0Q43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C7E26B1;
        Mon, 27 Nov 2023 08:55:40 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C478E6607405;
        Mon, 27 Nov 2023 16:55:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104139;
        bh=O6QoqjhfTjZ8fxwdlWAH4p8qUAwUTkwY0GJ5W4xynQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/wvnA4g8SOzv8+U7u+BimIdh8r0Q9ehMJ/zalV3OCNZ0eaUROvDxJLFCFy/iDvXx
         Aufoa9+saUnjG8XLitslPMAYIso9fXHIFqY9qXuEp6L3AU6nXoc8V8VVSqW+qGiJ7f
         AVuaudIEtx/IOqstj9+2TRxrs0edqDy8pC3Ie1Ex6AFoL0gpwGAVhypbUGGLMmpsXA
         f918axMhhez2P9p5jagX3maoc5/ojg/0wWafSFQBuG0YTAguWtP8LJ/iAagHnFmFTU
         KWVFZEVzJmWgJPa0ulOFGYGRz0Bw5PpWea7HVF5gobwiSSfP0p/4najE11F6WnBoN/
         1vRO9rY11s7WA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 43/55] media: pci: bt8xx: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:42 +0100
Message-Id: <20231127165454.166373-44-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bt8xx driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/pci/bt8xx/bttv-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 09a193bb87df..8a3fb30e73f6 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -3094,7 +3094,7 @@ static int vdev_init(struct bttv *btv, struct video_device *vfd,
 	q->gfp_flags = __GFP_DMA32;
 	q->buf_struct_size = sizeof(struct bttv_buffer);
 	q->lock = &btv->lock;
-	q->min_buffers_needed = 2;
+	q->min_dma_buffers_needed = 2;
 	q->dev = &btv->c.pci->dev;
 	err = vb2_queue_init(q);
 	if (err)
-- 
2.39.2

