Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42D7E26C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjKFO0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKFO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:26:13 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D177BD51
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:26:09 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so3374980276.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699280768; x=1699885568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=clebCQm1+LBapUz3ORAAhgjPSPUNZu8n0M4MtoluA3A=;
        b=izHuTFs6nSpiQocOEUbAdQQKi4oY4J15jeSfl0MlKsXZYQKc3UrqoKx79JMsTyRgXx
         TOConcjbYjTFxxpn7hf+ldOklrF/hQoWLvvO+m58dP5TFGHPIMU0M75iANxJxJ7qRePf
         tGvJEcqQwO5LFClfAyMHBmD33Fe7mJDS/8xpFKqW2YeqIWaOq2ThySgTeCy+ws9Ld6LC
         kmC7S7vpxwQi2Lro8i5wxVi7IcGeXuJjOuXf7dQRelL2M5L5kff3g3RyuUCFyc9zZ0/6
         16l7YpiwykFe+maFkBB4c8N+GtrdazjpWEVtyApx5ORvZazBriQOP4vUihCn/CE9JqkR
         nppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280768; x=1699885568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clebCQm1+LBapUz3ORAAhgjPSPUNZu8n0M4MtoluA3A=;
        b=hsfyjJubGuIesfZ6OsxnkEG+sLD3ugebUo814hnGgVu6xJy3UKhJD8M+IGb11DsVfD
         EzdvxOvVdcyDv130R0YD4d5LIiVTwa2KwgMWAqbkYra8lKVPQdiAFWUQE23fA3sXToap
         SRMU7hQCJpQ4tgm7ZzOYvNzz8Abh2tOkMQ4Ta9eEf2ACCn+jDDklQWCMxXgoCMZyW1jH
         qrlLusXz0ue18RfF2H8ZVs1xH95Ml6mLguLrVD3HBMazLmr7vtNtqnMpDa0IwoRRgfiW
         hzWBUrAqp7JTnd7WKzzr5uGBMlThTEKHwIAMlLdrxkCr/K0s2SywcEN97zrfXbnKR++k
         PzBw==
X-Gm-Message-State: AOJu0YwLzKPxZvWj1XuxNFNjsmUxHnE2VwlP886liEl5Gt5lVS80CMkZ
        PlzHBAwJrISb/7EJ9+WuT36gg/x0LJ6R7scxCE2v3A==
X-Google-Smtp-Source: AGHT+IF5BH9O6Ws3yKpEkBHytetsUIpUzn9flJjQzqMC5RNQD4AQcnOdSNKrmQ5eAT0CoDKg5+dINR8k2R6zA+yCKi4=
X-Received: by 2002:a25:db11:0:b0:da0:4c63:f648 with SMTP id
 g17-20020a25db11000000b00da04c63f648mr28557922ybf.6.1699280768250; Mon, 06
 Nov 2023 06:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20231106104018.29179-1-wenchao.chen@unisoc.com>
In-Reply-To: <20231106104018.29179-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 15:25:32 +0100
Message-ID: <CAPDyKFrJ=hGbeQzAHwk1KA_Wn=W7oVFy56V6kCisb_BkXRq7ew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix the clock switch
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 11:40, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Some SOCs have a "1x_enable" clock that needs to be turned on and off
> in probe, remove and runtime pm.

Well, first of all, what is a "1x_enable" clock and why do we need it?

Moreover, the clock needs to be described as a part of the DT bindings
for the sdhci-sprd mmc controller. That said, it looks like the
binding for the sdhci-sprd controller needs to be converted to the
yaml format first, can you please have a look at that too?

>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sprd.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6b84ba27e6ab..3367f924dc5b 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -83,6 +83,7 @@ struct sdhci_sprd_host {
>         u32 version;
>         struct clk *clk_sdio;
>         struct clk *clk_enable;
> +       struct clk *clk_1x_enable;
>         struct clk *clk_2x_enable;
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pins_uhs;
> @@ -784,6 +785,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         }
>         sprd_host->clk_enable = clk;
>
> +       clk = devm_clk_get(&pdev->dev, "1x_enable");
> +       if (!IS_ERR(clk))
> +               sprd_host->clk_1x_enable = clk;
> +
>         clk = devm_clk_get(&pdev->dev, "2x_enable");
>         if (!IS_ERR(clk))
>                 sprd_host->clk_2x_enable = clk;
> @@ -793,12 +798,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>                 goto pltfm_free;
>
>         ret = clk_prepare_enable(sprd_host->clk_enable);
> +       if (ret)
> +               goto clk_sdio_disable;
> +
> +       ret = clk_prepare_enable(sprd_host->clk_1x_enable);
>         if (ret)
>                 goto clk_disable;
>
>         ret = clk_prepare_enable(sprd_host->clk_2x_enable);
>         if (ret)
> -               goto clk_disable2;
> +               goto clk_1x_disable;
>
>         sdhci_sprd_init_config(host);
>         host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
> @@ -858,10 +867,13 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
>
> -clk_disable2:
> -       clk_disable_unprepare(sprd_host->clk_enable);
> +clk_1x_disable:
> +       clk_disable_unprepare(sprd_host->clk_1x_enable);
>
>  clk_disable:
> +       clk_disable_unprepare(sprd_host->clk_enable);
> +
> +clk_sdio_disable:
>         clk_disable_unprepare(sprd_host->clk_sdio);
>
>  pltfm_free:
> @@ -878,6 +890,7 @@ static void sdhci_sprd_remove(struct platform_device *pdev)
>
>         clk_disable_unprepare(sprd_host->clk_sdio);
>         clk_disable_unprepare(sprd_host->clk_enable);
> +       clk_disable_unprepare(sprd_host->clk_1x_enable);
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
>
>         sdhci_pltfm_free(pdev);
> @@ -900,6 +913,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
>
>         clk_disable_unprepare(sprd_host->clk_sdio);
>         clk_disable_unprepare(sprd_host->clk_enable);
> +       clk_disable_unprepare(sprd_host->clk_1x_enable);
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
>
>         return 0;
> @@ -915,10 +929,14 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       ret = clk_prepare_enable(sprd_host->clk_enable);
> +       ret = clk_prepare_enable(sprd_host->clk_1x_enable);
>         if (ret)
>                 goto clk_2x_disable;
>
> +       ret = clk_prepare_enable(sprd_host->clk_enable);
> +       if (ret)
> +               goto clk_1x_disable;
> +
>         ret = clk_prepare_enable(sprd_host->clk_sdio);
>         if (ret)
>                 goto clk_disable;
> @@ -931,6 +949,9 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
>  clk_disable:
>         clk_disable_unprepare(sprd_host->clk_enable);
>
> +clk_1x_disable:
> +       clk_disable_unprepare(sprd_host->clk_1x_enable);
> +
>  clk_2x_disable:
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
>
> --
> 2.17.1
>
