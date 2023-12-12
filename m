Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0180E47C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjLLGwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLGwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:52:11 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2BECF;
        Mon, 11 Dec 2023 22:52:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso3297250b3a.2;
        Mon, 11 Dec 2023 22:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702363933; x=1702968733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTf2cuqewiPrk1RQQoqt4/IkxJXXPXtDeMWQFMEZ4Hw=;
        b=BciUfiVAH1RYlbWfBBlo9EoUX6YqvMl3OI0Eu+YkOkg56k2tWlk2JKQF4qT2JGIA8J
         SZGLPnkhgBDKh9yJw4vlVUSoH/j4vtBHNxl6EcrTBz9nFEApHEbx3an3XvAgI27VapRx
         ePymwYN6OQSrHkBfciFT2nFDk9hikTid/824bsEReTHOMkrqXCdRVh6+b6ZG8BL0eHJa
         AxWDRtRf3hzsAY9eEk3v7c4jdO1wlDSLXwplMaemUs3b136/WjpVsijoqZQ+6PkR//x4
         7XmXW3peD4DX2IZ3InvmJYrv/pIYbBLg6N9kuXM/i2cjlrLQdgdRkduPJX0R8Xed0jRx
         hfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702363933; x=1702968733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTf2cuqewiPrk1RQQoqt4/IkxJXXPXtDeMWQFMEZ4Hw=;
        b=kR8LZaiIiM/3oi5RwoHsd7qxyvzKe2/LZr5X6NX+5I6F60c5i00l/o5X1c4jkLqCHT
         QdrIFqHUleIe/+q7ExPkY6wK6zXXeCx0frBbiTYTysfZ1+c9GvrNvRkG0W0W9hYDj25Z
         pSz5oNMXAgJBCnufWi7ra66U8qU/FJDz9FigZ1JZt7TADfuRDoXNx/wv0pT1uFugMQfk
         lRiGdgVqOAD1oZ3FgYnEiU8wgvN0o+M8saeKVhJaUYzoFQ6IRl3YR40mHKOvBi9ClIKJ
         OnAK6jZEno8tRS8oZhZDH3gKcVXWTlLlpXBbpRmIZwqz8th5yyF0ukmo886I9ktSF874
         fvzg==
X-Gm-Message-State: AOJu0Yz9sdcbzOoNV86hs0eoc1/0gQulFkfCt6cH8ZiwiH2rPV+K8Oiv
        KWWpCLis4W59CdiIlVRmIIk=
X-Google-Smtp-Source: AGHT+IH7Lpx23pIFrf41IMWWQR20J3LQ8P14JiziXUXV88Cyrk6LtlNKTDlumeVyZW/StlZIysKFjQ==
X-Received: by 2002:a05:6a21:999d:b0:18f:fb0d:e961 with SMTP id ve29-20020a056a21999d00b0018ffb0de961mr3104973pzb.60.1702363932793;
        Mon, 11 Dec 2023 22:52:12 -0800 (PST)
Received: from localhost.localdomain ([1.200.151.130])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001d0c4869725sm7855221plg.97.2023.12.11.22.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:52:12 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
To:     jim.t90615@gmail.com, JJLIU0@nuvoton.com, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v9 0/3] Add Nuvoton NPCM SGPIO feature
Date:   Tue, 12 Dec 2023 14:51:44 +0800
Message-Id: <20231212065147.3475413-1-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
NPCM7xx/NPCM8xx have two sgpio module each module can support up
to 64 output pins,and up to 64 input pin, the pin is only for GPI or GPO.
GPIO pins have sequential, First half is GPO and second half is GPI.

Jim Liu (3):
  dt-bindings: gpio: add NPCM sgpio driver bindings
  arm: dts: nuvoton: npcm: Add sgpio feature
  gpio: nuvoton: Add Nuvoton NPCM sgpio driver

 .../bindings/gpio/nuvoton,sgpio.yaml          |  86 +++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |  24 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 635 ++++++++++++++++++
 5 files changed, 753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.25.1

