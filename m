Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7297A05E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbjINNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbjINNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:33:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68D1BF8;
        Thu, 14 Sep 2023 06:33:42 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81ACF660734B;
        Thu, 14 Sep 2023 14:33:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698420;
        bh=orO42HgJZVmG5GsbDRr5p5aAYmAqR4f3jKdoimxCmR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEyKLGVxdNGIKeLMpz746kqo6Ve+WUl2NaNIpmLz08Xw4NXo6f3Gc+8JDHzt45sC2
         BxamcwujM4l70xCIk0N+RjcA65h0NI4FnWqOfvPckyIa/R1SjIh63Xy8JkCtBmE6Tu
         tU9B8pJSm6Zvp/xCBnWU6IGAeUCRisISM8Xm57/PKT2jCAkgJEQBYAqoGqwVDKM1th
         EgcCyrb4S5gGIgS3P1306A7+0y6a03yUgJDstwdbiiD5DxZpwfNAQ8+Q+BLo6Z3acQ
         +VWLGLVn7lS+vvmwKPDhFceFJ9UjZeioznviCP+ph00kMU2B/MBXVeSgJnjAVw4YWV
         GQc8A6hsuyc4Q==
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
Subject: [PATCH v7 18/49] media: Remove duplicated index vs q->num_buffers check
Date:   Thu, 14 Sep 2023 15:32:52 +0200
Message-Id: <20230914133323.198857-19-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2_get_buffer() already check if the requested index is valid.
Stop duplicating this kind of check everywhere.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c |  8 ++++++++
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 13 -------------
 include/media/videobuf2-core.h                  |  8 +-------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index ee4df7c68397..2add7a6795e7 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -660,6 +660,14 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 	}
 }
 
+struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
+{
+	if (index < q->num_buffers)
+		return q->bufs[index];
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vb2_get_buffer);
+
 bool vb2_buffer_in_use(struct vb2_queue *q, struct vb2_buffer *vb)
 {
 	unsigned int plane;
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 87c2d5916960..f10b70d8e66a 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -378,11 +378,6 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 		return -EINVAL;
 	}
 
-	if (b->index >= q->num_buffers) {
-		dprintk(q, 1, "%s: buffer index out of range\n", opname);
-		return -EINVAL;
-	}
-
 	vb = vb2_get_buffer(q, b->index);
 	if (!vb) {
 		dprintk(q, 1, "%s: buffer is NULL\n", opname);
@@ -829,10 +824,6 @@ int vb2_qbuf(struct vb2_queue *q, struct media_device *mdev,
 		return -EBUSY;
 	}
 
-	if (b->index >= q->num_buffers) {
-		dprintk(q, 1, "buffer index out of range\n");
-		return -EINVAL;
-	}
 	vb = vb2_get_buffer(q, b->index);
 	if (!vb) {
 		dprintk(q, 1, "can't find the requested buffer\n");
@@ -904,10 +895,6 @@ int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb)
 {
 	struct vb2_buffer *vb;
 
-	if (eb->index >= q->num_buffers) {
-		dprintk(q, 1, "buffer index out of range\n");
-		return -EINVAL;
-	}
 	vb = vb2_get_buffer(q, eb->index);
 	if (!vb) {
 		dprintk(q, 1, "can't find the requested buffer\n");
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 97153c69583f..25ca395616a7 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1238,13 +1238,7 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
  * operation, so the buffer lifetime should be taken into
  * consideration.
  */
-static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
-						unsigned int index)
-{
-	if (index < q->num_buffers)
-		return q->bufs[index];
-	return NULL;
-}
+struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index);
 
 /*
  * The following functions are not part of the vb2 core API, but are useful
-- 
2.39.2

