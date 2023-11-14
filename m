Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8567EAE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjKNKz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjKNKzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:55:55 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24411186;
        Tue, 14 Nov 2023 02:55:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32BA62000A;
        Tue, 14 Nov 2023 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699959348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uX1qAm3PoNBjcV71gubQoriGUAtfUipgUKlDAbAe2Og=;
        b=YyMEmwGcOAZb3/vG+C4mQhSrCpsNt1hxFFDhRqeN/3udwY0nnAIJsvavTcIDzJPmr1F1+K
        9ulvGXleLBQBazGSodrxSYe1X+1NxgGTGJuOC1R+9BaJfYyNUgBAKL+j03oV+E8ZVibXBu
        1UoJoMy9ANnL2keTWm6nwnFfwpvSF1tfyCOzcMtY3KT5oH+X2hqrKvY1AL4sqVkkNtcTxE
        YAejF1dUw3zZdOdtNKEPBEkgR40GL4lYN2Agk0p6RKHwShMvGMlHluEbenx8V37XOVfH66
        G03shzfxke5RnDyXFc1ecJQAfDepID1fMeBlutnhTrFwhLvRr7h8MyrxvqP1yw==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v3 0/8] net: qualcomm: ipqess: introduce Qualcomm IPQESS driver
Date:   Tue, 14 Nov 2023 11:55:50 +0100
Message-ID: <20231114105600.1012056-1-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is the 3rd iteration on the Qualcomm IPQ4019 Ethernet Switch Subsystem
driver. I made some patch separation mistakes in the v2, sorry about that.

Notable changes in v3:
 - Fixed formatting of 3/8.

Notable changes in v2:
 - Refactored the PSGMII calibration procedure to exclude
   PHY-model-specific code from the switch driver. Added two new callbacks
   to the phy_driver struct to enable PHY-agnostic calibration control from
   the MAC driver.
 - Modified the EDMA Ethernet driver to use page_pool for skb handling.
 - Refactored several qca8k-common.c functions to enable calling them from
   the IPQESS driver rather than reimplementing them.

The IPQ4019 SoC integrates a modified version of the QCA8K Ethernet switch.
One major difference with the original switch IP is that port tags are
passed to the integrated Ethernet controller out-of-band.

Previous DSA versions of this driver were rejected because they required
adding out-of-band tagging support to the DSA subsystem. Therefore, we
rewrote the driver as a pure switchdev module, which shares a common
backend library with the current QCA8K driver.

The main driver components are:
 - ipqess_switch.c which registers and configures the integrated switch
 - ipqess_port.c which creates net devices for each one of the front-facing
   ports.
 - ipqess_edma.c which handles the integrated EDMA Ethernet controller
   linked to the CPU port.
 - drivers/net/dsa/qca/qca8k-common.c which defines low-level ESS access
   methods common to this driver and the original DSA QCA8K driver.

Thanks to the people from Sartura for providing us hardware and working on
the base QCA8K driver, and to Maxime for his work on the EDMA code.

Best regards,

Romain

Romain Gantois (8):
  dt-bindings: net: Introduce the Qualcomm IPQESS Ethernet switch
  net: dsa: qca8k: Make the QCA8K hardware library available globally
  net: qualcomm: ipqess: introduce the Qualcomm IPQESS driver
  net: qualcomm: ipqess: Add Ethtool ops to IPQESS port netdevices
  net: qualcomm: ipqess: add bridge offloading features to the IPQESS
    driver
  net: phy: add calibration callbacks to phy_driver
  net: qualcomm: ipqess: add a PSGMII calibration procedure to the
    IPQESS driver
  ARM: dts: qcom: ipq4019: Add description for the IPQ4019 ESS EDMA and
    switch

 .../bindings/net/qcom,ipq4019-ess.yaml        |  152 ++
 MAINTAINERS                                   |    7 +
 .../boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi |   13 +
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      |   94 +
 drivers/net/dsa/qca/Kconfig                   |   10 +
 drivers/net/dsa/qca/Makefile                  |    5 +-
 drivers/net/dsa/qca/qca8k-8xxx.c              |   51 +-
 drivers/net/dsa/qca/qca8k-common.c            |  126 +-
 drivers/net/dsa/qca/qca8k-leds.c              |    2 +-
 drivers/net/ethernet/qualcomm/Kconfig         |   15 +
 drivers/net/ethernet/qualcomm/Makefile        |    2 +
 drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
 .../ethernet/qualcomm/ipqess/ipqess_calib.c   |  156 ++
 .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1195 ++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  488 +++++
 .../ethernet/qualcomm/ipqess/ipqess_ethtool.c |  245 +++
 .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++
 .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
 .../ethernet/qualcomm/ipqess/ipqess_port.c    | 1686 +++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |  102 +
 .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  533 ++++++
 .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   36 +
 .../net/dsa/qca => include/linux/dsa}/qca8k.h |   61 +-
 include/linux/phy.h                           |   28 +
 24 files changed, 5296 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
 rename {drivers/net/dsa/qca => include/linux/dsa}/qca8k.h (90%)

-- 
2.42.0

