Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4347542F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjGNS5h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjGNS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:57:34 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7135AB;
        Fri, 14 Jul 2023 11:57:28 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98e2865e2f2so59477166b.0;
        Fri, 14 Jul 2023 11:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689361047; x=1689965847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWKbxFe0GUaCCcLpCxfwdswLDeX3/EHTR7UY3EDzKW8=;
        b=kv1X34RUWIgaHBaxgZjiEcT91r6GWrIL1wI1cuSsjDfmujWkCgCzXuu8FW0cig6/Dm
         KgE5b0q1uHTZizv/3g5QWjsSdZFjistmdYijM2g9G7Zt5WQ7MwI+CQfLA4u38Vm8R/g9
         sopbz5zJPve7ZTY505eNUE16kuNbHz8qUuL63BAPIKovziko2Cgi+Eln+hyFmPPT+bq+
         iRwsnfjEmG2sCtiiAYFJO0Fo7jOyAa6s9kH2QgVifp6lyu560K594PjqcrRkWB+WF1YM
         UxqH3G2xXF5Ws3KyzOdkZbyVPPhZIGzH1jrZXWYaxeIAbPmnso8jHK/uHFAkypJdZk2Q
         rYpQ==
X-Gm-Message-State: ABy/qLbt1c96i1rOcPZDkoP/Jp578VlwnzJD8GkOREGxC1wrn1ZsGVJd
        z9WaVF1tMLA1Ywvpi10wJ6p5zQ13K7Xrvzogavs=
X-Google-Smtp-Source: APBJJlEldMKcJNNl2LL1EEFkrP9GnJM6mIh2flPT4WEqAqcqOkvdf3iPbJByP7P2fTjGVi7Yjzjp1TN0BAdBkUBeDyI=
X-Received: by 2002:a17:906:739c:b0:988:815c:ba09 with SMTP id
 f28-20020a170906739c00b00988815cba09mr30755ejl.4.1689361046779; Fri, 14 Jul
 2023 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230712093322.37322-1-frank.li@vivo.com> <20230712093322.37322-17-frank.li@vivo.com>
In-Reply-To: <20230712093322.37322-17-frank.li@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 20:57:15 +0200
Message-ID: <CAJZ5v0iuyjSV9xcYAQHtVFYssGdDTYX5u2dZvVqKgUs8yLMPbg@mail.gmail.com>
Subject: Re: [PATCH 17/19] cpufreq: acpi: Convert to platform remove callback
 returning void
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

or please let me know if you want me to pick this up.

Thanks!

> ---
>  drivers/cpufreq/acpi-cpufreq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b2f05d27167e..37f1cdf46d29 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1011,22 +1011,20 @@ static int __init acpi_cpufreq_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int acpi_cpufreq_remove(struct platform_device *pdev)
> +static void acpi_cpufreq_remove(struct platform_device *pdev)
>  {
>         pr_debug("%s\n", __func__);
>
>         cpufreq_unregister_driver(&acpi_cpufreq_driver);
>
>         free_acpi_perf_data();
> -
> -       return 0;
>  }
>
>  static struct platform_driver acpi_cpufreq_platdrv = {
>         .driver = {
>                 .name   = "acpi-cpufreq",
>         },
> -       .remove         = acpi_cpufreq_remove,
> +       .remove_new     = acpi_cpufreq_remove,
>  };
>
>  static int __init acpi_cpufreq_init(void)
> --
> 2.39.0
>
