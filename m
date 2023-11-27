Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F937FA4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjK0PnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjK0PnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:43:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892919A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:43:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50aab20e828so6243208e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099793; x=1701704593; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eKSI20Q0D7jXzWoo9HzJDMIqRNEtaSE30aXGr8DziA=;
        b=ZhMJYwXqbKpOvey+XEjM/xgkpO74KdI1XsxanSfnmDMlddavsNGS5UV0NLUV22Qzbz
         ZwkliyuE0WWS7uWCDK5lu/gp8//0k2PWu2/dYev9CC1TIttFkvjYHVmyzVfP8ezHSHpk
         ZVM6h/5BUfBCozWFuA8qYXxITNsComji7LSWXCD/ys9cX+XPHlyCA2yHCjVc3ePXMMSZ
         OWGc0lxCw3dfjtfLaqIGJ8ty12V5L4T4gF2Kmm1T8AvCt+Nrg5bb+UTjPJ0SSw7H37xl
         j1Y01GAD2cD0g7jLDfU5tMODyELbNTviTqvXu/jzJPWBw2fLA5sBhJQdaWEI/U+Na7qF
         9clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099793; x=1701704593;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eKSI20Q0D7jXzWoo9HzJDMIqRNEtaSE30aXGr8DziA=;
        b=Pr/Dn7k1PiBZunLHszaGb52DE+TutkhxjTzXFV+c2WuQ5O+UH2o8nTz9wCe4qP7R/5
         QkepJXYfcOi4l+6yTbvYDZ0F4TOWeb7tr4BOVebyCOBcx2xME9OSq7JhCsipA3PnKbS+
         GlS9yR8b3wSCfBGu3VFUQIs7ziYRK9ARS6bjYhbrCfVsft8e04baInvXL+WdkdEosV7r
         7n6ak74ccDUnlaitgpemt1xNBAaPDgPhPf/Kbf6AJ4EXx2hWDQ4+x9Tioej66j/+gS/q
         LHtHFKpVf9v+hY9cKvMG8KoDYzI7Y4Yqr4qKlOCY2T9btv6N5cJ59Jm7ioBsRtGkMrrJ
         WqUw==
X-Gm-Message-State: AOJu0Ywlu5LwWlncMeBFO9iDCA4Uuwny7760kkCO5cT6Fp+G9RXGiWxF
        pKTM+IgqXxGls5H80Rpappc9iQ==
X-Google-Smtp-Source: AGHT+IGy3Wqhh/1y9K43w7Cyu6fyQ5q8zbBpGEJRrqy0jjJp9msb/yS9xwFFWICWk19kmr7GKnf8dw==
X-Received: by 2002:a05:6512:15aa:b0:50b:a823:6213 with SMTP id bp42-20020a05651215aa00b0050ba8236213mr6962935lfb.52.1701099792426;
        Mon, 27 Nov 2023 07:43:12 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2559c000000b0050ab86037d8sm1505049lfg.205.2023.11.27.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:43:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v9 0/5] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date:   Mon, 27 Nov 2023 16:43:03 +0100
Message-Id: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAe5ZGUC/43RTWrDMBAF4KsErauif4266j1KF5I1TgSuHWSjp
 gTfvYq7qIux6fIxzDfw5k5GzAlH8nK6k4wljWnoa3BPJ9JcfH9GmmLNRDAhOWNAP3wu2HUUAA3
 Xgn76nnYYa26UDLaNoo2kbl8ztum2yG+kx4n2eJvIe51c0jgN+Ws5Wfgy/9G53NULp4wyy0Xwz
 oG2zWuXep+H5yGfF7SINaT2IVEh2zaeQTAAym0guYbMPiQrJKGJSrnYBq43kFpD+8UV9YAQWWO
 sBBlwA+kVJA460o+OEITTgnHt7QYya+igI1Mh56QPzCknldpA9p+QrZAAUw1rnI18A8EvxI++B
 hXSrD7MKm4cD3+geZ6/Ae/ZyjHIAgAA
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
Changes in v9:
- Drop all the per-platform device tree fixes, instead send these
  separately for Marvell and NXP platform trees to be applied through
  the SoC tree.
- This means the bindings will yield robotized warnings. Ignore these,
  and rely on platform maintainers to deal with the fallout.
  Patches exists for the majority of the problems, see v8.
- Link to v8: https://lore.kernel.org/r/20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org

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
Linus Walleij (5):
      dt-bindings: net: dsa: Require ports or ethernet-ports
      dt-bindings: net: mvusb: Fix up DSA example
      dt-bindings: net: ethernet-switch: Accept special variants
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema

 Documentation/devicetree/bindings/net/dsa/dsa.yaml |   6 +
 .../bindings/net/dsa/marvell,mv88e6060.yaml        |  88 ++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 337 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 -------
 .../devicetree/bindings/net/ethernet-switch.yaml   |  23 +-
 .../devicetree/bindings/net/marvell,mvusb.yaml     |   7 +-
 MAINTAINERS                                        |   3 +-
 7 files changed, 458 insertions(+), 115 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

