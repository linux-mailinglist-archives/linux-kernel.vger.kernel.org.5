Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64184807843
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379123AbjLFS6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379144AbjLFS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:58:03 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B40D64;
        Wed,  6 Dec 2023 10:58:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73A46E0007;
        Wed,  6 Dec 2023 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701889086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUror6Zovej/o+q+rAuuqniKbeAQpbMhZQ2xAZRjM6U=;
        b=lHD4O3jig6uyxTqELk5Gy2q6UKohpFRsE0loQJ43ShLvd88HSx94xoiiTGs/uRgVUnSnez
        8cu6VRs3Bc/VAkroGIkOkx9fbvzCIv3jcTqU8EFnghax0EsXMsAIMLJBqJh5548qct7nuP
        0zGjX48NhCO/JSZdPX941pTH+Drg2G2PQT2NdNiuP6obdDMdnE/SCwyOoX8dugsFWoxEkW
        G6X86iVsJAQKLOh2dTdXXBf990JtCEf1J1ho8iqrHN4jzeQPQ69UtgJbEnUlYoDfub0nnD
        ErrJX/WnplCNXD/9Vmn6Bp9xQImfHXbO9aS7cI0YoUs4nSM9G8ESjvNBgeI5Tg==
Date:   Wed, 6 Dec 2023 19:58:02 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [RFC PATCH v2 5/8] net: pcs: add driver for MediaTek USXGMII
 PCS
Message-ID: <20231206195802.5d2562e7@device.home>
In-Reply-To: <ZXC2MFn7pVX/KNmJ@shell.armlinux.org.uk>
References: <cover.1701826319.git.daniel@makrotopia.org>
        <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
        <20231206105838.069ae288@device.home>
        <ZXC2MFn7pVX/KNmJ@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 17:58:08 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Dec 06, 2023 at 10:58:38AM +0100, Maxime Chevallier wrote:
> > On Wed, 6 Dec 2023 01:44:38 +0000
> > Daniel Golle <daniel@makrotopia.org> wrote:  
> > > +	/* Read USXGMII link status */
> > > +	state->link = FIELD_GET(RG_PCS_RX_LINK_STATUS,
> > > +				mtk_r32(mpcs, RG_PCS_RX_STATUS0));
> > > +
> > > +	/* Continuously repeat re-configuration sequence until link comes up */
> > > +	if (!state->link) {
> > > +		mtk_usxgmii_pcs_config(pcs, mpcs->neg_mode,
> > > +				       state->interface, NULL, false);
> > > +		return;  
> > 
> > .pcs_get_state() isn't called only for link state polling,but also when querying
> > the link state from ethtool, from phylink_ethtool_ksettings_get().
> > 
> > As mtk_usxgmii_pcs_config triggers a pcs reset and reconfiguration, won't this disrupt
> > the link ?   
> 
> Highly likely if there's a race, but note that mtk_usxgmii_pcs_config()
> only gets called if the link is *down*. I guess some IPs need a bit of
> kicking to work properly.
> 
Ah right that's true, it should be OK then.

Thanks,

Maxime
