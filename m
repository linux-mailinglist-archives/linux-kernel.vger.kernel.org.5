Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F278D8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjH3SbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbjH3IxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:53:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B246CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:53:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500b0f06136so6232143e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693385580; x=1693990380; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7IUUKRo18kc1SIdFh7Gpb3hs7/PPc93dlBfA1+9r5g=;
        b=J2TXaDKL0Lkt3UKz9MFW0KciUwTa9go+L5IhE9L3ANepHfb1webQYdRQvvA8dknC/E
         t453VO2vN7OSoVb7Dv93mxCLY2NYHuEvrew8Cbleou54zF5RxnV6cBG081t6vfeaJAZq
         cadLaDnHyo/ayGBU36HrKsrnlOyaBatFHJhG8+W3udK+3ka2o7RcxRU2vQcHpht2xJ6r
         qej1EdJSzwDIeURCZ655m3VNVocUTrETA/F2X+lkO7icPdc7uOoNjvl6f3748kvcGe76
         L5Q6Xnus+5y8NDDKhAtVXM7LLSsdzXLe5VEdQgR0hp567mTkZSxiiUPbWno83vMQJKiu
         9i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693385580; x=1693990380;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7IUUKRo18kc1SIdFh7Gpb3hs7/PPc93dlBfA1+9r5g=;
        b=E5N4d1x+g/BnuRZfw9DKi7ZLmvVxnkHKgBSjhMJvjDLGuH3/YsKFiB9JYupPcB05DP
         UvfoL4c1OEa9cadmsmYawY4qQfbQkny68wVVmHeb5ZVZg/qroqSBvVtNu3RHvEP69Ue4
         mUi4VhC0Aa2Zub6PLsb/lTFYRe2LS9iAbKQsPvCwvjGbwTeCVnHGiuTLLoRx3anWpAyL
         4cQWS/YK9AR2xlhsS6NDAArMR4EcoaHu3V0vFhjLIUVh7svm3WfrcWmZvTqiF/nRcC4q
         tcCDOKOggvjn93Yl1E3rum2ojfhbHTts0pUfQ6T2iiPAw4plhtPFEGgCG0ubEY4dRF4j
         0Vzg==
X-Gm-Message-State: AOJu0YywEtL5fxgZGksHdWzcvy4BlMSEBMnJOCPrn079/AfIRCba9v3E
        2yWpABzVgwuTyJlWXpmSPE2pxQ==
X-Google-Smtp-Source: AGHT+IE+jxbyjKkaU0CTSRVGxTD8FSRj4bUC++kmj65m2HoeIl/YH3+1mOCN2srawPv2yzHUPshMFg==
X-Received: by 2002:a19:4314:0:b0:4f9:5519:78b8 with SMTP id q20-20020a194314000000b004f9551978b8mr910521lfa.63.1693385580391;
        Wed, 30 Aug 2023 01:53:00 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id p3-20020a19f003000000b004fbc6a8ad08sm2296971lfc.306.2023.08.30.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 01:52:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Aug 2023 10:52:59 +0200
Subject: [PATCH] iio: afe: rescale: Accept only offset channels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-iio-rescale-only-offset-v1-1-40ab9f4436c7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGoD72QC/x3MwQpAQBRG4VfRXbs1RkpeRRaYf7ilGc2VSN7dZ
 PktznlIkQRKXfFQwikqMWRUZUHzOoYFLC6brLG1aWvDIpETdB43cAzbzdF7xcHetjDN5KzDRLn
 eE7xc/7kf3vcDbeA1yWkAAAA=
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Jonathan Cameron: it is perfectly legal for a channel
to have an offset but no scale in addition to the raw interface.
The conversion will imply that scale is 1:1.

Make rescale_configure_channel() accept just scale, or just offset
to process a channel.

The code to handle channels with just offset is already there.

Link: https://lore.kernel.org/linux-iio/CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com/
Fixes: 53ebee949980 ("iio: afe: iio-rescale: Support processed channels")
Fixes: 9decacd8b3a4 ("iio: afe: rescale: Fix boolean logic bug")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/afe/iio-rescale.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 1f280c360701..18aafb4bdda0 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -280,8 +280,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->type = rescale->cfg->type;
 
 	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
-	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_info(dev, "using raw+scale source channel\n");
+	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
+	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
+		dev_info(dev, "using raw+scale/offset source channel\n");
 	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
 		dev_info(dev, "using processed channel\n");
 		rescale->chan_processed = true;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230830-iio-rescale-only-offset-f28e05bd2deb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

