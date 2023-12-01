Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D6801258
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379060AbjLASOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:14:33 -0500
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3A10D;
        Fri,  1 Dec 2023 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1701454446; bh=8ItrQJpfnYJNBvx9/ZxfYVCB4X1PSHGmZpReeVMVCbM=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=BlRJe1XoLRRfLfBlqX9FKJXDcczc9GjGwiHexrrf2wJDGyH4QwQYFcMP2gml325Ew
         x7N8QzhHSsMKY7CiqKsYPa6vBzklsiX/NIoj3ILcNFVOLU8i9gQdnDCOwfhj/oiF8Q
         B3zFDEDOCYN62u80TcrXeY4f3rb7yGbgSSfNzuis=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Fri,  1 Dec 2023 19:14:05 +0100 (CET)
X-EA-Auth: ym1ciIqVgZ9eNjymoAMtLEFtuPM6bDp74qWVWVEHmy5LVtFvlqvwNHZnHGLyOdmKhJr18Ui7S9JftJCkKqCam+ZcJB/sbMs1XtBetbwXJJ0=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 3/3] media: i2c: ak7375: Add support for ak7345
Date:   Fri,  1 Dec 2023 19:13:50 +0100
Message-ID: <20231201181350.26454-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201181350.26454-1-vincent.knecht@mailoo.org>
References: <20231201181350.26454-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ak7345 VCM, which has 9 bits position values,
longer power-up delay, and no known standby register setting.
Might be compatible as-is with ak7348.

Tested on msm8916-alcatel-idol347 phone.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2: no change
---
 drivers/media/i2c/ak7375.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
index 3a14eff41531..9a2432cea3ff 100644
--- a/drivers/media/i2c/ak7375.c
+++ b/drivers/media/i2c/ak7375.c
@@ -16,6 +16,7 @@ struct ak73xx_chipdef {
 	u8 shift_pos;
 	u8 mode_active;
 	u8 mode_standby;
+	bool has_standby;	/* Some chips may not have standby mode */
 	u16 focus_pos_max;
 	/*
 	 * This sets the minimum granularity for the focus positions.
@@ -37,12 +38,26 @@ struct ak73xx_chipdef {
 	u16 power_delay_us;
 };
 
+static const struct ak73xx_chipdef ak7345_cdef = {
+	.reg_position	= 0x0,
+	.reg_cont	= 0x2,
+	.shift_pos	= 7,	/* 9 bits position values, need to << 7 */
+	.mode_active	= 0x0,
+	.has_standby	= false,
+	.focus_pos_max	= 511,
+	.focus_steps	= 1,
+	.ctrl_steps	= 16,
+	.ctrl_delay_us	= 1000,
+	.power_delay_us	= 20000,
+};
+
 static const struct ak73xx_chipdef ak7375_cdef = {
 	.reg_position	= 0x0,
 	.reg_cont	= 0x2,
 	.shift_pos	= 4,	/* 12 bits position values, need to << 4 */
 	.mode_active	= 0x0,
 	.mode_standby	= 0x40,
+	.has_standby	= true,
 	.focus_pos_max	= 4095,
 	.focus_steps	= 1,
 	.ctrl_steps	= 64,
@@ -249,10 +264,12 @@ static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
 		usleep_range(cdef->ctrl_delay_us, cdef->ctrl_delay_us + 10);
 	}
 
-	ret = ak7375_i2c_write(ak7375_dev, cdef->reg_cont,
-			       cdef->mode_standby, 1);
-	if (ret)
-		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
+	if (cdef->has_standby) {
+		ret = ak7375_i2c_write(ak7375_dev, cdef->reg_cont,
+				       cdef->mode_standby, 1);
+		if (ret)
+			dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
+	}
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(ak7375_supply_names),
 				     ak7375_dev->supplies);
@@ -312,6 +329,7 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
 }
 
 static const struct of_device_id ak7375_of_table[] = {
+	{ .compatible = "asahi-kasei,ak7345", .data = &ak7345_cdef, },
 	{ .compatible = "asahi-kasei,ak7375", .data = &ak7375_cdef, },
 	{ /* sentinel */ }
 };
-- 
2.43.0



