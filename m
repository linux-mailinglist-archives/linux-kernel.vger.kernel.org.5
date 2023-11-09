Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32007E6ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344073AbjKIQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjKIQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:32:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521D3849;
        Thu,  9 Nov 2023 08:32:29 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 026306607421;
        Thu,  9 Nov 2023 16:32:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547548;
        bh=rhUkYFk+VvLmxfiAps4JtG+uZEhzCV4A0U/lurUMSB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxlgNAXqMhJDD+CDFjXORNkk/AMcOLaBftomO7DHHTElE74WSln9yF4WbiAcm3/PU
         3va2pVAyfvB8lZZaxXl01mnAHGmyHnc0hl6RrjwngZKQKI0CE2WRhgwA8J+Jj5lxli
         uJ9U8GyuOCoLArhEG/zzTfwBmm22T0DAaQDLOQcGo7OrMrifBNxaUQzFEUu/DIPXzt
         pokzp+wolvzdFDQtW+qHRtnIXwY2EOJ677FjuVzSe2oQ6DPQPpyAVwa5AqNdTPvW0F
         9P5PV/o2Hb3DJS1yqL1KviRBA9ORXuqQbJOdFYmG232f8k5dFnE6O8YXQWC6INdJAd
         onR/yGLsnwLOQ==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH v15 03/56] media: videobuf2: Stop spamming kernel log with all queue counter
Date:   Thu,  9 Nov 2023 17:29:15 +0100
Message-Id: <20231109163008.179152-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
References: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only report unbalanced queue counters do avoid spamming kernel log
with useless information.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 79 +++++++++++--------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 0b7c6b297d12..009ae53dbe3b 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -538,25 +538,26 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	/*
-	 * Check that all the calls were balances during the life-time of this
-	 * queue. If not (or if the debug level is 1 or up), then dump the
-	 * counters to the kernel log.
+	 * Check that all the calls were balanced during the life-time of this
+	 * queue. If not then dump the counters to the kernel log.
 	 */
 	if (q->num_buffers) {
 		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
 				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
 				  q->cnt_wait_prepare != q->cnt_wait_finish;
 
-		if (unbalanced || debug) {
-			pr_info("counters for queue %p:%s\n", q,
-				unbalanced ? " UNBALANCED!" : "");
-			pr_info("     setup: %u start_streaming: %u stop_streaming: %u\n",
-				q->cnt_queue_setup, q->cnt_start_streaming,
-				q->cnt_stop_streaming);
-			pr_info("     prepare_streaming: %u unprepare_streaming: %u\n",
-				q->cnt_prepare_streaming, q->cnt_unprepare_streaming);
-			pr_info("     wait_prepare: %u wait_finish: %u\n",
-				q->cnt_wait_prepare, q->cnt_wait_finish);
+		if (unbalanced) {
+			pr_info("unbalanced counters for queue %p:\n", q);
+			if (q->cnt_start_streaming != q->cnt_stop_streaming)
+				pr_info("     setup: %u start_streaming: %u stop_streaming: %u\n",
+					q->cnt_queue_setup, q->cnt_start_streaming,
+					q->cnt_stop_streaming);
+			if (q->cnt_prepare_streaming != q->cnt_unprepare_streaming)
+				pr_info("     prepare_streaming: %u unprepare_streaming: %u\n",
+					q->cnt_prepare_streaming, q->cnt_unprepare_streaming);
+			if (q->cnt_wait_prepare != q->cnt_wait_finish)
+				pr_info("     wait_prepare: %u wait_finish: %u\n",
+					q->cnt_wait_prepare, q->cnt_wait_finish);
 		}
 		q->cnt_queue_setup = 0;
 		q->cnt_wait_prepare = 0;
@@ -577,29 +578,37 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 				  vb->cnt_buf_prepare != vb->cnt_buf_finish ||
 				  vb->cnt_buf_init != vb->cnt_buf_cleanup;
 
-		if (unbalanced || debug) {
-			pr_info("   counters for queue %p, buffer %d:%s\n",
-				q, buffer, unbalanced ? " UNBALANCED!" : "");
-			pr_info("     buf_init: %u buf_cleanup: %u buf_prepare: %u buf_finish: %u\n",
-				vb->cnt_buf_init, vb->cnt_buf_cleanup,
-				vb->cnt_buf_prepare, vb->cnt_buf_finish);
-			pr_info("     buf_out_validate: %u buf_queue: %u buf_done: %u buf_request_complete: %u\n",
-				vb->cnt_buf_out_validate, vb->cnt_buf_queue,
-				vb->cnt_buf_done, vb->cnt_buf_request_complete);
-			pr_info("     alloc: %u put: %u prepare: %u finish: %u mmap: %u\n",
-				vb->cnt_mem_alloc, vb->cnt_mem_put,
-				vb->cnt_mem_prepare, vb->cnt_mem_finish,
-				vb->cnt_mem_mmap);
-			pr_info("     get_userptr: %u put_userptr: %u\n",
-				vb->cnt_mem_get_userptr, vb->cnt_mem_put_userptr);
-			pr_info("     attach_dmabuf: %u detach_dmabuf: %u map_dmabuf: %u unmap_dmabuf: %u\n",
-				vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf,
-				vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
-			pr_info("     get_dmabuf: %u num_users: %u vaddr: %u cookie: %u\n",
+		if (unbalanced) {
+			pr_info("unbalanced counters for queue %p, buffer %d:\n",
+				q, buffer);
+			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
+				pr_info("     buf_init: %u buf_cleanup: %u\n",
+					vb->cnt_buf_init, vb->cnt_buf_cleanup);
+			if (vb->cnt_buf_prepare != vb->cnt_buf_finish)
+				pr_info("     buf_prepare: %u buf_finish: %u\n",
+					vb->cnt_buf_prepare, vb->cnt_buf_finish);
+			if (vb->cnt_buf_queue != vb->cnt_buf_done)
+				pr_info("     buf_out_validate: %u buf_queue: %u buf_done: %u buf_request_complete: %u\n",
+					vb->cnt_buf_out_validate, vb->cnt_buf_queue,
+					vb->cnt_buf_done, vb->cnt_buf_request_complete);
+			if (vb->cnt_mem_alloc != vb->cnt_mem_put)
+				pr_info("     alloc: %u put: %u\n",
+					vb->cnt_mem_alloc, vb->cnt_mem_put);
+			if (vb->cnt_mem_prepare != vb->cnt_mem_finish)
+				pr_info("     prepare: %u finish: %u\n",
+					vb->cnt_mem_prepare, vb->cnt_mem_finish);
+			if (vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr)
+				pr_info("     get_userptr: %u put_userptr: %u\n",
+					vb->cnt_mem_get_userptr, vb->cnt_mem_put_userptr);
+			if (vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf)
+				pr_info("     attach_dmabuf: %u detach_dmabuf: %u\n",
+					vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf);
+			if (vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf)
+				pr_info("     map_dmabuf: %u unmap_dmabuf: %u\n",
+					vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
+			pr_info("     get_dmabuf: %u num_users: %u\n",
 				vb->cnt_mem_get_dmabuf,
-				vb->cnt_mem_num_users,
-				vb->cnt_mem_vaddr,
-				vb->cnt_mem_cookie);
+				vb->cnt_mem_num_users);
 		}
 	}
 #endif
-- 
2.39.2

