Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B637E73E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjKIVvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjKIVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:51:18 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A14212;
        Thu,  9 Nov 2023 13:51:16 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1CvH-0003Tv-1d;
        Thu, 09 Nov 2023 21:50:47 +0000
Date:   Thu, 9 Nov 2023 21:50:43 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Daniel Golle <daniel@makrotopia.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH 0/8] Add support for 10G Ethernet SerDes on MT7988
Message-ID: <cover.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to add support for GMAC2 and GMAC3 of the MediaTek MT7988 SoC.
While the vendor SDK stuffs all this into their Ethernet driver, I've tried to
seperate things into a PHY driver, a PCS driver as well as changes to the
existing Ethernet and LynxI PCS driver.

                  +----------------+
+--------------+  |  USXGMII PCS   |   +------------------+
| Ethernet MAC +--+-------------+  +---+ PEXTP SerDes PHY |
+--------------+  |  SGMII PCS  |  |   +------------------+
                  +-------------+--+

Alltogether this allows using GMAC2 and GMAC3 with all possible interface modes,
including in-band-status if needed.

Daniel Golle (8):
  dt-bindings: phy: mediatek,xfi-pextp: add new bindings
  phy: add driver for MediaTek pextp 10GE SerDes PHY
  net: pcs: pcs-mtk-lynxi: use 2500Base-X without AN
  net: pcs: pcs-mtk-lynxi: allow calling with NULL advertising
  dt-bindings: net: pcs: add bindings for MediaTek USXGMII PCS
  net: pcs: add driver for MediaTek USXGMII PCS
  dt-bindings: net: mediatek,net: fix and complete mt7988-eth binding
  net: ethernet: mtk_eth_soc: add paths and SerDes modes for MT7988

 .../devicetree/bindings/net/mediatek,net.yaml | 171 ++++-
 .../bindings/net/pcs/mediatek,usxgmii.yaml    | 105 +++
 .../bindings/phy/mediatek,xfi-pextp.yaml      |  71 ++
 MAINTAINERS                                   |   3 +
 drivers/net/ethernet/mediatek/Kconfig         |  17 +
 drivers/net/ethernet/mediatek/mtk_eth_path.c  | 122 +++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 178 ++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 105 ++-
 drivers/net/pcs/Kconfig                       |  10 +
 drivers/net/pcs/Makefile                      |   1 +
 drivers/net/pcs/pcs-mtk-lynxi.c               |  38 +-
 drivers/net/pcs/pcs-mtk-usxgmii.c             | 688 ++++++++++++++++++
 drivers/phy/mediatek/Kconfig                  |  11 +
 drivers/phy/mediatek/Makefile                 |   1 +
 drivers/phy/mediatek/phy-mtk-pextp.c          | 355 +++++++++
 include/linux/pcs/pcs-mtk-usxgmii.h           |  18 +
 16 files changed, 1813 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
 create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-pextp.c
 create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h

-- 
2.42.1
