Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A97EA701
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjKMXgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMXgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:36:04 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980CCD55
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:35:59 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so66480671fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699918558; x=1700523358; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLUowILeMSx22TGmoI2SiGwx7HFPC6VGLKfDV1sGTQA=;
        b=GqkwCyiUHzfEoY3njYk1b/NBrfYwYEGpIPa6AfFVRU2gVPEdtdt7hm2fgz9uNOP9uP
         15eNuQcXasG2aUbOzlKtlWhPp8pWYWpljpXr8lBWf7e4op+QC/LCJ/n4fYhXp62MKtxh
         u1GgKBzzNJQyip3tNRK11fIS1JWN4sRlBVHO34oyLkK2ttptLyn6XHy7Dv6x6TxYR7W8
         G7sVmJLeCF0jEv8Zvyp8Z81s9jyaM1B7T/d4PQKbjBedKbGc6h5fcAkGBDtzKzTiTpxD
         CrUA/WXYYQq0O7JoWjkLuPQWRm5E0QZuZCoJUDOzeDvakUZepq29RBUlu99wZtFxrCgY
         tsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918558; x=1700523358;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLUowILeMSx22TGmoI2SiGwx7HFPC6VGLKfDV1sGTQA=;
        b=GY7FyA0y4IQOzW+MedPvfjQ6EIeL0hYxw/6S4L8gT08bzoe4LzZDDyxyTNfKbkbx2B
         hPj6x9ThQJaRgwuB8LhGZFYH3coOtiTL5FI7DkY+YAm7J7HhlITuAv954COKeqiMgsVz
         2/gv5rU81F5HBFH/pi7FThIuzVPimDAbw6pL8WBrh50a1BouTQmGVb8c3fPNeo/+e4sW
         0XuhWDdC+a4Gf0J9ROewxtkwFtlvRvJOcAYjl+/+nC1v+JJogyrKDbNUHb5Z5FNuJmrm
         zJ4Wcvca2/65s14ifeTJVzpo/4vP0V9AO36nVpxjIH0TsN73TQucmwpB1/vo30lNBvlm
         WjDQ==
X-Gm-Message-State: AOJu0YzLrXGD3nD/R1EMyecIsuOjZ3vRYzaJ6LRlsOlC2v5twmDlbmLK
        wpN/Eu1OZ1Op5Mk6vh9RBitq5Q==
X-Google-Smtp-Source: AGHT+IH4vwjdzlPMdHRoC9SQ1paCa/XR78O9smbQ5zOFeoPMPeq5w5XfQico49NTk3IB8761xZAT0w==
X-Received: by 2002:a05:651c:2c4:b0:2c5:f8e:35cf with SMTP id f4-20020a05651c02c400b002c50f8e35cfmr463031ljo.20.1699918557815;
        Mon, 13 Nov 2023 15:35:57 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0611000000b002b70a8478ddsm1202859ljg.44.2023.11.13.15.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:35:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v8 0/9] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date:   Tue, 14 Nov 2023 00:35:55 +0100
Message-Id: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANuyUmUC/43Qy2rDMBAF0F8JWldFb4266n+ULvQYJwJXLrJxU
 4L/vYq7cTEOXV4ucwbujYxYM47k5XQjFec85qG0AE8nEi++nJHm1DIRTEjOGNAPX2fsewqAhmt
 Bv3yhPaaWo5LBdkl0ibTrz4pdvq7yGyk40YLXiby35pLHaajf68uZr/2vzuWhPnPKKLNcBO8ca
 Btf+1x8HZ6Hel7RWWwhdQyJBtkuegbBACi3g+QWMseQbJCEmJRyqQtc7yC1hY6Hm9UdQmTRWAk
 y4A7SG0g82EjfN0IQTgvGtbc7yGyhBxuZBjknfWBOOanUDrL/hGyDBJhmWONs4n+gZVl+AOg+y
 VJ/AgAA
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This latest version employs special compatibles in the
odd ABI device trees.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v8:
- Restore ALL original switch node names in the Turris Mox, not just
  the top one. Put a comment above each not to change the node name.
- Add a special compatible for the Turris Mox switches, so that we
  can apply special rules for these ABI nodes.
- Add quirks to the bindings to deal with the special node names
  so we don't get unsolicited warnings about them from the checks.
  This is done so that people will not come and "fix the DTS files"
  so they break. We only have serious warnings after this.
- Add the quirks and updates to the nodes into separate patches
  for review.
- Link to v7: https://lore.kernel.org/r/20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org

Changes in v7:
- Fix the elaborate spacing to satisfy yamllint in the
  ports/ethernet-ports requirement.
- Link to v6: https://lore.kernel.org/r/20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org

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
Linus Walleij (9):
      dt-bindings: net: dsa: Require ports or ethernet-ports
      dt-bindings: net: mvusb: Fix up DSA example
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      dt-bindings: net: ethernet-switch: Accept special variants
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      ARM64: dts: Add special compatibles for the Turris Mox
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema

 Documentation/devicetree/bindings/net/dsa/dsa.yaml |   6 +
 .../bindings/net/dsa/marvell,mv88e6060.yaml        |  88 ++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 337 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 -------
 .../devicetree/bindings/net/ethernet-switch.yaml   |  23 +-
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
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |  97 +++---
 .../boot/dts/marvell/armada-7040-mochabin.dts      |  24 +-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  22 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |  42 ++-
 27 files changed, 745 insertions(+), 411 deletions(-)
---
base-commit: 1c9be5fea84e409542a186893d219bf7cff22f5a
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

