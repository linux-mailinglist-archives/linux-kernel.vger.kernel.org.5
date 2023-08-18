Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8482578074C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358654AbjHRIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358651AbjHRIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:38:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611730F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:38:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so6452965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347891; x=1692952691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8v8yPa3137/niC26eiAKunSGrUVi6KH36COCn9q7Zlo=;
        b=e89hl2B+CkgrFStNqGY9X2vXTXCbtTxFrwnnX2+e0I2eaGb4Jeyhpz5y1yW1KlItJO
         oHFu/CR/L2ytSJF6+T3jS0MSKcEbDehb1PYSYpFODZS9xVHVmexTN0yJYp7uf5A7BhUO
         cGo34z4sWVL/lZTnhq9ofRcrKPP5bvmB/dy59FfDsQQ0Bod90EVMzSvJQTEQke/7U993
         vSN8j72oZ8k1L8ebVmyDwGsO2+aGac24/LHUNsDX3hwseO+7UPjL118MPwYXXP/CsGb0
         0wcWdAJ87VuxVlIxUcLd5oION4J+VH203Wzos+YR2bZo+OG2kREWaAER7aZMs2YJmetb
         98/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347891; x=1692952691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v8yPa3137/niC26eiAKunSGrUVi6KH36COCn9q7Zlo=;
        b=FL5nLN9QMRFE3YEIT4MVfJ5MC5lQKA7JPzk2v5Et8Mo4xg7mHNcnQEgIg5epXE3nEc
         IaQy2pvXill52D3/hbP3dmZXMYF7sX3S8OvnrFOOSYS6AOLy5mJ7+p0ZoW5fHInO61rd
         idx+gJOuEY6A8tNbIfhbc5gTPxTMD9TOqbuwd9kjg1ML9bTScClkwB7aU+JQo7plmz/c
         QVrAspYhkpPl2El/DVFwLFcLTKk2ApPhuYnO0lJa8sWyGkeXFQF7IIA7g/rQLzHoqWRA
         rUw8h1XnbzbUWiydmRwjsyZpsNWIgwwi5QBjdCe/uKIUYVTa+JEUnXdHZr0AjLVhhJTn
         SCUA==
X-Gm-Message-State: AOJu0YznRir+odWcLdpU+e+0mIMSNV1sec34fwmBTgB2tHShHbTluT1s
        +1Q04yDsdpq4FE5O+6z9BU0=
X-Google-Smtp-Source: AGHT+IHpRsGh1lSlWaJDDzqyLYI7tB6h0+4jfdv93A6Ne2NveBB35YDiyQXtVHHV+dlt85UUaK++Cg==
X-Received: by 2002:a7b:cc13:0:b0:3fb:ef86:e2e with SMTP id f19-20020a7bcc13000000b003fbef860e2emr1593585wmh.19.1692347891049;
        Fri, 18 Aug 2023 01:38:11 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003fbb5506e54sm2046748wmi.29.2023.08.18.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:38:10 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v2 1/2] mfd: (tps65086): Read DEVICE ID register 1 from device
Date:   Fri, 18 Aug 2023 10:37:21 +0200
Message-ID: <20230818083721.29790-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

This commit prepares a following commit for the regulator part of the MFD.
The driver should support different device chips that differ in their
register definitions, for instance to control LDOA1 and SWB2.
So it is necessary to use a dedicated regulator description for a
specific device variant. Thus, the content from DEVICEID Register 1 is
used to choose a dedicated configuration between the different device
variants.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v2: Store chip ID read from PMIC in chip_id device data instead of enum.
---
 drivers/mfd/tps65086.c       | 17 ++++++++++++-----
 include/linux/mfd/tps65086.h | 20 ++++++++++++++------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 6a21000aad4a..9bb7d7d8dcfc 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -81,16 +81,23 @@ static int tps65086_probe(struct i2c_client *client)
 		return PTR_ERR(tps->regmap);
 	}
 
-	ret = regmap_read(tps->regmap, TPS65086_DEVICEID, &version);
+	/* Store device ID to load regulator configuration that fit to IC variant */
+	ret = regmap_read(tps->regmap, TPS65086_DEVICEID1, &tps->chip_id);
 	if (ret) {
-		dev_err(tps->dev, "Failed to read revision register\n");
+		dev_err(tps->dev, "Failed to read revision register 1\n");
+		return ret;
+	}
+
+	ret = regmap_read(tps->regmap, TPS65086_DEVICEID2, &version);
+	if (ret) {
+		dev_err(tps->dev, "Failed to read revision register 2\n");
 		return ret;
 	}
 
 	dev_info(tps->dev, "Device: TPS65086%01lX, OTP: %c, Rev: %ld\n",
-		 (version & TPS65086_DEVICEID_PART_MASK),
-		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
-		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
+		 (version & TPS65086_DEVICEID2_PART_MASK),
+		 (char)((version & TPS65086_DEVICEID2_OTP_MASK) >> 4) + 'A',
+		 (version & TPS65086_DEVICEID2_REV_MASK) >> 6);
 
 	if (tps->irq > 0) {
 		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
diff --git a/include/linux/mfd/tps65086.h b/include/linux/mfd/tps65086.h
index 16f87cccc003..87e590de6ca5 100644
--- a/include/linux/mfd/tps65086.h
+++ b/include/linux/mfd/tps65086.h
@@ -13,8 +13,9 @@
 #include <linux/regmap.h>
 
 /* List of registers for TPS65086 */
-#define TPS65086_DEVICEID		0x01
-#define TPS65086_IRQ			0x02
+#define TPS65086_DEVICEID1		0x00
+#define TPS65086_DEVICEID2		0x01
+#define TPS65086_IRQ		0x02
 #define TPS65086_IRQ_MASK		0x03
 #define TPS65086_PMICSTAT		0x04
 #define TPS65086_SHUTDNSRC		0x05
@@ -75,10 +76,16 @@
 #define TPS65086_IRQ_SHUTDN_MASK	BIT(3)
 #define TPS65086_IRQ_FAULT_MASK		BIT(7)
 
-/* DEVICEID Register field definitions */
-#define TPS65086_DEVICEID_PART_MASK	GENMASK(3, 0)
-#define TPS65086_DEVICEID_OTP_MASK	GENMASK(5, 4)
-#define TPS65086_DEVICEID_REV_MASK	GENMASK(7, 6)
+/* DEVICEID1 Register field definitions */
+#define TPS6508640_ID			0x00
+#define TPS65086401_ID			0x01
+#define TPS6508641_ID			0x10
+#define TPS65086470_ID			0x70
+
+/* DEVICEID2 Register field definitions */
+#define TPS65086_DEVICEID2_PART_MASK	GENMASK(3, 0)
+#define TPS65086_DEVICEID2_OTP_MASK	GENMASK(5, 4)
+#define TPS65086_DEVICEID2_REV_MASK	GENMASK(7, 6)
 
 /* VID Masks */
 #define BUCK_VID_MASK			GENMASK(7, 1)
@@ -100,6 +107,7 @@ enum tps65086_irqs {
 struct tps65086 {
 	struct device *dev;
 	struct regmap *regmap;
+	unsigned int chip_id;
 
 	/* IRQ Data */
 	int irq;
-- 
2.41.0

