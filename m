Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57E7B2B49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjI2Fj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjI2FjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:39:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC921AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1826905366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965959; x=1696570759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ5ltUZdRq/zpSgjEvQ5Nn9MPK9gRZTRXdEHWtkmrGY=;
        b=FlFMJ64xCehFzCSX78nGo8c8zhIAyECyEsK+CQA8965wUEKi5yHWKa2OTdmisnfLZH
         w6JVJPBixeL28znQM3iMeVKRSWpEGHcki24G2ri0KYooFMUr7Gpl20V3Q2cJdtQ+Bmtl
         GiOzU4hxzb2lB5ONZTg1j9zGYkhdVn5nPjxbkz0EAKE9ZEjOmHnmLTNvmwv7p6jei93e
         D/RDu3YcaNny6nsXOU0S9lIW+tz8oEClFNYXLbPCaK+bqCKRhowsG+u+tO29FlfY3YHa
         AUaNg9WgyAWwrXAzHlIb3EtUcH7xBFZCLF4p4ZQW1LAeJ/bSX3Mroehu6Wmh8gr8IZOt
         zIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965959; x=1696570759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ5ltUZdRq/zpSgjEvQ5Nn9MPK9gRZTRXdEHWtkmrGY=;
        b=YKJV0RKrxHRKGEnCjCfdaNUFr9+NcnTyzeRF3WEGBE4z6VHPy/7FBF1CjdlMzXzqty
         +YS6B6e1i0hdKl67SwuChZ/k6gx3LeBv4g5Dj7HklsfaDmchziGdddIrlHgIp4+6QczP
         PzyuRuQwpmohZkDbjfpsWpX+RyxOgXxFTSUCFahQmOWuiWdu36ZyW4K2CECG17hNRh1Q
         Ltia9T4ZLStdHOLcHxTEdYH8rONvjD3Rt1h4KfSR95e44gb+l/r3FwZa87jQOatW5zBA
         pKczpbsEWbRuQJQ7FczbUMwIs9ek364F/i6bgyITbDUDeQGGaopNqhtFdP+CDNFQn4RF
         EN1Q==
X-Gm-Message-State: AOJu0Yx7Hyx+mzPONW+ePg8XbS8sZjrALOUOKhFzcRzMJJkPpqJ+w8vK
        MCUImTcm6Aa0PxHemyfQEKMqVw==
X-Google-Smtp-Source: AGHT+IFs1wtp/YcwJb7GfOCLwGjYtFOwNujKRuwlhMXrwiRQ2KA6NJFyO2UtmJ1jRYeZXgWwQfejdQ==
X-Received: by 2002:a17:906:57c7:b0:9ad:e2c8:1741 with SMTP id u7-20020a17090657c700b009ade2c81741mr3186997ejr.58.1695965959245;
        Thu, 28 Sep 2023 22:39:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:18 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/28] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
Date:   Fri, 29 Sep 2023 08:38:47 +0300
Message-Id: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This patch series adds initial support for The Renesas RZ/G3S (R9A08G045{S33})
SoC. The RZ/G3S device is a general-purpose microprocessor with a
single-core Arm® Cortex®-A55 (1.1GHz) and a dual-core Arm® Cortex®-M33 (250MHz),
perfect for an IOT gateway controller.

This includes:
- SoC identification;
- clocks (core clocks, pin controller clock, serial interface, SD ch0
  clock) and corresponding resets;
- minimal device tree for SoM and carrier boards.

With this series Linux can boot from eMMC or SD card. The eMMC and uSD
interface are multiplexed on the SoM; selection is made using a hardware
switch.

Patches are gouped as follows:
- 01    documents scif support;
- 02-05	contain fixes on clock drivers identified while adding RZ/G3S
	support
- 06	clock cleanups identifies while adding support for RZ/G3S
- 07-13	clock changes needed by RZ/G3S
- 14-21	pinctrl changes needed by RZ/G3S
- 22-28 device tree support for RZ/G3S

Changes in v2:
- addressed review comments
- collected tags
- removed from series patches that were already integrated
- added patches:
	- [PATCH v2 19/28] dt-bindings: pinctrl: renesas: set additionalProperties: false
	- [PATCH v2 23/28] dt-bindings: arm: renesas: document RZ/G3S SMARC SoM
	- [PATCH v2 26/28] dt-bindings: arm: renesas: document SMARC Carrier-II EVK
- please see individual patches for detailed changes

Claudiu Beznea (28):
  dt-bindings: serial: renesas,scif: document r9a08g045 support
  clk: renesas: rzg2l: wait for status bit of SD mux before continuing
  clk: renesas: rzg2l: lock around writes to mux register
  clk: renesas: rzg2l: trust value returned by hardware
  clk: renesas: rzg2l: fix computation formula
  clk: renesas: rzg2l: remove critical area
  clk: renesas: rzg2l: add support for RZ/G3S PLL
  clk: renesas: rzg2l: add struct clk_hw_data
  clk: renesas: rzg2l: remove CPG_SDHI_DSEL from generic header
  clk: renesas: rzg2l: refactor sd mux driver
  clk: renesas: rzg2l: add a divider clock for RZ/G3S
  dt-bindings: clock: renesas,rzg2l-cpg: document RZ/G3S SoC
  clk: renesas: add minimal boot support for RZ/G3S SoC
  pinctrl: renesas: rzg2l: index all registers based on port offset
  pinctrl: renesas: rzg2l: adapt for different SD/PWPR register offsets
  pinctrl: renesas: rzg2l: adapt function number for RZ/G3S
  pinctrl: renesas: rzg2l: move ds and oi to SoC specific configuration
  pinctrl: renesas: rzg2l: add support for different ds values on
    different groups
  dt-bindings: pinctrl: renesas: set additionalProperties: false
  dt-bindings: pinctrl: renesas: document RZ/G3S SoC
  pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
  arm64: dts: renesas: add initial DTSI for RZ/G3S SoC
  dt-bindings: arm: renesas: document RZ/G3S SMARC SoM
  arm64: dts: renesas: rzg3l-smarc-som: add initial support for RZ/G3S
    SMARC SoM
  arm64: dts: renesas: rzg3s-smarc: add initial device tree for RZ SMARC
    Carrier-II Board
  dt-bindings: arm: renesas: document SMARC Carrier-II EVK
  arm64: dts: renesas: r9a08g045s33-smarc: add initial device tree for
    RZ/G3S SMARC EVK board
  arm64: defconfig: enable RZ/G3S (R9A08G045) SoC

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   1 +
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  23 +-
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../bindings/soc/renesas/renesas.yaml         |  13 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 139 ++++
 .../boot/dts/renesas/r9a08g045s33-smarc.dts   |  17 +
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |  14 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 142 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  28 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |  19 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |  19 +-
 drivers/clk/renesas/r9a08g045-cpg.c           | 213 ++++++
 drivers/clk/renesas/rzg2l-cpg.c               | 478 ++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h               |  33 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 705 ++++++++++++++----
 include/dt-bindings/clock/r9a08g045-cpg.h     | 242 ++++++
 20 files changed, 1860 insertions(+), 238 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

-- 
2.39.2

