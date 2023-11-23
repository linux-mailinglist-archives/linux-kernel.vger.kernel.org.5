Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5767F6808
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjKWUEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKWUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:04:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D8AD44;
        Thu, 23 Nov 2023 12:04:48 -0800 (PST)
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 730E26607397;
        Thu, 23 Nov 2023 20:04:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700769887;
        bh=5j6oAVvGeJ2LSvKq7qLh6iBlcNajPE2w0T4ed6BQGtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqFZD9qHB+z1EpsnmKFjtHIpSP6PnbKUHX6xr3X9mBqDoKldt41VVXI3lvfJrc6SP
         F0mUsuAZ97CU9hxOt/nF/8nAX/+FAEO5XyEPMIP2Y27uNpoKjjA0OCDv3QbwqU1uLf
         FTKJ+WexaEQ1LzESCljp2OJCtxg7RZHG1Gv48Sl3Qlxt1r5BUTnp2QDnZjYgBPLqKv
         yfjbJYHESMGFQDlE3An6AxFAPxxgPiTyr6yjyXGBNM2+8sHx1z781VZin06gCNLo3Z
         ctZBIJkL/3+pGYj9zahlPnJ4gZMJVAqJpmkGULaGQ1gBbXoFblphiSWRnuLhVdwW+m
         GwQKYjeqZSeIw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 2/4] media: visl: Add a stable_output parameter
Date:   Thu, 23 Nov 2023 14:57:45 -0500
Message-ID: <20231123200451.148097-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123200451.148097-1-detlev.casanova@collabora.com>
References: <20231123200451.148097-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/test-drivers/visl/visl-dec.c  | 256 ++++++++++++--------
 drivers/media/test-drivers/visl/visl.h      |   1 +
 3 files changed, 166 insertions(+), 96 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index ef89eead6671..a9c060104932 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -88,6 +88,11 @@ module_param(bitstream_trace_nframes, uint, 0444);
 MODULE_PARM_DESC(bitstream_trace_nframes,
 		 " the number of frames to dump the bitstream through debugfs");
 
+bool stable_output = true;
+module_param(stable_output, bool, 0644);
+MODULE_PARM_DESC(stable_output,
+		 " only write stable data for a given input on the output frames");
+
 static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
 	{
 		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 318d675e5668..a6c878f0813a 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -52,11 +52,17 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 	case VISL_CODEC_FWHT: {
 		struct vb2_buffer *vb2_buf;
 
-		vb2_buf = vb2_find_buffer(cap_q, run->fwht.params->backward_ref_ts);
+		if (!stable_output) {
+			vb2_buf = vb2_find_buffer(cap_q, run->fwht.params->backward_ref_ts);
+
+			scnprintf(buf, buflen, "backwards_ref_ts: %lld, vb2_idx: %d",
+				  run->fwht.params->backward_ref_ts,
+				  vb2_buf ? vb2_buf->index : -1);
+		} else {
+			scnprintf(buf, buflen, "backwards_ref_ts: %lld",
+				  run->fwht.params->backward_ref_ts);
+		}
 
-		scnprintf(buf, buflen, "backwards_ref_ts: %lld, vb2_idx: %d",
-			  run->fwht.params->backward_ref_ts,
-			  vb2_buf ? vb2_buf->index : -1);
 		break;
 	}
 
@@ -64,16 +70,25 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		struct vb2_buffer *b_ref;
 		struct vb2_buffer *f_ref;
 
-		b_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->backward_ref_ts);
-		f_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->forward_ref_ts);
+		if (!stable_output) {
+			b_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->backward_ref_ts);
+			f_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->forward_ref_ts);
+
+			scnprintf(buf, buflen,
+				  "backward_ref_ts: %llu, vb2_idx: %d\n"
+				  "forward_ref_ts: %llu, vb2_idx: %d\n",
+				  run->mpeg2.pic->backward_ref_ts,
+				  b_ref ? b_ref->index : -1,
+				  run->mpeg2.pic->forward_ref_ts,
+				  f_ref ? f_ref->index : -1);
+		} else {
+			scnprintf(buf, buflen,
+				  "backward_ref_ts: %llu\n"
+				  "forward_ref_ts: %llu\n",
+				  run->mpeg2.pic->backward_ref_ts,
+				  run->mpeg2.pic->forward_ref_ts);
 
-		scnprintf(buf, buflen,
-			  "backward_ref_ts: %llu, vb2_idx: %d\n"
-			  "forward_ref_ts: %llu, vb2_idx: %d\n",
-			  run->mpeg2.pic->backward_ref_ts,
-			  b_ref ? b_ref->index : -1,
-			  run->mpeg2.pic->forward_ref_ts,
-			  f_ref ? f_ref->index : -1);
+		}
 		break;
 	}
 
@@ -82,20 +97,30 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		struct vb2_buffer *golden;
 		struct vb2_buffer *alt;
 
-		last = vb2_find_buffer(cap_q, run->vp8.frame->last_frame_ts);
-		golden = vb2_find_buffer(cap_q, run->vp8.frame->golden_frame_ts);
-		alt = vb2_find_buffer(cap_q, run->vp8.frame->alt_frame_ts);
-
-		scnprintf(buf, buflen,
-			  "last_ref_ts: %llu, vb2_idx: %d\n"
-			  "golden_ref_ts: %llu, vb2_idx: %d\n"
-			  "alt_ref_ts: %llu, vb2_idx: %d\n",
-			  run->vp8.frame->last_frame_ts,
-			  last ? last->index : -1,
-			  run->vp8.frame->golden_frame_ts,
-			  golden ? golden->index : -1,
-			  run->vp8.frame->alt_frame_ts,
-			  alt ? alt->index : -1);
+		if (!stable_output) {
+			last = vb2_find_buffer(cap_q, run->vp8.frame->last_frame_ts);
+			golden = vb2_find_buffer(cap_q, run->vp8.frame->golden_frame_ts);
+			alt = vb2_find_buffer(cap_q, run->vp8.frame->alt_frame_ts);
+
+			scnprintf(buf, buflen,
+				  "last_ref_ts: %llu, vb2_idx: %d\n"
+				  "golden_ref_ts: %llu, vb2_idx: %d\n"
+				  "alt_ref_ts: %llu, vb2_idx: %d\n",
+				  run->vp8.frame->last_frame_ts,
+				  last ? last->index : -1,
+				  run->vp8.frame->golden_frame_ts,
+				  golden ? golden->index : -1,
+				  run->vp8.frame->alt_frame_ts,
+				  alt ? alt->index : -1);
+		} else {
+			scnprintf(buf, buflen,
+				  "last_ref_ts: %llu\n"
+				  "golden_ref_ts: %llu\n"
+				  "alt_ref_ts: %llu\n",
+				  run->vp8.frame->last_frame_ts,
+				  run->vp8.frame->golden_frame_ts,
+				  run->vp8.frame->alt_frame_ts);
+		}
 		break;
 	}
 
@@ -104,32 +129,49 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		struct vb2_buffer *golden;
 		struct vb2_buffer *alt;
 
-		last = vb2_find_buffer(cap_q, run->vp9.frame->last_frame_ts);
-		golden = vb2_find_buffer(cap_q, run->vp9.frame->golden_frame_ts);
-		alt = vb2_find_buffer(cap_q, run->vp9.frame->alt_frame_ts);
-
-		scnprintf(buf, buflen,
-			  "last_ref_ts: %llu, vb2_idx: %d\n"
-			  "golden_ref_ts: %llu, vb2_idx: %d\n"
-			  "alt_ref_ts: %llu, vb2_idx: %d\n",
-			  run->vp9.frame->last_frame_ts,
-			  last ? last->index : -1,
-			  run->vp9.frame->golden_frame_ts,
-			  golden ? golden->index : -1,
-			  run->vp9.frame->alt_frame_ts,
-			  alt ? alt->index : -1);
+		if (!stable_output) {
+			last = vb2_find_buffer(cap_q, run->vp9.frame->last_frame_ts);
+			golden = vb2_find_buffer(cap_q, run->vp9.frame->golden_frame_ts);
+			alt = vb2_find_buffer(cap_q, run->vp9.frame->alt_frame_ts);
+
+			scnprintf(buf, buflen,
+				  "last_ref_ts: %llu, vb2_idx: %d\n"
+				  "golden_ref_ts: %llu, vb2_idx: %d\n"
+				  "alt_ref_ts: %llu, vb2_idx: %d\n",
+				  run->vp9.frame->last_frame_ts,
+				  last ? last->index : -1,
+				  run->vp9.frame->golden_frame_ts,
+				  golden ? golden->index : -1,
+				  run->vp9.frame->alt_frame_ts,
+				  alt ? alt->index : -1);
+		} else {
+			scnprintf(buf, buflen,
+				  "last_ref_ts: %llu\n"
+				  "golden_ref_ts: %llu\n"
+				  "alt_ref_ts: %llu\n",
+				  run->vp9.frame->last_frame_ts,
+				  run->vp9.frame->golden_frame_ts,
+				  run->vp9.frame->alt_frame_ts);
+		}
 		break;
 	}
 
 	case VISL_CODEC_H264: {
 		char entry[] = "dpb[%d]:%u, vb2_index: %d\n";
+		char entry_stable[] = "dpb[%d]:%u\n";
 		struct vb2_buffer *vb2_buf;
 
 		for (i = 0; i < ARRAY_SIZE(run->h264.dpram->dpb); i++) {
-			vb2_buf = vb2_find_buffer(cap_q, run->h264.dpram->dpb[i].reference_ts);
-			len = scnprintf(buf, buflen, entry, i,
-					run->h264.dpram->dpb[i].reference_ts,
-					vb2_buf ? vb2_buf->index : -1);
+			if (!stable_output) {
+				vb2_buf = vb2_find_buffer(cap_q,
+							  run->h264.dpram->dpb[i].reference_ts);
+				len = scnprintf(buf, buflen, entry, i,
+						run->h264.dpram->dpb[i].reference_ts,
+						vb2_buf ? vb2_buf->index : -1);
+			} else {
+				len = scnprintf(buf, buflen, entry_stable, i,
+						run->h264.dpram->dpb[i].reference_ts);
+			}
 			buf += len;
 			buflen -= len;
 		}
@@ -139,13 +181,20 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 
 	case VISL_CODEC_HEVC: {
 		char entry[] = "dpb[%d]:%u, vb2_index: %d\n";
+		char entry_stable[] = "dpb[%d]:%u\n";
 		struct vb2_buffer *vb2_buf;
 
 		for (i = 0; i < ARRAY_SIZE(run->hevc.dpram->dpb); i++) {
-			vb2_buf = vb2_find_buffer(cap_q, run->hevc.dpram->dpb[i].timestamp);
-			len = scnprintf(buf, buflen, entry, i,
-					run->hevc.dpram->dpb[i].timestamp,
-					vb2_buf ? vb2_buf->index : -1);
+			if (!stable_output) {
+				vb2_buf = vb2_find_buffer(cap_q, run->hevc.dpram->dpb[i].timestamp);
+				len = scnprintf(buf, buflen, entry, i,
+						run->hevc.dpram->dpb[i].timestamp,
+						vb2_buf ? vb2_buf->index : -1);
+			} else {
+				len = scnprintf(buf, buflen, entry_stable, i,
+						run->hevc.dpram->dpb[i].timestamp);
+			}
+
 			buf += len;
 			buflen -= len;
 		}
@@ -197,19 +246,30 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
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
@@ -280,28 +340,30 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
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
@@ -333,25 +395,27 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
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

