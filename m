Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857F7DD223
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjJaQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbjJaQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:31:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799112C;
        Tue, 31 Oct 2023 09:31:30 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c562:2ef4:80c0:92f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B22BE66073AF;
        Tue, 31 Oct 2023 16:31:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698769889;
        bh=PuFoOUa6JL13sN6HuBrtSIThFlotKKJZbkNL+kdatwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIu4lKY6cxWJ3SPRMCG3vM6K80vk+j+1gdvuFwXG9i9NiXHcZgN6o3GyB8w0qGKj+
         AWwqYFDKAtSQsOuo9dVWjwwy34l1q2nR1fwGyKeR0GrURjCM2JTRYhr/DucjyGWCKf
         SimgVD7hD01NTZ4b/IBDb5I/W5AaA+ii+mXVqZcHDbvyMFfe5EPCqDy1yhn0a50pC3
         CvkekJPy5UOp0S4e69PbC0qSsttTRAzat8ogPWMMt0HLUBMmA6txzeq5HLzamGpQ5s
         xYum7i4USs9PTDDTbQoy9iK3BU1O/nRfqsUqx8d/z1ujaXWXw8ZozuyQfkboPzwAua
         Xd5jdG5i/M/AQ==
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
        Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v14 10/56] media: amphion: Stop direct calls to queue num_buffers field
Date:   Tue, 31 Oct 2023 17:30:18 +0100
Message-Id: <20231031163104.112469-11-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Ming Qian <ming.qian@nxp.com>
CC: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/media/platform/amphion/vpu_dbg.c  | 8 ++++----
 drivers/media/platform/amphion/vpu_v4l2.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index a462d6fe4ea9..940e5bda5fa3 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -87,7 +87,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 	num = scnprintf(str, sizeof(str),
 			"output (%2d, %2d): fmt = %c%c%c%c %d x %d, %d;",
 			vb2_is_streaming(vq),
-			vq->num_buffers,
+			vb2_get_num_buffers(vq),
 			inst->out_format.pixfmt,
 			inst->out_format.pixfmt >> 8,
 			inst->out_format.pixfmt >> 16,
@@ -111,7 +111,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 	num = scnprintf(str, sizeof(str),
 			"capture(%2d, %2d): fmt = %c%c%c%c %d x %d, %d;",
 			vb2_is_streaming(vq),
-			vq->num_buffers,
+			vb2_get_num_buffers(vq),
 			inst->cap_format.pixfmt,
 			inst->cap_format.pixfmt >> 8,
 			inst->cap_format.pixfmt >> 16,
@@ -139,7 +139,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 		return 0;
 
 	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
-	for (i = 0; i < vq->num_buffers; i++) {
+	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
 		struct vb2_buffer *vb;
 		struct vb2_v4l2_buffer *vbuf;
 
@@ -161,7 +161,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 	}
 
 	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
-	for (i = 0; i < vq->num_buffers; i++) {
+	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
 		struct vb2_buffer *vb;
 		struct vb2_v4l2_buffer *vbuf;
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 0f6e4c666440..87afb4a18d5d 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -439,7 +439,7 @@ int vpu_get_num_buffers(struct vpu_inst *inst, u32 type)
 	else
 		q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
 
-	return q->num_buffers;
+	return vb2_get_num_buffers(q);
 }
 
 static void vpu_m2m_device_run(void *priv)
@@ -587,7 +587,7 @@ static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		  fmt->sizeimage[0], fmt->bytesperline[0],
 		  fmt->sizeimage[1], fmt->bytesperline[1],
 		  fmt->sizeimage[2], fmt->bytesperline[2],
-		  q->num_buffers);
+		  vb2_get_num_buffers(q));
 	vb2_clear_last_buffer_dequeued(q);
 	ret = call_vop(inst, start, q->type);
 	if (ret)
-- 
2.39.2

