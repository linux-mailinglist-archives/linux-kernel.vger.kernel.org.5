Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F187578D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjGRKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGRKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:04:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B28AC;
        Tue, 18 Jul 2023 03:04:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4vcJ6xtBz6D94M;
        Tue, 18 Jul 2023 18:01:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 11:04:52 +0100
Date:   Tue, 18 Jul 2023 11:04:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 04/10] pinctrl: intel: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <20230718110451.00001227@Huawei.com>
In-Reply-To: <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
        <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 20:28:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 5 +----
>  drivers/pinctrl/intel/pinctrl-intel.h | 9 ++-------
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 64c3e62b4348..40e45c4889ee 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -929,7 +929,7 @@ static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned int offset,
>   *
>   * Return: a GPIO offset, or negative error code if translation can't be done.
>   */
> -static __maybe_unused int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
> +static int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
>  {
>  	const struct intel_community *community;
>  	const struct intel_padgroup *padgrp;
> @@ -1488,7 +1488,6 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
>  	if (!communities)
>  		return -ENOMEM;
>  
> -
>  	for (i = 0; i < pctrl->ncommunities; i++) {
>  		struct intel_community *community = &pctrl->communities[i];
>  		u32 *intmask, *hostown;
> @@ -1712,7 +1711,6 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
>  }
>  EXPORT_SYMBOL_GPL(intel_pinctrl_get_soc_data);
>  
> -#ifdef CONFIG_PM_SLEEP
>  static bool __intel_gpio_is_direct_irq(u32 value)
>  {
>  	return (value & PADCFG0_GPIROUTIOXAPIC) && (value & PADCFG0_GPIOTXDIS) &&
> @@ -1913,7 +1911,6 @@ int intel_pinctrl_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
> -#endif

Can you check if this is successfully removed?  I think it won't be.
Not immediately obvious how to tidy that up given these are used
in a macro called from lots of drivers.

Maybe just leaving the ifdef is best we can do here.



>  
>  MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
>  MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
> index 1faf2ada480a..65b1699a2ed5 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.h
> +++ b/drivers/pinctrl/intel/pinctrl-intel.h
> @@ -255,15 +255,10 @@ struct intel_pinctrl {
>  int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
>  int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
>  
> -#ifdef CONFIG_PM_SLEEP
>  int intel_pinctrl_suspend_noirq(struct device *dev);
>  int intel_pinctrl_resume_noirq(struct device *dev);
> -#endif
>  
> -#define INTEL_PINCTRL_PM_OPS(_name)					\
> -const struct dev_pm_ops _name = {					\
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,	\
> -				      intel_pinctrl_resume_noirq)	\
> -}
> +#define INTEL_PINCTRL_PM_OPS(_name)								\
> +	DEFINE_NOIRQ_DEV_PM_OPS(_name, intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
>  
>  #endif /* PINCTRL_INTEL_H */

