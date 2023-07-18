Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0D757E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjGRNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjGRNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:55:44 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1106BEA;
        Tue, 18 Jul 2023 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689688538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIIcx1SGAw9uYYN1avMxPsLqak5l24gEpGFmCR8wXQs=;
        b=MeGV0ommnDXY0bZLzz2aUDd3eORngKqqpm/czs4W5fC56SGEpuHkxL+e3H80XeL4olpT4w
        1ApOAoo+UVumdCRRcw4QCgk1bWX8vFzXQhxjA1hdPhx0ybjBisPaXhX4AezSFzKDJcy2CL
        4umq/NBxiWzrvybq7Sv34wmBua/EBa4=
Message-ID: <d674ed791e4e7a71b671d1a66a03796cd6867fde.camel@crapouillou.net>
Subject: Re: [PATCH v2 04/10] pinctrl: intel: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Date:   Tue, 18 Jul 2023 15:55:35 +0200
In-Reply-To: <CAHp75VdPNCvhVSeKESbd7VNVPa8GVXVnw04jaE4HMUjK_b8+dA@mail.gmail.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
         <c47c26ba7ea5bcbdcbe1d001b6cc527cee6c7d03.camel@crapouillou.net>
         <CAHp75Vcjq9=Q2_fsGJ9oCw=WYR3p3ot_cNLiDJV93psNcXXHLw@mail.gmail.com>
         <8c66f79025ddd8388eeb9bdb3f0e789fe9f362d9.camel@crapouillou.net>
         <CAHp75VdPNCvhVSeKESbd7VNVPa8GVXVnw04jaE4HMUjK_b8+dA@mail.gmail.com>
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

Hi Andy,

Le mardi 18 juillet 2023 =C3=A0 15:57 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> On Mon, Jul 17, 2023 at 10:56=E2=80=AFPM Paul Cercueil <paul@crapouillou.=
net>
> wrote:
> > Le lundi 17 juillet 2023 =C3=A0 22:33 +0300, Andy Shevchenko a =C3=A9cr=
it :
> > > On Mon, Jul 17, 2023 at 10:02=E2=80=AFPM Paul Cercueil
> > > <paul@crapouillou.net>
> > > wrote:
> > > > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=
=A9crit
> > > > :
>=20
> ...
>=20
> > > > So the correct way to update this driver would be to have a
> > > > conditionally-exported dev_pm_ops structure:
> > > >=20
> > > > EXPORT_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops) =3D {
> > > > =C2=A0=C2=A0=C2=A0 NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_=
noirq,
> > > > intel_pinctrl_resume_noirq),
> > > > };
> > >=20
> > > This looks ugly. I didn't know that EXPORT*PM_OPS designed that
> > > way,
> > > but it seems pm.h in such case needs EXPORT for NOIRQ case as
> > > well.
> >=20
> > It's designed so that when CONFIG_PM is disabled, the dev_pm_ops is
> > garbage-collected along with all its callbacks.
> >=20
> > I know it looks ugly, but we already have 4 variants (regular,
> > namespace, GPL, namespace + GPL), if we start to add macros for
> > specific use-cases then it will become bloated really quick.
>=20
> Maybe macros can be replaced / changed to make it scale?

If you have any ideas, then yes absolutely.

>=20
> > And the "bloat" I'm trying to avoid here is the extreme expansion
> > of
> > the API which makes it hard for people not familiar to the code to
> > understand what should be used and how.
>=20
> So far, based on the rest of the messages in the thread the
> EXPORT*PM_OPS() have the following issues:
> 1) do not scale (for variants with different scope we need new set of
> macros);
> 2) do not cover cases with pm_sleep_ptr();
> 3) export symbols in case when it's not needed.
>=20
> Am I right?

I think that's right yes.

>=20
> > > > Then your two callbacks can be "static" and without #ifdef
> > > > guards.
> > > >=20
> > > > The resulting "intel_pinctrl_pm_ops" can be marked as "extern"
> > > > in
> > > > the
> > > > pinctrl-intel.h without any guards, as long as it is only
> > > > referenced
> > > > with the pm_ptr() macro.
> > >=20
> > > I'm not sure I got this. Currently drivers do not have any
> > > guards.
> > > Moreover, the correct one for noirq is pm_sleep_ptr(), isn't it?
> >=20
> > The EXPORT_*_DEV_PM_OPS() macros do export the "dev_pm_ops"
> > conditionally depending on CONFIG_PM. We could add variants that
> > export
> > it conditionally depending on CONFIG_PM_SLEEP, but we're back at
> > the
> > problem of adding bloat.
>=20
> Exactly.
>=20
> > You could use pm_sleep_ptr() indeed, with the existing macros, with
> > the
> > drawback that in the case where CONFIG_PM && !CONFIG_PM_SLEEP, the
> > dev_pm_ops + callbacks are compiled in but never referenced.
>=20
> And exactly.
>=20
> I don't think they are ready to use (in the current form). But let's
> see what we may do better here...

They were OK when Jonathan and myself were updating the IIO drivers -
but now they definitely show their limitations.

Cheers,
-Paul
