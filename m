Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9ED757AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjGRLzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGRLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:55:12 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4171A5;
        Tue, 18 Jul 2023 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689681308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUcNwMpkRou4HoWP59j29IOth9JECxsyonqdKzM916o=;
        b=3Uf7/QWlCCH5tyFroVybd1Qgx2JU1l06CTuA9m3ghJn+G0lPlIIF/07/Hxm/ZxptzHo46Z
        h2OZUg6m/lQhQJIB6Il4yacDOBHUwVFFbI50WGHrQQU43CQxBY24dhU5MIPMJCetRF/jeH
        v8qQUt4kIp37e6JvSTUVskqe2fHxiMw=
Message-ID: <8f32cb8377808a073b043e0adf3ccf5ae5a84c92.camel@crapouillou.net>
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
Date:   Tue, 18 Jul 2023 13:55:05 +0200
In-Reply-To: <ZLZ6amp5HKUbm5w3@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
         <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
         <ZLZDL27zzDpY4q8E@orome>
         <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
         <ZLZ6amp5HKUbm5w3@orome>
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

Le mardi 18 juillet 2023 =C3=A0 13:41 +0200, Thierry Reding a =C3=A9crit=C2=
=A0:
> On Tue, Jul 18, 2023 at 10:42:47AM +0200, Paul Cercueil wrote:
> > Hi Thierry,
> >=20
> > Le mardi 18 juillet 2023 =C3=A0 09:45 +0200, Thierry Reding a =C3=A9cri=
t=C2=A0:
> > > On Mon, Jul 17, 2023 at 09:14:12PM +0200, Paul Cercueil wrote:
> > > > Hi Andy,
> > > >=20
> > > > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a
> > > > =C3=A9crit=C2=A0:
> > > > > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > > > > switch the driver to use it instead of open coded variant.
> > > > >=20
> > > > > Signed-off-by: Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com>
> > > > > ---
> > > > > =C2=A0drivers/pinctrl/tegra/pinctrl-tegra.c | 5 +----
> > > > > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > index 4547cf66d03b..734c71ef005b 100644
> > > > > --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > @@ -747,10 +747,7 @@ static int tegra_pinctrl_resume(struct
> > > > > device
> > > > > *dev)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > =C2=A0}
> > > > > =C2=A0
> > > > > -const struct dev_pm_ops tegra_pinctrl_pm =3D {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D &te=
gra_pinctrl_suspend,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D &teg=
ra_pinctrl_resume
> > > > > -};
> > > > > +DEFINE_NOIRQ_DEV_PM_OPS(tegra_pinctrl_pm,
> > > > > tegra_pinctrl_suspend,
> > > > > tegra_pinctrl_resume);
> > > > > =C2=A0
> > > > > =C2=A0static bool tegra_pinctrl_gpio_node_has_range(struct
> > > > > tegra_pmx
> > > > > *pmx)
> > > > > =C2=A0{
> > > >=20
> > > > Another driver where using EXPORT_GPL_DEV_PM_OPS() would make
> > > > more
> > > > sense.
> > >=20
> > > We don't currently export these PM ops because none of the Tegra
> > > pinctrl
> > > drivers can be built as a module.
> >=20
> > This doesn't change anything. You'd want to use
> > EXPORT_GPL_DEV_PM_OPS
> > (or better, the namespaced version) so that the PM ops can be
> > defined
> > in one file and referenced in another, while still having them
> > garbage-
> > collected when CONFIG_PM is disabled.
>=20
> Looking at the definition of EXPORT_GPL_DEV_PM_OPS(), it will cause
> an
> EXPORT_SYMBOL_GPL() to be added. So there very well is a change. And
> it's a completely bogus change because no module is ever going to use
> that symbol. If we were to ever support building the pinctrl driver
> as
> a module, then this would perhaps make sense, but we don't.

In this particular case the EXPORT_SYMBOL_GPL() isn't really important,
the rest of EXPORT_GPL_DEV_PM_OPS() is.

I don't think having a symbol exported it is a big deal, TBH, if you
use the namespaced version. If you really don't want that, we need a
version of EXPORT_GPL_DEV_PM_OPS() that doesn't export the symbol.

-Paul
