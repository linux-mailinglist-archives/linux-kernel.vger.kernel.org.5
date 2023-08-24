Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45D786EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbjHXMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbjHXMVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:21:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C351170F;
        Thu, 24 Aug 2023 05:21:13 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a889485117so144206b6e.1;
        Thu, 24 Aug 2023 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692879672; x=1693484472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJjDYi526dyuJbfu3Q5q3ouhJnvi2sl1oLR0pSnKiyU=;
        b=sF5xKaY4i/UT1PG06J41CVtupxPri04W6rl7Bfa09jSrcE6q0NWlIooS3QWq7T/NVi
         r2Qw0bBNio99KKgg3p7xVZdjKhaJsBs5iBNWEN0sdBhW/XkkymfuZKNrTXitcwZIwR9/
         h6Wjg/Qi98rut3a2j9KFjVyhFX29eV8cAqYEmVEfpkpCsZSooEPmDqXdKLMmG52FGcE4
         EO+B1iI6NhFsiXOkFqWEqUL9x80AdGsgILLoLhejKt6+kN+L22ixCSF+FBkaGfGpB1Ci
         tsGu8QKFpFNPxBLRbKyWIS7UCzljhrvpOr3NuhSmdc5XuGMvzYvvPYCVG/Inrk6Yr8C/
         dvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879672; x=1693484472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJjDYi526dyuJbfu3Q5q3ouhJnvi2sl1oLR0pSnKiyU=;
        b=mAeuXk4YLptL3v2JMXh+xZNKC4d/H6SIewZuKb+/ZYp/5802q/Fs3c01LZon1pCtWk
         1Rg8P7UqiYYexjA0RauZ+F9ni9WV6IUTC9e137rddpWd/oLfQ72X345wIGqnqNeK0byZ
         Aphzb7iRkw6TJbXKuS9Js1Q3MiijXFXmU4bWNaS9CsmjFJdip738QjjeK8Rlf/9rAlk/
         rsJsYdjK5z6sKoexqQM8vvuqLtcIki5L4s3IETu8Unnsv4Iq/70US8jMVyHZsOnBWwIg
         HAyeKuMDFUZvaKUC9MWMOPshRXXug4vE8buPDHJckbVrczBVTrWOqFlzBvpu69lLSFUG
         Ub5w==
X-Gm-Message-State: AOJu0YxjVpmSVwtVHY0TMP62VHdBmKOFoSjqAbTCu370UzPDqFxnKwj1
        s92/5xzJN9ug5rjoNpjq248=
X-Google-Smtp-Source: AGHT+IFqNdELyxrV5wVgVO4XIymYcMbmcoYapnlSHCSOVP0vvdvUlyDC7hldV4I12jOh/w/QRSwVnA==
X-Received: by 2002:a05:6808:2009:b0:3a8:901e:c5a with SMTP id q9-20020a056808200900b003a8901e0c5amr1972605oiw.0.1692879672474;
        Thu, 24 Aug 2023 05:21:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8c51:3a01:4599:db3])
        by smtp.gmail.com with ESMTPSA id a18-20020a05680804d200b003a862e70bcbsm3747170oie.13.2023.08.24.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:21:11 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] thermal: imx8mm: Allow reboot after critical temperature
Date:   Thu, 24 Aug 2023 09:21:02 -0300
Message-Id: <20230824122102.474550-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Currently, after the SoC reaches the critical temperature, the board
goes through a poweroff mechanism.

In some cases, such behavior does not suit well, as the board may be
unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce a reboot_on_critical parameter to indicate that the board
will go through a reboot after the critical temperature is reached.

When this parameter is not passed, the default behavior of forcing a
shutdown is preserved.

Tested on a imx8mm-evk board by passing 'imx8mm_thermal.reboot_on_critical'
via kernel command line.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Set the .critical ops at init time and get rid of the
thermal_zone_device_critical(tz) call. (Daniel)

 drivers/thermal/imx8mm_thermal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e89b11b3f2b9..f156e6e81abc 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -10,9 +10,11 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
@@ -75,6 +77,11 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
+static bool reboot_on_critical;
+module_param(reboot_on_critical, bool, 0444);
+MODULE_PARM_DESC(reboot_on_critical,
+		 "Reboot the system after the critical temperature is reached.");
+
 struct thermal_soc_data {
 	u32 num_sensors;
 	u32 version;
@@ -146,7 +153,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return tmu->socdata->get_temp(sensor, temp);
 }
 
-static const struct thermal_zone_device_ops tmu_tz_ops = {
+static struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -293,6 +300,13 @@ static int imx8mm_tmu_probe_set_calib(struct platform_device *pdev,
 	return imx8mm_tmu_probe_set_calib_v2(pdev, tmu);
 }
 
+static void tmu_critical(struct thermal_zone_device *tz)
+{
+	dev_emerg(thermal_zone_device(tz), "%s: critical temperature reached\n",
+		  thermal_zone_device_type(tz));
+	kernel_restart(NULL);
+}
+
 static int imx8mm_tmu_probe(struct platform_device *pdev)
 {
 	const struct thermal_soc_data *data;
@@ -327,6 +341,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	/* disable the monitor during initialization */
 	imx8mm_tmu_enable(tmu, false);
 
+	if (reboot_on_critical)
+		tmu_tz_ops.critical = tmu_critical;
+
 	for (i = 0; i < data->num_sensors; i++) {
 		tmu->sensors[i].priv = tmu;
 		tmu->sensors[i].tzd =
-- 
2.34.1

