Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001807FA711
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjK0Qzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjK0Qz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76868D6D;
        Mon, 27 Nov 2023 08:55:18 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5A7B6607285;
        Mon, 27 Nov 2023 16:55:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104117;
        bh=OM1rMpAHnewxMwYLehpH3RhyuQD/KBKxUNIY9psBF1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwt0rlRF5iVZMWkF95dc1OcXj7QgqBO+VsnS6mYiSFfym4uFTTI8NqV4IKo9OAOi2
         BgLUy2d833QU1yJIuPlXwlS4MBFA0HY55MFYS6lgkk3bHxkhwEx+xErqkm4ur/A1lQ
         ZQFyRw31dlwXCcpKi+xdvQu3FQ1q7jvp75h4mNw1JddQy/KM4X0qyiRy6krj/vCFiz
         qV+PnfSpf2z4ZGk2VYpG3gfqTTPxvbLCmsOlvjdqs+HmfiFd2UdukfBxHHAusTxRxt
         fC/ha/eaO4+z4Xh8XOtXPNbX9co2oTScIZl2imvhFlFYOZapLYuvQovGEXbJeQTMVC
         ria//pNugEYag==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH 15/55] media: amphion: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:14 +0100
Message-Id: <20231127165454.166373-16-benjamin.gaignard@collabora.com>
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
amphion driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Ming Qian <ming.qian@nxp.com>
CC: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 87afb4a18d5d..1e4c76032d2b 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -649,7 +649,7 @@ static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_q
 		src_vq->mem_ops = &vb2_vmalloc_memops;
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_reqbufs_allocation = 1;
 	src_vq->dev = inst->vpu->dev;
 	src_vq->lock = &inst->lock;
 	ret = vb2_queue_init(src_vq);
@@ -666,7 +666,7 @@ static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_q
 		dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
-	dst_vq->min_buffers_needed = 1;
+	dst_vq->min_reqbufs_allocation = 1;
 	dst_vq->dev = inst->vpu->dev;
 	dst_vq->lock = &inst->lock;
 	ret = vb2_queue_init(dst_vq);
-- 
2.39.2

