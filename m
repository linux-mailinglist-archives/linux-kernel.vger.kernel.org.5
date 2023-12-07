Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E28807CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjLGAHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjLGAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:07:35 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1ECC9;
        Wed,  6 Dec 2023 16:07:40 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rB1vB-0000Eb-3C;
        Thu, 07 Dec 2023 00:07:19 +0000
Date:   Thu, 7 Dec 2023 00:07:14 +0000
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
Subject: Re: [RFC PATCH v2 3/8] net: pcs: pcs-mtk-lynxi: add platform driver
 for MT7988
Message-ID: <ZXEMsugMy6_gPRRi@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <68bb81ac6bf99393c8de256f42e5715626590af8.1701826319.git.daniel@makrotopia.org>
 <ZXC0pq2C6iRmeF4B@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXC0pq2C6iRmeF4B@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:51:34PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 06, 2023 at 01:44:17AM +0000, Daniel Golle wrote:
> > +struct phylink_pcs *mtk_pcs_lynxi_select_pcs(struct device_node *np, phy_interface_t mode)
> > +{
> > +	struct platform_device *pdev;
> > +	struct mtk_pcs_lynxi *mpcs;
> > +
> > +	if (!np)
> > +		return NULL;
> > +
> > +	if (!of_device_is_available(np))
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	if (!of_match_node(mtk_pcs_lynxi_of_match, np))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	pdev = of_find_device_by_node(np);
> > +	if (!pdev || !platform_get_drvdata(pdev)) {
> > +		if (pdev)
> > +			put_device(&pdev->dev);
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +	}
> > +
> > +	mpcs = platform_get_drvdata(pdev);
> > +	put_device(&pdev->dev);
> > +
> > +	return &mpcs->pcs;
> > +}
> > +EXPORT_SYMBOL(mtk_pcs_lynxi_select_pcs);
> 
> If you're going to play games like this, then you must mark the driver
> with .suppress_bind_attrs = true to remove the bind/unbind attributes
> in userspace that could wreak havoc with the above - because there is
> _nothing_ that guarantees that the memory you're returning from this
> function will remain intact. Basically, it's racy.

Ack, I've set .suppress_bind_attrs = true in the usxgmii driver but
forgot to add it here.

> Also, I'm not sure I approve of using the "select_pcs" suffix (I
> haven't spotted _where_ you use this, but returning EPROBE_DEFER to
> phylink's mac_select_pcs() method doesn't do anything to defer any
> probe, so that's an entirely misleading error code.

EPROBE_DEFER is handled when the function is called by mtk_add_mac()
during probe of the Ethernet driver -- which we do want to postpone
in case the PCS hasn't been probed yet as at this point that's the
best we can do without adding lots of intrastructure to dynamically
attach the PCS later on...

But true, later the function is being called by mac_select_pcs() and
what ever it returns is returned to the caller of mac_select_pcs().
If you think it's better to return ENODEV (or EAGAIN?) I can change
that -- from what I could tell, the only error which receives special
handling by phylink is -EOPNOTSUPP, everything else just gets passed-
through to the callers.

> If we are going to have device drivers for PCS, then we need to
> seriously think about how we look up PCS and return the phylink_pcs
> pointer - and also how we handle the PCS device going away. None of
> that should be coded into _any_ PCS driver.

I agree -- just wasn't up to design and implement all that at once.
