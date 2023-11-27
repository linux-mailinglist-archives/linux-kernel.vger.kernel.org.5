Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4A7FA810
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjK0Re1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjK0ReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:34:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0790;
        Mon, 27 Nov 2023 09:34:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-409299277bbso33236945e9.2;
        Mon, 27 Nov 2023 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701106470; x=1701711270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMR2AzaNP6dtsYlxVMl7E7nXSabAWLa9DNxxIFd59k4=;
        b=Vzgs4/HsCi11zqtuks/HmeMR/5wuGdvsUder6xTkdlEpF6yYKIRD0ZJKaU7kIVc4KC
         dlO9GODwGJP9HCaV5GQws/bPwFHpSsOxFNfNvrqi2f5dKQyU2IK/nJkVvshfR6aWnTXy
         MOy7qfgBdXM0bPrWJoIGUDGKYoJGg729EPGAZlnuWimpi6Il31NIqIgYv51+ulqktiBo
         vwNH1D5DkodtiyM1C54aAMW/6JX7wBnWkBa41vdODjOmzcfTmeydLd7+KA3e8V7yyKZD
         sExrKfX1SFKL/3zBZIOAMcTHFfVRbJNlVu0PSBDUnWjIsbljCIjG8xiPl8bv6AhU8AkC
         FUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106470; x=1701711270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMR2AzaNP6dtsYlxVMl7E7nXSabAWLa9DNxxIFd59k4=;
        b=CsvxMX5ektRUr1ZGRjDAKvO+62PMfZGb+NrmNI85L/P5Lr5oaSu/FHkVe2RDlSDJu9
         umbWWMcPxtbGbfgEsZL4/AK+9Z9kHyCbZMXviYFycb0+quouR3HptnY+djTmp17Kj7Ah
         C2DB8ueyfEc4pu9kuF3UHlzqU7AOtP9osJNAL1i8yNPb6baJru7ScExK+fRR8Xwtx2wF
         dBz/sMYa13gzNxmc310qybXXXd0xbMuGgNu8SKbPrzmSK9eUfmmYKRR9OrxqnQaImHNh
         BJ/AX4V8L71NCWgRglsMxlSeFGnDGGa4pIa1WYX9uXh1LW6RYmgvmdl6lfsrUVrKAdQf
         Iaeg==
X-Gm-Message-State: AOJu0YxecfbQJBYDJcnUMnS4S2dGDzI0rZ5XK/EQcUjNvgYz6C0F+Ogo
        bxQN2l/jvLDN9fvHRyzoJ+s=
X-Google-Smtp-Source: AGHT+IG3cENoOyM1tLbWu17mI0hNJOKfLtmjDf/rLwg1+1jpowY4BpyUdoKvDh7hnCmB+C+OZRyNww==
X-Received: by 2002:a05:600c:1989:b0:408:3f87:cba with SMTP id t9-20020a05600c198900b004083f870cbamr8743868wmq.39.1701106470453;
        Mon, 27 Nov 2023 09:34:30 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-aa01-5533-a7bc-788c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:aa01:5533:a7bc:788c])
        by smtp.gmail.com with ESMTPSA id je19-20020a05600c1f9300b004083729fc14sm15139626wmb.20.2023.11.27.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:34:30 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/3] iio: light: add support for VEML6075 UVA and UVB
 light sensor
Date:   Mon, 27 Nov 2023 18:34:27 +0100
Message-Id: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACPTZGUC/3WNzQ7CIBAGX8VwFsMu4N/J9zAegG5bEkoNKNE0f
 XdpTx70OF92ZieWKXnK7LyZWKLisx9jBbndMNeb2BH3TWWGAiUACF5oCHtx0FwiaERHxpkTq+f
 WZOI2mej6KsRnCHW8J2r9a+1fb5V7nx9jeq/vCizrj3IBLrjUykpUmkCZSzcYH3ZuHNgSKfhPx
 Co2QlFr3dG2Gr7FeZ4/9scZxe4AAAA=
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701106468; l=2761;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=OMwY/jKvDu8C3jplLlM5jK7D4g8rurvRZ9c6ohzQ9oU=;
 b=YeVlqLGNl4FGKDS94OC/YyuQEU/QpF3QUqaPskq+WieSahVQ7/g032rEuR6kdBMDn/3rjLNE3
 VLhFWF/+8w4C2P9hWkI1i3s5D5q/LpiirfuXN49TGLWEC6Hv6dFd3Hf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Vishay VEML6075 ultraviolet sensor,
which offers UVA and UVB measurement channels and I2C communication.

The device bindings and a simple example are also provided.

This driver has been tested with a Gravity VEML6075 UV Sensor Module in
open air conditions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- veml6075.c: use MICRO instead of 1000000LL (add linux/units.h).
- veml6075.c: improve lock description.
- veml6075.c: remove unnecessary i2c_get_client_data() from the probe
  function.
- veml6075.c: remove shutdown function and do the bit update inline.
- veml6075.c: improve return path in read/write_raw().
- veml6075.c: remove -ENODEV return check for regulator_get_enable().
- Link to v2: https://lore.kernel.org/r/20231110-veml6075-v2-0-d04efbc8bf51@gmail.com

Changes in v2:
- General: swap patch order (bindings first).
- iio core: add uva and uvb modifiers.
- veml6075.c: use uva and uvb modifiers instead of extend_name
- veml6075.c: remove redundant information from the description.
- veml6075.c: inline device name.
- veml6075.c: use read_avail() for available attributes.
- veml6075.c: use guard(mutex) instead of lock/unlock().
- veml6075.c: use regulator_get_enable() without _optional.
- veml6075.c: register managed iio device and delete remove().
- veml6075.c: remove remaining debug messages.
- veml6075.c: error path cleanup (return type after val assignment).
- veml6075.c: remove zero from i2c_device_id.
- MAINTAINERS: fix bindings name.
- vishay,veml6075.yaml: remove vdd-supply description and mark property
  as true.
- Link to v1: https://lore.kernel.org/r/20231110-veml6075-v1-0-354b3245e14a@gmail.com

---
Javier Carrasco (3):
      iio: add modifiers for A and B ultraviolet light
      dt-bindings: iio: light: add support for Vishay VEML6075
      iio: light: add VEML6075 UVA and UVB light sensor driver

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +-
 .../bindings/iio/light/vishay,veml6075.yaml        |  39 ++
 MAINTAINERS                                        |   6 +
 drivers/iio/industrialio-core.c                    |   2 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml6075.c                       | 474 +++++++++++++++++++++
 include/uapi/linux/iio/types.h                     |   2 +
 tools/iio/iio_event_monitor.c                      |   2 +
 9 files changed, 542 insertions(+), 2 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231110-veml6075-321522ceaca9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

