Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF63803476
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbjLDNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbjLDNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FDF3;
        Mon,  4 Dec 2023 05:23:43 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A05C66071CC;
        Mon,  4 Dec 2023 13:23:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696222;
        bh=vUKzmdehCfLCcwbM7gaKkVboVYXsxqKFA6kaBbI0L2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPPjIMOunjZNuH8fAjPP3b4mSMCV/NHPckS3LjK+bXSYdCykIk5tD/FGV9U+H/5BR
         m01dBoNIjvgtGuQ3gycq515tlISsPaWjtLe1l1HCvCUuzbKHYMfRmzn1Yqf2oUMFFo
         UnOxQa3CzjSVhOlkDrK40q/eNTj9/3QcyAcxPhfgEdavnwo7rrJTEAPLUdGnN5gnbG
         ia8NC9nuPQbrn98fm+9YJKNZrlzbyIh+IT2bAQClJ7hgJqqvN08+t5efAoom6JLvXd
         0Vog+unbItWp5hnYhKxsWoojzQY0GHbQ2HcPaVEYfjhxYGUM/gMewLLC0a6GDP+R3m
         Tq0BN32TcXvRg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v2 04/36] media: amphion: Remove useless setting of min_buffers_needed
Date:   Mon,  4 Dec 2023 14:22:51 +0100
Message-Id: <20231204132323.22811-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
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

This driver uses min_buffers_needed which vb2 uses to ensure
start_streaming is called when at least 'min_buffers_needed'
buffers are queued. However, this driver doesn't need this,
it can stream fine without any buffers queued.
Just drop this unnecessary restriction.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Ming Qian <ming.qian@nxp.com>
CC: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 87afb4a18d5d..a80c5f28c659 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -649,7 +649,6 @@ static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_q
 		src_vq->mem_ops = &vb2_vmalloc_memops;
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
-	src_vq->min_buffers_needed = 1;
 	src_vq->dev = inst->vpu->dev;
 	src_vq->lock = &inst->lock;
 	ret = vb2_queue_init(src_vq);
@@ -666,7 +665,6 @@ static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_q
 		dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
-	dst_vq->min_buffers_needed = 1;
 	dst_vq->dev = inst->vpu->dev;
 	dst_vq->lock = &inst->lock;
 	ret = vb2_queue_init(dst_vq);
-- 
2.39.2

