Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBD751F76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjGMLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGMLGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:06:09 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0292691
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:06:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57045429f76so4624977b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246363; x=1691838363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ5zJ3RE3bkqHW8nA39k1wel/wtNjBxuxQZqeE/oUIc=;
        b=AF4JKuK521m6pB4IPsTQ+GbIWvx6HdZRWVs+C/32ulGesRM1zmk1vbHB4UwV1J6XP3
         zd7N23Hr2cH+MRs2rq8FOD+J/ndsTIujQp7lzgR+eh48apV2E/O/x7pwTjuNqGypgJYv
         U5Yl5JQyBCCTKaccyP4uHt8Plaw+gPFq/0Cq4sVbo+RqhBH7Rf9zZb2UQVz7aQvrKV2X
         BSS/CrJU1XisLVIOnKYIv7DJniMH7Bq7bmHtpy/Oi6UBYSyt9knrS6YZoBjHP6Rxg79w
         GA+Zi1PUbXLsu2USX7EwENOe1S8HkIPv0yN3dRPKvde1q6/e2pJfiy3vpofdakqwW0kg
         ZfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246363; x=1691838363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ5zJ3RE3bkqHW8nA39k1wel/wtNjBxuxQZqeE/oUIc=;
        b=TAxnTuOtuiLP0eSKmQhx6F7wc/H6S8nrEmiVdZEaaf+NfZdY19mt5nzzmPtjq+VwrT
         UWZqg/D/JHddgFC7vLKYQThmbpXucjnXy9BA8NM2VkPeGUHSjrMKKwScIIfGjeyfXy+y
         JhzgqKBl8iH3rkDdLGdtt+ZxqSr8ruZ/g1OSDrLzNLTfHFLIvP9XJ+YbUYWSC7i6qneK
         mV8j9dlauA7NIk8DqNIgZrWSP+bYzc7hMka8T8uRYZ4sA5Tqpm3P1mzCJsDjDxQtA1za
         tqfNP5vZ5zK3o4eK7DZ1Y/0rs0P4f6EULjkZSdf408ejC4e7nL0ngFG+iQaGDuJgDWqE
         BiRw==
X-Gm-Message-State: ABy/qLap6Me5RFsKUQ7ZHUIJ/FKQdFztL+75vbVenmpffpv+w/oM0w5L
        +FYZbbcmlKcHmyL2iR/9XTLO0+GEAW3gPEzM3tUWNA==
X-Google-Smtp-Source: APBJJlG6zZPjAMen3wDVjrgT8dwhjGZ3m8Hcib7Gz1vJ0iqq3SC5gZIHOnTB0izb/nMffmR2rQGrjr1dp1LGr3QanzM=
X-Received: by 2002:a0d:dfcf:0:b0:570:6a58:d864 with SMTP id
 i198-20020a0ddfcf000000b005706a58d864mr1098399ywe.51.1689246363583; Thu, 13
 Jul 2023 04:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230622090233.188539-1-harperchen1110@gmail.com>
In-Reply-To: <20230622090233.188539-1-harperchen1110@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:05:27 +0200
Message-ID: <CAPDyKFqGG4S9GYZhikt--BhSpemke0t3859mX5QN7Rc2ajYwZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunplus: fix return value check of mmc_add_host()
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 11:02, Wei Chen <harperchen1110@gmail.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> 1. the memory allocated in mmc_alloc_host() will be leaked
> 2. null-ptr-deref will happen when calling mmc_remove_host()
> in remove function spmmc_drv_remove() because deleting not
> added device.
>
> Fix this by checking the return value of mmc_add_host(). Moreover,
> I fixed the error handling path of spmmc_drv_probe() to clean up.
>
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunplus-mmc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index db5e0dcdfa7f..a96e90ea6541 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -902,7 +902,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> -               goto probe_free_host;
> +               goto clk_disable;
>
>         mmc->ops = &spmmc_ops;
>         mmc->f_min = SPMMC_MIN_CLK;
> @@ -911,7 +911,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>
>         ret = mmc_regulator_get_supply(mmc);
>         if (ret)
> -               goto probe_free_host;
> +               goto clk_disable;
>
>         if (!mmc->ocr_avail)
>                 mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> @@ -927,9 +927,17 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         host->tuning_info.enable_tuning = 1;
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto pm_disable;
>
> -       return ret;
> +       return 0;
> +
> +pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +
> +clk_disable:
> +       clk_disable_unprepare(host->clk);
>
>  probe_free_host:
>         if (mmc)
> --
> 2.25.1
>
