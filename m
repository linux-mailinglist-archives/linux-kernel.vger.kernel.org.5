Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC33806B25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377347AbjLFJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377306AbjLFJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:58:41 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CFFFA;
        Wed,  6 Dec 2023 01:58:46 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BB97240008;
        Wed,  6 Dec 2023 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701856724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dasdfMtvb5/6F6Xl6tXdAQvmSib+B8MTu7AZcbGRRpI=;
        b=E4sSHAHNbk/P25tK9GlNW898yfNEPsTTCpuSOrvNg3FDLAQa5H2MB8BRBjjdZkmc8iyIaA
        b6odeZBloX3O6K431Gft6l8bCm/hcnvr2+z/XM6Lahwsh4AtTFk85mbSpf7X6rzHKvMVt6
        3umP9OEFpwaUVhEVEAcTVj0ieLjeJiNgKnvgJ0VctBblzzer+uzeuVxsOuDH5U9LF9cI2Q
        zzti/EjMfrFKZsIUnuinTx9zodpPb9o4h+HfB7PROhWn5RHP3LpKUYtFXinRhxwNKJWX1+
        /fEfRmLP4XlanmKXIT1XLFJfuEOYBwF14EvjJt38ClTdAVVQVxjpVi8R93acjg==
Date:   Wed, 6 Dec 2023 10:58:38 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
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
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH v2 5/8] net: pcs: add driver for MediaTek USXGMII
 PCS
Message-ID: <20231206105838.069ae288@device.home>
In-Reply-To: <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
        <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On Wed, 6 Dec 2023 01:44:38 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> create a wrapped PCS taking care of the components shared between the
> new USXGMII PCS and the legacy LynxI PCS.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

[...]

> +
> +static int mtk_usxgmii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				  phy_interface_t interface,
> +				  const unsigned long *advertising,
> +				  bool permit_pause_to_mac)
> +{
> +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> +	unsigned int an_ctrl = 0, link_timer = 0, xfi_mode = 0, adapt_mode = 0;
> +	bool mode_changed = false;

Reverse christmas tree ordering can be used here (longest lines first)

> +
> +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
> +		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0x1FF) | USXGMII_AN_ENABLE;
> +		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x7B) |
> +			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x7B) |
> +			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x7B);
> +		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_MODE_10G) |
> +			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_MODE_10G);
> +	} else if (interface == PHY_INTERFACE_MODE_10GBASER) {
> +		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0x1FF);
> +		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x7B) |
> +			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x7B) |
> +			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x7B);
> +		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_MODE_10G) |
> +			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_MODE_10G);
> +		adapt_mode = USXGMII_RATE_UPDATE_MODE;
> +	} else if (interface == PHY_INTERFACE_MODE_5GBASER) {
> +		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0xFF);
> +		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x3D) |
> +			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x3D) |
> +			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x3D);
> +		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_MODE_5G) |
> +			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_MODE_5G);
> +		adapt_mode = USXGMII_RATE_UPDATE_MODE;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	adapt_mode |= FIELD_PREP(USXGMII_RATE_ADAPT_MODE, USXGMII_RATE_ADAPT_MODE_X1);
> +
> +	if (mpcs->interface != interface) {
> +		mpcs->interface = interface;
> +		mode_changed = true;
> +	}
> +
> +	mtk_usxgmii_reset(mpcs);
> +
> +	/* Setup USXGMII AN ctrl */
> +	mtk_m32(mpcs, RG_PCS_AN_CTRL0,
> +		USXGMII_AN_SYNC_CNT | USXGMII_AN_ENABLE,
> +		an_ctrl);
> +
> +	mtk_m32(mpcs, RG_PCS_AN_CTRL2,
> +		USXGMII_LINK_TIMER_IDLE_DETECT |
> +		USXGMII_LINK_TIMER_COMP_ACK_DETECT |
> +		USXGMII_LINK_TIMER_AN_RESTART,
> +		link_timer);
> +
> +	mpcs->neg_mode = neg_mode;
> +
> +	/* Gated MAC CK */
> +	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
> +		USXGMII_MAC_CK_GATED, USXGMII_MAC_CK_GATED);
> +
> +	/* Enable interface force mode */
> +	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
> +		USXGMII_IF_FORCE_EN, USXGMII_IF_FORCE_EN);
> +
> +	/* Setup USXGMII adapt mode */
> +	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
> +		USXGMII_RATE_UPDATE_MODE | USXGMII_RATE_ADAPT_MODE,
> +		adapt_mode);
> +
> +	/* Setup USXGMII speed */
> +	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
> +		USXGMII_XFI_RX_MODE | USXGMII_XFI_TX_MODE,
> +		xfi_mode);
> +
> +	usleep_range(1, 10);
> +
> +	/* Un-gated MAC CK */
> +	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1, USXGMII_MAC_CK_GATED, 0);
> +
> +	usleep_range(1, 10);
> +
> +	/* Disable interface force mode for the AN mode */
> +	if (an_ctrl & USXGMII_AN_ENABLE)
> +		mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1, USXGMII_IF_FORCE_EN, 0);
> +
> +	return mode_changed;
> +}
> +

[...]

> +static void mtk_usxgmii_pcs_get_state(struct phylink_pcs *pcs,
> +				      struct phylink_link_state *state)
> +{
> +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> +
> +	/* Refresh USXGMII link status by toggling RG_PCS_AN_STATUS_UPDATE */
> +	mtk_m32(mpcs, RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE,
> +		RG_PCS_RX_STATUS_UPDATE);
> +	ndelay(1020);
> +	mtk_m32(mpcs, RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE, 0);
> +	ndelay(1020);
> +
> +	/* Read USXGMII link status */
> +	state->link = FIELD_GET(RG_PCS_RX_LINK_STATUS,
> +				mtk_r32(mpcs, RG_PCS_RX_STATUS0));
> +
> +	/* Continuously repeat re-configuration sequence until link comes up */
> +	if (!state->link) {
> +		mtk_usxgmii_pcs_config(pcs, mpcs->neg_mode,
> +				       state->interface, NULL, false);
> +		return;

.pcs_get_state() isn't called only for link state polling,but also when querying
the link state from ethtool, from phylink_ethtool_ksettings_get().

As mtk_usxgmii_pcs_config triggers a pcs reset and reconfiguration, won't this disrupt
the link ? 

Thanks,

Maxime
