Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D707A7051
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjITC1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITC1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:27:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA866C5;
        Tue, 19 Sep 2023 19:26:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so865133b3a.0;
        Tue, 19 Sep 2023 19:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176819; x=1695781619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TeNOz0+PeBM7BS0zrNE2nATuP8C0d/z2oGULXDhCZQ=;
        b=BqFKLBpvLiycvX+dyOV+UzlLac0xVAzO8/Hqt9ICNk16lziniDUXae6X6Hn0oASf3W
         +bbwFhAsDbwiOYeigDKKFiRWXBEEnOHYEqd2m+ifyEBVJqY1CQ7sfKdSfFQW2WtKtaZv
         acn+VpfNZYXoAOfv27S7q4Ym6XwWxOOs62ZkWZdG2NI/6fyXB1PXUYBP9pkJ6HWjhejZ
         tszmsHWbKDD/UMLsjhDVyBIRcgJejI33VwPJbrOLjvhZXR+ojeM5gDzXKiY59+lTgLro
         Fj4U7MKYx5CIq6XJmRuIyDHcyj2OPIHGUIBZAx1ONgoHjm7YAWP+VL7KSypeRpeh3Q2L
         V/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176819; x=1695781619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TeNOz0+PeBM7BS0zrNE2nATuP8C0d/z2oGULXDhCZQ=;
        b=oB5C6hz36XXf2RgO5jTDcY/M/UsUKGSXxNrB4GyZ0iWt/ew6OaqJqXkGzWX8x9bZDk
         1uA3rBp6VrwEZDOgjBI1K0ViZqCuOVyNgywxTokoi4TtJp40s+wb7OjCaFNQ5+Q2Jzrz
         PFTeA7ZJSTGowG4b7K4yW7eZjbBbeA8DYHecsCI1quXdL7iAnOHNzpgQrsBfTRqq9gtZ
         YrUWkejwdA/uczrVvqqYCro3+SHMLlDpTVZgt9J+bpIGDpubnQNo2OrZe/qonFX4pKlE
         8BN3VpJJj5pgwhlPwlo5hGTIRL1UlSb5lVk+co9AmM36aYyuK+/5PX/6Dd8gHAaUULEM
         Al9w==
X-Gm-Message-State: AOJu0YxeEEv6FGkr2IIszyVyy+UOtQgW90HgguuqlrqXcYtIDQNU7sDU
        P2xCTkCGsS7mu46pXzZ3O1ioyq5OyUg=
X-Google-Smtp-Source: AGHT+IGBXJfd4cgxjFnjRb5i6arxZ4iVWAZIY64RPJk1KFlERIjGyhc8lXcthOwLN9wlP0Ha2b8rzw==
X-Received: by 2002:a05:6a00:21cc:b0:68b:bf33:2957 with SMTP id t12-20020a056a0021cc00b0068bbf332957mr1583146pfj.22.1695176818903;
        Tue, 19 Sep 2023 19:26:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9ca3:318f:421e:68cb])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b0067aea93af40sm9224757pff.2.2023.09.19.19.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:26:57 -0700 (PDT)
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
Subject: [PATCH v2 0/5] serial: add drivers for the ESP32xx serial devices
Date:   Tue, 19 Sep 2023 19:26:39 -0700
Message-Id: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
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

Changes v1->v2:
- address review comments, listed in each patch
- add cleanup for the uart_get_baud_rate function

Max Filippov (5):
  serial: core: tidy invalid baudrate handling in uart_get_baud_rate
  dt-bindings: serial: document esp32-uart
  drivers/tty/serial: add driver for the ESP32 UART
  dt-bindings: serial: document esp32s3-acm
  drivers/tty/serial: add ESP32S3 ACM device driver

 .../bindings/serial/esp,esp32-acm.yaml        |  39 +
 .../bindings/serial/esp,esp32-uart.yaml       |  48 ++
 drivers/tty/serial/Kconfig                    |  27 +
 drivers/tty/serial/Makefile                   |   2 +
 drivers/tty/serial/esp32_acm.c                | 458 +++++++++++
 drivers/tty/serial/esp32_uart.c               | 749 ++++++++++++++++++
 drivers/tty/serial/serial_core.c              |   5 +-
 include/uapi/linux/serial_core.h              |   6 +
 8 files changed, 1331 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
 create mode 100644 drivers/tty/serial/esp32_acm.c
 create mode 100644 drivers/tty/serial/esp32_uart.c

-- 
2.30.2

