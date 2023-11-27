Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC87FA163
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjK0Nv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjK0Nvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:51:51 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12778131;
        Mon, 27 Nov 2023 05:51:57 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ARDVR9d017714;
        Mon, 27 Nov 2023 14:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=O6LQdEvr7zQdDLFNs7fkq2PhCVX3l1VU2E90N6NZ87c=; b=kZ
        Nt9EsUWJSN2qQaL2b79aIbZ0zJY/iRqHmt9JYFn2viTzAHHK6dKPwDtSbbKJP/3I
        JZb6TJMkUdB9aKW+1OE7Myh+NyhDc9HrBI4RJ8QDWAhmla/f2uYEJ7R44D9pwjrE
        KusZ8IbXMqzAi1zC/0KHZvyiDOrHcxGWlFdce4WAMAsAhmxtcU1QE5c/EpA3A5yq
        SIkQ+CamNg+4xX4+fpbFg+2ccNpnAYkS0xb6WOcN2I5FBb6XWWDQWSqlLP67GJLB
        H7NQiOb2VPuRldpeHXW831OmO8ygwFe2SzeghIOPxm3qC3YbRCcdSjTQqVHPsw09
        MDgUZhHY2IhP86xGMiGA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk77kr5cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:51:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E55310002A;
        Mon, 27 Nov 2023 14:51:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25DE92291B9;
        Mon, 27 Nov 2023 14:51:49 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 27 Nov
 2023 14:51:48 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] media: i2c: st-vgxy61: Add V4L2_SUBDEV_FL_HAS_EVENTS and subscribe hooks
Date:   Mon, 27 Nov 2023 14:51:11 +0100
Message-ID: <20231127135113.1424113-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127135113.1424113-1-alain.volmat@foss.st.com>
References: <20231127135113.1424113-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_11,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any V4L2 subdevice that implements controls and declares
V4L2_SUBDEV_FL_HAS_DEVNODE should also declare V4L2_SUBDEV_FL_HAS_EVENTS
and implement subscribe_event and unsubscribe_event hooks.

With that done, v4l2-compliance testing is now ok.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-vgxy61.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
index 98d8975dcd67..c85fd580dcf4 100644
--- a/drivers/media/i2c/st-vgxy61.c
+++ b/drivers/media/i2c/st-vgxy61.c
@@ -21,6 +21,7 @@
 #include <media/v4l2-async.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
@@ -1464,6 +1465,11 @@ static int vgxy61_init_controls(struct vgxy61_dev *sensor)
 	return ret;
 }
 
+static const struct v4l2_subdev_core_ops vgxy61_core_ops = {
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
 static const struct v4l2_subdev_video_ops vgxy61_video_ops = {
 	.s_stream = vgxy61_s_stream,
 };
@@ -1477,6 +1483,7 @@ static const struct v4l2_subdev_pad_ops vgxy61_pad_ops = {
 };
 
 static const struct v4l2_subdev_ops vgxy61_subdev_ops = {
+	.core = &vgxy61_core_ops,
 	.video = &vgxy61_video_ops,
 	.pad = &vgxy61_pad_ops,
 };
@@ -1846,7 +1853,8 @@ static int vgxy61_probe(struct i2c_client *client)
 
 	v4l2_i2c_subdev_init(&sensor->sd, client, &vgxy61_subdev_ops);
 	sensor->sd.internal_ops = &vgxy61_internal_ops;
-	sensor->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sensor->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+			    V4L2_SUBDEV_FL_HAS_EVENTS;
 	sensor->pad.flags = MEDIA_PAD_FL_SOURCE;
 	sensor->sd.entity.ops = &vgxy61_subdev_entity_ops;
 	sensor->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
-- 
2.25.1

