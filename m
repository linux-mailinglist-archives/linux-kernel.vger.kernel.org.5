Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40892807B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377631AbjLFWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377604AbjLFWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:38:59 -0500
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de [80.67.31.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4510C3;
        Wed,  6 Dec 2023 14:39:04 -0800 (PST)
Received: from [92.206.191.209] (helo=note-book.lan)
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1rB0TI-0007Ur-12;
        Wed, 06 Dec 2023 23:34:24 +0100
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Wed, 06 Dec 2023 23:33:57 +0100
Subject: [PATCH v4 3/4] media: i2c: imx214: Read orientation and rotation
 from system firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-imx214-v4-3-7ef604b01dcb@apitzsch.eu>
References: <20231206-imx214-v4-0-7ef604b01dcb@apitzsch.eu>
In-Reply-To: <20231206-imx214-v4-0-7ef604b01dcb@apitzsch.eu>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obtain rotation and orientation information from system firmware and
register the appropriate controls. While at it, update number of
pre-allocated control slots.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/media/i2c/imx214.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index e460030a601b..132267e3a8f5 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -704,11 +704,16 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 		.width = 1120,
 		.height = 1120,
 	};
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	int ret;
 
+	ret = v4l2_fwnode_device_parse(imx214->dev, &props);
+	if (ret < 0)
+		return ret;
+
 	ctrl_hdlr = &imx214->ctrls;
-	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 3);
+	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 6);
 	if (ret)
 		return ret;
 
@@ -746,6 +751,8 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 				V4L2_CID_UNIT_CELL_SIZE,
 				v4l2_ctrl_ptr_create((void *)&unit_size));
 
+	v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx214_ctrl_ops, &props);
+
 	ret = ctrl_hdlr->error;
 	if (ret) {
 		v4l2_ctrl_handler_free(ctrl_hdlr);

-- 
2.43.0

