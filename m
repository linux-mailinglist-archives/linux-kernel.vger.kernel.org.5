Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71ED76F4B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHCVo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHCVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:44:56 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 14:44:56 PDT
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97D30F8;
        Thu,  3 Aug 2023 14:44:55 -0700 (PDT)
Received: from fedori.lan (51b69adf.dsl.pool.telekom.hu [::ffff:81.182.154.223])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072E3A.0000000064CC1C4F.0001D18F; Thu, 03 Aug 2023 23:29:50 +0200
From:   =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>
Subject: [RFC PATCH 2/2] media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL
Date:   Thu,  3 Aug 2023 23:28:58 +0200
Message-ID: <550bf1a9adf175a166163d696e667165ce7db79f.1691096157.git.soyer@irl.hu>
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

Logitech Streamcam can be mounted in 'portrait mode' as well.
It reports the current roll (-90, 0, 90, 180) with
UVC_CT_ROLL_ABSOLUTE_CONTROL.

Map UVC_CT_ROLL_ABSOLUTE_CONTROL to V4L2_CID_ROLL_ABSOLUTE to
make it available to userspace.

Signed-off-by: Gergő Köteles <soyer@irl.hu>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5e9d3da862dd..2801a1ee04a2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -748,6 +748,15 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
 		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
 	},
+	{
+		.id		= V4L2_CID_ROLL_ABSOLUTE,
+		.entity		= UVC_GUID_UVC_CAMERA,
+		.selector	= UVC_CT_ROLL_ABSOLUTE_CONTROL,
+		.size		= 16,
+		.offset		= 0,
+		.v4l2_type	= V4L2_CTRL_TYPE_INTEGER,
+		.data_type	= UVC_CTRL_DATA_TYPE_SIGNED,
+	},
 };
 
 const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
-- 
2.41.0

