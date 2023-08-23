Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33081786232
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjHWVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjHWVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:17:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8A10DC;
        Wed, 23 Aug 2023 14:17:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fed963273cso1486725e9.1;
        Wed, 23 Aug 2023 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825438; x=1693430238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHSWIR7ua5WAhEqqjqTOsQsAANqNcjB5jXCsCVNmx9M=;
        b=jiqMPR/AuCL8HmPHQ+IHQDdPTw3EKc5xUstUyvyp1rJZY8mqgGJI8LPs1Y/HfFYNoa
         4fxiUCKqg/S0s/MGX9UUqeTxcfJtXAMvDoH42ZpqkqU49ZXcDpnlvhc06h/8hTgIN+6E
         rCArbtgJOUE4SdqdaHz8Oyvhf6NDuh2/Hn4PJaVXSaQL0m6DXEmSMwiDajm5RC5nBy3e
         AvE7W/L1LfDDT192X/SUpXVDuP3sBkXrPUOuKuvk+WPCcWnFvi0nG7HpkWJNkQIQbxhd
         WMp2wEZJFanPOxIrc6eaVxM0GZYBZ/9gyt6bf8UfZPylMxYTB4rXFp0sWsNCAiwl6rzl
         pNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825438; x=1693430238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHSWIR7ua5WAhEqqjqTOsQsAANqNcjB5jXCsCVNmx9M=;
        b=E64KpZiIPIlKhfCKkBrB1/xPEUD1wFMtFjU2va0/SBrWVljFmsP0QPSropRNY8m5Ua
         EPFGytbB5QvhSb5+pRdFlhXHly1R+njYvj9AUF2aTgHh90ZiGvvcmvZ3IokPuWduDtwe
         mqA9G+GhA6fFFt52k2zJZDEVr27++5Xq6X+163/Q4sK67QehrfPQtJqcvC8M+bWLYVhR
         wCVwD7TyrRJlWzbwEcl8kdFiV0v60UtRt7Ly5Ml3K7TQsmmk3gFjltmprQ/ToAKJ+VSP
         wjE3bokV9dNiRTE5s2voR/Lu2usA4kj23Ul0zsLZGCmURvp4nY48DsAm/o+Hcrj23On2
         ZvPg==
X-Gm-Message-State: AOJu0Yx3HE4HQ1Bg4hooQu0RTbsEhcy6Bg636hTIg0ypDZX9kaASx2SF
        vTAYd0q6IoEULOUAn9fNcWs=
X-Google-Smtp-Source: AGHT+IFY/NCg2lQcBGxkTvP32e4fkARWgw9MNfO8PWS/bCT6ip9qdnIMY9WCL3Wzvslcgk5CGeO9Pg==
X-Received: by 2002:a5d:4ac2:0:b0:319:70c8:6e90 with SMTP id y2-20020a5d4ac2000000b0031970c86e90mr9927951wrs.24.1692825438520;
        Wed, 23 Aug 2023 14:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm20193399wrm.81.2023.08.23.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:17:17 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Wed, 23 Aug 2023 23:16:40 +0200
Message-Id: <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1692824815.git.mehdi.djait.k@gmail.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
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

Since Kionix accelerometers use various numbers of bits to report data, a
device-specific function is required.
Implement the function as a callback in the device-specific chip_info structure

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v8:
v7:
- no changes

v6:
- directly return KX022A_FIFO_MAX_BYTES as suggested by Andy

v5:
- no changes

v4:
- removed the comment about "bogus value from i2c"
- removed regmap_get_device(data->regmap); dev is present in the
  driver's private data

v3:
- no changes

v2:
- separated this change from the chip_info introduction and made it a patch in v2 
- changed the function from generic implementation for to device-specific one
- removed blank lines pointed out by checkpatch
- changed the allocation of the "buffer" array in __kx022a_fifo_flush

 drivers/iio/accel/kionix-kx022a.c | 28 ++++++++++++++++++----------
 drivers/iio/accel/kionix-kx022a.h |  4 ++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 6bac618c63b4..458859ebc645 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -596,26 +596,33 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
+static int kx022a_get_fifo_bytes(struct kx022a_data *data)
+{
+	int ret, fifo_bytes;
+
+	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
+	if (ret) {
+		dev_err(data->dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
+		return KX022A_FIFO_MAX_BYTES;
+
+	return fifo_bytes;
+}
+
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
 	struct kx022a_data *data = iio_priv(idev);
-	struct device *dev = regmap_get_device(data->regmap);
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
 	int64_t tstamp;
 	int ret, i;
 
-	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
-	if (ret) {
-		dev_err(dev, "Error reading buffer status\n");
-		return ret;
-	}
-
-	/* Let's not overflow if we for some reason get bogus value from i2c */
-	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
-		fifo_bytes = KX022A_FIFO_MAX_BYTES;
+	fifo_bytes = data->chip_info->get_fifo_bytes(data);
 
 	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
 		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
@@ -1024,6 +1031,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
 	.inc5		  = KX022A_REG_INC5,
 	.inc6		  = KX022A_REG_INC6,
 	.xout_l		  = KX022A_REG_XOUT_L,
+	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 0e5026019213..c9f9aee7e597 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,6 +76,8 @@
 
 struct device;
 
+struct kx022a_data;
+
 /**
  * struct kx022a_chip_info - Kionix accelerometer chip specific information
  *
@@ -99,6 +101,7 @@ struct device;
  * @inc5:		interrupt control register 5
  * @inc6:		interrupt control register 6
  * @xout_l:		x-axis output least significant byte
+ * @get_fifo_bytes:	function pointer to get number of bytes in the FIFO buffer
  */
 struct kx022a_chip_info {
 	const char *name;
@@ -121,6 +124,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2

