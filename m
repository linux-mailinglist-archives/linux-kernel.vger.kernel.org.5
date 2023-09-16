Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAA7A31E1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbjIPSZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjIPSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 14:25:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D010CE6;
        Sat, 16 Sep 2023 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xaTgqIRqEW118i1euHWPGl1GL4m7oLRslyef9vzxato=; b=cMTQ5S0H6ptadVHrLUVUPezYG0
        M/m9SP+CLoFdyO2PpoZEf5Ld6DB59iCsLWDck05pQLQDBzS050zVFVFDppfLyXkFDpX2nA+G/x10F
        nUyJ1hPFsUIrnBQ24CHqasjX/Mmqnqvy+Y41WlSNOFxP9Cuwx8cSG/nXTAtt95OQi03B8pkCatQpW
        hDgHmHJj/FNxOxFAcXuHdkTaBlcSxOnSvsDzlYQrEhoNkl4jAPPBvPbW03oCBYytNzrIyLiLEtZ+E
        hJLzXV137LRsaeX/ajGL72d+sO8izCz9F8L9Hl1Nmoq96ettQHwKEm3GOCVWkQHDKzYoVca2sdnQG
        x9Lo2Jyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38474)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qhZyG-0006uM-23;
        Sat, 16 Sep 2023 19:24:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qhZyA-00072B-OD; Sat, 16 Sep 2023 19:24:38 +0100
Date:   Sat, 16 Sep 2023 19:24:38 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
        ndesaulniers@google.com, nathan@kernel.org, trix@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
Message-ID: <ZQXy5pxPRN1QXQkq@shell.armlinux.org.uk>
References: <675b5abd8b40a71c177e9e4e4c92d2d6b1413b9b.1694527316.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675b5abd8b40a71c177e9e4e4c92d2d6b1413b9b.1694527316.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:54:40PM +0100, Daniel Golle wrote:
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

Why are you assigning state->interface?

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

Doesn't this make the assignment to state->link above irrelevant?

I need to spend a bit longer looking through this - it looks like there
are three levels of indirection in this now?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
