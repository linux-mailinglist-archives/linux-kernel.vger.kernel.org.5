Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18697B5276
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjJBMHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbjJBMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:06:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA406D7;
        Mon,  2 Oct 2023 05:06:32 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EEB26607334;
        Mon,  2 Oct 2023 13:06:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696248391;
        bh=LamHPpgiOIWh6DTy0PrTueIlE19Fe0d1QhlJSM4GvGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlQQAI0Tz0U55KP+2uOlbnYt9eTF4THK2s5T72E2JH3FHmsPchmN0AaBc6WjiOQBD
         C7ogo0hkajkLaUYjhWbXbngdOHk9RVVroY30sSyiLCGHfD0SY+ujWHLKPAXMs3NSMB
         uahv1jvFXwWPLoUzGwz8vEXzQlWEQSgugaO5ozwkflLWdXQa/eLkz9+HWV8MgvJvs1
         4gXu6bYX6nJ3z+1yH8NzVg/LQWIdSO6U6QTDlBMPpDrwfRvuBpmwaZSNdNcXK+fWzb
         lOZfAYF3xNB2Svp/J6AmWr2ENefHC+I7OYF2ijyJNMXQ1A/6BJlNPbqvKLZlJmNq9+
         bnMsus9yrIRow==
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
Subject: [PATCH v9 13/53] media: Report the maximum possible number of buffers for the queue
Date:   Mon,  2 Oct 2023 14:05:37 +0200
Message-Id: <20231002120617.119602-14-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
References: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
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

Use one of the struct v4l2_create_buffers reserved bytes to report
the maximum possible number of buffers for the queue.
V4l2 framework set V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS flags in queue
capabilities so userland can know when the field is valid.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../userspace-api/media/v4l/vidioc-create-bufs.rst        | 8 ++++++--
 Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst  | 1 +
 drivers/media/common/videobuf2/videobuf2-v4l2.c           | 6 +++++-
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 4 ++--
 include/uapi/linux/videodev2.h                            | 7 ++++++-
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
index a048a9f6b7b6..1a46549e7462 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
@@ -116,9 +116,13 @@ than the number requested.
       - ``flags``
       - Specifies additional buffer management attributes.
 	See :ref:`memory-flags`.
-
     * - __u32
-      - ``reserved``\ [6]
+      - ``max_buffers``
+      - If V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS capability flag is set
+        this field indicate the maximum possible number of buffers
+        for this queue.
+    * - __u32
+      - ``reserved``\ [5]
       - A place holder for future extensions. Drivers and applications
 	must set the array to zero.
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
index 099fa6695167..0395187e1a5a 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
@@ -120,6 +120,7 @@ aborting or finishing any DMA in progress, an implicit
 .. _V4L2-BUF-CAP-SUPPORTS-ORPHANED-BUFS:
 .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
 .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
+.. _V4L2-BUF-CAP-SUPPORTS-SET-MAX-BUFS:
 
 .. raw:: latex
 
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 278ea1107b01..51b16cd14582 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -686,6 +686,7 @@ EXPORT_SYMBOL(vb2_querybuf);
 static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
 {
 	*caps = V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS;
+	*caps |= V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS;
 	if (q->io_modes & VB2_MMAP)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_MMAP;
 	if (q->io_modes & VB2_USERPTR)
@@ -767,7 +768,10 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
 
 	fill_buf_caps(q, &create->capabilities);
 	validate_memory_flags(q, create->memory, &create->flags);
-	create->index = q->num_buffers;
+
+	create->max_buffers = q->max_num_buffers;
+	create->index = vb2_get_num_buffers(q);
+
 	if (create->count == 0)
 		return ret != -EBUSY ? ret : 0;
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index f4d9d6279094..700db197e371 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -483,9 +483,9 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
 {
 	const struct v4l2_create_buffers *p = arg;
 
-	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, ",
+	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, max buffers=%u",
 		p->index, p->count, prt_names(p->memory, v4l2_memory_names),
-		p->capabilities);
+		p->capabilities, p->max_buffers);
 	v4l_print_format(&p->format, write_only);
 }
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 78260e5d9985..b0dbb1be728c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1034,6 +1034,7 @@ struct v4l2_requestbuffers {
 #define V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS		(1 << 4)
 #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF	(1 << 5)
 #define V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS		(1 << 6)
+#define V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS		(1 << 7)
 
 /**
  * struct v4l2_plane - plane info for multi-planar buffers
@@ -2604,6 +2605,9 @@ struct v4l2_dbg_chip_info {
  * @flags:	additional buffer management attributes (ignored unless the
  *		queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability
  *		and configured for MMAP streaming I/O).
+ * @max_buffers: if V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS capability flag is set
+ *		 this field indicate the maximum possible number of buffers
+ *		 for this queue.
  * @reserved:	future extensions
  */
 struct v4l2_create_buffers {
@@ -2613,7 +2617,8 @@ struct v4l2_create_buffers {
 	struct v4l2_format	format;
 	__u32			capabilities;
 	__u32			flags;
-	__u32			reserved[6];
+	__u32			max_buffers;
+	__u32			reserved[5];
 };
 
 /*
-- 
2.39.2

