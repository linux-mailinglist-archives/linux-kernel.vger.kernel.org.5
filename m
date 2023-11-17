Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C507EF83D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjKQUN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQUN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:13:56 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA817D6C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:51 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b3f6dd612cso1431542b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252031; x=1700856831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhumf+S/1zmUfncIex+xhepA+T9wIMv2vyztW6+G6BA=;
        b=lsqWx7hmnb2o+hQ6cvbPdIkA/XMtr4wg7c8GrbwyNDrm/DgKj/o//s90fnhi++6Jxj
         znF1XWc+e7ooIFcybvXIkUObb7zB5oPDOx5Zc8c0fcGXKL5spQ+FSqt3Ily4wVyE3gh2
         0toW1bZPjSsHFkvfA1mEU+DOAvbUX1jvJUDUhp17PsPFv+VxCuYehVTusVJejhljbbLg
         xouR8VXVlRcsMOH+odeR6T/gwPjHnXVDKdfwhn3MGIf+fDMjxTgApoo2iwwbNHADb9SE
         wf26BdcW/VcqvbIU/g8j1HLvYh5oqbq7cRQDtZCJGO1jqtBijQ4WyEnp1lG4p97d7yXP
         7Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252031; x=1700856831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhumf+S/1zmUfncIex+xhepA+T9wIMv2vyztW6+G6BA=;
        b=tHwSwmAgFGlW9qrwuEW78TbjTyN6gAaBRSStsJ28j+GW/yW2lgwUN3Jxsb83ss+CiM
         H+J0wJE4qHN0C2mYWyxA1fL803sXQuIYajShi89Ag9Xjn3wfK4thPmk1cYzp7DsHaw4z
         Cis8AXoX0HQZxfAZR0eOX6gc/8wpErTsxxXrtwlsmOyyZATHpgGIi4eqjYytsjVYVsxA
         SWsn8xW8umhS0Hk9RVvsrWvXMUFMjRKVHeGOZRAWnRlaxXAJQX5Ay5DVLuuCrGaU9nux
         GrhNpVNwgPfliqn+WFNOm/optTzWbrY3NqKY/FA/vrmnpjmL/EVq4d1uS4YC6wJdTyQY
         rQow==
X-Gm-Message-State: AOJu0YxhOXdO+Tjgb7SXtFy4HwFka4ud690QHVooBj9oMGRK8JtPVoCQ
        K4NWHrrH40ASSKpb2lkWUFk9/w==
X-Google-Smtp-Source: AGHT+IGWJBiZ9GKDWx65XkxF5PxgPchzalM6vQQqXfeWw6zoM9oBeieyq2RA7kcI1qGBrs/oSdE4iQ==
X-Received: by 2002:a05:6808:19a2:b0:3ab:870d:2d49 with SMTP id bj34-20020a05680819a200b003ab870d2d49mr584414oib.8.1700252031144;
        Fri, 17 Nov 2023 12:13:51 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:50 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] spi: axi-spi-engine improvements
Date:   Fri, 17 Nov 2023 14:12:51 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are working towards adding support for the offload feature[1] of the
AXI SPI Engine IP core. Before we can do that, we want to make some
general fixes and improvements to the driver. In order to avoid a giant
series with 35+ patches, we are splitting this up into a few smaller
series.

This first series mostly doing some housekeeping:
* Convert device tree bindings to yaml.
* Add a MAINTAINERS entry.
* Clean up probe and remove using devm.
* Separate message state from driver state.
* Add support for cs_off and variable word size.

Once this series is applied, we will follow up with a second series of
general improvements, and then finally a 3rd series that implements the
offload support. The offload support will also involve the IIO
subsystem (a new IIO driver will depend on the new SPI offload feature),
so I'm mentioning this now in case we want to do anything ahead of time
to prepare for that (e.g. putting all of these changes on a separate
branch).

[1]: https://wiki.analog.com/resources/fpga/peripherals/spi_engine/offload

---
David Lechner (14):
      dt-bindings: spi: axi-spi-engine: convert to yaml
      MAINTAINERS: add entry for AXI SPI Engine
      spi: axi-spi-engine: simplify driver data allocation
      spi: axi-spi-engine: use devm_spi_alloc_host()
      spi: axi-spi-engine: use devm action to reset hw on remove
      spi: axi-spi-engine: use devm_request_irq()
      spi: axi-spi-engine: use devm_spi_register_controller()
      spi: axi-spi-engine: check for valid clock rate
      spi: axi-spi-engine: move msg state to new struct
      spi: axi-spi-engine: use message_prepare/unprepare
      spi: axi-spi-engine: remove completed_id from driver state
      spi: axi-spi-engine: remove struct spi_engine::msg
      spi: axi-spi-engine: add support for cs_off
      spi: axi-spi-engine: add support for any word size

 .../devicetree/bindings/spi/adi,axi-spi-engine.txt |  31 --
 .../bindings/spi/adi,axi-spi-engine.yaml           |  66 ++++
 MAINTAINERS                                        |  10 +
 drivers/spi/spi-axi-spi-engine.c                   | 399 +++++++++++++--------
 4 files changed, 329 insertions(+), 177 deletions(-)
---
base-commit: 6f9da18171889fae105e1413a825c53fa5aab40c
change-id: 20231117-axi-spi-engine-series-1-7c76311440f9
