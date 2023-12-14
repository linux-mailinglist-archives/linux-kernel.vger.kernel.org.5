Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267ED81288A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443332AbjLNGvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 01:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443250AbjLNGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:50:44 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464EB9;
        Wed, 13 Dec 2023 22:50:50 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6EE82819B;
        Thu, 14 Dec 2023 14:50:49 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:49 +0800
Received: from ubuntu.mshome.net (113.72.145.168) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:46 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Marvin Lin" <milkfafa@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Ming Qian" <ming.qian@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v1 8/9] staging: media: starfive: Add frame sync event for video capture device
Date:   Wed, 13 Dec 2023 22:50:26 -0800
Message-ID: <20231214065027.28564-9-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
References: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.168]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add frame sync event for video capture device.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-capture.c    |  9 +++++++++
 drivers/staging/media/starfive/camss/stf-video.c  | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 6a137a273c8a..d0be769da11b 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
  */
 
+#include <media/v4l2-event.h>
 #include "stf-camss.h"
 
 static const char * const stf_cap_names[] = {
@@ -430,10 +431,15 @@ static void stf_buf_flush(struct stf_v_buf *output, enum vb2_buffer_state state)
 
 static void stf_buf_done(struct stf_v_buf *output)
 {
+	struct stf_capture *cap = container_of(output, struct stf_capture,
+					       buffers);
 	struct stfcamss_buffer *ready_buf;
 	struct stfcamss *stfcamss = cap->video.stfcamss;
 	u64 ts = ktime_get_ns();
 	unsigned long flags;
+	struct v4l2_event event = {
+		.type = V4L2_EVENT_FRAME_SYNC,
+	};
 
 	if (output->state == STF_OUTPUT_OFF ||
 	    output->state == STF_OUTPUT_RESERVED)
@@ -445,6 +451,9 @@ static void stf_buf_done(struct stf_v_buf *output)
 		if (cap->type == STF_CAPTURE_SCD)
 			stf_isp_fill_yhist(stfcamss, ready_buf->vaddr_sc);
 
+		event.u.frame_sync.frame_sequence = output->sequence;
+		v4l2_event_queue(&cap->video.vdev, &event);
+
 		ready_buf->vb.vb2_buf.timestamp = ts;
 		ready_buf->vb.sequence = output->sequence++;
 
diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 54d855ba0b57..32381e9ad049 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -507,6 +507,17 @@ static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	return __video_try_fmt(video, f);
 }
 
+static int video_subscribe_event(struct v4l2_fh *fh,
+				 const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_FRAME_SYNC:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct v4l2_ioctl_ops stf_vid_ioctl_ops = {
 	.vidioc_querycap                = video_querycap,
 	.vidioc_enum_fmt_vid_cap        = video_enum_fmt,
@@ -523,6 +534,8 @@ static const struct v4l2_ioctl_ops stf_vid_ioctl_ops = {
 	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
 	.vidioc_streamon                = vb2_ioctl_streamon,
 	.vidioc_streamoff               = vb2_ioctl_streamoff,
+	.vidioc_subscribe_event         = video_subscribe_event,
+	.vidioc_unsubscribe_event       = v4l2_event_unsubscribe,
 };
 
 static int video_scd_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
@@ -554,6 +567,8 @@ static const struct v4l2_ioctl_ops stf_vid_scd_ioctl_ops = {
 	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
 	.vidioc_streamon                = vb2_ioctl_streamon,
 	.vidioc_streamoff               = vb2_ioctl_streamoff,
+	.vidioc_subscribe_event         = video_subscribe_event,
+	.vidioc_unsubscribe_event       = v4l2_event_unsubscribe,
 };
 
 /* -----------------------------------------------------------------------------
-- 
2.25.1

