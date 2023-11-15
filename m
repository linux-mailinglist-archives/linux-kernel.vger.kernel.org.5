Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDB7EC52A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbjKOO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:28:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01686E7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:28:38 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9db6cf8309cso998147466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700058516; x=1700663316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1bYEl09IoLqZ4ey+eADiyqvL5SUtiEl1aW7JJS482k=;
        b=os8cyFDNBB2SLocU2l3XP9mO+eKkeEtTmr6pM7D4Mlrh+xVuXzA6GeMEOq2Sd4OfQ+
         KfGcvfOWkZZmSqGXlCCoawZxv6XY25yalS/O/u4y8W6wNyZuyzJLr43D7iBwvEp6SPc1
         RDz2ahDNjLv4xn66kpnLIvbs0UxzyzdGhhxYYbDf7BeEmJYg7iabiFK3TNqE/t/tWnSR
         zuKbOL390S3hL2TzHIM0BaWuajFaWLy+fymao0tdUlAZqXzULy/F2DRQFrr8Pn5F0Nft
         UWSootp/IrgOLotOHWQTIG3KzDTAowtxzaSGiZo1caymqCTEMGjoOTo4elq2yP1w2KMd
         o/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058516; x=1700663316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1bYEl09IoLqZ4ey+eADiyqvL5SUtiEl1aW7JJS482k=;
        b=hnzbAzUSQy8prpohLpi4PR2r/swNhkC91GWqFLEyG0wKTDjskv+8cGCoJUHGuTn5ds
         BlvsuCk66nNQW4/akcgLrPuoSgrsrfP8s+bR7eG2xmPh+Lt5b5FeumrAnpOmZhJmBMZi
         GVLJczEp+xqjSiMpqxSkcJzxoDf7hEQokuMPIbXItkoxvCyrubQWT2uhmv9sgc4q/7Bo
         g+CZVtPjezFaR8xEz/GvrPqVQrFhTgN+jXRQBxuEBNPDtJo15CY1W9b1pGtjw8VSLfqp
         z34P3bpi/bCimP76R4VFO1tbXL9hlG5lsSxyNf++OCqeXSFTopZWaNmS3SZw2R95SsH0
         /XyQ==
X-Gm-Message-State: AOJu0YztB1tCJKsIZMdQO0EL2zgpYM7uL1tn/odaQv0+TNts6tyCz6QS
        mdF3rwA+EbNn9ixmkmuXsmkwmQ==
X-Google-Smtp-Source: AGHT+IGr51Xp9J2M/QL2HgUJoT05UgyIsuf5IK5LOC5/gt3gQmAyfU3KI/4Vncq8iuWLEctadZ1uLg==
X-Received: by 2002:a17:906:4b47:b0:9be:e278:4d45 with SMTP id j7-20020a1709064b4700b009bee2784d45mr9348004ejv.15.1700058516380;
        Wed, 15 Nov 2023 06:28:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.119])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b0099bd5d28dc4sm7186394ejc.195.2023.11.15.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:28:35 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/9] irqchip/renesas-rzg2l: add support for RZ/G3S SoC
Date:   Wed, 15 Nov 2023 16:27:40 +0200
Message-Id: <20231115142749.853106-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds support for IA55 available on RZ/G3S SoC.
Patches are split as follows:
- 1/9 updates documentation
- 2/9 adds IA55 clock
- 3-5/9 minor cleanups to align with the suggestions at [1] and
  coding style recommendations
- 6/9 implement restriction described in HW manual for ISCR register
- 7/9 add a macro to retrieve TITSR base address based on it's index
- 8/9 add suspend to RAM support
- 9/9 adds IA55 device tree node

Thank you,
Claudiu Beznea

[1] https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

Changes in v2:
- collected Conor's tag
- updated commit description according to code review comments
- added patches 4, 5 according to review recommendations
- updated patch 7/9 to retrieve only TITSR base address; dropped the rest
  of the changes for the moment
- in patch 8/9 use local variable in suspend/resume functions for controller's
  base address, indent initialized structures members to tabs, updated
  private driver data structure name
- patch 3/7 from v1 was replaced by patch 7/9 in v2
- patch 5/7 from v1 was renamed "Add support for suspend to RAM"
- cleanup patches were kept at the beginning of the series and features at the end

Claudiu Beznea (9):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S
  clk: renesas: r9a08g045: Add IA55 pclk and its reset
  irqchip/renesas-rzg2l: Use tabs instead of spaces
  irqchip/renesas-rzg2l: Align struct member names to tabs
  irqchip/renesas-rzg2l: Document structure members
  irqchip/renesas-rzg2l: Implement restriction when writing ISCR
    register
  irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset
    based on register index
  irqchip/renesas-rzg2l: Add support for suspend to RAM
  arm64: dts: renesas: r9108g045: Add IA55 interrupt controller node

 .../renesas,rzg2l-irqc.yaml                   |   5 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  68 +++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/irqchip/irq-renesas-rzg2l.c           | 110 +++++++++++++-----
 4 files changed, 156 insertions(+), 30 deletions(-)

-- 
2.39.2

