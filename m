Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9E7BFF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjJJO2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjJJO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:27:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A65C9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:27:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso805983276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948075; x=1697552875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dT77dimH38lNkEOjl8IbLPxRcBLVK2X43aS4AEihWpM=;
        b=vGj9VZPyTFZobfyj+fkrhPKhxwDZ3o8bIiDQ37YfnfJenNy3ZH7HA4SfdyeoUY2K1m
         9ZEwRgDTuYsnljEX6A+ABS2WM3OqBmpjrHjcvupIqdcU5TMi+cWkn3aGy5BKzzwZRe1k
         vfHyz3ibYX8AyNGZU5hTq9l3n+m5BeYKouiSxuDLqojGXpnxvPnQNRhhmqnyocYgUgzx
         Z+OyJ6fpUpFof85vWUhynelHYwu766IdZoEMML39tFkqayat1QhOHuH+JQHEw5xFmemc
         J71GuQp1nEpylNjqfdIWO7Yk/w7PQDWZWYMmE0tWuOWl804ZZx7jotLdD6K+hOcRBl1L
         k1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948075; x=1697552875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT77dimH38lNkEOjl8IbLPxRcBLVK2X43aS4AEihWpM=;
        b=KirEJUPaCv/HRo6GeZH5WnyNT/5q6jzj7tgwXD1dghuE2XCLOT4BLAd/OcPV/y1HGX
         COqxHR+UmV90uBuRtht3rcpOr2j1QeMkZw+C3HoXYGGKvhOTBJYBLHCW2BMcZUD6ypoX
         1mBX5U6XpHpjIa4MRNayVQxzceoPXW2Tgm82rc76nnAKs5h8cXs9wLOOJw/GsqTRyVwL
         Jq7lXDKmCijzr2tzAHPKB4jdPdZWXFgTG9Jlim3n/j7/B924Ar3K6Jg04I7oFqOgNRlE
         GwE0opbcxyllyQKChKN4A0UCj8Qc+puYByK45d8T4WZVdajW7p6QKLu8RtnQgaMlGTRT
         A0XA==
X-Gm-Message-State: AOJu0YxYM3QoM3rlrELTK8jvj6/L8cLhOB9tt1usSj07kJJTDanp3VL1
        imtgfFimdJvGf5OMc48yhNfXGNjceOxNJcXVxAibAvEMi9ETGCZV
X-Google-Smtp-Source: AGHT+IGWrxLtQd056lvR1T3hdr2BKFoq4kFj36v28+Mx5Z06v6657RWnOLDen1pD9HpMm5ZtwX8ltnK12vixWnT1Ra0=
X-Received: by 2002:a25:24cd:0:b0:d81:cdda:729c with SMTP id
 k196-20020a2524cd000000b00d81cdda729cmr16448284ybk.23.1696948075130; Tue, 10
 Oct 2023 07:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230928135644.1489691-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20230928135644.1489691-1-ben.wolsieffer@hefring.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:19 +0200
Message-ID: <CAPDyKFqha53z1wvB8FTXkivE0akoyCbcmU4DCh2qJhBtAbKwtQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: use peripheral flow control for STM32
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sept 2023 at 15:57, Ben Wolsieffer
<ben.wolsieffer@hefring.com> wrote:
>
> From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
>
> The STM32 SDMMC peripheral (at least for the STM32F429, STM32F469 and
> STM32F746, which are all the currently supported devices using periphid
> 0x00880180) requires DMA to be performed in peripheral flow controller
> mode. From the STM32F74/5 reference manual, section 35.3.2:
>
> "SDMMC host allows only to use the DMA in peripheral flow controller
> mode. DMA stream used to serve SDMMC must be configured in peripheral
> flow controller mode"
>
> This patch adds a variant option to control peripheral flow control and
> enables it for the STM32 variant.
>
> Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2: use bool instead of u8:1
>
>  drivers/mmc/host/mmci.c | 3 ++-
>  drivers/mmc/host/mmci.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 769b34afa835..90e32f18abbc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -249,6 +249,7 @@ static struct variant_data variant_stm32 = {
>         .f_max                  = 48000000,
>         .pwrreg_clkgate         = true,
>         .pwrreg_nopower         = true,
> +       .dma_flow_controller    = true,
>         .init                   = mmci_variant_init,
>  };
>
> @@ -1012,7 +1013,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>                 .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
>                 .src_maxburst = variant->fifohalfsize >> 2, /* # of words */
>                 .dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
> -               .device_fc = false,
> +               .device_fc = variant->dma_flow_controller,
>         };
>         struct dma_chan *chan;
>         struct dma_device *device;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 253197f132fc..34d9897c289b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -332,6 +332,7 @@ enum mmci_busy_state {
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>   * @dma_lli: true if variant has dma link list feature.
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> + * @dma_flow_controller: use peripheral as flow controller for DMA.
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -378,6 +379,7 @@ struct variant_data {
>         u8                      dma_lli:1;
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
> +       bool                    dma_flow_controller;
>         void (*init)(struct mmci_host *host);
>  };
>
> --
> 2.42.0
>
