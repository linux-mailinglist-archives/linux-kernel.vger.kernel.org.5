Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4507756D06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGQTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:19:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8618D;
        Mon, 17 Jul 2023 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689621543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2cj6nzOloFnUedIE+sqlGYJXKAM8KXP3LA38uvlSgg=;
        b=aMum8ykNR3O1EyRf6APapE/nrm/XIgEfrpD8ayt6JjIYHc+ZXXuoLqyzwoTFi2PMsEbFo0
        8F9S9ZtTbKtbVAibRi4zQuAieo9ldUyxhzc5NMkbAJtj94tVSGeV2CfoYzoeBe1keU1UIX
        0eqds2sfP9zZWoHFmwgWgbxzA1/ATLA=
Message-ID: <a9c7064df30215878925206751a4017830938ede.camel@crapouillou.net>
Subject: Re: [PATCH v2 01/10] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
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
Date:   Mon, 17 Jul 2023 21:19:00 +0200
In-Reply-To: <20230717172821.62827-2-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-2-andriy.shevchenko@linux.intel.com>
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

Hi Andy,

Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> _DEFINE_DEV_PM_OPS() helps to define PM operations for the system
> sleep
> and/or runtime PM cases. Some of the existing users want to have
> _noirq()
> variants to be set. For that purpose introduce a new helper which
> sets
> up _noirq() callbacks to be set and struct dev_pm_ops be provided.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0include/linux/pm.h | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index badad7d11f4f..0f19af8d5493 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -448,6 +448,15 @@ const struct dev_pm_ops __maybe_unused name =3D {
> \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_RUNTIME_PM_OPS(suspen=
d_fn, resume_fn, idle_fn) \
> =C2=A0}
> =C2=A0
> +/*
> + * Use this if you want to have the suspend and resume callbacks be
> called
> + * with disabled IRQs.

with disabled IRQs -> with IRQs disabled?

I'm not really sure that we need this macro, but I don't really object
either. As long as it has callers I guess it's fine, I just don't want
<linux/pm.h> to become too bloated and confusing.

Anyway:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> + */
> +#define DEFINE_NOIRQ_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +const struct dev_pm_ops name =3D { \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NOIRQ_SYSTEM_SLEEP_PM_OPS(susp=
end_fn, resume_fn) \
> +}
> +
> =C2=A0#define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
> =C2=A0#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP),
> (_ptr))
> =C2=A0

