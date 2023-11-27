Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60157F9B06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjK0He0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0HeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:34:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7CD9;
        Sun, 26 Nov 2023 23:34:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so3953197e87.0;
        Sun, 26 Nov 2023 23:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701070469; x=1701675269; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBEFDFiEzXjJEVyyuALZhQnjEInmYu9CJKq+XNayaXA=;
        b=E5Ce8uRHb4S3Mv1eJNmtTGE6wiwxt3RV/+oRqBc0C212vkhKKJbEttKYYglY8utjyJ
         c0CyK9qzHfkuCs/ZjdDqlxLrNz6XQL2RwxmFx7sMkihd6OmOw2UCLBF/nFtTtQHVi8Xx
         1M7qv1d4kwBFaexvByntfoZRWxM+PomfZiwZdctKMMJVAGTAE7gTu7Smn2KMoCcIY799
         ABvj9hXNx2zM7aJonQUBNdJUtSrDIz3lUyIlfZEnQz24ZTfRckR9CumCJ6b+inEdH+lm
         9c7Av7p0QPzSdOoN4pHXxkn+5UKA4/NStN9z38dW5Qmy8iwPSxOJUThp8h7F+PoIQRkf
         qNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701070469; x=1701675269;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBEFDFiEzXjJEVyyuALZhQnjEInmYu9CJKq+XNayaXA=;
        b=NVpGNTk4XcT0+7SJPy9lq4CLSaD55P37U5BfiwQFLOUQM+kPsPVmUcwCHdW2IkAFF7
         q/oXedey7i+1tB/AJ5bR06hVGwSjagro6J0oAVay2J7Vs0GyPHuY0gv4h6hYqjgz0T4y
         T4K+Wy+2VqdadYeLrMsvg1s2iw00dR5yorHwxvK3tYafCtdFHw/MFma8QaJWYMcUnhFu
         duwS6/LOm9wif+bBfTglMYjm+8EMPG5hIyW2+I7Me3OdeZCcxtBG2dEebG4UOowWVLJS
         Z7z44Lf4WsukQh7bxyS5tMpR4OpGL6yngV6Hn6n1wq3ScaTjqTV1DDnt+6znFGQemrxh
         qWmw==
X-Gm-Message-State: AOJu0YxicqGJh8AIVpK1EmatsT2ULU72lOxdj9c2kkwkpXTGWOuBmtNR
        1IuuY222pwFf1DXhItiwIV8ayh0g69k=
X-Google-Smtp-Source: AGHT+IGSKH0n0tTDmZY26GNIGe54gTOvF9KQEFcEvMS6CWTjc3N5yF1xS0VRnodA+uMBO7wibdo9lw==
X-Received: by 2002:a05:6512:3d0b:b0:504:3464:b4a1 with SMTP id d11-20020a0565123d0b00b005043464b4a1mr5273253lfv.22.1701070468977;
        Sun, 26 Nov 2023 23:34:28 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id e6-20020a196906000000b0050a5f6b5b46sm1437140lfc.225.2023.11.26.23.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 23:34:27 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Mon, 27 Nov 2023 08:38:22 +0100
Subject: [PATCH v2] iio: adc: mcp3911: simplify code with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG1HZGUC/3XMSwrCMBSF4a2UOzbiTfqKI/chHYS8esE2JdGgl
 Ozd2LnD/8D5dkg2kk1wbXaINlOisNbgpwb0rFZvGZnawC9cIPKOLXoTEpH5l4qGjX3fSbRcy3a
 A+tmidfQ+vPtUe6b0DPFz8Bl/6z8pI0PGh3Y02CvhhLv5RdHjrMMCUynlC+AkpBKqAAAA
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3495;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=s+pvUlHgSCkIjg7XqIH1GmY/4spFnPS00JaKJH/kGi0=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBlZEd8s7kNikLi/nJI5fTLbPLVPAO7iLu4PtBcF
 i3cdMPyRj+JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZWRHfAAKCRCIgE5vWV1S
 MuS5D/9cdDhpskooJ3R1HGVYQ7IjP++BWocV2Ws+Hk23UbmkBOFKRUOy9KJdetEDeL+fyP0Brb0
 LxoM8lD3P46rm8q1ppdgMyOKa36TgEri6nMO1l5YCTVHw7bZAmDUmmOc1/KEcvhlS/tqm1YUUDZ
 JiG9JKGm6piXVJCWdTy1QNduUlBN89hdq2h2fSbGV/Jxt4LvICmoxTHvsQasJXYoJpsyQxtufeB
 MvlK1xcH1dMzlj7Uh/LO0m7/9mnbHgrOS8b9ppnla8BFDTUtPjFIHP7ubvJht1fA22rLlFgvFZr
 xS4VhDpUAPLBpYaOXJP3wPCTDuoVlkiY3zqf2GTSwAM+u0z0QIScpBiI9eCsKSvWAyTGWEQMr/r
 ibdDGo7GxPlQ4hn2q5Z70zH+axyA8/Z6iuJIBoQWWSMNIvlEYvzUUw/STHTN6MUJyOhVLh+1MSb
 /tSZqGBxeaG7vhYI3nxfFZlNn8NwqpvjF/+a8HwFLr7IVbcMo/87rwgJOe/H85VJRuB8P/Kkr88
 N1Nt+BT/U/ieU1nzZ4r2r+AZK2kp9FuvNWh5sOIwyAu5uCDx4KSPuARcWGiZmvLHcdoW/dJiSKk
 XHWEeZV0AQhHWbRP25+SgMWb8fevIxvjvHcLaRDQEApnCs6LLGu+ApUa++CPluXZgNu2hGZKXPQ
 eqzpEaTItp4x4kg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the guard(mutex) macro for handle mutex lock/unlocks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
- Return directly instead of goto label
- Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
---
 drivers/iio/adc/mcp3911.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..30836725ef9a 100644
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
@@ -168,13 +169,13 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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
 
@@ -185,14 +186,14 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		ret = mcp3911_read(adc,
 				   MCP3911_OFFCAL(channel->channel), val, 3);
 		if (ret)
-			goto out;
+			return ret;
 
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
 		if (ret)
-			goto out;
+			return ret;
 
 		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
 		*val = 32 << *val;
@@ -206,8 +207,6 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-out:
-	mutex_unlock(&adc->lock);
 	return ret;
 }
 
@@ -218,7 +217,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
@@ -233,16 +232,14 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		if (val2 != 0) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (val2 != 0)
+			return -EINVAL;
 
 		/* Write offset */
 		ret = mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
 				    3);
 		if (ret)
-			goto out;
+			return ret;
 
 		/* Enable offset*/
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
@@ -261,9 +258,6 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	}
-
-out:
-	mutex_unlock(&adc->lock);
 	return ret;
 }
 
@@ -350,7 +344,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	int i = 0;
 	int ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
@@ -368,7 +362,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
 					   iio_get_time_ns(indio_dev));
 out:
-	mutex_unlock(&adc->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231125-mcp3911-guard-866591e2c947

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

