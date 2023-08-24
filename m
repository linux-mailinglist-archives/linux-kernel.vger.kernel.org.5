Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB26786DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjHXL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjHXL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:27:18 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4710F3;
        Thu, 24 Aug 2023 04:27:16 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bca018afe8so1629696a34.0;
        Thu, 24 Aug 2023 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876435; x=1693481235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoX/1SqxDvI7G80pdYJhH4J1CONUc0UeZCbshQ9Td9o=;
        b=mLfi8Zk7uVlgAUg7qCr6D5cmpwiFbHNFqs0Ab58xc/IcDknZLrLQjRjarQjvbqyOXh
         jMKy3tyitZ6E5MrbALXilBKs0tqhsSr+aSSTw8yrnTrovu9WCLOeR7HWch9M3RpMtGa7
         TH8xzN9YShfEB1BO0Y/ijHPqqTeZeb7qCivj+gtIvB5kaxIzXo3PJgRS8MmMg+GIj8qz
         BMTbK/h1quUxcJkYbLK5zG+PXM46bZ7Fpl5FjegYWzIeUny+dDAZnYGHRl8UNq0Bjlhc
         stNPvHhNjAkFCp3dOGajJnUk0FYohMlaI+uDCliACr2tdVYzos2wOyxkSw3So1tLqr8J
         s5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876435; x=1693481235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoX/1SqxDvI7G80pdYJhH4J1CONUc0UeZCbshQ9Td9o=;
        b=Cb6RPtlFBS89DHsTugKJ43CPB+IH0dDoBy3VSKBXZPuYF9bfkkebP9O7AcJyIIe4R8
         Z9IcwmZhApkhhmUAA+Jf/wVQu1Yz45AmK8L+nkb0aScIMdOhtm+xFvGtRyLX3gjbDSso
         sYxZnGmB/SvjwbWjbKbwkzXBSua/ODRkTU3HDZEM5ziPTUoq3NixaWuR4cxviF0NZERJ
         2QQIgcVAd2n9y7Mo9dfpXrE9Gw1/7dJ0mBRsN6UDaSv0XiEEun7NkvNiC9E8SIJO1O09
         jRTUZSbl1iV+tafXGjTR8fDwUFHOmE5gip2WeL1doZxuz/EC2Ojg5KuGZ/V9CY2DXv6e
         eqLg==
X-Gm-Message-State: AOJu0YyOCzS4q2t9yVBFRLr21oCxVmu1k4aXmuuUllO4Kp3X3KLHtw37
        9AJy2gQ0jslAy6MhlOj3GGodMtXi6jk=
X-Google-Smtp-Source: AGHT+IHF0VFZPTm/p/IU3XRMQd1DYFEMeND9nfqMLQIC5tv06ttFVnzhZWeaHrzOVEeOd3x3Ovd/6g==
X-Received: by 2002:a05:6871:5223:b0:1bf:fe4f:db58 with SMTP id ht35-20020a056871522300b001bffe4fdb58mr19335561oac.5.1692876435653;
        Thu, 24 Aug 2023 04:27:15 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8c51:3a01:4599:db3])
        by smtp.gmail.com with ESMTPSA id bp4-20020a056808238400b003a8715d7f9esm2160567oib.19.2023.08.24.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:27:15 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] thermal: imx8mm: Allow reboot after critical temperature
Date:   Thu, 24 Aug 2023 08:27:05 -0300
Message-Id: <20230824112705.451411-1-festevam@gmail.com>
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

Currently, after the board reaches the critical temperature, the system
goes through a poweroff mechanism.

In some cases, such behavior does not suit well, as the board may be
unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce a reboot_on_critical parameter to indicate that the board
will go through a reboot after the critical temperature is reached.

When this parameter is not selected, the default behavior of forcing a
shutdown is preserved.

Tested on a imx8mm-evk board by passing 'imx8mm_thermal.reboot_on_critical'
via kernel command line.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Introduce a module_param() instead of a devicetree property.

 drivers/thermal/imx8mm_thermal.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e89b11b3f2b9..2427bd46ac6c 100644
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
@@ -146,8 +153,20 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return tmu->socdata->get_temp(sensor, temp);
 }
 
+static void tmu_critical(struct thermal_zone_device *tz)
+{
+	if (reboot_on_critical) {
+		dev_emerg(thermal_zone_device(tz), "%s: critical temperature reached\n",
+			  thermal_zone_device_type(tz));
+		kernel_restart(NULL);
+	} else {
+		thermal_zone_device_critical(tz);
+	}
+}
+
 static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
+	.critical = tmu_critical,
 };
 
 static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
-- 
2.34.1

