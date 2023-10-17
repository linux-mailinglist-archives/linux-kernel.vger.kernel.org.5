Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F547CBEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjJQJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJQJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:19:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C09F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2602160b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=himax-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1697534350; x=1698139150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQrLFPQFt1F5LXm+iqqKkTk9oKTtyDdmvV5/il7M5b8=;
        b=jwR01Je0ioJQHaqSCxH7fwd9RGnmZ7TNDDFUlSm4QflZmPAPIbeAUuG1decJY/o6Se
         IvP2GTRDP1JN3+wquhpxxL4G3erMf88hveMwSXf5Nfbl6k4Ji05IMQcqKizOSwzT7kgc
         KRKkQw84If0UfL8/eg3TGyhbmIRvi7Czsi0GKnd3Ss2Y+Rfz2hlaTIsOnW9WKdbaEBVW
         hy/KMnqnqCsB9Qg1W17qiSWFiOdN5ByGxHsjFJrqN647Xo5UB7awCGz/Jj59kq9YZPrH
         WYv8P3Z0KTLM1XGsL50vyR+xneYEaoOpmziMOqOLikJsGT7fTAm5Cr6vTj7KN0DSI9ll
         ZEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534350; x=1698139150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQrLFPQFt1F5LXm+iqqKkTk9oKTtyDdmvV5/il7M5b8=;
        b=vYfaX84Xd7I4sBXNKDfRyZ0RpIf2hTHFF8Ec7KhyREwwEgNr2dyvbNuDGAgNOU3MDW
         ybp0Hxznz1m5sxhLB9YSNIdzdNHwFtxisCu0crUdTTWF3cOmke4axSKFvj/ReHKqkjBD
         DMCPB+yf2FK4F5wmd+jcpItD81wzVj0hQVmmvjRM/jkksx+F2JuL5gNYm6FWvmyUvXI7
         YNwq3NJkVC5rVahwprzgZFarDuEuPU2NbANBgjG57qMDg5fi5pnLx7AtM7rGBkGv3g2P
         YcsAAiWMpkdt2trEEfYz0ZLcOXo7srAdY7C0jQWG6YEUhYiTIZmtWELKOGo/LCB0CEJN
         fwwg==
X-Gm-Message-State: AOJu0Yxp8HaYQJNqpybg2txbPgrpacZrGdfS0Tz2/12bGOa2HVl9v1A0
        wdlno7lvPIw2ozZfG8pAsvRkBA==
X-Google-Smtp-Source: AGHT+IGKiqR6U4SclzE7t/fRN9sf33k8wm1Zji/JR/QXmM3XzzFKq3ehJELmxArGJUou3rvehbWbcA==
X-Received: by 2002:a05:6a20:9155:b0:133:f0b9:856d with SMTP id x21-20020a056a20915500b00133f0b9856dmr1652984pzc.17.1697534349808;
        Tue, 17 Oct 2023 02:19:09 -0700 (PDT)
Received: from tylor-mini-server.net ([101.9.190.154])
        by smtp.gmail.com with ESMTPSA id pl17-20020a17090b269100b00274de7c8aacsm6003963pjb.45.2023.10.17.02.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:19:09 -0700 (PDT)
From:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
Date:   Tue, 17 Oct 2023 17:18:56 +0800
Message-Id: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds the driver for Himax HID-over-SPI touchscreen ICs.
This driver takes a position in [1], it intends to take advantage of SPI
transfer speed and HID interface.

Patch 1 adds the Maintainer and devicetree bindings document for driver.

Patch 2-4 adds the driver itself, Kconfig and Makefiles. Due to server
could not receive patch >100000 chars, patch separate into 3 parts.

[1] Overview:
+--------------------------------+
| himax hid-over-spi TPIC driver |
+--------------------------------+
| +-----------+  +-----------+   |      +-----------+  +-----------+
| | Device #1 |  | Device #i |   |      | Device #j |  | Device #k |
| +-----------+  +-----------+   |      +-----------+  +-----------+
|          \\      //            |               \\      //
|        +------------+          |             +------------+
|        | I/O Driver |          |             | I/O Driver |
|        +------------+          |             +------------+
|              ||                |                   ||
|     +------------------+       |          +------------------+
|     | Transport Driver |       |          | Transport Driver |
|     +------------------+       |          +------------------+
|                      \___      |         ___/
+--------------------------------+       /
                            \           /
                          +----------------+
                          |    HID Core    |
                          +----------------+
                           /  |        |  \
                          /   |        |   \
             ____________/    |        |    \_________________
            /                 |        |                      \
           /                  |        |                       \
 +----------------+  +-----------+  +------------------+  +------------------+
 | Generic Driver |  | MT Driver |  | Custom Driver #1 |  | Custom Driver #2 |
 +----------------+  +-----------+  +------------------+  +------------------+

version 3 changes
-rename binding compatible from himax,hid-over-spi to himax,hid
-rename document himax,hid-over-spi.yaml to himax,hid.yaml
-rename binding properties himax,rst-gpio to reset
-remove binding properties himax,irq-gpio, himax3v3-gpio and himax,fw_in_flash.
-add binding properties vcca-power, vccd-power.
-add binding sub-node panel and move himax,pid into this one.
-HIMAX_DRIVER_VER update from 0.0.11 to 1.0.0
version 2 changes
-rename bindings name from himax,hid-over-hx-spi to himax,hid-over-spi
-remove "himax,fw_size", "himax,heatmap_16bits", "himax,fw_in_flash", "himax,pid"
 and "himax,boot_time_fw_upgrade" items from dt-bindings and related code
-add "himax,id-gpios" for user to specify hardware id pins
-rename "himax,ic_det_delay" to "himax,ic-det-delay-ms" and
 "himax,ic_resume_delay" to "himax,ic-resume-delay-ms"
-MAINTAINER position adjust: move info to the position by letter order
-Kconfig add HX_HID_HAS_FLASH option to replace "himax,fw_in_flash"
-HIMAX_DRIVER_VER upadte from 0.0.10 to 0.0.11
-remove unused includes and description in hx_hid.c
-add code to map id-gpios value to PID
-correct variable naming style and misspellings in hx_ic_core.c/h
-remove unnecessary global varaible debug_flag

Tylor Yang (4):
  dt-bindings: input: Introduce Himax HID-over-SPI device
  HID: touchscreen: Add initial support for Himax HID-over-SPI
  HID: touchscreen: Add initial support for Himax HID-over-SPI
  HID: touchscreen: Add initial support for Himax HID-over-SPI

 .../devicetree/bindings/input/himax,hid.yaml  |  123 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    2 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hx-hid/Kconfig                    |   43 +
 drivers/hid/hx-hid/Makefile                   |   35 +
 drivers/hid/hx-hid/hx_acpi.c                  |   81 +
 drivers/hid/hx-hid/hx_core.c                  | 1605 ++++++++
 drivers/hid/hx-hid/hx_core.h                  |  489 +++
 drivers/hid/hx-hid/hx_hid.c                   |  753 ++++
 drivers/hid/hx-hid/hx_hid.h                   |   96 +
 drivers/hid/hx-hid/hx_ic_83102j.c             |  340 ++
 drivers/hid/hx-hid/hx_ic_83102j.h             |   42 +
 drivers/hid/hx-hid/hx_ic_core.c               | 3260 +++++++++++++++++
 drivers/hid/hx-hid/hx_ic_core.h               |  792 ++++
 drivers/hid/hx-hid/hx_inspect.c               |  652 ++++
 drivers/hid/hx-hid/hx_inspect.h               |  104 +
 drivers/hid/hx-hid/hx_of.c                    |  214 ++
 drivers/hid/hx-hid/hx_plat.c                  |  502 +++
 drivers/hid/hx-hid/hx_plat.h                  |   30 +
 20 files changed, 9172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hid.yaml
 create mode 100644 drivers/hid/hx-hid/Kconfig
 create mode 100644 drivers/hid/hx-hid/Makefile
 create mode 100644 drivers/hid/hx-hid/hx_acpi.c
 create mode 100644 drivers/hid/hx-hid/hx_core.c
 create mode 100644 drivers/hid/hx-hid/hx_core.h
 create mode 100644 drivers/hid/hx-hid/hx_hid.c
 create mode 100644 drivers/hid/hx-hid/hx_hid.h
 create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.c
 create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.h
 create mode 100644 drivers/hid/hx-hid/hx_ic_core.c
 create mode 100644 drivers/hid/hx-hid/hx_ic_core.h
 create mode 100644 drivers/hid/hx-hid/hx_inspect.c
 create mode 100644 drivers/hid/hx-hid/hx_inspect.h
 create mode 100644 drivers/hid/hx-hid/hx_of.c
 create mode 100644 drivers/hid/hx-hid/hx_plat.c
 create mode 100644 drivers/hid/hx-hid/hx_plat.h

-- 
2.25.1

