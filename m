Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F58077A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378798AbjLFSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378355AbjLFSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:34:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3E139;
        Wed,  6 Dec 2023 10:34:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso108867e87.0;
        Wed, 06 Dec 2023 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701887682; x=1702492482; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DAsSFLxv7cCivXxxZDP7xntxjqrycq5IDoNMPhqOJs=;
        b=PQ55gHtLdOkK8UrbNpga7nIKtQKtLcirKAIJt7sT21c/QCEHlIWfNebhI0TyRQd8ni
         Yt5drX4NYgYKBfA8ZFQg3LLElEmk1kR+zDMxF+IYBdmPcKRBgeNEYsLFY19wCRGM9z5v
         8K/RvWToXxYAY5IiTLu/NnfpR9d6EVYfyGr062acGuhrfRS9cTKx6Ybes/Ecw+RJD37y
         0dixZR1v+Q8PtnvjG34O7VQfuAh6HfCsbLoxpwOjYJTTQRjRh3dXTSjUAVw7xpItjksF
         6wh84BpMQce//2LwmJOq0ZzhFlqcU72V7W/jRn9OAvSxmvnI26saAFmKrIF0+RIUL6ZJ
         10CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887682; x=1702492482;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DAsSFLxv7cCivXxxZDP7xntxjqrycq5IDoNMPhqOJs=;
        b=CVGyfNnQfBF2tIx9REITcKVA0YutM9eoOZ1c5TicJBbA1ZXL9PXOAtXhoIGpA2YrWY
         QXuF+0Rtge11OQP+b86VMGXJ60ECcSC6T4stHDsIEAF4WtQ/cgzn+Vvpw/VJmUhck8aO
         msX2g+bhxybDEK9h6vMn8+9X11h2CSl77ujx4tFpM5N3A6kRfbS1enQp7MeQy42Ua8VI
         GUXcM2kmyuI6SK3dq0FMrmMAeOD1GT4pkSIDdagB6x7lS1Q41bdmOqPb0q/j5CajHIky
         mLQNdEZrfDQMXKyfcC0ROAOyl0mpuMEs07wYmXaMnCXbqbAqJ/j18gbsDZSpX8nDt42f
         XJSw==
X-Gm-Message-State: AOJu0YxR97To1a+v+0hEqVIGXcqXeNjLosAd0HurH7fCD6DklaGnNjct
        i56jS+6Qd+RtfWFwugBzsEyiTBIX71s=
X-Google-Smtp-Source: AGHT+IHAZABTuzLy8tfuBPtyQAnJPM7dIp8U/NDC2uD3q3TZx0u70ZV82P4fOvOibBdngwVCQ6cm/Q==
X-Received: by 2002:a05:6512:60b:b0:50c:44:919e with SMTP id b11-20020a056512060b00b0050c0044919emr912640lfe.108.1701887682174;
        Wed, 06 Dec 2023 10:34:42 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id k22-20020ac24f16000000b0050bf59d513bsm1044009lfr.94.2023.12.06.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:34:40 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Wed, 06 Dec 2023 19:39:04 +0100
Subject: [PATCH v4] iio: adc: mcp3911: simplify code with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-mcp3911-guard-v4-1-30c3c5d4340f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMe/cGUC/3XNTQ6CMBCG4auYrq1hplCoK+9hXDTtAE3kJ602G
 sLdLWwkGJffJM87EwvkHQV2PkzMU3TBDX0a+fHATKv7hrizaTPMUABgwTszCgXAm6f2lldSFgo
 IjcpLlszoqXavtXe9pd268Bj8e81HWK7/ShE4cCzzyoLUohb1pem0u5/M0LGlFHGry73GpFUuU
 YrMGg201+KrMfv5LZK2dSVIFdICqa2e5/kDbDpWUyYBAAA=
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4388;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=0Nl6k178wltht81ihfvleOVdWM/BNHMS3fFENupKlMw=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBlcL/P7tGZEz0CLXTKiG7sDCNkD3oZw+S/Ga6J3
 5yDl5vSv62JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZXC/zwAKCRCIgE5vWV1S
 MmF7EACRCAqdqtI6NunF0sERBBFm9wwV4AiP8dWVOk8/2jcipp8zQfRMa0UXkgjHazyWxahhDfb
 zIf+eJJqsIvZ0vNqV0q0Zvw/pqmWHLdvvsMKsL4HWjryerDsvDHOvRfqxqNVei+KUkZ7b/66V7w
 Fh0CIxj0VXimj6XUZ6oEvEW9vktEm96ypgi/2LEJVex/h12WIntNQg/po8uhfguvQ5tax/A4Oks
 tTvCUEP3OkVY11nDuR4cMwdQcHDw8Xu+3k0nlPy31/2aH/UO9+sG8xRPbD01eoPq8L+sy+SFsu2
 TOzLMHTeTmbR6BbNwjcXhql67HQLRBfN5988LkUKTpN64tG3SqFDk4vRDANAIAz3O6PGP1I/nER
 xYHqD6HjjrCzqtnK5eOkfCBZKrU2tiY5AzcWTZDxeX1lILf2CAuyr2uhuT3cptJHHZx4iaWnqj1
 f0eF4ZinPdBs+8qKTMR3jD7BypfkaFuH/OucHylt/5kCtAhSjJzL5A2DNYyM1pqb7UflLwzZLzA
 cqaqcZkc1WiMIcf74xYzM/IXAzOHSs4NCzT/DF2ATaxpRDIdacKLW5OR+Ho5bi5FMsAJuKh79oo
 eKIdJxWrZ4DUPFKbGBzq2nGC3p2Qjhf4A6UxDvaz/G5x3fud/9qENQW5622lwsslfhYeQWOJqQe
 oJNCcGuCI7jBpxA==
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
Changes in v4:
- Remove unreachable breaks
- Link to v3: https://lore.kernel.org/r/20231205-mcp3911-guard-v3-1-df83e956d1e9@gmail.com

Changes in v3:
- Return early in good paths as well
- Rebase against master
- Link to v2: https://lore.kernel.org/r/20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com

Changes in v2:
- Return directly instead of goto label
- Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
---
 drivers/iio/adc/mcp3911.c | 55 +++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index d864558bc087..dfcb6cb7570f 100644
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
@@ -318,44 +319,28 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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
-		break;
-
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
-
 		ret = adc->chip->get_offset(adc, channel->channel, val);
-		if (ret)
-			goto out;
-
-		ret = IIO_VAL_INT;
-		break;
+		return (ret) ? ret : IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = adc->chip->get_osr(adc, val);
-		if (ret)
-			goto out;
-
-		ret = IIO_VAL_INT;
-		break;
-
+		return (ret) ? ret : IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
 		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
+		return IIO_VAL_INT_PLUS_NANO;
 	}
 
-out:
-	mutex_unlock(&adc->lock);
 	return ret;
 }
 
@@ -364,9 +349,8 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct mcp3911 *adc = iio_priv(indio_dev);
-	int ret = -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
@@ -374,32 +358,24 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
-
-		ret = adc->chip->set_offset(adc, channel->channel, val);
-		break;
+		if (val2 != 0)
+			return -EINVAL;
 
+		return adc->chip->set_offset(adc, channel->channel, val);
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
@@ -532,7 +508,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	int i = 0;
 	int ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
@@ -549,7 +525,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
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

