Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52F7D0CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377060AbjJTKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376902AbjJTKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:09:08 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD92CC;
        Fri, 20 Oct 2023 03:09:06 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D61C1201E8A;
        Fri, 20 Oct 2023 12:09:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 732DD201E75;
        Fri, 20 Oct 2023 12:09:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D8E3D181D0E5;
        Fri, 20 Oct 2023 18:09:02 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v7 11/13] media: uapi: Add audio rate controls support
Date:   Fri, 20 Oct 2023 17:30:30 +0800
Message-Id: <1697794232-2607-12-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1697794232-2607-1-git-send-email-shengjiu.wang@nxp.com>
References: <1697794232-2607-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_CID_M2M_AUDIO_SOURCE_RATE and V4L2_CID_M2M_AUDIO_DEST_RATE
new IDs for rate control.

Add V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET and
V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET for clock drift.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../media/v4l/ext-ctrls-audio-m2m.rst          | 18 ++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c      | 12 ++++++++++++
 include/uapi/linux/v4l2-controls.h             |  5 +++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
index 82d2ecedbfee..e6972a2d3b17 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
@@ -19,3 +19,21 @@ Audio M2M Control IDs
     The Audio M2M class descriptor. Calling
     :ref:`VIDIOC_QUERYCTRL` for this control will
     return a description of this control class.
+
+.. _v4l2-audio-asrc:
+
+``V4L2_CID_M2M_AUDIO_SOURCE_RATE``
+    Sets the audio source rate, unit is (Hz)
+
+``V4L2_CID_M2M_AUDIO_DEST_RATE``
+    Sets the audio destination rate, unit is (Hz)
+
+``V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET``
+    Sets the offset for audio source rate, unit is (Hz).
+    Offset expresses the drift of clock if there is. It is
+    equal to real rate minus ideal rate.
+
+``V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET``
+    Sets the offset for audio destination rate, unit is (Hz)
+    Offset expresses the drift of clock if there is. It is
+    equal to real rate minus ideal rate.
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 2a85ea3dc92f..b695cbdd1f6e 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1245,6 +1245,10 @@ const char *v4l2_ctrl_get_name(u32 id)
 
 	/* Audio M2M controls */
 	case V4L2_CID_M2M_AUDIO_CLASS:  return "Audio M2M Controls";
+	case V4L2_CID_M2M_AUDIO_SOURCE_RATE:	return "Audio Source Sample Rate";
+	case V4L2_CID_M2M_AUDIO_DEST_RATE:	return "Audio Dest Sample Rate";
+	case V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET:	return "Audio Source Sample Rate Offset";
+	case V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET:	return "Audio Dest Sample Rate Offset";
 	default:
 		return NULL;
 	}
@@ -1606,6 +1610,14 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
 		*type = V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY;
 		break;
+	case V4L2_CID_M2M_AUDIO_SOURCE_RATE:
+	case V4L2_CID_M2M_AUDIO_DEST_RATE:
+		*type = V4L2_CTRL_TYPE_INTEGER_MENU;
+		break;
+	case V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET:
+	case V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET:
+		*type = V4L2_CTRL_TYPE_FIXED_POINT;
+		break;
 	default:
 		*type = V4L2_CTRL_TYPE_INTEGER;
 		break;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index eb0f0a76f867..d433c6f0b533 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -3498,4 +3498,9 @@ struct v4l2_ctrl_av1_film_grain {
 #define V4L2_CID_M2M_AUDIO_CLASS_BASE  (V4L2_CTRL_CLASS_M2M_AUDIO | 0x900)
 #define V4L2_CID_M2M_AUDIO_CLASS       (V4L2_CTRL_CLASS_M2M_AUDIO | 1)
 
+#define V4L2_CID_M2M_AUDIO_SOURCE_RATE	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 0)
+#define V4L2_CID_M2M_AUDIO_DEST_RATE	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 1)
+#define V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 2)
+#define V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 3)
+
 #endif
-- 
2.34.1

