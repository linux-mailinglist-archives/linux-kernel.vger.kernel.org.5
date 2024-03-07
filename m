Return-Path: <linux-kernel+bounces-96078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A948756D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3431F21E16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389F136992;
	Thu,  7 Mar 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k1qZhgdX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB2136983;
	Thu,  7 Mar 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838784; cv=none; b=TcqEbFzYJM4XRI0d/9/6AIFMX9crhsx+Xwqd9cVGZggh0AhdVwz7yyqKHdxX+e0n2RfBnIezXlDfzkpYplOgLaYN/CuPyiE/oZDuGmGIVoKYAPa1ViKCQzIA4PGP5T0ak18IsU5pekrE7Se3y8ud2N6g23eg+dk6EN0zHO83mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838784; c=relaxed/simple;
	bh=Ip2lE0mlbIvlK/wNnyztRmiDquhn+dPX9ocwRDPsZyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ertbhL6dIfY5uLALnMuFA3lGCs7EK616n7gM1hDekqlBPM7WuiOGfcjo3xgMLOHIIJU77kWs0UnaJwXzS9Xa7beTr2rhzvzx8a+SvO0FLj6F5pR+ewnQhKqc4tow/MD+GNMTRkIewLfrcoe5PawZ0CG9q0yQ18WSBnwADvdqPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k1qZhgdX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709838779;
	bh=Ip2lE0mlbIvlK/wNnyztRmiDquhn+dPX9ocwRDPsZyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1qZhgdXJG8OZfEgJs/DPqZuVEYQsarfUw7PiTJC1ZzbZBP0NAbu7RS7FgwjBsi8L
	 8PNm1J+Q3AhcIKyEuI8W9ts+UF9aVPUIe9/+Ws2V1EAPtOoxENwBUMTGVGHL8cHE7U
	 nQGPywOOBU8H56xNTWR5PhdP5CKAuiQovedwkTseGm+vNcGDQltgdbKIVVfVJvBb07
	 34ZVTU0hqS2a/IiDWXxG/12ObX07GK+6GJGwnGdDPLy6J5O/oqSZ560rJ6WzmDBB69
	 U7rGfOlvE0mWYlFGGhgeMduXbAwX9ZZTw0Xj6Dh7jnWBwu57NX7fa0R0Y+WzfHmbaj
	 M16aL6bmXsCoQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89DCB378134F;
	Thu,  7 Mar 2024 19:12:55 +0000 (UTC)
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
Subject: [RFC PATCH v2 2/2] media: rkvdec: rewrite parts of the driver in Rust
Date: Thu,  7 Mar 2024 16:08:16 -0300
Message-ID: <20240307190841.10260-3-daniel.almeida@collabora.com>
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
 drivers/staging/media/rkvdec/Kconfig       |   1 +
 drivers/staging/media/rkvdec/Makefile      |   2 +-
 drivers/staging/media/rkvdec/cbindgen.toml |  36 ++
 drivers/staging/media/rkvdec/common.rs     |  19 +
 drivers/staging/media/rkvdec/regs.rs       | 237 ++++++++
 drivers/staging/media/rkvdec/rkvdec-vp9.c  | 585 ++++---------------
 drivers/staging/media/rkvdec/rkvdec_rs.h   | 125 ++++
 drivers/staging/media/rkvdec/rkvdec_rs.rs  |  14 +
 drivers/staging/media/rkvdec/vp9.rs        | 636 +++++++++++++++++++++
 rust/helpers.c                             |   7 +
 10 files changed, 1181 insertions(+), 481 deletions(-)
 create mode 100644 drivers/staging/media/rkvdec/cbindgen.toml
 create mode 100644 drivers/staging/media/rkvdec/common.rs
 create mode 100644 drivers/staging/media/rkvdec/regs.rs
 create mode 100644 drivers/staging/media/rkvdec/rkvdec_rs.h
 create mode 100644 drivers/staging/media/rkvdec/rkvdec_rs.rs
 create mode 100644 drivers/staging/media/rkvdec/vp9.rs

diff --git a/drivers/staging/media/rkvdec/Kconfig b/drivers/staging/media/rkvdec/Kconfig
index 245dc47082d4..1877b6b0153b 100644
--- a/drivers/staging/media/rkvdec/Kconfig
+++ b/drivers/staging/media/rkvdec/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_ROCKCHIP_VDEC
 	tristate "Rockchip Video Decoder driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on VIDEO_DEV
+	depends on RUST
 	select MEDIA_CONTROLLER
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_VMALLOC
diff --git a/drivers/staging/media/rkvdec/Makefile b/drivers/staging/media/rkvdec/Makefile
index cb86b429cfaa..8e04aa7dbf16 100644
--- a/drivers/staging/media/rkvdec/Makefile
+++ b/drivers/staging/media/rkvdec/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_VIDEO_ROCKCHIP_VDEC) += rockchip-vdec.o
 
-rockchip-vdec-y += rkvdec.o rkvdec-h264.o rkvdec-vp9.o
+rockchip-vdec-y += rkvdec.o rkvdec-h264.o rkvdec-vp9.o rkvdec_rs.o
diff --git a/drivers/staging/media/rkvdec/cbindgen.toml b/drivers/staging/media/rkvdec/cbindgen.toml
new file mode 100644
index 000000000000..3ca785d26cc8
--- /dev/null
+++ b/drivers/staging/media/rkvdec/cbindgen.toml
@@ -0,0 +1,36 @@
+# Generate the C API with:
+# cbindgen  --lang c  -v --config drivers/staging/media/rkvdec/cbindgen.toml --output drivers/staging/media/rkvdec/rkvdec_rs.h -- drivers/staging/media/rkvdec/rkvdec_rs.rs
+
+language = "C"
+
+# No <stdarg.h>, <stdbool.h>, <stdint.h>, <stdlib.h>, <uchar.h>
+no_includes = true
+style = "tag"
+
+sys_includes = ["media/v4l2-ctrls.h", "media/v4l2-vp9-rs.h", "linux/types.h"]
+autogen_warning = "/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */"
+usize_is_size_t = true
+include_guard = "RKVDEC_RS_H"
+
+# Rename everything from bindgen
+# See https://github.com/mozilla/cbindgen/issues/621
+# Also rename our mangled structs into snake_case for the C API
+[export.rename]
+"v4l2_ctrl_vp9_frame" = "struct v4l2_ctrl_vp9_frame"
+"v4l2_vp9_segmentation" = "struct v4l2_vp9_segmentation"
+"v4l2_vp9_loop_filter" = "struct v4l2_vp9_loop_filter"
+"Resolution" = "rkvdec_rs_resolution"
+"Mv" = " rkvdec_rs_vp9_mv"
+"InterFrameProbs" = " rkvdec_rs_vp9_inter_frame_probs"
+"IntraModeProbs" = " rkvdec_rs_vp9_intra_mode_probs"
+"IntraOnlyFrameProbs" = " rkvdec_rs_vp9_intra_only_frame_probs"
+"FrameProbs" = " rkvdec_rs_vp9_frame_probs"
+"HwProbs" = " rkvdec_rs_vp9_probs"
+"DecodedBufferInfo" = "rkvdec_rs_decoded_buffer_info"
+"FrameInfo" = "rkvdec_rs_frame_info"
+"BaseRun" = "rkvdec_rs_base_run"
+"Run" = "rkvdec_rs_run"
+"FrameContext" = "struct v4l2_vp9_frame_context_rs"
+
+[enum]
+prefix_with_name = true
diff --git a/drivers/staging/media/rkvdec/common.rs b/drivers/staging/media/rkvdec/common.rs
new file mode 100644
index 000000000000..0f9f35bc915f
--- /dev/null
+++ b/drivers/staging/media/rkvdec/common.rs
@@ -0,0 +1,19 @@
+#![allow(missing_docs)]
+#![allow(non_upper_case_globals)]
+#![allow(dead_code)]
+#![allow(unused_variables)]
+
+use kernel::bindings;
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+pub(crate) struct Resolution {
+    pub(crate) width: u32,
+    pub(crate) height: u32,
+}
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+pub(crate) struct BaseRun {
+    pub(crate) decoded_resolution: Resolution,
+}
diff --git a/drivers/staging/media/rkvdec/regs.rs b/drivers/staging/media/rkvdec/regs.rs
new file mode 100644
index 000000000000..644f4b07063d
--- /dev/null
+++ b/drivers/staging/media/rkvdec/regs.rs
@@ -0,0 +1,237 @@
+#![allow(dead_code)]
+#![allow(unused_macros)]
+
+pub(crate) const RKVDEC_REG_INTERRUPT: u32 = 0x004;
+pub(crate) const RKVDEC_INTERRUPT_DEC_E: u32 = 1 << 0;
+pub(crate) const RKVDEC_CONFIG_DEC_CLK_GATE_E: u32 = 1 << 1;
+pub(crate) const RKVDEC_E_STRMD_CLKGATE_DIS: u32 = 1 << 2;
+pub(crate) const RKVDEC_TIMEOUT_MODE: u32 = 1 << 3;
+pub(crate) const RKVDEC_IRQ_DIS: u32 = 1 << 4;
+pub(crate) const RKVDEC_TIMEOUT_E: u32 = 1 << 5;
+pub(crate) const RKVDEC_BUF_EMPTY_E: u32 = 1 << 6;
+pub(crate) const RKVDEC_STRM_E_WAITDECFIFO_EMPTY: u32 = 1 << 7;
+pub(crate) const RKVDEC_IRQ: u32 = 1 << 8;
+pub(crate) const RKVDEC_IRQ_RAW: u32 = 1 << 9;
+pub(crate) const RKVDEC_E_REWRITE_VALID: u32 = 1 << 10;
+pub(crate) const RKVDEC_COMMONIRQ_MODE: u32 = 1 << 11;
+pub(crate) const RKVDEC_RDY_STA: u32 = 1 << 12;
+pub(crate) const RKVDEC_BUS_STA: u32 = 1 << 13;
+pub(crate) const RKVDEC_ERR_STA: u32 = 1 << 14;
+pub(crate) const RKVDEC_TIMEOUT_STA: u32 = 1 << 15;
+pub(crate) const RKVDEC_BUF_EMPTY_STA: u32 = 1 << 16;
+pub(crate) const RKVDEC_COLMV_REF_ERR_STA: u32 = 1 << 17;
+pub(crate) const RKVDEC_CABU_END_STA: u32 = 1 << 18;
+pub(crate) const RKVDEC_H264ORVP9_ERR_MODE: u32 = 1 << 19;
+pub(crate) const RKVDEC_SOFTRST_EN_P: u32 = 1 << 20;
+pub(crate) const RKVDEC_FORCE_SOFTRESET_VALID: u32 = 1 << 21;
+pub(crate) const RKVDEC_SOFTRESET_RDY: u32 = 1 << 22;
+pub(crate) const RKVDEC_REG_SYSCTRL: u32 = 0x008;
+pub(crate) const RKVDEC_IN_ENDIAN: u32 = 1 << 0;
+pub(crate) const RKVDEC_IN_SWAP32_E: u32 = 1 << 1;
+pub(crate) const RKVDEC_IN_SWAP64_E: u32 = 1 << 2;
+pub(crate) const RKVDEC_STR_ENDIAN: u32 = 1 << 3;
+pub(crate) const RKVDEC_STR_SWAP32_E: u32 = 1 << 4;
+pub(crate) const RKVDEC_STR_SWAP64_E: u32 = 1 << 5;
+pub(crate) const RKVDEC_OUT_ENDIAN: u32 = 1 << 6;
+pub(crate) const RKVDEC_OUT_SWAP32_E: u32 = 1 << 7;
+pub(crate) const RKVDEC_OUT_CBCR_SWAP: u32 = 1 << 8;
+pub(crate) const RKVDEC_RLC_MODE_DIRECT_WRITE: u32 = 1 << 10;
+pub(crate) const RKVDEC_RLC_MODE: u32 = 1 << 11;
+macro_rules! RKVDEC_STRM_START_BIT { ($x:expr) => { ((($x) & 0x7f) << 12) } }
+macro_rules! RKVDEC_MODE { ($x:expr) => { ((($x) & 0x03) << 20) } }
+pub(crate) const RKVDEC_MODE_H264: u32 = 1;
+pub(crate) const RKVDEC_MODE_VP9: u32 = 2;
+pub(crate) const RKVDEC_RPS_MODE: u32 = 1 << 24;
+pub(crate) const RKVDEC_STRM_MODE: u32 = 1 << 25;
+pub(crate) const RKVDEC_H264_STRM_LASTPKT: u32 = 1 << 26;
+pub(crate) const RKVDEC_H264_FIRSTSLICE_FLAG: u32 = 1 << 27;
+pub(crate) const RKVDEC_H264_FRAME_ORSLICE: u32 = 1 << 28;
+pub(crate) const RKVDEC_BUSPR_SLOT_DIS: u32 = 1 << 29;
+pub(crate) const RKVDEC_REG_PICPAR: u32 = 0x00C;
+macro_rules! RKVDEC_Y_HOR_VIRSTRIDE { ($x:expr) => { (($x) & 0x1ff) } }
+pub(crate) const RKVDEC_SLICE_NUM_HIGHBIT: u32 = 1 << 11;
+macro_rules! RKVDEC_UV_HOR_VIRSTRIDE { ($x:expr) => { ((($x) & 0x1ff) << 12) } }
+macro_rules! RKVDEC_SLICE_NUM_LOWBITS { ($x:expr) => { ((($x) & 0x7ff) << 21) } }
+pub(crate) const RKVDEC_REG_STRM_RLC_BASE: u32 = 0x010;
+pub(crate) const RKVDEC_REG_STRM_LEN: u32 = 0x014;
+macro_rules! RKVDEC_STRM_LEN { ($x:expr) => { (($x) & 0x7ffffff) } }
+pub(crate) const RKVDEC_REG_CABACTBL_PROB_BASE: u32 = 0x018;
+pub(crate) const RKVDEC_REG_DECOUT_BASE: u32 = 0x01C;
+pub(crate) const RKVDEC_REG_Y_VIRSTRIDE: u32 = 0x020;
+macro_rules! RKVDEC_Y_VIRSTRIDE { ($x:expr) => { (($x) & 0xfffff) } }
+pub(crate) const RKVDEC_REG_YUV_VIRSTRIDE: u32 = 0x024;
+macro_rules! RKVDEC_YUV_VIRSTRIDE { ($x:expr) => { (($x) & 0x1fffff) } }
+macro_rules! RKVDEC_REG_H264_BASE_REFER { ($x:expr) => { ((($i) * 0x04) + 0x028) } }
+pub(crate) const RKVDEC_REG_H264_BASE_REFER15: u32 = 0x0C0;
+pub(crate) const RKVDEC_FIELD_REF: u32 = 1 << 0;
+pub(crate) const RKVDEC_TOPFIELD_USED_REF: u32 = 1 << 1;
+pub(crate) const RKVDEC_BOTFIELD_USED_REF: u32 = 1 << 2;
+pub(crate) const RKVDEC_COLMV_USED_FLAG_REF: u32 = 1 << 3;
+pub(crate) const RKVDEC_REG_VP9_LAST_FRAME_BASE: u32 = 0x02c;
+pub(crate) const RKVDEC_REG_VP9_GOLDEN_FRAME_BASE: u32 = 0x030;
+pub(crate) const RKVDEC_REG_VP9_ALTREF_FRAME_BASE: u32 = 0x034;
+pub(crate) const RKVDEC_REG_VP9_CPRHEADER_OFFSET: u32 = 0x028;
+macro_rules! RKVDEC_VP9_CPRHEADER_OFFSET { ($x:expr) => { (($x) & 0xffff) } }
+pub(crate) const RKVDEC_REG_VP9_REFERLAST_BASE: u32 = 0x02C;
+pub(crate) const RKVDEC_REG_VP9_REFERGOLDEN_BASE: u32 = 0x030;
+pub(crate) const RKVDEC_REG_VP9_REFERALFTER_BASE: u32 = 0x034;
+pub(crate) const RKVDEC_REG_VP9COUNT_BASE: u32 = 0x038;
+pub(crate) const RKVDEC_VP9COUNT_UPDATE_EN: u32 = 1 << 0;
+pub(crate) const RKVDEC_REG_VP9_SEGIDLAST_BASE: u32 = 0x03C;
+pub(crate) const RKVDEC_REG_VP9_SEGIDCUR_BASE: u32 = 0x040;
+macro_rules! RKVDEC_REG_VP9_FRAME_SIZE { ($x:expr) => { (($x) * 0x04 + 0x044) } }
+macro_rules! RKVDEC_VP9_FRAMEWIDTH { ($x:expr) => { ((($x) & 0xffff) << 0) } }
+macro_rules! RKVDEC_VP9_FRAMEHEIGHT { ($x:expr) => { ((($x) & 0xffff) << 16) } }
+macro_rules! RKVDEC_VP9_SEGID_GRP { ($x:expr) => { (($x) * 0x04 + 0x050) } }
+macro_rules! RKVDEC_SEGID_ABS_DELTA { ($x:expr) => { (($x) & 0x1) } }
+macro_rules! RKVDEC_SEGID_FRAME_QP_DELTA_EN { ($x:expr) => { ((($x) & 0x1) << 1) } }
+macro_rules! RKVDEC_SEGID_FRAME_QP_DELTA { ($x:expr) => { ((($x) & 0x1ff) << 2) } }
+macro_rules! RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE_EN { ($x:expr) => { ((($x) & 0x1) << 11) } }
+macro_rules! RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE { ($x:expr) => { ((($x) & 0x7f) << 12) } }
+macro_rules! RKVDEC_SEGID_REFERINFO_EN { ($x:expr) => { ((($x) & 0x1) << 19) } }
+macro_rules! RKVDEC_SEGID_REFERINFO { ($x:expr) => { ((($x) & 0x03) << 20) } }
+macro_rules! RKVDEC_SEGID_FRAME_SKIP_EN { ($x:expr) => { ((($x) & 0x1) << 22) } }
+pub(crate) const RKVDEC_VP9_CPRHEADER_CONFIG: u32 = 0x070;
+macro_rules! RKVDEC_VP9_TX_MODE { ($x:expr) => { (($x) & 0x07) } }
+macro_rules! RKVDEC_VP9_FRAME_REF_MODE { ($x:expr) => { ((($x) & 0x03) << 3) } }
+macro_rules! RKVDEC_VP9_REF_SCALE { ($x:expr) => { (($x) * 0x04 + 0x074) } }
+macro_rules! RKVDEC_VP9_REF_HOR_SCALE { ($x:expr) => { (($x) & 0xffff) } }
+macro_rules! RKVDEC_VP9_REF_VER_SCALE { ($x:expr) => { ((($x) & 0xffff) << 16) } }
+pub(crate) const RKVDEC_VP9_REF_DELTAS_LASTFRAME: u32 = 0x080;
+macro_rules! RKVDEC_REF_DELTAS_LASTFRAME { ($pos:expr, $val:expr) => { ((($val) & 0x7f) << (($pos) * 7)) } }
+pub(crate) const RKVDEC_VP9_INFO_LASTFRAME: u32 = 0x084;
+macro_rules! RKVDEC_MODE_DELTAS_LASTFRAME { ($pos:expr, $val:expr) => { ((($val) & 0x7f) << (($pos) * 7)) } }
+pub(crate) const RKVDEC_SEG_EN_LASTFRAME: u32 = 1 << 16;
+pub(crate) const RKVDEC_LAST_SHOW_FRAME: u32 = 1 << 17;
+pub(crate) const RKVDEC_LAST_INTRA_ONLY: u32 = 1 << 18;
+pub(crate) const RKVDEC_LAST_WIDHHEIGHT_EQCUR: u32 = 1 << 19;
+macro_rules! RKVDEC_COLOR_SPACE_LASTKEYFRAME { ($x:expr) => { ((($x) & 0x07) << 20) } }
+pub(crate) const RKVDEC_VP9_INTERCMD_BASE: u32 = 0x088;
+pub(crate) const RKVDEC_VP9_INTERCMD_NUM: u32 = 0x08C;
+macro_rules! RKVDEC_INTERCMD_NUM { ($x:expr) => { (($x) & 0xffffff) } }
+pub(crate) const RKVDEC_VP9_LASTTILE_SIZE: u32 = 0x090;
+macro_rules! RKVDEC_LASTTILE_SIZE { ($x:expr) => { (($x) & 0xffffff) } }
+macro_rules! RKVDEC_VP9_HOR_VIRSTRIDE { ($i:expr) => { (($i) * 0x04 + 0x094) } }
+macro_rules! RKVDEC_HOR_Y_VIRSTRIDE { ($x:expr) => { (($x) & 0x1ff) } }
+macro_rules! RKVDEC_HOR_UV_VIRSTRIDE { ($x:expr) => { ((($x) & 0x1ff) << 16) } }
+macro_rules! RKVDEC_REG_H264_POC_REFER0 { ($i:expr) => { ((($i) * 0x04) + 0x064) } }
+macro_rules! RKVDEC_REG_H264_POC_REFER1 { ($i:expr) => { ((($i) * 0x04) + 0x0C4) } }
+macro_rules! RKVDEC_REG_H264_POC_REFER2 { ($i:expr) => { ((($i) * 0x04) + 0x120) } }
+macro_rules! RKVDEC_POC_REFER { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_CUR_POC0: u32 = 0x0A0;
+pub(crate) const RKVDEC_REG_CUR_POC1: u32 = 0x128;
+macro_rules! RKVDEC_CUR_POC { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_RLCWRITE_BASE: u32 = 0x0A4;
+pub(crate) const RKVDEC_REG_PPS_BASE: u32 = 0x0A8;
+pub(crate) const RKVDEC_REG_RPS_BASE: u32 = 0x0AC;
+pub(crate) const RKVDEC_REG_STRMD_ERR_EN: u32 = 0x0B0;
+macro_rules! RKVDEC_STRMD_ERR_EN { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_STRMD_ERR_STA: u32 = 0x0B4;
+macro_rules! RKVDEC_STRMD_ERR_STA { ($x:expr) => { (($x) & 0xfffffff) } }
+macro_rules! RKVDEC_COLMV_ERR_REF_PICIDX { ($x:expr) => { ((($x) & 0x0f) << 28) } }
+pub(crate) const RKVDEC_REG_STRMD_ERR_CTU: u32 = 0x0B8;
+macro_rules! RKVDEC_STRMD_ERR_CTU { ($x:expr) => { (($x) & 0xff) } }
+macro_rules! RKVDEC_STRMD_ERR_CTU_YOFFSET { ($x:expr) => { ((($x) & 0xff) << 8) } }
+macro_rules! RKVDEC_STRMFIFO_SPACE2FULL { ($x:expr) => { ((($x) & 0x7f) << 16) } }
+pub(crate) const RKVDEC_VP9_ERR_EN_CTU0: u32 = 1 << 24;
+pub(crate) const RKVDEC_REG_SAO_CTU_POS: u32 = 0x0BC;
+macro_rules! RKVDEC_SAOWR_XOFFSET { ($x:expr) => { (($x) & 0x1ff) } }
+macro_rules! RKVDEC_SAOWR_YOFFSET { ($x:expr) => { ((($x) & 0x3ff) << 16) } }
+pub(crate) const RKVDEC_VP9_LAST_FRAME_YSTRIDE: u32 = 0x0C0;
+pub(crate) const RKVDEC_VP9_GOLDEN_FRAME_YSTRIDE: u32 = 0x0C4;
+pub(crate) const RKVDEC_VP9_ALTREF_FRAME_YSTRIDE: u32 = 0x0C8;
+macro_rules! RKVDEC_VP9_REF_YSTRIDE { ($x:expr) => { ((($x) & 0xfffff) << 0) } }
+pub(crate) const RKVDEC_VP9_LAST_FRAME_YUVSTRIDE: u32 = 0x0CC;
+macro_rules! RKVDEC_VP9_REF_YUVSTRIDE { ($x:expr) => { ((($x) & 0x1fffff) << 0) } }
+pub(crate) const RKVDEC_VP9_REF_COLMV_BASE: u32 = 0x0D0;
+pub(crate) const RKVDEC_REG_PERFORMANCE_CYCLE: u32 = 0x100;
+macro_rules! RKVDEC_PERFORMANCE_CYCLE { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_AXI_DDR_RDATA: u32 = 0x104;
+macro_rules! RKVDEC_AXI_DDR_RDATA { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_AXI_DDR_WDATA: u32 = 0x108;
+macro_rules! RKVDEC_AXI_DDR_WDATA { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_FPGADEBUG_RESET: u32 = 0x10C;
+pub(crate) const RKVDEC_BUSIFD_RESETN: u32 = 1 << 0;
+pub(crate) const RKVDEC_CABAC_RESETN: u32 = 1 << 1;
+pub(crate) const RKVDEC_DEC_CTRL_RESETN: u32 = 1 << 2;
+pub(crate) const RKVDEC_TRANSD_RESETN: u32 = 1 << 3;
+pub(crate) const RKVDEC_INTRA_RESETN: u32 = 1 << 4;
+pub(crate) const RKVDEC_INTER_RESETN: u32 = 1 << 5;
+pub(crate) const RKVDEC_RECON_RESETN: u32 = 1 << 6;
+pub(crate) const RKVDEC_FILER_RESETN: u32 = 1 << 7;
+pub(crate) const RKVDEC_REG_PERFORMANCE_SEL: u32 = 0x110;
+macro_rules! RKVDEC_PERF_SEL_CNT0 { ($x:expr) => { (($x) & 0x3f) } }
+macro_rules! RKVDEC_PERF_SEL_CNT1 { ($x:expr) => { ((($x) & 0x3f) << 8) } }
+macro_rules! RKVDEC_PERF_SEL_CNT2 { ($x:expr) => { ((($x) & 0x3f) << 16) } }
+macro_rules! RKVDEC_REG_PERFORMANCE_CNT { ($i:expr) => { (($i) * 0x04 + 0x114) } }
+macro_rules! RKVDEC_PERF_CNT { ($x:expr) => { (($x) & 0xffffffff) } }
+pub(crate) const RKVDEC_REG_H264_ERRINFO_BASE: u32 = 0x12C;
+pub(crate) const RKVDEC_REG_H264_ERRINFO_NUM: u32 = 0x130;
+macro_rules! RKVDEC_SLICEDEC_NUM { ($x:expr) => { (($x) & 0x3fff) } }
+pub(crate) const RKVDEC_STRMD_DECT_ERR_FLAG: u32 = 1 << 15;
+macro_rules! RKVDEC_ERR_PKT_NUM { ($x:expr) => { ((($x) & 0x3fff) << 16) } }
+pub(crate) const RKVDEC_REG_H264_ERR_E: u32 = 0x134;
+macro_rules! RKVDEC_H264_ERR_EN_HIGHBITS { ($x:expr) => { (($x) & 0x3fffffff) } }
+pub(crate) const RKVDEC_REG_PREF_LUMA_CACHE_COMMAND: u32 = 0x410;
+pub(crate) const RKVDEC_REG_PREF_CHR_CACHE_COMMAND: u32 = 0x450;
+pub(crate) use RKVDEC_STRM_START_BIT;
+pub(crate) use RKVDEC_MODE;
+pub(crate) use RKVDEC_Y_HOR_VIRSTRIDE;
+pub(crate) use RKVDEC_UV_HOR_VIRSTRIDE;
+pub(crate) use RKVDEC_SLICE_NUM_LOWBITS;
+pub(crate) use RKVDEC_STRM_LEN;
+pub(crate) use RKVDEC_Y_VIRSTRIDE;
+pub(crate) use RKVDEC_YUV_VIRSTRIDE;
+pub(crate) use RKVDEC_REG_H264_BASE_REFER;
+pub(crate) use RKVDEC_VP9_CPRHEADER_OFFSET;
+pub(crate) use RKVDEC_REG_VP9_FRAME_SIZE;
+pub(crate) use RKVDEC_VP9_FRAMEWIDTH;
+pub(crate) use RKVDEC_VP9_FRAMEHEIGHT;
+pub(crate) use RKVDEC_VP9_SEGID_GRP;
+pub(crate) use RKVDEC_SEGID_ABS_DELTA;
+pub(crate) use RKVDEC_SEGID_FRAME_QP_DELTA_EN;
+pub(crate) use RKVDEC_SEGID_FRAME_QP_DELTA;
+pub(crate) use RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE_EN;
+pub(crate) use RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE;
+pub(crate) use RKVDEC_SEGID_REFERINFO_EN;
+pub(crate) use RKVDEC_SEGID_REFERINFO;
+pub(crate) use RKVDEC_SEGID_FRAME_SKIP_EN;
+pub(crate) use RKVDEC_VP9_TX_MODE;
+pub(crate) use RKVDEC_VP9_FRAME_REF_MODE;
+pub(crate) use RKVDEC_VP9_REF_SCALE;
+pub(crate) use RKVDEC_VP9_REF_HOR_SCALE;
+pub(crate) use RKVDEC_VP9_REF_VER_SCALE;
+pub(crate) use RKVDEC_REF_DELTAS_LASTFRAME;
+pub(crate) use RKVDEC_MODE_DELTAS_LASTFRAME;
+pub(crate) use RKVDEC_COLOR_SPACE_LASTKEYFRAME;
+pub(crate) use RKVDEC_INTERCMD_NUM;
+pub(crate) use RKVDEC_LASTTILE_SIZE;
+pub(crate) use RKVDEC_VP9_HOR_VIRSTRIDE;
+pub(crate) use RKVDEC_HOR_Y_VIRSTRIDE;
+pub(crate) use RKVDEC_HOR_UV_VIRSTRIDE;
+pub(crate) use RKVDEC_REG_H264_POC_REFER0;
+pub(crate) use RKVDEC_REG_H264_POC_REFER1;
+pub(crate) use RKVDEC_REG_H264_POC_REFER2;
+pub(crate) use RKVDEC_POC_REFER;
+pub(crate) use RKVDEC_CUR_POC;
+pub(crate) use RKVDEC_STRMD_ERR_EN;
+pub(crate) use RKVDEC_STRMD_ERR_STA;
+pub(crate) use RKVDEC_COLMV_ERR_REF_PICIDX;
+pub(crate) use RKVDEC_STRMD_ERR_CTU;
+pub(crate) use RKVDEC_STRMD_ERR_CTU_YOFFSET;
+pub(crate) use RKVDEC_STRMFIFO_SPACE2FULL;
+pub(crate) use RKVDEC_SAOWR_XOFFSET;
+pub(crate) use RKVDEC_SAOWR_YOFFSET;
+pub(crate) use RKVDEC_VP9_REF_YSTRIDE;
+pub(crate) use RKVDEC_VP9_REF_YUVSTRIDE;
+pub(crate) use RKVDEC_PERFORMANCE_CYCLE;
+pub(crate) use RKVDEC_AXI_DDR_RDATA;
+pub(crate) use RKVDEC_AXI_DDR_WDATA;
+pub(crate) use RKVDEC_PERF_SEL_CNT0;
+pub(crate) use RKVDEC_PERF_SEL_CNT1;
+pub(crate) use RKVDEC_PERF_SEL_CNT2;
+pub(crate) use RKVDEC_REG_PERFORMANCE_CNT;
+pub(crate) use RKVDEC_PERF_CNT;
+pub(crate) use RKVDEC_SLICEDEC_NUM;
+pub(crate) use RKVDEC_ERR_PKT_NUM;
+pub(crate) use RKVDEC_H264_ERR_EN_HIGHBITS;
\ No newline at end of file
diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
index 86c6903d11ab..5af5a7fdcde2 100644
--- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
+++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
@@ -23,74 +23,15 @@
 
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
+#include "rkvdec_rs.h"
 
 #define RKVDEC_VP9_PROBE_SIZE		4864
 #define RKVDEC_VP9_COUNT_SIZE		13232
 #define RKVDEC_VP9_MAX_SEGMAP_SIZE	73728
 
-struct rkvdec_vp9_intra_mode_probs {
-	u8 y_mode[105];
-	u8 uv_mode[23];
-};
-
-struct rkvdec_vp9_intra_only_frame_probs {
-	u8 coef_intra[4][2][128];
-	struct rkvdec_vp9_intra_mode_probs intra_mode[10];
-};
-
-struct rkvdec_vp9_inter_frame_probs {
-	u8 y_mode[4][9];
-	u8 comp_mode[5];
-	u8 comp_ref[5];
-	u8 single_ref[5][2];
-	u8 inter_mode[7][3];
-	u8 interp_filter[4][2];
-	u8 padding0[11];
-	u8 coef[2][4][2][128];
-	u8 uv_mode_0_2[3][9];
-	u8 padding1[5];
-	u8 uv_mode_3_5[3][9];
-	u8 padding2[5];
-	u8 uv_mode_6_8[3][9];
-	u8 padding3[5];
-	u8 uv_mode_9[9];
-	u8 padding4[7];
-	u8 padding5[16];
-	struct {
-		u8 joint[3];
-		u8 sign[2];
-		u8 classes[2][10];
-		u8 class0_bit[2];
-		u8 bits[2][10];
-		u8 class0_fr[2][2][3];
-		u8 fr[2][3];
-		u8 class0_hp[2];
-		u8 hp[2];
-	} mv;
-};
-
-struct rkvdec_vp9_probs {
-	u8 partition[16][3];
-	u8 pred[3];
-	u8 tree[7];
-	u8 skip[3];
-	u8 tx32[2][3];
-	u8 tx16[2][2];
-	u8 tx8[2][1];
-	u8 is_inter[4];
-	/* 128 bit alignment */
-	u8 padding0[3];
-	union {
-		struct rkvdec_vp9_inter_frame_probs inter;
-		struct rkvdec_vp9_intra_only_frame_probs intra_only;
-	};
-	/* 128 bit alignment */
-	u8 padding1[11];
-};
-
 /* Data structure describing auxiliary buffer format. */
 struct rkvdec_vp9_priv_tbl {
-	struct rkvdec_vp9_probs probs;
+	struct rkvdec_rs_vp9_probs probs;
 	u8 segmap[2][RKVDEC_VP9_MAX_SEGMAP_SIZE];
 };
 
@@ -165,188 +106,6 @@ struct rkvdec_vp9_ctx {
 	struct rkvdec_vp9_frame_info last;
 };
 
-static void write_coeff_plane(const u8 coef[6][6][3], u8 *coeff_plane)
-{
-	unsigned int idx = 0, byte_count = 0;
-	int k, m, n;
-	u8 p;
-
-	for (k = 0; k < 6; k++) {
-		for (m = 0; m < 6; m++) {
-			for (n = 0; n < 3; n++) {
-				p = coef[k][m][n];
-				coeff_plane[idx++] = p;
-				byte_count++;
-				if (byte_count == 27) {
-					idx += 5;
-					byte_count = 0;
-				}
-			}
-		}
-	}
-}
-
-static void init_intra_only_probs(struct rkvdec_ctx *ctx,
-				  const struct rkvdec_vp9_run *run)
-{
-	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
-	struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
-	struct rkvdec_vp9_intra_only_frame_probs *rkprobs;
-	const struct v4l2_vp9_frame_context_rs *probs;
-	unsigned int i, j, k;
-
-	rkprobs = &tbl->probs.intra_only;
-	probs = &vp9_ctx->probability_tables;
-
-	/*
-	 * intra only 149 x 128 bits ,aligned to 152 x 128 bits coeff related
-	 * prob 64 x 128 bits
-	 */
-	for (i = 0; i < ARRAY_SIZE(probs->coef); i++) {
-		for (j = 0; j < ARRAY_SIZE(probs->coef[0]); j++)
-			write_coeff_plane(probs->coef[i][j][0],
-					  rkprobs->coef_intra[i][j]);
-	}
-
-	/* intra mode prob  80 x 128 bits */
-	for (i = 0; i < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob_rs); i++) {
-		unsigned int byte_count = 0;
-		int idx = 0;
-
-		/* vp9_kf_y_mode_prob */
-		for (j = 0; j < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob_rs[0]); j++) {
-			for (k = 0; k < ARRAY_SIZE(v4l2_vp9_kf_y_mode_prob_rs[0][0]);
-			     k++) {
-				u8 val = v4l2_vp9_kf_y_mode_prob_rs[i][j][k];
-
-				rkprobs->intra_mode[i].y_mode[idx++] = val;
-				byte_count++;
-				if (byte_count == 27) {
-					byte_count = 0;
-					idx += 5;
-				}
-			}
-		}
-	}
-
-	for (i = 0; i < sizeof(v4l2_vp9_kf_uv_mode_prob_rs); ++i) {
-		const u8 *ptr = (const u8 *)v4l2_vp9_kf_uv_mode_prob_rs;
-
-		rkprobs->intra_mode[i / 23].uv_mode[i % 23] = ptr[i];
-	}
-}
-
-static void init_inter_probs(struct rkvdec_ctx *ctx,
-			     const struct rkvdec_vp9_run *run)
-{
-	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
-	struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
-	struct rkvdec_vp9_inter_frame_probs *rkprobs;
-	const struct v4l2_vp9_frame_context_rs *probs;
-	unsigned int i, j, k;
-
-	rkprobs = &tbl->probs.inter;
-	probs = &vp9_ctx->probability_tables;
-
-	/*
-	 * inter probs
-	 * 151 x 128 bits, aligned to 152 x 128 bits
-	 * inter only
-	 * intra_y_mode & inter_block info 6 x 128 bits
-	 */
-
-	memcpy(rkprobs->y_mode, probs->y_mode, sizeof(rkprobs->y_mode));
-	memcpy(rkprobs->comp_mode, probs->comp_mode,
-	       sizeof(rkprobs->comp_mode));
-	memcpy(rkprobs->comp_ref, probs->comp_ref,
-	       sizeof(rkprobs->comp_ref));
-	memcpy(rkprobs->single_ref, probs->single_ref,
-	       sizeof(rkprobs->single_ref));
-	memcpy(rkprobs->inter_mode, probs->inter_mode,
-	       sizeof(rkprobs->inter_mode));
-	memcpy(rkprobs->interp_filter, probs->interp_filter,
-	       sizeof(rkprobs->interp_filter));
-
-	/* 128 x 128 bits coeff related */
-	for (i = 0; i < ARRAY_SIZE(probs->coef); i++) {
-		for (j = 0; j < ARRAY_SIZE(probs->coef[0]); j++) {
-			for (k = 0; k < ARRAY_SIZE(probs->coef[0][0]); k++)
-				write_coeff_plane(probs->coef[i][j][k],
-						  rkprobs->coef[k][i][j]);
-		}
-	}
-
-	/* intra uv mode 6 x 128 */
-	memcpy(rkprobs->uv_mode_0_2, &probs->uv_mode[0],
-	       sizeof(rkprobs->uv_mode_0_2));
-	memcpy(rkprobs->uv_mode_3_5, &probs->uv_mode[3],
-	       sizeof(rkprobs->uv_mode_3_5));
-	memcpy(rkprobs->uv_mode_6_8, &probs->uv_mode[6],
-	       sizeof(rkprobs->uv_mode_6_8));
-	memcpy(rkprobs->uv_mode_9, &probs->uv_mode[9],
-	       sizeof(rkprobs->uv_mode_9));
-
-	/* mv related 6 x 128 */
-	memcpy(rkprobs->mv.joint, probs->mv.joint,
-	       sizeof(rkprobs->mv.joint));
-	memcpy(rkprobs->mv.sign, probs->mv.sign,
-	       sizeof(rkprobs->mv.sign));
-	memcpy(rkprobs->mv.classes, probs->mv.classes,
-	       sizeof(rkprobs->mv.classes));
-	memcpy(rkprobs->mv.class0_bit, probs->mv.class0_bit,
-	       sizeof(rkprobs->mv.class0_bit));
-	memcpy(rkprobs->mv.bits, probs->mv.bits,
-	       sizeof(rkprobs->mv.bits));
-	memcpy(rkprobs->mv.class0_fr, probs->mv.class0_fr,
-	       sizeof(rkprobs->mv.class0_fr));
-	memcpy(rkprobs->mv.fr, probs->mv.fr,
-	       sizeof(rkprobs->mv.fr));
-	memcpy(rkprobs->mv.class0_hp, probs->mv.class0_hp,
-	       sizeof(rkprobs->mv.class0_hp));
-	memcpy(rkprobs->mv.hp, probs->mv.hp,
-	       sizeof(rkprobs->mv.hp));
-}
-
-static void init_probs(struct rkvdec_ctx *ctx,
-		       const struct rkvdec_vp9_run *run)
-{
-	const struct v4l2_ctrl_vp9_frame *dec_params;
-	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
-	struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
-	struct rkvdec_vp9_probs *rkprobs = &tbl->probs;
-	const struct v4l2_vp9_segmentation *seg;
-	const struct v4l2_vp9_frame_context_rs *probs;
-	bool intra_only;
-
-	dec_params = run->decode_params;
-	probs = &vp9_ctx->probability_tables;
-	seg = &dec_params->seg;
-
-	memset(rkprobs, 0, sizeof(*rkprobs));
-
-	intra_only = !!(dec_params->flags &
-			(V4L2_VP9_FRAME_FLAG_KEY_FRAME |
-			 V4L2_VP9_FRAME_FLAG_INTRA_ONLY));
-
-	/* sb info  5 x 128 bit */
-	memcpy(rkprobs->partition,
-	       intra_only ? v4l2_vp9_kf_partition_probs_rs : probs->partition,
-	       sizeof(rkprobs->partition));
-
-	memcpy(rkprobs->pred, seg->pred_probs, sizeof(rkprobs->pred));
-	memcpy(rkprobs->tree, seg->tree_probs, sizeof(rkprobs->tree));
-	memcpy(rkprobs->skip, probs->skip, sizeof(rkprobs->skip));
-	memcpy(rkprobs->tx32, probs->tx32, sizeof(rkprobs->tx32));
-	memcpy(rkprobs->tx16, probs->tx16, sizeof(rkprobs->tx16));
-	memcpy(rkprobs->tx8, probs->tx8, sizeof(rkprobs->tx8));
-	memcpy(rkprobs->is_inter, probs->is_inter, sizeof(rkprobs->is_inter));
-
-	if (intra_only)
-		init_intra_only_probs(ctx, run);
-	else
-		init_inter_probs(ctx, run);
-}
-
 struct rkvdec_vp9_ref_reg {
 	u32 reg_frm_size;
 	u32 reg_hor_stride;
@@ -355,30 +114,6 @@ struct rkvdec_vp9_ref_reg {
 	u32 reg_ref_base;
 };
 
-static struct rkvdec_vp9_ref_reg ref_regs[] = {
-	{
-		.reg_frm_size = RKVDEC_REG_VP9_FRAME_SIZE(0),
-		.reg_hor_stride = RKVDEC_VP9_HOR_VIRSTRIDE(0),
-		.reg_y_stride = RKVDEC_VP9_LAST_FRAME_YSTRIDE,
-		.reg_yuv_stride = RKVDEC_VP9_LAST_FRAME_YUVSTRIDE,
-		.reg_ref_base = RKVDEC_REG_VP9_LAST_FRAME_BASE,
-	},
-	{
-		.reg_frm_size = RKVDEC_REG_VP9_FRAME_SIZE(1),
-		.reg_hor_stride = RKVDEC_VP9_HOR_VIRSTRIDE(1),
-		.reg_y_stride = RKVDEC_VP9_GOLDEN_FRAME_YSTRIDE,
-		.reg_yuv_stride = 0,
-		.reg_ref_base = RKVDEC_REG_VP9_GOLDEN_FRAME_BASE,
-	},
-	{
-		.reg_frm_size = RKVDEC_REG_VP9_FRAME_SIZE(2),
-		.reg_hor_stride = RKVDEC_VP9_HOR_VIRSTRIDE(2),
-		.reg_y_stride = RKVDEC_VP9_ALTREF_FRAME_YSTRIDE,
-		.reg_yuv_stride = 0,
-		.reg_ref_base = RKVDEC_REG_VP9_ALTREF_FRAME_BASE,
-	}
-};
-
 static struct rkvdec_decoded_buffer *
 get_ref_buf(struct rkvdec_ctx *ctx, struct vb2_v4l2_buffer *dst, u64 timestamp)
 {
@@ -409,84 +144,6 @@ static dma_addr_t get_mv_base_addr(struct rkvdec_decoded_buffer *buf)
 	       yuv_len;
 }
 
-static void config_ref_registers(struct rkvdec_ctx *ctx,
-				 const struct rkvdec_vp9_run *run,
-				 struct rkvdec_decoded_buffer *ref_buf,
-				 struct rkvdec_vp9_ref_reg *ref_reg)
-{
-	unsigned int aligned_pitch, aligned_height, y_len, yuv_len;
-	struct rkvdec_dev *rkvdec = ctx->dev;
-
-	aligned_height = round_up(ref_buf->vp9.height, 64);
-	writel_relaxed(RKVDEC_VP9_FRAMEWIDTH(ref_buf->vp9.width) |
-		       RKVDEC_VP9_FRAMEHEIGHT(ref_buf->vp9.height),
-		       rkvdec->regs + ref_reg->reg_frm_size);
-
-	writel_relaxed(vb2_dma_contig_plane_dma_addr(&ref_buf->base.vb.vb2_buf, 0),
-		       rkvdec->regs + ref_reg->reg_ref_base);
-
-	if (&ref_buf->base.vb == run->base.bufs.dst)
-		return;
-
-	aligned_pitch = round_up(ref_buf->vp9.width * ref_buf->vp9.bit_depth, 512) / 8;
-	y_len = aligned_height * aligned_pitch;
-	yuv_len = (y_len * 3) / 2;
-
-	writel_relaxed(RKVDEC_HOR_Y_VIRSTRIDE(aligned_pitch / 16) |
-		       RKVDEC_HOR_UV_VIRSTRIDE(aligned_pitch / 16),
-		       rkvdec->regs + ref_reg->reg_hor_stride);
-	writel_relaxed(RKVDEC_VP9_REF_YSTRIDE(y_len / 16),
-		       rkvdec->regs + ref_reg->reg_y_stride);
-
-	if (!ref_reg->reg_yuv_stride)
-		return;
-
-	writel_relaxed(RKVDEC_VP9_REF_YUVSTRIDE(yuv_len / 16),
-		       rkvdec->regs + ref_reg->reg_yuv_stride);
-}
-
-static void config_seg_registers(struct rkvdec_ctx *ctx, unsigned int segid)
-{
-	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
-	struct v4l2_vp9_segmentation *seg;
-	struct rkvdec_dev *rkvdec = ctx->dev;
-	s16 feature_val;
-	int feature_id;
-	u32 val = 0;
-
-	seg = vp9_ctx->last.valid ? &vp9_ctx->last.seg : &vp9_ctx->cur.seg;
-	feature_id = V4L2_VP9_SEG_LVL_ALT_Q;
-	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid)) {
-		feature_val = seg->feature_data[segid][feature_id];
-		val |= RKVDEC_SEGID_FRAME_QP_DELTA_EN(1) |
-		       RKVDEC_SEGID_FRAME_QP_DELTA(feature_val);
-	}
-
-	feature_id = V4L2_VP9_SEG_LVL_ALT_L;
-	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid)) {
-		feature_val = seg->feature_data[segid][feature_id];
-		val |= RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE_EN(1) |
-		       RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE(feature_val);
-	}
-
-	feature_id = V4L2_VP9_SEG_LVL_REF_FRAME;
-	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid)) {
-		feature_val = seg->feature_data[segid][feature_id];
-		val |= RKVDEC_SEGID_REFERINFO_EN(1) |
-		       RKVDEC_SEGID_REFERINFO(feature_val);
-	}
-
-	feature_id = V4L2_VP9_SEG_LVL_SKIP;
-	if (v4l2_vp9_seg_feat_enabled_rs(&seg->feature_enabled, feature_id, segid))
-		val |= RKVDEC_SEGID_FRAME_SKIP_EN(1);
-
-	if (!segid &&
-	    (seg->flags & V4L2_VP9_SEGMENTATION_FLAG_ABS_OR_DELTA_UPDATE))
-		val |= RKVDEC_SEGID_ABS_DELTA(1);
-
-	writel_relaxed(val, rkvdec->regs + RKVDEC_VP9_SEGID_GRP(segid));
-}
-
 static void update_dec_buf_info(struct rkvdec_decoded_buffer *buf,
 				const struct v4l2_ctrl_vp9_frame *dec_params)
 {
@@ -516,17 +173,11 @@ static void update_ctx_last_info(struct rkvdec_vp9_ctx *vp9_ctx)
 static void config_registers(struct rkvdec_ctx *ctx,
 			     const struct rkvdec_vp9_run *run)
 {
-	unsigned int y_len, uv_len, yuv_len, bit_depth, aligned_height, aligned_pitch, stream_len;
 	const struct v4l2_ctrl_vp9_frame *dec_params;
 	struct rkvdec_decoded_buffer *ref_bufs[3];
 	struct rkvdec_decoded_buffer *dst, *last, *mv_ref;
 	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
-	u32 val, last_frame_info = 0;
-	const struct v4l2_vp9_segmentation *seg;
-	struct rkvdec_dev *rkvdec = ctx->dev;
-	dma_addr_t addr;
 	bool intra_only;
-	unsigned int i;
 
 	dec_params = run->decode_params;
 	dst = vb2_to_rkvdec_decoded_buf(&run->base.bufs.dst->vb2_buf);
@@ -541,36 +192,17 @@ static void config_registers(struct rkvdec_ctx *ctx,
 
 	update_dec_buf_info(dst, dec_params);
 	update_ctx_cur_info(vp9_ctx, dst, dec_params);
-	seg = &dec_params->seg;
 
 	intra_only = !!(dec_params->flags &
 			(V4L2_VP9_FRAME_FLAG_KEY_FRAME |
 			 V4L2_VP9_FRAME_FLAG_INTRA_ONLY));
 
-	writel_relaxed(RKVDEC_MODE(RKVDEC_MODE_VP9),
-		       rkvdec->regs + RKVDEC_REG_SYSCTRL);
-
-	bit_depth = dec_params->bit_depth;
-	aligned_height = round_up(ctx->decoded_fmt.fmt.pix_mp.height, 64);
-
-	aligned_pitch = round_up(ctx->decoded_fmt.fmt.pix_mp.width *
-				 bit_depth,
-				 512) / 8;
-	y_len = aligned_height * aligned_pitch;
-	uv_len = y_len / 2;
-	yuv_len = y_len + uv_len;
-
-	writel_relaxed(RKVDEC_Y_HOR_VIRSTRIDE(aligned_pitch / 16) |
-		       RKVDEC_UV_HOR_VIRSTRIDE(aligned_pitch / 16),
-		       rkvdec->regs + RKVDEC_REG_PICPAR);
-	writel_relaxed(RKVDEC_Y_VIRSTRIDE(y_len / 16),
-		       rkvdec->regs + RKVDEC_REG_Y_VIRSTRIDE);
-	writel_relaxed(RKVDEC_YUV_VIRSTRIDE(yuv_len / 16),
-		       rkvdec->regs + RKVDEC_REG_YUV_VIRSTRIDE);
-
-	stream_len = vb2_get_plane_payload(&run->base.bufs.src->vb2_buf, 0);
-	writel_relaxed(RKVDEC_STRM_LEN(stream_len),
-		       rkvdec->regs + RKVDEC_REG_STRM_LEN);
+	if (!intra_only &&
+	    !(dec_params->flags & V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT) &&
+	    vp9_ctx->last.valid)
+		mv_ref = last;
+	else
+		mv_ref = dst;
 
 	/*
 	 * Reset count buffer, because decoder only output intra related syntax
@@ -583,114 +215,110 @@ static void config_registers(struct rkvdec_ctx *ctx,
 	vp9_ctx->cur.segmapid = vp9_ctx->last.segmapid;
 	if (!intra_only &&
 	    !(dec_params->flags & V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT) &&
-	    (!(seg->flags & V4L2_VP9_SEGMENTATION_FLAG_ENABLED) ||
-	     (seg->flags & V4L2_VP9_SEGMENTATION_FLAG_UPDATE_MAP)))
+	    (!(dec_params->seg.flags & V4L2_VP9_SEGMENTATION_FLAG_ENABLED) ||
+	     (dec_params->seg.flags & V4L2_VP9_SEGMENTATION_FLAG_UPDATE_MAP)))
 		vp9_ctx->cur.segmapid++;
 
-	for (i = 0; i < ARRAY_SIZE(ref_bufs); i++)
-		config_ref_registers(ctx, run, ref_bufs[i], &ref_regs[i]);
-
-	for (i = 0; i < 8; i++)
-		config_seg_registers(ctx, i);
-
-	writel_relaxed(RKVDEC_VP9_TX_MODE(vp9_ctx->cur.tx_mode) |
-		       RKVDEC_VP9_FRAME_REF_MODE(dec_params->reference_mode),
-		       rkvdec->regs + RKVDEC_VP9_CPRHEADER_CONFIG);
-
-	if (!intra_only) {
-		const struct v4l2_vp9_loop_filter *lf;
-		s8 delta;
-
-		if (vp9_ctx->last.valid)
-			lf = &vp9_ctx->last.lf;
-		else
-			lf = &vp9_ctx->cur.lf;
-
-		val = 0;
-		for (i = 0; i < ARRAY_SIZE(lf->ref_deltas); i++) {
-			delta = lf->ref_deltas[i];
-			val |= RKVDEC_REF_DELTAS_LASTFRAME(i, delta);
-		}
-
-		writel_relaxed(val,
-			       rkvdec->regs + RKVDEC_VP9_REF_DELTAS_LASTFRAME);
-
-		for (i = 0; i < ARRAY_SIZE(lf->mode_deltas); i++) {
-			delta = lf->mode_deltas[i];
-			last_frame_info |= RKVDEC_MODE_DELTAS_LASTFRAME(i,
-									delta);
-		}
-	}
-
-	if (vp9_ctx->last.valid && !intra_only &&
-	    vp9_ctx->last.seg.flags & V4L2_VP9_SEGMENTATION_FLAG_ENABLED)
-		last_frame_info |= RKVDEC_SEG_EN_LASTFRAME;
-
-	if (vp9_ctx->last.valid &&
-	    vp9_ctx->last.flags & V4L2_VP9_FRAME_FLAG_SHOW_FRAME)
-		last_frame_info |= RKVDEC_LAST_SHOW_FRAME;
-
-	if (vp9_ctx->last.valid &&
-	    vp9_ctx->last.flags &
-	    (V4L2_VP9_FRAME_FLAG_KEY_FRAME | V4L2_VP9_FRAME_FLAG_INTRA_ONLY))
-		last_frame_info |= RKVDEC_LAST_INTRA_ONLY;
-
-	if (vp9_ctx->last.valid &&
-	    last->vp9.width == dst->vp9.width &&
-	    last->vp9.height == dst->vp9.height)
-		last_frame_info |= RKVDEC_LAST_WIDHHEIGHT_EQCUR;
-
-	writel_relaxed(last_frame_info,
-		       rkvdec->regs + RKVDEC_VP9_INFO_LASTFRAME);
-
-	writel_relaxed(stream_len - dec_params->compressed_header_size -
-		       dec_params->uncompressed_header_size,
-		       rkvdec->regs + RKVDEC_VP9_LASTTILE_SIZE);
-
-	for (i = 0; !intra_only && i < ARRAY_SIZE(ref_bufs); i++) {
-		unsigned int refw = ref_bufs[i]->vp9.width;
-		unsigned int refh = ref_bufs[i]->vp9.height;
-		u32 hscale, vscale;
-
-		hscale = (refw << 14) /	dst->vp9.width;
-		vscale = (refh << 14) / dst->vp9.height;
-		writel_relaxed(RKVDEC_VP9_REF_HOR_SCALE(hscale) |
-			       RKVDEC_VP9_REF_VER_SCALE(vscale),
-			       rkvdec->regs + RKVDEC_VP9_REF_SCALE(i));
-	}
-
-	addr = vb2_dma_contig_plane_dma_addr(&dst->base.vb.vb2_buf, 0);
-	writel_relaxed(addr, rkvdec->regs + RKVDEC_REG_DECOUT_BASE);
-	addr = vb2_dma_contig_plane_dma_addr(&run->base.bufs.src->vb2_buf, 0);
-	writel_relaxed(addr, rkvdec->regs + RKVDEC_REG_STRM_RLC_BASE);
-	writel_relaxed(vp9_ctx->priv_tbl.dma +
-		       offsetof(struct rkvdec_vp9_priv_tbl, probs),
-		       rkvdec->regs + RKVDEC_REG_CABACTBL_PROB_BASE);
-	writel_relaxed(vp9_ctx->count_tbl.dma,
-		       rkvdec->regs + RKVDEC_REG_VP9COUNT_BASE);
-
-	writel_relaxed(vp9_ctx->priv_tbl.dma +
+	/* pack everything that Rust needs in order to run */
+	struct rkvdec_rs_run rkvdec_rs_run = {
+		.base = {
+			{
+				.width = ctx->decoded_fmt.fmt.pix_mp.width,
+				.height = ctx->decoded_fmt.fmt.pix_mp.height,
+			}
+		},
+		.decode_params = dec_params,
+		.hw_probs = &((struct rkvdec_vp9_priv_tbl *)vp9_ctx->priv_tbl.cpu)->probs,
+		.probability_tables = &vp9_ctx->probability_tables,
+		.src_address = vb2_dma_contig_plane_dma_addr(&run->base.bufs.src->vb2_buf, 0),
+		.probs_address = vp9_ctx->priv_tbl.dma + offsetof(struct rkvdec_vp9_priv_tbl, probs),
+		.count_base_address = vp9_ctx->count_tbl.dma,
+		.segid_cur_base_address = vp9_ctx->priv_tbl.dma +
 		       offsetof(struct rkvdec_vp9_priv_tbl, segmap) +
 		       (RKVDEC_VP9_MAX_SEGMAP_SIZE * vp9_ctx->cur.segmapid),
-		       rkvdec->regs + RKVDEC_REG_VP9_SEGIDCUR_BASE);
-	writel_relaxed(vp9_ctx->priv_tbl.dma +
+		.segid_last_base_address = vp9_ctx->priv_tbl.dma +
 		       offsetof(struct rkvdec_vp9_priv_tbl, segmap) +
 		       (RKVDEC_VP9_MAX_SEGMAP_SIZE * (!vp9_ctx->cur.segmapid)),
-		       rkvdec->regs + RKVDEC_REG_VP9_SEGIDLAST_BASE);
-
-	if (!intra_only &&
-	    !(dec_params->flags & V4L2_VP9_FRAME_FLAG_ERROR_RESILIENT) &&
-	    vp9_ctx->last.valid)
-		mv_ref = last;
-	else
-		mv_ref = dst;
-
-	writel_relaxed(get_mv_base_addr(mv_ref),
-		       rkvdec->regs + RKVDEC_VP9_REF_COLMV_BASE);
+		.motion_vectors_base_address = get_mv_base_addr(mv_ref),
+		.dst = {
+			.resolution = {
+				.width = dst->vp9.width,
+				.height = dst->vp9.height,
+			},
+			.bit_depth = dst->vp9.bit_depth,
+			.same_as_dst = true,
+			.dma_address = vb2_dma_contig_plane_dma_addr(&dst->base.vb.vb2_buf, 0),
+		},
+		.ref_bufs = {
+			[0] = {
+				{
+					.width = ref_bufs[0]->vp9.width,
+					.height = ref_bufs[0]->vp9.height,
+
+				},
+				.bit_depth = ref_bufs[0]->vp9.bit_depth,
+				.same_as_dst = (&ref_bufs[0]->base.vb == run->base.bufs.dst),
+				.dma_address = vb2_dma_contig_plane_dma_addr(&ref_bufs[0]->base.vb.vb2_buf, 0),
+			},
+			[1] = {
+				{
+					.width = ref_bufs[1]->vp9.width,
+					.height = ref_bufs[1]->vp9.height,
+
+				},
+				.bit_depth = ref_bufs[1]->vp9.bit_depth,
+				.same_as_dst = (&ref_bufs[1]->base.vb == run->base.bufs.dst),
+				.dma_address = vb2_dma_contig_plane_dma_addr(&ref_bufs[1]->base.vb.vb2_buf, 0),
+			},
+			[2] = {
+				{
+					.width = ref_bufs[2]->vp9.width,
+					.height = ref_bufs[2]->vp9.height,
+
+				},
+				.bit_depth = ref_bufs[2]->vp9.bit_depth,
+				.same_as_dst = (&ref_bufs[2]->base.vb == run->base.bufs.dst),
+				.dma_address = vb2_dma_contig_plane_dma_addr(&ref_bufs[2]->base.vb.vb2_buf, 0),
+			}
+		},
+		.last = {
+			.resolution = {
+				.width = last->vp9.width,
+				.height = last->vp9.height,
+			},
+			.bit_depth = last->vp9.bit_depth,
+			.same_as_dst = (&last->base.vb == run->base.bufs.dst),
+			.dma_address = vb2_dma_contig_plane_dma_addr(&last->base.vb.vb2_buf, 0),
+		},
+
+		.stream_len = vb2_get_plane_payload(&run->base.bufs.src->vb2_buf, 0),
+		.cur_frame_info = {
+			.valid = vp9_ctx->cur.valid,
+			.frame_context_idx = vp9_ctx->cur.frame_context_idx,
+			.reference_mode = vp9_ctx->cur.reference_mode,
+			.tx_mode = vp9_ctx->cur.tx_mode,
+			.interpolation_filter = vp9_ctx->cur.interpolation_filter,
+			.flags = vp9_ctx->cur.flags,
+			.timestamp = vp9_ctx->cur.timestamp,
+			.seg = vp9_ctx->cur.seg,
+			.lf = vp9_ctx->cur.lf,
+		},
+		.last_frame_info = {
+			.valid = vp9_ctx->last.valid,
+			.frame_context_idx = vp9_ctx->last.frame_context_idx,
+			.reference_mode = vp9_ctx->last.reference_mode,
+			.tx_mode = vp9_ctx->last.tx_mode,
+			.interpolation_filter = vp9_ctx->last.interpolation_filter,
+			.flags = vp9_ctx->last.flags,
+			.timestamp = vp9_ctx->last.timestamp,
+			.seg = vp9_ctx->last.seg,
+			.lf = vp9_ctx->last.lf,
+		},
+		.regs = ctx->dev->regs,
+	};
 
-	writel_relaxed(ctx->decoded_fmt.fmt.pix_mp.width |
-		       (ctx->decoded_fmt.fmt.pix_mp.height << 16),
-		       rkvdec->regs + RKVDEC_REG_PERFORMANCE_CYCLE);
+	rkvdec_rs_vp9_init_probs(&rkvdec_rs_run);
+	rkvdec_rs_vp9_config_registers(&rkvdec_rs_run);
 }
 
 static int validate_dec_params(struct rkvdec_ctx *ctx,
@@ -810,9 +438,6 @@ static int rkvdec_vp9_run(struct rkvdec_ctx *ctx)
 		return ret;
 	}
 
-	/* Prepare probs. */
-	init_probs(ctx, &run);
-
 	/* Configure hardware registers. */
 	config_registers(ctx, &run);
 
diff --git a/drivers/staging/media/rkvdec/rkvdec_rs.h b/drivers/staging/media/rkvdec/rkvdec_rs.h
new file mode 100644
index 000000000000..207d0020546c
--- /dev/null
+++ b/drivers/staging/media/rkvdec/rkvdec_rs.h
@@ -0,0 +1,125 @@
+#ifndef RKVDEC_RS_H
+#define RKVDEC_RS_H
+
+/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-vp9-rs.h>
+#include <linux/types.h>
+
+struct rkvdec_rs_resolution {
+  uint32_t width;
+  uint32_t height;
+};
+
+struct rkvdec_rs_base_run {
+  struct rkvdec_rs_resolution decoded_resolution;
+};
+
+struct  rkvdec_rs_vp9_mv {
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
+struct  rkvdec_rs_vp9_inter_frame_probs {
+  uint8_t y_mode[4][9];
+  uint8_t comp_mode[5];
+  uint8_t comp_ref[5];
+  uint8_t single_ref[5][2];
+  uint8_t inter_mode[7][3];
+  uint8_t interp_filter[4][2];
+  uint8_t padding0[11];
+  uint8_t coef[2][4][2][128];
+  uint8_t uv_mode_0_2[3][9];
+  uint8_t padding1[5];
+  uint8_t uv_mode_3_5[3][9];
+  uint8_t padding2[5];
+  uint8_t uv_mode_6_8[3][9];
+  uint8_t padding3[5];
+  uint8_t uv_mode_9[9];
+  uint8_t padding4[7];
+  uint8_t padding5[16];
+  struct  rkvdec_rs_vp9_mv mv;
+};
+
+struct  rkvdec_rs_vp9_intra_mode_probs {
+  uint8_t y_mode[105];
+  uint8_t uv_mode[23];
+};
+
+struct  rkvdec_rs_vp9_intra_only_frame_probs {
+  uint8_t coef_intra[4][2][128];
+  struct  rkvdec_rs_vp9_intra_mode_probs intra_mode[10];
+};
+
+union  rkvdec_rs_vp9_frame_probs {
+  struct  rkvdec_rs_vp9_inter_frame_probs inter;
+  struct  rkvdec_rs_vp9_intra_only_frame_probs intra_only;
+};
+
+struct  rkvdec_rs_vp9_probs {
+  uint8_t partition[16][3];
+  uint8_t pred[3];
+  uint8_t tree[7];
+  uint8_t skip[3];
+  uint8_t tx32[2][3];
+  uint8_t tx16[2][2];
+  uint8_t tx8[2][1];
+  uint8_t is_inter[4];
+  uint8_t padding0[3];
+  union  rkvdec_rs_vp9_frame_probs frame_probs;
+  uint8_t padding1[11];
+};
+
+struct rkvdec_rs_decoded_buffer_info {
+  struct rkvdec_rs_resolution resolution;
+  uint8_t bit_depth;
+  bool same_as_dst;
+  dma_addr_t dma_address;
+};
+
+struct rkvdec_rs_frame_info {
+  bool valid;
+  uint8_t segmapid;
+  uint8_t frame_context_idx;
+  uint8_t reference_mode;
+  uint8_t tx_mode;
+  uint8_t interpolation_filter;
+  uint32_t flags;
+  uint64_t timestamp;
+  struct v4l2_vp9_segmentation seg;
+  struct v4l2_vp9_loop_filter lf;
+};
+
+struct rkvdec_rs_run {
+  struct rkvdec_rs_base_run base;
+  const struct v4l2_ctrl_vp9_frame *decode_params;
+  struct  rkvdec_rs_vp9_probs *hw_probs;
+  const struct v4l2_vp9_frame_context_rs *probability_tables;
+  dma_addr_t src_address;
+  dma_addr_t probs_address;
+  dma_addr_t count_base_address;
+  dma_addr_t segid_cur_base_address;
+  dma_addr_t segid_last_base_address;
+  dma_addr_t motion_vectors_base_address;
+  struct rkvdec_rs_decoded_buffer_info dst;
+  struct rkvdec_rs_decoded_buffer_info ref_bufs[3];
+  struct rkvdec_rs_decoded_buffer_info last;
+  uint32_t stream_len;
+  struct rkvdec_rs_frame_info cur_frame_info;
+  struct rkvdec_rs_frame_info last_frame_info;
+  void *regs;
+};
+
+void rkvdec_rs_vp9_init_probs(struct rkvdec_rs_run *run);
+
+void rkvdec_rs_vp9_config_registers(struct rkvdec_rs_run *run);
+
+#endif /* RKVDEC_RS_H */
diff --git a/drivers/staging/media/rkvdec/rkvdec_rs.rs b/drivers/staging/media/rkvdec/rkvdec_rs.rs
new file mode 100644
index 000000000000..a7a48b203225
--- /dev/null
+++ b/drivers/staging/media/rkvdec/rkvdec_rs.rs
@@ -0,0 +1,14 @@
+#![allow(missing_docs, unused_imports)]
+
+use kernel::prelude::*;
+
+const __LOG_PREFIX: &[u8] = b"rkvdec_rs\0";
+pub(crate) mod vp9;
+mod common;
+mod regs;
+
+macro_rules! round_up {
+    ($x:expr, $v:expr) => ((($x - 1) | ($v - 1)) + 1)
+}
+
+pub(crate) use round_up;
diff --git a/drivers/staging/media/rkvdec/vp9.rs b/drivers/staging/media/rkvdec/vp9.rs
new file mode 100644
index 000000000000..74ea33eedc4c
--- /dev/null
+++ b/drivers/staging/media/rkvdec/vp9.rs
@@ -0,0 +1,636 @@
+#![allow(missing_docs)]
+
+use crate::common;
+use crate::regs;
+use crate::round_up;
+use kernel::bindings;
+use kernel::media::v4l2_core::vp9;
+
+#[repr(C)]
+#[derive(Debug)]
+struct DecodedBufferInfo {
+    resolution: common::Resolution,
+    bit_depth: u8,
+    same_as_dst: bool,
+    dma_address: bindings::dma_addr_t,
+}
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+struct IntraModeProbs {
+    y_mode: [u8; 105],
+    uv_mode: [u8; 23],
+}
+
+impl Default for IntraModeProbs {
+    fn default() -> Self {
+        Self {
+            y_mode: [0; 105],
+            uv_mode: [0; 23],
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+struct IntraOnlyFrameProbs {
+    coef_intra: [[[u8; 128]; 2]; 4],
+    intra_mode: [IntraModeProbs; 10],
+}
+
+impl Default for IntraOnlyFrameProbs {
+    fn default() -> Self {
+        Self {
+            coef_intra: [[[0; 128]; 2]; 4],
+            intra_mode: [IntraModeProbs::default(); 10],
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+struct Mv {
+    joint: [u8; 3],
+    sign: [u8; 2],
+    classes: [[u8; 10]; 2],
+    class0_bit: [u8; 2],
+    bits: [[u8; 10]; 2],
+    class0_fr: [[[u8; 3]; 2]; 2],
+    fr: [[u8; 3]; 2],
+    class0_hp: [u8; 2],
+    hp: [u8; 2],
+}
+
+impl Default for Mv {
+    fn default() -> Self {
+        Self {
+            joint: [0; 3],
+            sign: [0; 2],
+            classes: [[0; 10]; 2],
+            class0_bit: [0; 2],
+            bits: [[0; 10]; 2],
+            class0_fr: [[[0; 3]; 2]; 2],
+            fr: [[0; 3]; 2],
+            class0_hp: [0; 2],
+            hp: [0; 2],
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+struct InterFrameProbs {
+    y_mode: [[u8; 9]; 4],
+    comp_mode: [u8; 5],
+    comp_ref: [u8; 5],
+    single_ref: [[u8; 2]; 5],
+    inter_mode: [[u8; 3]; 7],
+    interp_filter: [[u8; 2]; 4],
+    padding0: [u8; 11],
+    coef: [[[[u8; 128]; 2]; 4]; 2],
+    uv_mode_0_2: [[u8; 9]; 3],
+    padding1: [u8; 5],
+    uv_mode_3_5: [[u8; 9]; 3],
+    padding2: [u8; 5],
+    uv_mode_6_8: [[u8; 9]; 3],
+    padding3: [u8; 5],
+    uv_mode_9: [u8; 9],
+    padding4: [u8; 7],
+    padding5: [u8; 16],
+    mv: Mv,
+}
+
+impl Default for InterFrameProbs {
+    fn default() -> Self {
+        Self {
+            y_mode: [[0; 9]; 4],
+            comp_mode: [0; 5],
+            comp_ref: [0; 5],
+            single_ref: [[0; 2]; 5],
+            inter_mode: [[0; 3]; 7],
+            interp_filter: [[0; 2]; 4],
+            padding0: [0; 11],
+            coef: [[[[0; 128]; 2]; 4]; 2],
+            uv_mode_0_2: [[0; 9]; 3],
+            padding1: [0; 5],
+            uv_mode_3_5: [[0; 9]; 3],
+            padding2: [0; 5],
+            uv_mode_6_8: [[0; 9]; 3],
+            padding3: [0; 5],
+            uv_mode_9: [0; 9],
+            padding4: [0; 7],
+            padding5: [0; 16],
+            mv: Mv::default(),
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Copy, Clone)]
+struct HwProbs {
+    partition: [[u8; 3]; 16],
+    pred: [u8; 3],
+    tree: [u8; 7],
+    skip: [u8; 3],
+    tx32: [[u8; 3]; 2],
+    tx16: [[u8; 2]; 2],
+    tx8: [[u8; 1]; 2],
+    is_inter: [u8; 4],
+    padding0: [u8; 3],
+    frame_probs: FrameProbs,
+    padding1: [u8; 11],
+}
+
+impl Default for HwProbs {
+    fn default() -> Self {
+        Self {
+            partition: [[0; 3]; 16],
+            pred: [0; 3],
+            tree: [0; 7],
+            skip: [0; 3],
+            tx32: [[0; 3]; 2],
+            tx16: [[0; 2]; 2],
+            tx8: [[0; 1]; 2],
+            is_inter: [0; 4],
+            padding0: [0; 3],
+            frame_probs: FrameProbs {
+                inter: InterFrameProbs::default(),
+            },
+            padding1: [0; 11],
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Copy, Clone)]
+union FrameProbs {
+    inter: InterFrameProbs,
+    intra_only: IntraOnlyFrameProbs,
+}
+
+#[repr(C)]
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+struct RefReg {
+    reg_frm_size: u32,
+    reg_hor_stride: u32,
+    reg_y_stride: u32,
+    reg_yuv_stride: u32,
+    reg_ref_base: u32,
+}
+
+static REF_REGS: [RefReg; 3] = {
+    [
+        RefReg {
+            reg_frm_size: regs::RKVDEC_REG_VP9_FRAME_SIZE!(0),
+            reg_hor_stride: regs::RKVDEC_VP9_HOR_VIRSTRIDE!(0),
+            reg_y_stride: regs::RKVDEC_VP9_LAST_FRAME_YSTRIDE,
+            reg_yuv_stride: regs::RKVDEC_VP9_LAST_FRAME_YUVSTRIDE,
+            reg_ref_base: regs::RKVDEC_REG_VP9_LAST_FRAME_BASE,
+        },
+        RefReg {
+            reg_frm_size: regs::RKVDEC_REG_VP9_FRAME_SIZE!(1),
+            reg_hor_stride: regs::RKVDEC_VP9_HOR_VIRSTRIDE!(1),
+            reg_y_stride: regs::RKVDEC_VP9_GOLDEN_FRAME_YSTRIDE,
+            reg_yuv_stride: 0,
+            reg_ref_base: regs::RKVDEC_REG_VP9_GOLDEN_FRAME_BASE,
+        },
+        RefReg {
+            reg_frm_size: regs::RKVDEC_REG_VP9_FRAME_SIZE!(2),
+            reg_hor_stride: regs::RKVDEC_VP9_HOR_VIRSTRIDE!(2),
+            reg_y_stride: regs::RKVDEC_VP9_ALTREF_FRAME_YSTRIDE,
+            reg_yuv_stride: 0,
+            reg_ref_base: regs::RKVDEC_REG_VP9_ALTREF_FRAME_BASE,
+        },
+    ]
+};
+
+#[repr(C)]
+struct FrameInfo {
+    valid: bool,
+    segmapid: u8,
+    frame_context_idx: u8,
+    reference_mode: u8,
+    tx_mode: u8,
+    interpolation_filter: u8,
+    flags: u32,
+    timestamp: u64,
+    seg: bindings::v4l2_vp9_segmentation,
+    lf: bindings::v4l2_vp9_loop_filter,
+}
+
+#[repr(C)]
+pub(crate) struct Run<'a> {
+    base: crate::common::BaseRun,
+    decode_params: &'a bindings::v4l2_ctrl_vp9_frame,
+    hw_probs: &'a mut HwProbs,
+    probability_tables: &'a vp9::FrameContext,
+    src_address: bindings::dma_addr_t,
+    probs_address: bindings::dma_addr_t,
+    count_base_address: bindings::dma_addr_t,
+    segid_cur_base_address: bindings::dma_addr_t,
+    segid_last_base_address: bindings::dma_addr_t,
+    motion_vectors_base_address: bindings::dma_addr_t,
+    dst: DecodedBufferInfo,
+    ref_bufs: [DecodedBufferInfo; 3],
+    last: DecodedBufferInfo,
+    stream_len: u32,
+    cur_frame_info: FrameInfo,
+    last_frame_info: FrameInfo,
+    regs: *mut core::ffi::c_void,
+}
+
+impl<'a> Run<'a> {
+    fn write_register(&self, val: impl Into<u32>, offset: u32) {
+        if offset > regs::RKVDEC_REG_PREF_CHR_CACHE_COMMAND {
+            kernel::pr_warn!(
+                "Invalid register offset: 0x{:x}, ignoring\n",
+                offset as usize
+            );
+            return;
+        }
+
+        // Safety: if we're here, C has mapped this range for us. So long as we
+        // write within it, we are safe.
+        unsafe {
+            let addr = self.regs.add(offset as usize);
+            bindings::writel_relaxed(val.into(), addr);
+        }
+    }
+
+    fn write_coeff_plane(coef: &[[[u8; 3]; 6]; 6], coef_plane: &mut [u8; 128]) {
+        let mut idx = 0;
+        let mut byte_count = 0;
+        for coef in coef.iter().flatten().flatten() {
+            coef_plane[idx] = *coef;
+            idx += 1;
+            byte_count += 1;
+
+            if byte_count == 27 {
+                idx += 5;
+                byte_count = 0;
+            }
+        }
+    }
+
+    fn init_intra_only_probs(&mut self) {
+        // Safety: this was zero-initialized and we only write to it here.
+        let rkprobs = unsafe { &mut self.hw_probs.frame_probs.intra_only };
+        let probs = self.probability_tables;
+
+        for i in 0..probs.coef.len() {
+            for j in 0..probs.coef[0].len() {
+                Self::write_coeff_plane(&probs.coef[i][j][0], &mut rkprobs.coef_intra[i][j]);
+            }
+        }
+
+        for i in 0..vp9::v4l2_vp9_kf_y_mode_prob_rs.len() {
+            let mut byte_count = 0;
+            let mut idx = 0;
+
+            for j in 0..vp9::v4l2_vp9_kf_y_mode_prob_rs[0].len() {
+                for k in 0..vp9::v4l2_vp9_kf_y_mode_prob_rs[0][0].len() {
+                    let val = vp9::v4l2_vp9_kf_y_mode_prob_rs[i][j][k];
+
+                    rkprobs.intra_mode[i].y_mode[idx] = val;
+
+                    idx += 1;
+                    byte_count += 1;
+
+                    if byte_count == 27 {
+                        byte_count = 0;
+                        idx += 5;
+                    }
+                }
+            }
+        }
+
+        for (i, uv_mode) in vp9::v4l2_vp9_kf_uv_mode_prob_rs
+            .iter()
+            .flatten()
+            .enumerate()
+        {
+            rkprobs.intra_mode[i / 23].uv_mode[i % 23] = *uv_mode;
+        }
+    }
+
+    fn init_inter_probs(&mut self) {
+        // Safety: this was zero-initialized and we only write to it here.
+        let rkprobs = unsafe { &mut self.hw_probs.frame_probs.inter };
+        let probs = self.probability_tables;
+
+        rkprobs.y_mode = probs.y_mode;
+        rkprobs.comp_mode = probs.comp_mode;
+        rkprobs.comp_ref = probs.comp_ref;
+        rkprobs.single_ref = probs.single_ref;
+        rkprobs.inter_mode = probs.inter_mode;
+        rkprobs.interp_filter = probs.interp_filter;
+
+        for (i, coef_i) in probs.coef.iter().enumerate() {
+            for (j, coef_j) in coef_i.iter().enumerate() {
+                for (k, _coef_k) in coef_j.iter().enumerate() {
+                    Self::write_coeff_plane(&coef_j[k], &mut rkprobs.coef[k][i][j]);
+                }
+            }
+        }
+
+        rkprobs.uv_mode_0_2.copy_from_slice(&probs.uv_mode[0..3]);
+        rkprobs.uv_mode_3_5.copy_from_slice(&probs.uv_mode[3..6]);
+        rkprobs.uv_mode_6_8.copy_from_slice(&probs.uv_mode[6..9]);
+        rkprobs.uv_mode_9 = probs.uv_mode[9];
+
+        rkprobs.mv.joint = probs.mv.joint;
+        rkprobs.mv.sign = probs.mv.sign;
+        rkprobs.mv.classes = probs.mv.classes;
+        rkprobs.mv.class0_bit = probs.mv.class0_bit;
+        rkprobs.mv.class0_bit = probs.mv.class0_bit;
+        rkprobs.mv.bits = probs.mv.bits;
+        rkprobs.mv.class0_fr = probs.mv.class0_fr;
+        rkprobs.mv.fr = probs.mv.fr;
+        rkprobs.mv.class0_hp = probs.mv.class0_hp;
+        rkprobs.mv.hp = probs.mv.hp;
+    }
+
+    pub(crate) fn init_probs(&mut self) {
+        *self.hw_probs = Default::default();
+
+        let intra_only = self.decode_params.flags & bindings::V4L2_VP9_FRAME_FLAG_KEY_FRAME != 0
+            || self.decode_params.flags & bindings::V4L2_VP9_FRAME_FLAG_INTRA_ONLY != 0;
+
+        if intra_only {
+            self.hw_probs.partition = vp9::v4l2_vp9_kf_partition_probs_rs;
+        } else {
+            self.hw_probs.partition = self.probability_tables.partition;
+        }
+
+        self.hw_probs.pred = self.decode_params.seg.pred_probs;
+        self.hw_probs.tree = self.decode_params.seg.tree_probs;
+        self.hw_probs.skip = self.probability_tables.skip;
+        self.hw_probs.tx32 = self.probability_tables.tx32;
+        self.hw_probs.tx16 = self.probability_tables.tx16;
+        self.hw_probs.tx8 = self.probability_tables.tx8;
+        self.hw_probs.is_inter = self.probability_tables.is_inter;
+
+        if intra_only {
+            self.init_intra_only_probs();
+        } else {
+            self.init_inter_probs();
+        }
+    }
+
+    fn config_ref_registers(&mut self) {
+        for (ref_buf, ref_reg) in self.ref_bufs.iter().zip(&REF_REGS) {
+            let aligned_height = round_up!(ref_buf.resolution.height, 64);
+
+            self.write_register(
+                regs::RKVDEC_VP9_FRAMEWIDTH!(ref_buf.resolution.width)
+                    | regs::RKVDEC_VP9_FRAMEHEIGHT!(ref_buf.resolution.height),
+                ref_reg.reg_frm_size,
+            );
+
+            self.write_register(
+                u32::try_from(ref_buf.dma_address).unwrap(),
+                ref_reg.reg_ref_base,
+            );
+
+            if ref_buf.same_as_dst {
+                continue;
+            }
+
+            let aligned_pitch =
+                round_up!(ref_buf.resolution.width * u32::from(ref_buf.bit_depth), 512) / 8;
+            let y_len = aligned_height * aligned_pitch;
+            let yuv_len = (y_len * 3) / 2;
+
+            self.write_register(
+                regs::RKVDEC_HOR_Y_VIRSTRIDE!(aligned_pitch / 16)
+                    | regs::RKVDEC_HOR_UV_VIRSTRIDE!(aligned_pitch / 16),
+                ref_reg.reg_hor_stride,
+            );
+
+            self.write_register(
+                regs::RKVDEC_VP9_REF_YSTRIDE!(y_len / 16),
+                ref_reg.reg_y_stride,
+            );
+
+            if ref_reg.reg_yuv_stride == 0 {
+                continue;
+            }
+
+            self.write_register(
+                regs::RKVDEC_VP9_REF_YUVSTRIDE!(yuv_len / 16),
+                ref_reg.reg_yuv_stride,
+            );
+        }
+    }
+
+    fn config_seg_registers(&mut self) {
+        let seg = if self.last_frame_info.valid {
+            &self.last_frame_info.seg
+        } else {
+            &self.cur_frame_info.seg
+        };
+
+        for i in 0..seg.feature_enabled.len() {
+            let mut val = 0;
+            let mut feature_val;
+            let seg_flags = u32::from(seg.flags);
+
+            let feature_id = bindings::V4L2_VP9_SEG_LVL_ALT_Q;
+            if vp9::seg_feat_enabled(&seg.feature_enabled, feature_id, i as u32) {
+                feature_val = seg.feature_data[i][feature_id as usize];
+                val |= regs::RKVDEC_SEGID_FRAME_QP_DELTA_EN!(1)
+                    | regs::RKVDEC_SEGID_FRAME_QP_DELTA!(feature_val as u32);
+            }
+
+            let feature_id = bindings::V4L2_VP9_SEG_LVL_ALT_L;
+            if vp9::seg_feat_enabled(&seg.feature_enabled, feature_id, i as u32) {
+                feature_val = seg.feature_data[i][feature_id as usize];
+                val |= regs::RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE_EN!(1)
+                    | regs::RKVDEC_SEGID_FRAME_LOOPFILTER_VALUE!(feature_val as u32);
+            }
+
+            let feature_id = bindings::V4L2_VP9_SEG_LVL_REF_FRAME;
+            if vp9::seg_feat_enabled(&seg.feature_enabled, feature_id, i as u32) {
+                feature_val = seg.feature_data[i][feature_id as usize];
+                val |= regs::RKVDEC_SEGID_REFERINFO_EN!(1)
+                    | regs::RKVDEC_SEGID_REFERINFO!(feature_val as u32);
+            }
+
+            let feature_id = bindings::V4L2_VP9_SEG_LVL_SKIP;
+            if vp9::seg_feat_enabled(&seg.feature_enabled, feature_id, i as u32) {
+                val |= regs::RKVDEC_SEGID_FRAME_SKIP_EN!(1);
+            }
+
+            if i == 0 && (seg_flags & bindings::V4L2_VP9_SEGMENTATION_FLAG_ABS_OR_DELTA_UPDATE != 0)
+            {
+                val |= regs::RKVDEC_SEGID_ABS_DELTA!(1)
+            }
+
+            self.write_register(val, regs::RKVDEC_VP9_SEGID_GRP!(i as u32));
+        }
+    }
+
+    pub(crate) fn config_registers(&mut self) {
+        let dec_params = self.decode_params;
+        let intra_only = dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_KEY_FRAME != 0
+            || dec_params.flags & bindings::V4L2_VP9_FRAME_FLAG_INTRA_ONLY != 0;
+
+        self.write_register(
+            regs::RKVDEC_MODE!(regs::RKVDEC_MODE_VP9),
+            regs::RKVDEC_REG_SYSCTRL,
+        );
+
+        let bit_depth = u32::from(dec_params.bit_depth);
+        let aligned_height = round_up!(self.base.decoded_resolution.height, 64);
+        let aligned_pitch = round_up!(self.base.decoded_resolution.width * bit_depth, 512) / 8;
+
+        let y_len = aligned_height * aligned_pitch;
+        let uv_len = y_len / 2;
+        let yuv_len = y_len + uv_len;
+
+        self.write_register(
+            regs::RKVDEC_Y_HOR_VIRSTRIDE!(aligned_pitch / 16)
+                | regs::RKVDEC_UV_HOR_VIRSTRIDE!(aligned_pitch / 16),
+            regs::RKVDEC_REG_PICPAR,
+        );
+
+        self.write_register(
+            regs::RKVDEC_Y_VIRSTRIDE!(y_len / 16),
+            regs::RKVDEC_REG_Y_VIRSTRIDE,
+        );
+        self.write_register(
+            regs::RKVDEC_YUV_VIRSTRIDE!(yuv_len / 16),
+            regs::RKVDEC_REG_YUV_VIRSTRIDE,
+        );
+        self.write_register(
+            regs::RKVDEC_STRM_LEN!(self.stream_len),
+            regs::RKVDEC_REG_STRM_LEN,
+        );
+
+        self.config_ref_registers();
+        self.config_seg_registers();
+
+        let tx_mode = self.cur_frame_info.tx_mode;
+
+        self.write_register(
+            regs::RKVDEC_VP9_TX_MODE!(tx_mode)
+                | regs::RKVDEC_VP9_FRAME_REF_MODE!(dec_params.reference_mode),
+            regs::RKVDEC_VP9_CPRHEADER_CONFIG,
+        );
+
+        let mut last_frame_info = 0;
+        if !intra_only {
+            let lf = if self.last_frame_info.valid {
+                &self.last_frame_info.lf
+            } else {
+                &self.cur_frame_info.lf
+            };
+
+            let mut val = 0;
+            for (i, delta) in lf.ref_deltas.iter().enumerate() {
+                val |= regs::RKVDEC_REF_DELTAS_LASTFRAME!(i, *delta as u32);
+            }
+
+            self.write_register(val, regs::RKVDEC_VP9_REF_DELTAS_LASTFRAME);
+
+            for (i, delta) in lf.mode_deltas.iter().enumerate() {
+                last_frame_info |= regs::RKVDEC_MODE_DELTAS_LASTFRAME!(i, *delta as u32);
+            }
+        }
+
+        let seg_flags = u32::from(dec_params.seg.flags);
+        if self.last_frame_info.valid
+            && !intra_only
+            && seg_flags & bindings::V4L2_VP9_SEGMENTATION_FLAG_ENABLED != 0
+        {
+            last_frame_info |= regs::RKVDEC_SEG_EN_LASTFRAME;
+        }
+
+        if self.last_frame_info.valid
+            && self.last_frame_info.flags & bindings::V4L2_VP9_FRAME_FLAG_SHOW_FRAME != 0
+        {
+            last_frame_info |= regs::RKVDEC_LAST_SHOW_FRAME;
+        }
+
+        if self.last_frame_info.valid
+            && self.last_frame_info.flags
+                & (bindings::V4L2_VP9_FRAME_FLAG_KEY_FRAME
+                    | bindings::V4L2_VP9_FRAME_FLAG_INTRA_ONLY)
+                != 0
+        {
+            last_frame_info |= regs::RKVDEC_LAST_INTRA_ONLY;
+        }
+
+        if self.last_frame_info.valid && self.last.resolution == self.dst.resolution {
+            last_frame_info |= regs::RKVDEC_LAST_WIDHHEIGHT_EQCUR;
+        }
+
+        self.write_register(last_frame_info, regs::RKVDEC_VP9_INFO_LASTFRAME);
+        let last_tile_size = self.stream_len
+            - u32::from(dec_params.compressed_header_size)
+            - u32::from(dec_params.uncompressed_header_size);
+
+        self.write_register(last_tile_size, regs::RKVDEC_VP9_LASTTILE_SIZE);
+
+        for i in 0..REF_REGS.len() {
+            if intra_only {
+                break;
+            }
+
+            let refw = self.ref_bufs[i].resolution.width;
+            let refh = self.ref_bufs[i].resolution.height;
+            let hscale = (refw << 14) / self.dst.resolution.width;
+            let vscale = (refh << 14) / self.dst.resolution.height;
+
+            self.write_register(
+                regs::RKVDEC_VP9_REF_HOR_SCALE!(hscale) | regs::RKVDEC_VP9_REF_VER_SCALE!(vscale),
+                regs::RKVDEC_VP9_REF_SCALE!(i as u32),
+            );
+        }
+
+        self.write_register(
+            u32::try_from(self.dst.dma_address).unwrap(),
+            regs::RKVDEC_REG_DECOUT_BASE,
+        );
+        self.write_register(
+            u32::try_from(self.src_address).unwrap(),
+            regs::RKVDEC_REG_STRM_RLC_BASE,
+        );
+
+        self.write_register(
+            u32::try_from(self.probs_address).unwrap(),
+            regs::RKVDEC_REG_CABACTBL_PROB_BASE,
+        );
+        self.write_register(
+            u32::try_from(self.count_base_address).unwrap(),
+            regs::RKVDEC_REG_VP9COUNT_BASE,
+        );
+        self.write_register(
+            u32::try_from(self.segid_cur_base_address).unwrap(),
+            regs::RKVDEC_REG_VP9_SEGIDCUR_BASE,
+        );
+        self.write_register(
+            u32::try_from(self.segid_last_base_address).unwrap(),
+            regs::RKVDEC_REG_VP9_SEGIDLAST_BASE,
+        );
+
+        self.write_register(
+            u32::try_from(self.motion_vectors_base_address).unwrap(),
+            regs::RKVDEC_VP9_REF_COLMV_BASE,
+        );
+        self.write_register(
+            self.base.decoded_resolution.width | (self.base.decoded_resolution.height << 16),
+            regs::RKVDEC_REG_PERFORMANCE_CYCLE,
+        );
+    }
+}
+
+#[no_mangle]
+pub(crate) extern "C" fn rkvdec_rs_vp9_init_probs(run: &mut Run<'_>) {
+    run.init_probs();
+}
+
+#[no_mangle]
+pub(crate) extern "C" fn rkvdec_rs_vp9_config_registers(run: &mut Run<'_>) {
+    run.config_registers();
+}
diff --git a/rust/helpers.c b/rust/helpers.c
index d146bbf25aec..fde0520e1d57 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -20,6 +20,7 @@
  * Sorted alphabetically.
  */
 
+#include "asm/io.h"
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
@@ -272,3 +273,9 @@ static_assert(
 	__alignof__(size_t) == __alignof__(uintptr_t),
 	"Rust code expects C `size_t` to match Rust `usize`"
 );
+
+void rust_helper_writel_relaxed(u32 val, void *addr)
+{
+	writel_relaxed(val, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writel_relaxed);
-- 
2.43.0


