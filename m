Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331377F4F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbjKVSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:16:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1D101;
        Wed, 22 Nov 2023 10:16:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00a9c6f283so4230866b.0;
        Wed, 22 Nov 2023 10:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700676972; x=1701281772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNKke+f9nL2R7UOg+skl46azWZAH5Kx0OODrdJmgO9Y=;
        b=KGIbPNBJr5FbJgdMDDDsnN38tkqOgR8odObVsNx0C/MtxAk0IGNu+C6Mxi8/22ZfQw
         3/KUBKGD/zeOT8+7DwUUQl11qgHp9BVzAr4Iy8IqsbolUPITkN3KdkmbEQSiAEFtpSA2
         /cl4N5c3ZsqgsnNhjgo9+gJQb8U3zvDOobHoSkkUceAaM1nLvmActCjxiNvS21O5cu4n
         //Quh5+bM7OLaXxXxMyAWFubKglRLydV0EetQ//4UD2tdVRtbDZ4tw8tf68y+npDg9/F
         8AKo82XHc7l9MmGxFLtVZ3LpPafH/jvK9vnFB0Gfmjw+DvNAcHwB726wTFYfGQRol9l6
         yeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676972; x=1701281772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNKke+f9nL2R7UOg+skl46azWZAH5Kx0OODrdJmgO9Y=;
        b=ez93Cnh7GHG0HB4EYg7gdBZmSfaBYkMFF20CZX8nidkHvRv7++ktTOeyMes9XyPFcl
         rOR8dm8Z+ZrE9ItSHMyfcQ6AbaKek5lBUi3KzopnEXNsV5K45i6ykZeXdt+Q0iLnQhlG
         OkE5PqUjfZANRa/LUI5XZYCt8/6degByKU1OnCR4/+JkBfnxsbIKjqXF11SfNOWHSPrj
         75brDnPo6lhqvVvPEUMymU1yOoa13uFO4ReR0o9PxDndgUFnQOkoC0vF4c7Ssm13i/ev
         m6m3FNJO3Wk18DUTewM4d4E9ZCFuHcJYNElIqjKQ5EMH6V/NoVuvyBHhStUOgKq110l9
         xqXA==
X-Gm-Message-State: AOJu0YyBx2wz2cBUl1sQtHautu5HeIEft+U8dlEzdf9mf/5alKyvKlD8
        hy33CCq55kaq4uZwSF3Trs4=
X-Google-Smtp-Source: AGHT+IESN7cv5Y61ltIYgxy4Ue/k1QB7/lQaZZNOrceCaK4bcKpNyGK5316b1QJUoAyTU0RcmMfsFg==
X-Received: by 2002:a17:907:c002:b0:9fd:deec:a273 with SMTP id ss2-20020a170907c00200b009fddeeca273mr2574627ejc.25.1700676972221;
        Wed, 22 Nov 2023 10:16:12 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:e883:3641:f460:3a14])
        by smtp.gmail.com with ESMTPSA id e23-20020a1709062c1700b009fc0c42098csm44682ejh.173.2023.11.22.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:16:11 -0800 (PST)
From:   Stefan Eichenberger <eichest@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv8803: Add power management support
Date:   Wed, 22 Nov 2023 19:16:11 +0100
Message-Id: <20231122181611.164792-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power management support to the driver. This allows a SoC to wake
from suspend using the nINT provided by the RTC. Only register it as a
wakeup device if the interrupt is provided and handled.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/rtc/rtc-rv8803.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 1a3ec1bb5b814..11e6b0d31f5d7 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/rtc.h>
+#include <linux/pm_wakeirq.h>
 
 #define RV8803_I2C_TRY_COUNT		4
 
@@ -607,6 +608,28 @@ static int rv8803_regs_configure(struct rv8803_data *rv8803)
 	return 0;
 }
 
+static int rv8803_resume(struct device *dev)
+{
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+
+	if (rv8803->client->irq > 0 && device_may_wakeup(dev))
+		disable_irq_wake(rv8803->client->irq);
+
+	return 0;
+}
+
+static int rv8803_suspend(struct device *dev)
+{
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+
+	if (rv8803->client->irq > 0 && device_may_wakeup(dev))
+		enable_irq_wake(rv8803->client->irq);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rv8803_pm_ops, rv8803_suspend, rv8803_resume);
+
 static const struct i2c_device_id rv8803_id[] = {
 	{ "rv8803", rv_8803 },
 	{ "rv8804", rx_8804 },
@@ -683,6 +706,11 @@ static int rv8803_probe(struct i2c_client *client)
 		if (err) {
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
 			client->irq = 0;
+		} else {
+			device_init_wakeup(&client->dev, true);
+			err = dev_pm_set_wake_irq(&client->dev, client->irq);
+			if (err)
+				dev_err(&client->dev, "failed to set wake IRQ\n");
 		}
 	}
 	if (!client->irq)
@@ -737,6 +765,7 @@ static struct i2c_driver rv8803_driver = {
 	.driver = {
 		.name = "rtc-rv8803",
 		.of_match_table = of_match_ptr(rv8803_of_match),
+		.pm = &rv8803_pm_ops,
 	},
 	.probe		= rv8803_probe,
 	.id_table	= rv8803_id,
-- 
2.40.1

