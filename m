Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D547F90BA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjKZBxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:53:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D0C6;
        Sat, 25 Nov 2023 17:53:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b397793aaso11005245e9.0;
        Sat, 25 Nov 2023 17:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963633; x=1701568433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZxXzgcsFa66c5DTc1V1SpwFIJNBC3WpXhfBHmJYop4=;
        b=YPz0iXiC/zijDmdGZbPgyzGACqJAMshiuIeznudECVJIlrHOmEZErKQ3MvoqHaj6sc
         QAyRYbe70d33aIULf/2CxCXQlS37DI86Uowx4fsN0z0dTIKpwjzMRZvG+bJRivxPHnG6
         DuUpY5f/Z/SuJIzbnIXfyMOgHeMGYmRL2BLNIX+pGOYUYM4b5Fowa1lb2QrrqEZY2WaF
         a2lpC2Sr6da3lwpwdABDIIg9f7eS1rJlYa8YevXw5xEM0aR2OoMotvHUJIcD5DRHDo3/
         /ZXjc+CuPT9V/vJmlDKJvtrnv9RLCYoUTKL6rOsuoue8IahVvz7w78AYuKPQIzJFl1Ow
         ew9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963633; x=1701568433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZxXzgcsFa66c5DTc1V1SpwFIJNBC3WpXhfBHmJYop4=;
        b=kpZZZewHWa1XHC+NQDbjaWGPvZYxZprO7mAypyrraJzus8sBpUXYoAcKbxbs1nVN4i
         /oRFvvW8qjrBXh9ARzhLuGQl4qwtsP5fH9jzkMXm6szlSR0D3tCoB4l0NNAQTxIWn/9f
         LEEaFZ14SryR0hMiORfCb+2IY5vF4vj9c+Bcsog3tyVRpqzRT++wlY1yzDwq9lQeEWdT
         jUSK6hruAQ6Tf07zjQTN5VUT5wDMH+Zb4dTWVnHhKeFFDJxEGmFwb6oalWmvU9nDcqTd
         9A0BQ+AY9Zkqw0svVkF1v041MEybKRKn/0ga1rKSQW/xXsVTvx9526MlROEpONRqbXWj
         +S0Q==
X-Gm-Message-State: AOJu0YyNb62FYsgY+Y9K8XP/V2u7V28M5gE1k2SZmM93TTzRxCHqjJs3
        Bj4Sk+Rd94gzOyxau+9puHk=
X-Google-Smtp-Source: AGHT+IF3zWcXt6J8ONHbVNqsmKNBZ78aaiUYHOj1FlStaqQ7aY4b1MwjHFFZQlrITxUlZaQzKLppnw==
X-Received: by 2002:a05:600c:4311:b0:40b:3de0:8e1a with SMTP id p17-20020a05600c431100b0040b3de08e1amr4388812wme.8.1700963633053;
        Sat, 25 Nov 2023 17:53:53 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm9875344wms.44.2023.11.25.17.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:53:52 -0800 (PST)
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next PATCH RFC v3 0/8] net: phy: Support DT PHY package
Date:   Sun, 26 Nov 2023 02:53:38 +0100
Message-Id: <20231126015346.25208-1-ansuelsmth@gmail.com>
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

This depends on another series for PHY package API change. [1]

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
            compatible = "ethernet-phy-package";
            #address-cells = <1>;
            #size-cells = <0>;

            reg = <0>;
            qcom,package-mode = "qsgmii";

            ethernet-phy@1 {
              reg = <1>;
            };

            phy4: ethernet-phy@4 {
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

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20231126003748.9600-1-ansuelsmth@gmail.com/

Changes v3:
- Add back compatible implementation
- Detach patch that can be handled separately (phy_package_mmd, 
  phy_package extended)
- Rework code to new simplified implementation with base addr + offset
- Improve documentation with additional info and description
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

Christian Marangi (6):
  dt-bindings: net: document ethernet PHY package nodes
  net: phy: add initial support for PHY package in DT
  net: phy: add support for shared priv data size for PHY package in DT
  net: phy: add support for driver specific PHY package probe/config
  dt-bindings: net: Document Qcom QCA807x PHY package
  net: phy: qca807x: Add support for configurable LED

Robert Marko (2):
  dt-bindings: net: add QCA807x PHY defines
  net: phy: add Qualcom QCA807x driver

 .../bindings/net/ethernet-phy-package.yaml    |   75 +
 .../devicetree/bindings/net/qcom,qca807x.yaml |  136 ++
 drivers/net/mdio/of_mdio.c                    |   68 +-
 drivers/net/phy/Kconfig                       |    7 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/mdio_bus.c                    |   35 +-
 drivers/net/phy/phy_device.c                  |   54 +
 drivers/net/phy/qca807x.c                     | 1315 +++++++++++++++++
 include/dt-bindings/net/qcom-qca807x.h        |   30 +
 include/linux/phy.h                           |   27 +
 10 files changed, 1719 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qca807x.c
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

-- 
2.40.1

