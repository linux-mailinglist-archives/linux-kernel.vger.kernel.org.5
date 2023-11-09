Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F487E7332
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbjKIVDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345247AbjKIVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:03:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC24239;
        Thu,  9 Nov 2023 13:03:27 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 55B4416F9;
        Thu,  9 Nov 2023 22:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563783;
        bh=oK58tgcoyg38J0Dq4OGc76mXK/hbRlzuovhuQYajoWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puu+jPwPfZFvKJNfQICRdZQm0DdIaZZlPMzqvOXstUdy3EydTpu/sOmMZqTp1/q1P
         cYLpsotW8oMll7X7oWV20x7T/hM07tm3mCgsOqlDsTb/gotV/YB9dulNgeuUrGENoL
         JBFfEey3DytCml2huYbLGvvMmoa/aFpjxOO/QepM=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 03/15] media: videobuf2: Allow exporting of a struct dmabuf
Date:   Thu,  9 Nov 2023 16:02:55 -0500
Message-ID: <20231109210309.638594-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

videobuf2 only allowed exporting a dmabuf as a file descriptor,
but there are instances where having the struct dma_buf is
useful within the kernel.

Split the current implementation into two, one step which
exports a struct dma_buf, and the second which converts that
into an fd.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 36 +++++++++++++------
 include/media/videobuf2-core.h                | 15 ++++++++
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 27aee92f3eea..8ba85c2db375 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2229,49 +2229,49 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
 	return -EINVAL;
 }
 
-int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
-		unsigned int index, unsigned int plane, unsigned int flags)
+struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
+				       unsigned int index, unsigned int plane,
+				       unsigned int flags)
 {
 	struct vb2_buffer *vb = NULL;
 	struct vb2_plane *vb_plane;
-	int ret;
 	struct dma_buf *dbuf;
 
 	if (q->memory != VB2_MEMORY_MMAP) {
 		dprintk(q, 1, "queue is not currently set up for mmap\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (!q->mem_ops->get_dmabuf) {
 		dprintk(q, 1, "queue does not support DMA buffer exporting\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (flags & ~(O_CLOEXEC | O_ACCMODE)) {
 		dprintk(q, 1, "queue does support only O_CLOEXEC and access mode flags\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (type != q->type) {
 		dprintk(q, 1, "invalid buffer type\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (index >= q->num_buffers) {
 		dprintk(q, 1, "buffer index out of range\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	vb = q->bufs[index];
 
 	if (plane >= vb->num_planes) {
 		dprintk(q, 1, "buffer plane out of range\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (vb2_fileio_is_active(q)) {
 		dprintk(q, 1, "expbuf: file io in progress\n");
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
 	}
 
 	vb_plane = &vb->planes[plane];
@@ -2283,9 +2283,23 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
 	if (IS_ERR_OR_NULL(dbuf)) {
 		dprintk(q, 1, "failed to export buffer %d, plane %d\n",
 			index, plane);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
+	return dbuf;
+}
+EXPORT_SYMBOL_GPL(vb2_core_expbuf_dmabuf);
+
+int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
+		    unsigned int index, unsigned int plane, unsigned int flags)
+{
+	struct dma_buf *dbuf;
+	int ret;
+
+	dbuf = vb2_core_expbuf_dmabuf(q, type, index, plane, flags);
+	if (IS_ERR(dbuf))
+		return PTR_ERR(dbuf);
+
 	ret = dma_buf_fd(dbuf, flags & ~O_ACCMODE);
 	if (ret < 0) {
 		dprintk(q, 3, "buffer %d, plane %d failed to export (%d)\n",
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b6a9d2ea372..cba4e495f6a2 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -925,6 +925,21 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type);
  */
 int vb2_core_streamoff(struct vb2_queue *q, unsigned int type);
 
+/**
+ * vb2_core_expbuf_dmabuf() - Export a buffer as a dma_buf structure
+ * @q:         videobuf2 queue
+ * @type:      buffer type
+ * @index:     id number of the buffer
+ * @plane:     index of the plane to be exported, 0 for single plane queues
+ * @flags:     flags for newly created file, currently only O_CLOEXEC is
+ *             supported, refer to manual of open syscall for more details
+ *
+ * Return: Returns the dmabuf pointer
+ */
+struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
+				       unsigned int index, unsigned int plane,
+				       unsigned int flags);
+
 /**
  * vb2_core_expbuf() - Export a buffer as a file descriptor.
  * @q:		pointer to &struct vb2_queue with videobuf2 queue.
-- 
2.41.0

