Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691AF7BF6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjJJI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjJJI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:59:43 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874AAC9;
        Tue, 10 Oct 2023 01:59:37 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57e40f0189aso3024620eaf.1;
        Tue, 10 Oct 2023 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696928376; x=1697533176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pS+UJr8Jh15KatUL4iYKP+zcuvxoJTxMHrLEZJKpOkQ=;
        b=K6WXj1ng7dqb4t7qocVL0+fTyUi5sf0+i9pYXXJW+/jCsfNmi1MruTcIMer1mITYPd
         EZHE8bm/jr2lI0qtQwyinoZMpu8yJDbD1WHQbIHJZJlzif9iuCGAYFFor8d8Z8b4RCc0
         hzGu6QywhKQZdqD+q7aIQ+3Y1vly3BOKYtXd/TiK8dHsivFlc8y3dJvd9kdxNL4p/fWE
         Agyswh3pw3L0FeTCDjyYxUMaX/dfzbP2Vz/7w7dqkpzuICp7W0/fxqVHrHb63zw0VQtD
         Rn//WSfYMdTAezupBvQgMREp4JHalJyl8naeqBPGwO4trh1IhCKRXlb6+Za/ZJwPlTzJ
         QtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928376; x=1697533176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS+UJr8Jh15KatUL4iYKP+zcuvxoJTxMHrLEZJKpOkQ=;
        b=pHQXsoaCGDbMTdTFG4CeH738SGI7gUgiE7OhUyKHoCK5/k4W1XtDPc0Z5LxtPOdgNY
         xDdnnsOym543ncQeuKAtklQr0uRCKNCutKdFQ1Ja6B01U4lBi/oAR/1Ggrikh7Yj3Ixc
         63O/S+85MYiQ1kFrYWDOOP1ndrGelczA1XrCU1FjR3edDf+lu5OiyrnQuCqNK7hFnlHH
         4WQS+1CvI1WuETRKumlNWspSbE/pNMjOJvEciRU2pr+dNTtyds+sQA4t2oMuUeXha+ph
         21esdsoBzDOP5kVp4TFMHeHDcgrroctXgLdzByrotmiavzB95tUEGSyujbui+Qs7Og9U
         Y7+A==
X-Gm-Message-State: AOJu0YwrUpLkT8UduDuVZBbYvnaR6MvDJtibRaUU39bJydWB5KqkBeVX
        NB4mLjX2mqqULlfeEJxx/JxTSrgQlmo=
X-Google-Smtp-Source: AGHT+IF3sj3BBK+nNQSLTnJbqNTU5PhRmbwDlbOXg4G8Le+kHH5TPWVZUzX0CmM/472bq9qgPYlXoA==
X-Received: by 2002:a05:6358:94a0:b0:141:162:b0cd with SMTP id i32-20020a05635894a000b001410162b0cdmr20061777rwb.19.1696928376389;
        Tue, 10 Oct 2023 01:59:36 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:f462:7ab2:1aaa:db73])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a3d4c00b0027782f611d1sm12542731pjf.36.2023.10.10.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:59:36 -0700 (PDT)
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
Subject: [PATCH v5 0/5] serial: add drivers for the ESP32xx serial devices
Date:   Tue, 10 Oct 2023 01:59:21 -0700
Message-Id: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds drivers for the UART and ACM gadget controllers found
in the Espressif ESP32 and ESP32S3 SoCs.

Changes v4->v5:
- address review comments, listed in each patch
- rebase on top of change introducing PORT_GENERIC

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
  drivers/tty/serial: add ESP32S3 ACM gadget driver

 .../bindings/serial/esp,esp32-acm.yaml        |  42 +
 .../bindings/serial/esp,esp32-uart.yaml       |  51 ++
 drivers/tty/serial/Kconfig                    |  26 +
 drivers/tty/serial/Makefile                   |   2 +
 drivers/tty/serial/esp32_acm.c                | 459 +++++++++++
 drivers/tty/serial/esp32_uart.c               | 741 ++++++++++++++++++
 drivers/tty/serial/serial_core.c              |   4 +-
 7 files changed, 1322 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
 create mode 100644 drivers/tty/serial/esp32_acm.c
 create mode 100644 drivers/tty/serial/esp32_uart.c

-- 
2.30.2

