Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3C7B646F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjJCIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjJCIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:38:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC81A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:38:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40535597f01so5948645e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696322320; x=1696927120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DsmPwmdbvUQU1M3M1OlojdLb5jD3QCY1+hcT64UcVY=;
        b=SJx/l7zfmBP43ul1LyThtUdBcomyoYtPUlisz6LDgJyMAxcJNyVBFDRURbIVzAo1mR
         TqEsMZjAPbLCVrZ9aAI3Sh2y5pxXfG669QI54hTCGkVpSa+cH9hTPp9uuLzsKWQBAvFB
         G0in5tCOvPOVBHGTFYNEM0UW/87ySVnwP+FZaJvg31PyVMXz3h7mLSgMuKvuT8VnAKu6
         gtNWU7bJ6ucAE+olHNcp/zS1t+0vsOnwmK2xg5uIONRE0sJWMvam5MYHmqHVcK6Qavmw
         Xh3WyvNQwQBM1gORFQV8r0M2WQEDQI9VQ8qQc+wjiE5/I2nSuUz2mIm3n/y4/qDCPpfK
         3xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322320; x=1696927120;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DsmPwmdbvUQU1M3M1OlojdLb5jD3QCY1+hcT64UcVY=;
        b=mEd9QqRT0Cxyn3+Dm1Z6zhc+/MbNHeMaIWISmrRzzQfmyfdNLfrTAI8SS20DD9zAVN
         Pn8PfHRpp7mpwpEL5vtFtLEhzZ+TvrwjKka9+rn//ks7XY7v7HDI9i/zgMPKpu4+HHmo
         7VsgylEluC3gapiQ91E+yiwb/nXgowf3UyYL735z2YZhAGMJoC08Vi2T296k+S2JAejq
         1RD159GWnMJy5UuJ54uecrY4hmMTGGDxFe1ZbOtr3m/C6/enEuQM0I2U533lSvTERMZT
         LkQEhiLbJMl7SIJXAhJD/ispJ05Mm8Nv4JLDrmXSXYXUeJrdsDbIB2MeLwxqfca+CWKc
         r8wQ==
X-Gm-Message-State: AOJu0YyHPDIzLySht+c2gtSw86wjcEb8AjoxsqF8bRQFCos0glmXDxm+
        dqGQNg5TMhXDr0RTQn3xmLPmHw==
X-Google-Smtp-Source: AGHT+IE8zNBvMqGDnHxXWC4124C+zApQkL4b+H1sXTC+yJbR4zZMeRQ5EwqKQARBeYdi6ZGDYQLPag==
X-Received: by 2002:a7b:cb89:0:b0:405:3455:e1a3 with SMTP id m9-20020a7bcb89000000b004053455e1a3mr13173127wmi.17.1696322320003;
        Tue, 03 Oct 2023 01:38:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b00405323d47fdsm733597wml.21.2023.10.03.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:38:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v8 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Tue, 03 Oct 2023 10:38:32 +0200
Message-Id: <20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjTG2UC/53RwW6EIBAG4FfZcC4NIAj01PdoegAclMSKQddss
 /HdO+6hm8aL9fhPyPcPmTuZoCSYyNvlTgosaUp5wGBeLiR0bmiBpgYzEUxUrGY1nfOYAm1zbtK
 Neih9Guh1nOYC7oumIc3J9dQ7q8FAMFEGgpR3E1Bf3BA6xIZr3+NwLBDT7dH98Ym5S9Ocy/djl
 YVv03+2LpwyKh3TknvjIDbv+MyV/JpLS7aGRZxRBaqi9vgZ4GAZ7NTqjFqhGpnSOoBrNLM7VZ5
 RJarMSh2ksR643qnqqRrGD6pqU7UVSthKKVvt1PqpWi4OqjWqXkKITtro7f5a+lfljB1VNaq4K
 oI8KjDmj7qu6w8DfjOv8gIAAA==
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
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4736;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=i2ZbGFYQgpJbzpu15MKmnfJz8X1iofBc5kNU563O7DA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlG9MMFKuqZlpuHS3P1LNvBHcSF/4XSqyXKYJT3KUj
 GDQngzWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRvTDAAKCRB33NvayMhJ0VRVEA
 Cru4ZuvP8h7cyPC6eC1fDjhubKnL/IWXLz6DgQG4LsKc1NxsgvIAUFVok+TPbbptB7sKniAHvNxawA
 okR2c6qA4zJNkt1f3lZrjwOYrQHnvk1HFwlI47AxqF0J8JRoOETWQ/2ZCqhAOjCojkAdcZXzPh5l2I
 fSNtN5DLLKLHexN0hX5l6OjMOq8rrdORTq16hcd9/cxK/YqrmCJzj63tLSFCuyElprnqBH3B7aWrWp
 MGJX7z6TQzPGg+GCgMcA3lDMO2mCE38UvMtMTavnnUmz+I7YB+zXFe+T6OLHeTzsEUA51dVGXPqCDi
 vZtkcj8y7U7ZXc3nvtFxpDneMCiPPdq7em4TMahT/801UUE7FyIHPZHV/MhaEGuvIOo58HSDd/32Ce
 db+PdPUl/qODm3IwFBqmZNyQFv1sQWgtnF5In2bBbPJ4nDliU5+f399CKw3veBmViyY5aQQhIt5XAM
 VxIXn3JtAPipGJUtdEMhnOtq2+dsL4tgI3aOr2OKki4GfeUWpPUEXbkUGnQZwz63wA5KWm4cb6jfG+
 aKkCHk+pfJ/BuihunS567jZDucr80xMZ/AS8yOcwRocynpQXn8GRcghKQMI3rNjh21UCQ0U2P06cKZ
 1bXIYAXU9+bCL4obQ0CjziIjJDE7Z43roHyJGtn7eAh550SMx9/wB3nC3tTw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

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

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
 drivers/input/touchscreen/Kconfig                  |  31 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 582 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 173 ++++++
 7 files changed, 1112 insertions(+)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

