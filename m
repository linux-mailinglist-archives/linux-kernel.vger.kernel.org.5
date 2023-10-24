Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68D57D4BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjJXJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjJXJZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:25:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B510D9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507ac66a969so5725070e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698139511; x=1698744311; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4drfBU1NndBBEL9qL7PFTO+dnjU+af8Xvi9HMH+C3g=;
        b=Eph6JMVLb5ezLaDhqTYG0RaloZfwokHpJmNKcsbZnslUXvMPS58IS4/UgxYK7Cmpi5
         oeWmRlWOJWu2tpAlbdZ5xTv9l++BX/UCfN4hd+d/8ojsfqHBKkfEGQTL7QcE3U/80O7i
         Q29J0fUUglHS+EMIMVdCf0NPMsczCwXh4PhBeRWnDOaG8SPLd5gKsBiXNp9E4fGWDbVh
         8jt+7WRFFqvE3ZZJLQSY3lw7BYZadrnoDQT5HJvxrtXg3HdxdsvttlR+nbkKzEQQi+xK
         imMyTl6p3N+HxUXK32fxvSHm3vJHPMlfYdBmtiCGcx3pui2kpzwqJ5/sT10T4jgZ+8ET
         pItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139511; x=1698744311;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4drfBU1NndBBEL9qL7PFTO+dnjU+af8Xvi9HMH+C3g=;
        b=b25OnFOTaTekg7uqv2ibnY+ipG33VMDEFsMWRn+72j4l4pvFfWuUPEhY1uS5RKniOW
         NkuJtuoRed+SHTlC9WQzTmVJrKnuxId5ICAnFD1Hum8NmLir9EIajBFYBRyLPMMZPDW+
         671QSfR4YqTRPqupoFVkNCcjh67Y/amEPllBWtdLGpSUC5YF+8t6wl+BXfKi1NVPfI3p
         0y1b/1vXkJZqnZ9gtx3TlEtGoNft/2JYKW2xJ+RePG8rhCdYJeRWKuBt5p25ng/mEEoA
         vDeAf1PNfg8lcsAoqPd1AwpDeDmqj5NTmnZQjngn3Rba4eoaVFvDV7YwS6vd1COEly9Q
         rB6g==
X-Gm-Message-State: AOJu0YzjNxN1vj5GiURw7iN6+vRf3py7bm3cgmxHFa8kh9C95xDKKPj9
        T5iSCPywNctFS+iFewk31Evstw==
X-Google-Smtp-Source: AGHT+IE6nLShP+24bHzx+rvQOG17X9l2G1OHwe4apNXfPUZd+AJmojMkxYxBAoBUfkI/a2F/lxmXmA==
X-Received: by 2002:ac2:5308:0:b0:500:a3be:1ab6 with SMTP id c8-20020ac25308000000b00500a3be1ab6mr8272530lfh.6.1698139511223;
        Tue, 24 Oct 2023 02:25:11 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id c12-20020ac25f6c000000b004fbc82dd1a5sm2060246lfc.13.2023.10.24.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:25:10 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v6 0/7] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date:   Tue, 24 Oct 2023 11:24:52 +0200
Message-Id: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSNN2UC/33QyWrDMBQF0F8JWldF89BV/6NkoeEpEbhykY2SE
 vzvVdyNi3GXl8s7D+4DTVAzTOjt9EAVWp7yWHpQLycUrq5cAOfYM2KEcUqIwZ+uNhgGbAwoKhm
 +uYIHiD0Hwb1OkaWI+vVXhZTvq/yBCsy4wH1G595c8zSP9Xt92eja/+qUH+qNYoKJpsw7a43U4
 X3IxdXxdayXFW1sC4ljiHVIp+CI8coYYXcQ30LqGOId4iZEIWxMnsodJLbQ8XBNPCEAEpTmhnv
 YQXIDsX82ks+NwDArGaHS6T/Qsiw/VY5Wwe0BAAA=
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
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell switches are lacking DT bindings.

I need proper schema checking to add LED support to the
Marvell switch. Just how it is, it can't go on like this.

Some Device Tree fixes are included in the series, these
remove the major and most annoying warnings fallout noise:
some warnings remain, and these are of more serious nature,
such as missing phy-mode. They can be applied individually,
or to the networking tree with the rest of the patches.

Thanks to Andrew Lunn, Vladimir Oltean and Russell King
for excellent review and feedback!

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v6:
- Fix ports/ethernet-ports requirement with proper indenting
  (hopefully).
- Link to v5: https://lore.kernel.org/r/20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org

Changes in v5:
- Consistently rename switch@n to ethernet-switch@n in all cleanup patches
- Consistently rename ports to ethernet-ports in all cleanup patches
- Consistently rename all port@n to ethernet-port@n in all cleanup patches
- Consistently rename all phy@n to ethernet-phy@n in all cleanup patches
- Restore the nodename on the Turris MOX which has a U-Boot binary using the
  nodename as ABI, put in a blurb warning about this so no-one else tries
  to change it in the future.
- Drop dsa.yaml direct references where we reference dsa.yaml#/$defs/ethernet-ports
- Replace the conjured MV88E6xxx example by a better one based on imx6qdl
  plus strictly named nodes and added reset-gpios for a more complete example,
  and another example using the interrupt controller based on
  armada-381-netgear-gs110emx.dts
- Bump lineage to 2008 as Vladimir says the code was developed starting 2008.
- Link to v4: https://lore.kernel.org/r/20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org

Changes in v4:
- Rebase the series on top of Rob's series
  "dt-bindings: net: Child node schema cleanups" (or the hex numbered
  ports will not work)
- Fix up a whitespacing error corrupting v3...
- Add a new patch making the generic DSA binding require ports or
  ethernet-ports in the switch node.
- Drop any corrections of port@a in the patches.
- Drop oneOf in the compatible enum for mv88e6xxx
- Use ethernet-switch, ethernet-ports and ethernet-phy in the examples
- Transclude the dsa.yaml#/$defs/ethernet-ports define for ports
- Move the DTS and binding fixes first, before the actual bindings,
  so they apply without (too many) warnings as fallout.
- Drop stray colon in text.
- Drop example port in the mveusb binding.
- Link to v3: https://lore.kernel.org/r/20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org

Changes in v3:
- Fix up a related mvusb example in a different binding that
  the scripts were complaining about.
- Fix up the wording on internal vs external MDIO buses in the
  mv88e6xxx binding document.
- Remove pointless label and put the right rev-mii into the
  MV88E6060 schema.
- Link to v2: https://lore.kernel.org/r/20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org

Changes in v2:
- Break out a separate Marvell MV88E6060 binding file. I stand corrected.
- Drop the idea to rely on nodename mdio-external for the external
  MDIO bus, keep the compatible, drop patch for the driver.
- Fix more Marvell DT mistakes.
- Fix NXP DT mistakes in a separate patch.
- Fix Marvell ARM64 mistakes in a separate patch.
- Link to v1: https://lore.kernel.org/r/20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org

---
Linus Walleij (7):
      dt-bindings: net: dsa: Require ports or ethernet-ports
      dt-bindings: net: mvusb: Fix up DSA example
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema

 Documentation/devicetree/bindings/net/dsa/dsa.yaml |   6 +
 .../bindings/net/dsa/marvell,mv88e6060.yaml        |  88 ++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 330 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 -------
 .../devicetree/bindings/net/marvell,mvusb.yaml     |   7 +-
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/marvell/armada-370-rd.dts        |  24 +-
 .../dts/marvell/armada-381-netgear-gs110emx.dts    |  44 ++-
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     |  38 +--
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |  22 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  |  18 +-
 .../boot/dts/marvell/armada-385-turris-omnia.dts   |  20 +-
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |  20 +-
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |  18 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts        |  14 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts    |  70 ++---
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts        |  18 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts    |  20 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts   |  18 +-
 .../dts/marvell/armada-3720-espressobin-ultra.dts  |  14 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |  20 +-
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |  20 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 189 ++++++------
 .../boot/dts/marvell/armada-7040-mochabin.dts      |  24 +-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  22 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |  42 ++-
 26 files changed, 761 insertions(+), 457 deletions(-)
---
base-commit: 1c9be5fea84e409542a186893d219bf7cff22f5a
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

