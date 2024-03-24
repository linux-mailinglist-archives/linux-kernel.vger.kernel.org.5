Return-Path: <linux-kernel+bounces-116284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B4889DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5D91C338BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802253CB8FE;
	Mon, 25 Mar 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBDHIhxH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FC229C17;
	Sun, 24 Mar 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324140; cv=none; b=qWwr/KdzprJ5WaU0NvGXnSzmxiGqub5ZqbotmEm98r0NGF6B8CJB3o+oW7T7/TeLas1Cuv2DNNtRa8tdP+muQqtZUYGfUmTJiHY0+LVv3sD7Z37JTa+LLz/a9/amewGJNN7vJwkOLCtslTMqL47fluiMgFbj5P3shIR274z4CcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324140; c=relaxed/simple;
	bh=P2fm8Z2EQMNiv+Y/NQXqm4jPEzogggdVonsyMGAJLTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrkpZaTol5d9RDT/kVp7jf3Rnnn+FDaL1FsVvefMsW64OXzJFGbs0Vd+CgjwWehRx4RWmHu/qS7nOU082MEDEUXdCF4ta708YIkd0kKnulwsfIvoFaSHCfX+c8jqvgKitGKlM0XTmtF2oRspGbk71CdcGNja/CtQ6ADxmlMZIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBDHIhxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8757C433C7;
	Sun, 24 Mar 2024 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324140;
	bh=P2fm8Z2EQMNiv+Y/NQXqm4jPEzogggdVonsyMGAJLTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBDHIhxHshcM8H/PcWaAagqGKw28WGKW/L7v6xfArotnQSdA5QGi1+RaMOHkNG4nK
	 PE0WDuflP1hujkuYbHbGCN+okMF+nVQWyXCiqeXop51FB0IuIQ2R8VsR3Yf5vNfhxR
	 yYEN9EdmKR3Jnk1zDIi5Ya6Ua67u1Dra5MVuRPyvO2Da5uV4pwC3J+JZkyrZa9X9IJ
	 DBt48li2d3qtJZ7kWExuuIeWQlawEjiivwFYywmuRZ6+n0H3sALJSj2mrydKRBDF5K
	 4tgi2ZamD1bPtQFk1oa4wEVxQtSCVH/l6LS8yssUCFn3qEZ0ccXj/8ujJfaWIKcwoJ
	 n+o/2ZvMw2kTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vandana BN <bnvandana@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 136/183] media: v4l2-core: correctly validate video and metadata ioctls
Date: Sun, 24 Mar 2024 19:45:49 -0400
Message-ID: <20240324234638.1355609-137-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Vandana BN <bnvandana@gmail.com>

[ Upstream commit 96f49c1ac370c23ae55c63c67a0b40d83928bfbd ]

If the type is VFL_TYPE_GRABBER, then also check device_caps
to see if the video device supports video and/or metadata and
disable unneeded ioctls.

Without this change, format ioctls for both video and metadata devices
could be called on both device nodes. This is true for other ioctls as
well, even if the device supports only video or metadata.

Metadata devices act similar to VBI devices w.r.t. which ioctls should
be enabled. This makes sense since VBI *is* metadata.

Signed-off-by: Vandana BN <bnvandana@gmail.com>
Co-developed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Stable-dep-of: d0b07f712bf6 ("media: ttpci: fix two memleaks in budget_av_attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-dev.c   | 62 +++++++++++++++++-----------
 drivers/media/v4l2-core/v4l2-ioctl.c | 16 +++++--
 2 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 4037689a945a5..1bf543932e4f9 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -533,13 +533,23 @@ static int get_index(struct video_device *vdev)
  */
 static void determine_valid_ioctls(struct video_device *vdev)
 {
+	const u32 vid_caps = V4L2_CAP_VIDEO_CAPTURE |
+			     V4L2_CAP_VIDEO_CAPTURE_MPLANE |
+			     V4L2_CAP_VIDEO_OUTPUT |
+			     V4L2_CAP_VIDEO_OUTPUT_MPLANE |
+			     V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE;
+	const u32 meta_caps = V4L2_CAP_META_CAPTURE |
+			      V4L2_CAP_META_OUTPUT;
 	DECLARE_BITMAP(valid_ioctls, BASE_VIDIOC_PRIVATE);
 	const struct v4l2_ioctl_ops *ops = vdev->ioctl_ops;
-	bool is_vid = vdev->vfl_type == VFL_TYPE_GRABBER;
+	bool is_vid = vdev->vfl_type == VFL_TYPE_GRABBER &&
+		      (vdev->device_caps & vid_caps);
 	bool is_vbi = vdev->vfl_type == VFL_TYPE_VBI;
 	bool is_radio = vdev->vfl_type == VFL_TYPE_RADIO;
 	bool is_sdr = vdev->vfl_type == VFL_TYPE_SDR;
 	bool is_tch = vdev->vfl_type == VFL_TYPE_TOUCH;
+	bool is_meta = vdev->vfl_type == VFL_TYPE_GRABBER &&
+		       (vdev->device_caps & meta_caps);
 	bool is_rx = vdev->vfl_dir != VFL_DIR_TX;
 	bool is_tx = vdev->vfl_dir != VFL_DIR_RX;
 
@@ -587,39 +597,31 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		set_bit(_IOC_NR(VIDIOC_ENUM_FREQ_BANDS), valid_ioctls);
 
 	if (is_vid || is_tch) {
-		/* video and metadata specific ioctls */
+		/* video and touch specific ioctls */
 		if ((is_rx && (ops->vidioc_enum_fmt_vid_cap ||
-			       ops->vidioc_enum_fmt_vid_overlay ||
-			       ops->vidioc_enum_fmt_meta_cap)) ||
-		    (is_tx && (ops->vidioc_enum_fmt_vid_out ||
-			       ops->vidioc_enum_fmt_meta_out)))
+			       ops->vidioc_enum_fmt_vid_overlay)) ||
+		    (is_tx && ops->vidioc_enum_fmt_vid_out))
 			set_bit(_IOC_NR(VIDIOC_ENUM_FMT), valid_ioctls);
 		if ((is_rx && (ops->vidioc_g_fmt_vid_cap ||
 			       ops->vidioc_g_fmt_vid_cap_mplane ||
-			       ops->vidioc_g_fmt_vid_overlay ||
-			       ops->vidioc_g_fmt_meta_cap)) ||
+			       ops->vidioc_g_fmt_vid_overlay)) ||
 		    (is_tx && (ops->vidioc_g_fmt_vid_out ||
 			       ops->vidioc_g_fmt_vid_out_mplane ||
-			       ops->vidioc_g_fmt_vid_out_overlay ||
-			       ops->vidioc_g_fmt_meta_out)))
+			       ops->vidioc_g_fmt_vid_out_overlay)))
 			 set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
 		if ((is_rx && (ops->vidioc_s_fmt_vid_cap ||
 			       ops->vidioc_s_fmt_vid_cap_mplane ||
-			       ops->vidioc_s_fmt_vid_overlay ||
-			       ops->vidioc_s_fmt_meta_cap)) ||
+			       ops->vidioc_s_fmt_vid_overlay)) ||
 		    (is_tx && (ops->vidioc_s_fmt_vid_out ||
 			       ops->vidioc_s_fmt_vid_out_mplane ||
-			       ops->vidioc_s_fmt_vid_out_overlay ||
-			       ops->vidioc_s_fmt_meta_out)))
+			       ops->vidioc_s_fmt_vid_out_overlay)))
 			 set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
 		if ((is_rx && (ops->vidioc_try_fmt_vid_cap ||
 			       ops->vidioc_try_fmt_vid_cap_mplane ||
-			       ops->vidioc_try_fmt_vid_overlay ||
-			       ops->vidioc_try_fmt_meta_cap)) ||
+			       ops->vidioc_try_fmt_vid_overlay)) ||
 		    (is_tx && (ops->vidioc_try_fmt_vid_out ||
 			       ops->vidioc_try_fmt_vid_out_mplane ||
-			       ops->vidioc_try_fmt_vid_out_overlay ||
-			       ops->vidioc_try_fmt_meta_out)))
+			       ops->vidioc_try_fmt_vid_out_overlay)))
 			 set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_OVERLAY, vidioc_overlay);
 		SET_VALID_IOCTL(ops, VIDIOC_G_FBUF, vidioc_g_fbuf);
@@ -641,7 +643,21 @@ static void determine_valid_ioctls(struct video_device *vdev)
 			set_bit(_IOC_NR(VIDIOC_S_CROP), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_G_SELECTION, vidioc_g_selection);
 		SET_VALID_IOCTL(ops, VIDIOC_S_SELECTION, vidioc_s_selection);
-	} else if (is_vbi) {
+	}
+	if (is_meta && is_rx) {
+		/* metadata capture specific ioctls */
+		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_meta_cap);
+		SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_meta_cap);
+		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_meta_cap);
+		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_meta_cap);
+	} else if (is_meta && is_tx) {
+		/* metadata output specific ioctls */
+		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_meta_out);
+		SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_meta_out);
+		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_meta_out);
+		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_meta_out);
+	}
+	if (is_vbi) {
 		/* vbi specific ioctls */
 		if ((is_rx && (ops->vidioc_g_fmt_vbi_cap ||
 			       ops->vidioc_g_fmt_sliced_vbi_cap)) ||
@@ -681,8 +697,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
 			set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
 	}
 
-	if (is_vid || is_vbi || is_sdr || is_tch) {
-		/* ioctls valid for video, metadata, vbi or sdr */
+	if (is_vid || is_vbi || is_sdr || is_tch || is_meta) {
+		/* ioctls valid for video, vbi, sdr, touch and metadata */
 		SET_VALID_IOCTL(ops, VIDIOC_REQBUFS, vidioc_reqbufs);
 		SET_VALID_IOCTL(ops, VIDIOC_QUERYBUF, vidioc_querybuf);
 		SET_VALID_IOCTL(ops, VIDIOC_QBUF, vidioc_qbuf);
@@ -694,8 +710,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
 	}
 
-	if (is_vid || is_vbi || is_tch) {
-		/* ioctls valid for video or vbi */
+	if (is_vid || is_vbi || is_tch || is_meta) {
+		/* ioctls valid for video, vbi, touch and metadata */
 		if (ops->vidioc_s_std)
 			set_bit(_IOC_NR(VIDIOC_ENUMSTD), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_S_STD, vidioc_s_std);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 3012e8ecffb94..b8edef9160864 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -950,12 +950,22 @@ static bool check_ext_ctrls(struct v4l2_ext_controls *c, unsigned long ioctl)
 
 static int check_fmt(struct file *file, enum v4l2_buf_type type)
 {
+	const u32 vid_caps = V4L2_CAP_VIDEO_CAPTURE |
+			     V4L2_CAP_VIDEO_CAPTURE_MPLANE |
+			     V4L2_CAP_VIDEO_OUTPUT |
+			     V4L2_CAP_VIDEO_OUTPUT_MPLANE |
+			     V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE;
+	const u32 meta_caps = V4L2_CAP_META_CAPTURE |
+			      V4L2_CAP_META_OUTPUT;
 	struct video_device *vfd = video_devdata(file);
 	const struct v4l2_ioctl_ops *ops = vfd->ioctl_ops;
-	bool is_vid = vfd->vfl_type == VFL_TYPE_GRABBER;
+	bool is_vid = vfd->vfl_type == VFL_TYPE_GRABBER &&
+		      (vfd->device_caps & vid_caps);
 	bool is_vbi = vfd->vfl_type == VFL_TYPE_VBI;
 	bool is_sdr = vfd->vfl_type == VFL_TYPE_SDR;
 	bool is_tch = vfd->vfl_type == VFL_TYPE_TOUCH;
+	bool is_meta = vfd->vfl_type == VFL_TYPE_GRABBER &&
+		       (vfd->device_caps & meta_caps);
 	bool is_rx = vfd->vfl_dir != VFL_DIR_TX;
 	bool is_tx = vfd->vfl_dir != VFL_DIR_RX;
 
@@ -1014,11 +1024,11 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
 			return 0;
 		break;
 	case V4L2_BUF_TYPE_META_CAPTURE:
-		if (is_vid && is_rx && ops->vidioc_g_fmt_meta_cap)
+		if (is_meta && is_rx && ops->vidioc_g_fmt_meta_cap)
 			return 0;
 		break;
 	case V4L2_BUF_TYPE_META_OUTPUT:
-		if (is_vid && is_tx && ops->vidioc_g_fmt_meta_out)
+		if (is_meta && is_tx && ops->vidioc_g_fmt_meta_out)
 			return 0;
 		break;
 	default:
-- 
2.43.0


