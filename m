Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117527FA715
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjK0Q4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjK0Qzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6619B3;
        Mon, 27 Nov 2023 08:55:21 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D86466072C1;
        Mon, 27 Nov 2023 16:55:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104120;
        bh=QToV8lElzrqp6zWG2/Ij9Fy7YYCaGPBAPbmtKiSOV+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBGt7xdMVEDvZuVk9Ad14jb83KoEdPpGetmdJSap2lBA2z5MJ403Xorerc4Bnbt1J
         fMUQrg/YddUn0oxlaDoWJ8uL25YiWdqYKXzah8zc76vIuqATvru2IgmKIz3v4O/GE8
         md/ixY3FvptKrTjOwT0L6St5UlZvDV4DWTKm6ZOPPpwrEprsmKVRAnQBjz4wtiaNSp
         U1QUNctewxrMvCLj7IzvCbP3+xTxNvobqU3TZAnO9VZr5HD77oypyU6GEzcibztO5b
         p4Cat7dlxH/Sx+i9JGbFd3+rIlZJTGjE8ouelk/vcaO0fw0hSNhicljgodjU1Bw+x5
         uBbSq6hrdGDEw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 19/55] media: sun8i-rotate: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:18 +0100
Message-Id: <20231127165454.166373-20-benjamin.gaignard@collabora.com>
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
sun8i-rotate driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Samuel Holland <samuel@sholland.org>
---
 drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
index 0b025ec91826..14cd0afd7c6a 100644
--- a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
+++ b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
@@ -536,7 +536,7 @@ static int rotate_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	src_vq->drv_priv = ctx;
 	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_reqbufs_allocation = 1;
 	src_vq->ops = &rotate_qops;
 	src_vq->mem_ops = &vb2_dma_contig_memops;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
@@ -551,7 +551,7 @@ static int rotate_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	dst_vq->drv_priv = ctx;
 	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
-	dst_vq->min_buffers_needed = 2;
+	dst_vq->min_reqbufs_allocation = 2;
 	dst_vq->ops = &rotate_qops;
 	dst_vq->mem_ops = &vb2_dma_contig_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
-- 
2.39.2

