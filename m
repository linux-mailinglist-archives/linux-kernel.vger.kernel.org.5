Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2878A01F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjH0QJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjH0QJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:09:33 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4193B2;
        Sun, 27 Aug 2023 09:09:29 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qaIK7-0006yH-1d;
        Sun, 27 Aug 2023 16:09:11 +0000
Date:   Sun, 27 Aug 2023 17:09:02 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2] net: ethernet: mtk_eth_soc: add paths
 and SerDes modes for MT7988
Message-ID: <ZOt1Hp7v1tKRNGgX@makrotopia.org>
References: <8b05b606aa37cd30445b8a6d73caef1b0d0cfbfa.1692908556.git.daniel@makrotopia.org>
 <20230827153523.GS3523530@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827153523.GS3523530@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

thank you for reviewing!

On Sun, Aug 27, 2023 at 05:35:23PM +0200, Simon Horman wrote:
> On Thu, Aug 24, 2023 at 09:24:48PM +0100, Daniel Golle wrote:
> > MT7988 comes with a built-in 2.5G PHY as well as SerDes lanes to
> > connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-R,
> > 2500Base-X, 1000Base-X and Cisco SGMII interface modes.
> > 
> > Implement support for configuring for the new paths to SerDes interfaces
> > and the internal 2.5G PHY.
> > 
> > Add USXGMII PCS driver for 10GBase-R, 5GBase-R and USXGMII mode, and
> > setup the new PHYA on MT7988 to access the also still existing old
> > LynxI PCS for 1000Base-X, 2500Base-X and Cisco SGMII PCS interface
> > modes.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Hi Daniel,
> 
> some minor feedback from my side.
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_usxgmii.c b/drivers/net/ethernet/mediatek/mtk_usxgmii.c
> 
> ...
> 
> > +static int mtk_usxgmii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> > +				  phy_interface_t interface,
> > +				  const unsigned long *advertising,
> > +				  bool permit_pause_to_mac)
> > +{
> > +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> > +	struct mtk_eth *eth = mpcs->eth;
> > +	struct regmap *pextp = eth->regmap_pextp[mpcs->id];
> > +	unsigned int an_ctrl = 0, link_timer = 0, xfi_mode = 0, adapt_mode = 0;
> > +	bool mode_changed = false;
> > +
> > +	if (!pextp)
> > +		return -ENODEV;
> > +
> > +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
> > +		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0x1FF) |
> > +			  (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) ?
> > +			  USXGMII_AN_ENABLE : 0;
> 
> clang-16 W=1 suggests using parentheses here:
> 
>  drivers/net/ethernet/mediatek/mtk_usxgmii.c:468:51: warning: operator '?:' has lower precedence than '|'; '|' will be evaluated first [-Wbitwise-conditional-parentheses]
>                            (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) ?
>                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>  drivers/net/ethernet/mediatek/mtk_usxgmii.c:468:51: note: place parentheses around the '|' expression to silence this warning
>                            (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) ?
>                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>  drivers/net/ethernet/mediatek/mtk_usxgmii.c:468:51: note: place parentheses around the '?:' expression to evaluate it first
>                            (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) ?
>                                                                         ^
>                            (

Yeah, I've seen that one coming up on patchwork as well, fixed it already in my
local tree.

> 
> > +		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x7B) |
> > +			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x7B) |
> > +			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x7B);
> > +		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_RX_MODE_10G) |
> > +			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_TX_MODE_10G);
> 
> ...
> 
> > +int mtk_usxgmii_init(struct mtk_eth *eth)
> > +{
> > +	struct device_node *r = eth->dev->of_node;
> > +	struct device *dev = eth->dev;
> > +	struct device_node *np;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < MTK_MAX_DEVS; i++) {
> > +		np = of_parse_phandle(r, "mediatek,usxgmiisys", i);
> > +		if (!np)
> > +			break;
> > +
> > +		eth->usxgmii_pcs[i] = devm_kzalloc(dev, sizeof(*eth->usxgmii_pcs), GFP_KERNEL);
> 
> Smatch warns that only 8 bytes are allocated, whereas 64 are needed.
> I think one more defference of the parameter to sizeof().
> 
> e.g.:
> 
> 		eth->usxgmii_pcs[i] = devm_kzalloc(dev,
> 						   sizeof(*eth->usxgmii_pcs[i]),
> 						   GFP_KERNEL);

Good catch, thank you! I will fix it.


> 
> > +		if (!eth->usxgmii_pcs[i])
> > +			return -ENOMEM;
> > +
> > +		eth->usxgmii_pcs[i]->id = i;
> > +		eth->usxgmii_pcs[i]->eth = eth;
> > +		eth->usxgmii_pcs[i]->regmap = syscon_node_to_regmap(np);
> > +		if (IS_ERR(eth->usxgmii_pcs[i]->regmap))
> > +			return PTR_ERR(eth->usxgmii_pcs[i]->regmap);
> > +
> > +		eth->usxgmii_pcs[i]->pcs.ops = &mtk_usxgmii_pcs_ops;
> > +		eth->usxgmii_pcs[i]->pcs.poll = true;
> > +		eth->usxgmii_pcs[i]->pcs.neg_mode = true;
> > +		eth->usxgmii_pcs[i]->interface = PHY_INTERFACE_MODE_NA;
> > +		eth->usxgmii_pcs[i]->neg_mode = -1;
> > +
> > +		of_node_put(np);
> > +	}
> 
> ...
> 
