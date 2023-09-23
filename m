Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92E7ABEC4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjIWINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIWING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:13:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA29180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:12:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bffa8578feso56522661fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695456777; x=1696061577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bi321A2drNy6nknQTf7dQWZFXj5dHMNZIqg1+SAX5s=;
        b=Eb6muA52t84np1PtJvHMCmyqpxUZXUNe5EBOLvbBqfSO/FjQ68Y7YWamoD/Azed3ka
         xDSLcdmEZkKx8UanBZV+hIVuYCX3nZ/NxQVBsJdrSrV6OXkwh4KsgG11tAsO+GwDYWq6
         9JD1VCPmS2F680El6cBO+cN8RHG06TDFNmc6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695456777; x=1696061577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi321A2drNy6nknQTf7dQWZFXj5dHMNZIqg1+SAX5s=;
        b=b7UPkLLgF2F+L9zl01+nMKsD1MygZTKY9jtsrZrtpnaTivOggnyvQ+NHzayPit+8vj
         ClDPwxvmbQplR1Tqk9UO8I/GBWxSiavZTH/OvsFgct/ZrzLanmu8Afx9ebtKTi5Vkh2t
         pd349T47PDd9P2CCJChPrzmYGud/FJBOcZC/oag8pa/J7eWuzj4zaqEWn06KQDmWbOnn
         OfJvioYVkD0pd6+98rDXu8Zv17oDPXhYDfzpo7Q5AUOQPcFESWVjWWlF4kQIgX25CNp5
         0XOpH/BbFCOh8fu+z0XK3RjaPapzbBikXGFmL7yJ7L/n/YtkjvAPo8hIL1/sCBgopB36
         J0DQ==
X-Gm-Message-State: AOJu0YxNjKlgm5HxmF8o+EJPJRqrohgn3RKa3tHWeJXg8GYHl3BeIUO1
        8LYCJPYDLQG8weXK55SJ50pPkmAHf0yQaHVUX0UNFg==
X-Google-Smtp-Source: AGHT+IECnxMKCUchTTGpBiZNHPiRxbAjTm5HGeILQHbyVOU3vKKeQJn06Lqp7XA7vJmj2YNE+ycen3IpeXS+HSyxN2o=
X-Received: by 2002:a19:5002:0:b0:4f8:77db:1d9e with SMTP id
 e2-20020a195002000000b004f877db1d9emr1402093lfb.12.1695456777524; Sat, 23 Sep
 2023 01:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230922095348.22182-1-pablo.sun@mediatek.com>
In-Reply-To: <20230922095348.22182-1-pablo.sun@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Sat, 23 Sep 2023 16:12:46 +0800
Message-ID: <CAGXv+5Hi2dem-d-EfAJjGkeb1aPnYBWjgVgyHdgp-RJAV=gRcQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw
To:     Pablo Sun <pablo.sun@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 6:05=E2=80=AFPM Pablo Sun <pablo.sun@mediatek.com> =
wrote:
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
> [    1.204633] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         =
5.15.42-mtk+modified #1
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
> Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open=
-coded polling")
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
