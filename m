Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622076E363
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjHCImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjHCImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:42:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF1E7;
        Thu,  3 Aug 2023 01:42:00 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6DB4D4A;
        Thu,  3 Aug 2023 10:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691052055;
        bh=egXxbNnChhv3B43ArDJxxblwfAW0XcIBDvL/amPdS8M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NNB2lcdi4vLXuVOXd5LLJ7Ssv2mzREjUQJH2ZKy7Fkxwl3KuPNRBUYf9DcdFIrKTT
         VSrEK6bJnZ2TbPntimZthAigsNiFU7SuY56vRsLPEsHq1FmSyWjmnYrGy+G9aAKgIK
         5Q2m6mlUNdGjkgunjRKZWqmmidAxJhbw0KTVBRX0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 03 Aug 2023 11:41:38 +0300
Subject: [PATCH 1/2] media: i2c: ds90ub9x3: Fix use of uninitialized
 variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
In-Reply-To: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=egXxbNnChhv3B43ArDJxxblwfAW0XcIBDvL/amPdS8M=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky2hVCiT5ZSmCfesqk5bdJbl6+ncGJSNISqvnC
 mAvQuS3yWWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMtoVQAKCRD6PaqMvJYe
 9WfED/9GUcDLKyBaAol8r2Z6UJpzboB2urTpc/hF93xBeMK0A9c1nZvCv1B0lIh/IV/Dwbng/C4
 eG8U+4xI6npmVdoibnVapQD3dl7pkFWBjYm2MJ+fEC7IwBG4QZgLbS1OwoVSo6KzY3xg2UhxJ4m
 U505l/sb8Xho/cjvShfuWgkD6YvHkh3HPvKFyOofC7UKTOQBV2P+D4Mjf3MlicLnvgD3q/Rrn5K
 1gF4LVj7hLN5hq5sGYlzHnoJCAzf7m+YREAmyEk1lZYUVX2D2Eh4oKnH47XOTiVYr5zMNUuJURq
 dlUXdRDWIyq9lx2fO7AbDZQYUkUyxaEy/9kI5pbsHAoSG8BfWxNM6CAqytdtOd322zZ1SqyC1gr
 1ly1GO+o5fVbGegpNGZy0XigFPT800ihE0m51QOYGUPv59cYbRJbXNo5gbvcw9bd2Q2jbQdlJzq
 DHBKaCUBnbuhVnDmOiLSAS0cCieymwXf7R+kGUkJ+IRXuFFr2oC1A1p9wJheSxq/hhyZh8Ckp7M
 XXDT5Dp0G0lGdL3+cIXDIX+AA/NxQmQkptLQU15cMRznhVXshNZ+x26NUqY5+Mk1PLj2Tw9r6hw
 W7DagvJjgLSjCpt62U3mBZ+J0LvzKy5zUhYV0d9r4qrGGboj3gZf+xNGySI43SWPWWbfDzw46Md
 0ia9tPf3IG/KVqw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports some uninitialized variables:

drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v1'.
drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v2'.
drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_local_data'.
drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_input_ctrl'.
drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_pin_sts'.

These are used only for printing debug information, and the use of an
uninitialized variable only happens if an i2c transaction has failed,
which will print an error. Thus, fix the errors just by initializing the
variables to 0.

Fixes: 6363db1c9d45 ("media: i2c: add DS90UB953 driver")
Fixes: c158d0d4ff15 ("media: i2c: add DS90UB913 driver")
Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub913.c | 2 +-
 drivers/media/i2c/ds90ub953.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index 80d9cf6dd945..b2115e3519e2 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -469,7 +469,7 @@ static int ub913_log_status(struct v4l2_subdev *sd)
 {
 	struct ub913_data *priv = sd_to_ub913(sd);
 	struct device *dev = &priv->client->dev;
-	u8 v = 0, v1, v2;
+	u8 v = 0, v1 = 0, v2 = 0;
 
 	ub913_read(priv, UB913_REG_MODE_SEL, &v);
 	dev_info(dev, "MODE_SEL %#02x\n", v);
diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index cadf75eb0773..27471249a62a 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -593,9 +593,9 @@ static int ub953_log_status(struct v4l2_subdev *sd)
 	u8 v = 0, v1 = 0, v2 = 0;
 	unsigned int i;
 	char id[UB953_REG_FPD3_RX_ID_LEN];
-	u8 gpio_local_data;
-	u8 gpio_input_ctrl;
-	u8 gpio_pin_sts;
+	u8 gpio_local_data = 0;
+	u8 gpio_input_ctrl = 0;
+	u8 gpio_pin_sts = 0;
 
 	for (i = 0; i < sizeof(id); i++)
 		ub953_read(priv, UB953_REG_FPD3_RX_ID(i), &id[i]);

-- 
2.34.1

