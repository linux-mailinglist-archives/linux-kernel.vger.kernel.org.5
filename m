Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286DA811A89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjLMRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjLMRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:13:17 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE848F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:13:22 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so92493931fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702487601; x=1703092401; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfr047CJmFVYGyC6u7HATirhSSdF2uxrBFBr8iqJs6o=;
        b=AmbZDJpHYhU4OvPXu9KSJqIKTl82+fTkcT/ivzcVCHbe9h/8GxsL5EnU6Yn4j/gvSH
         IRCV+R4bIDHi/mRg4S225QsmW/nVfh6f3i+VSLjwGkiXrMwApgbOj2T3dtvOUeTWVe/d
         ZfCiu6aAjGn/c+3mUwdLsD4IrLJgIszYtUYphALNypo+qD3wHBF9rlmes2Ll/3TOXHDy
         a+mqqEVMM/ZTmIngP9a/v9h+sDFAQ+KsxCZzyuAUjQPYnLjtRhiilnNMMS4atCBlMciO
         TKMVGdt2cZ5YlrPpr+7zhkYQ7WA+I1lCkaclKAk85vS6ZkZDOrFQ+ERTPRy54b43NsJo
         udbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487601; x=1703092401;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bfr047CJmFVYGyC6u7HATirhSSdF2uxrBFBr8iqJs6o=;
        b=PFiabOycI+RTM6qvso9RWn++VGyGnR8+/h9+qNeMv5MtWkFsdg/GlaUULTPOZWCEkF
         XmwkSyYZ6ZqT4knxEkP1XKj768DvMlnke4XQKUG8wXmHebMurGURWuQqHMuNHelB9HRa
         Rm65fHDiOmDRHeqeIang8WtKDh/oQi+7+UGMcsyOq5mmNaskrMRy9Ol5bQx0pvKTg1+r
         S5PytNsDC3i3/sL97F5Ccrc0qT5JVNnYBMLcIwGXM6ddpwKFXojMq8QBCL1fSI2G6TKw
         wpIll+/ROlBMq1UXJLwko1cRzkKDxN+B/hkN9UMRpndO2m1kn+ZF9Bak+/VCUpe0lK4J
         GKsg==
X-Gm-Message-State: AOJu0Ywj0KPcX7l3RML2CWRmQlKtOgJo03oiYJMmktC+pDTthn7SyefP
        7OLGO0X9IsP81ynhjxLw6ikmlA==
X-Google-Smtp-Source: AGHT+IHuvsNhveoE2ssuyookqE7k5MmOVDDPQahe1zDiITRQQdSxUcbASrzK4jWKuAjqrJqfaZUrzw==
X-Received: by 2002:a2e:ab18:0:b0:2cc:219d:d42 with SMTP id ce24-20020a2eab18000000b002cc219d0d42mr4850151ljb.104.1702487600810;
        Wed, 13 Dec 2023 09:13:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fs27-20020a05600c3f9b00b0040b36050f1bsm20711039wmb.44.2023.12.13.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:13:20 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v13 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Wed, 13 Dec 2023 18:13:14 +0100
Message-Id: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrmeWUC/53TwW7DIAwA0F+pch6TTSDATvuPaQcgpkXqkoqkV
 aeq/z6nh7UTl6xHLPRsbHxpJiqZpuZtc2kKnfKUx4EP2L5smrjzw5ZE7jnQSJAtdNCJeTzkKLb
 j2OezCFT2eRDHwzQX8l8iD3nOfi+Cd4YsRZtUbJgKfiIRih/ijrHhuN9z8FAo5fMt+ccnn3d5m
 sfyfavlhEv0n1lPKEAoD0ZhsJ5S/87XfBlfx7Jtlgwn+YwqWZVd4McQkgOq1PYZtWU1gTYmku8
 NuEpVz6iKVXDKRGVdIDSVqu+qBVyp6kU1TmrpWq1dW6ndXXUoV6odq0FRTF65FFw9LfOrIsBa1
 bDKpTKISZO1lWof1XalallFgzwIBEl9V6nuQZVr++oWtU3cBGsN6lpFeGTXFos8LWEtUZSkMUK
 o3ft6Ia5fr2W/dFSGnAETof4HeF8wlODWusuGkU/JU9DcDv3HvV6vP5EPwGanBAAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6485;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pU9H2UHzkCsD41LinXb2qliV6+2X2qipa6vZEOGJNVE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleeYtmjdcpa4AmucGIHTpOVbLW/j/nWiGfglkR5zU
 HFueerqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXnmLQAKCRB33NvayMhJ0RzhD/
 wIcEUsR/4zpgij23fVG/KkaD9Yv5Ia2LELulabiLA6S0EXq9fxQ6LzVDQX1yq7lUetNBG1+kdYLkfv
 N15xgMsuf+H9IO5o6jzOW4OqfJYfNfiXg0wlV/A3o7pEKkSEY22CIqp5cP20M7BOp97HhXpMYA2fBS
 7zSEgzSekUaKScym8M8BsdhthZUE6iKfr/4l0zS0LcggPEk+Y/TmjLIJH5WAd+emBFgCcWKE9W0hU8
 PGC/mUs0JzMa63hehO2fnU4guWcPQckBE6DffJoaWQLKuK3mtGTwjiQHeEIEvSKTcbFRJzjuATYd21
 N1zUuW1fOR/xvnBSFSlmwaDCjjh9Ooy99G62FTqQX1t8csHBrBqZoZ0XdGwKD6C6WdMMyCaJWe4810
 1nBBwL0y3cIRLcWGhGD0NJZBrMqALaITgjt9TRe3puXCw9yh9QOZqYKXOZrDlXhgw2+YHaRHE67JEH
 n+8jzU9Z02FiJa1F6FDMlNUs9PcboCNBocneUeIbKtF7p+Xh8KdMfp3VDKrDdglbsrukeDplpX34Tm
 RPD9uK2JgfwesOyYayAtrz2ngdeXujdjzM5Yu9NKZOTFyZX351K+KwsfTDEdzbuARLpPky36HHmq3y
 WFGDrJOj8/2JFvrleduwiEwpH5YA68RIQCc8cKbtWPdYlAqSBA9WnOynJBEw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550/SM8650 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v13:
- Thanks to Dmitry's suggestion:
  - Move core defines and structs into goodix_berlin_core.c
  - Comments typos and rephrasings
  - Identation fixes
  - Refactor of goodix_berlin_power_on
  - goodix_berlin_get_ic_info move to __free(kfree) to avoid leaking
- Added comment explaining how data is retrieved in irq handler
- Link to v12: https://lore.kernel.org/r/20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org

Changes in v12:
- Rebased on next-20231208
- Link to v11: https://lore.kernel.org/r/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org

Changes in v11:
- Fixes according to Jeff's review:
 - s/dev_info/dev_err/ in goodix_berlin_get_ic_info()
 - remove spurious return instead of goto in goodix_berlin_get_ic_info()
 - added back dropped msleep() in goodix_berlin_request_handle_reset()
- Link to v10: https://lore.kernel.org/r/20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org

Changes in v10:
- Fix according to Dmitry's review:
 - move goodix_berlin_get_ic_info() afe_data to heap
 - merge the goodix_berlin_parse_finger() loops and skip invalid fingers instead of returning
 - remove unwanted goodix_berlin_touch_handler() "static" for buffer
 - only call goodix_berlin_request_handle_reset() if gpio was provided
 - use "error = func(); if(error) return error;" instead of "return func()" when function handles multiple error cases
- Link to v9: https://lore.kernel.org/r/20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org

Changes in v9:
- Rebased on next-20231020 
- Link to v8: https://lore.kernel.org/r/20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org

Changes in v8:
- Add missing bitfield.h include in core
- Link to v7: https://lore.kernel.org/r/20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org

Changes in v7:
- rebased on v6.6-rc3
- Link to v6: https://lore.kernel.org/r/20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org

Changes in v6:
- rebased on v6.6-rc1
- changed commit message prefix to match the other Input commits
- Link to v5: https://lore.kernel.org/r/20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org

Changes in v5:
- rebased on next-20230801
- Link to v4: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org

Changes in v4:
- Core updates:
 - drop kconfig depends, deps will be handled by _SPI and _I2C
 - change power_on() error labels
 - print errors on all dev_err() prints
 - remove useless default variable initialization
 - switch irq touch checksum error to dev_err()
 - add Jeff's review tag
- I2C changes
 - change REGMAP_I2C Kconfig from depends to select
 - add Jeff's review tag
- SPI changes
 - add select REGMAP to Kconfig
 - added GOODIX_BERLIN_ prefix to defines
 - switched from ret to error
 - add Jeff's review tag
- Link to v3: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org

Changes in v3:
- Another guge cleanups after Jeff's review:
 - appended goodix_berlin_ before all defines
 - removed some unused defines
 - removed retries on most of read functions, can be added back later
 - added __le to ic_info structures
 - reworked and simplified irq handling, dropped enum and ts_event structs
 - added struct for touch data
 - simplified and cleaned goodix_berlin_check_checksum & goodix_berlin_is_dummy_data
 - moved touch_data_addr to the end of the main code_data
 - reworked probe to get_irq last and right before setip input device
 - cleaned probe by removing the "cd->dev"
 - added short paragraph to justify new driver for berlin devices
 - defined all offsets & masks
- Added bindings review tag
- Link to v2: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org

Changes in v2:
- Huge cleanups after Jeff's review:
 - switch to error instead of ret
 - drop dummy vendor/product ids
 - drop unused defined/enums
 - drop unused ic_info and only keep needes values
 - cleanup namings and use goodix_berlin_ everywhere
 - fix regulator setup
 - fix default variables value when assigned afterwars
 - removed indirections
 - dropped debugfs
 - cleaned input_dev setup
 - dropped _remove()
 - sync'ed i2c and spi drivers
- fixed yaml bindings
- Link to v1: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org

---
Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      Input: add core support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 +++
 drivers/input/touchscreen/Kconfig                  |  31 +
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          |  24 +
 drivers/input/touchscreen/goodix_berlin_core.c     | 766 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  74 ++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 177 +++++
 7 files changed, 1170 insertions(+)
---
base-commit: bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

