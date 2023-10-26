Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C37D8622
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjJZPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJZPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:44:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F7196;
        Thu, 26 Oct 2023 08:44:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so170807466b.1;
        Thu, 26 Oct 2023 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698335092; x=1698939892; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOqZewXxQGVP1NcocKVuNRkU9OFyXGemHQI6cQ9yNks=;
        b=EyJe4ebSgtQW89MTIf5Rtl6pAASHtePBqfA2YIvG1lBEuYnO+tdCzGLALWqry7SfFD
         gCdOya0C5boXXYG2ZbMLmXYKPy3kHGn09zvElnMrCSCM6pb3cqeIVk0roZtJ70tlQda6
         ldLZzasrN5+28qtkeV9ns8rO/ZEHbN0f5j8PUaiRaN10rxUccE8IqSrjAibaEC/aH/q1
         kRQVm95viQO1/6bdBY0XP0KFjaxk0MPrGRiXR6jVFCt+eSLuVdXPHV0E12m2Dc/rISRD
         T1JLBV7vlA25Z38xZCV9paaFd6RkzQB7TbR3GCY+8KaVuTmMQUB6zpSLecxdk4/9TgSI
         6pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335092; x=1698939892;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOqZewXxQGVP1NcocKVuNRkU9OFyXGemHQI6cQ9yNks=;
        b=uG0VYWeEbeFe9hMioFB+wLZCAAKaTfyoahfsdQJMRE87Ds1Ruojb+gUTfXVhgyf1/1
         SjVnvz5tCzZD+b0mEGmhfZJ19vaeoKiQguJhLmy5G5Jl8ZLCoxV3LelPYGNgLTgJJEfq
         gDnVPVd8fQDo+BqB4RGG7XBCnIAxOguHmEqOIuj8VlZ5QDM8TVJSmUWsXUDbOpn6lOow
         VhKBbMoE+qMo/iNemafhyuURGuKliXakQGjc0bmrCF6eb7JHjEVzcj4UtUljw9V7Ub86
         xLoaFWOTEN4bLV5WkUNQf2irBrlqk91SnwoEbMdYSZcuqMgvbbZn92fLjKzHtd1KM6Mr
         A8Mg==
X-Gm-Message-State: AOJu0Ywpsik4os3pNMMnsHlH5je4sBSvHPtG1iyOoQlxCwGIwh1TL3TC
        rL5Cj0kh0mSJ1rXSaSmcpJhYv+rZ1b5Hqw==
X-Google-Smtp-Source: AGHT+IEefJdMKI8wkbUnTDRxw3MAhhTLd/xrtqsB9JhDqpHCGBd1IAvpOfXgRQ8kX0FbzVXPfmjSBA==
X-Received: by 2002:a17:907:a03:b0:9bf:889e:32a4 with SMTP id bb3-20020a1709070a0300b009bf889e32a4mr43387ejc.54.1698335091602;
        Thu, 26 Oct 2023 08:44:51 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-aa18-f9fe-f627-2a46.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:aa18:f9fe:f627:2a46])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906841100b009c8b720cf59sm8331164ejx.42.2023.10.26.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:44:51 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 26 Oct 2023 17:44:49 +0200
Subject: [PATCH] iio: common: ms_sensors: ms_sensors_i2c: fix humidity
 conversion time table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-topic-htu21_conversion_time-v1-1-bd257dc44209@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHCJOmUC/x2NQQrDIBRErxL+uoIaSNNepZRg7KT+RTR8bSiE3
 L3a5eMxbw7KEEame3eQYOfMKVYwl458cPENxa/KZLXtjbaDKmljr0L5WDP5FHdIm0yFV6gb3Gg
 wDlfdL1QLs8tQs7joQ2usLhdIE5tg4e//9vE8zx9aM49KhgAAAA==
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698335090; l=4449;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=8iImRaAF6cpsowlFJX62gZM3TPXl66xs7q2hHDrIAkk=;
 b=2mcpbQsmBS2XjpaRDf036urt72rxf6gtyy25oLE2pfF8dJKutOcZswYf8URTLU4Pq20/P4BZi
 L+mLBnl8LcrA6Xqp2tPmEv8E/1XcwFmqLvP9HNmhSZR9vTueKfM6bsy
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HTU21 offers 4 sampling frequencies: 20, 40, 70 and 120, which are
associated to an index that is used to select the right measurement
resolution and its corresponding measurement time. The current
implementation selects the measurement resolution and the temperature
measurement time properly, but it does not select the right humidity
measurement time in all cases.

In summary, the 40 and 70 humidity measurement times are swapped.

The reason for that is probably the unusual coding for the measurement
resolution. According to the datasheet, the bits [7,0] of the "user
register" are used as follows to select the bit resolution:

--------------------------------------------------
| Bit 7 | Bit 0 | RH | Temp | Trh (us) | Tt (us) |
--------------------------------------------------
|   0   |   0   | 12 |  14  |  16000   |  50000  |
--------------------------------------------------
|   0   |   1   | 8  |  12  |  3000    |  13000  |
--------------------------------------------------
|   1   |   0   | 10 |  13  |  5000    |  25000  |
--------------------------------------------------
|   1   |   1   | 11 |  11  |  8000    |  7000   |
--------------------------------------------------
*This table is available in the official datasheet, page 13/21. I have
just appended the times provided in the humidity/temperature tables,
pages 3/21, 5/21. Note that always a pair of resolutions is selected.

The sampling frequencies [20, 40, 70, 120] are assigned to a linear
index [0..3] which is then coded as follows [1]:

Index    [7,0]
--------------
idx 0     0,0
idx 1     1,0
idx 2     0,1
idx 3     1,1

That is done that way because the temperature measurements are being
used as the reference for the sampling frequency (the frequencies and
the temperature measurement times are correlated), so increasing the
index always reduces the temperature measurement time and its
resolution. Therefore, the temperature measurement time array is as
simple as [50000, 25000, 13000, 7000]

On the other hand, the humidity resolution cannot follow the same
pattern because of the way it is coded in the "user register", where
both resolutions are selected at the same time. The humidity measurement
time array is the following: [16000, 3000, 5000, 8000], which defines
the following assignments:

Index    [7,0]    Trh
-----------------------
idx 0     0,0     16000  -> right, [0,0] selects 12 bits (Trh = 16000)
idx 1     1,0     3000   -> wrong! [1,0] selects 10 bits (Trh = 5000)
idx 2     0,1     5000   -> wrong! [0,1] selects 8 bits (Trh = 3000)
idx 3     1,1     8000   -> right, [1,1] selects 11 bits (Trh = 8000)

The times have been ordered as if idx = 1 -> [0,1] and idx = 2 -> [1,0],
which is not the case for the reason explained above.

So a simple modification is required to obtain the right humidity
measurement time array, swapping the values in the positions 1 and 2.

The right table should be the following: [16000, 5000, 3000, 8000]

Fix the humidity measurement time array with the right idex/value
coding.

[1] The actual code that makes this coding and assigns it to the current
value of the "user register" is the following:
config_reg &= 0x7E;
config_reg |= ((i & 1) << 7) + ((i & 2) >> 1);

Fixes: d574a87cc311 ("Add meas-spec sensors common part")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 6633b35a94e6..9c9bc77003c7 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -15,8 +15,8 @@
 /* Conversion times in us */
 static const u16 ms_sensors_ht_t_conversion_time[] = { 50000, 25000,
 						       13000, 7000 };
-static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 3000,
-						       5000, 8000 };
+static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 5000,
+						       3000, 8000 };
 static const u16 ms_sensors_tp_conversion_time[] = { 500, 1100, 2100,
 						     4100, 8220, 16440 };
 

---
base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
change-id: 20231026-topic-htu21_conversion_time-9ea81e86703f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

