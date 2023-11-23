Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DA7F6360
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbjKWPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346215AbjKWPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:53:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF28D5E;
        Thu, 23 Nov 2023 07:53:36 -0800 (PST)
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32FC7660738E;
        Thu, 23 Nov 2023 15:53:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700754815;
        bh=lLh3HN5eIBxg3dtfHkvgpXiGAEqtW51Xbreg2ng/BmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D15V1KiRf8qE9KCTCzQv4GnmDd0BzZsIpdgs6SVwZIFAVY+JcsfxzEr2ruDek7LPH
         cxxo2QvleZllbz4zklFx9Yqe3Kml9Ihhd8EtkfAOtt92jEhNOC3kZ+GMxmt/5nKhDz
         iWMCQNSzqNd9Xdpn2N6uiwueidDt7Q1iVKpM/4daTPB/E2yaLsCN1n8DRquAuQyjC4
         51n75RdS4xpI5nHPaQ+LLl0ziAQgj0/Ju99R9zWuTn+a9clIvSrEgExcSvbBSlay24
         z3G8fg2yK8QUuYVDJdwjG/thOLbYyd5aZZGC9N892uh1mlZfvUewVY4phUAkRKdtyl
         gFza+XsGPNNDQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 1/2] visl: Add AV1 support
Date:   Thu, 23 Nov 2023 10:52:25 -0500
Message-ID: <20231123155342.56277-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123155342.56277-1-detlev.casanova@collabora.com>
References: <20231123155342.56277-1-detlev.casanova@collabora.com>
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

Let the visl test driver accept the AV1 pixel format.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-core.c   |  21 ++
 drivers/media/test-drivers/visl/visl-dec.c    |  72 +++-
 drivers/media/test-drivers/visl/visl-dec.h    |   8 +
 .../media/test-drivers/visl/visl-trace-av1.h  | 314 ++++++++++++++++++
 .../test-drivers/visl/visl-trace-points.c     |   1 +
 drivers/media/test-drivers/visl/visl-video.c  |  18 +
 drivers/media/test-drivers/visl/visl-video.h  |   1 +
 drivers/media/test-drivers/visl/visl.h        |   1 +
 8 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-av1.h

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index 9970dc739ca5..68dac896277b 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -211,6 +211,27 @@ const struct visl_ctrls visl_hevc_ctrls = {
 	.num_ctrls = ARRAY_SIZE(visl_hevc_ctrl_descs),
 };
 
+static const struct visl_ctrl_desc visl_av1_ctrl_descs[] = {
+	{
+		.cfg.id = V4L2_CID_STATELESS_AV1_FRAME,
+	},
+	{
+		.cfg.id = V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY,
+		.cfg.dims = { V4L2_AV1_MAX_TILE_COUNT },
+	},
+	{
+		.cfg.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
+	},
+	{
+		.cfg.id = V4L2_CID_STATELESS_AV1_FILM_GRAIN,
+	},
+};
+
+const struct visl_ctrls visl_av1_ctrls = {
+	.ctrls = visl_av1_ctrl_descs,
+	.num_ctrls = ARRAY_SIZE(visl_av1_ctrl_descs),
+};
+
 struct v4l2_ctrl *visl_find_control(struct visl_ctx *ctx, u32 id)
 {
 	struct v4l2_ctrl_handler *hdl = &ctx->hdl;
diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 318d675e5668..023592231575 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -13,12 +13,21 @@
 #include "visl-trace-vp9.h"
 #include "visl-trace-h264.h"
 #include "visl-trace-hevc.h"
+#include "visl-trace-av1.h"
 
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/tpg/v4l2-tpg.h>
 
+#define LAST_BUF_IDX (V4L2_AV1_REF_LAST_FRAME - V4L2_AV1_REF_LAST_FRAME)
+#define LAST2_BUF_IDX (V4L2_AV1_REF_LAST2_FRAME - V4L2_AV1_REF_LAST_FRAME)
+#define LAST3_BUF_IDX (V4L2_AV1_REF_LAST3_FRAME - V4L2_AV1_REF_LAST_FRAME)
+#define GOLDEN_BUF_IDX (V4L2_AV1_REF_GOLDEN_FRAME - V4L2_AV1_REF_LAST_FRAME)
+#define BWD_BUF_IDX (V4L2_AV1_REF_BWDREF_FRAME - V4L2_AV1_REF_LAST_FRAME)
+#define ALT2_BUF_IDX (V4L2_AV1_REF_ALTREF2_FRAME - V4L2_AV1_REF_LAST_FRAME)
+#define ALT_BUF_IDX (V4L2_AV1_REF_ALTREF_FRAME - V4L2_AV1_REF_LAST_FRAME)
+
 static void *plane_vaddr(struct tpg_data *tpg, struct vb2_buffer *buf,
 			 u32 p, u32 bpl[TPG_MAX_PLANES], u32 h)
 {
@@ -152,6 +161,55 @@ static void visl_get_ref_frames(struct visl_ctx *ctx, u8 *buf,
 
 		break;
 	}
+
+	case VISL_CODEC_AV1: {
+		int idx_last = run->av1.frame->ref_frame_idx[LAST_BUF_IDX];
+		int idx_last2 = run->av1.frame->ref_frame_idx[LAST2_BUF_IDX];
+		int idx_last3 = run->av1.frame->ref_frame_idx[LAST3_BUF_IDX];
+		int idx_golden = run->av1.frame->ref_frame_idx[GOLDEN_BUF_IDX];
+		int idx_bwd = run->av1.frame->ref_frame_idx[BWD_BUF_IDX];
+		int idx_alt2 = run->av1.frame->ref_frame_idx[ALT2_BUF_IDX];
+		int idx_alt = run->av1.frame->ref_frame_idx[ALT_BUF_IDX];
+
+		struct vb2_buffer *ref_last =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last]);
+		struct vb2_buffer *ref_last2 =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last2]);
+		struct vb2_buffer *ref_last3 =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_last3]);
+		struct vb2_buffer *ref_golden =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_golden]);
+		struct vb2_buffer *ref_bwd =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_bwd]);
+		struct vb2_buffer *ref_alt2 =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_alt2]);
+		struct vb2_buffer *ref_alt =
+			vb2_find_buffer(cap_q, run->av1.frame->reference_frame_ts[idx_alt]);
+
+		scnprintf(buf, buflen,
+			  "ref_last_ts: %llu, vb2_idx: %d\n"
+			  "ref_last2_ts: %llu, vb2_idx: %d\n"
+			  "ref_last3_ts: %llu, vb2_idx: %d\n"
+			  "ref_golden_ts: %llu, vb2_idx: %d\n"
+			  "ref_bwd_ts: %llu, vb2_idx: %d\n"
+			  "ref_alt2_ts: %llu, vb2_idx: %d\n"
+			  "ref_alt_ts: %llu, vb2_idx: %d\n",
+			  run->av1.frame->reference_frame_ts[idx_last],
+			  ref_last ? ref_last->index : -1,
+			  run->av1.frame->reference_frame_ts[idx_last2],
+			  ref_last2 ? ref_last2->index : -1,
+			  run->av1.frame->reference_frame_ts[idx_last3],
+			  ref_last3 ? ref_last3->index : -1,
+			  run->av1.frame->reference_frame_ts[idx_golden],
+			  ref_golden ? ref_golden->index : -1,
+			  run->av1.frame->reference_frame_ts[idx_bwd],
+			  ref_bwd ? ref_bwd->index : -1,
+			  run->av1.frame->reference_frame_ts[idx_alt2],
+			  ref_alt2 ? ref_alt2->index : -1,
+			  run->av1.frame->reference_frame_ts[idx_alt],
+			  ref_alt ? ref_alt->index : -1);
+		break;
+	}
 	}
 }
 
@@ -410,7 +468,13 @@ static void visl_trace_ctrls(struct visl_ctx *ctx, struct visl_run *run)
 			trace_v4l2_hevc_dpb_entry(&run->hevc.dpram->dpb[i]);
 
 		trace_v4l2_hevc_pred_weight_table(&run->hevc.spram->pred_weight_table);
-	break;
+		break;
+	case VISL_CODEC_AV1:
+		trace_v4l2_ctrl_av1_sequence(run->av1.seq);
+		trace_v4l2_ctrl_av1_frame(run->av1.frame);
+		trace_v4l2_ctrl_av1_film_grain(run->av1.grain);
+		trace_v4l2_ctrl_av1_tile_group_entry(run->av1.tge);
+		break;
 	}
 }
 
@@ -469,6 +533,12 @@ void visl_device_run(void *priv)
 		run.hevc.sm = visl_find_control_data(ctx, V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
 		run.hevc.dpram = visl_find_control_data(ctx, V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
 		break;
+	case VISL_CODEC_AV1:
+		run.av1.seq = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_SEQUENCE);
+		run.av1.frame = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_FRAME);
+		run.av1.tge = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY);
+		run.av1.grain = visl_find_control_data(ctx, V4L2_CID_STATELESS_AV1_FILM_GRAIN);
+		break;
 	}
 
 	frame_dprintk(ctx->dev, run.dst->sequence,
diff --git a/drivers/media/test-drivers/visl/visl-dec.h b/drivers/media/test-drivers/visl/visl-dec.h
index 4a706a9de02e..c2c2ef3a8798 100644
--- a/drivers/media/test-drivers/visl/visl-dec.h
+++ b/drivers/media/test-drivers/visl/visl-dec.h
@@ -45,6 +45,13 @@ struct visl_hevc_run {
 	const struct v4l2_ctrl_hevc_decode_params *dpram;
 };
 
+struct visl_av1_run {
+	const struct v4l2_ctrl_av1_sequence *seq;
+	const struct v4l2_ctrl_av1_frame *frame;
+	const struct v4l2_ctrl_av1_tile_group_entry *tge;
+	const struct v4l2_ctrl_av1_film_grain *grain;
+};
+
 struct visl_run {
 	struct vb2_v4l2_buffer	*src;
 	struct vb2_v4l2_buffer	*dst;
@@ -56,6 +63,7 @@ struct visl_run {
 		struct visl_vp9_run	vp9;
 		struct visl_h264_run	h264;
 		struct visl_hevc_run	hevc;
+		struct visl_av1_run	av1;
 	};
 };
 
diff --git a/drivers/media/test-drivers/visl/visl-trace-av1.h b/drivers/media/test-drivers/visl/visl-trace-av1.h
new file mode 100644
index 000000000000..09f205de53df
--- /dev/null
+++ b/drivers/media/test-drivers/visl/visl-trace-av1.h
@@ -0,0 +1,314 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(_VISL_TRACE_AV1_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _VISL_TRACE_AV1_H_
+
+#include <linux/tracepoint.h>
+#include "visl.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM visl_av1_controls
+
+DECLARE_EVENT_CLASS(v4l2_ctrl_av1_seq_tmpl,
+	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
+	TP_ARGS(s),
+	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_sequence, s)),
+	TP_fast_assign(__entry->s = *s;),
+	TP_printk("\nflags %s\nseq_profile: %u\norder_hint_bits: %u\nbit_depth: %u\n"
+		  "max_frame_width_minus_1: %u\nmax_frame_height_minus_1: %u\n",
+		  __print_flags(__entry->s.flags, "|",
+		  {V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE, "STILL_PICTURE"},
+		  {V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK, "USE_128X128_SUPERBLOCK"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA, "ENABLE_FILTER_INTRA"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER, "ENABLE_INTRA_EDGE_FILTER"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND, "ENABLE_INTERINTRA_COMPOUND"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND, "ENABLE_MASKED_COMPOUND"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION, "ENABLE_WARPED_MOTION"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER, "ENABLE_DUAL_FILTER"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT, "ENABLE_ORDER_HINT"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP, "ENABLE_JNT_COMP"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS, "ENABLE_REF_FRAME_MVS"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES, "ENABLE_SUPERRES"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF, "ENABLE_CDEF"},
+		  {V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION, "ENABLE_RESTORATION"},
+		  {V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME, "MONO_CHROME"},
+		  {V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE, "COLOR_RANGE"},
+		  {V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X, "SUBSAMPLING_X"},
+		  {V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y, "SUBSAMPLING_Y"},
+		  {V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT, "FILM_GRAIN_PARAMS_PRESENT"},
+		  {V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q, "SEPARATE_UV_DELTA_Q"}),
+		  __entry->s.seq_profile,
+		  __entry->s.order_hint_bits,
+		  __entry->s.bit_depth,
+		  __entry->s.max_frame_width_minus_1,
+		  __entry->s.max_frame_height_minus_1
+	)
+);
+
+DECLARE_EVENT_CLASS(v4l2_ctrl_av1_tge_tmpl,
+	TP_PROTO(const struct v4l2_ctrl_av1_tile_group_entry *t),
+	TP_ARGS(t),
+	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_tile_group_entry, t)),
+	TP_fast_assign(__entry->t = *t;),
+	TP_printk("\ntile_offset: %u\n tile_size: %u\n tile_row: %u\ntile_col: %u\n",
+		  __entry->t.tile_offset,
+		  __entry->t.tile_size,
+		  __entry->t.tile_row,
+		  __entry->t.tile_col
+	)
+);
+
+DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
+	TP_PROTO(const struct v4l2_ctrl_av1_frame *f),
+	TP_ARGS(f),
+	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_frame, f)),
+	TP_fast_assign(__entry->f = *f;),
+	TP_printk("\ntile_info.flags: %s\ntile_info.context_update_tile_id: %u\n"
+		  "tile_info.tile_cols: %u\ntile_info.tile_rows: %u\n"
+		  "tile_info.mi_col_starts: %s\ntile_info.mi_row_starts: %s\n"
+		  "tile_info.width_in_sbs_minus_1: %s\ntile_info.height_in_sbs_minus_1: %s\n"
+		  "tile_info.tile_size_bytes: %u\nquantization.flags: %s\n"
+		  "quantization.base_q_idx: %u\nquantization.delta_q_y_dc: %d\n"
+		  "quantization.delta_q_u_dc: %d\nquantization.delta_q_u_ac: %d\n"
+		  "quantization.delta_q_v_dc: %d\nquantization.delta_q_v_ac: %d\n"
+		  "quantization.qm_y: %u\nquantization.qm_u: %u\nquantization.qm_v: %u\n"
+		  "quantization.delta_q_res: %u\nsuperres_denom: %u\nsegmentation.flags: %s\n"
+		  "segmentation.last_active_seg_id: %u\nsegmentation.feature_enabled:%s\n"
+		  "loop_filter.flags: %s\nloop_filter.level: %s\nloop_filter.sharpness: %u\n"
+		  "loop_filter.ref_deltas: %s\nloop_filter.mode_deltas: %s\n"
+		  "loop_filter.delta_lf_res: %u\ncdef.damping_minus_3: %u\ncdef.bits: %u\n"
+		  "cdef.y_pri_strength: %s\ncdef.y_sec_strength: %s\n"
+		  "cdef.uv_pri_strength: %s\ncdef.uv_sec_strength:%s\nskip_mode_frame: %s\n"
+		  "primary_ref_frame: %u\nloop_restoration.flags: %s\n"
+		  "loop_restoration.lr_unit_shift: %u\nloop_restoration.lr_uv_shift: %u\n"
+		  "loop_restoration.frame_restoration_type: %s\n"
+		  "loop_restoration.loop_restoration_size: %s\nflags: %s\norder_hint: %u\n"
+		  "upscaled_width: %u\nframe_width_minus_1: %u\nframe_height_minus_1: %u\n"
+		  "render_width_minus_1: %u\nrender_height_minus_1: %u\ncurrent_frame_id: %u\n"
+		  "buffer_removal_time: %s\norder_hints: %s\nreference_frame_ts: %s\n"
+		  "ref_frame_idx: %s\nrefresh_frame_flags: %u\n",
+		  __print_flags(__entry->f.tile_info.flags, "|",
+		  {V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING, "UNIFORM_TILE_SPACING"}),
+		  __entry->f.tile_info.context_update_tile_id,
+		  __entry->f.tile_info.tile_cols,
+		  __entry->f.tile_info.tile_rows,
+		  __print_array(__entry->f.tile_info.mi_col_starts,
+				ARRAY_SIZE(__entry->f.tile_info.mi_col_starts),
+				sizeof(__entry->f.tile_info.mi_col_starts[0])),
+		  __print_array(__entry->f.tile_info.mi_row_starts,
+				ARRAY_SIZE(__entry->f.tile_info.mi_row_starts),
+				sizeof(__entry->f.tile_info.mi_row_starts[0])),
+		  __print_array(__entry->f.tile_info.width_in_sbs_minus_1,
+				ARRAY_SIZE(__entry->f.tile_info.width_in_sbs_minus_1),
+				sizeof(__entry->f.tile_info.width_in_sbs_minus_1[0])),
+		  __print_array(__entry->f.tile_info.height_in_sbs_minus_1,
+				ARRAY_SIZE(__entry->f.tile_info.height_in_sbs_minus_1),
+				sizeof(__entry->f.tile_info.height_in_sbs_minus_1[0])),
+		  __entry->f.tile_info.tile_size_bytes,
+		  __print_flags(__entry->f.quantization.flags, "|",
+		  {V4L2_AV1_QUANTIZATION_FLAG_DIFF_UV_DELTA, "DIFF_UV_DELTA"},
+		  {V4L2_AV1_QUANTIZATION_FLAG_USING_QMATRIX, "USING_QMATRIX"},
+		  {V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT, "DELTA_Q_PRESENT"}),
+		  __entry->f.quantization.base_q_idx,
+		  __entry->f.quantization.delta_q_y_dc,
+		  __entry->f.quantization.delta_q_u_dc,
+		  __entry->f.quantization.delta_q_u_ac,
+		  __entry->f.quantization.delta_q_v_dc,
+		  __entry->f.quantization.delta_q_v_ac,
+		  __entry->f.quantization.qm_y,
+		  __entry->f.quantization.qm_u,
+		  __entry->f.quantization.qm_v,
+		  __entry->f.quantization.delta_q_res,
+		  __entry->f.superres_denom,
+		  __print_flags(__entry->f.segmentation.flags, "|",
+		  {V4L2_AV1_SEGMENTATION_FLAG_ENABLED, "ENABLED"},
+		  {V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP, "UPDATE_MAP"},
+		  {V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE, "TEMPORAL_UPDATE"},
+		  {V4L2_AV1_SEGMENTATION_FLAG_UPDATE_DATA, "UPDATE_DATA"},
+		  {V4L2_AV1_SEGMENTATION_FLAG_SEG_ID_PRE_SKIP, "SEG_ID_PRE_SKIP"}),
+		  __entry->f.segmentation.last_active_seg_id,
+		  __print_array(__entry->f.segmentation.feature_enabled,
+				ARRAY_SIZE(__entry->f.segmentation.feature_enabled),
+				sizeof(__entry->f.segmentation.feature_enabled[0])),
+		  __print_flags(__entry->f.loop_filter.flags, "|",
+		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED, "DELTA_ENABLED"},
+		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_UPDATE, "DELTA_UPDATE"},
+		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT, "DELTA_LF_PRESENT"},
+		  {V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_MULTI, "DELTA_LF_MULTI"}),
+		  __print_array(__entry->f.loop_filter.level,
+				ARRAY_SIZE(__entry->f.loop_filter.level),
+				sizeof(__entry->f.loop_filter.level[0])),
+		  __entry->f.loop_filter.sharpness,
+		  __print_array(__entry->f.loop_filter.ref_deltas,
+				ARRAY_SIZE(__entry->f.loop_filter.ref_deltas),
+				sizeof(__entry->f.loop_filter.ref_deltas[0])),
+		  __print_array(__entry->f.loop_filter.mode_deltas,
+				ARRAY_SIZE(__entry->f.loop_filter.mode_deltas),
+				sizeof(__entry->f.loop_filter.mode_deltas[0])),
+		  __entry->f.loop_filter.delta_lf_res,
+		  __entry->f.cdef.damping_minus_3,
+		  __entry->f.cdef.bits,
+		  __print_array(__entry->f.cdef.y_pri_strength,
+				ARRAY_SIZE(__entry->f.cdef.y_pri_strength),
+				sizeof(__entry->f.cdef.y_pri_strength[0])),
+		  __print_array(__entry->f.cdef.y_sec_strength,
+				ARRAY_SIZE(__entry->f.cdef.y_sec_strength),
+				sizeof(__entry->f.cdef.y_sec_strength[0])),
+		  __print_array(__entry->f.cdef.uv_pri_strength,
+				ARRAY_SIZE(__entry->f.cdef.uv_pri_strength),
+				sizeof(__entry->f.cdef.uv_pri_strength[0])),
+		  __print_array(__entry->f.cdef.uv_sec_strength,
+				ARRAY_SIZE(__entry->f.cdef.uv_sec_strength),
+				sizeof(__entry->f.cdef.uv_sec_strength[0])),
+		  __print_array(__entry->f.skip_mode_frame,
+				ARRAY_SIZE(__entry->f.skip_mode_frame),
+				sizeof(__entry->f.skip_mode_frame[0])),
+		  __entry->f.primary_ref_frame,
+		  __print_flags(__entry->f.loop_restoration.flags, "|",
+		  {V4L2_AV1_LOOP_RESTORATION_FLAG_USES_LR, "USES_LR"},
+		  {V4L2_AV1_LOOP_RESTORATION_FLAG_USES_CHROMA_LR, "USES_CHROMA_LR"}),
+		  __entry->f.loop_restoration.lr_unit_shift,
+		  __entry->f.loop_restoration.lr_uv_shift,
+		  __print_array(__entry->f.loop_restoration.frame_restoration_type,
+				ARRAY_SIZE(__entry->f.loop_restoration.frame_restoration_type),
+				sizeof(__entry->f.loop_restoration.frame_restoration_type[0])),
+		  __print_array(__entry->f.loop_restoration.loop_restoration_size,
+				ARRAY_SIZE(__entry->f.loop_restoration.loop_restoration_size),
+				sizeof(__entry->f.loop_restoration.loop_restoration_size[0])),
+		  __print_flags(__entry->f.flags, "|",
+		  {V4L2_AV1_FRAME_FLAG_SHOW_FRAME, "SHOW_FRAME"},
+		  {V4L2_AV1_FRAME_FLAG_SHOWABLE_FRAME, "SHOWABLE_FRAME"},
+		  {V4L2_AV1_FRAME_FLAG_ERROR_RESILIENT_MODE, "ERROR_RESILIENT_MODE"},
+		  {V4L2_AV1_FRAME_FLAG_DISABLE_CDF_UPDATE, "DISABLE_CDF_UPDATE"},
+		  {V4L2_AV1_FRAME_FLAG_ALLOW_SCREEN_CONTENT_TOOLS, "ALLOW_SCREEN_CONTENT_TOOLS"},
+		  {V4L2_AV1_FRAME_FLAG_FORCE_INTEGER_MV, "FORCE_INTEGER_MV"},
+		  {V4L2_AV1_FRAME_FLAG_ALLOW_INTRABC, "ALLOW_INTRABC"},
+		  {V4L2_AV1_FRAME_FLAG_USE_SUPERRES, "USE_SUPERRES"},
+		  {V4L2_AV1_FRAME_FLAG_ALLOW_HIGH_PRECISION_MV, "ALLOW_HIGH_PRECISION_MV"},
+		  {V4L2_AV1_FRAME_FLAG_IS_MOTION_MODE_SWITCHABLE, "IS_MOTION_MODE_SWITCHABLE"},
+		  {V4L2_AV1_FRAME_FLAG_USE_REF_FRAME_MVS, "USE_REF_FRAME_MVS"},
+		  {V4L2_AV1_FRAME_FLAG_DISABLE_FRAME_END_UPDATE_CDF,
+		   "DISABLE_FRAME_END_UPDATE_CDF"},
+		  {V4L2_AV1_FRAME_FLAG_ALLOW_WARPED_MOTION, "ALLOW_WARPED_MOTION"},
+		  {V4L2_AV1_FRAME_FLAG_REFERENCE_SELECT, "REFERENCE_SELECT"},
+		  {V4L2_AV1_FRAME_FLAG_REDUCED_TX_SET, "REDUCED_TX_SET"},
+		  {V4L2_AV1_FRAME_FLAG_SKIP_MODE_ALLOWED, "SKIP_MODE_ALLOWED"},
+		  {V4L2_AV1_FRAME_FLAG_SKIP_MODE_PRESENT, "SKIP_MODE_PRESENT"},
+		  {V4L2_AV1_FRAME_FLAG_FRAME_SIZE_OVERRIDE, "FRAME_SIZE_OVERRIDE"},
+		  {V4L2_AV1_FRAME_FLAG_BUFFER_REMOVAL_TIME_PRESENT, "BUFFER_REMOVAL_TIME_PRESENT"},
+		  {V4L2_AV1_FRAME_FLAG_FRAME_REFS_SHORT_SIGNALING, "FRAME_REFS_SHORT_SIGNALING"}),
+		  __entry->f.order_hint,
+		  __entry->f.upscaled_width,
+		  __entry->f.frame_width_minus_1,
+		  __entry->f.frame_height_minus_1,
+		  __entry->f.render_width_minus_1,
+		  __entry->f.render_height_minus_1,
+		  __entry->f.current_frame_id,
+		  __print_array(__entry->f.buffer_removal_time,
+				ARRAY_SIZE(__entry->f.buffer_removal_time),
+				sizeof(__entry->f.buffer_removal_time[0])),
+		  __print_array(__entry->f.order_hints,
+				ARRAY_SIZE(__entry->f.order_hints),
+				sizeof(__entry->f.order_hints[0])),
+		  __print_array(__entry->f.reference_frame_ts,
+				ARRAY_SIZE(__entry->f.reference_frame_ts),
+				sizeof(__entry->f.reference_frame_ts[0])),
+		  __print_array(__entry->f.ref_frame_idx,
+				ARRAY_SIZE(__entry->f.ref_frame_idx),
+				sizeof(__entry->f.ref_frame_idx[0])),
+		  __entry->f.refresh_frame_flags
+	)
+);
+
+
+DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
+	TP_PROTO(const struct v4l2_ctrl_av1_film_grain *f),
+	TP_ARGS(f),
+	TP_STRUCT__entry(__field_struct(struct v4l2_ctrl_av1_film_grain, f)),
+	TP_fast_assign(__entry->f = *f;),
+	TP_printk("\nflags %s\ncr_mult: %u\ngrain_seed: %u\n"
+		  "film_grain_params_ref_idx: %u\nnum_y_points: %u\npoint_y_value: %s\n"
+		  "point_y_scaling: %s\nnum_cb_points: %u\npoint_cb_value: %s\n"
+		  "point_cb_scaling: %s\nnum_cr_points: %u\npoint_cr_value: %s\n"
+		  "point_cr_scaling: %s\ngrain_scaling_minus_8: %u\nar_coeff_lag: %u\n"
+		  "ar_coeffs_y_plus_128: %s\nar_coeffs_cb_plus_128: %s\n"
+		  "ar_coeffs_cr_plus_128: %s\nar_coeff_shift_minus_6: %u\n"
+		  "grain_scale_shift: %u\ncb_mult: %u\ncb_luma_mult: %u\ncr_luma_mult: %u\n"
+		  "cb_offset: %u\ncr_offset: %u\n",
+		  __print_flags(__entry->f.flags, "|",
+		  {V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN, "APPLY_GRAIN"},
+		  {V4L2_AV1_FILM_GRAIN_FLAG_UPDATE_GRAIN, "UPDATE_GRAIN"},
+		  {V4L2_AV1_FILM_GRAIN_FLAG_CHROMA_SCALING_FROM_LUMA, "CHROMA_SCALING_FROM_LUMA"},
+		  {V4L2_AV1_FILM_GRAIN_FLAG_OVERLAP, "OVERLAP"},
+		  {V4L2_AV1_FILM_GRAIN_FLAG_CLIP_TO_RESTRICTED_RANGE, "CLIP_TO_RESTRICTED_RANGE"}),
+		  __entry->f.cr_mult,
+		  __entry->f.grain_seed,
+		  __entry->f.film_grain_params_ref_idx,
+		  __entry->f.num_y_points,
+		  __print_array(__entry->f.point_y_value,
+				ARRAY_SIZE(__entry->f.point_y_value),
+				sizeof(__entry->f.point_y_value[0])),
+		  __print_array(__entry->f.point_y_scaling,
+				ARRAY_SIZE(__entry->f.point_y_scaling),
+				sizeof(__entry->f.point_y_scaling[0])),
+		  __entry->f.num_cb_points,
+		  __print_array(__entry->f.point_cb_value,
+				ARRAY_SIZE(__entry->f.point_cb_value),
+				sizeof(__entry->f.point_cb_value[0])),
+		  __print_array(__entry->f.point_cb_scaling,
+				ARRAY_SIZE(__entry->f.point_cb_scaling),
+				sizeof(__entry->f.point_cb_scaling[0])),
+		  __entry->f.num_cr_points,
+		  __print_array(__entry->f.point_cr_value,
+				ARRAY_SIZE(__entry->f.point_cr_value),
+				sizeof(__entry->f.point_cr_value[0])),
+		  __print_array(__entry->f.point_cr_scaling,
+				ARRAY_SIZE(__entry->f.point_cr_scaling),
+				sizeof(__entry->f.point_cr_scaling[0])),
+		  __entry->f.grain_scaling_minus_8,
+		  __entry->f.ar_coeff_lag,
+		  __print_array(__entry->f.ar_coeffs_y_plus_128,
+				ARRAY_SIZE(__entry->f.ar_coeffs_y_plus_128),
+				sizeof(__entry->f.ar_coeffs_y_plus_128[0])),
+		  __print_array(__entry->f.ar_coeffs_cb_plus_128,
+				ARRAY_SIZE(__entry->f.ar_coeffs_cb_plus_128),
+				sizeof(__entry->f.ar_coeffs_cb_plus_128[0])),
+		  __print_array(__entry->f.ar_coeffs_cr_plus_128,
+				ARRAY_SIZE(__entry->f.ar_coeffs_cr_plus_128),
+				sizeof(__entry->f.ar_coeffs_cr_plus_128[0])),
+		  __entry->f.ar_coeff_shift_minus_6,
+		  __entry->f.grain_scale_shift,
+		  __entry->f.cb_mult,
+		  __entry->f.cb_luma_mult,
+		  __entry->f.cr_luma_mult,
+		  __entry->f.cb_offset,
+		  __entry->f.cr_offset
+	)
+)
+
+DEFINE_EVENT(v4l2_ctrl_av1_seq_tmpl, v4l2_ctrl_av1_sequence,
+	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
+	TP_ARGS(s)
+);
+
+DEFINE_EVENT(v4l2_ctrl_av1_frame_tmpl, v4l2_ctrl_av1_frame,
+	TP_PROTO(const struct v4l2_ctrl_av1_frame *f),
+	TP_ARGS(f)
+);
+
+DEFINE_EVENT(v4l2_ctrl_av1_tge_tmpl, v4l2_ctrl_av1_tile_group_entry,
+	TP_PROTO(const struct v4l2_ctrl_av1_tile_group_entry *t),
+	TP_ARGS(t)
+);
+
+DEFINE_EVENT(v4l2_ctrl_av1_film_grain_tmpl, v4l2_ctrl_av1_film_grain,
+	TP_PROTO(const struct v4l2_ctrl_av1_film_grain *f),
+	TP_ARGS(f)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/media/test-drivers/visl
+#define TRACE_INCLUDE_FILE visl-trace-av1
+#include <trace/define_trace.h>
diff --git a/drivers/media/test-drivers/visl/visl-trace-points.c b/drivers/media/test-drivers/visl/visl-trace-points.c
index f7b866534f1e..321ff732c682 100644
--- a/drivers/media/test-drivers/visl/visl-trace-points.c
+++ b/drivers/media/test-drivers/visl/visl-trace-points.c
@@ -8,3 +8,4 @@
 #include "visl-trace-vp9.h"
 #include "visl-trace-h264.h"
 #include "visl-trace-hevc.h"
+#include "visl-trace-av1.h"
diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
index 7cac6a6456eb..82d9c259e878 100644
--- a/drivers/media/test-drivers/visl/visl-video.c
+++ b/drivers/media/test-drivers/visl/visl-video.c
@@ -40,6 +40,9 @@ static void visl_set_current_codec(struct visl_ctx *ctx)
 	case V4L2_PIX_FMT_HEVC_SLICE:
 		ctx->current_codec = VISL_CODEC_HEVC;
 		break;
+	case V4L2_PIX_FMT_AV1_FRAME:
+		ctx->current_codec = VISL_CODEC_AV1;
+		break;
 	default:
 		dprintk(ctx->dev, "Warning: unsupported fourcc: %d\n", fourcc);
 		ctx->current_codec = VISL_CODEC_NONE;
@@ -218,6 +221,21 @@ const struct visl_coded_format_desc visl_coded_fmts[] = {
 		.num_decoded_fmts = ARRAY_SIZE(visl_decoded_fmts),
 		.decoded_fmts = visl_decoded_fmts,
 	},
+	{
+		.pixelformat = V4L2_PIX_FMT_AV1_FRAME,
+		.frmsize = {
+			.min_width = 64,
+			.max_width = 4096,
+			.step_width = 1,
+			.min_height = 64,
+			.max_height = 2304,
+			.step_height = 1,
+		},
+		.ctrls = &visl_av1_ctrls,
+		.num_decoded_fmts = ARRAY_SIZE(visl_decoded_fmts),
+		.decoded_fmts = visl_decoded_fmts,
+	},
+
 };
 
 const size_t num_coded_fmts = ARRAY_SIZE(visl_coded_fmts);
diff --git a/drivers/media/test-drivers/visl/visl-video.h b/drivers/media/test-drivers/visl/visl-video.h
index 27ad70a558db..92e274894c20 100644
--- a/drivers/media/test-drivers/visl/visl-video.h
+++ b/drivers/media/test-drivers/visl/visl-video.h
@@ -17,6 +17,7 @@ extern const struct visl_ctrls visl_vp8_ctrls;
 extern const struct visl_ctrls visl_vp9_ctrls;
 extern const struct visl_ctrls visl_h264_ctrls;
 extern const struct visl_ctrls visl_hevc_ctrls;
+extern const struct visl_ctrls visl_av1_ctrls;
 
 int visl_queue_init(void *priv, struct vb2_queue *src_vq,
 		    struct vb2_queue *dst_vq);
diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
index 31639f2e593d..c593b1337f11 100644
--- a/drivers/media/test-drivers/visl/visl.h
+++ b/drivers/media/test-drivers/visl/visl.h
@@ -127,6 +127,7 @@ enum visl_codec {
 	VISL_CODEC_VP9,
 	VISL_CODEC_H264,
 	VISL_CODEC_HEVC,
+	VISL_CODEC_AV1,
 };
 
 struct visl_blob {
-- 
2.41.0

