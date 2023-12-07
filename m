Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E538089B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjLGN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjLGN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:59:30 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C510F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:59:34 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db5e5647c24so1804987276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957573; x=1702562373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0vyvlC9eF+1wpIASte+MSRLcH7gFX9ras58OkHQG/I=;
        b=hVm3rQYWBYyVQ0uW9eomnQO118KuY8vUU5VT4x04hP4lwY/YCAllr9jgjyqbys8MMG
         dj5meFr1Q6g9GwKFI+aj/ETYowxBtv9DxpESvA39YToX0TZBA1f5VqmJSddQgkZw+LK7
         OLKG9E1fC4Hd25hUdm62w4Kq1xiGMpy2RzRbQZ2nfudJmh5iuf0rEC30I31odzu1fEAh
         iXxLhaJ2DAb3TStrVXEf2feDxqCqzJgkAXfn6pKPHepKGm5WzIDB9V7+EPadsh6IrFjF
         V5a1QAWXP2xr30KhT3/gRK3RXQXUVTXmjLQ5tayalxVWCET2c3J2y2SiYoA0xLEHdUOJ
         JtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957573; x=1702562373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0vyvlC9eF+1wpIASte+MSRLcH7gFX9ras58OkHQG/I=;
        b=hvFyO49nupd+MI94V+fR68wBpPdQBdAoVgKaPHw4jg1DQop+G3cRvVrmMgDF7CeR2j
         tN3R//UjaWZYfMfxh7V1t82fbcr2oF/Tdww9aboGolGlm23hwJjUuAx/562fvG9HbZox
         GvTsCVReTh4E8faxgjIzLrJvhs27M9sPBskj+AKzaVTdWgXHqU556BRAcqs9FXpPpfsT
         ELPwaZr9aEQ/cac6jYfWd8tikYCYbdfseIsk1aB42qpUS2EapMHeMuGxy95uKNDFbGkh
         lcWNFSZPiYHVCnQspiqVMfHd7/aOnQ6mI9Bs7zh3v5JvoRq5UbyAvvxGtgNUmsWBzNO4
         iWQQ==
X-Gm-Message-State: AOJu0Yxn8wmUYmXLUkAu771oSdDSumOBHXzNugjvY3/r1xDW7YMghqi/
        XB+rbPO4gGP2rQnEmPyWJFgYcHlXyMAGLjgN/HdPWY5d5K/JmUGy
X-Google-Smtp-Source: AGHT+IHSzJy22Mg0xsZufbVMZodywBof+OeL81fih15QUTaArLRA1CZHrXP2uf+xRD0tejTll3DYbVjpXHsu/UtirCw=
X-Received: by 2002:a25:e64e:0:b0:db9:52dc:62c1 with SMTP id
 d75-20020a25e64e000000b00db952dc62c1mr3391214ybh.65.1701957573313; Thu, 07
 Dec 2023 05:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20231204064934.21236-1-wenchao.chen@unisoc.com>
In-Reply-To: <20231204064934.21236-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 14:58:56 +0100
Message-ID: <CAPDyKFpK2Yjj2oDWCUKHpht6PC9uNG-x2rPYO3EBD6GGWg4VZg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sprd: Fix eMMC init failure after hw reset
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

On Mon, 4 Dec 2023 at 07:50, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Some eMMC devices that do not close the auto clk gate
> after hw reset will cause eMMC initialization to fail.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

I assume we want this tagged for stable kernels too, but do we have a
corresponding fixes commit that we can point out?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sprd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6b8a57e2d20f..bed57a1c64b5 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
>         div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
>         sdhci_enable_clk(host, div);
>
> +       val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> +       mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
>         /* Enable CLK_AUTO when the clock is greater than 400K. */
>         if (clk > 400000) {
> -               val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> -               mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
> -                       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
>                 if (mask != (val & mask)) {
>                         val |= mask;
>                         sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
>                 }
> +       } else {
> +               if (val & mask) {
> +                       val &= ~mask;
> +                       sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> +               }
>         }
>  }
>
> --
> 2.17.1
>
