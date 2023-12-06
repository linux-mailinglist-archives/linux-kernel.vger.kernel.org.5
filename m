Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ADE8078F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442823AbjLFTwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379426AbjLFTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:52:44 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE74FA;
        Wed,  6 Dec 2023 11:52:49 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rAxwa-0007c0-2h;
        Wed, 06 Dec 2023 19:52:30 +0000
Date:   Wed, 6 Dec 2023 19:52:23 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH v2 8/8] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
Message-ID: <ZXDQ94Xh3gzL3IR9@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <3ccc33fa14310ab47e90ff8e6ce46f1562bb838e.1701826319.git.daniel@makrotopia.org>
 <ZXDDtmRklS6o994V@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXDDtmRklS6o994V@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 06:55:50PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 06, 2023 at 01:45:17AM +0000, Daniel Golle wrote:
> > @@ -516,6 +538,21 @@ static struct phylink_pcs *mtk_mac_select_pcs(struct phylink_config *config,
> >  	struct mtk_eth *eth = mac->hw;
> >  	unsigned int sid;
> >  
> > +	if (mtk_is_netsys_v3_or_greater(eth)) {
> > +		switch (interface) {
> > +		case PHY_INTERFACE_MODE_1000BASEX:
> > +		case PHY_INTERFACE_MODE_2500BASEX:
> > +		case PHY_INTERFACE_MODE_SGMII:
> > +			return mtk_pcs_lynxi_select_pcs(mac->sgmii_pcs_of_node, interface);
> > +		case PHY_INTERFACE_MODE_5GBASER:
> > +		case PHY_INTERFACE_MODE_10GBASER:
> > +		case PHY_INTERFACE_MODE_USXGMII:
> > +			return mtk_usxgmii_select_pcs(mac->usxgmii_pcs_of_node, interface);
> 
> From what I can see, neither of these two "select_pcs" methods that
> you're calling makes any use of the "interface" you pass to them.
> I'm not sure what they _could_ do with it either, given that what
> you're effectively doing here is getting the phylink_pcs structure from
> the driver, and each one only has a single phylink_pcs.

Yes, you are right, the interface parameter isn't used, I will drop
it from both mtk_*_select_pcs() prototypes.

In the long run we may want something like
struct phylink_pcs *of_pcs_get(struct device_node *np, phy_interface_t interface)
provided by a to-be-built drivers/net/pcs/core.c...
