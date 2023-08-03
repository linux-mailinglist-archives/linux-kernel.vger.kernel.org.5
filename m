Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0876F4E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjHCV45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHCV4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:56:54 -0400
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95763ABE;
        Thu,  3 Aug 2023 14:56:51 -0700 (PDT)
Received: from fedori.lan (51b69adf.dsl.pool.telekom.hu [::ffff:81.182.154.223])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072E37.0000000064CC1C4D.0001D183; Thu, 03 Aug 2023 23:29:42 +0200
From:   =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>
Subject: [RFC PATCH 1/2] media: v4l2: ctrls: Add ROLL_ABSOLUTE control
Date:   Thu,  3 Aug 2023 23:28:57 +0200
Message-ID: <8eb0e251fb4f4ab4f3ed5472fbd26e94786b46ff.1691096157.git.soyer@irl.hu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691096157.git.soyer@irl.hu>
References: <cover.1691096157.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_CID_ROLL_ABSOLUTE as an integer control to
retrieve and set the camera roll in degrees, and its
documentation.

Signed-off-by: Gergő Köteles <soyer@irl.hu>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                  | 1 +
 include/uapi/linux/v4l2-controls.h                         | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index cdc515c60468..81bc31a4bf79 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -672,3 +672,8 @@ enum v4l2_scene_mode -
 
     As modes differ for each sensor, menu items are not standardized by this
     control and are left to the programmer.
+
+``V4L2_CID_ROLL_ABSOLUTE (integer)``
+    This control describes the camera rotation along the image viewing axis in
+    degrees. Values range from -180 to +180, the default is zero. Positive
+    values rotate the camera clockwise, negative values counter-clockwise.
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..0e8af56cb2a2 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1086,6 +1086,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_CAMERA_ORIENTATION:	return "Camera Orientation";
 	case V4L2_CID_CAMERA_SENSOR_ROTATION:	return "Camera Sensor Rotation";
 	case V4L2_CID_HDR_SENSOR_MODE:		return "HDR Sensor Mode";
+	case V4L2_CID_ROLL_ABSOLUTE:		return "Roll, Absolute";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..5131711ea873 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1075,6 +1075,8 @@ enum v4l2_auto_focus_range {
 
 #define V4L2_CID_HDR_SENSOR_MODE		(V4L2_CID_CAMERA_CLASS_BASE+36)
 
+#define V4L2_CID_ROLL_ABSOLUTE			(V4L2_CID_CAMERA_CLASS_BASE+37)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
-- 
2.41.0

