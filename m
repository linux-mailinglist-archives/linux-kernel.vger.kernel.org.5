Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7788052F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjLELeO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 06:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442108AbjLELd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:33:57 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F211AE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:33:27 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5cece20f006so64426877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776006; x=1702380806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK8pG1Ch209D8ULQ7meBK4Xhko4HHTTJW9BjU1JAjGs=;
        b=UJmsH1WymDukqN13X6HVQeCSHJgy81PZoLIpPp01PQa2+IaSa3YMJyHv3RDGQefohb
         CszMfONFMtlPrN3eH3yc/bHyUc5MOBm4Al/c/akeHH0vXLV3MpZMt+Oflarei73spkRb
         qQfUIEQHDRhav4BEJJchINpimhLFDKpjdgNf5Hnte4frRsXYlTnjTTc78NKirDd58B62
         OkkBgBOlfALE4Q5eB1V4ipeBIKuhnRFokt3T2uNNo7ppZrjUjGqlgu/o8uZAGWBg6bdJ
         HB5DtbsLh0fOKcGZYy3gJUV85XaG46OgZVRvawxmPfAtwfL19Wu/f9m8G4XmdhBvYrah
         vQRw==
X-Gm-Message-State: AOJu0YwFba7jEEp6YNzcu/7Jib41pMWmgF1gCdg59cx3QrsTbRjTzuGf
        kyIEgwM6ZzCBB5Da9f6QJJE2SSDE8K2Xww==
X-Google-Smtp-Source: AGHT+IEWRHO0aXlNHLri+Fe6Pnl4dvdUTuRLgNjC66fzeTvcRF+QAxxLXySGBAxF2f/UvE2TvN/DMQ==
X-Received: by 2002:a81:79cd:0:b0:5d7:1940:f3fa with SMTP id u196-20020a8179cd000000b005d71940f3famr4437648ywc.98.1701776006568;
        Tue, 05 Dec 2023 03:33:26 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r20-20020a0de814000000b005d39c874019sm3790951ywe.66.2023.12.05.03.33.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 03:33:26 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db544987c79so3890444276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:33:25 -0800 (PST)
X-Received: by 2002:a05:6902:1008:b0:db7:dacf:6fd4 with SMTP id
 w8-20020a056902100800b00db7dacf6fd4mr5436314ybt.92.1701776005540; Tue, 05 Dec
 2023 03:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20231203052125.37334-1-liuhaoran14@163.com>
In-Reply-To: <20231203052125.37334-1-liuhaoran14@163.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Dec 2023 12:33:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULptdNwqMQx7zqrbuowWCCd5wsKboReHDHfT8FkcKtKw@mail.gmail.com>
Message-ID: <CAMuHMdULptdNwqMQx7zqrbuowWCCd5wsKboReHDHfT8FkcKtKw@mail.gmail.com>
Subject: Re: [PATCH] [mfd] da9052: Add error handling for spi_setup in da9052_spi_probe
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     support.opensource@diasemi.com, lee@kernel.org,
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

On Sun, Dec 3, 2023 at 6:22 AM Haoran Liu <liuhaoran14@163.com> wrote:
> This patch adds error handling for the spi_setup call. The need for this
> error handling was identified through static analysis, which highlighted
> the lack of proper handling for potential failures of spi_setup.
> Previously, a failure in spi_setup could lead to unstable behavior of
> the DA9052 device.
>
> Although the error addressed by this patch may not occur in the current
> environment, I still suggest implementing these error handling routines
> if the function is not highly time-sensitive. As the environment evolves
> or the code gets reused in different contexts, there's a possibility that
> these errors might occur. In case you find this addition unnecessary, I
> completely understand and respect your perspective. My intention was to
> enhance the robustness of the code, but I acknowledge that practical
> considerations and current functionality might not warrant this change
> at this point.
>
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/mfd/da9052-spi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
> index be5f2b34e18a..c32d5025a18f 100644
> --- a/drivers/mfd/da9052-spi.c
> +++ b/drivers/mfd/da9052-spi.c
> @@ -22,6 +22,7 @@ static int da9052_spi_probe(struct spi_device *spi)
>         int ret;
>         const struct spi_device_id *id = spi_get_device_id(spi);
>         struct da9052 *da9052;
> +       int ret;

As reported by the kernel test robot:

    error: redeclaration of 'ret' with no linkage

your patch fails to build (again!).

Please stop submitting completely untested patches.
Thank you!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
