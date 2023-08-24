Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF47871CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjHXOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbjHXOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:37:02 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6088193;
        Thu, 24 Aug 2023 07:37:00 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso1216646fac.0;
        Thu, 24 Aug 2023 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692887820; x=1693492620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tE5urQmLOnciHXtitwRyqKhpUKhIg/sORznqPn+7MY=;
        b=M6a9jQ0lrv/aU5IjWIMXwP7EB3uYJ3sTkTPEHC3zJVsB2grEEXRnkVUybpesULHcmU
         v5NRfv7Oj6xqwyQBhUOa7WeUiTXhAWv/cwYjOt7PfkbSiyx86wFdwXQCt9oonq1ZWDFO
         uaZDLxUKEuMKQMTktLQPjrmWwpIx18fF+WgGi4ki9CTeqeMAptZFGJ142vH3j2J2xr7O
         DPG7hJwhgwejSko4wR5UmeMN9n8diJ97YisfeB8ojtou4Ifoeq+95QfPrr6V5vsil+19
         4jQ6Ll0SMoK7+HEleFRawQXRUHJLn7LrO5ucGrDxc8XOfRMM82nkJCIkBGqeXMrgpVsh
         hwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887820; x=1693492620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tE5urQmLOnciHXtitwRyqKhpUKhIg/sORznqPn+7MY=;
        b=gBmqFdha9FT+QXgGlZdtcQDqFQaasp7v4Ibj5hh8dmIUZ2SpTacVvfUAVLbD5ju7wG
         nyhUpwxel8AmckjKdfEK/X2Y/ebXhttUk+vCZqiFUlUyA6ibWeA5aY96eBrhjvZ/+Fbq
         9gybKeDGG4LBeRVcSo3YL0OIYg40H79F0yxvBzH/upIY0Z266H8ZDmJRY8XEWW/bl8AP
         VEavRhBPUrnJXR3wcIJZGQ+zWEXIqYy87TEyorDiHE7PFmdbTwCxnqQEioJDPPM8pkgc
         dv4yq4S3B4CpMUcB6IUz+sqBiGIs2b/9cxPG9Vrp7LloPBWWgu6AgIFs2COuwrOA97YX
         lpiw==
X-Gm-Message-State: AOJu0YzRP7PvbREkvRugBr3OAbf1HbC07mTSi1CYGRONphynVm1Jumpw
        UVStjjmXAOt8EBQSsIN74Lk=
X-Google-Smtp-Source: AGHT+IGScxhSj64wzOKTUF/kjCoE+4F464sfIi5/Ag7EgDaLadEW7LdfqO1H8GqCC1wrOYBTOZFxqA==
X-Received: by 2002:a05:6870:56a8:b0:1bb:b9d1:37fe with SMTP id p40-20020a05687056a800b001bbb9d137femr17847622oao.2.1692887819863;
        Thu, 24 Aug 2023 07:36:59 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8c51:3a01:4599:db3])
        by smtp.gmail.com with ESMTPSA id n6-20020a05687104c600b001ccb5ea6ee5sm2916558oai.55.2023.08.24.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:36:59 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v4] thermal: imx8mm: Allow reboot after critical temperature
Date:   Thu, 24 Aug 2023 11:36:52 -0300
Message-Id: <20230824143652.529624-1-festevam@gmail.com>
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

Introduce a 'reboot_on_crit' sysfs entry to indicate that the board
will go through a reboot after the critical temperature is reached.

By default, the original shutdown behavior is preserved.

Tested on a imx8mm-evk board by issuing the command below:

echo 1 > /sys/devices/platform/soc@0/30000000.bus/30260000.tmu/reboot_on_crit

Confirmed that it goes through a reboot after the critical temperature
is reached.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v3:
- Add a sysfs entry.

 drivers/thermal/imx8mm_thermal.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e89b11b3f2b9..07c6d21147ba 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
+#include <linux/reboot.h>
 
 #include "thermal_hwmon.h"
 
@@ -91,6 +92,7 @@ struct imx8mm_tmu {
 	void __iomem *base;
 	struct clk *clk;
 	const struct thermal_soc_data *socdata;
+	bool reboot;
 	struct tmu_sensor sensors[];
 };
 
@@ -146,8 +148,58 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return tmu->socdata->get_temp(sensor, temp);
 }
 
+static ssize_t reboot_on_crit_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct imx8mm_tmu *tmu = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", tmu->reboot);
+}
+
+static ssize_t reboot_on_crit_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct imx8mm_tmu *tmu = dev_get_drvdata(dev);
+	int ret, reboot;
+
+	ret = kstrtoint(buf, 0, &reboot);
+	if (ret < 0)
+		return ret;
+
+	tmu->reboot = reboot;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(reboot_on_crit);
+
+static struct attribute *reboot_on_crit_attrs[] = {
+	&dev_attr_reboot_on_crit.attr,
+	NULL
+};
+
+static const struct attribute_group reboot_attribute_group = {
+	.attrs = reboot_on_crit_attrs,
+};
+
+static void tmu_critical(struct thermal_zone_device *tz)
+{
+	struct tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct imx8mm_tmu *tmu = sensor->priv;
+
+	if (tmu->reboot) {
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
@@ -355,6 +407,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	if (tmu->socdata->version == TMU_VER2)
 		imx8mm_tmu_probe_sel_all(tmu);
 
+	ret = sysfs_create_group(&pdev->dev.kobj, &reboot_attribute_group);
+	if (ret)
+		goto disable_clk;
+
 	/* enable the monitor */
 	imx8mm_tmu_enable(tmu, true);
 
@@ -372,6 +428,7 @@ static int imx8mm_tmu_remove(struct platform_device *pdev)
 	/* disable TMU */
 	imx8mm_tmu_enable(tmu, false);
 
+	sysfs_remove_group(&pdev->dev.kobj, &reboot_attribute_group);
 	clk_disable_unprepare(tmu->clk);
 	platform_set_drvdata(pdev, NULL);
 
-- 
2.34.1

