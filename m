Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3C774955
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjHHTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHHTv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:51:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DE54C3F;
        Tue,  8 Aug 2023 09:57:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe4762173bso9734965e87.3;
        Tue, 08 Aug 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513867; x=1692118667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFCHTtX5KsdeKY8CuzU6iN0y/8t8L576wRb5AX7KKjs=;
        b=TB9WzhGgWK+d/4sbAUry7QK8j4V1lSYbQxHKrVuO6ZM/r5Fct1f5bOxvxWyiBEfkD+
         N6zTICmPSkIjyR6XasEfBl8xrtErcaoC/u6xPOxT35H1jV40f85z4g6ZxYof6vaoMec1
         +1mdww/EMFoAlWKt+lKj8xCwqBK2MrAUfZB8H8ifRetfcOvQEpEj03SC7X/jio6p529p
         FHBcKatvur1qtbtc+XohZOwMfr/rpyK2w/s6I1QC5U8PMFdRa8fZd7HV17lwkYlgX7ol
         yJZbooQc7WBDvZSFp8WWfI/f0ZCD44gEuHi5vcdlfGbKk7ADnJj4Io6ptDXcJ39J14e0
         GlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513867; x=1692118667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFCHTtX5KsdeKY8CuzU6iN0y/8t8L576wRb5AX7KKjs=;
        b=G7dApADbAzJhQGohM89qDtNVkC0q+vb6uHTcwFD8F44fVNa94lj4YdksQTGggop0xR
         jL7TKvy+TdzPUUdcT0kkTjqrYaEsr4BLFJQKXzrbc12zsPLXU1zeDiPm2p+n8viaTw3x
         SlP3g0LnmJGvl+oHcuuVagMj9jZ4PORzL9l3STucL6WnnlVaakYRnok5Fhw6sZDjt49Y
         JglekGLuAnBhC306MvmXG3NePYwJ0WtG/SbNwKsayweNNw4H8iZlshUbo3E7Xceas/Yp
         xnOkYUgDjqsrIeINwIjPw6npPdHuyk7l6IK6Zz75vjZ5QY1/vgWPtgg5yd5FksgBANSj
         Zs2g==
X-Gm-Message-State: AOJu0YyelIIEH0SB802rsUIHCbLqj5UQb5e68NydhB817F4wGS4jv0Zb
        DQR30887BspfBX6FRCPCl9o2TEB72vk41MlakNPgVArz4GU=
X-Google-Smtp-Source: AGHT+IEJtndB+TX6d+lulY9nN/dXEeKD8QPCRSZMq31M4xp63m6SJ08BwBgWPwffNQfbkUeoXy5ALYliUzjrnGvjPHA=
X-Received: by 2002:aa7:d9c2:0:b0:522:38cb:d8cb with SMTP id
 v2-20020aa7d9c2000000b0052238cbd8cbmr8955558eds.20.1691487402502; Tue, 08 Aug
 2023 02:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033130.2226-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20230808033130.2226-1-Wenhua.Lin@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 8 Aug 2023 17:36:05 +0800
Message-ID: <CAAfSe-t45FeFzXKUCjOU5qoPF-rq4dzMKo-eRciw6MbLq+rNgA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: sprd: In the sleep state, the eic dbnc clk must
 be forced open
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 11:32, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> In the sleep state, Eic dbnc has no clock and the clk enable

Does "dbnc" mean "debounce"? I suggest not using abbreviation here.

> of dbnc needs to be forced open, so that eic can wake up normally.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 0d85d9e80848..c506cfd6df8e 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -23,6 +23,7 @@
>  #define SPRD_EIC_DBNC_IC               0x24
>  #define SPRD_EIC_DBNC_TRIG             0x28
>  #define SPRD_EIC_DBNC_CTRL0            0x40
> +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
>
>  #define SPRD_EIC_LATCH_INTEN           0x0
>  #define SPRD_EIC_LATCH_INTRAW          0x4
> @@ -213,6 +214,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
>         u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
>
>         value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> +       value |= SPRD_EIC_DBNC_FORCE_CLK;
>         writel_relaxed(value, base + reg);
>
>         return 0;
> --
> 2.17.1
>
