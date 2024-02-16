Return-Path: <linux-kernel+bounces-68392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2785799D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1750289BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D55024A07;
	Fri, 16 Feb 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TGVQBLme"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB309241E7;
	Fri, 16 Feb 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077366; cv=none; b=VV8hcxjHF06/ImFVN29gUdItP/3JLXRGmMSpHaux4UmPfly9pPNc5GJj6fwWitO8C7prJXu7UWowTXdqvwf1Au9NUOcvNd5GAJ0YibU8u90NuEBtgl8b9icDEAZtSeV+T9PaktFvJ8aHWGnihFBw6xLX08nsPpCxb4MgdbYi1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077366; c=relaxed/simple;
	bh=LjBq2hXcVmjxGGKOBoc4VPG8K7hvjp5oJwcqjaIhYTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqjxxNXKoSprhQHfyhFL6rql3/hRVyvdduK731ZXj+3YeMODFD47cOJPdxNnOsfJ4X2xaRr35Qz20kczJ/O8wTHtA5FGG41Ctp/qg+FCi6IinWEAMQEo8Q/oNNkRJKdMXdbfyrDzx5bZcP/qy0Wely4NxiasYTE2nCkyMeyD6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TGVQBLme; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA0386B3;
	Fri, 16 Feb 2024 10:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708077359;
	bh=LjBq2hXcVmjxGGKOBoc4VPG8K7hvjp5oJwcqjaIhYTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGVQBLmeljtogK4nhSQnuOpoAEixv1o3n66UKCm1S3MMatziV2m6g/qY8U6TmNfyY
	 Hbl0vsFq/WGL/LRD2TdCmk7OW7baJewG+zuoneB69v5tErk1SpgNmQogL08v6HCEKn
	 FPtYeN6m82QuFettZn1Bp7EZ5X0yc0QePS5B6bo8=
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
Subject: [PATCH v12 09/12] media: rkisp1: Add YC swap capability
Date: Fri, 16 Feb 2024 18:54:55 +0900
Message-Id: <20240216095458.2919694-10-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISP version in the i.MX8MP has an MI_OUTPUT_ALIGN_FORMAT register
that the rk3399 does not have. This register allows swapping bytes,
which can be used to implement UYVY from YUYV.

Add a flag to the format info in the list of formats supported by the
capture v4l2 devices, and update enum_fmt and s_fmt to take it into
account.

To signify the presence of this feature, reuse the MAIN_STRIDE feature
flag, as it is very likely that any ISP version that supports one of
these two features will also support the other.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>

---
Changes in v12:
- replace MI_OUTPUT_ALIGN feature flag with MAIN_STRIDE
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 1ee7639c42b7..99375e08b503 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -47,13 +47,15 @@ enum rkisp1_plane {
  * @fourcc: pixel format
  * @fmt_type: helper filed for pixel format
  * @uv_swap: if cb cr swapped, for yuv
+ * @yc_swap: if y and cb/cr swapped, for yuv
  * @write_format: defines how YCbCr self picture data is written to memory
  * @output_format: defines sp output format
  * @mbus: the mbus code on the src resizer pad that matches the pixel format
  */
 struct rkisp1_capture_fmt_cfg {
 	u32 fourcc;
-	u8 uv_swap;
+	u32 uv_swap : 1;
+	u32 yc_swap : 1;
 	u32 write_format;
 	u32 output_format;
 	u32 mbus;
@@ -1162,10 +1164,14 @@ rkisp1_fill_pixfmt(const struct rkisp1_capture *cap,
 static const struct rkisp1_capture_fmt_cfg *
 rkisp1_find_fmt_cfg(const struct rkisp1_capture *cap, const u32 pixelfmt)
 {
+	bool yc_swap_support = rkisp1_has_feature(cap->rkisp1, MAIN_STRIDE);
 	unsigned int i;
 
 	for (i = 0; i < cap->config->fmt_size; i++) {
-		if (cap->config->fmts[i].fourcc == pixelfmt)
+		const struct rkisp1_capture_fmt_cfg *fmt = &cap->config->fmts[i];
+
+		if (fmt->fourcc == pixelfmt &&
+		    (!fmt->yc_swap || yc_swap_support))
 			return &cap->config->fmts[i];
 	}
 	return NULL;
@@ -1234,23 +1240,29 @@ static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
 {
 	struct rkisp1_capture *cap = video_drvdata(file);
 	const struct rkisp1_capture_fmt_cfg *fmt = NULL;
+	bool yc_swap_support = rkisp1_has_feature(cap->rkisp1, MAIN_STRIDE);
 	unsigned int i, n = 0;
 
-	if (!f->mbus_code) {
-		if (f->index >= cap->config->fmt_size)
-			return -EINVAL;
+	if (f->index >= cap->config->fmt_size)
+		return -EINVAL;
 
+	if (!f->mbus_code && yc_swap_support) {
 		fmt = &cap->config->fmts[f->index];
 		f->pixelformat = fmt->fourcc;
 		return 0;
 	}
 
 	for (i = 0; i < cap->config->fmt_size; i++) {
-		if (cap->config->fmts[i].mbus != f->mbus_code)
+		fmt = &cap->config->fmts[i];
+
+		if (f->mbus_code && fmt->mbus != f->mbus_code)
+			continue;
+
+		if (!yc_swap_support && fmt->yc_swap)
 			continue;
 
 		if (n++ == f->index) {
-			f->pixelformat = cap->config->fmts[i].fourcc;
+			f->pixelformat = fmt->fourcc;
 			return 0;
 		}
 	}
-- 
2.39.2


