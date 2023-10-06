Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065A7BB570
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjJFKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJFKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76E9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:40:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso372507666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696588821; x=1697193621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeQqgG9kHc72c2g0exnbDlVNb4xPw3G7iuO/4geTEVQ=;
        b=eVaKKxPVNCaiezl69xNhZrzLn9Li3v0m4TrLKxnFAqJbdyZXvr72PJICTyXDKw10g3
         m9X/L8xui4uhSqYiNv58mmBqqyUgvkN9dEuRy3xUJs1lNRLXBUDA1VR0t69/twUgwfX4
         fLe7w2kKDSAMQoc5P8GpvX13feseMsiuxXEazYOU5sEIElUCASUQhufuMibB4IKZkZOs
         4yk3GxVABsKvyVTA1ivQNT//ezcjeefA0W6lKMomDs4DYEAJLLnxFK4fARnKiDM21vy/
         IPRXXstR8Ax+cxddcuqz+b2imLUg1kegX7JuZHL+mQD8KSg7tV2iGCECgM2NgdNDvzt6
         oxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588821; x=1697193621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeQqgG9kHc72c2g0exnbDlVNb4xPw3G7iuO/4geTEVQ=;
        b=kWHnVfr8EIvXJsxi9EC1OIMSBvVEAZU5aovwuxrQsansLQDHYnvR8eH9m0+M3re3+n
         PHYuTsAVoaVek0Kme6AGmgldfzrKNBQip9Vi8rd+xZrxYbCZu6L4VagRT94ygcMABZiI
         JaTrorjtA+YI1Eric64z+96ZhGc2e/2XRxsrkL9pSTosezxaRMS2W2h7ivhw1Y7z1uRB
         U9UunUE9GXKC0RBqO3y0s/PR6A6mqI/9RGKkuHFHaCfMxQgWNQGhRToUYOSoWDfNKuye
         TAmuI3Z2Upo28d0CFzOoW8NpZWAwDh0JPFZ6u9iVKLtfOz1BeRFFDgUTD7bODAdjKI/k
         ncng==
X-Gm-Message-State: AOJu0Yz7pNSv4tn/jV4Gd7DrDlzqTBieqke9STXwDh+EthjkqCgqmgwH
        dEoxXt+NHdRn2TgsA0+cAQ9jtw==
X-Google-Smtp-Source: AGHT+IHMKEAZG+zX5i9Cl32pZ+P5QmVcPSYDJ5qyvhw04Q1MitxDEPTj2audMVvwor1W/QPxocLXVQ==
X-Received: by 2002:a17:907:78d7:b0:9ae:3a68:93e8 with SMTP id kv23-20020a17090778d700b009ae3a6893e8mr7117382ejc.14.1696588820745;
        Fri, 06 Oct 2023 03:40:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm2642490ejb.185.2023.10.06.03.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:40:20 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/4] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
Date:   Fri,  6 Oct 2023 13:39:55 +0300
Message-Id: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
- 02-04	clock changes needed by RZ/G3S

Changes in v3:
- remove from series patches that were already integrated
- addressed review comments
- please see individual patches for detailed changes

Changes in v2:
- addressed review comments
- collected tags
- removed from series patches that were already integrated
- added patches:
	- [PATCH v2 19/28] dt-bindings: pinctrl: renesas: set additionalProperties: false
	- [PATCH v2 23/28] dt-bindings: arm: renesas: document RZ/G3S SMARC SoM
	- [PATCH v2 26/28] dt-bindings: arm: renesas: document SMARC Carrier-II EVK
- please see individual patches for detailed changes

Claudiu Beznea (4):
  dt-bindings: serial: renesas,scif: document r9a08g045 support
  clk: renesas: rzg2l: refactor sd mux driver
  clk: renesas: rzg2l: add a divider clock for RZ/G3S
  clk: renesas: add minimal boot support for RZ/G3S SoC

 .../bindings/serial/renesas,scif.yaml         |   1 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |  12 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |  12 +-
 drivers/clk/renesas/r9a08g045-cpg.c           | 214 +++++++++++
 drivers/clk/renesas/rzg2l-cpg.c               | 342 +++++++++++++++---
 drivers/clk/renesas/rzg2l-cpg.h               |  28 +-
 8 files changed, 565 insertions(+), 52 deletions(-)
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c

-- 
2.39.2

