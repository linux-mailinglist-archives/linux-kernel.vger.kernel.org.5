Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67D7D5B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbjJXTKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbjJXTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:10:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86F10C6;
        Tue, 24 Oct 2023 12:10:22 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D4196607324;
        Tue, 24 Oct 2023 20:10:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698174621;
        bh=t1TeU6FLfPr3toRNJpSXAr038MxZO0xCNid62XMKzcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dr4eQw/5o1YwI4tNZEATXpkUIcGc1x3rpipznMaY0PiQ41pQ4sailtAPeK6xWsMSk
         YS66z0X7negEWFDdr1NOmaAal7FuYv/w3d+BaeUVOkFhAHwNC1NwwgjQsJ36Lsir2v
         /EC713GSih0b+4lI7G1tv0U45ZFfXzmvqRpJVhF0rQYUkGJ6uhlVyHNUZQnaOWDzZp
         TBVJFVLrFiijeH4mpYNXOpu/03KEpjZKmweI/nk95xmNvMLhsmmXCqMNobqTtQP20N
         24ktXqHD8XJCiRe29uYo5Hoi1lB31vqFxJf32KTxRpOHGkl5937KZ9hw1R7agY1+BO
         qPKm1Wh0eEloA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 2/5] media: visl: Add a stable_output parameter
Date:   Tue, 24 Oct 2023 15:09:47 -0400
Message-ID: <20231024191027.305622-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024191027.305622-1-detlev.casanova@collabora.com>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This parameter is used to ensure that for a given input, the output
frames are always identical so that it can be compared against
a reference in automatic tests.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-core.c |   5 +
 drivers/media/test-drivers/visl/visl-dec.c  | 125 +++++++++++---------
 drivers/media/test-drivers/visl/visl.h      |   1 +
 3 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index df6515530fbf..d28d50afec02 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -88,6 +88,11 @@ module_param(bitstream_trace_nframes, uint, 0);
 MODULE_PARM_DESC(bitstream_trace_nframes,
 		 " the number of frames to dump the bitstream through debugfs");
 
+bool stable_output;
+module_param(stable_output, bool, 0644);
+MODULE_PARM_DESC(stable_output,
+		 " only write stable data for a given input on the output frames");
+
 static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
 	{
 		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 318d675e5668..61cfca49ead9 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -197,19 +197,30 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
 {
 	u32 stream_ms;
 
-	stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
-
-	scnprintf(buf, bufsz,
-		  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
-		  (stream_ms / (60 * 60 * 1000)) % 24,
-		  (stream_ms / (60 * 1000)) % 60,
-		  (stream_ms / 1000) % 60,
-		  stream_ms % 1000,
-		  run->dst->sequence,
-		  run->dst->vb2_buf.timestamp,
-		  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
-		  (run->dst->field == V4L2_FIELD_TOP ?
-		  " top" : " bottom") : "none");
+	if (!stable_output) {
+		stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
+
+		scnprintf(buf, bufsz,
+			  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
+			  (stream_ms / (60 * 60 * 1000)) % 24,
+			  (stream_ms / (60 * 1000)) % 60,
+			  (stream_ms / 1000) % 60,
+			  stream_ms % 1000,
+			  run->dst->sequence,
+			  run->dst->vb2_buf.timestamp,
+			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
+			  (run->dst->field == V4L2_FIELD_TOP ?
+			  " top" : " bottom") : "none");
+	} else {
+		scnprintf(buf, bufsz,
+			  "sequence:%u timestamp:%lld field:%s",
+			  run->dst->sequence,
+			  run->dst->vb2_buf.timestamp,
+			  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
+			  (run->dst->field == V4L2_FIELD_TOP ?
+			  " top" : " bottom") : "none");
+
+	}
 }
 
 static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
@@ -244,15 +255,17 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "");
 	line++;
 
-	visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
+	if (!stable_output) {
+		visl_get_ref_frames(ctx, buf, TPG_STR_BUF_SZ, run);
 
-	while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
-		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, line_str);
-		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", line_str);
-	}
+		while ((line_str = strsep(&tmp, "\n")) && strlen(line_str)) {
+			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, line_str);
+			frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", line_str);
+		}
 
-	frame_dprintk(ctx->dev, run->dst->sequence, "");
-	line++;
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		line++;
+	}
 
 	scnprintf(buf,
 		  TPG_STR_BUF_SZ,
@@ -280,28 +293,30 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 	}
 
-	line++;
-	frame_dprintk(ctx->dev, run->dst->sequence, "");
-	scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
-	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
-	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+	if (!stable_output) {
+		line++;
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
-	len = 0;
-	for (i = 0; i < out_q->num_buffers; i++) {
-		char entry[] = "index: %u, state: %s, request_fd: %d, ";
-		u32 old_len = len;
-		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
+		len = 0;
+		for (i = 0; i < out_q->num_buffers; i++) {
+			char entry[] = "index: %u, state: %s, request_fd: %d, ";
+			u32 old_len = len;
+			char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
 
-		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
-				 entry, i, q_status,
-				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
+			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
+					 entry, i, q_status,
+					 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
 
-		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
-					   &buf[len],
-					   TPG_STR_BUF_SZ - len);
+			len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
+						   &buf[len],
+						   TPG_STR_BUF_SZ - len);
 
-		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
-		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
+			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+		}
 	}
 
 	line++;
@@ -333,25 +348,27 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 	}
 
-	line++;
-	frame_dprintk(ctx->dev, run->dst->sequence, "");
-	scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
-	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
-	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+	if (!stable_output) {
+		line++;
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
-	len = 0;
-	for (i = 0; i < cap_q->num_buffers; i++) {
-		u32 old_len = len;
-		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
+		len = 0;
+		for (i = 0; i < cap_q->num_buffers; i++) {
+			u32 old_len = len;
+			char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
 
-		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
-				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
-				 cap_q->bufs[i]->index, q_status,
-				 cap_q->bufs[i]->timestamp,
-				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
+			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
+					 "index: %u, status: %s, timestamp: %llu, is_held: %d",
+					 cap_q->bufs[i]->index, q_status,
+					 cap_q->bufs[i]->timestamp,
+					 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
 
-		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
-		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
+			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+		}
 	}
 }
 
diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
index 31639f2e593d..5a81b493f121 100644
--- a/drivers/media/test-drivers/visl/visl.h
+++ b/drivers/media/test-drivers/visl/visl.h
@@ -85,6 +85,7 @@ extern unsigned int visl_dprintk_nframes;
 extern bool keep_bitstream_buffers;
 extern int bitstream_trace_frame_start;
 extern unsigned int bitstream_trace_nframes;
+extern bool stable_output;
 
 #define frame_dprintk(dev, current, fmt, arg...) \
 	do { \
-- 
2.41.0

