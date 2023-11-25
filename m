Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E587F872E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjKYAfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKYAfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:35:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597E1739;
        Fri, 24 Nov 2023 16:35:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4079ed65471so18195865e9.1;
        Fri, 24 Nov 2023 16:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700872517; x=1701477317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gJ4dsCN4jAp0Z6B7bPy+5n1kCmEg5zx74BRyzkdzqY=;
        b=mI3gHBupx0YHxrwWjKumjVfCxqFu1IUNqrUD4mb6DuSBwePyTRtfEpzTQiX+GqVAIS
         QqntuKY3I5O2sZW7TezFnboTlH7lbDndObmaLNEVtdU3YlPsbWVLmwDr1jIMEOb5EUt2
         nWU/dcO4axu2BAAZkpUZAWnzkTW/qb3KTmOrJyWdYdRSx6agjjZwIeX23Zf1bRS8sB5t
         KtL2kwq1Bd9wg8J52awxx2OJDzcAVEzrh7YHjtlCmCQl1u7RVAe/2yZSyjQTgeU05V93
         u8xgYhUUV8/oZZJLmbu2Uvg3g9MEKN/dVM5KK1QmMPQZ6rVknREDpgNINbokuEOn4FPw
         w+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700872517; x=1701477317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gJ4dsCN4jAp0Z6B7bPy+5n1kCmEg5zx74BRyzkdzqY=;
        b=JWXDqXmJ3EryJUbvPO16nF+hssKv+/hFLNdjj5oonwh4NMXfoW3ESI2fwYOlNA+ryE
         UJwREOR53wwQjZm92BSwxbAhdOoStF2lV3dXJB6fWqZ7Ix8Ggmeh7sxZN37kkgB+MBJu
         TDiX8YhOCxCwB2VWLmbSgYYZns/H8ejI1eM7S1ndXp3iyfYu8LS7xxp2JNy8wV+2GtCk
         9Lu/q5GyB4hOTjMNCHCt9N4QGK4STtTO0qjdOxYL/7Q/iSHHAqkDYe8txyoUgy+wjmSx
         hJ9gXvA9o4FHymjplDmrCUdCcHBIilQRkRRT8EjT+G6rvFyTAjEq2IUJv1QClcG2l9ED
         Ihkw==
X-Gm-Message-State: AOJu0YwKbenQCG3Hu+9QQ0P7uCqt8sSYWaRMRYBnRumZHYnAvuU2lFwC
        FsNvMrczZpUv3xl+cWnggzA=
X-Google-Smtp-Source: AGHT+IEynPKBI7IwnMHpc9o110PkJqJCiDc1zB8vkXfce7EMPEhPFPGlhNEmKHM/SQm8OexRWAI3Ag==
X-Received: by 2002:a05:600c:1914:b0:40b:3803:e4c6 with SMTP id j20-20020a05600c191400b0040b3803e4c6mr3641836wmq.8.1700872516754;
        Fri, 24 Nov 2023 16:35:16 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u13-20020a05600c00cd00b00405718cbeadsm4268005wmm.1.2023.11.24.16.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:35:16 -0800 (PST)
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
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH v2 00/11] net: phy: Support DT PHY package
Date:   Sat, 25 Nov 2023 01:11:16 +0100
Message-Id: <20231125001127.5674-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

        ethernet-phy-package@0 {
            #address-cells = <1>;
            #size-cells = <0>;

            reg = <0>;

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

I hope this implementation is clean enough as I expect more and more of
these configuration to appear in the future.

(For Andrew, we are looking intro making this in at803x PHY driver and see
what functions can be reused, idea is to move the driver to a dedicated
directory and create something like at803x-common.c as the at803x PHY
driver is too bloated and splitting it it's a better approach)

Changes v2:
- Drop compatible "ethernet-phy-package", use node name prefix matching
  instead
- Improve DT example
- Add reg for ethernet-phy-package
- Drop phy-mode for ethernet-phy-package
- Drop patch for generalization of phy-mode
- Drop global-phy property (handle internally to the PHY driver)
- Rework OF phy package code and PHY driver to handle base address
- Fix missing of_node_put
- Add some missing docs for added variables in struct
- Move some define from dt-bindings include to PHY driver
- Handle qsgmii validation in PHY driver
- Fix wrong include for gpiolib
- Drop reduntant version.h include

Christian Marangi (9):
  net: phy: extend PHY package API to support multiple global address
  dt-bindings: net: document ethernet PHY package nodes
  net: phy: add initial support for PHY package in DT
  net: phy: add support for shared priv data size for PHY package in DT
  net: phy: add support for driver specific PHY package probe/config
  net: phy: move mmd_phy_indirect to generic header
  net: phy: add support for PHY package MMD read/write
  dt-bindings: net: Document Qcom QCA807x PHY package
  net: phy: qca807x: Add support for configurable LED

Robert Marko (2):
  dt-bindings: net: add QCA807x PHY defines
  net: phy: add Qualcom QCA807x driver

 .../bindings/net/ethernet-phy-package.yaml    |   66 +
 .../devicetree/bindings/net/qcom,qca807x.yaml |  148 ++
 drivers/net/mdio/of_mdio.c                    |   68 +-
 drivers/net/phy/Kconfig                       |    7 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/bcm54140.c                    |   23 +-
 drivers/net/phy/mdio_bus.c                    |   35 +-
 drivers/net/phy/mediatek-ge-soc.c             |   11 +-
 drivers/net/phy/micrel.c                      |   13 +-
 drivers/net/phy/mscc/mscc.h                   |    7 +
 drivers/net/phy/mscc/mscc_main.c              |   16 +-
 drivers/net/phy/phy-core.c                    |   14 -
 drivers/net/phy/phy_device.c                  |  165 +-
 drivers/net/phy/qca807x.c                     | 1324 +++++++++++++++++
 include/dt-bindings/net/qcom-qca807x.h        |   30 +
 include/linux/phy.h                           |  170 ++-
 16 files changed, 1996 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qca807x.c
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

-- 
2.40.1

