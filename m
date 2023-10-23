Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB77D41E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjJWVtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:49:34 -0400
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E810C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:49:32 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qv2nh-0004Kz-0O;
        Mon, 23 Oct 2023 23:49:29 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Mon, 23 Oct 2023 23:47:52 +0200
Subject: [PATCH 3/4] media: i2c: imx214: Read orientation and rotation from
 system firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231023-imx214-v1-3-b33f1bbd1fcf@apitzsch.eu>
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

Obtain rotation and orientation information from system firmware and
register the appropriate controls.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/media/i2c/imx214.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 554fc4733128..bef8dc36e2d0 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -704,9 +704,14 @@ static int imx214_ctrls_init(struct imx214 *imx214)
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
 	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 3);
 	if (ret)
@@ -746,6 +751,8 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 				V4L2_CID_UNIT_CELL_SIZE,
 				v4l2_ctrl_ptr_create((void *)&unit_size));
 
+	v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx214_ctrl_ops, &props);
+
 	ret = ctrl_hdlr->error;
 	if (ret) {
 		v4l2_ctrl_handler_free(ctrl_hdlr);

-- 
2.42.0

