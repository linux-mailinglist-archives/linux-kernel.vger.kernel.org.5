Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2771F7F6528
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbjKWRTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345417AbjKWRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:18:57 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419ED65
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:02 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso1057226276.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759942; x=1701364742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRIUp/X6KH94V1dmHPajzonMFWyN0k2R15HuLH0rxE0=;
        b=vdH9/viMXZopA/i6o/AofO0nYc9zKPydxWYyd2rwmq8ZUjciWsFEoI0d7WgJGNh46I
         wLAiPyk0FSSoaorM7/J9G6ht4IGxBcj1y8mTYDbHgD6teYPf0OgWNBiCDLjg99ejs7u0
         IJU8+r22tPLpnFHpHRxbshaf5P0rKkNJAAR9jE+04zmL2WriT+YCbIOdf5WQoGMBTTq9
         ndsUQ1iNfvXHl8kB4ldnXFt3OLSRK7kDVECh4KhrdRft2qeP1xSLHmuaicjqauQCuNwW
         dIJ2QBwkGe+FVUcFyYW30m6F8FQxHdFGQzgikWDWHRqobJFIr9FGhBAZcyubXFszw4IG
         OAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759942; x=1701364742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRIUp/X6KH94V1dmHPajzonMFWyN0k2R15HuLH0rxE0=;
        b=EV7I1mB0rt3Dl6Cln0dNvl+aSrUbAt5qTwVEN4TNvvnSksrJ7uUWfiI59dsNNsbIdy
         1kE+2hTTtqZ/Ako8djlWFaRw1h26L+gGKqrMJ1EDlYeYuf157m2D14+xtY8vZ5Ce9p4v
         GBEPGZLXYrCasvNtDkgNbMRogqjsSIuJaQDoRGRj7LXVs+7Au1xlfnof3Ar3tYGfOvFk
         QuBHckijuJb5Ezxklxwoh9hBwSi7er/l+z5oBLMxJP1J+9TcdHIWBrUESS1gBD8MPgq7
         Sb3HH4TdfisWuLOOSF+tw4niI6p/NEGYe5fyN1cPmQkz78PRP1syT87gBSsLn9AewcN5
         RNRg==
X-Gm-Message-State: AOJu0Yx+J5OgA1PDVQpq0qH7PVXiSEJzaqq+6p9+flmri4IWBjxtG8f7
        HhZWIG+hRUjp6hstCGYjG0PTsB1USZRUw3ZXaY6rIDeNsJr3fjK8
X-Google-Smtp-Source: AGHT+IFXzKMZeuvW1BPKO8joBFVKPsKfpM2I/+f/wsTRT3THsVsSAwM69EGwF7PtesQFhk7BaXI4Y8hMBA/Tv2oP78c=
X-Received: by 2002:a25:3746:0:b0:da3:76d7:ddbf with SMTP id
 e67-20020a253746000000b00da376d7ddbfmr6099448yba.33.1700759941864; Thu, 23
 Nov 2023 09:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20231115083406.7368-1-wenchao.chen@unisoc.com>
In-Reply-To: <20231115083406.7368-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Nov 2023 18:18:26 +0100
Message-ID: <CAPDyKFqJmPEps7tSxuOnerFLohzaTFXjmDo+Mb8nGVODhNE0+A@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sprd: Fix vqmmc not shutting down after the card
 was pulled
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 09:34, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> With cat regulator_summary, we found that vqmmc was not shutting
> down after the card was pulled.
>
> cat /sys/kernel/debug/regulator/regulator_summary
> 1.before fix
> 1)Insert SD card
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2)Pull out the SD card
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2.after fix
> 1)Insert SD cardt
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2)Pull out the SD card
>  vddsdio                0    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  0                         0mA  3500mV  3600mV
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


>
> Change in v2:
> - Remove useless sdhci_sprd_signal_voltage_switch and power_mode.
> - Use mmc_regulator_get_supply in probe to prevent sdhci_setup_host
>   from powering up vqmmc.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6b84ba27e6ab..6b8a57e2d20f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -416,12 +416,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>         mmc_request_done(host->mmc, mrq);
>  }
>
> +static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
> +                                unsigned short vdd)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +
> +       switch (mode) {
> +       case MMC_POWER_OFF:
> +               mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
> +
> +               mmc_regulator_disable_vqmmc(mmc);
> +               break;
> +       case MMC_POWER_ON:
> +               mmc_regulator_enable_vqmmc(mmc);
> +               break;
> +       case MMC_POWER_UP:
> +               mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
> +               break;
> +       }
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
>         .write_w = sdhci_sprd_writew,
>         .write_b = sdhci_sprd_writeb,
>         .set_clock = sdhci_sprd_set_clock,
> +       .set_power = sdhci_sprd_set_power,
>         .get_max_clock = sdhci_sprd_get_max_clock,
>         .get_min_clock = sdhci_sprd_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
> @@ -823,6 +844,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>                          SDHCI_SUPPORT_DDR50);
>
> +       ret = mmc_regulator_get_supply(host->mmc);
> +       if (ret)
> +               goto pm_runtime_disable;
> +
>         ret = sdhci_setup_host(host);
>         if (ret)
>                 goto pm_runtime_disable;
> --
> 2.17.1
>
