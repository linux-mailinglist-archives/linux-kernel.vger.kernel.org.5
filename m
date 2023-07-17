Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4615C756DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjGQT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjGQT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:57:30 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5AF1B3;
        Mon, 17 Jul 2023 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689623821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLbtiM3Mg2ozARpSTeCbg9ZzYZDLdqZM0J85vmoD7SM=;
        b=wmzyKuhBLBCQrGjJqR3U+7snGQXMWADygmSKRYXKPpLXpiIILjUaJXc/cQwu3akJM/sgMi
        G5fwAxKthEkfhTtNEYo0NUzyvKSLXQUjEHg6jPYQU5bjP9hMkUDEgzSgJcSMgcCe1h1Gsv
        B9WmHBgwcHLSP6I2XCpK/+VG0owAMf8=
Message-ID: <7dc59ec83ceb6b7c101039570652fb9c8122d15a.camel@crapouillou.net>
Subject: Re: [PATCH v2 07/10] pinctrl: mediatek: Switch to use
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
Date:   Mon, 17 Jul 2023 21:56:59 +0200
In-Reply-To: <CAHp75VfSd6giH0Hvt4m_cai5+qhhBfMa6R0fDhzpN4U7WxYzSw@mail.gmail.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
         <f48a35d596694839665bc5883260cbae3ae01d9c.camel@crapouillou.net>
         <CAHp75VfSd6giH0Hvt4m_cai5+qhhBfMa6R0fDhzpN4U7WxYzSw@mail.gmail.com>
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

Le lundi 17 juillet 2023 =C3=A0 22:36 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> On Mon, Jul 17, 2023 at 10:07=E2=80=AFPM Paul Cercueil <paul@crapouillou.=
net>
> wrote:
> > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9cr=
it :
>=20
> ...
>=20
> > > +DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops,
> > > mtk_paris_suspend,
> > > mtk_paris_resume);
> >=20
> > It's a bit more work, but I think you should use
> > EXPORT_GPL_DEV_PM_OPS
> > (or even better, EXPORT_NS_GPL_DEV_PM_OPS) so that the dev_pm_ops
> > is
> > conditionally exported. All callers would have to be updated to use
> > pm_ptr().
>=20
> Why pm_ptr()? What did I miss?
> The rest is OK.
>=20

Or pm_sleep_ptr(). As I said in my answer to the other patch,
EXPORT_*_DEV_PM_OPS() currently only exports on CONFIG_PM, so it
doesn't really matter which one you use.

Cheers,
-Paul
