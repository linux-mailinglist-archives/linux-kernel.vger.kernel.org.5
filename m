Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E1757E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjGRNsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjGRNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:48:34 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F948F;
        Tue, 18 Jul 2023 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689688111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KihHBXzQ5YscflwfpTqH3zKYKGvYlYBWepP0Q5n+rtU=;
        b=UNdTDGqa0OtoBQaI2l3ghDjFxpMFaBpM9l/Ykjhq7diTw50XCdiPIhpvvlr1SxESWzw6G6
        eKk/Z+BPbTVo1rMmomxkPZJtkaxvHfHzhBb4ZpemqpEKMHvEKSuxYE4JJxjQW1a4PGMsWH
        QtcsjXWqbehZKL69FjxVnejBKvKxNTE=
Message-ID: <ae93b34812c04e499fae93dde833422c78d86b63.camel@crapouillou.net>
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
Date:   Tue, 18 Jul 2023 15:48:27 +0200
In-Reply-To: <ZLaRlyzkqRLSqjQc@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
         <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
         <ZLZDL27zzDpY4q8E@orome>
         <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
         <ZLZ6amp5HKUbm5w3@orome>
         <8f32cb8377808a073b043e0adf3ccf5ae5a84c92.camel@crapouillou.net>
         <ZLaRlyzkqRLSqjQc@orome>
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

Le mardi 18 juillet 2023 =C3=A0 15:20 +0200, Thierry Reding a =C3=A9crit=C2=
=A0:
> On Tue, Jul 18, 2023 at 01:55:05PM +0200, Paul Cercueil wrote:
> > Le mardi 18 juillet 2023 =C3=A0 13:41 +0200, Thierry Reding a =C3=A9cri=
t=C2=A0:
> > > On Tue, Jul 18, 2023 at 10:42:47AM +0200, Paul Cercueil wrote:
> > > > Hi Thierry,
> > > >=20
> > > > Le mardi 18 juillet 2023 =C3=A0 09:45 +0200, Thierry Reding a
> > > > =C3=A9crit=C2=A0:
> > > > > On Mon, Jul 17, 2023 at 09:14:12PM +0200, Paul Cercueil
> > > > > wrote:
> > > > > > Hi Andy,
> > > > > >=20
> > > > > > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a
> > > > > > =C3=A9crit=C2=A0:
> > > > > > > Since pm.h provides a helper for system no-IRQ PM
> > > > > > > callbacks,
> > > > > > > switch the driver to use it instead of open coded
> > > > > > > variant.
> > > > > > >=20
> > > > > > > Signed-off-by: Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com>
> > > > > > > ---
> > > > > > > =C2=A0drivers/pinctrl/tegra/pinctrl-tegra.c | 5 +----
> > > > > > > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > > b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > > index 4547cf66d03b..734c71ef005b 100644
> > > > > > > --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > > +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > > @@ -747,10 +747,7 @@ static int
> > > > > > > tegra_pinctrl_resume(struct
> > > > > > > device
> > > > > > > *dev)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > > =C2=A0}
> > > > > > > =C2=A0
> > > > > > > -const struct dev_pm_ops tegra_pinctrl_pm =3D {
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D=
 &tegra_pinctrl_suspend,
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D =
&tegra_pinctrl_resume
> > > > > > > -};
> > > > > > > +DEFINE_NOIRQ_DEV_PM_OPS(tegra_pinctrl_pm,
> > > > > > > tegra_pinctrl_suspend,
> > > > > > > tegra_pinctrl_resume);
> > > > > > > =C2=A0
> > > > > > > =C2=A0static bool tegra_pinctrl_gpio_node_has_range(struct
> > > > > > > tegra_pmx
> > > > > > > *pmx)
> > > > > > > =C2=A0{
> > > > > >=20
> > > > > > Another driver where using EXPORT_GPL_DEV_PM_OPS() would
> > > > > > make
> > > > > > more
> > > > > > sense.
> > > > >=20
> > > > > We don't currently export these PM ops because none of the
> > > > > Tegra
> > > > > pinctrl
> > > > > drivers can be built as a module.
> > > >=20
> > > > This doesn't change anything. You'd want to use
> > > > EXPORT_GPL_DEV_PM_OPS
> > > > (or better, the namespaced version) so that the PM ops can be
> > > > defined
> > > > in one file and referenced in another, while still having them
> > > > garbage-
> > > > collected when CONFIG_PM is disabled.
> > >=20
> > > Looking at the definition of EXPORT_GPL_DEV_PM_OPS(), it will
> > > cause
> > > an
> > > EXPORT_SYMBOL_GPL() to be added. So there very well is a change.
> > > And
> > > it's a completely bogus change because no module is ever going to
> > > use
> > > that symbol. If we were to ever support building the pinctrl
> > > driver
> > > as
> > > a module, then this would perhaps make sense, but we don't.
> >=20
> > In this particular case the EXPORT_SYMBOL_GPL() isn't really
> > important,
> > the rest of EXPORT_GPL_DEV_PM_OPS() is.
> >=20
> > I don't think having a symbol exported it is a big deal, TBH, if
> > you
> > use the namespaced version. If you really don't want that, we need
> > a
> > version of EXPORT_GPL_DEV_PM_OPS() that doesn't export the symbol.
>=20
> I do think it's a big deal to export a symbol if there's no reason to
> do
> so.
>=20
> And please, can we stop adding these macros for every possible
> scenario?

Yes, as you can read from my other responses, I am not really keen on
having a multiplication of these macros.

> Maybe I'm just getting old, but I find it increasingly difficult to
> understand what all of these are supposed to be. I get that people
> want
> to get rid of boilerplate, but I think we need to more carefully
> balance
> boilerplate vs. simplicity.

The EXPORT_GPL_DEV_PM_OPS() macro does more than get rid of
boilerplate, it gets rid of dead code.

If we take this driver as an example, before the patch the
"tegra_pinctrl_pm" struct, as well as the "tegra_pinctrl_suspend" and
"tegra_pinctrl_resume" functions were always compiled in, even if
CONFIG_PM_SLEEP is disabled in the config.

The status-quo before the introduction of the new PM macros was to just
wrap the dev_pm_ops struct + callbacks with a #ifdef CONFIG_PM_SLEEP.
This was pretty bad as the code was then conditionally compiled. With
the new PM macros this code is always compiled, independently of any
Kconfig option; and thanks to that, bugs and regressions are
subsequently easier to catch.

Cheers,
-Paul

> I'm seeing the same thing with stuff like those mass conversions to
> atrocities like devm_platform_ioremap_resource() and
> devm_platform_get_and_ioremap_resource(). There's so much churn
> involved
> in getting those merged for usually saving a single line of code. And
> it's not even mass conversions, but people tend to send these as one
> patch per driver, which doesn't exactly help (except perhaps for
> patch
> statistics).
>=20
> Thierry

