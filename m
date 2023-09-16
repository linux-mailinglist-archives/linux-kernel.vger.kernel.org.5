Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141D7A31CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjIPSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbjIPSBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 14:01:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205610B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 11:00:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076E2C433C9;
        Sat, 16 Sep 2023 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694887257;
        bh=ul1iN8HpVZcfnlmUiMzJEP8GTsDZxDc39Cq6k3T7vkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHz20afM1LmCRNkebPbf9s29aMmZW9a1MsveNhR4ElECGZYt4y2ot32wMfQ7DJmxP
         RyS6b7DTnRdVTRs9xunu9kmc8J73btGNDhqOxJWFJktx9OAZvUCB9FGs4gjbtgZrPx
         B3wphUdaYiVBRC6NQ8M+g12EzyZ5DO/keHftyoNAyhsPqFoHqGxQaXveEMPH0j2o75
         AAB1Gfb57lEPdMTXkZmsnIIJW0dr9+umSUntZiDeLqHRtBvHYtcaCGrtG+2ay5rRXI
         iU/aku6rsWuNM/eGXnQUAgjYC5cKKLg+LEI19vlpW7x0zZOOzJSSEoAFgySxbJqxui
         rC9PNTUnwBqyA==
Date:   Sat, 16 Sep 2023 20:00:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
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
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
        ndesaulniers@google.com, nathan@kernel.org, trix@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
Message-ID: <20230916180051.GH1125562@kernel.org>
References: <675b5abd8b40a71c177e9e4e4c92d2d6b1413b9b.1694527316.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675b5abd8b40a71c177e9e4e4c92d2d6b1413b9b.1694527316.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:54:40PM +0100, Daniel Golle wrote:
> MT7988 comes with a built-in 2.5G PHY as well as SerDes lanes to
> connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-R,
> 2500Base-X, 1000Base-X and Cisco SGMII interface modes.
> 
> Implement support for configuring for the new paths to SerDes interfaces
> and the internal 2.5G PHY.
> 
> Add USXGMII PCS driver for 10GBase-R, 5GBase-R and USXGMII mode, and
> setup the new PHYA on MT7988 to access the also still existing old
> LynxI PCS for 1000Base-X, 2500Base-X and Cisco SGMII interface modes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Changes since RFC v2:
>  * read PCS_RX_STATUS0 register to avoid bogus link-up
>    (recommended by mtk devs)
>  * use parenthese to fix evaluation order
>    (Simon Horman reported clang warning)
>  * fix allocation size of usxgmii_pcs
>    (Simon Horman reported Smatch warning)
>  * always set USXGMII_AN_ENABLE bit in USXGMII mode
>    (it's what the vendor driver does and USXGMII doesn't seem to work
>     at all otherwise, we may need to manually set rate matching registers
>     if we don't use AN, but this isn't implemented at this point)
> 
> Changes since initial RFC:
>  * set missing neg_mode = true for usxgmii pcs
>  * use phylink_decode_usxgmii_word instead of open coding
> 
>  drivers/net/ethernet/mediatek/Kconfig        |  16 +
>  drivers/net/ethernet/mediatek/Makefile       |   1 +
>  drivers/net/ethernet/mediatek/mtk_eth_path.c | 123 +++-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c  | 182 ++++-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h  | 232 +++++-
>  drivers/net/ethernet/mediatek/mtk_usxgmii.c  | 702 +++++++++++++++++++
>  6 files changed, 1225 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/net/ethernet/mediatek/mtk_usxgmii.c
> 
> diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
> index da0db417ab690..b942b4622d146 100644
> --- a/drivers/net/ethernet/mediatek/Kconfig
> +++ b/drivers/net/ethernet/mediatek/Kconfig
> @@ -25,6 +25,22 @@ config NET_MEDIATEK_SOC
>  	  This driver supports the gigabit ethernet MACs in the
>  	  MediaTek SoC family.
>  
> +config NET_MEDIATEK_SOC_USXGMII
> +	bool "Support USXGMII SerDes on MT7988"
> +	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
> +	def_bool NET_MEDIATEK_SOC != n
> +	help
> +	  Include support for 10GE SerDes which can be found on MT7988.
> +	  If this kernel should run on SoCs with 10 GBit/s Ethernet you
> +	  will need to select this option to use GMAC2 and GMAC3 with
> +	  external PHYs, SFP(+) cages in 10GBase-R, 5GBase-R or USXGMII
> +	  interface modes.
> +
> +	  Note that as the 2500Base-X/1000Base-X/Cisco SGMII SerDes PCS
> +	  unit (MediaTek LynxI) in MT7988 is connected via the new 10GE
> +	  SerDes, you will also need to select this option in case you
> +	  want to use any of those SerDes modes.
> +
>  config NET_MEDIATEK_STAR_EMAC
>  	tristate "MediaTek STAR Ethernet MAC support"
>  	select PHYLIB

...

> diff --git a/drivers/net/ethernet/mediatek/mtk_usxgmii.c b/drivers/net/ethernet/mediatek/mtk_usxgmii.c

...

> +static void mtk_usxgmii_pcs_get_state(struct phylink_pcs *pcs,
> +				      struct phylink_link_state *state)
> +{
> +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> +	struct mtk_eth *eth = mpcs->eth;
> +	struct mtk_mac *mac = eth->mac[mtk_xgmii2mac_id(eth, mpcs->id)];
> +	u32 val = 0;
> +
> +	regmap_read(mpcs->regmap, RG_PCS_AN_CTRL0, &val);
> +	if (FIELD_GET(USXGMII_AN_ENABLE, val)) {
> +		/* Refresh LPA by inverting LPA_LATCH */
> +		regmap_read(mpcs->regmap, RG_PCS_AN_STS0, &val);
> +		regmap_update_bits(mpcs->regmap, RG_PCS_AN_STS0,
> +				   USXGMII_LPA_LATCH,
> +				   !(val & USXGMII_LPA_LATCH));
> +
> +		regmap_read(mpcs->regmap, RG_PCS_AN_STS0, &val);
> +
> +		phylink_decode_usxgmii_word(state, FIELD_GET(USXGMII_PCS_AN_WORD,
> +							     val));
> +
> +		state->interface = mpcs->interface;
> +	} else {
> +		val = mtk_r32(mac->hw, MTK_XGMAC_STS(mac->id));
> +
> +		if (mac->id == MTK_GMAC2_ID)
> +			val >>= 16;
> +
> +		switch (FIELD_GET(MTK_USXGMII_PCS_MODE, val)) {
> +		case 0:
> +			state->speed = SPEED_10000;
> +			break;
> +		case 1:
> +			state->speed = SPEED_5000;
> +			break;
> +		case 2:
> +			state->speed = SPEED_2500;
> +			break;
> +		case 3:
> +			state->speed = SPEED_1000;
> +			break;
> +		}
> +
> +		state->interface = mpcs->interface;
> +		state->link = FIELD_GET(MTK_USXGMII_PCS_LINK, val);
> +		state->duplex = DUPLEX_FULL;
> +	}
> +
> +	/* Refresh USXGMII link status by toggling RG_PCS_RX_STATUS_UPDATE */
> +	regmap_set_bits(mpcs->regmap, RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE);
> +	ndelay(1020);
> +	regmap_clear_bits(mpcs->regmap, RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE);
> +	ndelay(1020);
> +
> +	/* Read USXGMII link status */
> +	regmap_read(mpcs->regmap, RG_PCS_RX_STATUS0, &val);
> +	state->link = state->link && FIELD_GET(RG_PCS_RX_LINK_STATUS, val);
> +
> +	/* Continuously repeat re-configuration sequence until link comes up */
> +	if (!state->link)
> +		mtk_usxgmii_pcs_config(pcs, mpcs->neg_mode,
> +				       state->interface, NULL, false);
> +}

Hi Daniel,

I feel that I'm missing something obvious, but with this patch applied,
when building with allmodconfig for both x86_64 and arm64 the build fails
reporting that RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE and
RG_PCS_RX_LINK_STATUS are undefined.

...
