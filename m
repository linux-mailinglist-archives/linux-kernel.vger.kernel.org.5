Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD45B7756EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHIKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:14:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F1B10D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:14:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so103731561fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691576079; x=1692180879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpBUSROzSck0HYxkn+8+wNc7Veqlv5AziTepsaYeq9Q=;
        b=qItreBPEAoPqLRE97x6bPYFqNXII7NGEMBK8e5UylvwUH8zOJC1jj3LlnYFPoiFYtF
         4DaozvtMjkuCpAbh2suuMDtmO1Vd5VjqiiWCCn67JsvB6Ur4GunD9CI+O5R8kYEd9Vs0
         D1qPQ0LWepabwUU03byX/gdmaC2Q7SCMHs6KcGa189AvIHMAvbTJFky/lpZgPjwmB0av
         hI6HWFLjU3EVjPpd8y/OZN3a3b9YkwAB/FvgWzYD/4/GnBzbIDCTfA9K2KZzf7O0NGtm
         sJB/TmAsXhQWl3AxvLXho40o3mxofIwGHg0Z20hZefIopuG15r2bMPXW/ZLrStugKVML
         G8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576079; x=1692180879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpBUSROzSck0HYxkn+8+wNc7Veqlv5AziTepsaYeq9Q=;
        b=ZNd0A9FuCn8oDWybJceH/QOzlc8qgtg8UdlFCPfxK5xcz9XEgLMkidERBQE845tTk6
         MjF+btriRJFWsQpx20ZqwT09g40X2YVUUUL3nTfZSrZl1LF2L0Ggmj/Uwm5jOmsh2l/L
         rjyYCJP23XMC1PVD7ecUJMKsBJs6y1zAMmH/i0MNx5rdBCm+VAFSc6AY30eR022RDs9C
         suUDG2LrTeN7NqtnoUXfCaQnkfs7fWcbo/8ldKYlmfofEQJ2JIx0xLMYIJ/3+VY/Jomm
         zloPFl1fQxrqDBeDbz27XRdp/vuBZzjY+yMEFdyXMbjuIbniIyIL8ZsakdynVWA1V5Du
         pJHQ==
X-Gm-Message-State: AOJu0YwiewNCVzyoCO/bl6d5MOsINWJjTYmIKIT7Mjh+2/kszr1T8dWd
        GR/vUJnELSJBWwvZ2OJKxv4=
X-Google-Smtp-Source: AGHT+IF7lompDrjovoIDTURED+kwC2toKhWkX3OJ5TG4Y4T6X4azMIkSQz2Jz8Ze11rhpwI3O9JuKQ==
X-Received: by 2002:a2e:b177:0:b0:2b4:6eb0:2a27 with SMTP id a23-20020a2eb177000000b002b46eb02a27mr1541418ljm.17.1691576078611;
        Wed, 09 Aug 2023 03:14:38 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b003fe24df4182sm2053718wmo.1.2023.08.09.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:14:38 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH 1/2] mfd: (tps65086): Read DEVICE ID register 1 from device
Date:   Wed,  9 Aug 2023 12:14:28 +0200
Message-ID: <20230809101429.7885-1-andre.werner@systec-electronic.com>
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
 drivers/mfd/tps65086.c       | 37 ++++++++++++++++++++++++++++++------
 include/linux/mfd/tps65086.h | 27 ++++++++++++++++++++------
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 6a21000aad4a..38f8572c265e 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -64,7 +64,7 @@ MODULE_DEVICE_TABLE(of, tps65086_of_match_table);
 static int tps65086_probe(struct i2c_client *client)
 {
 	struct tps65086 *tps;
-	unsigned int version;
+	unsigned int version, id;
 	int ret;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
@@ -81,16 +81,41 @@ static int tps65086_probe(struct i2c_client *client)
 		return PTR_ERR(tps->regmap);
 	}
 
-	ret = regmap_read(tps->regmap, TPS65086_DEVICEID, &version);
+	ret = regmap_read(tps->regmap, TPS65086_DEVICEID1, &id);
 	if (ret) {
-		dev_err(tps->dev, "Failed to read revision register\n");
+		dev_err(tps->dev, "Failed to read revision register 1\n");
+		return ret;
+	}
+
+	/* Store device ID to load regulator configuration that fit to IC variant */
+	switch (id) {
+	case TPS6508640_ID:
+		tps->chip_id = TPS6508640;
+		break;
+	case TPS65086401_ID:
+		tps->chip_id = TPS65086401;
+		break;
+	case TPS6508641_ID:
+		tps->chip_id = TPS6508641;
+		break;
+	case TPS65086470_ID:
+		tps->chip_id = TPS65086470;
+		break;
+	default:
+		dev_err(tps->dev, "Unknown device ID. Cannot determine regulator config.\n");
+		return -ENODEV;
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
index 16f87cccc003..88df344b38df 100644
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
@@ -75,16 +76,29 @@
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
 #define VDOA1_VID_MASK			GENMASK(4, 1)
 #define VDOA23_VID_MASK			GENMASK(3, 0)
 
+enum tps65086_ids {
+	TPS6508640,
+	TPS65086401,
+	TPS6508641,
+	TPS65086470,
+};
+
 /* Define the TPS65086 IRQ numbers */
 enum tps65086_irqs {
 	TPS65086_IRQ_DIETEMP,
@@ -100,6 +114,7 @@ enum tps65086_irqs {
 struct tps65086 {
 	struct device *dev;
 	struct regmap *regmap;
+	unsigned int chip_id;
 
 	/* IRQ Data */
 	int irq;
-- 
2.41.0

