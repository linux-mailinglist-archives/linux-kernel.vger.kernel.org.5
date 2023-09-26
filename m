Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5F7AEF70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjIZPEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjIZPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849FE51
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:04:22 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bf298ef1f5so5586438a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740659; x=1696345459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HeFjiy4HXCSDHqncKbVdy7TDNdv7qqAs1Sfi74FhiwE=;
        b=Mea04XD+xmsmV6xUVR41DHh650MP5JLzCR/Ifg+bbdHJoXwhO6VDEGgqKlcPbSLcsP
         ysVcDHy/Gl2wqJKTFuMeEwRg/BEugFAHkYE+dHxnGRdItYLvkwb54vYQifxzDbVWB59k
         UCS+ATDOnx9n9llm8PYZ0qyn0Xs0YS12vetLsKxgUUlqnp+1O3o/4xA6rbHfPXbTQM62
         0W7X5fnIuVKK5T5feoyxrOABNecKAJG6Cd/Aaxf4iK901wnmCiYc2wxgRqpvW3t7bTkK
         n5BHRkda490C6T1/hrJI14HdyutVD9hVJzy/APIqca+2U2lH3mQrugeYflfNB2EvJ3Tr
         4mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740659; x=1696345459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeFjiy4HXCSDHqncKbVdy7TDNdv7qqAs1Sfi74FhiwE=;
        b=ERYrKpTrextvzHWjvVgmg5FNgr3UjWWORS/ETphufJYlmnA+c9XNmgDjsofvZDujPH
         QTv5Z4ESI43dbgow+m93EscT1exFGSrlM9f+8fHW/eJEAiicgpGVinFW61EE1bdWd6zc
         eNjkf3wLh9rKc8GBQWtD46U4s9zMDIREqwRqeBip/qR0/uF23xCEn40rvNGJX8vGjYCF
         CHePhsvVfYhxoSXn9kPsc9OFzZQsS4/5wuhscREb9hoF/BgFKT5kCQyArxB2VSdyaInf
         pChenj0sSdWInYIdESbTijfPVtFtIYixt1ZgoxQpGBZnLbQAAJBvwc+15g2Y/N7e4pAf
         NIEQ==
X-Gm-Message-State: AOJu0YyiIVTQh+gTAhT7I5UVLM2BrJeClvJQWEvl11fp29bQXi1yQVkw
        YKNOmaadDo3aWZifJ05eX6toWuZGuT7lc+U81AIzJw==
X-Google-Smtp-Source: AGHT+IGdQuvVsg+gmIk0SmA4JMrymCzShro3UtZMccAsP+0p8Rtd1FF4Qge9tx7ZaLRR3USnZ4acnj3DZvpnD5dhoHo=
X-Received: by 2002:a05:6830:22e4:b0:6b9:68fb:5a28 with SMTP id
 t4-20020a05683022e400b006b968fb5a28mr10468019otc.27.1695740658349; Tue, 26
 Sep 2023 08:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230922095348.22182-1-pablo.sun@mediatek.com>
In-Reply-To: <20230922095348.22182-1-pablo.sun@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 17:03:42 +0200
Message-ID: <CAPDyKFo9i-8maLJ=L5re8pe4v2v5vQ8Jy+g-MqtNZH_w6Lb9cg@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw
To:     Pablo Sun <pablo.sun@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 11:54, Pablo Sun <pablo.sun@mediatek.com> wrote:
>
> Use atomic readl_poll_timeout_atomic, because msdc_reset_hw
> may be invoked in IRQ handler in the following context:
>
>   msdc_irq() -> msdc_cmd_done() -> msdc_reset_hw()
>
> The following kernel BUG stack trace can be observed on
> Genio 1200 EVK after initializing MSDC1 hardware during kernel boot:
>
> [    1.187441] BUG: scheduling while atomic: swapper/0/0/0x00010002
> [    1.189157] Modules linked in:
> [    1.204633] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.15.42-mtk+modified #1
> [    1.205713] Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> [    1.206484] Call trace:
> [    1.206796]  dump_backtrace+0x0/0x1ac
> [    1.207266]  show_stack+0x24/0x30
> [    1.207692]  dump_stack_lvl+0x68/0x84
> [    1.208162]  dump_stack+0x1c/0x38
> [    1.208587]  __schedule_bug+0x68/0x80
> [    1.209056]  __schedule+0x6ec/0x7c0
> [    1.209502]  schedule+0x7c/0x110
> [    1.209915]  schedule_hrtimeout_range_clock+0xc4/0x1f0
> [    1.210569]  schedule_hrtimeout_range+0x20/0x30
> [    1.211148]  usleep_range_state+0x84/0xc0
> [    1.211661]  msdc_reset_hw+0xc8/0x1b0
> [    1.212134]  msdc_cmd_done.isra.0+0x4ac/0x5f0
> [    1.212693]  msdc_irq+0x104/0x2d4
> [    1.213121]  __handle_irq_event_percpu+0x68/0x280
> [    1.213725]  handle_irq_event+0x70/0x15c
> [    1.214230]  handle_fasteoi_irq+0xb0/0x1a4
> [    1.214755]  handle_domain_irq+0x6c/0x9c
> [    1.215260]  gic_handle_irq+0xc4/0x180
> [    1.215741]  call_on_irq_stack+0x2c/0x54
> [    1.216245]  do_interrupt_handler+0x5c/0x70
> [    1.216782]  el1_interrupt+0x30/0x80
> [    1.217242]  el1h_64_irq_handler+0x1c/0x2c
> [    1.217769]  el1h_64_irq+0x78/0x7c
> [    1.218206]  cpuidle_enter_state+0xc8/0x600
> [    1.218744]  cpuidle_enter+0x44/0x5c
> [    1.219205]  do_idle+0x224/0x2d0
> [    1.219624]  cpu_startup_entry+0x30/0x80
> [    1.220129]  rest_init+0x108/0x134
> [    1.220568]  arch_call_rest_init+0x1c/0x28
> [    1.221094]  start_kernel+0x6c0/0x700
> [    1.221564]  __primary_switched+0xc0/0xc8
>
> Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 5392200cfdf7..97f7c3d4be6e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -669,11 +669,11 @@ static void msdc_reset_hw(struct msdc_host *host)
>         u32 val;
>
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
> -       readl_poll_timeout(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
> +       readl_poll_timeout_atomic(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
>
>         sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
> -       readl_poll_timeout(host->base + MSDC_FIFOCS, val,
> -                          !(val & MSDC_FIFOCS_CLR), 0, 0);
> +       readl_poll_timeout_atomic(host->base + MSDC_FIFOCS, val,
> +                                 !(val & MSDC_FIFOCS_CLR), 0, 0);
>
>         val = readl(host->base + MSDC_INT);
>         writel(val, host->base + MSDC_INT);
> --
> 2.18.0
>
