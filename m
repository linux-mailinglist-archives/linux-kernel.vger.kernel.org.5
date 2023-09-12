Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E779C4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjILEwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjILEwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:52:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CBFCDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so6199726a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494336; x=1695099136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL8AUPRM1aegmrc4Jg4uOM+4oALiCtGLkJY+J8Syis0=;
        b=A22sv3d3DNDHoX7QPOiJI2uQWPQ2CkA+q3mvysmXlMBDsp6Ny+bDNpRUP29JrFlqfE
         yf2GJTuj5Aiz5MEjr4tzU+k2Omnamfom57uPsg+sDqTiVIQJ8prQuJAO96UOdH6QPHIR
         rT0bLAfezPTJVTz7f+Lph9M+HpiMvhlcWiBIdKWXQrDF3frkqJjmOds7Sr5jTAhtDA+Q
         cQs4rdtUBhQMUi2yAckKQbFusUDF3Y1usdyNj9Plr/iRzGi6a4JAtvRnK1HB18Owud1U
         i1SxYMF9GgrBIEVhbgBalE6O6H2AEaGCxqh+68fEXj5nddk0Fi81oDx2tBnLNGvjmmap
         +B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494336; x=1695099136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZL8AUPRM1aegmrc4Jg4uOM+4oALiCtGLkJY+J8Syis0=;
        b=nYLT6rS1W5EE5NYay7sBpGLwHvseAZ4j4BlJfVahf2BpBX/jPXftxxCCLKxXNqTGDV
         bV+OItMoNUHsTaRHyqDugjwNRl6OT409Tv81o6jQnluC2blipqarZNBPyQuv+5HpDM/l
         58pPaVntI03g6ZOy77JD3v7KUkDiF/KwTNlhIX2nlAQMSjJ/Edp0HTQ+MVA0aUeDsVIC
         rWmYq9Ns7lSdBTWQI5X1I4Mfq61HeEDrK+eT4fw0uqIj5GTNE7+oaVFclDm8C2ACECML
         jBEEs+kagz7M6HffdNyjgpBTnMl49p9FMqOWmDG4lCflx0YP4kHkHZ/1bOC47t8Y8/HM
         qFkw==
X-Gm-Message-State: AOJu0YyWJDFewKNlh4Y7ZIQoA2e/iBo490LO8pu2uXofwsj9UMidwoeo
        kWwEEFrOVn71LfwGghvLuwXvlw==
X-Google-Smtp-Source: AGHT+IH/7FX3AG4GBKPNWl3bGJcnTxMw8eitbqLPSbHY6Kq8+B6wBqEBknJ7/dQ5zhBRhOc1jR5Sgg==
X-Received: by 2002:a50:ec90:0:b0:522:6e3f:b65 with SMTP id e16-20020a50ec90000000b005226e3f0b65mr9982020edr.33.1694494336357;
        Mon, 11 Sep 2023 21:52:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:16 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 00/37] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
Date:   Tue, 12 Sep 2023 07:51:20 +0300
Message-Id: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
- 01-04 adds SoC identification support;
- 05	is a simple cleanup on SoC identification support
- 06-09	contain fixes on clock drivers identified while adding RZ/G3S
	support
- 10-14	clock cleanups identifies while adding support for RZ/G3S
- 15-22	clock changes needed by RZ/G3S
- 23-30	pinctrl changes needed by RZ/G3S
- 31	document SDHI for RZ/G3S
- 32-37 device tree support for RZ/G3S

Thank you,
Claudiu Beznea

Claudiu Beznea (37):
  dt-bindings: serial: renesas,scif: document r9a08g045 support
  dt-bindings: soc: renesas: document Renesas RZ/G3S SoC variants
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: document RZ/G3S SoC
  soc: renesas: identify RZ/G3S SoC
  soc: renesas: remove blank lines
  clk: renesas: rzg2l: wait for status bit of SD mux before continuing
  clk: renesas: rzg2l: lock around writes to mux register
  clk: renesas: rzg2l: trust value returned by hardware
  clk: renesas: rzg2l: fix computation formula
  clk: renesas: rzg2l: use core->name for clock name
  clk: renesas: rzg2l: simplify a bit the logic in
    rzg2l_mod_clock_endisable()
  clk: renesas: rzg2l: reduce the critical area
  clk: renesas: rzg2l: use FIELD_GET() for PLL register fields
  clk: renesas: rzg2l: use u32 for flag and mux_flags
  clk: renesas: rzg2l: add support for RZ/G3S PLL
  clk: renesas: rzg2l: add struct clk_hw_data
  clk: renesas: rzg2l: remove CPG_SDHI_DSEL from generic header
  clk: renesas: rzg2l: refactor sd mux driver
  clk: renesas: rzg2l: add a divider clock for RZ/G3S
  dt-bindings: clock: renesas,rzg2l-cpg: document RZ/G3S SoC
  dt-bindings: clock: add r9a08g045 CPG clocks and resets definitions
  clk: renesas: add minimal boot support for RZ/G3S SoC
  pinctrl: renesas: rzg2l: index all registers based on port offset
  pinctrl: renesas: rzg2l: adapt for different SD/PWPR register offsets
  pinctrl: renesas: rzg2l: adapt function number for RZ/G3S
  pinctrl: renesas: rzg2l: move ds and oi to SoC specific configuration
  pinctrl: renesas: rzg2l: add support for different ds values on
    different groups
  pinctrl: renesas: rzg2l: make struct
    rzg2l_pinctrl_data::dedicated_pins constant
  dt-bindings: pinctrl: renesas: document RZ/G3S SoC
  pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
  arm64: dts: renesas: add initial DTSI for RZ/G3S SoC
  arm64: dts: renesas: rzg3l-smarc-som: add initial support for RZ/G3S
    SMARC Carrier-II SoM
  arm64: dts: renesas: rzg3s-smarc: add initial device tree for RZ SMARC
    Carrier-II Board
  dt-bindings: arm: renesas: document SMARC Carrier-II EVK
  arm64: dts: renesas: r9a08g045s33-smarc: add initial device tree for
    RZ/G3S SMARC EVK board
  arm64: defconfig: enable RZ/G3S (R9A08G045) SoC

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   1 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml |   2 +
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  26 +-
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../soc/renesas/renesas,rzg2l-sysc.yaml       |   1 +
 .../bindings/soc/renesas/renesas.yaml         |   8 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 139 ++++
 .../boot/dts/renesas/r9a08g045s33-smarc.dts   |  17 +
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |  14 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 147 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  28 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |  19 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |  19 +-
 drivers/clk/renesas/r9a08g045-cpg.c           | 217 ++++++
 drivers/clk/renesas/rzg2l-cpg.c               | 495 ++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h               |  39 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 728 ++++++++++++++----
 drivers/soc/renesas/Kconfig                   |   6 +
 drivers/soc/renesas/renesas-soc.c             |  15 +-
 include/dt-bindings/clock/r9a08g045-cpg.h     | 243 ++++++
 24 files changed, 1924 insertions(+), 252 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

-- 
2.39.2

