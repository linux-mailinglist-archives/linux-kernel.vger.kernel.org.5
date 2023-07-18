Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A577576EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGRInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjGRIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:42:59 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F1A6;
        Tue, 18 Jul 2023 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689669770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvBHRW1hX7jSHUc5Dd1yf8Vt754q3/Qv7wxhKNRg9lU=;
        b=maEuuMJ23VwXgPP1BYNWDWH9FoDi8ssbRkcHwVHdHZ+2liVDNNtSFXoi/Ucm7tD8fFcWkz
        Y1+1pyzlgXX8KdYt9Wa7GKYCY48VbAbD6BnoH3PHwrKdfGz5uVVGeT1MlJH1yeEkON6JDi
        BIcoju3Ka9xM3kidK/COzZ4sCOkXIp0=
Message-ID: <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Date:   Tue, 18 Jul 2023 10:42:47 +0200
In-Reply-To: <ZLZDL27zzDpY4q8E@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
         <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
         <ZLZDL27zzDpY4q8E@orome>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Le mardi 18 juillet 2023 =C3=A0 09:45 +0200, Thierry Reding a =C3=A9crit=C2=
=A0:
> On Mon, Jul 17, 2023 at 09:14:12PM +0200, Paul Cercueil wrote:
> > Hi Andy,
> >=20
> > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9cr=
it=C2=A0:
> > > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > > switch the driver to use it instead of open coded variant.
> > >=20
> > > Signed-off-by: Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>
> > > ---
> > > =C2=A0drivers/pinctrl/tegra/pinctrl-tegra.c | 5 +----
> > > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > index 4547cf66d03b..734c71ef005b 100644
> > > --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > @@ -747,10 +747,7 @@ static int tegra_pinctrl_resume(struct
> > > device
> > > *dev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0}
> > > =C2=A0
> > > -const struct dev_pm_ops tegra_pinctrl_pm =3D {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D &tegra_=
pinctrl_suspend,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D &tegra_p=
inctrl_resume
> > > -};
> > > +DEFINE_NOIRQ_DEV_PM_OPS(tegra_pinctrl_pm, tegra_pinctrl_suspend,
> > > tegra_pinctrl_resume);
> > > =C2=A0
> > > =C2=A0static bool tegra_pinctrl_gpio_node_has_range(struct tegra_pmx
> > > *pmx)
> > > =C2=A0{
> >=20
> > Another driver where using EXPORT_GPL_DEV_PM_OPS() would make more
> > sense.
>=20
> We don't currently export these PM ops because none of the Tegra
> pinctrl
> drivers can be built as a module.

This doesn't change anything. You'd want to use EXPORT_GPL_DEV_PM_OPS
(or better, the namespaced version) so that the PM ops can be defined
in one file and referenced in another, while still having them garbage-
collected when CONFIG_PM is disabled.

Cheers,
-Paul
