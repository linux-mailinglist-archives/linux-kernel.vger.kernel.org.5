Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9936A8051BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjLELMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjLELMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:12:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E2135;
        Tue,  5 Dec 2023 03:12:13 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so55005e87.3;
        Tue, 05 Dec 2023 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701774732; x=1702379532; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dU9vuAjHJvI8A2/DORsX8Wd9bQM+NwPY4Oo/b6BqT2E=;
        b=PbNfbgvOyMbglJYSutF+2hZJa16KJDEnURkefgZlDLWqzRqonaYnyFMtarbmD+9/te
         lIDP2uWa1jayNjNl5f0AQqm2Tb7JnByjEynna3yEd9O2p8sN2KHUOFwuSzB0emT4fLrP
         CPpYHNGwxSRoymFIUifDQp1lqcMjfNzSRYvY9q0mD07XpIooElI86ChJD+5/0BgNZSvp
         AlMgGjuMeo+GKWpPWTY1MCq10dD32gTbkReOQ7ZFTPkppVIAyiJyIG8zwWdxxFstBiR2
         NItPIDle93tDbnb3h4ikrf7SzqLdLW5/ooTDeuUlG3+xvz4P2/FRFVEeX7bVdBUf6uez
         rnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774732; x=1702379532;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dU9vuAjHJvI8A2/DORsX8Wd9bQM+NwPY4Oo/b6BqT2E=;
        b=vHIaIJih9VUp4T/z+747HelteGtxjotpHvV+VjbOfriBXE1PQa/ZMREqAMZcE62KaL
         yCdO3vw58dIGR2hRpgaI/KAbjR1RwWajlvZaiJRy1dtl0LEvO8S0Amj3tRaAO7SKHlJ+
         6/rCpl8T2XgoJ3YZLG8/b9HJ3bx5PLyurBYY66VdWcOgIxAQUky/9mXTmleOCP4fdf4C
         EiBd4K4Sw9I4/dg5ck8q+v5NJc4yfZdrBYxg9+AbA9AwIZgSHqqdBITR5L3sMNyZQGeS
         dBc4Wwn5scgrd6fwqUl2czoZxK8qdo5QrMDng/OTNE6A15grw5bGu/RaRIarMFIkVisG
         KbJw==
X-Gm-Message-State: AOJu0YxyLyqaY3w3O7uIFbWmX/I3NaPIBLf1KsvCUM96NrmB/S8bpBT1
        M8bKglGUijk4CQlT6hhPuc8=
X-Google-Smtp-Source: AGHT+IFdkglMKykZ6zar0e9cQ+0KPOF95EoZIFI/xK9scL5Wmpo23Juc/hd4b2l6GYaaPkDeXHUf/w==
X-Received: by 2002:a05:6512:3da1:b0:50b:ec8c:6697 with SMTP id k33-20020a0565123da100b0050bec8c6697mr2431877lfv.128.1701774731871;
        Tue, 05 Dec 2023 03:12:11 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b0050beeea07f3sm849377lfe.4.2023.12.05.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:12:11 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Tue, 05 Dec 2023 12:16:33 +0100
Subject: [PATCH v3] iio: adc: mcp3911: simplify code with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-mcp3911-guard-v3-1-df83e956d1e9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJAGb2UC/3XMSwrCMBSF4a2UjI303rRp48h9iIOQpO0F+yDRo
 JTs3bSjIjg8B75/ZcF5coFdipV5FynQPOUhTgUzg556x8nmzbBEAYA1H80iFADvX9pb3kpZK3B
 oVNWwbBbvOnrvvds974HCc/afPR9he/+VInDg2FStBalFJ7prP2p6nM08sq0U8aibX41Zq0qiF
 KU1GtxRp5S+oMInR+gAAAA=
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4249;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=jTOz9DHoo4Sk4PrMlQzy+BgB6hsFZ0TTG9UTUY6JaQ0=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBlbwaYtd5Snqu1q1Mo8JK/DlKZs/J7P5BxABgYP
 8+Spgtl2pSJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZW8GmAAKCRCIgE5vWV1S
 MhmMEADfnsKwIAis5LZomhgQnTO2KKZmQ1i8meyvRoynARwj1LA8oZHa/+YXGoxKD7uQmx51+yD
 E5TiTnszjqUN8oygcLA0eauB6KL5Jk2pxJEvtoCOsYZkONmHRZ5ojWufVMI+QOgez8t3CgyhzHg
 xH76lLfnT9dwTRReGPkUZqFH+BSIxYLZtWqfUddGIvhzo3ifnOaPTo0fQZUH7oEO3E+mQD+As6j
 2Hq4FmwZO46IbJx8Lxn9XWMe0z7f1yMnE0eUL2lSJIu4vncimvYcdsPWS9k5rBt/YAgCPiUXRnZ
 ecq9pbnSyN3R3IMnfAX1RkRj8ytr56NTxtCnJq1Q3nrRsk5uOJeaIXKlLCNxiREQ6iD7DD3Zzn1
 xcvIreu5XqAtIyVXoDni/mgYAD9JzWU/0xoGTwJVFKSO42y6k+0ZVfamVkndWgpiibmt9VT/tPl
 yPwSHCQ4V9IX0ieVvPhN3/G8yMUwJ7XicKv8JV7QCK2/WJcbknHpbPJtLJTPNrSk6lmPjx3m2o3
 T/yWD06YLn57tJ5Oat18SQ5EBx5Sz5dfAVrXT0O0XU9lbn04XRNYfSyYLyFinM7qul/6ARZ/sYo
 5peVZGcdKGeolLqDCNW1EPDG0Wg8Rn4t6/w4+vP+nRTVJcn69tIvuHyHXzTzToMnC2suvVr4Flg
 rKILaim+IiX4N5w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the guard(mutex) macro for handle mutex lock/unlocks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v3:
- Return early in good paths as well
- Rebase against master
- Link to v2: https://lore.kernel.org/r/20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com

Changes in v2:
- Return directly instead of goto label
- Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
---
 drivers/iio/adc/mcp3911.c | 47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index d864558bc087..f4822ecece89 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -7,6 +7,7 @@
  */
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -318,44 +319,34 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = mcp3911_read(adc,
 				   MCP3911_CHANNEL(channel->channel), val, 3);
 		if (ret)
-			goto out;
+			return ret;
 
 		*val = sign_extend32(*val, 23);
-
-		ret = IIO_VAL_INT;
+		return IIO_VAL_INT;
 		break;
 
 	case IIO_CHAN_INFO_OFFSET:
-
 		ret = adc->chip->get_offset(adc, channel->channel, val);
-		if (ret)
-			goto out;
-
-		ret = IIO_VAL_INT;
+		return (ret) ? ret : IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = adc->chip->get_osr(adc, val);
-		if (ret)
-			goto out;
-
-		ret = IIO_VAL_INT;
+		return (ret) ? ret : IIO_VAL_INT;
 		break;
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
 		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
-		ret = IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_NANO;
 		break;
 	}
 
-out:
-	mutex_unlock(&adc->lock);
 	return ret;
 }
 
@@ -364,9 +355,8 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct mcp3911 *adc = iio_priv(indio_dev);
-	int ret = -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
@@ -374,32 +364,26 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			    val2 == mcp3911_scale_table[i][1]) {
 
 				adc->gain[channel->channel] = BIT(i);
-				ret = adc->chip->set_scale(adc, channel->channel, i);
+				return adc->chip->set_scale(adc, channel->channel, i);
 			}
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		if (val2 != 0) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (val2 != 0)
+			return -EINVAL;
 
-		ret = adc->chip->set_offset(adc, channel->channel, val);
+		return adc->chip->set_offset(adc, channel->channel, val);
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
 			if (val == mcp3911_osr_table[i]) {
-				ret = adc->chip->set_osr(adc, i);
-				break;
+				return adc->chip->set_osr(adc, i);
 			}
 		}
 		break;
 	}
-
-out:
-	mutex_unlock(&adc->lock);
-	return ret;
+	return -EINVAL;
 }
 
 static int mcp3911_calc_scale_table(struct mcp3911 *adc)
@@ -532,7 +516,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	int i = 0;
 	int ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
@@ -549,7 +533,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
 					   iio_get_time_ns(indio_dev));
 out:
-	mutex_unlock(&adc->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231125-mcp3911-guard-866591e2c947

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

