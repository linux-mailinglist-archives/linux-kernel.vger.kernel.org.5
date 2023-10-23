Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE477D41E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjJWVth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjJWVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:49:35 -0400
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1555DE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:49:32 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qv2ng-0004Kz-2b;
        Mon, 23 Oct 2023 23:49:28 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Mon, 23 Oct 2023 23:47:51 +0200
Subject: [PATCH 2/4] media: i2c: imx214: Move controls init to separate
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
In-Reply-To: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code refinement, no functional changes.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/media/i2c/imx214.c | 111 ++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 9218c149d4c8..554fc4733128 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -695,6 +695,68 @@ static const struct v4l2_ctrl_ops imx214_ctrl_ops = {
 	.s_ctrl = imx214_set_ctrl,
 };
 
+static int imx214_ctrls_init(struct imx214 *imx214)
+{
+	static const s64 link_freq[] = {
+		IMX214_DEFAULT_LINK_FREQ
+	};
+	static const struct v4l2_area unit_size = {
+		.width = 1120,
+		.height = 1120,
+	};
+	struct v4l2_ctrl_handler *ctrl_hdlr;
+	int ret;
+
+	ctrl_hdlr = &imx214->ctrls;
+	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 3);
+	if (ret)
+		return ret;
+
+	imx214->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, NULL,
+					       V4L2_CID_PIXEL_RATE, 0,
+					       IMX214_DEFAULT_PIXEL_RATE, 1,
+					       IMX214_DEFAULT_PIXEL_RATE);
+
+	imx214->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr, NULL,
+						   V4L2_CID_LINK_FREQ,
+						   ARRAY_SIZE(link_freq) - 1,
+						   0, link_freq);
+	if (imx214->link_freq)
+		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	/*
+	 * WARNING!
+	 * Values obtained reverse engineering blobs and/or devices.
+	 * Ranges and functionality might be wrong.
+	 *
+	 * Sony, please release some register set documentation for the
+	 * device.
+	 *
+	 * Yours sincerely, Ricardo.
+	 */
+	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
+					     V4L2_CID_EXPOSURE,
+					     IMX214_EXPOSURE_MIN,
+					     IMX214_EXPOSURE_MAX,
+					     IMX214_EXPOSURE_STEP,
+					     IMX214_EXPOSURE_DEFAULT);
+
+	imx214->unit_size = v4l2_ctrl_new_std_compound(ctrl_hdlr,
+				NULL,
+				V4L2_CID_UNIT_CELL_SIZE,
+				v4l2_ctrl_ptr_create((void *)&unit_size));
+
+	ret = ctrl_hdlr->error;
+	if (ret) {
+		v4l2_ctrl_handler_free(ctrl_hdlr);
+		return dev_err_probe(imx214->dev, ret, "failed to add controls\n");
+	}
+
+	imx214->sd.ctrl_handler = ctrl_hdlr;
+
+	return 0;
+};
+
 #define MAX_CMD 4
 static int imx214_write_table(struct imx214 *imx214,
 			      const struct reg_8 table[])
@@ -918,13 +980,6 @@ static int imx214_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct imx214 *imx214;
-	static const s64 link_freq[] = {
-		IMX214_DEFAULT_LINK_FREQ,
-	};
-	static const struct v4l2_area unit_size = {
-		.width = 1120,
-		.height = 1120,
-	};
 	int ret;
 
 	ret = imx214_parse_fwnode(dev);
@@ -979,48 +1034,10 @@ static int imx214_probe(struct i2c_client *client)
 	pm_runtime_enable(imx214->dev);
 	pm_runtime_idle(imx214->dev);
 
-	v4l2_ctrl_handler_init(&imx214->ctrls, 3);
-
-	imx214->pixel_rate = v4l2_ctrl_new_std(&imx214->ctrls, NULL,
-					       V4L2_CID_PIXEL_RATE, 0,
-					       IMX214_DEFAULT_PIXEL_RATE, 1,
-					       IMX214_DEFAULT_PIXEL_RATE);
-	imx214->link_freq = v4l2_ctrl_new_int_menu(&imx214->ctrls, NULL,
-						   V4L2_CID_LINK_FREQ,
-						   ARRAY_SIZE(link_freq) - 1,
-						   0, link_freq);
-	if (imx214->link_freq)
-		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-
-	/*
-	 * WARNING!
-	 * Values obtained reverse engineering blobs and/or devices.
-	 * Ranges and functionality might be wrong.
-	 *
-	 * Sony, please release some register set documentation for the
-	 * device.
-	 *
-	 * Yours sincerely, Ricardo.
-	 */
-	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
-					     V4L2_CID_EXPOSURE,
-					     IMX214_EXPOSURE_MIN,
-					     IMX214_EXPOSURE_MAX,
-					     IMX214_EXPOSURE_STEP,
-					     IMX214_EXPOSURE_DEFAULT);
-
-	imx214->unit_size = v4l2_ctrl_new_std_compound(&imx214->ctrls,
-				NULL,
-				V4L2_CID_UNIT_CELL_SIZE,
-				v4l2_ctrl_ptr_create((void *)&unit_size));
-	ret = imx214->ctrls.error;
-	if (ret) {
-		dev_err(&client->dev, "%s control init failed (%d)\n",
-			__func__, ret);
+	ret = imx214_ctrls_init(imx214);
+	if (ret < 0)
 		goto free_ctrl;
-	}
 
-	imx214->sd.ctrl_handler = &imx214->ctrls;
 	mutex_init(&imx214->mutex);
 	imx214->ctrls.lock = &imx214->mutex;
 

-- 
2.42.0

