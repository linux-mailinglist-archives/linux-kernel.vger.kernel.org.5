Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF37FA6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjK0Qze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjK0Qz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB93D5B;
        Mon, 27 Nov 2023 08:55:15 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AD836607323;
        Mon, 27 Nov 2023 16:55:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104114;
        bh=q+PBOieh7TUOZfOTD/eax3kPGizf1naDWVCgdVzk/Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJ2rDmOHuYC+RuIZhYXo8DzC0Rkky/qSkpSFNsGMMVKLXohgncgJ1VcjJ74ikJGtf
         pY+o9OAvZ02fx9XYYChpfQcBnLpuhwM0fXK8/MYElMkedofzaOuGcYCgGIGgD9L3/t
         Qfqaciz57Axsq9LOu5/sBoxUQbbYMlFof/CVjj1OHKZnXjIhLO2lhxnpDDLE9KhY1q
         rCMIlMoSpiJy5nHB+B5Qpfv51KH3hA8Y28gS7RQFBGvGvtaHEvY8HKUFMR2m21KaLd
         qDYw4OTcBnjIUkRd6LlPfmV7RjT1KDoCeaKCHbUzFubxnZFKp5UK+/Ug0zAxL588t3
         o9asdDeXrRa9A==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
Subject: [PATCH 11/55] media: sti: hva: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:10 +0100
Message-Id: <20231127165454.166373-12-benjamin.gaignard@collabora.com>
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

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
hva driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
---
 drivers/media/platform/st/sti/hva/hva-v4l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
index cfe83e9dc01b..d7bc25b0d69e 100644
--- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
+++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
@@ -1142,7 +1142,7 @@ static int hva_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
 	src_vq->buf_struct_size = sizeof(struct hva_frame);
-	src_vq->min_buffers_needed = MIN_FRAMES;
+	src_vq->min_reqbufs_allocation = MIN_FRAMES;
 	src_vq->dev = ctx->hva_dev->dev;
 
 	ret = queue_init(ctx, src_vq);
@@ -1151,7 +1151,7 @@ static int hva_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	dst_vq->buf_struct_size = sizeof(struct hva_stream);
-	dst_vq->min_buffers_needed = MIN_STREAMS;
+	dst_vq->min_reqbufs_allocation = MIN_STREAMS;
 	dst_vq->dev = ctx->hva_dev->dev;
 
 	return queue_init(ctx, dst_vq);
-- 
2.39.2

