Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD337A78B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjITKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjITKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:10:15 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34911C;
        Wed, 20 Sep 2023 03:10:03 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EFA6A200B75;
        Wed, 20 Sep 2023 12:10:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 893E0201BD3;
        Wed, 20 Sep 2023 12:10:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A56A1180327D;
        Wed, 20 Sep 2023 18:09:58 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v4 09/11] media: uapi: Add V4L2_CID_USER_IMX_ASRC_RATIO_MOD control
Date:   Wed, 20 Sep 2023 17:32:48 +0800
Message-Id: <1695202370-24678-10-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695202370-24678-1-git-send-email-shengjiu.wang@nxp.com>
References: <1695202370-24678-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input clock and output clock may not be the accurate
rate as the sample rate, there is some drift, so the convert
ratio of i.MX ASRC module need to be changed according to
actual clock rate.

Add V4L2_CID_USER_IMX_ASRC_RATIO_MOD control for user to
adjust the ratio.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/userspace-api/media/v4l/control.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c         | 1 +
 include/uapi/linux/v4l2-controls.h                | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Documentation/userspace-api/media/v4l/control.rst
index 4463fce694b0..2bc175900a34 100644
--- a/Documentation/userspace-api/media/v4l/control.rst
+++ b/Documentation/userspace-api/media/v4l/control.rst
@@ -318,6 +318,11 @@ Control IDs
     depending on particular custom controls should check the driver name
     and version, see :ref:`querycap`.
 
+.. _v4l2-audio-imx:
+
+``V4L2_CID_USER_IMX_ASRC_RATIO_MOD``
+    sets the rasampler ratio modifier of i.MX asrc module.
+
 Applications can enumerate the available controls with the
 :ref:`VIDIOC_QUERYCTRL` and
 :ref:`VIDIOC_QUERYMENU <VIDIOC_QUERYCTRL>` ioctls, get and set a
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..16f66f66198c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1242,6 +1242,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_COLORIMETRY_CLASS:	return "Colorimetry Controls";
 	case V4L2_CID_COLORIMETRY_HDR10_CLL_INFO:		return "HDR10 Content Light Info";
 	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:	return "HDR10 Mastering Display";
+	case V4L2_CID_USER_IMX_ASRC_RATIO_MOD:			return "ASRC RATIO MOD";
 	default:
 		return NULL;
 	}
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..b1c319906d12 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -162,6 +162,7 @@ enum v4l2_colorfx {
 /* The base for the imx driver controls.
  * We reserve 16 controls for this driver. */
 #define V4L2_CID_USER_IMX_BASE			(V4L2_CID_USER_BASE + 0x10b0)
+#define V4L2_CID_USER_IMX_ASRC_RATIO_MOD	(V4L2_CID_USER_IMX_BASE + 0)
 
 /*
  * The base for the atmel isc driver controls.
-- 
2.34.1

