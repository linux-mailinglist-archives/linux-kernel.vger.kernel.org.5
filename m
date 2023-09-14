Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6397A062B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbjINNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbjINNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:35:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03D2D62;
        Thu, 14 Sep 2023 06:33:56 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30932660739B;
        Thu, 14 Sep 2023 14:33:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698435;
        bh=toYAovS+izT0LEoEizCbJtlr0mGm+eGtkX0GLil3vcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEps24M4VrGEsZjj534OIRuhGa5nrooJPEDbMc2XfeODZD/Snnj5GHpYmTeNJT9l+
         CnU62Cjhug0VYXFFocoTcbn5nVVz7hP+auojoUhN8d0sz0+dt5wdAcgRJyGvIHOZxs
         vCeZB7SShgrnW4lDf+dTiEik1PFHIThDnbFZMxPLLIB2BZR8K5+bOvZb955q3xuhx9
         56BPeGqp7XnfORhXvIKRsrY76WVS7I/k5Hdjk17tOl2cmfSRKgNs76OfI3XYNjMm4l
         xW6l0KS/HNEnfRoinzNpPeeTS9gcgrE2+B1lCiEu9EB4NTrO28oamIIUFNRIEB88yP
         ZS19F/X5nC2aA==
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
Subject: [PATCH v7 46/49] media: core: Free range of buffers
Date:   Thu, 14 Sep 2023 15:33:20 +0200
Message-Id: <20230914133323.198857-47-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve __vb2_queue_free() and __vb2_free_mem() to free
range of buffers and not only the last few buffers.
Intoduce starting index to be flexible on range and change the loops
according to this parameters.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index c5d4a388331b..88cdf4dcb07c 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -527,13 +527,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 /*
  * __vb2_free_mem() - release all video buffer memory for a given queue
  */
-static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
+static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
-	unsigned int buffer = 0;
-	long i = q->max_allowed_buffers;
+	unsigned int i, buffer = 0;
 	struct vb2_buffer *vb;
 
-	for (i = q->max_allowed_buffers; i >= 0 && buffer < buffers; i--) {
+	for (i = start; i < q->max_allowed_buffers && buffer < count; i++) {
 		vb = vb2_get_buffer(q, i);
 		if (!vb)
 			continue;
@@ -550,19 +549,18 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 }
 
 /*
- * __vb2_queue_free() - free buffers at the end of the queue - video memory and
+ * __vb2_queue_free() - free count buffers from start index of the queue - video memory and
  * related information, if no buffers are left return the queue to an
  * uninitialized state. Might be called even if the queue has already been freed.
  */
-static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
+static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
-	unsigned int buffer;
-	long i = q->max_allowed_buffers;
+	unsigned int i, buffer;
 
 	lockdep_assert_held(&q->mmap_lock);
 
 	/* Call driver-provided cleanup function for each buffer, if provided */
-	for (i = q->max_allowed_buffers, buffer = 0; i >= 0 && buffer < buffers; i--) {
+	for (i = start, buffer = 0; i < q->max_allowed_buffers && buffer < count; i++) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 		if (!vb)
@@ -574,7 +572,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 	}
 
 	/* Release video buffer memory */
-	__vb2_free_mem(q, buffers);
+	__vb2_free_mem(q, start, count);
 
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	/*
@@ -659,8 +657,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 #endif
 
 	/* Free vb2 buffers */
-	for (i = q->max_allowed_buffers, buffer = 0; i > 0 && buffer < buffers; i--) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = start, buffer = 0; i < q->max_allowed_buffers && buffer < count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 		if (!vb)
 			continue;
@@ -884,7 +882,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * queued without ever calling STREAMON.
 		 */
 		__vb2_queue_cancel(q);
-		__vb2_queue_free(q, q_num_bufs);
+		__vb2_queue_free(q, 0, q_num_bufs);
 		mutex_unlock(&q->mmap_lock);
 
 		/*
@@ -995,7 +993,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
-		__vb2_queue_free(q, allocated_buffers);
+		__vb2_queue_free(q, 0, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return ret;
 	}
@@ -1135,7 +1133,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
-		__vb2_queue_free(q, allocated_buffers);
+		__vb2_queue_free(q, 0, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return -ENOMEM;
 	}
@@ -2617,7 +2615,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_cleanup_fileio(q);
 	__vb2_queue_cancel(q);
 	mutex_lock(&q->mmap_lock);
-	__vb2_queue_free(q, q->max_allowed_buffers);
+	__vb2_queue_free(q, 0, q->max_allowed_buffers);
 	kfree(q->bufs);
 	q->bufs = NULL;
 	bitmap_free(q->bufs_map);
-- 
2.39.2

