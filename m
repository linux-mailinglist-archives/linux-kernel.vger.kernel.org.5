Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C652F7C964F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjJNUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJNUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:51:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A69CC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:51:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so4087541e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697316696; x=1697921496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qto4krpjBE/Wuaeru9wVjaS4puBPq/i+G9Tt+UL8VeY=;
        b=Mnr6dEfnv2ulV59TcxRwGVHuj6bbmpBcymfB9fS1q1DqPpRIZPibPDrimYIIUHsJHY
         1JXGycQaj1WI6mnY4Ll/AgEjqzxKncXQE8mk0giPs6ZSwSKBfOcO6rt2Q+Jxz1cZhNGn
         v4HJoPL9J7Fpu74QVWX5Fs/hxbDKQ3Lu7YIUYniFGP6uAsy5c9oJUu132bPNe3x1JaDt
         UHbLKSA8+KBsJqRfnXPKOMGtkhgIbBTxMvxeES5ZKTyVi14gVZeRPcJhClz+PiuvMUkE
         1hAvf3qBMouT+mxeKsFogjvtQpWuR5tEtGnDW/DJ5K/BkfcCbG9Io5KOoTEIfnF+EAhm
         OaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697316696; x=1697921496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qto4krpjBE/Wuaeru9wVjaS4puBPq/i+G9Tt+UL8VeY=;
        b=m+ViIGcxZ7rd0COrR5U5X6T3mrQzkydY6NVsnonScXz0USwCqgGt3F6upe/gHKj/49
         lNjXS5fvVStCTOWllSa9P7LM8RC2kZn4jerVcKGlOB1aS/b04bJBdwisJWiKwGJX35kX
         rIRU/lk0Nx1aPucDDNIXmOzlG0kzNbePMpZE6tlxVeBfzl3WI6LSuanM1qc9nZBo1hfW
         ExWMzfZlmPX/8x6YOXtBHrDReV6GIljXU3mPqFUurOqzQPcLTHcNPV2WpUUbBTRGlyyU
         TqWb11Cs8VNyKKYtxc/dC8W8UeAyOb+fiX06m1XeeeZGaZ08zEXGhATJkgS8X13tpjKq
         1PmA==
X-Gm-Message-State: AOJu0Yz4kBcMUZBDAd8nLjtDw6QZuP5Susjn2coUSe9A1gkC5JdKgSXH
        VHYocMu4LvCs89R1HjI07OnzQeUlzxvnRNwZNFw=
X-Google-Smtp-Source: AGHT+IE2LkLny2Hv7hkf3yTWo3sEWQ3xuaqPwi7Pl1HEr4EfSbhQQmLHHadFrPJoUvbWPgZgxpS18Q==
X-Received: by 2002:ac2:4ade:0:b0:507:a6e9:fbba with SMTP id m30-20020ac24ade000000b00507a6e9fbbamr1037614lfp.63.1697316696085;
        Sat, 14 Oct 2023 13:51:36 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004ff96c09b47sm49926lfr.260.2023.10.14.13.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:51:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v2 0/5] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date:   Sat, 14 Oct 2023 22:51:31 +0200
Message-Id: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFP/KmUC/3WNwQ6DIBAFf8XsudsA1oo99T8aDyirklBowFAbw
 7+X2HOPk8mbt0OkYCjCrdohUDLReFdAnCoYF+VmQqMLg2Ci5oxJfKqQyFqUkq68EfhWDi3pwuO
 lHtpJi0lDWb8CTWY7yg9wtKKjbYW+mMXE1YfPcZn44X91Xv+tJ44MWcvFoLpONu14t8ap4M8+z
 NDnnL8WSdfXyQAAAA==
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shows the path we could take with this, deprecating the
weird external bus thing.

I don't know what to do about the irq lines with a pointless
type flag that should be onecell:ed.

I need proper schema checking to add LED support to the
Marvell switch. Just how it is, it can't go on like this.

Some Device Tree fixes are included in the series, these
remove the major and most annoying warnings fallout noise:
some warnings remain, and these are of more serious nature,
such as missing phy-mode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Break out a separate Marvell MV88E6060 binding file. I stand corrected.
- Drop the idea to rely on nodename mdio-external for the external
  MDIO bus, keep the compatible, drop patch for the driver.
- Fix more Marvell DT mistakes.
- Fix NXP DT mistakes in a separate patch.
- Fix Marvell ARM64 mistakes in a separate patch.
- Link to v1: https://lore.kernel.org/r/20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org

---
Linus Walleij (5):
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes

 .../bindings/net/dsa/marvell,mv88e6060.yaml        | 106 +++++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 241 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/marvell/armada-370-rd.dts        |   2 -
 .../dts/marvell/armada-381-netgear-gs110emx.dts    |   6 +-
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     |   2 +-
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |   2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  |   2 -
 .../boot/dts/marvell/armada-385-turris-omnia.dts   |  16 +-
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   2 -
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |   2 -
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts    |   8 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts    |   4 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts   |   2 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |   4 +-
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |   4 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |  32 +--
 .../boot/dts/marvell/armada-7040-mochabin.dts      |   2 -
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |   2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |   6 +-
 23 files changed, 390 insertions(+), 171 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

