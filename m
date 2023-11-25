Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207D7F8D54
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjKYSxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:53:24 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE77EA;
        Sat, 25 Nov 2023 10:53:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c8790474d5so37612201fa.2;
        Sat, 25 Nov 2023 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700938408; x=1701543208; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PIN7PTLxMRDTTudo4CQU8eCZFkTohE+Jd4VNyt/7PI=;
        b=NdhfTqOtmB5FL13vvF5QiOWC+IReMEpoGFwT8VHZlv/CYdu3n0TsJQRy4Qhwj/m8YX
         kNdhp/X6h+8r8Q5fLPiQ/KkL70dX+97uMNimXfPomW9W3NhtqSxzb/3/ZLIIgVBCphu8
         RLv6kNNhCt1awZXztV8VUz7Fc/3Jw9U6QPaLpgcAFHsSHDeWvgcVgwOuk2KNTewDjow1
         ESGZFf6x3Nk+wb0q1I4Avr2Pa0M6ZJvpEqKcGQTbh8L8pImMAVh76YGV25bkhypjThAA
         2oG/JP9q2t/bnqIKMYt4DuZKxIFJ/iVjSOS+Bqz3mgqFBcigNzty9dmBgECh79oWJTqL
         Qbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700938408; x=1701543208;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PIN7PTLxMRDTTudo4CQU8eCZFkTohE+Jd4VNyt/7PI=;
        b=vIubu1Lt3ADzN044wRPxg2nRuZ5JSwKaHAebUfV45a49bzqHNRqUPn2CQFicGhsBBG
         gc5FQFjqZFyV01QPjqgxXhzAOWs8NqXlIw8UCfvZKV/9XXQZ0tsw2lbEK/iSysmdWuhw
         G/wbOAOftuGrg2m3/LrIF618O2Xxxi08ZFDptkxIQYGJf5ucqayWVBDdM97MyxDv4F/z
         6CHnJ9F0baesPlFH+oKx7dyXMWzf1Rw2e7d/bZXOEJsQyWOtTy7HdapLkloQAgmtLhoG
         GsxPlmk8kvIxYSbpXi0nbIS8wAMwvyu5Aub5f3XmjmgqCbxO45v8f0k3UNlE42L3Z+Fw
         f2tQ==
X-Gm-Message-State: AOJu0Yy3Cl0h8hXuJBF21+NyXuxuOt/4ldytO6yoHd8LXQTMwhBpYp0C
        IeWxSMt4876SQvdZZbUvu/8=
X-Google-Smtp-Source: AGHT+IH+x/XNYXuxiqO1n1b/RSr+a1zct+aNzIBggut8xgUeQFtCSY6gjTSyGhx7RVFKHByk9DQAqg==
X-Received: by 2002:a05:6512:3b96:b0:507:984e:9f17 with SMTP id g22-20020a0565123b9600b00507984e9f17mr5994637lfv.34.1700938408105;
        Sat, 25 Nov 2023 10:53:28 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id d27-20020a0565123d1b00b0050aa7168652sm919048lfv.7.2023.11.25.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 10:53:26 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Sat, 25 Nov 2023 19:57:24 +0100
Subject: [PATCH] iio: adc: mcp3911: simplify code with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJNDYmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNT3dzkAmNLQ0Pd9NLEohRdCzMzU0vDVKNkSxNzJaCegqLUtMwKsHn
 RsbW1ADu1J8BfAAAA
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=rpcMjVNeuk9mH60/Jcj21hZ9UYtSsdL0mp9KTGJKGxk=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBlYkOikkVW2nrOJTvvxNdrBjP3lniQ1rWFtvKhI
 rhPW5mwXfeJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZWJDogAKCRCIgE5vWV1S
 Mru3D/9wYfUN54XDUMDx8bY+yD8nRyvgjGeIiJIiEyiiMMfyAHlRpM36n8Z9BvvA5z8MeCZHiB8
 jF4+CfgnuGrDbdsu5f8bLcS2YR5K8rvk6rarGDdOB9j+nvLXKekbtZ6NRTWaR5N+xga0Aa+2kDF
 r7WkTi9IPRxSlVQcuzC4cLkBP/jnK+ydeVVI2Fl9WTJsnyH9GuoVa+XnfoTvdtd7S0Y9hWd0hZs
 g4LLDmC8yXNQzKcGDgCS7qNukc3KK06u3hvXqg8ifaHZSVIWs/ZBUOorDFfJDIvfYz0s+vtO3H2
 4DFeBEgSuRQjmn/i5i2PUCoK0UTUfo9ZE2P3aZE7SLg3PL1ocoyH6f0GRPBvKF8oYimHMYXqpvF
 0yPx94cdoHNfKe50OeJBlEfGKls5E+HQXhrlaVyfB/x5qpiSHYvxTKhY8mFOSNBd53a+rgwKKCw
 Klnl3kfAAp9OvKTjwkgQbPIUdykFd8IMHfXFcvczhJH+urCoGBOdU8ns3URz99Xp5BNL7CTkfrn
 Efu7Pf0OALhBJKdyn5ZQXa1kG7uV4YjxwvEtVB5fEYHc9D5+ZOApOZRL2Jbl2P42ylb7Zwuxo/9
 4iDbepIDdU8T1npu1yQxusWsj/QUexMsKcSagIaKu9QgPrHPpvdYGCvxN7EoWmUNAWaVksGWMVq
 V7u04KvzCPUe1Kw==
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
 drivers/iio/adc/mcp3911.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..85bb13eb6f3b 100644
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
@@ -168,7 +169,7 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = mcp3911_read(adc,
@@ -207,7 +208,6 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 	}
 
 out:
-	mutex_unlock(&adc->lock);
 	return ret;
 }
 
@@ -218,7 +218,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
@@ -263,7 +263,6 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	}
 
 out:
-	mutex_unlock(&adc->lock);
 	return ret;
 }
 
@@ -350,7 +349,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	int i = 0;
 	int ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
@@ -368,7 +367,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
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

