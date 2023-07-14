Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6994B7542F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjGNS7f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjGNS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:59:33 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC03585;
        Fri, 14 Jul 2023 11:59:31 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98273ae42d0so66495166b.0;
        Fri, 14 Jul 2023 11:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689361170; x=1691953170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7rxwrVXOI5HEGUU6bsJmY4hwO6zj3r23uL8AyTf01Q=;
        b=bw4UpuQfdTRSdgkDetYZtIRzArZg4mDELx5iiLwVl6m0dueEkikJdNU7xhwtCPTroj
         Gsgrrq26H8/bhjVAugwYJFFTo7SV/KlTAQYVlb3peRD2tMd8pSztsOpWmmBQWRP9v8Fu
         6K0KzQ9QACxtDPEa6TXCSepuoDrKnqmUs/z186Z7oGKAzIVk94ar6whMjB7O1JZmO24M
         BiBRbbkY6Vw7lNNkcIR25nGzR3bWhmOLm9Hrl8q0wYAirgxlgm54H1Jo4HVGucwcIACB
         KauzJ04ZZ6z5b66eKem2jDv0fyK6VnPMBs30hpJSChJCfkoc0M765fc+q2z+3aO67gZe
         mvCA==
X-Gm-Message-State: ABy/qLbVxFM5agP4Tj/jEqbTDIq/xy98FV08vSObZCNhF/KYUm1Lz43O
        x0ZhtfRWoiKAbDV8+kWKLPyk1EOh7dQvkGJCeq4=
X-Google-Smtp-Source: APBJJlGM5CC/r7eMDYqkpQeHNYDY72YactYVeNX51cE6Ppdm/CQ0AlzfTEzCq9yJqBBsMagjr0HGaRCvpaPEvH0aSOE=
X-Received: by 2002:a17:906:1c9:b0:987:6960:36c8 with SMTP id
 9-20020a17090601c900b00987696036c8mr40687ejj.7.1689361170348; Fri, 14 Jul
 2023 11:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230712093322.37322-1-frank.li@vivo.com> <20230712093322.37322-13-frank.li@vivo.com>
In-Reply-To: <20230712093322.37322-13-frank.li@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 20:59:19 +0200
Message-ID: <CAJZ5v0ixPUo1t8A4Qv7kAdxU3n7o4WxSFD0GyKom_ZJq_g2wtQ@mail.gmail.com>
Subject: Re: [PATCH 13/19] cpufreq: pcc-cpufreq: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:34 AM Yangtao Li <frank.li@vivo.com> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

or please let me know if you want me to pick ths up.

Thanks!

> ---
>  drivers/cpufreq/pcc-cpufreq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 73efbcf5513b..84fe37def0f1 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -608,22 +608,20 @@ static int __init pcc_cpufreq_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int pcc_cpufreq_remove(struct platform_device *pdev)
> +static void pcc_cpufreq_remove(struct platform_device *pdev)
>  {
>         cpufreq_unregister_driver(&pcc_cpufreq_driver);
>
>         pcc_clear_mapping();
>
>         free_percpu(pcc_cpu_info);
> -
> -       return 0;
>  }
>
>  static struct platform_driver pcc_cpufreq_platdrv = {
>         .driver = {
>                 .name   = "pcc-cpufreq",
>         },
> -       .remove         = pcc_cpufreq_remove,
> +       .remove_new     = pcc_cpufreq_remove,
>  };
>
>  static int __init pcc_cpufreq_init(void)
> --
> 2.39.0
>
