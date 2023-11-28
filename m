Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39D7FB1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjK1GLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjK1GLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:11:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E3EC4;
        Mon, 27 Nov 2023 22:11:24 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cd97c135e8so1229332b3a.0;
        Mon, 27 Nov 2023 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701151884; x=1701756684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5W5LkCBhH5FAS1jATODbsmfalZ7+kdMimPXWoxa9EQ=;
        b=Qu1Pp+FXvcQWp5QYD6fV7Uhk1DW3WE9188A52/99YxyZNR7w/V90w3FI+HBAFzh65H
         TlWigLgxYkKfC3KvDtDRwUNAsWjB/UCb1jGfZr9ReQD7aZhjN2tmFahyna3O54YZPpa3
         j3ktfBvVujOLoDnzGDtGbANV2WBS79w+1Wtd/yjE3RtAQdZ9/5UIQGxi9YACLmk4ysuU
         F9mhK//AAVoMb6/lnn+aqn5OVwWOQ+xI3ujTsJ7JaaA/etD6pu6LnPLEYML7K/mFp5pu
         wRH8sct4M0/baWG9r+X+Z52NlJFd4/X6F4u1zwNk5qO0L5nk+o+iRy4/WRqKLHUcR+zC
         uAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701151884; x=1701756684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5W5LkCBhH5FAS1jATODbsmfalZ7+kdMimPXWoxa9EQ=;
        b=n0WKPWzyIWzguwLi7mvaeb66TATYxt4z7WojFvFgL0g/WEIMSExLLS+OGn9Jg0Z+2Y
         bpvN9f879ptj6W3D5Ttp1+51P+Qy0sGNq3EhNyC7PnWWPXcu9b2JX8a09v1uINkUmnzk
         HNcg4tOPN0FtZQPC9X6xxw5h4Fffi2A0cl73lrHo4D6RVob6QyYzJq/S6anrGtspwJLa
         96sJ+ZOBrAJxQspJf0a5VzmgEZgcvF5R086bhf8yEticU7/dcZuLqt0/0jxW5MJ0dlo4
         Uv1xR6c0ZjJ+JcQ6C0AdVTRapxzrQWjRt1OQrphYlBfOLz65YB20StOscAQIIGOXSsBy
         WISQ==
X-Gm-Message-State: AOJu0YwhoTwYULW57uOLf8Cz0ySBQzF47wrVQrqh9N+2S9iQPGm17S/z
        095auG9K9LXWnoDfOoc5rqk=
X-Google-Smtp-Source: AGHT+IHlFbaobrz+1OcrIeW466cpBxRQKq4iOTPU9K0wUEM7utEJrFl4DVEsvHXKV0aaNylqZGV8ow==
X-Received: by 2002:a05:6a20:258b:b0:18c:64e0:447b with SMTP id k11-20020a056a20258b00b0018c64e0447bmr10036183pzd.28.1701151884056;
        Mon, 27 Nov 2023 22:11:24 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001c73f3a9b7fsm9402694plb.185.2023.11.27.22.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:11:22 -0800 (PST)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Subject: [PATCH v2 0/4] Add support for nuvoton ma35d1 pin control
Date:   Tue, 28 Nov 2023 06:11:14 +0000
Message-Id: <20231128061118.575847-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This patch series adds the pin control and GPIO driver for the nuvoton ma35d1
ARMv8 SoC. It includes DT binding documentation, the ma35d1 pin control driver,
and device tree updates.

This pin control driver has been tested on the ma35d1 som board with Linux 6.7.

v2:
  - Update nuvoton,ma35d1-pinctrl.yaml
    - Update the 'nuvoton,pins' to follow the style of rockchip pinctrl approch.
    - Use power-source to indicate the pin voltage selection which follow the
      realtek pinctrl approch.
    - Instead of integer, use drive-strength-microamp to specify the real driving
      strength capability of IO pins.
  - Update ma35d1 pinctrl driver
    - Add I/O drive strength lookup table for translating device tree setting
      into control register.
  - Remove ma35d1-pinfunc.h which is unused after update definition of 'nuvoton,pins'.

Jacky Huang (4):
  dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management
    node
  dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
  arm64: dts: nuvoton: Add pinctrl support for ma35d1
  pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver

 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       |  189 ++
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |    3 +-
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |   70 +-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |   73 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  159 +-
 drivers/pinctrl/nuvoton/Kconfig               |   22 +
 drivers/pinctrl/nuvoton/Makefile              |    2 +
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        | 1244 ++++++++++++
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   50 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 10 files changed, 3599 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

-- 
2.34.1

