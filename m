Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417917908BA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjIBQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjIBQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:43:23 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1CCE0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:43:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7d50ba994eso78525276.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693672999; x=1694277799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUQI1IMPxq/0QcnuPOG+oY2Cvb8cpMwVnmqwILZAnjE=;
        b=tupHNEMPOGzX2Ne/XK4qvMvTbXNd6vnZAqx2KMxCetrCff7eoBoZngvwdG55GYivps
         mLEVsnwVeKzrAjdPTZmv0zigSbEOnucH9EMCBsKaoT6n+HjxHvIP4lisY0fQAh2CTRPm
         lPA6XtXiG0XS0teXIwrrHWORTLdDSl1AAhk1YQS0CaQLpGIxykAdIbeDCxT+ZHAVqEvm
         pXZVVmrE53rdfbRaUfNt0Vp93eiTszFMIdJZkDRT/HSinnX/MGzodk31kP+pg9mFdG4z
         XB2K6OEGpzSZ1kUmn8RJwmCTo2yGBnhBRoTWtFrQlz0J8M6kAdusbUU0MQ1O+PxWiQJY
         JLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693672999; x=1694277799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUQI1IMPxq/0QcnuPOG+oY2Cvb8cpMwVnmqwILZAnjE=;
        b=GF/c7k6mAoS56iDR8p1fTgG4VPOUE5Y3A9tUHuG4EREGHTnA4JJXgUI25uAYpEZnV/
         KfX9r/NzTrWvm+Ys32ukkyqlkv4jKqfII6ipNjo0J1oyTDsUZgRZSp3BeRMkxeBvlR9f
         4TT2wGwEUSAgc8SD7GxA6eE/OjteJ70JBviLsV2CnyjpQlCdh5ftkpoh/P1NvwNoeL/4
         jYOY9HwsRL82ctBYRnkF/JLeIhV0Bv0ptWNVMs/1e6ADGWIWJwt6UvOVqQtvRF8J5ZLK
         3pzKhI/ng4ExKAal2thp05eTD7lKiBlAJkCIV021COkMAHGlKOiV6vXcNWgaeD4lLly+
         1rDQ==
X-Gm-Message-State: AOJu0YzlCWNnTncNZ6xZBfZOfSScapCiTl2xcXwh40zH8Kv2zv8KMqKi
        BuGbP3A08FNzeAFsto26pfSCsJkYUfEz3IFrBCBESA==
X-Google-Smtp-Source: AGHT+IE/lyKUxC+R61qFXqvryIakPGcGdMcW/bi3SrxhNQy2coxvc4NC7uGhbA7OM2U7ZRuQsjY6HNyjJvBnSDvaMR4=
X-Received: by 2002:a25:2495:0:b0:d78:1f87:d6f1 with SMTP id
 k143-20020a252495000000b00d781f87d6f1mr5941437ybk.33.1693672998777; Sat, 02
 Sep 2023 09:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120836.1057900-1-yann.gautier@foss.st.com>
In-Reply-To: <20230901120836.1057900-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 2 Sep 2023 18:43:07 +0200
Message-ID: <CACRpkdaj6bEQTo6a5gOJQne-wKqBLvuxiOe9kE+q-nkYLOU7Pw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann/Christophe,

just a quick note:

On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Yann Gautier <yann.gautier@foss.st.c=
om> wrote:

> +static void sdmmc_enable_sdio_irq(struct mmci_host *host, int enable)
> +{
> +       void __iomem *base =3D host->base;
> +       u32 mask =3D readl_relaxed(base + MMCIMASK0);
> +
> +       if (enable)
> +               writel_relaxed(mask | MCI_ST_SDIOITMASK, base + MMCIMASK0=
);
> +       else
> +               writel_relaxed(mask & ~MCI_ST_SDIOITMASK, base + MMCIMASK=
0);
> +}
> +
> +static void sdmmc_sdio_irq(struct mmci_host *host, u32 status)
> +{
> +       if (status & MCI_ST_SDIOIT) {
> +               sdmmc_enable_sdio_irq(host, 0);
> +               sdio_signal_irq(host->mmc);
> +       }
> +}

You need to move these to mmci and rename them since Ux500 will use
the same callbacks.

>  static struct mmci_host_ops sdmmc_variant_ops =3D {
>         .validate_data =3D sdmmc_idma_validate_data,
(...)
> +       .enable_sdio_irq =3D sdmmc_enable_sdio_irq,
> +       .sdio_irq =3D sdmmc_sdio_irq,
>  };

What about dropping the per-variant callbacks and just inline
this into mmci_enable_sdio_irq()/mmci_ack_sdio_irq() since
so many variants have the same scheme? I haven't looked
at the Qualcomm variant though, maybe it is completely
different...

Yours,
Linus Walleij
