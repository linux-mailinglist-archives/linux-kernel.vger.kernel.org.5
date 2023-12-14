Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09C681287D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443269AbjLNGur convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 01:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjLNGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:50:36 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2596E8;
        Wed, 13 Dec 2023 22:50:39 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9D252814B;
        Thu, 14 Dec 2023 14:50:38 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:38 +0800
Received: from ubuntu.mshome.net (113.72.145.168) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:35 +0800
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
Subject: [PATCH v1 4/9] staging: media: starfive: camss: Replace format index with pad
Date:   Wed, 13 Dec 2023 22:50:22 -0800
Message-ID: <20231214065027.28564-5-changhuang.liang@starfivetech.com>
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

Replace format index with pad.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-isp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index ac83f23842df..c3ae02cf6dd8 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -11,9 +11,6 @@
 
 #include "stf-camss.h"
 
-#define SINK_FORMATS_INDEX	0
-#define SOURCE_FORMATS_INDEX	1
-
 static int isp_set_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *state,
 			     struct v4l2_subdev_selection *sel);
@@ -95,11 +92,7 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
 		return;
 	}
 
-	if (pad == STF_ISP_PAD_SINK)
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
-	else if (pad == STF_ISP_PAD_SRC)
-		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
-
+	formats = &isp_dev->formats[pad];
 	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
 			     STFCAMSS_FRAME_MAX_WIDTH);
 	fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
@@ -124,7 +117,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		if (code->index >= ARRAY_SIZE(isp_formats_sink))
 			return -EINVAL;
 
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		formats = &isp_dev->formats[code->pad];
 		code->code = formats->fmts[code->index].code;
 	} else {
 		struct v4l2_mbus_framefmt *sink_fmt;
-- 
2.25.1

