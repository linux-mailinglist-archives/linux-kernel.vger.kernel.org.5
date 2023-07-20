Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8175B74A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGTTAS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 15:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGTTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:00:16 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228E1739;
        Thu, 20 Jul 2023 12:00:15 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5216cf475e9so325729a12.0;
        Thu, 20 Jul 2023 12:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879613; x=1690484413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifHxT1z6hiXEJ3OG+UDLq27GRDHcAHJm8XLdM1GHGAM=;
        b=I9L4B+sCZKVEeVPGotKZsoX7L7638sJA145/FYXyGfQSRudJ3QWlXWjY1lkR+JAoa7
         ahxGZR9iN1I8vaARCkVHhpSXnBhVuSuY5P70eK886Jtcj+ociPtLO76XavcNTQqscAnu
         mgYg27yfH4OtWSmr8+30ep5xKDF3gmICavrA3B1nHSNNAvJOljqKrypC1LfHV5/tS+hE
         iDyCZTtv1SgLBGXQ6FuxdrO2WlHuii1OkCAgTUObqDHnVbcOu/2QU9KBcJH+HehuBmsO
         QzxvTkQQrEiGEtbf+q1qALKsR3Q/s31KX1T50RBriXsvRHnwL6Lsfi0YQ3VsDw1FVz08
         2C2g==
X-Gm-Message-State: ABy/qLYcj9uMKkM6Wropxus4LWh5K+xyHtJefwrVmBXllcPZYWKd4Ys0
        fshxfKnMv8C4ggWFJfVmQg75YuHW3sqg/rLuoU0=
X-Google-Smtp-Source: APBJJlEnEO3zGpkZmjkvUh0XPmsJDERM4tmhfHj5H6iFn/o00COpAjnx9vtnIP+Yogzok+BZuamJs4bzUsjIpcDB0rY=
X-Received: by 2002:a17:906:530b:b0:993:eef2:5d53 with SMTP id
 h11-20020a170906530b00b00993eef25d53mr2631666ejo.0.1689879613338; Thu, 20 Jul
 2023 12:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com> <20230717172821.62827-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230717172821.62827-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 21:00:02 +0200
Message-ID: <CAJZ5v0j7FjmJytcRs-GPekxwsED-SC2KucDVa_tCoELLkRDPKg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 7:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> _DEFINE_DEV_PM_OPS() helps to define PM operations for the system sleep
> and/or runtime PM cases. Some of the existing users want to have _noirq()
> variants to be set. For that purpose introduce a new helper which sets
> up _noirq() callbacks to be set and struct dev_pm_ops be provided.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and please feel free to route this how you see fit.

> ---
>  include/linux/pm.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index badad7d11f4f..0f19af8d5493 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -448,6 +448,15 @@ const struct dev_pm_ops __maybe_unused name = { \
>         SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>  }
>
> +/*
> + * Use this if you want to have the suspend and resume callbacks be called
> + * with disabled IRQs.
> + */
> +#define DEFINE_NOIRQ_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +const struct dev_pm_ops name = { \
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +}
> +
>  #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
>  #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
>
> --
> 2.40.0.1.gaa8946217a0b
>
