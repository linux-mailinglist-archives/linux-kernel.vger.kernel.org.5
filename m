Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD458756CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGQTM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGQTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:12:57 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59D116;
        Mon, 17 Jul 2023 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689621174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjvSgydsLBAt+kJ9U/k9BFTw7JpoLGf2fEESmtZCfmw=;
        b=qeVCdSL1DB214zwLBzzpgW1NMPnfeFgV+Ul4yuE7BcFhqMCwo87py2QaHCdb3WJ1HVLVPR
        fkfBzWXAz4T9KH9iSCSzVhdwtSMTP+x2px4mS2rNi5fUY3UGIX3SJgUCiozeUlLvemRAVo
        SrkwqmTGB3bGFYaRrjrRbuvZxeZ7nGc=
Message-ID: <03592cf5d6854dd5e534e0416de946fd38e4380c.camel@crapouillou.net>
Subject: Re: [PATCH v2 09/10] pinctrl: renesas: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
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
Date:   Mon, 17 Jul 2023 21:12:51 +0200
In-Reply-To: <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
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
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/pinctrl/renesas/core.c | 16 +++++++---------
> =C2=A01 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/core.c
> b/drivers/pinctrl/renesas/core.c
> index 0c8d081da6a8..34232b016960 100644
> --- a/drivers/pinctrl/renesas/core.c
> +++ b/drivers/pinctrl/renesas/core.c
> @@ -649,7 +649,7 @@ static const struct of_device_id
> sh_pfc_of_table[] =3D {
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
> +#if defined(CONFIG_ARM_PSCI_FW)
> =C2=A0static void sh_pfc_nop_reg(struct sh_pfc *pfc, u32 reg, unsigned in=
t
> idx)
> =C2=A0{
> =C2=A0}
> @@ -732,15 +732,13 @@ static int sh_pfc_resume_noirq(struct device
> *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sh_pfc_walk_regs(pfc, sh_pfc_restore_reg);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> -
> -static const struct dev_pm_ops sh_pfc_pm=C2=A0 =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(=
sh_pfc_suspend_noirq,
> sh_pfc_resume_noirq)
> -};
> -#define DEV_PM_OPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sh_pfc_pm
> =C2=A0#else
> =C2=A0static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
> -#define DEV_PM_OPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL
> -#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
> +static int sh_pfc_suspend_noirq(struct device *dev) { return 0; }
> +static int sh_pfc_resume_noirq(struct device *dev) { return 0; }
> +#endif=C2=A0/* CONFIG_ARM_PSCI_FW */
> +
> +static DEFINE_NOIRQ_DEV_PM_OPS(sh_pfc_pm, sh_pfc_suspend_noirq,
> sh_pfc_resume_noirq);
> =C2=A0
> =C2=A0#ifdef DEBUG
> =C2=A0#define SH_PFC_MAX_REGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0300
> @@ -1418,7 +1416,7 @@ static struct platform_driver sh_pfc_driver =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=A0=3D DRV_NAME,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D of_match_ptr(sh_pfc_of_table),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.pm=C2=A0=C2=A0=C2=A0=C2=A0 =3D DEV_PM_OPS,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.pm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D pm_sleep_ptr(&sh_pfc=
_pm),

I think you could do:

.pm =3D IF_PTR(IS_ENABLED(CONFIG_ARM_PSCI_FW), pm_sleep_ptr(&sh_pfc_pm)),

Then you wouldn't need the #if defined(CONFIG_ARM_PSCI_FW) guard either
(as long as the code still compiles fine when that config option is
disabled), and you wouldn't need those dummy callbacks.

Cheers,
-Paul

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0};
> =C2=A0

