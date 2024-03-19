Return-Path: <linux-kernel+bounces-107194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD787F8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C21F21DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F157CF0B;
	Tue, 19 Mar 2024 08:08:03 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA115466E;
	Tue, 19 Mar 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835683; cv=none; b=cbUjvcUkiPjcGzryJO2nTHivF24wyxFkeaLnaCVlg3YmXnr0lWTarCrQgvQI8UjU4Ehe9AcAN70LL0UxvKfuAihDRC3ZjJvti9uTTPtXUeuqKgoRcu7HPVAT8G+UqHLPAz6HnLIBagJMZhlgninadMGyMgaw0y0lI6ammAf37po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835683; c=relaxed/simple;
	bh=n71JbBxn/Ji/Go4XRp7Smlrz7Vv7u0vTgePDyQjo3AE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=r+3mbZku78xbJJXyQGDevOJlwfwJaNdxU5RjcWUMey0pdPc5G7RTwXHvL5nHW92CWeHq1M5/U9WwravVGHCNKPoDJkTpxTLtsPINMMaXsD7jhU5U771g4SrU9qJVqDQeiiFWzHTSw7um5lTClHzNnpk4ZlQDdfDX/VsqWP3LG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F20B5201577;
	Tue, 19 Mar 2024 09:07:59 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B91A3201364;
	Tue, 19 Mar 2024 09:07:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A118C180C2DA;
	Tue, 19 Mar 2024 16:07:57 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 07/16] media: uapi: Add V4L2_CAP_AUDIO_M2M capability flag
Date: Tue, 19 Mar 2024 15:51:05 +0800
Message-Id: <1710834674-3285-8-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

V4L2_CAP_AUDIO_M2M is similar to V4L2_CAP_VIDEO_M2M flag.

It is used for audio memory to memory case.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/userspace-api/media/v4l/vidioc-querycap.rst    | 3 +++
 Documentation/userspace-api/media/videodev2.h.rst.exceptions | 1 +
 include/uapi/linux/videodev2.h                               | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
index 6c57b8428356..1c0d97bf192a 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
@@ -173,6 +173,9 @@ specification the ioctl returns an ``EINVAL`` error code.
 	interface. A video overlay device typically stores captured images
 	directly in the video memory of a graphics card, with hardware
 	clipping and scaling.
+    * - ``V4L2_CAP_AUDIO_M2M``
+      - 0x00000008
+      - The device supports the audio Memory-To-Memory interface.
     * - ``V4L2_CAP_VBI_CAPTURE``
       - 0x00000010
       - The device supports the :ref:`Raw VBI Capture <raw-vbi>`
diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
index 3e58aac4ef0b..da6d0b8e4c2c 100644
--- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
+++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
@@ -197,6 +197,7 @@ replace define V4L2_CAP_META_OUTPUT device-capabilities
 replace define V4L2_CAP_DEVICE_CAPS device-capabilities
 replace define V4L2_CAP_TOUCH device-capabilities
 replace define V4L2_CAP_IO_MC device-capabilities
+replace define V4L2_CAP_AUDIO_M2M device-capabilities
 
 # V4L2 pix flags
 replace define V4L2_PIX_FMT_PRIV_MAGIC :c:type:`v4l2_pix_format`
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index b8573e9ccde6..5cc2a978fd9c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -473,6 +473,7 @@ struct v4l2_capability {
 #define V4L2_CAP_VIDEO_CAPTURE		0x00000001  /* Is a video capture device */
 #define V4L2_CAP_VIDEO_OUTPUT		0x00000002  /* Is a video output device */
 #define V4L2_CAP_VIDEO_OVERLAY		0x00000004  /* Can do video overlay */
+#define V4L2_CAP_AUDIO_M2M		0x00000008  /* audio memory to memory */
 #define V4L2_CAP_VBI_CAPTURE		0x00000010  /* Is a raw VBI capture device */
 #define V4L2_CAP_VBI_OUTPUT		0x00000020  /* Is a raw VBI output device */
 #define V4L2_CAP_SLICED_VBI_CAPTURE	0x00000040  /* Is a sliced VBI capture device */
-- 
2.34.1


