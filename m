Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7C751F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjGMLHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjGMLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:07:29 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BF2705
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:07:27 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57688a146ecso4892007b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246446; x=1691838446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y0pyIQlBvW36Ph+YA2bTE1wsm2dlRAy2qTKSqOZ/cA=;
        b=fz2S5126ZLBxCYxaamY1kV1XyB8Qv9gBhsN9+rJe/eGznO+ScQvoojxk758DPrOL6S
         kiDpyKZGUcZetClE7o3VCBw3m6Akp3mXaCLgfcnhF2eujtVJKQu/+n20W/aIPj0Cd+ty
         WcEQ7nqPg/dCu7Todmj6yWyLlrj/lYAEKkh/bQDIiS/ki0HKFDN41wI9/Ngjrn/rCpAW
         b2Xm7uUaqAUYWAQjje5LQS0xRM7loY95nclMvnumicYpnG3uTZCEGrz1bKYIIMMQVVRq
         bvPcCaAknmhMq63eaYg2k42lGpJdncKI2FTAMeMr2fcyMBzcGqmG6lBfwecmh14bzgfU
         U+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246446; x=1691838446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y0pyIQlBvW36Ph+YA2bTE1wsm2dlRAy2qTKSqOZ/cA=;
        b=WJFLrbu6me6gjkK+mO32uObA+f7zOv5Jc2sO519ESOhU1+F4x3jdmQs/FmT1/Ssxj+
         hgSX9a7ahOnRL4yXSL8CyZoVYMpxKRtEAIVw3iMyeb/Mg+yJiYeds4s9JZZnXXEzStiy
         M4tjFCoOKyUVkJup2zHM9Dq37zXp/q+g+MMywc3kEBpVQ4jRuoeXDh4AR595SxnGsLSa
         hpkZF3G+i4i3UvZh0cLC+bIXhI6JR4N7KjE7IicmWrU8gopEdiEIvgQ7ECd29XldC8Wy
         J7612AmRwURtD/Q3TBniewFPfEauVjO8NpPyduX8MYdz+BuGxNQ79IRAjW2/xQCVGGqh
         Nn2Q==
X-Gm-Message-State: ABy/qLbhxc4867rmzWgRkVd2RdN2se2nbKkr/EuA8xBRKdZWZ9uXWHls
        Zt244qWGquY+sz9lPsmrfzkcTc775sC7oFF4xNlgig==
X-Google-Smtp-Source: APBJJlHbxUw4wK2EafSLUkStFGslm+iGkZ7cyFQclnB8FQ0STVNA6OJkiIZuxLzFRrbLtf01NpgRbuHPIBXmFf8Rfos=
X-Received: by 2002:a81:7744:0:b0:561:b85e:8d9e with SMTP id
 s65-20020a817744000000b00561b85e8d9emr1304189ywc.15.1689246446662; Thu, 13
 Jul 2023 04:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131939.22562-1-frank.li@vivo.com> <20230704131939.22562-3-frank.li@vivo.com>
In-Reply-To: <20230704131939.22562-3-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:50 +0200
Message-ID: <CAPDyKFqEZzph0B3gdy-UVvg_1YytoH3jVtSnv-AYCy9m9FG9cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: pxamci: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 15:19, Yangtao Li <frank.li@vivo.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 2a988f942b6c..1142cd2368f6 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -612,7 +612,6 @@ static int pxamci_probe(struct platform_device *pdev)
>         struct resource *r;
>         int ret, irq;
>
> -       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
> @@ -685,14 +684,14 @@ static int pxamci_probe(struct platform_device *pdev)
>         }
>
>         spin_lock_init(&host->lock);
> -       host->res = r;
>         host->imask = MMC_I_MASK_ALL;
>
> -       host->base = devm_ioremap_resource(dev, r);
> +       host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
>         if (IS_ERR(host->base)) {
>                 ret = PTR_ERR(host->base);
>                 goto out;
>         }
> +       host->res = r;
>
>         /*
>          * Ensure that the host controller is shut down, and setup
> --
> 2.39.0
>
