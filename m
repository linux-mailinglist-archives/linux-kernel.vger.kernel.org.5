Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C8753713
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjGNJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjGNJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:49:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE343A99
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:49:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57eb0df5265so15032457b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689328180; x=1691920180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVRCcYI6KU6X2B0QhZtXZV8P/Bq4K8WpsLsWqaeiYCY=;
        b=gckjdvJRp7dj9kX3fVv1PBsM74FxOMPv7eGl7UHbw1mKUmPJBuLDyZ1FAr4eVA4o1v
         rBibOLpivXX/JCTEEjCrpLdnqJsMYOsn1FzkSTAV6okwfMODHbpyTON+1Az87iHfHJsY
         XPB8k6zzS738KAS9EG9otMF5gcnA7YktUltPe2QFwij/5nvM4gtlTxtbEkPrVivZL6wC
         6xk8Lk8n1YZlmXpMwFurWfGRESRMaQZeX2TtzW0d89Z+/A905x2Pbez3JAAyDBpSVRHK
         RzCadUngjUi5FP5+Q3XE/Tclu+hIAVzQ5QBTYthZ9FeJ2qP06Oydu9Cl/kJC+5oFmjtF
         i3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328180; x=1691920180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVRCcYI6KU6X2B0QhZtXZV8P/Bq4K8WpsLsWqaeiYCY=;
        b=JhH6QnLK6iCAYpjKWN1sx5hCiQBHtcCbbfze11p81f4yznZ+OzKvj5BrKjyqoEDc0M
         6jk441NMa7FjRZl6KetP5Q+9CRdIkSkp9aW9JXuCpsLMWIA+JhDlvm1YPWd0k0ni8ZvB
         /cQfrxEteAnJeyydxGJC18DrPjVbgm6MIKSy6xel/RForA869nn6ebq4k7Kbib7Xacdh
         F96oRs7EPTczVIvanZ0iFPwn8RvefxPkddaBDlDDpqtS+iVd8GiWjBeTUOWx8IZ7NZ5D
         noiRZKtkFq4eAwd8ekang15nLnlOhJIFsdTbDjSRQqY1DVTUFFU/vdkYsAVsVD6eHfxY
         6LgQ==
X-Gm-Message-State: ABy/qLaAYg7RCoiTMYcKe5iSs2WUtk4Xu2JoShk5MFKE/cOgZYJ+F0hF
        O09j7hNTIuglb0I5CraBk3XiRym3fwu6Xpg+3j1vMQ==
X-Google-Smtp-Source: APBJJlFca572uyzN1V9nYArOEOjIGhR/em7iLkLtW0EDTtrrbLU4GkrmLpU04a4+yN1UuV1I+6cTxksR5yc7sbgM3ww=
X-Received: by 2002:a0d:eec3:0:b0:577:3fb4:f245 with SMTP id
 x186-20020a0deec3000000b005773fb4f245mr4757025ywe.19.1689328180403; Fri, 14
 Jul 2023 02:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
In-Reply-To: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jul 2023 11:49:04 +0200
Message-ID: <CAPDyKFpUV=Ko5J1nQOgZGYJUuifMFGYe_xwBJtK3zkFNFQ=GRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Make SDIO irq truly optional
To:     Julien Delbergue <j.delbergue.foss@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 11:31, Julien Delbergue
<j.delbergue.foss@gmail.com> wrote:
>
> The following error is printed on Logic PD's DA850 EVM:
>   davinci_mmc 1c40000.mmc: error -ENXIO: IRQ index 1 not found
>
> Depending on the board, the SDIO interrupt may not be present, so use
> the correct function to reflect that and prevent logging an error.
>
> Signed-off-by: Julien Delbergue <j.delbergue.foss@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 7138dfa065bf..fb686c0d171c 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1257,7 +1257,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>
>         host->use_dma = use_dma;
>         host->mmc_irq = irq;
> -       host->sdio_irq = platform_get_irq(pdev, 1);
> +       host->sdio_irq = platform_get_irq_optional(pdev, 1);
>
>         if (host->use_dma) {
>                 ret = davinci_acquire_dma_channels(host);
> --
> 2.34.1
