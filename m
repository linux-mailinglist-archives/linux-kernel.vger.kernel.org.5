Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF08091B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjLGToy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:44:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C971708;
        Thu,  7 Dec 2023 11:44:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33339d843b9so1390341f8f.0;
        Thu, 07 Dec 2023 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978296; x=1702583096; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODAetODriyWLBfgRxIkO8WbZl5Xnc+DQSeFmQhVOOfE=;
        b=mwtQ2fJCGaOBUihlXTy6Mm9J2opYFcAi0j5wpep1PNZfQlSLo3K5kCm4WL3rknrnty
         ZkYlHJ7okryA5RTyletWyNN+FF3EysLKjeFzHWWt1jLk1MySRLH/ikKTEkxJf1dDCh8J
         3z/OeaUPVomLgcYMeqC9l+JiGM3dAIqvLvef3rfF4ZlpiotD+3aNjaTsByQFYowBQr+Q
         tFWjtW9ijbmSNvsdTpU47hjVhRGzSg7lu3WiO87Dt+VRyNtoZ2fSiScq88Lm2mcNVrUN
         7mCfubkK2XI3t9k/Vk+OefjSjJpzJor/EzX2fCkf1K9SapbkflbH/BACGfiy7yQTGiCt
         2IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978296; x=1702583096;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODAetODriyWLBfgRxIkO8WbZl5Xnc+DQSeFmQhVOOfE=;
        b=xIg4SiydDA/yJTlYmd87M3qeuN+1x3L/SZaauiO6pE9FqVI27sAeRCE06oQiVfc5fV
         V2zCtd8pQ3HQWBrC3c7HSwzbQxe8krX8usdglOMrqJKKV2VmA+R+YOBsmLyfWQR15gKj
         fkZoIa0YNULatPnn1bSDpWa47qzszV1Xd0wkLgsjjvrxFZzMxHBI7JjkkuSmGMv9+rB2
         0Jx0Sy5a+PNQx2/4w13E52425JEOalK/O7VUohxUHnd4rPFoPqZVH40Tx2ayn53Ru69J
         UULqI1YYn7PerFKAyQYlJtUNN8ILZh84adT+X/rdG3PLu72miAnOyXqR9Guma22tLm1r
         WA8w==
X-Gm-Message-State: AOJu0Yzf9/FCY5C9nDsp3QjGi4R7EI0kqo5HzdkobE7IhSpFHMJy95A+
        H78fSHMCEmUZBV2Bf/E8tFBemffDQ19K1w==
X-Google-Smtp-Source: AGHT+IEY2oIagu+Gj4Fc690185mHBpl72OF3xWeYIgdW9IRLOipVSo3AgwWTxX+yW8CdKMy0EFx3gA==
X-Received: by 2002:adf:ed06:0:b0:333:380f:2d2d with SMTP id a6-20020adfed06000000b00333380f2d2dmr2203658wro.92.1701978296277;
        Thu, 07 Dec 2023 11:44:56 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1de9-f6cf-eef8-174f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1de9:f6cf:eef8:174f])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm127364ejc.75.2023.12.07.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:44:55 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/5] hwmon: Add support for Amphenol ChipCap 2
Date:   Thu, 07 Dec 2023 20:44:50 +0100
Message-Id: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIgcmUC/32NzQ6CMBAGX4X0bE27/AiefA/joWwX2ERo0xKiI
 by7hZMXPc5u5ptVRApMUVyzVQRaOLKbEuSnTOBgpp4k28QCFORagZKz84wSB/ZoPEgCWzd1WeQ
 KQSSpNZFkG8yEw66NJs4U9ocP1PHrKN0fiQeOswvvI7zo/fqzsWippKovBNoWrSZ760fDzzO6U
 exTC/zXIeldiTmUTVV1tv3Wt237AKficcQEAQAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701978294; l=3636;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=rzfCYZubHRyLXBqxD4RJvarNpshkMo3wb+FzrsdmjT0=;
 b=d1MiuSSrcZZjuwogYhweoMFAajaYPRinrkRv5R2LXalXOEGN9roQFIwGNJ73610Lg3zosMPC+
 vS9+NRmwwZdCwTgVsmZFQyu+uSTMlGEG4b/a2QqGWmWRcuD0mArFRK3
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

This series adds support and documentation for the Amphenol ChipCap 2
humidity and temperature sensor in its digital version.

This I2C device provides 14-bit humidity and temperature measurements as
well as low (minimum) and high (maximum) humidity alarms. A ready signal
is also available to reduce delays while fetching data.

The proposed driver implements the logic to perform measurements with
and without the ready signal, EEPROM configuration and alarm signaling.

The features this driver does not support (I2C address and command
window length modification) have been documented in the "Known Issues"
section.

The complete supported functionality has been tested with a CC2D33S
sensor (a 'sleep' device) connected to a Raspberry Pi Zero 2 w.
Different device tree node definitions (with and without regulator,
ready and/or alarm signals) have been positively tested.

The non-sleep measurement mechanism has been inferred from the first
measurement, which is carried out automatically and it is common for all
part numbers. Any testing or improvements with a non-sleep device is
more than welcome.

The tests have also covered the properties added to the hwmon core to
account for minimum and maximum humidity alarms.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- ABI: sysfs-class-hwmon: documented humidity min/max alarms.
- General: reorder patches (bindings first to remove checkpatch
  warnings).
- General: remove part number wildcards and use real part numbers.
- chipcap2.c: improve error path in probe function.
- chipcap2.c: fix error handling if regulator could not be registered.
- chipcap2.c: use absolute values for hysteresis (for both ABI
  compatibility and simplicity).
- chipcap2.c: minor code-style fixes and variable renaming.
- Link to v2: https://lore.kernel.org/r/20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com

Changes in v2:
- vendor-prefixes: full company name in the vendor description (Krzystof
  Kozlowski)
- chipcap2.c: proper i2c_device_id table, coding style fixes, cleaner
  error path in the probe function (Krzystof Kozlowski)
- dt-bindings: per-item description and lowercase names (Krzystof
  Kozlowski)
- MAINTAINERS: fix manufacturer name (Krzystof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com

---
Javier Carrasco (5):
      dt-bindings: vendor-prefixes: add Amphenol
      hwmon: (core) Add support for humidity min/max alarm
      ABI: sysfs-class-hwmon: add descriptions for humidity min/max alarms
      dt-bindings: hwmon: Add Amphenol ChipCap 2
      hwmon: Add support for Amphenol ChipCap 2

 Documentation/ABI/testing/sysfs-class-hwmon        |   18 +
 .../bindings/hwmon/amphenol,chipcap2.yaml          |   74 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/hwmon/chipcap2.rst                   |   73 ++
 Documentation/hwmon/index.rst                      |    1 +
 MAINTAINERS                                        |    8 +
 drivers/hwmon/Kconfig                              |   10 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/chipcap2.c                           | 1040 ++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |    2 +
 include/linux/hwmon.h                              |    4 +
 11 files changed, 1233 insertions(+)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231020-topic-chipcap2-e2d8985430c2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

