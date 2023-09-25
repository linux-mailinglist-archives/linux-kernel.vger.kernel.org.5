Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278217AD3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjIYItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjIYIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:48:53 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CCAB;
        Mon, 25 Sep 2023 01:48:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3aca1543608so3972595b6e.0;
        Mon, 25 Sep 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695631726; x=1696236526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPJ+3v8IOYRN+sZVaPmkV2aQfR1DvyQl9AclCfckmVw=;
        b=d1GFOBp0JrI664v9zquznNWKxNr7dNMlUoHJS9Yf7AsxVdPyX2MUqOjGQ55yBA32mj
         0eib3bYTUtbI0zaNmEqfMiMrliKhxdREJRnAnpGmm5hiosJ0vMD81oEvb0PqqZdJqGRD
         G5rhjHrGTvT4AOhbCWyR5RtOnAtYNR4kixUL7fzx78tC9/Ul3pYnM3tt0u/g5WdhIbw/
         yjf0ceodNi7aw0792qoc2GyN0NLiLHEqkEEpO7mdd9bqQPIvy2tBr8djdQVrV9Rv3Ac+
         6fHSLiiN/12rhfMLbJ3uL19GQ+MoMVruhUMNVWRh7+LxvZLZTFlQZwH9r/x+c4q6O1te
         9l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631726; x=1696236526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPJ+3v8IOYRN+sZVaPmkV2aQfR1DvyQl9AclCfckmVw=;
        b=S8rzhb8WMIU16bPBrYze2JUkJdkWL3Kj4EI0BObVhUoR2U1S+TFxUl+u0hLuvX9hi5
         4AYx8Z+kp4iznMaMT/H46LiE1TtbL7XwjbCDey1unmGPPL3VR+Mxcqf3yduXBBLFh38S
         bUfw0s4tPPXOkXEc9sMIvYgm3n7t8YtBeLQKvykO2NrkBy+QKfEnBtUWPEa8cG9RvbNM
         hDBurngyjutSMX5xD1hi4UkyAr8I/n6Ru9P+eSoNaui1w99b1gzVLbPxlRLDWEwhaI8F
         FPiW7CypqVxJgu+r/fClLGHy59ioS0nxNPkIGK7ivQF4EMs+FD0AA1uNBrZAvbUF0X4H
         19IQ==
X-Gm-Message-State: AOJu0YxSr+ZGP8oBQzBQbRfZfEb7BCCgLrUTgXe1X3AEg9IXUW5UA+hN
        Hr6GQeg+Lja+VCqbAFR6yQgzxzHMz+Q=
X-Google-Smtp-Source: AGHT+IHh9hH6MoxKgalPFqOg/TE46W4aOCGn+Ge6yIDFMiehR1QC4s+gbJDY1rbjW2Ih3A35e/hrIQ==
X-Received: by 2002:a05:6808:14a:b0:3ae:17af:7387 with SMTP id h10-20020a056808014a00b003ae17af7387mr8222096oie.43.1695631725786;
        Mon, 25 Sep 2023 01:48:45 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:bc97:e554:1bd8:be33])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b0055c178a8df1sm7406376pgd.94.2023.09.25.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:48:45 -0700 (PDT)
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
Subject: [PATCH v3 0/5] serial: add drivers for the ESP32xx serial devices
Date:   Mon, 25 Sep 2023 01:48:20 -0700
Message-Id: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
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
 drivers/tty/serial/serial_core.c              |   5 +-
 include/uapi/linux/serial_core.h              |   6 +
 8 files changed, 1330 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
 create mode 100644 drivers/tty/serial/esp32_acm.c
 create mode 100644 drivers/tty/serial/esp32_uart.c

-- 
2.30.2

