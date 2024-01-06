Return-Path: <linux-kernel+bounces-18649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76F826079
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C140E1C21BDE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7F2BB13;
	Sat,  6 Jan 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HWLmgqeb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A99847B;
	Sat,  6 Jan 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (unknown [IPv6:2001:268:c203:a8ee:6c57:4243:1eb3:6cb])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 67DB812E4;
	Sat,  6 Jan 2024 17:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704556973;
	bh=K70IzSs6vgDWbdrp4Sy/MWQlESNUan8JBoy4snxEayc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWLmgqebQOpbEax9JDjt/0c9uqPfpNQLkVU7nc6IMCWscDRvH6pM9uvXx/lxfTsCc
	 vHNHltwgBjZmd/i3KA9EhEnf3v9tZ3l5Pz5BgALPdE/aXd0YsU0cmNWVJoMy+DlXKm
	 Mr7YbGSmtMyGZ15fSQaLG0Z4ejgG8WjqHdQa95U0=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Paul Elder <paul.elder@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/10] media: rkisp1: Add UYVY as an output format
Date: Sun,  7 Jan 2024 01:02:21 +0900
Message-Id: <20240106160221.4183409-11-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106160221.4183409-1-paul.elder@ideasonboard.com>
References: <20240106160221.4183409-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for UYVY as an output format. The uv_swap bit in the
MI_XTD_FORMAT_CTRL register that is used for the NV formats does not
work for packed YUV formats. Thus, UYVY support is implemented via
byte-swapping. This method clearly does not work for implementing
support for YVYU and VYUY.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index bf63f78dc48c..813d4274f118 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -97,6 +97,12 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
 		.uv_swap = 0,
 		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
 		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.uv_swap = 0,
+		.yc_swap = 1,
+		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YUV422P,
 		.uv_swap = 0,
@@ -231,6 +237,13 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
 		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
 		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
 		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.uv_swap = 0,
+		.yc_swap = 1,
+		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
+		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YUV422P,
 		.uv_swap = 0,
@@ -464,6 +477,20 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
 		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
 	}
 
+	/*
+	 * U/V swapping with the MI_XTD_FORMAT_CTRL register only works for
+	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
+	 * YVYU and VYUY cannot be supported with this method.
+	 */
+	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
+		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
+		if (cap->pix.cfg->yc_swap)
+			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
+		else
+			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
+	}
+
 	rkisp1_mi_config_ctrl(cap);
 
 	reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
@@ -507,6 +534,20 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
 		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
 	}
 
+	/*
+	 * U/V swapping with the MI_XTD_FORMAT_CTRL register only works for
+	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
+	 * YVYU and VYUY cannot be supported with this method.
+	 */
+	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
+		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
+		if (cap->pix.cfg->yc_swap)
+			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
+		else
+			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
+	}
+
 	rkisp1_mi_config_ctrl(cap);
 
 	mi_ctrl = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
-- 
2.39.2


