Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD417E5917
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjKHOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344607AbjKHOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:34:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B831BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:33:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso9463784e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454037; x=1700058837; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcULZ9PGcbiz4pOSYdWqK1KBS4j8l5GIDZ+NaSWycPw=;
        b=zvKBXC5mGb15nr6GNShso8tgMsgpfhx1kHY/rv2v7yVw3RJwDRmTQiDu6WQ+j4UY5N
         j1AG0Pd4DRPcJjypqJk9r2zsve8IWmNDYFjoZhawTw2V0ubnmZWtv8eyCbHRjl+WrGz4
         lZmy5tYqAF/2nueJ4Qz41Mnpk0rYl/NqWHtYjCE9pkmCMrtTEc8afZes4/J/W1wbpD54
         D6sgIzOL/yFlDDWQJiwlaUsuwKvwi8NquNGbkfyWioKEgQ7kE2NVb34MP+J5ExOwiTQX
         3aj6BoDaJMos1dj8rO8Udy4BAIkUolOrr4SnZsawG12kSfUeiutzGnSGrUSH9cyluPSC
         4fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454037; x=1700058837;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcULZ9PGcbiz4pOSYdWqK1KBS4j8l5GIDZ+NaSWycPw=;
        b=KyXjMr+0x5l6+ni9irblMVayVFV71OLVBG0ygCFaBUEgzEI9iu2EeZpBR/2QclPdTQ
         p7ghdIxa5mYmBS/nWLxI8HMQmVaRCulxiptfh5PMHXiqpFJyJJmmuiTSoPTsZRaeIqyq
         EmxTx/bxUjcMfT1izblBcGlrD/El7wzE5gx1Pb7UJtLjfwVk/1uIq5iVn30PxLFz0Z5x
         n1ZZcsiFcbZ/lf/8SovaqfNvhPO+X17+JlW+lXmv3SXvG+DcoESlRewy8VMLHLc8lzhn
         Xgv2nhFG0IOJVoLWBmhvIW6Cw1SOxUtBz7qyQh2is88vsfjHd9UcgZpgxKTzrpc197eU
         TmSQ==
X-Gm-Message-State: AOJu0YyS76o3x7449WHI3G6+u3MP0vcCvPYcG5tlyuDPsugoqT+3/vAe
        NZkVhsLOp9acdDY3YEz4WMIObg==
X-Google-Smtp-Source: AGHT+IHfdWgUd7peX98jM5hIRx+rFXqSbrGst/IoGRVbU4s1SKmlHEwnM062t9jx1mAFjSR1p5D80Q==
X-Received: by 2002:a05:6512:31d0:b0:509:2b81:fc40 with SMTP id j16-20020a05651231d000b005092b81fc40mr1835669lfe.9.1699454037158;
        Wed, 08 Nov 2023 06:33:57 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b00507a3b8b007sm686773lfp.110.2023.11.08.06.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:33:56 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] Fix polarity and bindings for GPIO-based NAND drivers
Date:   Wed, 08 Nov 2023 15:33:48 +0100
Message-Id: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEycS2UC/x2MQQqAIBAAvyJ7bkGtoPpKdDBdaw+ZKEQg/j3pO
 DAzBTIlpgyLKJDo4cx3aKA6AfY04SBk1xi01L1SckTPL14cMwYTHNpZ0e4m6c3goTUxURP+37r
 V+gEN+7w/XwAAAA==
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Howard Harte <hharte@magicandroidapps.com>
X-Mailer: b4 0.12.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Delta and generic GPIO-based NAND drivers are using GPIO lines
extensively to communicate with a raw NAND flash.

Some confusion has crept into the naming leading to the two drivers using
inversed semantics differently for pins with the same name.

Fix the situation by naming the pins consistently without any inversion
names (such as nce for a negative active chip enable).

Fix up all in-tree users.

Next rewrite the device tree bindings in YAML schema, and fix up the
single in-tree DTS file (MIPS) to use the new bindings where each signal
is specified explicitly instead of an array with some "blanks" for unused
lines.

Last clean up the GPIO NAND driver to drop use of board file provided
data as no boards using this remain, and use device properties removing
the explicit reliance on device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (6):
      mtd: rawnand: ams-delta/gpio: Unify polarity
      dt-bindings: mtd: Rewrite gpio-control-nand in schema
      MIPS: NI 169445: Fix NAND GPIOs
      mtd: rawnand: gpio: Use device properties
      mtd: rawnand: gpio: Support standard nand width
      mtd: rawnand: gpio: Rename file

 .../devicetree/bindings/mtd/gpio-control-nand.txt  |  47 ------
 .../devicetree/bindings/mtd/gpio-control-nand.yaml | 168 +++++++++++++++++++++
 Documentation/devicetree/bindings/mtd/mtd.yaml     |   2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   8 +-
 arch/mips/boot/dts/ni/169445.dts                   |  13 +-
 drivers/mtd/nand/raw/Makefile                      |   2 +-
 drivers/mtd/nand/raw/ams-delta.c                   |  60 ++++----
 drivers/mtd/nand/raw/{gpio.c => nand-gpio.c}       | 120 +++++----------
 8 files changed, 251 insertions(+), 169 deletions(-)
---
base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
change-id: 20231105-fix-mips-nand-c91ebd80fa4f

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

