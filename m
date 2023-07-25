Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50025760449
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGYAvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGYAvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:51:35 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0611210F7;
        Mon, 24 Jul 2023 17:51:32 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qO6Ga-0004SA-10;
        Tue, 25 Jul 2023 00:51:08 +0000
Date:   Tue, 25 Jul 2023 01:51:00 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v6 0/8] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
Message-ID: <cover.1690246066.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT7988 SoC introduces a new version (3) of the NETSYS
block and comes with three instead of two MACs.

The first MAC can be internally connected to a built-in Gigabit
Ethernet switch with four 1000M/100M/10M twisted pair user ports.

The second MAC can be internally connected to a built-in 2500Base-T
Ethernet PHY.

There are two SerDes units which can be operated in USXGMII, 10GBase-(K)R,
5GBase-R, 2500Base-X, 1000Base-X or SGMII interface mode.

This series adds initial support for NETSYS v3 and the first MAC of the
MT7988 SoC connecting the built-in DSA switch.

The switch is supported since commit 110c18bfed414 ("net: dsa: mt7530:
introduce driver for MT7988 built-in switch").

Basic support for the 1000M/100M/10M built-in PHYs connected to the
switch ports is present since commit ("98c485eaf509b net: phy: add
driver for MediaTek SoC built-in GE PHYs").

Changes since v5:
  * Rebase again on current net-next tree

Changes since v4:
  * Rebase on current net-next tree

Changes since v3:
  * Set 'mediatek,infracfg = false;' in dt-bindings for those chips
    which do not require infracfg phandle.

Changes since v2:
  * Use version number instead of feature bits for NETSYS version
  * Remove unneeded check for NULL when calling mtk_pcs_lynxi_destroy
  * Reduce dt-bindings to what is actually needed at this point for
    the driver to work.

Daniel Golle (3):
  dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth
  dt-bindings: net: mediatek,net: add mt7988-eth binding
  net: ethernet: mtk_eth_soc: convert clock bitmap to u64

Lorenzo Bianconi (5):
  net: ethernet: mtk_eth_soc: add version in mtk_soc_data
  net: ethernet: mtk_eth_soc: increase MAX_DEVS to 3
  net: ethernet: mtk_eth_soc: rely on MTK_MAX_DEVS and remove
    MTK_MAC_COUNT
  net: ethernet: mtk_eth_soc: add NETSYS_V3 version support
  net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64

 .../devicetree/bindings/net/mediatek,net.yaml | 109 +++++++-
 drivers/net/ethernet/mediatek/mtk_eth_path.c  |  22 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 205 +++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 241 ++++++++++--------
 drivers/net/ethernet/mediatek/mtk_ppe.c       |  18 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |   2 +-
 drivers/net/ethernet/mediatek/mtk_wed.c       |   4 +-
 7 files changed, 399 insertions(+), 202 deletions(-)

-- 
2.41.0
