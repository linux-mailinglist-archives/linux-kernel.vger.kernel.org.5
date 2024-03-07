Return-Path: <linux-kernel+bounces-96077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9528756CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345B71C216CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83A13665C;
	Thu,  7 Mar 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aaKp2pDw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306012FF8C;
	Thu,  7 Mar 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838779; cv=none; b=UN9FQo/1tZcuy9j53+liZlwygVm+9XvQhMuNLSXzDI3yFwAOO6IXURMLv67vKpmp67GA4dgt2vvdCqNZk0PwhZWULFcPQhfvvfynwOi0HKRuX8dL12Lz8yq5fhj7eA3VuDx1JIZvPqjyNiEabeWOTboiM63gukf0fOZnvpxdQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838779; c=relaxed/simple;
	bh=9QFash5rhtEgauooL1CGidnfPpNBsj7gG+HqJ19XGoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQE759VWWv91IpreQ2j7pviTg5itPUVS6/txRMjmvV/ytITgVBVyXioFo2fQ6HIMT9Z4BZk4NCzaVFyumikZsStdVvjcrN+AQ05DMRTlT0vY2ZPJbvx4eyLJVE7njKkbrrpKnZPqbFjY1rbH6jpPnrhlTTPnng07N6qEc3Nf5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aaKp2pDw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709838773;
	bh=9QFash5rhtEgauooL1CGidnfPpNBsj7gG+HqJ19XGoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaKp2pDwHh/SgFq18lFU1SWNMhRhmKVqlw3x41po2BcbrvAfLF7kXsVBo1OUkHJTF
	 F++Qxjf/vpBS+ZWKaK3+n2YU39lItdefxFxat8WqVbSSQshmKb0D+JARNVttKmH680
	 UazEoz3Pv4K2na6+izVM+28K7iQ78STpZxplbQOLorwRNZYZ/6dGysDdzl7GI5CBQ6
	 xR16rq/hKOdyht6+sccwPdGg7Mg+PsrdoG49Md+Rmd2TaTD6oxNyvxgbhy9iAHf4y7
	 /rkWI/JLiIb0q4K5vJ+OJMDfwZPV8H5d3PiaQuf4v01P2xxDh4k2Im3/x07zx0uz/2
	 x2YFTeBilzLKw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 062FF37820EE;
	Thu,  7 Mar 2024 19:12:49 +0000 (UTC)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: wedsonaf@gmail.com,
	ojeda@kernel.org,
	mchehab@kernel.org,
	hverkuil@xs4all.nl
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: [RFC PATCH v2 1/2] v4l2-core: rewrite the VP9 library in Rust
Date: Thu,  7 Mar 2024 16:08:15 -0300
Message-ID: <20240307190841.10260-2-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307190841.10260-1-daniel.almeida@collabora.com>
References: <20240227215146.46487-1-daniel.almeida@collabora.com>
 <20240307190841.10260-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/media/platform/verisilicon/Kconfig    |    2 +-
 .../platform/verisilicon/hantro_g2_vp9_dec.c  |   38 +-
 .../media/platform/verisilicon/hantro_hw.h    |    8 +-
 drivers/media/v4l2-core/Kconfig               |    5 +
 drivers/staging/media/rkvdec/Kconfig          |    2 +-
 drivers/staging/media/rkvdec/rkvdec-vp9.c     |   52 +-
 include/media/v4l2-vp9-rs.h                   |   99 +
 rust/bindings/bindings_helper.h               |    1 +
 rust/kernel/lib.rs                            |    2 +
 rust/kernel/media.rs                          |    5 +
 rust/kernel/media/v4l2_core.rs                |    6 +
 rust/kernel/media/v4l2_core/cbindgen.toml     |   26 +
 rust/kernel/media/v4l2_core/vp9.rs            | 2053 +++++++++++++++++
 13 files changed, 2249 insertions(+), 50 deletions(-)
 create mode 100644 include/media/v4l2-vp9-rs.h
 create mode 100644 rust/kernel/media.rs
 create mode 100644 rust/kernel/media/v4l2_core.rs
 create mode 100644 rust/kernel/media/v4l2_core/cbindgen.toml
 create mode 100644 rust/kernel/media/v4l2_core/vp9.rs

diff --git a/drivers/media/platform/verisilicon/Kconfig b/drivers/media/platform/verisilicon/Kconfig
index 24b927d8f182..d8e4e9b5de2f 100644
--- a/drivers/media/platform/verisilicon/Kconfig
+++ b/drivers/media/platform/verisilicon/Kconfig
@@ -12,7 +12,7 @@ config VIDEO_HANTRO
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
 	select V4L2_H264
-	select V4L2_VP9
+	select V4L2_VP9_RS
 	help
 	  Support for the Hantro IP based Video Processing Units present on
 	  Rockchip and NXP i.MX8M SoCs, which accelerate video and image
diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
index 342e543dee4c..43990b550919 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <media/v4l2-mem2mem.h>
-#include <media/v4l2-vp9.h>
+#include <media/v4l2-vp9-rs.h>
 
 #include "hantro.h"
 #include "hantro_vp9.h"
@@ -63,7 +63,7 @@ static int start_prepare_run(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_
 	 *	frame_context_idx = 0
 	 * }
 	 */
-	fctx_idx = v4l2_vp9_reset_frame_ctx(*dec_params, vp9_ctx->frame_context);
+	fctx_idx = v4l2_vp9_reset_frame_ctx_rs(*dec_params, &vp9_ctx->frame_context);
 	vp9_ctx->cur.frame_context_idx = fctx_idx;
 
 	/* 6.1 frame(sz): load_probs() and load_probs2() */
@@ -83,7 +83,7 @@ static int start_prepare_run(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_
 	 * fw_update_probs() performs actual probs updates or leaves probs as-is
 	 * for values for which a zero was passed from userspace.
 	 */
-	v4l2_vp9_fw_update_probs(&vp9_ctx->probability_tables, prob_updates, *dec_params);
+	v4l2_vp9_fw_update_probs_rs(&vp9_ctx->probability_tables, prob_updates, *dec_params);
 
 	return 0;
 }
@@ -422,7 +422,7 @@ static void config_segment(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fr
 		if (segment_enabled) {
 			if (update_data)
 				update_feat_and_flag(vp9_ctx, seg, feat_id, segid);
-			if (v4l2_vp9_seg_feat_enabled(vp9_ctx->feature_enabled, feat_id, segid))
+			if (v4l2_vp9_seg_feat_enabled_rs(&vp9_ctx->feature_enabled, feat_id, segid))
 				feat_val = feat_val_clip3(feat_val,
 							  vp9_ctx->feature_data[segid][feat_id],
 							  absolute, 255);
@@ -435,7 +435,7 @@ static void config_segment(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fr
 		if (segment_enabled) {
 			if (update_data)
 				update_feat_and_flag(vp9_ctx, seg, feat_id, segid);
-			if (v4l2_vp9_seg_feat_enabled(vp9_ctx->feature_enabled, feat_id, segid))
+			if (v4l2_vp9_seg_feat_enabled_rs(&vp9_ctx->feature_enabled, feat_id, segid))
 				feat_val = feat_val_clip3(feat_val,
 							  vp9_ctx->feature_data[segid][feat_id],
 							  absolute, 63);
@@ -449,7 +449,7 @@ static void config_segment(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fr
 			if (update_data)
 				update_feat_and_flag(vp9_ctx, seg, feat_id, segid);
 			if (!(dec_params->flags & V4L2_VP9_FRAME_FLAG_KEY_FRAME) &&
-			    v4l2_vp9_seg_feat_enabled(vp9_ctx->feature_enabled, feat_id, segid))
+			    v4l2_vp9_seg_feat_enabled_rs(&vp9_ctx->feature_enabled, feat_id, segid))
 				feat_val = vp9_ctx->feature_data[segid][feat_id] + 1;
 		}
 		hantro_reg_write(ctx->dev, &seg_regs[segid][feat_id], feat_val);
@@ -460,7 +460,7 @@ static void config_segment(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fr
 		if (segment_enabled) {
 			if (update_data)
 				update_feat_and_flag(vp9_ctx, seg, feat_id, segid);
-			feat_val = v4l2_vp9_seg_feat_enabled(vp9_ctx->feature_enabled,
+			feat_val = v4l2_vp9_seg_feat_enabled_rs(&vp9_ctx->feature_enabled,
 							     feat_id, segid) ? 1 : 0;
 		}
 		hantro_reg_write(ctx->dev, &seg_regs[segid][feat_id], feat_val);
@@ -637,17 +637,17 @@ static void config_probs(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fram
 	struct hantro_g2_probs *adaptive;
 	struct hantro_g2_mv_probs *mv;
 	const struct v4l2_vp9_segmentation *seg = &dec_params->seg;
-	const struct v4l2_vp9_frame_context *probs = &vp9_ctx->probability_tables;
+	const struct v4l2_vp9_frame_context_rs *probs = &vp9_ctx->probability_tables;
 	int i, j, k, l, m;
 
 	for (i = 0; i < ARRAY_SIZE(all_probs->kf_y_mode_prob); ++i)
 		for (j = 0; j < ARRAY_SIZE(all_probs->kf_y_mode_prob[0]); ++j) {
 			memcpy(all_probs->kf_y_mode_prob[i][j],
-			       v4l2_vp9_kf_y_mode_prob[i][j],
+			       v4l2_vp9_kf_y_mode_prob_rs[i][j],
 			       ARRAY_SIZE(all_probs->kf_y_mode_prob[i][j]));
 
 			all_probs->kf_y_mode_prob_tail[i][j][0] =
-				v4l2_vp9_kf_y_mode_prob[i][j][8];
+				v4l2_vp9_kf_y_mode_prob_rs[i][j][8];
 		}
 
 	memcpy(all_probs->mb_segment_tree_probs, seg->tree_probs,
@@ -657,10 +657,10 @@ static void config_probs(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fram
 	       sizeof(all_probs->segment_pred_probs));
 
 	for (i = 0; i < ARRAY_SIZE(all_probs->kf_uv_mode_prob); ++i) {
-		memcpy(all_probs->kf_uv_mode_prob[i], v4l2_vp9_kf_uv_mode_prob[i],
+		memcpy(all_probs->kf_uv_mode_prob[i], v4l2_vp9_kf_uv_mode_prob_rs[i],
 		       ARRAY_SIZE(all_probs->kf_uv_mode_prob[i]));
 
-		all_probs->kf_uv_mode_prob_tail[i][0] = v4l2_vp9_kf_uv_mode_prob[i][8];
+		all_probs->kf_uv_mode_prob_tail[i][0] = v4l2_vp9_kf_uv_mode_prob_rs[i][8];
 	}
 
 	adaptive = &all_probs->probs;
@@ -692,8 +692,8 @@ static void config_probs(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_fram
 	}
 
 	for (i = 0; i < ARRAY_SIZE(adaptive->partition[0]); ++i) {
-		memcpy(adaptive->partition[0][i], v4l2_vp9_kf_partition_probs[i],
-		       sizeof(v4l2_vp9_kf_partition_probs[i]));
+		memcpy(adaptive->partition[0][i], v4l2_vp9_kf_partition_probs_rs[i],
+		       sizeof(v4l2_vp9_kf_partition_probs_rs[i]));
 
 		adaptive->partition[0][i][3] = 0;
 	}
@@ -933,7 +933,7 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx)
 
 	if (!(vp9_ctx->cur.flags & V4L2_VP9_FRAME_FLAG_PARALLEL_DEC_MODE)) {
 		/* error_resilient_mode == 0 && frame_parallel_decoding_mode == 0 */
-		struct v4l2_vp9_frame_context *probs = &vp9_ctx->probability_tables;
+		struct v4l2_vp9_frame_context_rs *probs = &vp9_ctx->probability_tables;
 		bool frame_is_intra = vp9_ctx->cur.flags &
 		    (V4L2_VP9_FRAME_FLAG_KEY_FRAME | V4L2_VP9_FRAME_FLAG_INTRA_ONLY);
 		struct tx_and_skip {
@@ -942,7 +942,7 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx)
 			u8 tx32[2][3];
 			u8 skip[3];
 		} _tx_skip, *tx_skip = &_tx_skip;
-		struct v4l2_vp9_frame_symbol_counts *counts;
+		struct v4l2_vp9_frame_symbol_counts_rs *counts;
 		struct symbol_counts *hantro_cnts;
 		u32 tx16p[2][4];
 		int i;
@@ -968,7 +968,8 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx)
 		}
 		counts->tx16p = &tx16p;
 
-		v4l2_vp9_adapt_coef_probs(probs, counts,
+		v4l2_vp9_adapt_coef_probs_rs(probs,
+								     counts,
 					  !vp9_ctx->last.valid ||
 					  vp9_ctx->last.flags & V4L2_VP9_FRAME_FLAG_KEY_FRAME,
 					  frame_is_intra);
@@ -984,7 +985,8 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx)
 				mv_mode[i][3] = hantro_cnts->inter_mode_counts[i][2][1];
 			}
 			counts->mv_mode = &mv_mode;
-			v4l2_vp9_adapt_noncoef_probs(&vp9_ctx->probability_tables, counts,
+			v4l2_vp9_adapt_noncoef_probs_rs(&vp9_ctx->probability_tables,
+										   counts,
 						     vp9_ctx->cur.reference_mode,
 						     vp9_ctx->cur.interpolation_filter,
 						     vp9_ctx->cur.tx_mode, vp9_ctx->cur.flags);
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 9aec8a79acdc..f8baa898ef53 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -12,7 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/v4l2-controls.h>
 #include <media/v4l2-ctrls.h>
-#include <media/v4l2-vp9.h>
+#include <media/v4l2-vp9-rs.h>
 #include <media/videobuf2-core.h>
 
 #include "rockchip_av1_entropymode.h"
@@ -231,9 +231,9 @@ struct hantro_vp9_dec_hw_ctx {
 	struct hantro_aux_buf tile_edge;
 	struct hantro_aux_buf segment_map;
 	struct hantro_aux_buf misc;
-	struct v4l2_vp9_frame_symbol_counts cnts;
-	struct v4l2_vp9_frame_context probability_tables;
-	struct v4l2_vp9_frame_context frame_context[4];
+	struct v4l2_vp9_frame_symbol_counts_rs cnts;
+	struct v4l2_vp9_frame_context_rs probability_tables;
+	struct v4l2_vp9_frame_context_rs frame_context[4];
 	struct hantro_vp9_frame_info cur;
 	struct hantro_vp9_frame_info last;
 
diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
index 331b8e535e5b..878229c2490b 100644
--- a/drivers/media/v4l2-core/Kconfig
+++ b/drivers/media/v4l2-core/Kconfig
@@ -48,6 +48,11 @@ config V4L2_H264
 config V4L2_VP9
 	tristate
 
+# Used by drivers that need the Rust equivalent to v4l2-vp9.ko
+config V4L2_VP9_RS
+	tristate
+	depends on RUST
+
 # Used by drivers that need v4l2-mem2mem.ko
 config V4L2_MEM2MEM_DEV
 	tristate
diff --git a/drivers/staging/media/rkvdec/Kconfig b/drivers/staging/media/rkvdec/Kconfig
index 5f3bdd848a2c..245dc47082d4 100644
--- a/drivers/staging/media/rkvdec/Kconfig
+++ b/drivers/staging/media/rkvdec/Kconfig
@@ -8,7 +8,7 @@ config VIDEO_ROCKCHIP_VDEC
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
 	select V4L2_H264
-	select V4L2_VP9
+	select V4L2_VP9_RS
 	help
 	  Support for the Rockchip Video Decoder IP present on Rockchip SoCs,
 	  which accelerates video decoding.
diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
index 0e7e16f20eeb..86c6903d11ab 100644
--- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
+++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <media/v4l2-mem2mem.h>
-#include <media/v4l2-vp9.h>
+#include <media/v4l2-vp9-rs.h>
 
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
@@ -157,10 +157,10 @@ struct rkvdec_vp9_frame_info {
 struct rkvdec_vp9_ctx {
 	struct rkvdec_aux_buf priv_tbl;
 	struct rkvdec_aux_buf count_tbl;
-	struct v4l2_vp9_frame_symbol_counts inter_cnts;
-	struct v4l2_vp9_frame_symbol_counts intra_cnts;
-	struct v4l2_vp9_frame_context probability_tables;
-	struct v4l2_vp9_frame_context frame_context[4];
+	struct v4l2_vp9_frame_symbol_counts_rs inter_cnts;
+	struct v4l2_vp9_frame_symbol_counts_rs intra_cnts;
+	struct v4l2_vp9_frame_context_rs probability_tables;
+	struct v4l2_vp9_frame_context_rs frame_context[4];
 	struct rkvdec_vp9_frame_info cur;
 	struct rkvdec_vp9_frame_info last;
 };
@@ -192,7 +192,7 @@ static void init_intra_only_probs(struct rkvdec_ctx *ctx,
 	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
 	struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
 	struct rkvdec_vp9_intra_only_frame_probs *rkprobs;
-	const struct v4l2_vp9_frame_context *probs;
+	const struct v4l2_vp9_frame_context_rs *probs;
 	unsigned int i, j, k;
 
 	rkprobs = &tbl->probs.intra_only;
@@ -209,15 +209,15 @@ static void init_intra_only_probs(struct rkvdec_ctx *ctx,
 	}
 
 	/* intra mode prob  80 x 128 bits */
-	for (i = 0; i < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob); i++) {
+	for (i = 0; i < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob_rs); i++) {
 		unsigned int byte_count = 0;
 		int idx = 0;
 
 		/* vp9_kf_y_mode_prob */
-		for (j = 0; j < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob[0]); j++) {
-			for (k = 0; k < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob[0][0]);
+		for (j = 0; j < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob_rs[0]); j++) {
+			for (k = 0; k < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob_rs[0][0]);
 			     k++) {
-				u8 val = v4l2_vp9_kf_y_mode_prob[i][j][k];
+				u8 val = v4l2_vp9_kf_y_mode_prob_rs[i][j][k];
 
 				rkprobs->intra_mode[i].y_mode[idx++] = val;
 				byte_count++;
@@ -229,8 +229,8 @@ static void init_intra_only_probs(struct rkvdec_ctx *ctx,
 		}
 	}
 
-	for (i = 0; i < sizeof(v4l2_vp9_kf_uv_mode_prob); ++i) {
-		const u8 *ptr = (const u8 *)v4l2_vp9_kf_uv_mode_prob;
+	for (i = 0; i < sizeof(v4l2_vp9_kf_uv_mode_prob_rs); ++i) {
+		const u8 *ptr = (const u8 *)v4l2_vp9_kf_uv_mode_prob_rs;
 
 		rkprobs->intra_mode[i / 23].uv_mode[i % 23] = ptr[i];
 	}
@@ -242,7 +242,7 @@ static void init_inter_probs(struct rkvdec_ctx *ctx,
 	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
 	struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
 	struct rkvdec_vp9_inter_frame_probs *rkprobs;
-	const struct v4l2_vp9_frame_context *probs;
+	const struct v4l2_vp9_frame_context_rs *probs;
 	unsigned int i, j, k;
 
 	rkprobs = &tbl->probs.inter;
@@ -315,7 +315,7 @@ static void init_probs(struct rkvdec_ctx *ctx,
 	struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
 	struct rkvdec_vp9_probs *rkprobs = &tbl->probs;
 	const struct v4l2_vp9_segmentation *seg;
-	const struct v4l2_vp9_frame_context *probs;
+	const struct v4l2_vp9_frame_context_rs *probs;
 	bool intra_only;
 
 	dec_params = run->decode_params;
@@ -330,7 +330,7 @@ static void init_probs(struct rkvdec_ctx *ctx,
 
 	/* sb info  5 x 128 bit */
 	memcpy(rkprobs->partition,
-	       intra_only ? v4l2_vp9_kf_partition_probs : probs->partition,
+	       intra_only ? v4l2_vp9_kf_partition_probs_rs : probs->partition,
 	       sizeof(rkprobs->partition));
 
 	memcpy(rkprobs->pred, seg->pred_probs, sizeof(rkprobs->pred));
@@ -448,7 +448,7 @@ static void config_ref_registers(struct rkvdec_ctx *ctx,
 static void config_seg_registers(struct rkvdec_ctx *ctx, unsigned int segid)
 {
 	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
-	const struct v4l2_vp9_segmentation *seg;
+	struct v4l2_vp9_segmentation *seg;
 	struct rkvdec_dev *rkvdec = ctx->dev;
 	s16 feature_val;
 	int feature_id;
@@ -456,28 +456,28 @@ static void config_seg_registers(struct rkvdec_ctx *ctx, unsigned int segid)
 
 	seg = vp9_ctx->last.valid ? &vp9_ctx->last.seg : &vp9_ctx->cur.seg;
 	feature_id = V4L2_VP9_SEG_LVL_ALT_Q;
-	if (v4l2_vp9_seg_feat_enabled(seg->feature_enabled, feature_id, segid)) {
+	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid)) {
 		feature_val = seg->feature_data[segid][feature_id];
 		val |= RKVDEC_SEGID_FRAME_QP_DELTA_EN(1) |
 		       RKVDEC_SEGID_FRAME_QP_DELTA(feature_val);
 	}
 
 	feature_id = V4L2_VP9_SEG_LVL_ALT_L;
-	if (v4l2_vp9_seg_feat_enabled(seg->feature_enabled, feature_id, segid)) {
+	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid)) {
 		feature_val = seg->feature_data[segid][feature_id];
 		val |= RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE_EN(1) |
 		       RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE(feature_val);
 	}
 
 	feature_id = V4L2_VP9_SEG_LVL_REF_FRAME;
-	if (v4l2_vp9_seg_feat_enabled(seg->feature_enabled, feature_id, segid)) {
+	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid)) {
 		feature_val = seg->feature_data[segid][feature_id];
 		val |= RKVDEC_SEGID_REFERINFO_EN(1) |
 		       RKVDEC_SEGID_REFERINFO(feature_val);
 	}
 
 	feature_id = V4L2_VP9_SEG_LVL_SKIP;
-	if (v4l2_vp9_seg_feat_enabled(seg->feature_enabled, feature_id, segid))
+	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid))
 		val |= RKVDEC_SEGID_FRAME_SKIP_EN(1);
 
 	if (!segid &&
@@ -773,7 +773,7 @@ static int rkvdec_vp9_run_preamble(struct rkvdec_ctx *ctx,
 	 *	frame_context_idx = 0
 	 * }
 	 */
-	fctx_idx = v4l2_vp9_reset_frame_ctx(dec_params, vp9_ctx->frame_context);
+	fctx_idx = v4l2_vp9_reset_frame_ctx_rs(dec_params, &vp9_ctx->frame_context);
 	vp9_ctx->cur.frame_context_idx = fctx_idx;
 
 	/* 6.1 frame(sz): load_probs() and load_probs2() */
@@ -793,7 +793,7 @@ static int rkvdec_vp9_run_preamble(struct rkvdec_ctx *ctx,
 	 * fw_update_probs() performs actual probs updates or leaves probs as-is
 	 * for values for which a zero was passed from userspace.
 	 */
-	v4l2_vp9_fw_update_probs(&vp9_ctx->probability_tables, prob_updates, dec_params);
+	v4l2_vp9_fw_update_probs_rs(&vp9_ctx->probability_tables, prob_updates, dec_params);
 
 	return 0;
 }
@@ -871,7 +871,7 @@ static void rkvdec_vp9_done(struct rkvdec_ctx *ctx,
 
 	if (!(vp9_ctx->cur.flags & V4L2_VP9_FRAME_FLAG_PARALLEL_DEC_MODE)) {
 		/* error_resilient_mode == 0 && frame_parallel_decoding_mode == 0 */
-		struct v4l2_vp9_frame_context *probs = &vp9_ctx->probability_tables;
+		struct v4l2_vp9_frame_context_rs *probs = &vp9_ctx->probability_tables;
 		bool frame_is_intra = vp9_ctx->cur.flags &
 		    (V4L2_VP9_FRAME_FLAG_KEY_FRAME | V4L2_VP9_FRAME_FLAG_INTRA_ONLY);
 		struct tx_and_skip {
@@ -880,7 +880,7 @@ static void rkvdec_vp9_done(struct rkvdec_ctx *ctx,
 			u8 tx32[2][3];
 			u8 skip[3];
 		} _tx_skip, *tx_skip = &_tx_skip;
-		struct v4l2_vp9_frame_symbol_counts *counts;
+		struct v4l2_vp9_frame_symbol_counts_rs *counts;
 
 		/* buffer the forward-updated TX and skip probs */
 		if (frame_is_intra)
@@ -894,7 +894,7 @@ static void rkvdec_vp9_done(struct rkvdec_ctx *ctx,
 			copy_tx_and_skip(probs, tx_skip);
 
 		counts = frame_is_intra ? &vp9_ctx->intra_cnts : &vp9_ctx->inter_cnts;
-		v4l2_vp9_adapt_coef_probs(probs, counts,
+		v4l2_vp9_adapt_coef_probs_rs(probs, counts,
 					  !vp9_ctx->last.valid ||
 					  vp9_ctx->last.flags & V4L2_VP9_FRAME_FLAG_KEY_FRAME,
 					  frame_is_intra);
@@ -909,7 +909,7 @@ static void rkvdec_vp9_done(struct rkvdec_ctx *ctx,
 			counts->classes = &classes;
 
 			/* load_probs2() already done */
-			v4l2_vp9_adapt_noncoef_probs(&vp9_ctx->probability_tables, counts,
+			v4l2_vp9_adapt_noncoef_probs_rs(&vp9_ctx->probability_tables, counts,
 						     vp9_ctx->cur.reference_mode,
 						     vp9_ctx->cur.interpolation_filter,
 						     vp9_ctx->cur.tx_mode, vp9_ctx->cur.flags);
diff --git a/include/media/v4l2-vp9-rs.h b/include/media/v4l2-vp9-rs.h
new file mode 100644
index 000000000000..3e93f67b0002
--- /dev/null
+++ b/include/media/v4l2-vp9-rs.h
@@ -0,0 +1,99 @@
+#ifndef V4L2_VP9_RS_H
+#define V4L2_VP9_RS_H
+
+/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */
+
+#include <media/v4l2-ctrls.h>
+
+struct v4l2_vp9_frame_mv_context_rs {
+  uint8_t joint[3];
+  uint8_t sign[2];
+  uint8_t classes[2][10];
+  uint8_t class0_bit[2];
+  uint8_t bits[2][10];
+  uint8_t class0_fr[2][2][3];
+  uint8_t fr[2][3];
+  uint8_t class0_hp[2];
+  uint8_t hp[2];
+};
+
+struct v4l2_vp9_frame_context_rs {
+  uint8_t tx8[2][1];
+  uint8_t tx16[2][2];
+  uint8_t tx32[2][3];
+  uint8_t coef[4][2][2][6][6][3];
+  uint8_t skip[3];
+  uint8_t inter_mode[7][3];
+  uint8_t interp_filter[4][2];
+  uint8_t is_inter[4];
+  uint8_t comp_mode[5];
+  uint8_t single_ref[5][2];
+  uint8_t comp_ref[5];
+  uint8_t y_mode[4][9];
+  uint8_t uv_mode[10][9];
+  uint8_t partition[16][3];
+  struct v4l2_vp9_frame_mv_context_rs mv;
+};
+
+struct v4l2_vp9_frame_symbol_counts_rs {
+  uint32_t (*partition)[16][4];
+  uint32_t (*skip)[3][2];
+  uint32_t (*intra_inter)[4][2];
+  uint32_t (*tx32p)[2][4];
+  uint32_t (*tx16p)[2][4];
+  uint32_t (*tx8p)[2][2];
+  uint32_t (*y_mode)[4][10];
+  uint32_t (*uv_mode)[10][10];
+  uint32_t (*comp)[5][2];
+  uint32_t (*comp_ref)[5][2];
+  uint32_t (*single_ref)[5][2][2];
+  uint32_t (*mv_mode)[7][4];
+  uint32_t (*filter)[4][3];
+  uint32_t (*mv_joint)[4];
+  uint32_t (*sign)[2][2];
+  uint32_t (*classes)[2][11];
+  uint32_t (*class0)[2][2];
+  uint32_t (*bits)[2][10][2];
+  uint32_t (*class0_fp)[2][2][4];
+  uint32_t (*fp)[2][4];
+  uint32_t (*class0_hp)[2][2];
+  uint32_t (*hp)[2][2];
+  uint32_t (*coeff[4][2][2][6][6])[3];
+  uint32_t *eob[4][2][2][6][6][2];
+};
+
+extern const uint8_t v4l2_vp9_kf_y_mode_prob_rs[10][10][9];
+
+extern const uint8_t v4l2_vp9_kf_partition_probs_rs[16][3];
+
+extern const uint8_t v4l2_vp9_kf_uv_mode_prob_rs[10][9];
+
+extern const struct v4l2_vp9_frame_context_rs v4l2_vp9_default_probs_rs;
+
+/**
+ * Counterpart to 6.3 compressed_header(), but parsing has been done in userspace.
+ */
+void v4l2_vp9_fw_update_probs_rs(struct v4l2_vp9_frame_context_rs *probs,
+                                 const struct v4l2_ctrl_vp9_compressed_hdr *deltas,
+                                 const struct v4l2_ctrl_vp9_frame *dec_params);
+
+uint8_t v4l2_vp9_reset_frame_ctx_rs(const struct v4l2_ctrl_vp9_frame *dec_params,
+                                    struct v4l2_vp9_frame_context_rs (*frame_context)[4]);
+
+void v4l2_vp9_adapt_coef_probs_rs(struct v4l2_vp9_frame_context_rs *probs,
+                                  struct v4l2_vp9_frame_symbol_counts_rs *counts,
+                                  bool use_128,
+                                  bool frame_is_intra);
+
+void v4l2_vp9_adapt_noncoef_probs_rs(struct v4l2_vp9_frame_context_rs *probs,
+                                     struct v4l2_vp9_frame_symbol_counts_rs *counts,
+                                     uint8_t reference_mode,
+                                     uint8_t interpolation_filter,
+                                     uint8_t tx_mode,
+                                     uint32_t flags);
+
+bool v4l2_vp9_seg_feat_enabled_rs(const uint8_t (*feature_enabled)[8],
+                                  uint32_t feature,
+                                  uint32_t segid);
+
+#endif /* V4L2_VP9_RS_H */
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c651d38e5dd6..25e2c06bb967 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/task_work.h>
 #include <linux/workqueue.h>
+#include <linux/v4l2-controls.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index cc39195b0157..724e1d3bf2af 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,8 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+#[cfg(CONFIG_MEDIA_SUPPORT)]
+pub mod media;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod prelude;
diff --git a/rust/kernel/media.rs b/rust/kernel/media.rs
new file mode 100644
index 000000000000..72f5cd716874
--- /dev/null
+++ b/rust/kernel/media.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Media support
+
+pub mod v4l2_core;
\ No newline at end of file
diff --git a/rust/kernel/media/v4l2_core.rs b/rust/kernel/media/v4l2_core.rs
new file mode 100644
index 000000000000..7515fe748a65
--- /dev/null
+++ b/rust/kernel/media/v4l2_core.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Core
+
+#[cfg(CONFIG_V4L2_VP9_RS)]
+pub mod vp9;
\ No newline at end of file
diff --git a/rust/kernel/media/v4l2_core/cbindgen.toml b/rust/kernel/media/v4l2_core/cbindgen.toml
new file mode 100644
index 000000000000..ebbc8a5e2fff
--- /dev/null
+++ b/rust/kernel/media/v4l2_core/cbindgen.toml
@@ -0,0 +1,26 @@
+# Generate the C API with:
+# cbindgen  --lang c  -v --config rust/kernel/media/v4l2_core/cbindgen.toml --output include/media/v4l2-vp9-rs.h -- rust/kernel/media/v4l2_core/vp9.rs
+
+language = "C"
+
+# No <stdarg.h>, <stdbool.h>, <stdint.h>, <stdlib.h>, <uchar.h>
+no_includes = true
+style = "tag"
+
+sys_includes = ["media/v4l2-ctrls.h"]
+autogen_warning = "/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */"
+usize_is_size_t = true
+include_guard = "V4L2_VP9_RS_H"
+
+# Rename everything from bindgen
+# See https://github.com/mozilla/cbindgen/issues/621
+# Also rename our mangled structs into snake_case for the C API
+[export.rename]
+"v4l2_ctrl_vp9_compressed_hdr" = "struct v4l2_ctrl_vp9_compressed_hdr"
+"v4l2_ctrl_vp9_frame" = "struct v4l2_ctrl_vp9_frame"
+"FrameContext" = "v4l2_vp9_frame_context_rs"
+"FrameSymbolCounts" = "v4l2_vp9_frame_symbol_counts_rs"
+"FrameMvContext" = "v4l2_vp9_frame_mv_context_rs"
+
+[enum]
+prefix_with_name = true
diff --git a/rust/kernel/media/v4l2_core/vp9.rs b/rust/kernel/media/v4l2_core/vp9.rs
new file mode 100644
index 000000000000..62e3c1d7c625
--- /dev/null
+++ b/rust/kernel/media/v4l2_core/vp9.rs
@@ -0,0 +1,2053 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! VP9 helpers
+//! This library was initially written by Andrzej Pietrasiewicz and ported into
+//! Rust by Daniel Almeida.
+
+#![allow(missing_docs)]
+#![allow(non_upper_case_globals)]
+#![allow(dead_code)]
+#![allow(unused_variables)]
+
+#[repr(C)]
+#[derive(Debug, Clone)]
+pub struct FrameMvContext {
+    pub joint: [u8; 3],
+    pub sign: [u8; 2],
+    pub classes: [[u8; 10]; 2],
+    pub class0_bit: [u8; 2],
+    pub bits: [[u8; 10]; 2],
+    pub class0_fr: [[[u8; 3]; 2]; 2],
+    pub fr: [[u8; 3]; 2],
+    pub class0_hp: [u8; 2],
+    pub hp: [u8; 2],
+}
+
+#[repr(C)]
+#[derive(Debug, Clone)]
+pub struct FrameContext {
+    pub tx8: [[u8; 1]; 2],
+    pub tx16: [[u8; 2]; 2],
+    pub tx32: [[u8; 3]; 2],
+    pub coef: [[[[[[u8; 3]; 6]; 6]; 2]; 2]; 4],
+    pub skip: [u8; 3],
+    pub inter_mode: [[u8; 3]; 7],
+    pub interp_filter: [[u8; 2]; 4],
+    pub is_inter: [u8; 4],
+    pub comp_mode: [u8; 5],
+    pub single_ref: [[u8; 2]; 5],
+    pub comp_ref: [u8; 5],
+    pub y_mode: [[u8; 9]; 4],
+    pub uv_mode: [[u8; 9]; 10],
+    pub partition: [[u8; 3]; 16],
+    pub mv: FrameMvContext,
+}
+
+#[repr(C)]
+#[derive(Debug)]
+pub struct FrameSymbolCounts<'a> {
+    pub partition: &'a mut [[u32; 4]; 16],
+    pub skip: &'a mut [[u32; 2]; 3],
+    pub intra_inter: &'a mut [[u32; 2]; 4],
+    pub tx32p: &'a mut [[u32; 4]; 2],
+    pub tx16p: &'a mut [[u32; 4]; 2],
+    pub tx8p: &'a mut [[u32; 2]; 2],
+    pub y_mode: &'a mut [[u32; 10]; 4],
+    pub uv_mode: &'a mut [[u32; 10]; 10],
+    pub comp: &'a mut [[u32; 2]; 5],
+    pub comp_ref: &'a mut [[u32; 2]; 5],
+    pub single_ref: &'a mut [[[u32; 2]; 2]; 5],
+    pub mv_mode: &'a mut [[u32; 4]; 7],
+    pub filter: &'a mut [[u32; 3]; 4],
+    pub mv_joint: &'a mut [u32; 4],
+    pub sign: &'a mut [[u32; 2]; 2],
+    pub classes: &'a mut [[u32; 11]; 2],
+    pub class0: &'a mut [[u32; 2]; 2],
+    pub bits: &'a mut [[[u32; 2]; 10]; 2],
+    pub class0_fp: &'a mut [[[u32; 4]; 2]; 2],
+    pub fp: &'a mut [[u32; 4]; 2],
+    pub class0_hp: &'a mut [[u32; 2]; 2],
+    pub hp: &'a mut [[u32; 2]; 2],
+    pub coeff: [[[[[&'a mut [u32; 3]; 6]; 6]; 2]; 2]; 4],
+    pub eob: [[[[[[&'a mut u32; 2]; 6]; 6]; 2]; 2]; 4],
+}
+
+#[no_mangle]
+pub static v4l2_vp9_kf_y_mode_prob_rs: [[[u8; 9]; 10]; 10] = [
+    [
+        /* above = dc */
+        [137, 30, 42, 148, 151, 207, 70, 52, 91], /*left = dc  */
+        [92, 45, 102, 136, 116, 180, 74, 90, 100], /*left = v   */
+        [73, 32, 19, 187, 222, 215, 46, 34, 100], /*left = h   */
+        [91, 30, 32, 116, 121, 186, 93, 86, 94],  /*left = d45 */
+        [72, 35, 36, 149, 68, 206, 68, 63, 105],  /*left = d135*/
+        [73, 31, 28, 138, 57, 124, 55, 122, 151], /*left = d117*/
+        [67, 23, 21, 140, 126, 197, 40, 37, 171], /*left = d153*/
+        [86, 27, 28, 128, 154, 212, 45, 43, 53],  /*left = d207*/
+        [74, 32, 27, 107, 86, 160, 63, 134, 102], /*left = d63 */
+        [59, 67, 44, 140, 161, 202, 78, 67, 119], /*left = tm  */
+    ],
+    [
+        /* above = v */
+        [63, 36, 126, 146, 123, 158, 60, 90, 96], /*left = dc  */
+        [43, 46, 168, 134, 107, 128, 69, 142, 92], /*left = v   */
+        [44, 29, 68, 159, 201, 177, 50, 57, 77],  /*left = h   */
+        [58, 38, 76, 114, 97, 172, 78, 133, 92],  /*left = d45 */
+        [46, 41, 76, 140, 63, 184, 69, 112, 57],  /*left = d135*/
+        [38, 32, 85, 140, 46, 112, 54, 151, 133], /*left = d117*/
+        [39, 27, 61, 131, 110, 175, 44, 75, 136], /*left = d153*/
+        [52, 30, 74, 113, 130, 175, 51, 64, 58],  /*left = d207*/
+        [47, 35, 80, 100, 74, 143, 64, 163, 74],  /*left = d63 */
+        [36, 61, 116, 114, 128, 162, 80, 125, 82], /*left = tm  */
+    ],
+    [
+        /* above = h */
+        [82, 26, 26, 171, 208, 204, 44, 32, 105], /*left = dc  */
+        [55, 44, 68, 166, 179, 192, 57, 57, 108], /*left = v   */
+        [42, 26, 11, 199, 241, 228, 23, 15, 85],  /*left = h   */
+        [68, 42, 19, 131, 160, 199, 55, 52, 83],  /*left = d45 */
+        [58, 50, 25, 139, 115, 232, 39, 52, 118], /*left = d135*/
+        [50, 35, 33, 153, 104, 162, 64, 59, 131], /*left = d117*/
+        [44, 24, 16, 150, 177, 202, 33, 19, 156], /*left = d153*/
+        [55, 27, 12, 153, 203, 218, 26, 27, 49],  /*left = d207*/
+        [53, 49, 21, 110, 116, 168, 59, 80, 76],  /*left = d63 */
+        [38, 72, 19, 168, 203, 212, 50, 50, 107], /*left = tm  */
+    ],
+    [
+        /* above = d45 */
+        [103, 26, 36, 129, 132, 201, 83, 80, 93], /*left = dc  */
+        [59, 38, 83, 112, 103, 162, 98, 136, 90], /*left = v   */
+        [62, 30, 23, 158, 200, 207, 59, 57, 50],  /*left = h   */
+        [67, 30, 29, 84, 86, 191, 102, 91, 59],   /*left = d45 */
+        [60, 32, 33, 112, 71, 220, 64, 89, 104],  /*left = d135*/
+        [53, 26, 34, 130, 56, 149, 84, 120, 103], /*left = d117*/
+        [53, 21, 23, 133, 109, 210, 56, 77, 172], /*left = d153*/
+        [77, 19, 29, 112, 142, 228, 55, 66, 36],  /*left = d207*/
+        [61, 29, 29, 93, 97, 165, 83, 175, 162],  /*left = d63 */
+        [47, 47, 43, 114, 137, 181, 100, 99, 95], /*left = tm  */
+    ],
+    [
+        /* above = d135 */
+        [69, 23, 29, 128, 83, 199, 46, 44, 101], /*left = dc  */
+        [53, 40, 55, 139, 69, 183, 61, 80, 110], /*left = v   */
+        [40, 29, 19, 161, 180, 207, 43, 24, 91], /*left = h   */
+        [60, 34, 19, 105, 61, 198, 53, 64, 89],  /*left = d45 */
+        [52, 31, 22, 158, 40, 209, 58, 62, 89],  /*left = d135*/
+        [44, 31, 29, 147, 46, 158, 56, 102, 198], /*left = d117*/
+        [35, 19, 12, 135, 87, 209, 41, 45, 167], /*left = d153*/
+        [55, 25, 21, 118, 95, 215, 38, 39, 66],  /*left = d207*/
+        [51, 38, 25, 113, 58, 164, 70, 93, 97],  /*left = d63 */
+        [47, 54, 34, 146, 108, 203, 72, 103, 151], /*left = tm  */
+    ],
+    [
+        /* above = d117 */
+        [64, 19, 37, 156, 66, 138, 49, 95, 133], /*left = dc  */
+        [46, 27, 80, 150, 55, 124, 55, 121, 135], /*left = v   */
+        [36, 23, 27, 165, 149, 166, 54, 64, 118], /*left = h   */
+        [53, 21, 36, 131, 63, 163, 60, 109, 81], /*left = d45 */
+        [40, 26, 35, 154, 40, 185, 51, 97, 123], /*left = d135*/
+        [35, 19, 34, 179, 19, 97, 48, 129, 124], /*left = d117*/
+        [36, 20, 26, 136, 62, 164, 33, 77, 154], /*left = d153*/
+        [45, 18, 32, 130, 90, 157, 40, 79, 91],  /*left = d207*/
+        [45, 26, 28, 129, 45, 129, 49, 147, 123], /*left = d63 */
+        [38, 44, 51, 136, 74, 162, 57, 97, 121], /*left = tm  */
+    ],
+    [
+        /* above = d153 */
+        [75, 17, 22, 136, 138, 185, 32, 34, 166], /*left = dc  */
+        [56, 39, 58, 133, 117, 173, 48, 53, 187], /*left = v   */
+        [35, 21, 12, 161, 212, 207, 20, 23, 145], /*left = h   */
+        [56, 29, 19, 117, 109, 181, 55, 68, 112], /*left = d45 */
+        [47, 29, 17, 153, 64, 220, 59, 51, 114],  /*left = d135*/
+        [46, 16, 24, 136, 76, 147, 41, 64, 172],  /*left = d117*/
+        [34, 17, 11, 108, 152, 187, 13, 15, 209], /*left = d153*/
+        [51, 24, 14, 115, 133, 209, 32, 26, 104], /*left = d207*/
+        [55, 30, 18, 122, 79, 179, 44, 88, 116],  /*left = d63 */
+        [37, 49, 25, 129, 168, 164, 41, 54, 148], /*left = tm  */
+    ],
+    [
+        /* above = d207 */
+        [82, 22, 32, 127, 143, 213, 39, 41, 70], /*left = dc  */
+        [62, 44, 61, 123, 105, 189, 48, 57, 64], /*left = v   */
+        [47, 25, 17, 175, 222, 220, 24, 30, 86], /*left = h   */
+        [68, 36, 17, 106, 102, 206, 59, 74, 74], /*left = d45 */
+        [57, 39, 23, 151, 68, 216, 55, 63, 58],  /*left = d135*/
+        [49, 30, 35, 141, 70, 168, 82, 40, 115], /*left = d117*/
+        [51, 25, 15, 136, 129, 202, 38, 35, 139], /*left = d153*/
+        [68, 26, 16, 111, 141, 215, 29, 28, 28], /*left = d207*/
+        [59, 39, 19, 114, 75, 180, 77, 104, 42], /*left = d63 */
+        [40, 61, 26, 126, 152, 206, 61, 59, 93], /*left = tm  */
+    ],
+    [
+        /* above = d63 */
+        [78, 23, 39, 111, 117, 170, 74, 124, 94], /*left = dc  */
+        [48, 34, 86, 101, 92, 146, 78, 179, 134], /*left = v   */
+        [47, 22, 24, 138, 187, 178, 68, 69, 59],  /*left = h   */
+        [56, 25, 33, 105, 112, 187, 95, 177, 129], /*left = d45 */
+        [48, 31, 27, 114, 63, 183, 82, 116, 56],  /*left = d135*/
+        [43, 28, 37, 121, 63, 123, 61, 192, 169], /*left = d117*/
+        [42, 17, 24, 109, 97, 177, 56, 76, 122],  /*left = d153*/
+        [58, 18, 28, 105, 139, 182, 70, 92, 63],  /*left = d207*/
+        [46, 23, 32, 74, 86, 150, 67, 183, 88],   /*left = d63 */
+        [36, 38, 48, 92, 122, 165, 88, 137, 91],  /*left = tm  */
+    ],
+    [
+        /* above = tm */
+        [65, 70, 60, 155, 159, 199, 61, 60, 81], /*left = dc  */
+        [44, 78, 115, 132, 119, 173, 71, 112, 93], /*left = v   */
+        [39, 38, 21, 184, 227, 206, 42, 32, 64], /*left = h   */
+        [58, 47, 36, 124, 137, 193, 80, 82, 78], /*left = d45 */
+        [49, 50, 35, 144, 95, 205, 63, 78, 59],  /*left = d135*/
+        [41, 53, 52, 148, 71, 142, 65, 128, 51], /*left = d117*/
+        [40, 36, 28, 143, 143, 202, 40, 55, 137], /*left = d153*/
+        [52, 34, 29, 129, 183, 227, 42, 35, 43], /*left = d207*/
+        [42, 44, 44, 104, 105, 164, 64, 130, 80], /*left = d63 */
+        [43, 81, 53, 140, 169, 204, 68, 84, 72], /*left = tm  */
+    ],
+];
+
+#[no_mangle]
+pub static v4l2_vp9_kf_partition_probs_rs: [[u8; 3]; 16] = [
+    /* 8x8 -> 4x4 */
+    [158, 97, 94], /* a/l both not split   */
+    [93, 24, 99],  /* a split, l not split */
+    [85, 119, 44], /* l split, a not split */
+    [62, 59, 67],  /* a/l both split       */
+    /* 16x16 -> 8x8 */
+    [149, 53, 53], /* a/l both not split   */
+    [94, 20, 48],  /* a split, l not split */
+    [83, 53, 24],  /* l split, a not split */
+    [52, 18, 18],  /* a/l both split       */
+    /* 32x32 -> 16x16 */
+    [150, 40, 39], /* a/l both not split   */
+    [78, 12, 26],  /* a split, l not split */
+    [67, 33, 11],  /* l split, a not split */
+    [24, 7, 5],    /* a/l both split       */
+    /* 64x64 -> 32x32 */
+    [174, 35, 49], /* a/l both not split   */
+    [68, 11, 27],  /* a split, l not split */
+    [57, 15, 9],   /* l split, a not split */
+    [12, 3, 3],    /* a/l both split       */
+];
+
+#[no_mangle]
+pub static v4l2_vp9_kf_uv_mode_prob_rs: [[u8; 9]; 10] = [
+    [144, 11, 54, 157, 195, 130, 46, 58, 108],  /* y = dc   */
+    [118, 15, 123, 148, 131, 101, 44, 93, 131], /* y = v    */
+    [113, 12, 23, 188, 226, 142, 26, 32, 125],  /* y = h    */
+    [120, 11, 50, 123, 163, 135, 64, 77, 103],  /* y = d45  */
+    [113, 9, 36, 155, 111, 157, 32, 44, 161],   /* y = d135 */
+    [116, 9, 55, 176, 76, 96, 37, 61, 149],     /* y = d117 */
+    [115, 9, 28, 141, 161, 167, 21, 25, 193],   /* y = d153 */
+    [120, 12, 32, 145, 195, 142, 32, 38, 86],   /* y = d207 */
+    [116, 12, 64, 120, 140, 125, 49, 115, 121], /* y = d63  */
+    [102, 19, 66, 162, 182, 122, 35, 59, 128],  /* y = tm   */
+];
+
+#[no_mangle]
+pub static v4l2_vp9_default_probs_rs: FrameContext = FrameContext {
+    tx8: [[100], [66]],
+    tx16: [[20, 152], [15, 101]],
+    tx32: [[3, 136, 37], [5, 52, 13]],
+    coef: [
+        [
+            /* tx  4x4 */
+            [
+                /* block Type 0 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [195, 29, 183],
+                        [84, 49, 136],
+                        [8, 42, 71],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [31, 107, 169],
+                        [35, 99, 159],
+                        [17, 82, 140],
+                        [8, 66, 114],
+                        [2, 44, 76],
+                        [1, 19, 32],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [40, 132, 201],
+                        [29, 114, 187],
+                        [13, 91, 157],
+                        [7, 75, 127],
+                        [3, 58, 95],
+                        [1, 28, 47],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [69, 142, 221],
+                        [42, 122, 201],
+                        [15, 91, 159],
+                        [6, 67, 121],
+                        [1, 42, 77],
+                        [1, 17, 31],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [102, 148, 228],
+                        [67, 117, 204],
+                        [17, 82, 154],
+                        [6, 59, 114],
+                        [2, 39, 75],
+                        [1, 15, 29],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [156, 57, 233],
+                        [119, 57, 212],
+                        [58, 48, 163],
+                        [29, 40, 124],
+                        [12, 30, 81],
+                        [3, 12, 31],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [191, 107, 226],
+                        [124, 117, 204],
+                        [25, 99, 155],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [29, 148, 210],
+                        [37, 126, 194],
+                        [8, 93, 157],
+                        [2, 68, 118],
+                        [1, 39, 69],
+                        [1, 17, 33],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [41, 151, 213],
+                        [27, 123, 193],
+                        [3, 82, 144],
+                        [1, 58, 105],
+                        [1, 32, 60],
+                        [1, 13, 26],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [59, 159, 220],
+                        [23, 126, 198],
+                        [4, 88, 151],
+                        [1, 66, 114],
+                        [1, 38, 71],
+                        [1, 18, 34],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [114, 136, 232],
+                        [51, 114, 207],
+                        [11, 83, 155],
+                        [3, 56, 105],
+                        [1, 33, 65],
+                        [1, 17, 34],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [149, 65, 234],
+                        [121, 57, 215],
+                        [61, 49, 166],
+                        [28, 36, 114],
+                        [12, 25, 76],
+                        [3, 16, 42],
+                    ],
+                ],
+            ],
+            [
+                /* block Type 1 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [214, 49, 220],
+                        [132, 63, 188],
+                        [42, 65, 137],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [85, 137, 221],
+                        [104, 131, 216],
+                        [49, 111, 192],
+                        [21, 87, 155],
+                        [2, 49, 87],
+                        [1, 16, 28],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [89, 163, 230],
+                        [90, 137, 220],
+                        [29, 100, 183],
+                        [10, 70, 135],
+                        [2, 42, 81],
+                        [1, 17, 33],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [108, 167, 237],
+                        [55, 133, 222],
+                        [15, 97, 179],
+                        [4, 72, 135],
+                        [1, 45, 85],
+                        [1, 19, 38],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [124, 146, 240],
+                        [66, 124, 224],
+                        [17, 88, 175],
+                        [4, 58, 122],
+                        [1, 36, 75],
+                        [1, 18, 37],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [141, 79, 241],
+                        [126, 70, 227],
+                        [66, 58, 182],
+                        [30, 44, 136],
+                        [12, 34, 96],
+                        [2, 20, 47],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [229, 99, 249],
+                        [143, 111, 235],
+                        [46, 109, 192],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [82, 158, 236],
+                        [94, 146, 224],
+                        [25, 117, 191],
+                        [9, 87, 149],
+                        [3, 56, 99],
+                        [1, 33, 57],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [83, 167, 237],
+                        [68, 145, 222],
+                        [10, 103, 177],
+                        [2, 72, 131],
+                        [1, 41, 79],
+                        [1, 20, 39],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [99, 167, 239],
+                        [47, 141, 224],
+                        [10, 104, 178],
+                        [2, 73, 133],
+                        [1, 44, 85],
+                        [1, 22, 47],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [127, 145, 243],
+                        [71, 129, 228],
+                        [17, 93, 177],
+                        [3, 61, 124],
+                        [1, 41, 84],
+                        [1, 21, 52],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [157, 78, 244],
+                        [140, 72, 231],
+                        [69, 58, 184],
+                        [31, 44, 137],
+                        [14, 38, 105],
+                        [8, 23, 61],
+                    ],
+                ],
+            ],
+        ],
+        [
+            /* tx  8x8 */
+            [
+                /* block Type 0 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [125, 34, 187],
+                        [52, 41, 133],
+                        [6, 31, 56],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [37, 109, 153],
+                        [51, 102, 147],
+                        [23, 87, 128],
+                        [8, 67, 101],
+                        [1, 41, 63],
+                        [1, 19, 29],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [31, 154, 185],
+                        [17, 127, 175],
+                        [6, 96, 145],
+                        [2, 73, 114],
+                        [1, 51, 82],
+                        [1, 28, 45],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [23, 163, 200],
+                        [10, 131, 185],
+                        [2, 93, 148],
+                        [1, 67, 111],
+                        [1, 41, 69],
+                        [1, 14, 24],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [29, 176, 217],
+                        [12, 145, 201],
+                        [3, 101, 156],
+                        [1, 69, 111],
+                        [1, 39, 63],
+                        [1, 14, 23],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [57, 192, 233],
+                        [25, 154, 215],
+                        [6, 109, 167],
+                        [3, 78, 118],
+                        [1, 48, 69],
+                        [1, 21, 29],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [202, 105, 245],
+                        [108, 106, 216],
+                        [18, 90, 144],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [33, 172, 219],
+                        [64, 149, 206],
+                        [14, 117, 177],
+                        [5, 90, 141],
+                        [2, 61, 95],
+                        [1, 37, 57],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [33, 179, 220],
+                        [11, 140, 198],
+                        [1, 89, 148],
+                        [1, 60, 104],
+                        [1, 33, 57],
+                        [1, 12, 21],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [30, 181, 221],
+                        [8, 141, 198],
+                        [1, 87, 145],
+                        [1, 58, 100],
+                        [1, 31, 55],
+                        [1, 12, 20],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [32, 186, 224],
+                        [7, 142, 198],
+                        [1, 86, 143],
+                        [1, 58, 100],
+                        [1, 31, 55],
+                        [1, 12, 22],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [57, 192, 227],
+                        [20, 143, 204],
+                        [3, 96, 154],
+                        [1, 68, 112],
+                        [1, 42, 69],
+                        [1, 19, 32],
+                    ],
+                ],
+            ],
+            [
+                /* block Type 1 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [212, 35, 215],
+                        [113, 47, 169],
+                        [29, 48, 105],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [74, 129, 203],
+                        [106, 120, 203],
+                        [49, 107, 178],
+                        [19, 84, 144],
+                        [4, 50, 84],
+                        [1, 15, 25],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [71, 172, 217],
+                        [44, 141, 209],
+                        [15, 102, 173],
+                        [6, 76, 133],
+                        [2, 51, 89],
+                        [1, 24, 42],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [64, 185, 231],
+                        [31, 148, 216],
+                        [8, 103, 175],
+                        [3, 74, 131],
+                        [1, 46, 81],
+                        [1, 18, 30],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [65, 196, 235],
+                        [25, 157, 221],
+                        [5, 105, 174],
+                        [1, 67, 120],
+                        [1, 38, 69],
+                        [1, 15, 30],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [65, 204, 238],
+                        [30, 156, 224],
+                        [7, 107, 177],
+                        [2, 70, 124],
+                        [1, 42, 73],
+                        [1, 18, 34],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [225, 86, 251],
+                        [144, 104, 235],
+                        [42, 99, 181],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [85, 175, 239],
+                        [112, 165, 229],
+                        [29, 136, 200],
+                        [12, 103, 162],
+                        [6, 77, 123],
+                        [2, 53, 84],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [75, 183, 239],
+                        [30, 155, 221],
+                        [3, 106, 171],
+                        [1, 74, 128],
+                        [1, 44, 76],
+                        [1, 17, 28],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [73, 185, 240],
+                        [27, 159, 222],
+                        [2, 107, 172],
+                        [1, 75, 127],
+                        [1, 42, 73],
+                        [1, 17, 29],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [62, 190, 238],
+                        [21, 159, 222],
+                        [2, 107, 172],
+                        [1, 72, 122],
+                        [1, 40, 71],
+                        [1, 18, 32],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [61, 199, 240],
+                        [27, 161, 226],
+                        [4, 113, 180],
+                        [1, 76, 129],
+                        [1, 46, 80],
+                        [1, 23, 41],
+                    ],
+                ],
+            ],
+        ],
+        [
+            /* tx  16x16 */
+            [
+                /* block Type 0 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [7, 27, 153],
+                        [5, 30, 95],
+                        [1, 16, 30],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [50, 75, 127],
+                        [57, 75, 124],
+                        [27, 67, 108],
+                        [10, 54, 86],
+                        [1, 33, 52],
+                        [1, 12, 18],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [43, 125, 151],
+                        [26, 108, 148],
+                        [7, 83, 122],
+                        [2, 59, 89],
+                        [1, 38, 60],
+                        [1, 17, 27],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [23, 144, 163],
+                        [13, 112, 154],
+                        [2, 75, 117],
+                        [1, 50, 81],
+                        [1, 31, 51],
+                        [1, 14, 23],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [18, 162, 185],
+                        [6, 123, 171],
+                        [1, 78, 125],
+                        [1, 51, 86],
+                        [1, 31, 54],
+                        [1, 14, 23],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [15, 199, 227],
+                        [3, 150, 204],
+                        [1, 91, 146],
+                        [1, 55, 95],
+                        [1, 30, 53],
+                        [1, 11, 20],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [19, 55, 240],
+                        [19, 59, 196],
+                        [3, 52, 105],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [41, 166, 207],
+                        [104, 153, 199],
+                        [31, 123, 181],
+                        [14, 101, 152],
+                        [5, 72, 106],
+                        [1, 36, 52],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [35, 176, 211],
+                        [12, 131, 190],
+                        [2, 88, 144],
+                        [1, 60, 101],
+                        [1, 36, 60],
+                        [1, 16, 28],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [28, 183, 213],
+                        [8, 134, 191],
+                        [1, 86, 142],
+                        [1, 56, 96],
+                        [1, 30, 53],
+                        [1, 12, 20],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [20, 190, 215],
+                        [4, 135, 192],
+                        [1, 84, 139],
+                        [1, 53, 91],
+                        [1, 28, 49],
+                        [1, 11, 20],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [13, 196, 216],
+                        [2, 137, 192],
+                        [1, 86, 143],
+                        [1, 57, 99],
+                        [1, 32, 56],
+                        [1, 13, 24],
+                    ],
+                ],
+            ],
+            [
+                /* block Type 1 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [211, 29, 217],
+                        [96, 47, 156],
+                        [22, 43, 87],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [78, 120, 193],
+                        [111, 116, 186],
+                        [46, 102, 164],
+                        [15, 80, 128],
+                        [2, 49, 76],
+                        [1, 18, 28],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [71, 161, 203],
+                        [42, 132, 192],
+                        [10, 98, 150],
+                        [3, 69, 109],
+                        [1, 44, 70],
+                        [1, 18, 29],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [57, 186, 211],
+                        [30, 140, 196],
+                        [4, 93, 146],
+                        [1, 62, 102],
+                        [1, 38, 65],
+                        [1, 16, 27],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [47, 199, 217],
+                        [14, 145, 196],
+                        [1, 88, 142],
+                        [1, 57, 98],
+                        [1, 36, 62],
+                        [1, 15, 26],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [26, 219, 229],
+                        [5, 155, 207],
+                        [1, 94, 151],
+                        [1, 60, 104],
+                        [1, 36, 62],
+                        [1, 16, 28],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [233, 29, 248],
+                        [146, 47, 220],
+                        [43, 52, 140],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [100, 163, 232],
+                        [179, 161, 222],
+                        [63, 142, 204],
+                        [37, 113, 174],
+                        [26, 89, 137],
+                        [18, 68, 97],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [85, 181, 230],
+                        [32, 146, 209],
+                        [7, 100, 164],
+                        [3, 71, 121],
+                        [1, 45, 77],
+                        [1, 18, 30],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [65, 187, 230],
+                        [20, 148, 207],
+                        [2, 97, 159],
+                        [1, 68, 116],
+                        [1, 40, 70],
+                        [1, 14, 29],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [40, 194, 227],
+                        [8, 147, 204],
+                        [1, 94, 155],
+                        [1, 65, 112],
+                        [1, 39, 66],
+                        [1, 14, 26],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [16, 208, 228],
+                        [3, 151, 207],
+                        [1, 98, 160],
+                        [1, 67, 117],
+                        [1, 41, 74],
+                        [1, 17, 31],
+                    ],
+                ],
+            ],
+        ],
+        [
+            /* tx  32x32 */
+            [
+                /* block Type 0 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [17, 38, 140],
+                        [7, 34, 80],
+                        [1, 17, 29],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [37, 75, 128],
+                        [41, 76, 128],
+                        [26, 66, 116],
+                        [12, 52, 94],
+                        [2, 32, 55],
+                        [1, 10, 16],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [50, 127, 154],
+                        [37, 109, 152],
+                        [16, 82, 121],
+                        [5, 59, 85],
+                        [1, 35, 54],
+                        [1, 13, 20],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [40, 142, 167],
+                        [17, 110, 157],
+                        [2, 71, 112],
+                        [1, 44, 72],
+                        [1, 27, 45],
+                        [1, 11, 17],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [30, 175, 188],
+                        [9, 124, 169],
+                        [1, 74, 116],
+                        [1, 48, 78],
+                        [1, 30, 49],
+                        [1, 11, 18],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [10, 222, 223],
+                        [2, 150, 194],
+                        [1, 83, 128],
+                        [1, 48, 79],
+                        [1, 27, 45],
+                        [1, 11, 17],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [36, 41, 235],
+                        [29, 36, 193],
+                        [10, 27, 111],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [85, 165, 222],
+                        [177, 162, 215],
+                        [110, 135, 195],
+                        [57, 113, 168],
+                        [23, 83, 120],
+                        [10, 49, 61],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [85, 190, 223],
+                        [36, 139, 200],
+                        [5, 90, 146],
+                        [1, 60, 103],
+                        [1, 38, 65],
+                        [1, 18, 30],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [72, 202, 223],
+                        [23, 141, 199],
+                        [2, 86, 140],
+                        [1, 56, 97],
+                        [1, 36, 61],
+                        [1, 16, 27],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [55, 218, 225],
+                        [13, 145, 200],
+                        [1, 86, 141],
+                        [1, 57, 99],
+                        [1, 35, 61],
+                        [1, 13, 22],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [15, 235, 212],
+                        [1, 132, 184],
+                        [1, 84, 139],
+                        [1, 57, 97],
+                        [1, 34, 56],
+                        [1, 14, 23],
+                    ],
+                ],
+            ],
+            [
+                /* block Type 1 */
+                [
+                    /* Intra */
+                    [
+                        /* Coeff Band 0 */
+                        [181, 21, 201],
+                        [61, 37, 123],
+                        [10, 38, 71],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [47, 106, 172],
+                        [95, 104, 173],
+                        [42, 93, 159],
+                        [18, 77, 131],
+                        [4, 50, 81],
+                        [1, 17, 23],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [62, 147, 199],
+                        [44, 130, 189],
+                        [28, 102, 154],
+                        [18, 75, 115],
+                        [2, 44, 65],
+                        [1, 12, 19],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [55, 153, 210],
+                        [24, 130, 194],
+                        [3, 93, 146],
+                        [1, 61, 97],
+                        [1, 31, 50],
+                        [1, 10, 16],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [49, 186, 223],
+                        [17, 148, 204],
+                        [1, 96, 142],
+                        [1, 53, 83],
+                        [1, 26, 44],
+                        [1, 11, 17],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [13, 217, 212],
+                        [2, 136, 180],
+                        [1, 78, 124],
+                        [1, 50, 83],
+                        [1, 29, 49],
+                        [1, 14, 23],
+                    ],
+                ],
+                [
+                    /* Inter */
+                    [
+                        /* Coeff Band 0 */
+                        [197, 13, 247],
+                        [82, 17, 222],
+                        [25, 17, 162],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                        [0, 0, 0],
+                    ],
+                    [
+                        /* Coeff Band 1 */
+                        [126, 186, 247],
+                        [234, 191, 243],
+                        [176, 177, 234],
+                        [104, 158, 220],
+                        [66, 128, 186],
+                        [55, 90, 137],
+                    ],
+                    [
+                        /* Coeff Band 2 */
+                        [111, 197, 242],
+                        [46, 158, 219],
+                        [9, 104, 171],
+                        [2, 65, 125],
+                        [1, 44, 80],
+                        [1, 17, 91],
+                    ],
+                    [
+                        /* Coeff Band 3 */
+                        [104, 208, 245],
+                        [39, 168, 224],
+                        [3, 109, 162],
+                        [1, 79, 124],
+                        [1, 50, 102],
+                        [1, 43, 102],
+                    ],
+                    [
+                        /* Coeff Band 4 */
+                        [84, 220, 246],
+                        [31, 177, 231],
+                        [2, 115, 180],
+                        [1, 79, 134],
+                        [1, 55, 77],
+                        [1, 60, 79],
+                    ],
+                    [
+                        /* Coeff Band 5 */
+                        [43, 243, 240],
+                        [8, 180, 217],
+                        [1, 115, 166],
+                        [1, 84, 121],
+                        [1, 51, 67],
+                        [1, 16, 6],
+                    ],
+                ],
+            ],
+        ],
+    ],
+
+    skip: [192, 128, 64],
+    inter_mode: [
+        [2, 173, 34],
+        [7, 145, 85],
+        [7, 166, 63],
+        [7, 94, 66],
+        [8, 64, 46],
+        [17, 81, 31],
+        [25, 29, 30],
+    ],
+    interp_filter: [[235, 162], [36, 255], [34, 3], [149, 144]],
+    is_inter: [9, 102, 187, 225],
+    comp_mode: [239, 183, 119, 96, 41],
+    single_ref: [[33, 16], [77, 74], [142, 142], [172, 170], [238, 247]],
+    comp_ref: [50, 126, 123, 221, 226],
+    y_mode: [
+        [65, 32, 18, 144, 162, 194, 41, 51, 98],
+        [132, 68, 18, 165, 217, 196, 45, 40, 78],
+        [173, 80, 19, 176, 240, 193, 64, 35, 46],
+        [221, 135, 38, 194, 248, 121, 96, 85, 29],
+    ],
+    uv_mode: [
+        [120, 7, 76, 176, 208, 126, 28, 54, 103],   /* y  dc */
+        [48, 12, 154, 155, 139, 90, 34, 117, 119],  /* y  v */
+        [67, 6, 25, 204, 243, 158, 13, 21, 96],     /* y  h */
+        [97, 5, 44, 131, 176, 139, 48, 68, 97],     /* y  d45 */
+        [83, 5, 42, 156, 111, 152, 26, 49, 152],    /* y  d135 */
+        [80, 5, 58, 178, 74, 83, 33, 62, 145],      /* y  d117 */
+        [86, 5, 32, 154, 192, 168, 14, 22, 163],    /* y  d153 */
+        [85, 5, 32, 156, 216, 148, 19, 29, 73],     /* y  d207 */
+        [77, 7, 64, 116, 132, 122, 37, 126, 120],   /* y  d63 */
+        [101, 21, 107, 181, 192, 103, 19, 67, 125], /* y  tm */
+    ],
+    partition: [
+        /* 8x8 -> 4x4 */
+        [199, 122, 141], /* a/l both not split */
+        [147, 63, 159],  /* a split, l not split */
+        [148, 133, 118], /* l split, a not split */
+        [121, 104, 114], /* a/l both split */
+        /* 16x16 -> 8x8 */
+        [174, 73, 87], /* a/l both not split */
+        [92, 41, 83],  /* a split, l not split */
+        [82, 99, 50],  /* l split, a not split */
+        [53, 39, 39],  /* a/l both split */
+        /* 32x32 -> 16x16 */
+        [177, 58, 59], /* a/l both not split */
+        [68, 26, 63],  /* a split, l not split */
+        [52, 79, 25],  /* l split, a not split */
+        [17, 14, 12],  /* a/l both split */
+        /* 64x64 -> 32x32 */
+        [222, 34, 30], /* a/l both not split */
+        [72, 16, 44],  /* a split, l not split */
+        [58, 32, 12],  /* l split, a not split */
+        [10, 7, 6],    /* a/l both split */
+    ],
+    mv: FrameMvContext {
+        joint: [32, 64, 96],
+        sign: [128, 128],
+        classes: [
+            [224, 144, 192, 168, 192, 176, 192, 198, 198, 245],
+            [216, 128, 176, 160, 176, 176, 192, 198, 198, 208],
+        ],
+        class0_bit: [216, 208],
+        bits: [
+            [136, 140, 148, 160, 176, 192, 224, 234, 234, 240],
+            [136, 140, 148, 160, 176, 192, 224, 234, 234, 240],
+        ],
+        class0_fr: [
+            [[128, 128, 64], [96, 112, 64]],
+            [[128, 128, 64], [96, 112, 64]],
+        ],
+        fr: [[64, 96, 64], [64, 96, 64]],
+        class0_hp: [160, 160],
+        hp: [128, 128],
+    },
+};
+
+pub fn fw_update_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+    dec_params: &bindings::v4l2_ctrl_vp9_frame,
+) {
+    if u32::from(deltas.tx_mode) == bindings::V4L2_VP9_TX_MODE_SELECT {
+        update_tx_probs(probs, deltas);
+    }
+
+    update_coeff_probs(probs, deltas, dec_params);
+    update_skip_probs(probs, deltas);
+
+    if dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_KEY_FRAME != 0
+        || dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_INTRA_ONLY != 0
+    {
+        return;
+    }
+
+    update_inter_mode_probs(probs, deltas);
+
+    if u32::from(dec_params.interpolation_filter) == bindings::V4L2_VP9_INTERP_FILTER_SWITCHABLE {
+        update_interp_filter_probs(probs, deltas);
+    }
+
+    update_is_inter_probs(probs, deltas);
+    update_frame_reference_mode_probs(dec_params.reference_mode.into(), probs, deltas);
+
+    update_y_mode_probs(probs, deltas);
+    update_partition_probs(probs, deltas);
+    update_mv_probs(probs, deltas, dec_params);
+}
+
+pub fn reset_frame_ctx(
+    dec_params: &bindings::v4l2_ctrl_vp9_frame,
+    frame_context: &mut [FrameContext; 4],
+) -> u8 {
+    let mut fctx_idx = dec_params.frame_context_idx;
+
+    if dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_KEY_FRAME != 0
+        || dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_INTRA_ONLY != 0
+        || dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT != 0
+    {
+        /*
+         * setup_past_independence()
+         * We do nothing here. Instead of storing default probs in some intermediate
+         * location and then copying from that location to appropriate contexts
+         * in save_probs() below, we skip that step and save default probs directly
+         * to appropriate contexts.
+         */
+
+        if dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_KEY_FRAME != 0
+            || dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT != 0
+            || u32::from(dec_params.reset_frame_context) == bindings::V4L2_VP9_RESET_FRAME_CTX_ALL
+        {
+            for i in 0..4 {
+                /* save_probs(i) */
+                frame_context[i] = v4l2_vp9_default_probs_rs.clone();
+            }
+        } else if u32::from(dec_params.reset_frame_context)
+            == bindings::V4L2_VP9_RESET_FRAME_CTX_SPEC
+        {
+            /* save_probs(fctx_idx) */
+            frame_context[usize::from(fctx_idx)] = v4l2_vp9_default_probs_rs.clone();
+        }
+
+        fctx_idx = 0;
+    }
+
+    fctx_idx
+}
+
+pub fn adapt_coef_probs(
+    probs: &mut FrameContext,
+    counts: &mut FrameSymbolCounts<'_>,
+    use_128: bool,
+    frame_is_intra: bool,
+) {
+    if frame_is_intra {
+        _adapt_coef_probs(probs, counts, 112);
+    } else {
+        if use_128 {
+            _adapt_coef_probs(probs, counts, 128);
+        } else {
+            _adapt_coef_probs(probs, counts, 112);
+        }
+    }
+}
+
+pub fn adapt_noncoef_probs(
+    probs: &mut FrameContext,
+    counts: &mut FrameSymbolCounts<'_>,
+    reference_mode: u8,
+    interpolation_filter: u8,
+    tx_mode: u8,
+    flags: u32,
+) {
+    for i in 0..probs.is_inter.len() {
+        probs.is_inter[i] = adapt_prob(probs.is_inter[i], counts.intra_inter[i]);
+    }
+
+    for i in 0..probs.comp_mode.len() {
+        probs.comp_mode[i] = adapt_prob(probs.comp_mode[i], counts.comp[i]);
+    }
+
+    for i in 0..probs.comp_ref.len() {
+        probs.comp_ref[i] = adapt_prob(probs.comp_ref[i], counts.comp_ref[i]);
+    }
+
+    if u32::from(reference_mode) != bindings::V4L2_VP9_REFERENCE_MODE_COMPOUND_REFERENCE {
+        for i in 0..probs.single_ref.len() {
+            for j in 0..probs.single_ref[0].len() {
+                probs.single_ref[i][j] =
+                    adapt_prob(probs.single_ref[i][j], counts.single_ref[i][j]);
+            }
+        }
+    }
+
+    for i in 0..probs.inter_mode.len() {
+        adapt_probs_variant_c(&mut probs.inter_mode[i], &counts.mv_mode[i]);
+    }
+
+    for i in 0..probs.y_mode.len() {
+        adapt_probs_variant_d(&mut probs.y_mode[i], &counts.y_mode[i]);
+    }
+
+    for i in 0..probs.uv_mode.len() {
+        adapt_probs_variant_d(&mut probs.uv_mode[i], &counts.uv_mode[i]);
+    }
+
+    for i in 0..probs.partition.len() {
+        adapt_probs_variant_e(&mut probs.partition[i], &counts.partition[i]);
+    }
+
+    for i in 0..probs.skip.len() {
+        probs.skip[i] = adapt_prob(probs.skip[i], counts.skip[i]);
+    }
+
+    if u32::from(interpolation_filter) == bindings::V4L2_VP9_INTERP_FILTER_SWITCHABLE {
+        for i in 0..probs.interp_filter.len() {
+            adapt_probs_variant_f(&mut probs.interp_filter[i], &counts.filter[i]);
+        }
+    }
+
+    if u32::from(tx_mode) == bindings::V4L2_VP9_TX_MODE_SELECT {
+        for i in 0..probs.tx8.len() {
+            adapt_probs_variant_b(&mut probs.tx8[i], &counts.tx8p[i]);
+            adapt_probs_variant_f(&mut probs.tx16[i], &counts.tx16p[i]);
+            adapt_probs_variant_e(&mut probs.tx32[i], &counts.tx32p[i]);
+        }
+    }
+
+    adapt_probs_variant_e(&mut probs.mv.joint, counts.mv_joint);
+
+    for i in 0..probs.mv.sign.len() {
+        probs.mv.sign[i] = adapt_prob(probs.mv.sign[i], counts.sign[i]);
+
+        adapt_probs_variant_g(&mut probs.mv.classes[i], &counts.classes[i]);
+
+        probs.mv.class0_bit[i] = adapt_prob(probs.mv.class0_bit[i], counts.class0[i]);
+
+        for j in 0..probs.mv.bits[0].len() {
+            probs.mv.bits[i][j] = adapt_prob(probs.mv.bits[i][j], counts.bits[i][j]);
+        }
+
+        for j in 0..probs.mv.class0_fr[0].len() {
+            adapt_probs_variant_e(&mut probs.mv.class0_fr[i][j], &counts.class0_fp[i][j]);
+        }
+
+        adapt_probs_variant_e(&mut probs.mv.fr[i], &counts.fp[i]);
+
+        if flags & bindings::V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV == 0 {
+            continue;
+        }
+
+        probs.mv.class0_hp[i] = adapt_prob(probs.mv.class0_hp[i], counts.class0_hp[i]);
+
+        probs.mv.hp[i] = adapt_prob(probs.mv.hp[i], counts.hp[i]);
+    }
+}
+
+pub fn seg_feat_enabled(feature_enabled: &[u8; 8], feature: u32, segid: u32) -> bool {
+    let mask = 1 << feature;
+    feature_enabled[segid as usize] & mask != 0
+}
+
+fn fastdiv(dividend: u32, divisor: u32) -> u32 {
+    const fn inv<const SZ: usize>() -> [u32; SZ] {
+        let mut ret = [0; SZ];
+        let mut i = 2;
+        let n = SZ + 1;
+
+        while i <= n {
+            ret[i - 2] = (((1u64 << 32) + (i as u64 - 1)) / i as u64) as u32;
+            i += 1;
+        }
+
+        ret
+    }
+    const SZ: usize = 255;
+    const INV: [u32; SZ] = inv::<SZ>();
+    if divisor - 2 >= SZ as u32 {
+        crate::pr_warn!("fastdiv: divisor {} too large", divisor);
+        return dividend;
+    }
+
+    if divisor == 0 {
+        0
+    } else if divisor == 1 {
+        dividend
+    } else {
+        let ret = (u64::from(dividend) * u64::from(INV[divisor as usize - 2])) >> 32;
+        ret as u32
+    }
+}
+
+fn inv_recenter_nonneg(v: i32, m: i32) -> i32 {
+    if v > 2 * m {
+        v
+    } else if (v & 1) != 0 {
+        m - ((v + 1) >> 1)
+    } else {
+        m + (v >> 1)
+    }
+}
+
+fn update_prob(delta: i32, prob: i32) -> i32 {
+    if delta == 0 {
+        prob
+    } else if prob <= 128 {
+        1 + inv_recenter_nonneg(delta, prob - 1)
+    } else {
+        255 - inv_recenter_nonneg(delta, 255 - prob)
+    }
+}
+
+fn update_tx_probs(probs: &mut FrameContext, deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr) {
+    for i in 0..probs.tx8.len() {
+        let p8x8 = &mut probs.tx8[i];
+        let p16x16 = &mut probs.tx16[i];
+        let p32x32 = &mut probs.tx32[i];
+
+        let d8x8 = &deltas.tx8[i];
+        let d16x16 = &deltas.tx16[i];
+        let d32x32 = &deltas.tx32[i];
+
+        p8x8[0] = update_prob(d8x8[0].into(), p8x8[0].into()) as u8;
+        p16x16[0] = update_prob(d16x16[0].into(), p16x16[0].into()) as u8;
+        p16x16[1] = update_prob(d16x16[1].into(), p16x16[1].into()) as u8;
+        p32x32[0] = update_prob(d32x32[0].into(), p32x32[0].into()) as u8;
+        p32x32[1] = update_prob(d32x32[1].into(), p32x32[1].into()) as u8;
+        p32x32[2] = update_prob(d32x32[2].into(), p32x32[2].into()) as u8;
+    }
+}
+
+macro_rules! BAND_6 {
+    ($band:expr) => {
+        if $band == 0 {
+            3
+        } else {
+            6
+        }
+    };
+}
+
+fn update_coeff(deltas: &[[[u8; 3]; 6]; 6], probs: &mut [[[u8; 3]; 6]; 6]) {
+    for l in 0..6 {
+        for m in 0..BAND_6!(l) {
+            let p = &mut probs[l][m];
+            let d = &deltas[l][m];
+
+            for n in 0..3 {
+                p[n] = update_prob(d[n].into(), p[n].into()) as u8;
+            }
+        }
+    }
+}
+
+fn update_coeff_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+    dec_params: &bindings::v4l2_ctrl_vp9_frame,
+) {
+    for i in 0..probs.coef.len() {
+        for j in 0..probs.coef[0].len() {
+            for k in 0..probs.coef[0][0].len() {
+                update_coeff(&deltas.coef[i][j][k], &mut probs.coef[i][j][k]);
+            }
+        }
+
+        if usize::from(deltas.tx_mode) == i {
+            break;
+        }
+    }
+}
+
+fn update_skip_probs(probs: &mut FrameContext, deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr) {
+    for i in 0..probs.skip.len() {
+        probs.skip[i] = update_prob(deltas.skip[i].into(), probs.skip[i].into()) as u8;
+    }
+}
+
+fn update_inter_mode_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+) {
+    for i in 0..probs.inter_mode.len() {
+        let p = &mut probs.inter_mode[i];
+        let d = &deltas.inter_mode[i];
+
+        p[0] = update_prob(d[0].into(), p[0].into()) as u8;
+        p[1] = update_prob(d[1].into(), p[1].into()) as u8;
+        p[2] = update_prob(d[2].into(), p[2].into()) as u8;
+    }
+}
+
+fn update_interp_filter_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+) {
+    for i in 0..probs.interp_filter.len() {
+        let p = &mut probs.interp_filter[i];
+        let d = &deltas.interp_filter[i];
+
+        p[0] = update_prob(d[0].into(), p[0].into()) as u8;
+        p[1] = update_prob(d[1].into(), p[1].into()) as u8;
+    }
+}
+
+fn update_is_inter_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+) {
+    for i in 0..probs.is_inter.len() {
+        probs.is_inter[i] = update_prob(deltas.is_inter[i].into(), probs.is_inter[i].into()) as u8;
+    }
+}
+
+fn update_frame_reference_mode_probs(
+    reference_mode: u32,
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+) {
+    if reference_mode == bindings::V4L2_VP9_REFERENCE_MODE_SELECT {
+        for i in 0..probs.comp_mode.len() {
+            probs.comp_mode[i] =
+                update_prob(deltas.comp_mode[i].into(), probs.comp_mode[i].into()) as u8;
+        }
+    }
+
+    if reference_mode != bindings::V4L2_VP9_REFERENCE_MODE_COMPOUND_REFERENCE {
+        for i in 0..probs.single_ref.len() {
+            let p = &mut probs.single_ref[i];
+            let d = &deltas.single_ref[i];
+
+            p[0] = update_prob(d[0].into(), p[0].into()) as u8;
+            p[1] = update_prob(d[1].into(), p[1].into()) as u8;
+        }
+    }
+
+    if reference_mode != bindings::V4L2_VP9_REFERENCE_MODE_SINGLE_REFERENCE {
+        for i in 0..probs.comp_ref.len() {
+            probs.comp_ref[i] =
+                update_prob(deltas.comp_ref[i].into(), probs.comp_ref[i].into()) as u8;
+        }
+    }
+}
+
+fn update_y_mode_probs(probs: &mut FrameContext, deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr) {
+    for i in 0..probs.y_mode.len() {
+        for j in 0..probs.y_mode[0].len() {
+            probs.y_mode[i][j] =
+                update_prob(deltas.y_mode[i][j].into(), probs.y_mode[i][j].into()) as u8;
+        }
+    }
+}
+
+fn update_partition_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+) {
+    for i in 0..4 {
+        for j in 0..4 {
+            let p = &mut probs.partition[i * 4 + j];
+            let d = deltas.partition[i * 4 + j];
+
+            p[0] = update_prob(d[0].into(), p[0].into()) as u8;
+            p[1] = update_prob(d[1].into(), p[1].into()) as u8;
+            p[2] = update_prob(d[2].into(), p[2].into()) as u8;
+        }
+    }
+}
+
+fn update_mv_prob(delta: i32, prob: i32) -> i32 {
+    if delta == 0 {
+        prob
+    } else {
+        delta
+    }
+}
+
+fn update_mv_probs(
+    probs: &mut FrameContext,
+    deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+    dec_params: &bindings::v4l2_ctrl_vp9_frame,
+) {
+    let p = &mut probs.mv.joint;
+    let d = &deltas.mv.joint;
+
+    p[0] = update_mv_prob(d[0].into(), p[0].into()) as u8;
+    p[1] = update_mv_prob(d[1].into(), p[1].into()) as u8;
+    p[2] = update_mv_prob(d[2].into(), p[2].into()) as u8;
+
+    for i in 0..probs.mv.sign.len() {
+        let p = &mut probs.mv.sign;
+        let d = &deltas.mv.sign;
+        p[i] = update_mv_prob(d[i].into(), p[i].into()) as u8;
+
+        let len = probs.mv.classes[0].len();
+        let p = &mut probs.mv.classes[i];
+        let d = &deltas.mv.classes[i];
+        for j in 0..len {
+            p[j] = update_mv_prob(d[j].into(), p[j].into()) as u8;
+        }
+
+        let p = &mut probs.mv.class0_bit;
+        let d = &deltas.mv.class0_bit;
+        p[i] = update_mv_prob(d[i].into(), p[i].into()) as u8;
+
+        let len = probs.mv.bits[0].len();
+        let p = &mut probs.mv.bits[i];
+        let d = &deltas.mv.bits[i];
+        for j in 0..len {
+            p[j] = update_mv_prob(d[j].into(), p[j].into()) as u8;
+        }
+
+        let len = probs.mv.class0_fr[0].len();
+        for j in 0..len {
+            let p = &mut probs.mv.class0_fr[i][j];
+            let d = &deltas.mv.class0_fr[i][j];
+
+            p[0] = update_mv_prob(d[0].into(), p[0].into()) as u8;
+            p[1] = update_mv_prob(d[1].into(), p[1].into()) as u8;
+            p[2] = update_mv_prob(d[2].into(), p[2].into()) as u8;
+        }
+
+        let len = probs.mv.fr[i].len();
+        let p = &mut probs.mv.fr[i];
+        let d = &deltas.mv.fr[i];
+        for j in 0..len {
+            p[j] = update_mv_prob(d[j].into(), p[j].into()) as u8;
+        }
+
+        if (dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV) != 0 {
+            let p = &mut probs.mv.class0_hp;
+            let d = &deltas.mv.class0_hp;
+            p[i] = update_mv_prob(d[i].into(), p[i].into()) as u8;
+
+            let p = &mut probs.mv.hp;
+            let d = &deltas.mv.hp;
+            p[i] = update_mv_prob(d[i].into(), p[i].into()) as u8;
+        }
+    }
+}
+
+macro_rules! clamp {
+    ($val:expr, $min:expr, $max:expr) => {
+        if $val < $min {
+            $min
+        } else if $val > $max {
+            $max
+        } else {
+            $val
+        }
+    };
+}
+
+fn merge_prob(pre_prob: u8, ct0: u32, ct1: u32, count_sat: u32, max_update_factor: u32) -> u8 {
+    let den = ct0 + ct1;
+
+    if den == 0 {
+        /*
+         * prob = 128, count = 0, update_factor = 0
+         * Round2's argument: pre_prob * 256
+         * (pre_prob * 256 + 128) >> 8 == pre_prob
+         */
+        return pre_prob;
+    }
+
+    let prob = clamp!(((ct0 << 8) + (den >> 1)) / den, 1, 255);
+    let count = core::cmp::min(den, count_sat);
+    let factor = fastdiv(max_update_factor * count, count_sat);
+
+    let prob = i64::from(prob);
+    let count = i64::from(count);
+    let factor = i64::from(factor);
+    let pre_prob = i64::from(pre_prob);
+
+    /*
+     * Round2(pre_prob * (256 - factor) + prob * factor, 8)
+     * Round2(pre_prob * 256 + (prob - pre_prob) * factor, 8)
+     * (pre_prob * 256 >> 8) + (((prob - pre_prob) * factor + 128) >> 8)
+     */
+    (pre_prob + (((prob - pre_prob) * factor + 128) >> 8))
+        .try_into()
+        .unwrap()
+}
+
+fn noncoef_merge_prob(pre_prob: u8, ct0: u32, ct1: u32) -> u8 {
+    merge_prob(pre_prob, ct0, ct1, 20, 128)
+}
+
+/* 8.4.2 Merge probs process */
+/*
+ * merge_probs() is a recursive function in the spec. We avoid recursion in the kernel.
+ * That said, the "tree" parameter of merge_probs() controls how deep the recursion goes.
+ * It turns out that in all cases the recursive calls boil down to a short-ish series
+ * of merge_prob() invocations (note no "s").
+ *
+ * Variant A
+ * ---------
+ * merge_probs(small_token_tree, 2):
+ *	merge_prob(p[1], c[0], c[1] + c[2])
+ *	merge_prob(p[2], c[1], c[2])
+ *
+ * Variant B
+ * ---------
+ * merge_probs(binary_tree, 0) or
+ * merge_probs(tx_size_8_tree, 0):
+ *	merge_prob(p[0], c[0], c[1])
+ *
+ * Variant C
+ * ---------
+ * merge_probs(inter_mode_tree, 0):
+ *	merge_prob(p[0], c[2], c[1] + c[0] + c[3])
+ *	merge_prob(p[1], c[0], c[1] + c[3])
+ *	merge_prob(p[2], c[1], c[3])
+ *
+ * Variant D
+ * ---------
+ * merge_probs(intra_mode_tree, 0):
+ *	merge_prob(p[0], c[0], c[1] + ... + c[9])
+ *	merge_prob(p[1], c[9], c[1] + ... + c[8])
+ *	merge_prob(p[2], c[1], c[2] + ... + c[8])
+ *	merge_prob(p[3], c[2] + c[4] + c[5], c[3] + c[8] + c[6] + c[7])
+ *	merge_prob(p[4], c[2], c[4] + c[5])
+ *	merge_prob(p[5], c[4], c[5])
+ *	merge_prob(p[6], c[3], c[8] + c[6] + c[7])
+ *	merge_prob(p[7], c[8], c[6] + c[7])
+ *	merge_prob(p[8], c[6], c[7])
+ *
+ * Variant E
+ * ---------
+ * merge_probs(partition_tree, 0) or
+ * merge_probs(tx_size_32_tree, 0) or
+ * merge_probs(mv_joint_tree, 0) or
+ * merge_probs(mv_fr_tree, 0):
+ *	merge_prob(p[0], c[0], c[1] + c[2] + c[3])
+ *	merge_prob(p[1], c[1], c[2] + c[3])
+ *	merge_prob(p[2], c[2], c[3])
+ *
+ * Variant F
+ * ---------
+ * merge_probs(interp_filter_tree, 0) or
+ * merge_probs(tx_size_16_tree, 0):
+ *	merge_prob(p[0], c[0], c[1] + c[2])
+ *	merge_prob(p[1], c[1], c[2])
+ *
+ * Variant G
+ * ---------
+ * merge_probs(mv_class_tree, 0):
+ *	merge_prob(p[0], c[0], c[1] + ... + c[10])
+ *	merge_prob(p[1], c[1], c[2] + ... + c[10])
+ *	merge_prob(p[2], c[2] + c[3], c[4] + ... + c[10])
+ *	merge_prob(p[3], c[2], c[3])
+ *	merge_prob(p[4], c[4] + c[5], c[6] + ... + c[10])
+ *	merge_prob(p[5], c[4], c[5])
+ *	merge_prob(p[6], c[6], c[7] + ... + c[10])
+ *	merge_prob(p[7], c[7] + c[8], c[9] + c[10])
+ *	merge_prob(p[8], c[7], c[8])
+ *	merge_prob(p[9], c[9], [10])
+ */
+
+fn merge_probs_variant_a(p: &mut [u8], c: &[u32], count_sat: u32, update_factor: u32) {
+    p[1] = merge_prob(p[1], c[0], c[1] + c[2], count_sat, update_factor);
+    p[2] = merge_prob(p[2], c[1], c[2], count_sat, update_factor);
+}
+
+fn merge_probs_variant_b(p: &mut [u8], c: &[u32], count_sat: u32, update_factor: u32) {
+    p[0] = merge_prob(p[0], c[0], c[1], count_sat, update_factor);
+}
+
+fn merge_probs_variant_c(p: &mut [u8], c: &[u32]) {
+    p[0] = noncoef_merge_prob(p[0], c[2], c[1] + c[0] + c[3]);
+    p[1] = noncoef_merge_prob(p[1], c[0], c[1] + c[3]);
+    p[2] = noncoef_merge_prob(p[2], c[1], c[3]);
+}
+
+fn merge_probs_variant_d(p: &mut [u8], c: &[u32]) {
+    let mut sum: u32 = c[1..=9].iter().sum();
+
+    p[0] = noncoef_merge_prob(p[0], c[0], sum);
+    sum -= c[9];
+    p[1] = noncoef_merge_prob(p[1], c[9], sum);
+    sum -= c[1];
+    p[2] = noncoef_merge_prob(p[2], c[1], sum);
+    let mut s2 = c[2] + c[4] + c[5];
+    sum -= s2;
+    p[3] = noncoef_merge_prob(p[3], s2, sum);
+    s2 -= c[2];
+    p[4] = noncoef_merge_prob(p[4], c[2], s2);
+    p[5] = noncoef_merge_prob(p[5], c[4], c[5]);
+    sum -= c[3];
+    p[6] = noncoef_merge_prob(p[6], c[3], sum);
+    sum -= c[8];
+    p[7] = noncoef_merge_prob(p[7], c[8], sum);
+    p[8] = noncoef_merge_prob(p[8], c[6], c[7]);
+}
+
+fn merge_probs_variant_e(p: &mut [u8], c: &[u32]) {
+    p[0] = noncoef_merge_prob(p[0], c[0], c[1] + c[2] + c[3]);
+    p[1] = noncoef_merge_prob(p[1], c[1], c[2] + c[3]);
+    p[2] = noncoef_merge_prob(p[2], c[2], c[3]);
+}
+
+fn merge_probs_variant_f(p: &mut [u8], c: &[u32]) {
+    p[0] = noncoef_merge_prob(p[0], c[0], c[1] + c[2]);
+    p[1] = noncoef_merge_prob(p[1], c[1], c[2]);
+}
+
+fn merge_probs_variant_g(p: &mut [u8], c: &[u32]) {
+    let mut sum: u32 = c[1..=10].iter().sum();
+    p[0] = noncoef_merge_prob(p[0], c[0], sum);
+    sum -= c[1];
+    p[1] = noncoef_merge_prob(p[1], c[1], sum);
+    sum -= c[2] + c[3];
+    p[2] = noncoef_merge_prob(p[2], c[2] + c[3], sum);
+    p[3] = noncoef_merge_prob(p[3], c[2], c[3]);
+    sum -= c[4] + c[5];
+    p[4] = noncoef_merge_prob(p[4], c[4] + c[5], sum);
+    p[5] = noncoef_merge_prob(p[5], c[4], c[5]);
+    sum -= c[6];
+    p[6] = noncoef_merge_prob(p[6], c[6], sum);
+    p[7] = noncoef_merge_prob(p[7], c[7] + c[8], c[9] + c[10]);
+    p[8] = noncoef_merge_prob(p[8], c[7], c[8]);
+    p[9] = noncoef_merge_prob(p[9], c[9], c[10]);
+}
+
+fn adapt_probs_variant_a_coef(p: &mut [u8], c: &[u32], update_factor: u32) {
+    merge_probs_variant_a(p, c, 24, update_factor);
+}
+
+fn adapt_probs_variant_b_coef(p: &mut [u8], c: &[u32], update_factor: u32) {
+    merge_probs_variant_b(p, c, 24, update_factor);
+}
+
+fn _adapt_coeff(
+    i: usize,
+    j: usize,
+    k: usize,
+    probs: &mut FrameContext,
+    counts: &FrameSymbolCounts<'_>,
+    uf: u32,
+) {
+    for l in 0..probs.coef[0][0][0].len() {
+        for m in 0..BAND_6!(l) {
+            let p = &mut probs.coef[i][j][k][l][m];
+            let counts_more_coefs = [
+                *counts.eob[i][j][k][l][m][1],
+                *counts.eob[i][j][k][l][m][0] - *counts.eob[i][j][k][l][m][1],
+            ];
+
+            adapt_probs_variant_a_coef(p, counts.coeff[i][j][k][l][m], uf);
+            adapt_probs_variant_b_coef(p, &counts_more_coefs, uf);
+        }
+    }
+}
+
+fn _adapt_coef_probs(probs: &mut FrameContext, counts: &mut FrameSymbolCounts<'_>, uf: u32) {
+    for i in 0..probs.coef.len() {
+        for j in 0..probs.coef[0].len() {
+            for k in 0..probs.coef[0][0].len() {
+                _adapt_coeff(i, j, k, probs, counts, uf);
+            }
+        }
+    }
+}
+
+fn adapt_probs_variant_b(p: &mut [u8], c: &[u32]) {
+    merge_probs_variant_b(p, c, 20, 128);
+}
+
+fn adapt_probs_variant_c(p: &mut [u8], c: &[u32]) {
+    merge_probs_variant_c(p, c);
+}
+
+fn adapt_probs_variant_d(p: &mut [u8], c: &[u32]) {
+    merge_probs_variant_d(p, c);
+}
+
+fn adapt_probs_variant_e(p: &mut [u8], c: &[u32]) {
+    merge_probs_variant_e(p, c);
+}
+
+fn adapt_probs_variant_f(p: &mut [u8], c: &[u32]) {
+    merge_probs_variant_f(p, c);
+}
+
+fn adapt_probs_variant_g(p: &mut [u8], c: &[u32]) {
+    merge_probs_variant_g(p, c);
+}
+
+fn adapt_prob(prob: u8, counts: [u32; 2]) -> u8 {
+    noncoef_merge_prob(prob, counts[0], counts[1])
+}
+
+// The C API for C drivers.
+pub mod c {
+    use super::*;
+    #[no_mangle]
+    /// Counterpart to 6.3 compressed_header(), but parsing has been done in userspace.
+    pub extern "C" fn v4l2_vp9_fw_update_probs_rs(
+        probs: &mut FrameContext,
+        deltas: &bindings::v4l2_ctrl_vp9_compressed_hdr,
+        dec_params: &bindings::v4l2_ctrl_vp9_frame,
+    ) {
+        super::fw_update_probs(probs, deltas, dec_params);
+    }
+
+    #[no_mangle]
+    pub extern "C" fn v4l2_vp9_reset_frame_ctx_rs(
+        dec_params: &bindings::v4l2_ctrl_vp9_frame,
+        frame_context: &mut [FrameContext; 4],
+    ) -> u8 {
+        super::reset_frame_ctx(dec_params, frame_context)
+    }
+
+    #[no_mangle]
+    pub extern "C" fn v4l2_vp9_adapt_coef_probs_rs(
+        probs: &mut FrameContext,
+        counts: &mut FrameSymbolCounts<'_>,
+        use_128: bool,
+        frame_is_intra: bool,
+    ) {
+        super::adapt_coef_probs(probs, counts, use_128, frame_is_intra);
+    }
+
+    #[no_mangle]
+    pub extern "C" fn v4l2_vp9_adapt_noncoef_probs_rs(
+        probs: &mut FrameContext,
+        counts: &mut FrameSymbolCounts<'_>,
+        reference_mode: u8,
+        interpolation_filter: u8,
+        tx_mode: u8,
+        flags: u32,
+    ) {
+        super::adapt_noncoef_probs(
+            probs,
+            counts,
+            reference_mode,
+            interpolation_filter,
+            tx_mode,
+            flags,
+        );
+    }
+
+    #[no_mangle]
+    pub extern "C" fn v4l2_vp9_seg_feat_enabled_rs(
+        feature_enabled: &[u8; 8],
+        feature: u32,
+        segid: u32,
+    ) -> bool {
+        super::seg_feat_enabled(feature_enabled, feature, segid)
+    }
+}
-- 
2.43.0


