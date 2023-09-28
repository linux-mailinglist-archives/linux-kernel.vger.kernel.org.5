Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434157B2145
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjI1PaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjI1PaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:30:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E119E;
        Thu, 28 Sep 2023 08:30:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-277336b8717so6546505a91.2;
        Thu, 28 Sep 2023 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695915015; x=1696519815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COLaeJR0N/VndVEqlx4mmHkfHE/lub9s/T3neKJii30=;
        b=WEy9sbbmYqHLwBkkVshBTNKwpvUqLVswn4FwBk7Ho8INOxqmeON5fKrzgC7HWx1EX1
         BUm/ddGdpspSL1fGIXAYKgOKHZpypox/5HD4PAK5DndylM29SIZ+ZGFyIA5M/QtA0dT6
         BqX5idoQYP5uFabzCssqh5LA4wjxsp9dP/sq31AsiAw025DJ7eFJwmJRL8R94ExjKvi/
         YY+jcxrOBgQrRcUUxVIKFiEmPVnfTaOz5lo32rs8L5CyWS4c+2jvE4WaaVolcRust0mb
         RQTOmTnpEp7SsM/eLA0DTi9j7XBpWuUrWm2NQY4GeujlEetsRqiEL8g7o+FQ11AFgE81
         BjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915015; x=1696519815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COLaeJR0N/VndVEqlx4mmHkfHE/lub9s/T3neKJii30=;
        b=SkymPHZR5FKggtNPyEnVR4wkWtiwisPTd/f+5kqNvu4DfUgf2oEl2s9h02YePZO+oH
         plgZwYI4drvRWP4LlI6D9+f8JZONOkViZvoyLoZXG+IkM2ybomQoYIrHmLA7rp5+ZW0m
         ftj7dPT+nUBocn8mI9tL8RiBQBlRkI9bHiKtjzXxx9c5Lbe77AmT1HMo/6EwWoXItmuI
         ud+pa450/WFxXzvcDuRcMrgZHtS7Wt6YHO0F6pXXHc8iwiTlvfN8Gak05jQASNLg6Osm
         mJM46n/dQmcvKW6LWHB+NK4UxAPmlLNTCGXkImd9Sn0DpQsYDqPnvuEzzaWBYh0tXfhz
         isgw==
X-Gm-Message-State: AOJu0Yw6JsBVPamemm6b4UVBfg+wSAihBgZ0gBpb+jJwLaxXsI6VATWO
        LEPCzYZLvv/K6zqhLyN3qmvWM/nheMU=
X-Google-Smtp-Source: AGHT+IG1d7y0Oh6C22OVDR3sOVdua6syt1xoVhcD71Rp44XforFFBZC9+AWsrBqDHV4D+zD21KCAjg==
X-Received: by 2002:a17:90a:8b8d:b0:274:96a:5007 with SMTP id z13-20020a17090a8b8d00b00274096a5007mr1393951pjn.1.1695915014854;
        Thu, 28 Sep 2023 08:30:14 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:a19c:f3d0:698d:f7a])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm3892318pjg.51.2023.09.28.08.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:30:14 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 0/5] serial: add drivers for the ESP32xx serial devices
Date:   Thu, 28 Sep 2023 08:16:26 -0700
Message-Id: <20230928151631.149333-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds drivers for the UART and ACM controllers found in the
Espressif ESP32 and ESP32S3 SoCs.

Changes v3->v4:
- address review comments, listed in each patch
- add reviewed-by tags

Changes v2->v3:
- address review comments, listed in each patch

Changes v1->v2:
- address review comments, listed in each patch
- add cleanup for the uart_get_baud_rate function

Max Filippov (5):
  serial: core: tidy invalid baudrate handling in uart_get_baud_rate
  dt-bindings: serial: document esp32-uart
  drivers/tty/serial: add driver for the ESP32 UART
  dt-bindings: serial: document esp32s3-acm
  drivers/tty/serial: add ESP32S3 ACM device driver

 .../bindings/serial/esp,esp32-acm.yaml        |  42 +
 .../bindings/serial/esp,esp32-uart.yaml       |  51 ++
 drivers/tty/serial/Kconfig                    |  27 +
 drivers/tty/serial/Makefile                   |   2 +
 drivers/tty/serial/esp32_acm.c                | 459 +++++++++++
 drivers/tty/serial/esp32_uart.c               | 741 ++++++++++++++++++
 drivers/tty/serial/serial_core.c              |   4 +-
 include/uapi/linux/serial_core.h              |   6 +
 8 files changed, 1329 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
 create mode 100644 drivers/tty/serial/esp32_acm.c
 create mode 100644 drivers/tty/serial/esp32_uart.c

-- 
2.30.2

