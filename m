Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A17F8A65
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjKYL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:56:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B310E2;
        Sat, 25 Nov 2023 03:57:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a08e4352992so200601766b.1;
        Sat, 25 Nov 2023 03:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700913418; x=1701518218; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ompf+2OoF8BHJ5J3VWaaBr54to0LIdPuwB41zRGN5Ew=;
        b=DW/8bsSPqYXIE1vUSXQ2ujMIPKAnkH51X06pXrfokRXjo/SP4L+TGsKtJF2LYBUX8w
         SNDS4llDUSptOj6lkYzR7Fv9ltgFL+EnPxigsbExOYxYaqDcDtG+uX2u/jUS/k/U0Ins
         eCE24iirtnQooCW6qyqhNngACRfJN896JRzvSzQ3zjvemWpYr5A9PjV3w/ClPd9mEWpf
         S+DOT7ElSeNE+SApH2D7i7XR4JGlvzPnMypQYLTMCz6zaNc17YGaDy6p5CbofHUaFX08
         NwfR1UkUXO6F1q9igB2b4NPlqiZ1gN97cImyaQUT6wQru15dzbNaW6nxl9E19S8y6YoO
         YAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700913418; x=1701518218;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ompf+2OoF8BHJ5J3VWaaBr54to0LIdPuwB41zRGN5Ew=;
        b=gCoCdjbjcYmUxtoX18xvazwQsJ82uczmFni062Lr1SyeZ+VxMrig0HZBUAkE+uSQGF
         nDANY0sm7AUuNqNRkiTl72pW6ITSq+lU9o5yGeu583j+6Cj3fl8W8dsy6b2F8Qon4Joq
         P56uI6UAoMmUGL5pZHDPBlARE//TMF1IswPl7aFz/nxif3ptWdfBE/zsHEqJH2U9ignN
         yJJQWN1iaAinQPz4/2sxOwEpHMgchxXJDO0J+/dde+6vfojFyrjSe5llRwq6q+2OHYyj
         Cnn814LLj9kKP4Ls3Vdsv16tvKl7uR0ksC9gokh45kQY0Z8F0hdEj+CJNatd5DUuCZVt
         N02Q==
X-Gm-Message-State: AOJu0Yx/tvSATVOrbtdpGuGQ5AxiNZ3tvLL4BVXWzxbaoLJAqgsF7TdM
        VHflDG99CfKQtRGd3UM/7X8ubYttiYLtTg==
X-Google-Smtp-Source: AGHT+IG8V+U/oUNdhKDvTKV66NneglcSu8tT5u8d4jKdseqIwXPLcV7GP/U9F1EGzlO9ClkIkZXl1w==
X-Received: by 2002:a17:906:1da:b0:9be:466c:1824 with SMTP id 26-20020a17090601da00b009be466c1824mr4424311ejj.11.1700913418153;
        Sat, 25 Nov 2023 03:56:58 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3176-084d-819d-12bf.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3176:84d:819d:12bf])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906a21100b009ae57888718sm3344349ejy.207.2023.11.25.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 03:56:57 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/3] iio: light: add support for VEML6075 UVA and UVB
 light sensor
Date:   Sat, 25 Nov 2023 12:56:54 +0100
Message-Id: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbhYWUC/22NTQ7CIBBGr9KwFsMMRaMr72G6mOLYTkKpASWap
 ncXu3b5Xr6fRWVOwlmdm0UlLpJljhVw1yg/UhxYy62yQoMWAIwuPIWDOTptERyiZ/J0UjXeU2b
 dJ4p+rIX4CqHKR+K7vLf9a1d5lPyc02e7K/Czf5YLaKOta3uLrWNo6TJMJGHv50l167p+AcmuO
 0S1AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700913416; l=2267;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=8qA1rB2jysMdnP4QbGebjf0iuxSJmGaYBpBZjDzcCXg=;
 b=ZxpFNQuv5NQEw1dyG6cIZJCR3thWA32K5ZvNMSMFUXsVPEf2SKydE1nkcGvVrDcugmePHJwut
 47rjDDhiISPAxksDzOAMM17kYyd9hEWaQGS3ALkAJLH+XT8z522Llmd
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
 drivers/iio/light/veml6075.c                       | 486 +++++++++++++++++++++
 include/uapi/linux/iio/types.h                     |   2 +
 tools/iio/iio_event_monitor.c                      |   2 +
 9 files changed, 554 insertions(+), 2 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231110-veml6075-321522ceaca9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

