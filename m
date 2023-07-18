Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F897574FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjGRHIV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjGRHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:08:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C91A6;
        Tue, 18 Jul 2023 00:08:11 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3FC7124E2E7;
        Tue, 18 Jul 2023 15:08:05 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 15:08:05 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 15:08:04 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>
CC:     Minda Chen <minda.chen@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] Add JH7110 MIPI DPHY RX support
Date:   Tue, 18 Jul 2023 00:08:01 -0700
Message-ID: <20230718070803.16660-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
It is used to transfer CSI camera data. The series has been tested on
the VisionFive 2 board.

This patchset should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20230629075115.11934-1-minda.chen@starfivetech.com/

changes since v6:
- Rebased on tag v6.4-rc6.

patch 2:
- Changed file name to "phy_jh7110_dphy_rx.c" follow the existing file
  naming rules.
- Changed Kconfig&Makefile follow the existing file rules.
- Add Author after Copyright follow the existing file rules.
- Changed MODULE_DESCRIPTION follow the existing file rules.

v6: https://lore.kernel.org/all/20230630093056.46904-1-changhuang.liang@starfivetech.com/

changes since v5:
- Rebased on tag v6.4.
- Dropped patch 3. Because it depends on the submission of others, it will be
  upstream separately later.

patch 1:
- Changed "pwrc_dphy" to "aon_syscon".
- Updated title and description.

patch 2:
- Dropped unnecessary register operations.
- Replaced "pm_runtime_get_sync" with "pm_runtime_resume_and_get".
- Dropped the pm reference on "regulator_enable" error handle.

v5: https://lore.kernel.org/all/20230529121503.3544-1-changhuang.liang@starfivetech.com/

changes since v4:
- Rebased on tag v6.4-rc2.

patch 1:
- Dropped "lane_maps" property.

patch 2:
- Added lane maps in compatible.

patch 3:
- Dropped "lane_maps" property.
- Changed "pwrc_dphy" to "aon_syscon".

v4: https://lore.kernel.org/all/20230412084540.295411-1-changhuang.liang@starfivetech.com/

changes since v3:
- Rebased on tag v6.3-rc4.

patch 1 & patch 3:
- Changed "starfive,aon-syscon" to "power-domains".
- Added "lane_maps" property.

patch 2:
- Changed "STF_DPHY_APBCFGSAIF__SYSCFG(x)" to "STF_DPHY_APBCFGSAIF_SYSCFG(x)".
- Merged phy_init into phy_power_on.
- Merged phy_exit into phy_power_off.
- Replaced syscon with power domain framework.
- Parsed "lane_maps" property form device tree.
- Dropped compatible private data.

v3: https://lore.kernel.org/all/20230315100421.133428-1-changhuang.liang@starfivetech.com/

changes since v2:
- Rebased on tag v6.3-rc1.

patch 1:
- Changed the 'Starfive' to 'StarFive'.
- Changed the "items" to "- items".
- Add description to clocks.

patch 2:
- Changed the 'Starfive' to 'StarFive'.
- Updated the driver order in MAINTAINERS.

patch 3:
- Changed the 'Starfive' to 'StarFive'.
- Update clocks&resets macros follow patchset [1].

v2: https://lore.kernel.org/all/20230223015952.201841-1-changhuang.liang@starfivetech.com/

changes since v1:
- Rebased on tag v6.2.
- Dropped patch 1, it will be added by the patch [2].

patch 1:
- Changed the node name 'dphy' to 'phy'.
- Changed the "starfive,aon-syscon" description.
- Changed the MIPI DPHY RX IP description.
- Add description to resets.
- Update devicetree binding examples.

patch 2:
- Changed the commit message.

patch 3:
- Changed the commit message.
- Changed the node name 'dphy' to 'phy'.
- Sorted the node by address.

v1: https://lore.kernel.org/all/20230210061713.6449-1-changhuang.liang@starfivetech.com/

Changhuang Liang (2):
  dt-bindings: phy: Add starfive,jh7110-dphy-rx
  phy: starfive: Add mipi dphy rx support

 .../bindings/phy/starfive,jh7110-dphy-rx.yaml |  71 ++++++
 MAINTAINERS                                   |   7 +
 drivers/phy/starfive/Kconfig                  |   9 +
 drivers/phy/starfive/Makefile                 |   5 +-
 drivers/phy/starfive/phy-jh7110-dphy-rx.c     | 232 ++++++++++++++++++
 5 files changed, 322 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-rx.c


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
prerequisite-patch-id: 6d585d462408a90a97b7cd7a4ee7fb9bdc287112
prerequisite-patch-id: 977d4f883a696ea56d30f1b20348d33b7e8c9ded
prerequisite-patch-id: bf7e042cedda9f58b9e80eab38b00819b58e3e03
prerequisite-patch-id: 76078ca6536392595191170665115ff5cd836750
prerequisite-patch-id: 0443acf52a2d14609502960d611207f2f715e146
prerequisite-patch-id: 8c735dffc6d5388a35a76b16e914a2f9722ad979
prerequisite-patch-id: 739028223ea0ab0a3a3b61df7ccb46b2c9d704ec
prerequisite-patch-id: 36e69700dfc0375b950b0e23086ed3b722cb84a4
prerequisite-patch-id: 2394fad7b98c991aeb1d7aa8768f85fb2d6e07bf
prerequisite-patch-id: 81f7c65712c4901a7a178ddcd98ffc55f3b473ff
prerequisite-patch-id: 05059f11b7b0e8dca6cf22782ff9e87bd5345a43
prerequisite-patch-id: 0159f09bb0a1ff711a00ae17ef5b12662c9c7d3d
prerequisite-patch-id: d5abfba63fc07ff97b5023911513c260bb7a53e1
prerequisite-patch-id: 64f486550e39c1f43f9555546b3f4bcc6edaee8e
prerequisite-patch-id: a387400b252f5064947ca98e860d6ff8537390d4
prerequisite-patch-id: a814c677c77c672e643b7383e8ad4ff53863a086
prerequisite-patch-id: 89f058e334644bad4414c7755cd7be2c9f193558
prerequisite-patch-id: aa6a7673a9b7af88988f5f933b3d60d17b5401a4
prerequisite-patch-id: 461e2e765ee974b050ed0cd8856cfcdbb21f7449
prerequisite-patch-id: d3fc0bca48b546ffac829ccdddbd9244d4c6c3b8
prerequisite-patch-id: ffe68ea172de27c31fa5e1c9834ad4bc817feb17
prerequisite-patch-id: 7061318e4ce479b4164ccf5c0876e6ef12f97af5
prerequisite-patch-id: fb0abb8eb7561829abef49d4ce85f6a88d2eac5b
prerequisite-patch-id: 4590f1ab508e1de53f38e041f72acf6697b86e43
prerequisite-patch-id: 8fbe91d635ccfb982dee0da2998806f427c3f728
prerequisite-patch-id: a226d30947a80ffcd2e7b2bd9a5447f42e52dc90
prerequisite-patch-id: 3af662de084917132f6908b314cb955716eff4e4
--
2.25.1
