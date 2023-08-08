Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DDD774D69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjHHVyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHHVxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:53:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005526A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0465662AD4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 21:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B0DC433C7;
        Tue,  8 Aug 2023 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691531607;
        bh=I2xqrp9av+1xeJT8Kmq2kU10XMExkt2v69dFZYUIZpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l35dmb8PlbHycZIoyCvoxj32aEA07dxo3H4AogNszsGFgn5lJTPerJHn0A2LA5TC/
         7BfCFKemVVIQHwTTc+BKqvYGtVOe5WywBkjeTT2MqH2Eihs98M9yZv9ltkV2KApFo0
         scXN+es15O749bbRAuOxyQzpeHylaQXX9PuSLr8bSoyJjMa18fSsg+2nWp6yZaIlN0
         VM3hNDF9Afedopm5hrhoU1Y3SuhC88gX0XCIShnoeEvmj6Vg2JVOTGByIRfakF5QN/
         mhCUvJYWo0xTGzc3WkTvHefTQSTrnatVsrK7kt7vJHdH9rWIV11KLGxYEpiUvMb8QE
         0StOPVuV+2JIg==
Date:   Tue, 8 Aug 2023 14:53:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <20230808145325.343c5098@kernel.org>
In-Reply-To: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 09:17:57 +0200 Uwe Kleine-K=C3=B6nig wrote:
> Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
> WoL at least on PHYs covered by the marvell driver. So skip disabling
> irqs on shutdown if WoL is enabled.
>=20
> While at it also explain the motivation that irqs are disabled at all.
>=20
> Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

What do we do with this one? It sounded like Russell was leaning
towards a revert?

FTR original report:
https://lore.kernel.org/all/20230803181640.yzxsk2xphwryxww4@pengutronix.de/

> while I'm not sure that disabling interrupts is a good idea in general,
> this change at least should fix the WoL case. Note that this change is
> only compile tested as next doesn't boot on my test machine (because of
> https://git.kernel.org/linus/b3574f579ece24439c90e9a179742c61205fbcfa)
> and 6.1 (which is the other kernel I have running) doesn't know about
> .wol_enabled. I don't want to delay this fix until I bisected this new
> issue.
>=20
> Assuming this patch is eligible for backporting to stable, maybe point
> out that it depends on v6.5-rc1~163^2~286^2~2 ("net: phy: Allow drivers
> to always call into ->suspend()"). Didn't try to backport that.
>=20
> Best regards
> Uwe
>=20
>  drivers/net/phy/phy_device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 61921d4dbb13..6d1526bdd1d7 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3340,6 +3340,15 @@ static void phy_shutdown(struct device *dev)
>  	if (phydev->state =3D=3D PHY_READY || !phydev->attached_dev)
>  		return;
> =20
> +	/* Most phys signal WoL via the irq line. So for these irqs shouldn't be
> +	 * disabled.
> +	 */
> +	if (phydev->wol_enabled)
> +		return;
> +
> +	/* On shutdown disable irqs to prevent an irq storm on systems where the
> +	 * irq line is shared by several devices.
> +	 */
>  	phy_disable_interrupts(phydev);
>  }
> =20

