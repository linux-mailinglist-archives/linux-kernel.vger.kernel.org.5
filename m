Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879417F14B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjKTNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjKTNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB76EE;
        Mon, 20 Nov 2023 05:51:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859dee28cso18315575e9.0;
        Mon, 20 Nov 2023 05:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488271; x=1701093071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=umWEKXWFXv0eNP2vzXEwDqh3C4XXm2b3F2YK1OcVyho=;
        b=Ug1PenHzHBVPOrmeVIBrUWmU8RhAM/adjddhvy0Iw3qBVosuWBJTZuAzOC60moSe4z
         Axd81i15KibYHzjBLdAJ0Qw/YB7iAq28R6zxLekWZoh0Gz1lAxR21NspSUctpUkhPHv5
         NbaSMnsD9zk+u/vctHmz2L8eAUFs5X3SYdGDyYRzwSVxfqshtt1G1JolOIDBGE1vXgZ4
         d2irt6r0lN/BgZkTuZOAKvO4b+6acgAsuUpcC74I+uO3pR3tEuUAvhbay/fEJbPIF0M8
         HrA3rcQY6vQJI0hgGFcFiocO5zTZUBLUcDOGnYon2LY4BlVGNkrcAucVCNZZxaPk7+NK
         jvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488271; x=1701093071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umWEKXWFXv0eNP2vzXEwDqh3C4XXm2b3F2YK1OcVyho=;
        b=ct5vss/L/KVkMQN66WtziOseEShTn7DjQoQ73Z8AG5TmDmO1r5KWiIwF7K30gCOe+G
         spHXQDL26rFurZgxZsHqczcicOQwy3O0S6sMP9KmPy/aNpx7Z2Yngt6RAgfTt4BTn9Vf
         d0I9conIEnrytDUfRXiQ3asuKVcGpb0ghBIaFkDOID2S0JcuTuT8cgKXT8gpO+bnc46I
         K+i5/S95TbH97eZkyGaIHVV7YBYE2QcensS/FTbqy7tQ5aYpi7YaZZju/5KTVcapUQtZ
         7z1xi1Gwy+0r7gKfw6Q4iGP6UNfbXAIUKArsuVm8Iyfi//6u1OpHE4IPvhYb2Om2gthr
         TrOQ==
X-Gm-Message-State: AOJu0YxhBgO/lIHBKrC7718iLkmXqAczZr61vdGJUTf0RZUsJ+uflAek
        DxF3Qb7wXDWOSB+BBLcfzJAUyhu2pcE=
X-Google-Smtp-Source: AGHT+IG1J8cbmxkv7bK3mr7U//mrN6TW30Hcy9cOIwzVFGvTJowIC50goBaskga2xCFUBmOawihy0w==
X-Received: by 2002:a05:600c:1392:b0:40a:69f2:3b7c with SMTP id u18-20020a05600c139200b0040a69f23b7cmr7002035wmf.16.1700488270960;
        Mon, 20 Nov 2023 05:51:10 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:10 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 00/14] net: phy: Support DT PHY package
Date:   Mon, 20 Nov 2023 14:50:27 +0100
Message-Id: <20231120135041.15259-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idea of this big series is to introduce the concept of PHY package in DT
and generalize the support of it by PHY driver.

The concept of PHY package is nothing new and is already a thing in the
kernel with the API phy_package_join/leave/read/write.

The main idea of those API is to permit the PHY to have a shared global
data and to run probe/config only once for the PHY package. There are
various example of this already in the kernel with the mscc, bcm54140
mediatek ge and micrle driver and they all follow the same pattern.

What is currently lacking is describing this in DT and better reference
the PHY in charge of global configuration of the PHY package. For the
already present PHY, the implementation is simple enough with only one
PHY having the required regs to apply global configuration.

This can be ok for simple PHY package but some Qcom PHY package on
""modern"" SoC have more complex implementation. One example is the PHY
for qca807x where some global regs are present in the so-called "combo"
port and everything about psgmii calibration is placed in a 5th port in
the PHY package.

Given these additional thing, the original phy_package API are extended
with support for multiple global PHY for configuration. Each PHY driver
will have an enum of the ID for the global PHY to reference and is
required to pass to the read/write function.

On top of this, it's added correct DT support for describing PHY
package.

One example is this:

        ethernet-phy-package {
            compatible = "ethernet-phy-package";
            #address-cells = <1>;
            #size-cells = <0>;

            global-phys = <&phy4>;
            global-phy-names = "base";

            ethernet-phy@1 {
              compatible = "ethernet-phy-ieee802.3-c22";
              reg = <1>;
            };

            phy4: ethernet-phy@4 {
              compatible = "ethernet-phy-ieee802.3-c22";
              reg = <4>;
            };
        };

The mdio parse functions are changed to address for this additional
special node, the function is changed to simply detect this node and
search also in this.

If this is detected phy core will join each PHY present in the node and
use (if defined) the additional info in the PHY driver to probe/config
once the PHY package.

Some PHY package also supports a single phy-mode for every PHY in the
PHY package. This is also supported and can be described in DT by
defining the phy-mode in the PHY package node.

I hope this implementation is clean enough as I expect more and more of
these configuration to appear in the future.

Christian Marangi (12):
  net: phy: extend PHY package API to support multiple global address
  dt-bindings: net: move PHY modes to common PHY mode types definition
  dt-bindings: net: document ethernet PHY package nodes
  net: phy: add initial support for PHY package in DT
  net: phy: add support for named global PHY in DT PHY package
  net: phy: add support for shared priv data size for PHY package in DT
  net: phy: add support for driver specific PHY package probe/config
  net: phy: add support for PHY package interface mode
  net: phy: move mmd_phy_indirect to generic header
  net: phy: add support for PHY package MMD read/write
  dt-bindings: net: Document Qcom QCA807x PHY package
  net: phy: qca807x: Add support for configurable LED

Robert Marko (2):
  dt-bindings: net: add QCA807x PHY defines
  net: phy: add Qualcom QCA807x driver

 .../bindings/net/ethernet-controller.yaml     |   47 +-
 .../bindings/net/ethernet-phy-mode-types.yaml |  132 ++
 .../bindings/net/ethernet-phy-package.yaml    |   86 ++
 .../devicetree/bindings/net/qcom,qca807x.yaml |  143 ++
 drivers/net/mdio/of_mdio.c                    |   60 +-
 drivers/net/phy/Kconfig                       |    7 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/bcm54140.c                    |   23 +-
 drivers/net/phy/mdio_bus.c                    |   33 +-
 drivers/net/phy/mediatek-ge-soc.c             |   11 +-
 drivers/net/phy/micrel.c                      |   13 +-
 drivers/net/phy/mscc/mscc.h                   |    7 +
 drivers/net/phy/mscc/mscc_main.c              |   16 +-
 drivers/net/phy/phy-core.c                    |   14 -
 drivers/net/phy/phy_device.c                  |  218 ++-
 drivers/net/phy/qca807x.c                     | 1232 +++++++++++++++++
 include/dt-bindings/net/qcom-qca807x.h        |   45 +
 include/linux/phy.h                           |  178 ++-
 18 files changed, 2119 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qca807x.c
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

-- 
2.40.1

