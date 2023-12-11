Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCDD80C4F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjLKJn1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 04:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:43:25 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102ABD1;
        Mon, 11 Dec 2023 01:43:32 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C4AA624DC33;
        Mon, 11 Dec 2023 17:43:30 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 11 Dec
 2023 17:43:30 +0800
Received: from ubuntu.localdomain (183.27.97.57) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 11 Dec
 2023 17:43:29 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] media: cadence: csi2rx: Add enum_mbus_code pad ops
Date:   Mon, 11 Dec 2023 01:43:29 -0800
Message-ID: <20231211094329.9090-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.57]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum_mbus_code ioctl so that user space can know what
formats are supported to csi2rx.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 889f4fbbafb3..7788ce0e3171 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -389,6 +389,18 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	return ret;
 }
 
+static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
+				 struct v4l2_subdev_state *state,
+				 struct v4l2_subdev_mbus_code_enum *code_enum)
+{
+	if (code_enum->index >= ARRAY_SIZE(formats))
+		return -EINVAL;
+
+	code_enum->code = formats[code_enum->index].code;
+
+	return 0;
+}
+
 static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 			  struct v4l2_subdev_state *state,
 			  struct v4l2_subdev_format *format)
@@ -439,6 +451,7 @@ static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
 }
 
 static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
+	.enum_mbus_code	= csi2rx_enum_mbus_code,
 	.get_fmt	= v4l2_subdev_get_fmt,
 	.set_fmt	= csi2rx_set_fmt,
 	.init_cfg	= csi2rx_init_cfg,
-- 
2.25.1

