Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0F756DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjGQT4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGQT4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:56:47 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB2170D;
        Mon, 17 Jul 2023 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689623760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEo4GP83lIE+lgHyH0OgrfVUmqIaUGHnS8773OANhBk=;
        b=l0iyJWMpe6xSAJOeof6UhbOiLwEzGtfdQOenOHe7x1WEX87oLs/sqcILqWR/6F6vYNbyxW
        0jHoBbsL1LxSF1a8umousHQ+ObYLfz2FWrXHnM3il1OBsIaAXM+DyopoqtpVwrV8RDMkRz
        nihLU0iVibpyCgWAkHsF50Li29isdlU=
Message-ID: <8c66f79025ddd8388eeb9bdb3f0e789fe9f362d9.camel@crapouillou.net>
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
Date:   Mon, 17 Jul 2023 21:55:57 +0200
In-Reply-To: <CAHp75Vcjq9=Q2_fsGJ9oCw=WYR3p3ot_cNLiDJV93psNcXXHLw@mail.gmail.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
         <c47c26ba7ea5bcbdcbe1d001b6cc527cee6c7d03.camel@crapouillou.net>
         <CAHp75Vcjq9=Q2_fsGJ9oCw=WYR3p3ot_cNLiDJV93psNcXXHLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 17 juillet 2023 =C3=A0 22:33 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> On Mon, Jul 17, 2023 at 10:02=E2=80=AFPM Paul Cercueil <paul@crapouillou.=
net>
> wrote:
> > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9cr=
it :
>=20
> ...
>=20
> > Unrelated change.
>=20
> OK.
>=20
> ...
>=20
> > So the correct way to update this driver would be to have a
> > conditionally-exported dev_pm_ops structure:
> >=20
> > EXPORT_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops) =3D {
> > =C2=A0=C2=A0=C2=A0 NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noir=
q,
> > intel_pinctrl_resume_noirq),
> > };
>=20
> This looks ugly. I didn't know that EXPORT*PM_OPS designed that way,
> but it seems pm.h in such case needs EXPORT for NOIRQ case as well.

It's designed so that when CONFIG_PM is disabled, the dev_pm_ops is
garbage-collected along with all its callbacks.

I know it looks ugly, but we already have 4 variants (regular,
namespace, GPL, namespace + GPL), if we start to add macros for
specific use-cases then it will become bloated really quick.

And the "bloat" I'm trying to avoid here is the extreme expansion of
the API which makes it hard for people not familiar to the code to
understand what should be used and how.

> > Then your two callbacks can be "static" and without #ifdef guards.
> >=20
> > The resulting "intel_pinctrl_pm_ops" can be marked as "extern" in
> > the
> > pinctrl-intel.h without any guards, as long as it is only
> > referenced
> > with the pm_ptr() macro.
>=20
> I'm not sure I got this. Currently drivers do not have any guards.
> Moreover, the correct one for noirq is pm_sleep_ptr(), isn't it?
>=20

The EXPORT_*_DEV_PM_OPS() macros do export the "dev_pm_ops"
conditionally depending on CONFIG_PM. We could add variants that export
it conditionally depending on CONFIG_PM_SLEEP, but we're back at the
problem of adding bloat.

You could use pm_sleep_ptr() indeed, with the existing macros, with the
drawback that in the case where CONFIG_PM && !CONFIG_PM_SLEEP, the
dev_pm_ops + callbacks are compiled in but never referenced.

Cheers,
-Paul
