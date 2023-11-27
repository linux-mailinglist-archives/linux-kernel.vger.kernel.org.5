Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863197FA71E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjK0Q4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjK0Q4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E522125;
        Mon, 27 Nov 2023 08:55:34 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0C4466073E9;
        Mon, 27 Nov 2023 16:55:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104133;
        bh=s+4TpTUuiOxUyySpjai/VxlncF5tn3uinvKKcPElu7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyB7slYMc/QOMLbN/sOUhyWxBxEMjH7WRzaNkawTZq5x4fpFzqsfn7WRQYIbJoqAx
         rh71hu63SYRcJzKctOEQnsZ3y2Zz59eLtmgYxQPfTmrvOq0+135DqZT+UoJL1+z9uJ
         ShSAMHev+R3AxIdTXfSy4gvYD91IuAon040J2TyM7le47nP4dGbT/QpkrjCQO+r7eC
         uwqwqPrJxXsm+6KihJbPJE1RjH0uLXz9KgnZps6JnDZ+q/9VYU+2lmbrW//U9SOWXT
         NFmDtBkibr8MnwZK7NR/PGAQFg9IY65b9M5RRPI3O3k2Wvi9tCuNlOG7kpUwJAMM1o
         0E0QEzOMPJPuQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 35/55] videobuf2: core: Add min_dma_buffers_needed field to vb2_queue
Date:   Mon, 27 Nov 2023 17:54:34 +0100
Message-Id: <20231127165454.166373-36-benjamin.gaignard@collabora.com>
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

'min_dma_buffers_needed' field is to clarify 'min_buffers_needed'
purpose versus 'min_reqbufs_allocation' usage.
'min_buffers_needed' is still used in few drivers so directly
rename it would be problematic.
The both will live together while fixing the drivers to use
'min_dma_buffers_needed' field instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 28 ++++++++++++++-----
 include/media/videobuf2-core.h                |  7 +++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index c224d13b3105..a6ec55db8635 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -816,7 +816,7 @@ static bool verify_coherency_flags(struct vb2_queue *q, bool non_coherent_mem)
 int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		     unsigned int flags, unsigned int *count)
 {
-	unsigned int num_buffers, allocated_buffers, num_planes = 0;
+	unsigned int num_buffers, allocated_buffers, min_reqbufs_needed, num_planes = 0;
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
@@ -866,7 +866,11 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * Make sure the requested values and current defaults are sane.
 	 */
 	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
-	num_buffers = max_t(unsigned int, num_buffers, q->min_reqbufs_allocation);
+	if (q->min_reqbufs_allocation)
+		num_buffers = max_t(unsigned int, num_buffers, q->min_reqbufs_allocation);
+	else
+		num_buffers = max_t(unsigned int, num_buffers, q->min_dma_buffers_needed + 1);
+	min_reqbufs_needed = num_buffers;
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
@@ -918,7 +922,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * There is no point in continuing if we can't allocate the minimum
 	 * number of buffers needed by this vb2_queue.
 	 */
-	if (allocated_buffers < q->min_buffers_needed)
+	if (allocated_buffers < min_reqbufs_needed)
 		ret = -ENOMEM;
 
 	/*
@@ -1654,7 +1658,7 @@ EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
  * @q:		videobuf2 queue
  *
  * Attempt to start streaming. When this function is called there must be
- * at least q->min_buffers_needed buffers queued up (i.e. the minimum
+ * at least q->min_dma_buffers_needed queued up (i.e. the minimum
  * number of buffers required for the DMA engine to function). If the
  * @start_streaming op fails it is supposed to return all the driver-owned
  * buffers back to vb2 in state QUEUED. Check if that happened and if
@@ -1847,7 +1851,8 @@ int vb2_core_qbuf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb,
 	 * then we can finally call start_streaming().
 	 */
 	if (q->streaming && !q->start_streaming_called &&
-	    q->queued_count >= q->min_buffers_needed) {
+	    ((q->queued_count >= q->min_buffers_needed) ||
+	    (q->queued_count >= q->min_dma_buffers_needed))) {
 		ret = vb2_start_streaming(q);
 		if (ret) {
 			/*
@@ -2217,6 +2222,12 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 		return -EINVAL;
 	}
 
+	if (q_num_bufs < q->min_dma_buffers_needed) {
+		dprintk(q, 1, "need at least %u allocated buffers\n",
+			q->min_dma_buffers_needed);
+		return -EINVAL;
+	}
+
 	ret = call_qop(q, prepare_streaming, q);
 	if (ret)
 		return ret;
@@ -2225,7 +2236,8 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 	 * Tell driver to start streaming provided sufficient buffers
 	 * are available.
 	 */
-	if (q->queued_count >= q->min_buffers_needed) {
+	if (q->queued_count >= q->min_buffers_needed &&
+	    q->queued_count >= q->min_dma_buffers_needed) {
 		ret = vb2_start_streaming(q);
 		if (ret)
 			goto unprepare;
@@ -2505,6 +2517,7 @@ int vb2_core_queue_init(struct vb2_queue *q)
 		return -EINVAL;
 
 	if (WARN_ON(q->max_num_buffers > MAX_BUFFER_INDEX) ||
+	    WARN_ON(q->min_dma_buffers_needed > q->max_num_buffers) ||
 	    WARN_ON(q->min_buffers_needed > q->max_num_buffers))
 		return -EINVAL;
 
@@ -2519,7 +2532,8 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	 * in that request) will always succeed. There is no method of
 	 * propagating an error back to userspace.
 	 */
-	if (WARN_ON(q->supports_requests && q->min_buffers_needed))
+	if (WARN_ON(q->supports_requests &&
+		    (q->min_buffers_needed || q->min_dma_buffers_needed)))
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&q->queued_list);
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 17cacd696ab4..0bc97f28a7ea 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -549,10 +549,16 @@ struct vb2_buf_ops {
  * @min_buffers_needed: the minimum number of buffers needed before
  *		@start_streaming can be called. Used when a DMA engine
  *		cannot be started unless at least this number of buffers
+ *		have been queued into the driver. (Deprecated)
+ * @min_dma_buffers_needed: the minimum number of buffers needed before
+ *		@start_streaming can be called. Used when a DMA engine
+ *		cannot be started unless at least this number of buffers
  *		have been queued into the driver.
  * @min_reqbufs_allocation: the minimum number of buffers allocated when
  *		calling VIDIOC_REQBUFS. Used when drivers need a to
  *		specify a minimum buffers allocation before setup a queue.
+ *		If set to 0 then min_dma_buffers_needed + 1 value is used
+ *		as minimum numbers of buffers value.
  */
 /*
  * Private elements (won't appear at the uAPI book):
@@ -618,6 +624,7 @@ struct vb2_queue {
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
 	u32				min_buffers_needed;
+	u32				min_dma_buffers_needed;
 	u32				min_reqbufs_allocation;
 
 	struct device			*alloc_devs[VB2_MAX_PLANES];
-- 
2.39.2

