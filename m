Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4E7BFF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjJJO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjJJO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2053D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d865854ef96so6056742276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948102; x=1697552902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5Rfkqq2sRB/UrRjurgpT2RLtcmwidhch/jC813qmrg=;
        b=CoAygsd1K68bW0ixq17UgH5e5yysyzcsygMiseotj5BbN1zOR/L8ANOiWFI8H1RKQD
         Z/xJ2FMl9JtUA9dRKwhl7mpPCywy6vXI2sZ+eXjmy0qf8bS/ZaelqwC2kGOytfemYmwx
         2vyQzhL2wnv6UMTFIyDF1Zf2cnqvshahThXM0ziyibnphqcQscwseeelUa9DAoA/0LUd
         eEwiBTzIUnkVMGSi38wQ5Oqmn0Ty7kjfivqNF6z/WMjAISuXt6+WP3GrmdMsw6sICHZg
         y/qCUNFyz1HY2OicDaQcPJPdE+Wckmo7g/meyjchlpnRWnfkEVF899ONT030YflFkszk
         sqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948102; x=1697552902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5Rfkqq2sRB/UrRjurgpT2RLtcmwidhch/jC813qmrg=;
        b=jKZgosOrP4SNPuIPUikSDST1TY47xilzU01DEKmksl7ozOMnCRk9//sXR1fotih4x8
         qsChS5djKwrknT333aHXZGuUrdPmfoqSa/JHAIvRmrQmXxGcYPbMO+M6HIVeLerdeyNt
         XF5AvvouiPqr0acQyzwCELZEcQ8S1q7DdTJDaDqU7OgMI93qg3gKLtMch9gVBiNwj0DX
         YEQx4KopXMwElWfe6PV1d46oQr4uSYdbMKhRFfRrht4W9nyCgtv8ZCPBlZoF6s089EQl
         1s/GypjXu5QG1WLsX159dlVZtCQFzTbdx6zQPHCkLfrZcLOVmFJSHqVRq5Yi+Df6z7/5
         ncZQ==
X-Gm-Message-State: AOJu0YwqE7JrlnT4lY96A1qMHc7SB2EvpOlmYOPybS/ADbdqGjPvVlZ3
        ASozBulqQ1fDZFr9nlKHRpf+tqrcDewkVa48Vt37OQ==
X-Google-Smtp-Source: AGHT+IGQjtg07ZEl3kbNS6s2cyMhih+TtYHl/2za/vGD0kAlS3GNGt2q4ev1cjF3EWQukTR3BF0ESm+AOzBq66SQydM=
X-Received: by 2002:a25:838a:0:b0:d9a:5071:716f with SMTP id
 t10-20020a25838a000000b00d9a5071716fmr2667802ybk.59.1696948102086; Tue, 10
 Oct 2023 07:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231006224343.441720-1-robh@kernel.org>
In-Reply-To: <20231006224343.441720-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:46 +0200
Message-ID: <CAPDyKFpoan9hbfSuLh0vGnYjAMbn+Nkbg9kNR9wOpXmEzvRSuw@mail.gmail.com>
Subject: Re: [PATCH] mmc: jz4740: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 at 00:43, Rob Herring <robh@kernel.org> wrote:
>
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index f379ce5b582d..6a45991ca056 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -18,9 +18,10 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/scatterlist.h>
>
> @@ -1040,7 +1041,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>         int ret;
>         struct mmc_host *mmc;
>         struct jz4740_mmc_host *host;
> -       const struct of_device_id *match;
>
>         mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
>         if (!mmc) {
> @@ -1050,13 +1050,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>
>         host = mmc_priv(mmc);
>
> -       match = of_match_device(jz4740_mmc_of_match, &pdev->dev);
> -       if (match) {
> -               host->version = (enum jz4740_mmc_version)match->data;
> -       } else {
> -               /* JZ4740 should be the only one using legacy probe */
> -               host->version = JZ_MMC_JZ4740;
> -       }
> +       /* Default if no match is JZ4740 */
> +       host->version = (enum jz4740_mmc_version)device_get_match_data(&pdev->dev);
>
>         ret = mmc_of_parse(mmc);
>         if (ret) {
> @@ -1200,7 +1195,7 @@ static struct platform_driver jz4740_mmc_driver = {
>         .driver = {
>                 .name = "jz4740-mmc",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table = of_match_ptr(jz4740_mmc_of_match),
> +               .of_match_table = jz4740_mmc_of_match,
>                 .pm = pm_sleep_ptr(&jz4740_mmc_pm_ops),
>         },
>  };
> --
> 2.40.1
>
