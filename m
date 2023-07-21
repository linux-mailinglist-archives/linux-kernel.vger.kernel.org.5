Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2F75C4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGUKpk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 06:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGUKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:45:26 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27491BF7;
        Fri, 21 Jul 2023 03:45:24 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-50d897af77bso497219a12.1;
        Fri, 21 Jul 2023 03:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689936322; x=1690541122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8wJTVBT/3WAHQa2wXEwIaaZ8k9MULWPoI7qp0kxJXk=;
        b=e0mpR9DFb9ATh70/nKk94PUoRWgJVO6XM58MtwzQnWKh5MbI9nI4yXQXqPASbtUzsf
         fYUqarw9QHN+OT72u9QUFP0BMrg5oQ1LJxSG/dznr0gwKRpY/CMB/EbvdoIPXyfZotkq
         fvkS2lV/14AQK7xSVP6mumZkmsDzRXhnqSPCNL6GhEw1hEbrJt/8FJwHctOzm8fb79vL
         8SI+divs3kv2AWjYVm+E+99YGfpAIUc5QiUU/kyz4VGPwgbsVsaUHWxjbe7JCI/cqbyQ
         OHdByEwAcZfDqOCzuAEb+BjK31HYRWNqCNUBBWdY8CuXbvj/bAX5EHlxgV0h2AjQqfxz
         CKmQ==
X-Gm-Message-State: ABy/qLZ9iuAT8QIBaNPJ6dMpoD2ty9YkWEMs1HYXh9vuMBZ/Zl6sDrLw
        SlL+zLBtqYpTqanEJl9FRUx9/wkZNshnBaVox9U=
X-Google-Smtp-Source: APBJJlGTR98Wg1niPHUvEdRwLJkWx6ZLHdL0iuuk2pM2B7Twjw+C+B41NYMrkfG5Gog1cpc6MO+7IsZMPQ5Z62zq098=
X-Received: by 2002:a05:6402:4304:b0:51d:9a92:24f0 with SMTP id
 m4-20020a056402430400b0051d9a9224f0mr1557619edc.4.1689936322410; Fri, 21 Jul
 2023 03:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094641.77189-1-frank.li@vivo.com> <20230721094641.77189-2-frank.li@vivo.com>
In-Reply-To: <20230721094641.77189-2-frank.li@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jul 2023 12:45:11 +0200
Message-ID: <CAJZ5v0iB5arngPxxduafyZ+hbxqTRLXm_5iwNoEcQcqVyCdCYw@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:47 AM Yangtao Li <frank.li@vivo.com> wrote:
>
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
>
> And tglx point out that:
>
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>
>      519 messages total (there are probably more)
>
>      352 unique messages
>
>      323 unique messages after lower casing
>
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
>
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
>
>      The most useful one of all is: "could request wakeup irq: %d"
>
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
>
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
>
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
>
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

It is not clear to me what the purpose of sending these patches is.

Because the devm_request_threaded_irq_probe() definition is not there
in the current -rc kernels AFAICS, it looks like they are sent in
order to collect tags from people.  If so, there should be a cover
letter making that clear.

As it stands, it is also unclear how you want them to be merged.

Moreover, sending the series without patch [01/22] to linux-pm has not
been helpful.

Thanks!

> ---
>  drivers/thermal/sun8i_thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 195f3c5d0b38..a952804ff993 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -512,9 +512,9 @@ static int sun8i_ths_probe(struct platform_device *pdev)
>          * registered yet, we deffer the registration of the interrupt to
>          * the end.
>          */
> -       ret = devm_request_threaded_irq(dev, irq, NULL,
> -                                       sun8i_irq_thread,
> -                                       IRQF_ONESHOT, "ths", tmdev);
> +       ret = devm_request_threaded_irq_probe(dev, irq, NULL,
> +                                             sun8i_irq_thread,
> +                                             IRQF_ONESHOT, "ths", tmdev, NULL);
>         if (ret)
>                 return ret;
>
> --
> 2.39.0
>
