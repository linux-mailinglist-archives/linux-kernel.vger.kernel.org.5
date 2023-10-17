Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D437CC63C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbjJQOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbjJQOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC0F7;
        Tue, 17 Oct 2023 07:48:06 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0FBF66072F7;
        Tue, 17 Oct 2023 15:48:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554085;
        bh=xMJ8tMojfr13gTY+PpecndOGeS4i3P9Tk9kRrGKcBSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7hNvZBOdqIIQScNEKEZXEKqQpHphKIKO1gDvnZGzzbxFUXsbcOiUXbF2gnZtUxdb
         gX9euiKi1jBkCihzJnvcbKdfsucw8WdYtWl7vmdF7Pu5Dxp+kX/Pc4+nTu6LUVo9G6
         DjT8tDZRBz4Tmd6fSPCNnMCQu7t8gFVqpV17zKEp3C4IBh8Aoi0Ym9YOPjh2vb1N6h
         QaYBIYZ0/R0R+MVk0bYO868d2oR9wRKblgYWpNAj3WvNCIP8yz7HBO0/1f3r9epupB
         mF/lG1Cdyz6GV0b0PBX8bM3iGIoZcjw42ql6xDz6KWTnMJwiR/ZO6BBrITmJGDjJJC
         EjchhilvatxqQ==
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
Subject: [PATCH v12 03/56] media: videobuf2: Stop spamming kernel log with all queue counter
Date:   Tue, 17 Oct 2023 16:47:03 +0200
Message-Id: <20231017144756.34719-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
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

Only report unbalanced queue counters do avoid spamming kernel log
with useless information.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 79 +++++++++++--------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 09be8e026044..47dba2a20d73 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -533,25 +533,26 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 
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
@@ -572,29 +573,37 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
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

