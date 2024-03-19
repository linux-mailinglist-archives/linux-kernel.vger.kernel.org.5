Return-Path: <linux-kernel+bounces-107199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2587F8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E10E1F21C58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD97E761;
	Tue, 19 Mar 2024 08:08:10 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDD7E0E4;
	Tue, 19 Mar 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835689; cv=none; b=Dv1xaCtUTMzsnVx0Mpdh74EQ2o3/up2jTuzwifCKdNzn9nCvSu+r9vmdhjNYc1dkO6QI7viHIbv3yfP8yEfD0mH3Y8dYNImm4eMZr2GBUHA+qilwwrYmFOsmqfQWUkHcVFTx7+3TqNea7mnweXEe3RpxH0nyKQ3mmrfQeMYeZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835689; c=relaxed/simple;
	bh=zItxLVW5Z3oKtQQHUpenFQi3aYHp+cZX947e2TReMKk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=YymSduGRuzrrgikkUbqGjNTjLmLwrEVG7Jh8INLGW7ohfb5w/MFLtMdwK8qEv5KybHhR03cZSMWsivRJrbDuZbUSHZ2DK5Tsz7VJtimReXVcUSzlZzidy4uwTrL2s5RySrH5YNnwrtW3zD/Z3NyvXDE0f0ynJcon+eaigbE5Sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5CA53201E5B;
	Tue, 19 Mar 2024 09:08:06 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 01887201E62;
	Tue, 19 Mar 2024 09:08:06 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EC79D1834890;
	Tue, 19 Mar 2024 16:08:03 +0800 (+08)
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
Subject: [PATCH v15 11/16] media: uapi: Add audio rate controls support
Date: Tue, 19 Mar 2024 15:51:09 +0800
Message-Id: <1710834674-3285-12-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add V4L2_CID_M2M_AUDIO_SOURCE_RATE and V4L2_CID_M2M_AUDIO_DEST_RATE
new IDs for rate control.

Add V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET and
V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET for clock drift.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../media/v4l/ext-ctrls-audio-m2m.rst         | 38 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  6 +++
 include/uapi/linux/v4l2-controls.h            |  5 +++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
index 82d2ecedbfee..b137b7c442e6 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
@@ -19,3 +19,41 @@ Audio M2M Control IDs
     The Audio M2M class descriptor. Calling
     :ref:`VIDIOC_QUERYCTRL` for this control will
     return a description of this control class.
+
+.. _v4l2-audio-asrc:
+
+``V4L2_CID_M2M_AUDIO_SOURCE_RATE (integer menu)``
+    This control specifies the audio source sample rate, unit is Hz
+
+``V4L2_CID_M2M_AUDIO_DEST_RATE (integer menu)``
+    This control specifies the audio destination sample rate, unit is Hz
+
+``V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET (fixed point)``
+    This control specifies the offset from the audio source sample rate,
+    unit is Hz.
+
+    The offset compensates for any clock drift. The actual source audio
+    sample rate is the ideal source audio sample rate from
+    ``V4L2_CID_M2M_AUDIO_SOURCE_RATE`` plus this fixed point offset.
+
+    The audio source clock may have some drift. Reducing or increasing the
+    audio sample rate dynamically to ensure that Sample Rate Converter is
+    working on the real sample rate, this feature is for the Asynchronous
+    Sample Rate Converter module.
+    So, userspace would be expected to be monitoring such drift
+    and increasing/decreasing the sample frequency as needed by this control.
+
+``V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET (fixed point)``
+    This control specifies the offset from the audio destination sample rate,
+    unit is Hz.
+
+    The offset compensates for any clock drift. The actual destination audio
+    sample rate is the ideal source audio sample rate from
+    ``V4L2_CID_M2M_AUDIO_DEST_RATE`` plus this fixed point offset.
+
+    The audio destination clock may have some drift. Reducing or increasing
+    the audio sample rate dynamically to ensure that sample rate converter
+    is working on the real sample rate, this feature is for the Asynchronous
+    Sample Rate Converter module.
+    So, userspace would be expected to be monitoring such drift
+    and increasing/decreasing the sample frequency as needed by this control.
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 2a85ea3dc92f..91e1f5348c23 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1245,6 +1245,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 
 	/* Audio M2M controls */
 	case V4L2_CID_M2M_AUDIO_CLASS:  return "Audio M2M Controls";
+	case V4L2_CID_M2M_AUDIO_SOURCE_RATE:	return "Audio Source Sample Rate";
+	case V4L2_CID_M2M_AUDIO_DEST_RATE:	return "Audio Destination Sample Rate";
 	default:
 		return NULL;
 	}
@@ -1606,6 +1608,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
 		*type = V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY;
 		break;
+	case V4L2_CID_M2M_AUDIO_SOURCE_RATE:
+	case V4L2_CID_M2M_AUDIO_DEST_RATE:
+		*type = V4L2_CTRL_TYPE_INTEGER_MENU;
+		break;
 	default:
 		*type = V4L2_CTRL_TYPE_INTEGER;
 		break;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index a8b4b830c757..30129ccdc282 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -3495,6 +3495,11 @@ struct v4l2_ctrl_av1_film_grain {
 #define V4L2_CID_M2M_AUDIO_CLASS_BASE  (V4L2_CTRL_CLASS_M2M_AUDIO | 0x900)
 #define V4L2_CID_M2M_AUDIO_CLASS       (V4L2_CTRL_CLASS_M2M_AUDIO | 1)
 
+#define V4L2_CID_M2M_AUDIO_SOURCE_RATE	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 0)
+#define V4L2_CID_M2M_AUDIO_DEST_RATE	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 1)
+#define V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 2)
+#define V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 3)
+
 /* MPEG-compression definitions kept for backwards compatibility */
 #ifndef __KERNEL__
 #define V4L2_CTRL_CLASS_MPEG            V4L2_CTRL_CLASS_CODEC
-- 
2.34.1


