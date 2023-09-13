Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EEF79F38B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjIMVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjIMVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:15:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D8D1724;
        Wed, 13 Sep 2023 14:15:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c328b53aeaso1848075ad.2;
        Wed, 13 Sep 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694639710; x=1695244510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gsH9bk643G8YxEeFoePkpJ9hzS+Ib/AEJLLU+UFoGDw=;
        b=K1LxRNZjIQ01N0iwkNGyXJeoGw5bvBiNEnhjGzNrA83q5THrZFeml2+BkiFN2O7WdJ
         HS6gZ9P/ySr7nremXIpRZm/4ekJbTohXYCVVawXNe2HiOco43kFp6ERuLoMaG5DBe7XG
         U35aydFsMgOfvEP+A8qqufBHW38NxuhVl3CkRFRoT7BO6OuMTU5aDV+wcFkncOcmSF6t
         Vv3fQfkLYM1LVXaiVtjm4Ct4sfURtR+W4dNWZzosXTDXeSFO283ABu/kRyq4+8AXIrgJ
         jps9EYH9bfcAh8tJltWzTaHLqvCMJaS4nYpMtYSiI+fRvhZP32t0p6TcvtheE6P4N2SM
         2JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639710; x=1695244510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsH9bk643G8YxEeFoePkpJ9hzS+Ib/AEJLLU+UFoGDw=;
        b=ipAWHJiK3eBzns8+gAORJKmMCB7S2zOA6uCwVhXFBQI3pxGNsWqpGs1slgXC9QE4jl
         BQbhCBlDElaJwLJhJhi/r37bMcR13h3EncY7sYXyLXINdZOEtzTJerI14/Vm4Tbvde0k
         DzxrxLbQF6wQQDrCACOJM1DK+As6e/gz92zex06HAw08XvlNMNrqwM9O+8+iYv/KtnfL
         QJGJow2n7kPbb6FenQm1EpUc1HBDSJtPG73EeCXMZH3vNaqMQy6ot01gfn0C6MzmYyA1
         zXeaGXn+Ca/SOIeL47GT3N2tvEXr64+FqYB7qNz8k67UwcsHIpAWututflF4IsC4RSah
         ekIA==
X-Gm-Message-State: AOJu0Ywvu5kbjfx3nzKZn2XDfIIVSOJYqnNYjyN9j2otccPoOc+byTw4
        m1w9pUZnYanomVPgAVolAq/Bfeopln4=
X-Google-Smtp-Source: AGHT+IEIupr6NAa7G30GxOa8cO59axP5WsOD+kiUhzFjXiNF2v+iCkBxfqLYApAwXFJoDlyUJ+LrwA==
X-Received: by 2002:a17:902:ecc5:b0:1c3:7628:fcbb with SMTP id a5-20020a170902ecc500b001c37628fcbbmr4876872plh.43.1694639709665;
        Wed, 13 Sep 2023 14:15:09 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:82b1:d7c2:2eaf:61e7])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b8c689060dsm73707plh.28.2023.09.13.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:15:09 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/4] serial: add drivers for the ESP32xx serial devices
Date:   Wed, 13 Sep 2023 14:14:45 -0700
Message-Id: <20230913211449.668796-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds drivers for the UART and ACM controllers found in the
Espressif ESP32 and ESP32S3 SoCs.

Max Filippov (4):
  dt-bindings: serial: document esp32-uart bindings
  drivers/tty/serial: add driver for the ESP32 UART
  dt-bindings: serial: document esp32s3-acm bindings
  drivers/tty/serial: add ESP32S3 ACM device driver

 .../bindings/serial/esp,esp32-acm.yaml        |  40 +
 .../bindings/serial/esp,esp32-uart.yaml       |  48 ++
 drivers/tty/serial/Kconfig                    |  27 +
 drivers/tty/serial/Makefile                   |   2 +
 drivers/tty/serial/esp32_acm.c                | 473 +++++++++++
 drivers/tty/serial/esp32_uart.c               | 766 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   6 +
 7 files changed, 1362 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
 create mode 100644 drivers/tty/serial/esp32_acm.c
 create mode 100644 drivers/tty/serial/esp32_uart.c

-- 
2.30.2

