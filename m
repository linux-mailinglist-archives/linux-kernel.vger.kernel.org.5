Return-Path: <linux-kernel+bounces-29132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FE83094F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A89AB23E57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89566224CE;
	Wed, 17 Jan 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h2fnKMtK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0122305;
	Wed, 17 Jan 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504336; cv=none; b=c0RCZvuN5NYa1KIljOyeAAV6BKOB/tvEBOANQdjmmKjwE1JTiMVo0pYdByrr12m8GAJYgLylfGumtP5IJa7Q/pX2x7GlOC/WXgSa0nvrstUZR7qLT8T56qIYMIDLGqLLqG/AKsGBPqo02/xuQw24JVURPXCe8Aww3Hf8Iwf2Crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504336; c=relaxed/simple;
	bh=OeZGrzzDz9+Z7c+xqVkwiTYFpYtIHAKFnSsD5ywyRss=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=LLV1DHVTjVhRaZ6jz19dcAedIVCzBuNhsXn4G6aAT60hIfBaXTbf77Z4jipH9XtoHA4Xd4nxnVA66hNsqLHBHpR5GM/NbMAMC8UsPExtdBAbyFwYrwYRHJCKcaGUWImRFOLziYqS5sNdKHPDZCx7slQ24SZeAxeSKI8Xh30MeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h2fnKMtK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705504332;
	bh=OeZGrzzDz9+Z7c+xqVkwiTYFpYtIHAKFnSsD5ywyRss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2fnKMtKkfpNwUNFBUC9FtbrPSH5KPlD5UAAE+a1mjZzVw/htz2y+2Ddc+e5BIAKg
	 qr1eKrw3OOdDcehQ/zgeEDefVVUxLS0eFfPtJvaSAiLsorGEDDeUKuf4oHvIXBFnYs
	 xn8lZwgPadiHRzeaZQH3+LyTaTddDwJY2dUaotadjupArA/GitCGns2cQMHERbrSF1
	 i1+Cy8rDfQn2AANdtOKGqgbCt2V3Rl4hcPgbMfebnnyouKnQdeuP77Zrnl+jnW/7Kh
	 6f+E3hnfzOpelFvCrqcwAC/PE0yKCC6o4kfEgB0ueRufgdC9VX7UTQ0M9Cv2sqkc3y
	 gvuNBmUZ9m3+w==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6CA283781FC7;
	Wed, 17 Jan 2024 15:12:11 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 2/4] media: visl: Add a tpg_verbose parameter
Date: Wed, 17 Jan 2024 10:10:16 -0500
Message-ID: <20240117151202.405426-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117151202.405426-1-detlev.casanova@collabora.com>
References: <20240117151202.405426-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The text written on the output frames stable for a given input.
Remove the unstable elements like pointers, buffer indexes or queues
status so that frames are always identical and can be compared against
a reference in automatic tests.

As the unstable information can be relevant when debugging the API, add
a tpg_verbose parameter to show them.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-core.c |   5 +
 drivers/media/test-drivers/visl/visl-dec.c  | 265 +++++++++++---------
 drivers/media/test-drivers/visl/visl.h      |   1 +
 3 files changed, 153 insertions(+), 118 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index 12e93a7798d1..5afa8b73d979 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -88,6 +88,11 @@ module_param(bitstream_trace_nframes, uint, 0444);
 MODULE_PARM_DESC(bitstream_trace_nframes,
 		 " the number of frames to dump the bitstream through debugfs");
 
+bool tpg_verbose = false;
+module_param(tpg_verbose, bool, 0644);
+MODULE_PARM_DESC(tpg_verbose,
+		 " add more verbose information on the generated output frames");
+
 static const struct visl_ctrl_desc visl_fwht_ctrl_descs[] = {
 	{
 		.cfg.id = V4L2_CID_STATELESS_FWHT_PARAMS,
diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index f21260054e0f..4933caa4f2a6 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -42,6 +42,22 @@ static void *plane_vaddr(struct tpg_data *tpg, struct vb2_buffer *buf,
 	return vbuf;
 }
 
+static void visl_print_ts_idx(u8 **buf, __kernel_size_t *buflen, const char* name,
+			     u64 ts, struct vb2_buffer *vb2_buf)
+{
+	u32 len;
+
+	if (tpg_verbose && vb2_buf) {
+		len = scnprintf(*buf, *buflen, "%s: %lld, vb2_idx: %d\n", name,
+				 ts, vb2_buf->index);
+	} else {
+		len = scnprintf(*buf, *buflen, "%s: %lld\n", name, ts);
+	}
+
+	*buf += len;
+	*buflen -= len;
+}
+
 static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 				__kernel_size_t buflen, struct visl_run *run)
 {
@@ -63,9 +79,9 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 
 		vb2_buf = vb2_find_buffer(cap_q, run->fwht.params->backward_ref_ts);
 
-		scnprintf(buf, buflen, "backwards_ref_ts: %lld, vb2_idx: %d",
-			  run->fwht.params->backward_ref_ts,
-			  vb2_buf ? vb2_buf->index : -1);
+		visl_print_ts_idx(&buf, &buflen, "backwards_ref_ts",
+				  run->fwht.params->backward_ref_ts, vb2_buf);
+
 		break;
 	}
 
@@ -76,13 +92,11 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		b_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->backward_ref_ts);
 		f_ref = vb2_find_buffer(cap_q, run->mpeg2.pic->forward_ref_ts);
 
-		scnprintf(buf, buflen,
-			  "backward_ref_ts: %llu, vb2_idx: %d\n"
-			  "forward_ref_ts: %llu, vb2_idx: %d\n",
-			  run->mpeg2.pic->backward_ref_ts,
-			  b_ref ? b_ref->index : -1,
-			  run->mpeg2.pic->forward_ref_ts,
-			  f_ref ? f_ref->index : -1);
+		visl_print_ts_idx(&buf, &buflen, "backward_ref_ts",
+				  run->mpeg2.pic->backward_ref_ts, b_ref);
+		visl_print_ts_idx(&buf, &buflen, "forward_ref_ts",
+				  run->mpeg2.pic->forward_ref_ts, f_ref);
+
 		break;
 	}
 
@@ -95,16 +109,13 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		golden = vb2_find_buffer(cap_q, run->vp8.frame->golden_frame_ts);
 		alt = vb2_find_buffer(cap_q, run->vp8.frame->alt_frame_ts);
 
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
+		visl_print_ts_idx(&buf, &buflen, "last_ref_ts",
+				  run->vp8.frame->last_frame_ts, last);
+		visl_print_ts_idx(&buf, &buflen, "golden_ref_ts",
+				  run->vp8.frame->golden_frame_ts, golden);
+		visl_print_ts_idx(&buf, &buflen, "alt_ref_ts",
+				  run->vp8.frame->alt_frame_ts, alt);
+
 		break;
 	}
 
@@ -117,28 +128,32 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		golden = vb2_find_buffer(cap_q, run->vp9.frame->golden_frame_ts);
 		alt = vb2_find_buffer(cap_q, run->vp9.frame->alt_frame_ts);
 
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
+		visl_print_ts_idx(&buf, &buflen, "last_ref_ts",
+				  run->vp9.frame->last_frame_ts, last);
+		visl_print_ts_idx(&buf, &buflen, "golden_ref_ts",
+				  run->vp9.frame->golden_frame_ts, golden);
+		visl_print_ts_idx(&buf, &buflen, "alt_ref_ts",
+				  run->vp9.frame->alt_frame_ts, alt);
+
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
+			vb2_buf = vb2_find_buffer(cap_q,
+						  run->h264.dpram->dpb[i].reference_ts);
+			if (tpg_verbose && vb2_buf) {
+				len = scnprintf(buf, buflen, entry, i,
+						run->h264.dpram->dpb[i].reference_ts,
+						vb2_buf->index);
+			} else {
+				len = scnprintf(buf, buflen, entry_stable, i,
+						run->h264.dpram->dpb[i].reference_ts);
+			}
 			buf += len;
 			buflen -= len;
 		}
@@ -148,13 +163,20 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 
 	case VISL_CODEC_HEVC: {
 		char entry[] = "dpb[%d]:%u, vb2_index: %d\n";
+		char entry_stable[] = "dpb[%d]:%u\n";
 		struct vb2_buffer *vb2_buf;
 
 		for (i = 0; i < ARRAY_SIZE(run->hevc.dpram->dpb); i++) {
 			vb2_buf = vb2_find_buffer(cap_q, run->hevc.dpram->dpb[i].timestamp);
-			len = scnprintf(buf, buflen, entry, i,
-					run->hevc.dpram->dpb[i].timestamp,
-					vb2_buf ? vb2_buf->index : -1);
+			if (tpg_verbose && vb2_buf) {
+				len = scnprintf(buf, buflen, entry, i,
+						run->hevc.dpram->dpb[i].timestamp,
+						vb2_buf->index);
+			} else {
+				len = scnprintf(buf, buflen, entry_stable, i,
+						run->hevc.dpram->dpb[i].timestamp);
+			}
+
 			buf += len;
 			buflen -= len;
 		}
@@ -171,43 +193,38 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 		int idx_alt2 = run->av1.frame->ref_frame_idx[ALT2_BUF_IDX];
 		int idx_alt = run->av1.frame->ref_frame_idx[ALT_BUF_IDX];
 
+		const u64 *reference_frame_ts = run->av1.frame->reference_frame_ts;
+
 		struct vb2_buffer *ref_last =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last]);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_last]);
 		struct vb2_buffer *ref_last2 =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last2]);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_last2]);
 		struct vb2_buffer *ref_last3 =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last3]);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_last3]);
 		struct vb2_buffer *ref_golden =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_golden]);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_golden]);
 		struct vb2_buffer *ref_bwd =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_bwd]);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_bwd]);
 		struct vb2_buffer *ref_alt2 =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_alt2]);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_alt2]);
 		struct vb2_buffer *ref_alt =
-			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_alt]);
-
-		scnprintf(buf, buflen,
-			  "ref_last_ts: %llu, vb2_idx: %d\n"
-			  "ref_last2_ts: %llu, vb2_idx: %d\n"
-			  "ref_last3_ts: %llu, vb2_idx: %d\n"
-			  "ref_golden_ts: %llu, vb2_idx: %d\n"
-			  "ref_bwd_ts: %llu, vb2_idx: %d\n"
-			  "ref_alt2_ts: %llu, vb2_idx: %d\n"
-			  "ref_alt_ts: %llu, vb2_idx: %d\n",
-			  run->av1.frame->reference_frame_ts[idx_last],
-			  ref_last ? ref_last->index : -1,
-			  run->av1.frame->reference_frame_ts[idx_last2],
-			  ref_last2 ? ref_last2->index : -1,
-			  run->av1.frame->reference_frame_ts[idx_last3],
-			  ref_last3 ? ref_last3->index : -1,
-			  run->av1.frame->reference_frame_ts[idx_golden],
-			  ref_golden ? ref_golden->index : -1,
-			  run->av1.frame->reference_frame_ts[idx_bwd],
-			  ref_bwd ? ref_bwd->index : -1,
-			  run->av1.frame->reference_frame_ts[idx_alt2],
-			  ref_alt2 ? ref_alt2->index : -1,
-			  run->av1.frame->reference_frame_ts[idx_alt],
-			  ref_alt ? ref_alt->index : -1);
+			vb2_find_buffer(cap_q, reference_frame_ts[idx_alt]);
+
+		visl_print_ts_idx(&buf, &buflen, "ref_last_ts",
+				  reference_frame_ts[idx_last], ref_last);
+		visl_print_ts_idx(&buf, &buflen, "ref_last2_ts",
+				  reference_frame_ts[idx_last2], ref_last2);
+		visl_print_ts_idx(&buf, &buflen, "ref_last3_ts",
+				  reference_frame_ts[idx_last3], ref_last3);
+		visl_print_ts_idx(&buf, &buflen, "ref_golden_ts",
+				  reference_frame_ts[idx_golden], ref_golden);
+		visl_print_ts_idx(&buf, &buflen, "ref_bwd_ts",
+				  reference_frame_ts[idx_bwd], ref_bwd);
+		visl_print_ts_idx(&buf, &buflen, "ref_alt2_ts",
+				  reference_frame_ts[idx_alt2], ref_alt2);
+		visl_print_ts_idx(&buf, &buflen, "ref_alt_ts",
+				  reference_frame_ts[idx_alt], ref_alt);
+
 		break;
 	}
 	}
@@ -254,15 +271,23 @@ static void visl_tpg_fill_sequence(struct visl_ctx *ctx,
 				   struct visl_run *run, char buf[], size_t bufsz)
 {
 	u32 stream_ms;
-
-	stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
+	int len;
+
+	if (tpg_verbose) {
+		stream_ms = jiffies_to_msecs(get_jiffies_64() - ctx->capture_streamon_jiffies);
+
+		len = scnprintf(buf, bufsz,
+				"stream time: %02d:%02d:%02d:%03d ",
+				(stream_ms / (60 * 60 * 1000)) % 24,
+				(stream_ms / (60 * 1000)) % 60,
+				(stream_ms / 1000) % 60,
+				stream_ms % 1000);
+		buf += len;
+		bufsz -= len;
+	}
 
 	scnprintf(buf, bufsz,
-		  "stream time: %02d:%02d:%02d:%03d sequence:%u timestamp:%lld field:%s",
-		  (stream_ms / (60 * 60 * 1000)) % 24,
-		  (stream_ms / (60 * 1000)) % 60,
-		  (stream_ms / 1000) % 60,
-		  stream_ms % 1000,
+		  "sequence:%u timestamp:%lld field:%s",
 		  run->dst->sequence,
 		  run->dst->vb2_buf.timestamp,
 		  (run->dst->field == V4L2_FIELD_ALTERNATE) ?
@@ -338,35 +363,37 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 	}
 
-	line++;
-	frame_dprintk(ctx->dev, run->dst->sequence, "");
-	scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
-	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
-	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+	if (tpg_verbose) {
+		line++;
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		scnprintf(buf, TPG_STR_BUF_SZ, "Output queue status:");
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
-	len = 0;
-	for (i = 0; i < vb2_get_num_buffers(out_q); i++) {
-		char entry[] = "index: %u, state: %s, request_fd: %d, ";
-		u32 old_len = len;
-		struct vb2_buffer *vb2;
-		char *q_status;
+		len = 0;
+		for (i = 0; i < vb2_get_num_buffers(out_q); i++) {
+			char entry[] = "index: %u, state: %s, request_fd: %d, ";
+			u32 old_len = len;
+			struct vb2_buffer *vb2;
+			char *q_status;
 
-		vb2 = vb2_get_buffer(out_q, i);
-		if (!vb2)
-			continue;
+			vb2 = vb2_get_buffer(out_q, i);
+			if (!vb2)
+				continue;
 
-		q_status = visl_get_vb2_state(vb2->state);
+			q_status = visl_get_vb2_state(vb2->state);
 
-		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
-				 entry, i, q_status,
-				 to_vb2_v4l2_buffer(vb2)->request_fd);
+			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
+					 entry, i, q_status,
+					 to_vb2_v4l2_buffer(vb2)->request_fd);
 
-		len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
-					   &buf[len],
-					   TPG_STR_BUF_SZ - len);
+			len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
+						   &buf[len],
+						   TPG_STR_BUF_SZ - len);
 
-		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
-		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
+			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+		}
 	}
 
 	line++;
@@ -398,32 +425,34 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 	}
 
-	line++;
-	frame_dprintk(ctx->dev, run->dst->sequence, "");
-	scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
-	tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
-	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
+	if (tpg_verbose) {
+		line++;
+		frame_dprintk(ctx->dev, run->dst->sequence, "");
+		scnprintf(buf, TPG_STR_BUF_SZ, "Capture queue status:");
+		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, buf);
+		frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
-	len = 0;
-	for (i = 0; i < vb2_get_num_buffers(cap_q); i++) {
-		u32 old_len = len;
-		struct vb2_buffer *vb2;
-		char *q_status;
+		len = 0;
+		for (i = 0; i < vb2_get_num_buffers(cap_q); i++) {
+			u32 old_len = len;
+			struct vb2_buffer *vb2;
+			char *q_status;
 
-		vb2 = vb2_get_buffer(cap_q, i);
-		if (!vb2)
-			continue;
+			vb2 = vb2_get_buffer(cap_q, i);
+			if (!vb2)
+				continue;
 
-		q_status = visl_get_vb2_state(vb2->state);
+			q_status = visl_get_vb2_state(vb2->state);
 
-		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
-				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
-				 vb2->index, q_status,
-				 vb2->timestamp,
-				 to_vb2_v4l2_buffer(vb2)->is_held);
+			len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
+					 "index: %u, status: %s, timestamp: %llu, is_held: %d",
+					 vb2->index, q_status,
+					 vb2->timestamp,
+					 to_vb2_v4l2_buffer(vb2)->is_held);
 
-		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
-		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+			tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
+			frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
+		}
 	}
 }
 
diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
index c593b1337f11..434e9efbf9b2 100644
--- a/drivers/media/test-drivers/visl/visl.h
+++ b/drivers/media/test-drivers/visl/visl.h
@@ -85,6 +85,7 @@ extern unsigned int visl_dprintk_nframes;
 extern bool keep_bitstream_buffers;
 extern int bitstream_trace_frame_start;
 extern unsigned int bitstream_trace_nframes;
+extern bool tpg_verbose;
 
 #define frame_dprintk(dev, current, fmt, arg...) \
 	do { \
-- 
2.43.0


