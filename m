Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1990787FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbjHYG0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbjHYG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:26:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7B1FD5;
        Thu, 24 Aug 2023 23:26:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso7715941fa.1;
        Thu, 24 Aug 2023 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692944780; x=1693549580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ipShb9SqOkO9YC3H7e/0Pr97qinxpxrUiWfa6MdKI=;
        b=JdGpEX7Dstg6BWpug7MvXigpjjMEfMugatyynVwkbQ4PJ5UpZmMM2OaOQuzEngnxus
         +yKkmAkX1hIU7zP5+VOALdAIUKCRtsJ5NolcAiP/DUmYEc2Ucat9OBow75rgT7zjqE9H
         YmTHwJdZR549F4qdn1abLUqDfTIjCS57FtOXcDuLTC9XiwmeIMFvwC+Lfa9jsb3g7SBn
         XUtaa9UfqBaEDDhslNsANFfXVjCsrIQmw3IAP4Ug+6tjiacDpnfAPfGiQ16Gn8qU+7Bf
         gtQvsunnnOFvGvMPeeOE1rtBF6EFlh07IzZmb9cFRPIMa2xYQ3A8no2hNkH56WYthTtP
         AURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944780; x=1693549580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1ipShb9SqOkO9YC3H7e/0Pr97qinxpxrUiWfa6MdKI=;
        b=hEeyp9COLNf5oPPNF6KnGeXzmn+Us0/cs342+JYXqCqQd7wVrk+LRGDchzrVwYMKxf
         /JqwqMODjOGplHKFZPtwdvh6ebRH0p0c00+1Glmzj1Gd52jINuBG7mcUN6AT41SK1zzz
         bTmYW8b2wzZ6Rum+/CH8PSpiGsevvzJxkZ0CZ4CTT0AeyW4gX3OP+dh1BN6N0Yq+TfD9
         Wkj8pjTQcdJugEkbXVrcBtW2ZpEYhXHVnm7mjEuosGQ6sglRSwDNEwgQrl54yzp3vIGV
         nh2+IlRiUTlXt8DyKyfh7t6zOzKqxtTUgWVdREv0pA87DuxO0hDkJbtKGA4zyMmbK34d
         HGCA==
X-Gm-Message-State: AOJu0YwDHxkUbWO+s36zmxCMzI1sNCkqOnnvFjXMuuk2qHigy3+7RFDw
        0aMkoUvwQmhskdB7FZyRPRxMNJl0OqrBzLCx5dM=
X-Google-Smtp-Source: AGHT+IGkaeK48THQJm2FwND3YMABwJYN+gKPAIMo9dNPHXvcvYZEMnmxeoc+h24u8LUXLnWM2Dmc6rbgJkyPamFSkhI=
X-Received: by 2002:ac2:5b03:0:b0:500:a6c1:d8e3 with SMTP id
 v3-20020ac25b03000000b00500a6c1d8e3mr842166lfn.46.1692944779618; Thu, 24 Aug
 2023 23:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230805070643.30705-1-zhifeng.tang@unisoc.com>
In-Reply-To: <20230805070643.30705-1-zhifeng.tang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 25 Aug 2023 14:25:42 +0800
Message-ID: <CAAfSe-vc1Kmvj0eFqTBAMv+ZAOH13b8WSDfVJ+OZx7s1gUuLMA@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: Composite driver support offset config
To:     Zhifeng Tang <zhifeng.tang@unisoc.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2023 at 15:07, Zhifeng Tang <zhifeng.tang@unisoc.com> wrote:
>
> The composite interface support the offset configuration,
> which is userd to support mux and div in different registers.

Please fix the typo "userd".

Also, you should describe in more detail the reason why we need this
change. Is it because the divider has different addresses from mux for
one composite clk?

>
> Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
> ---
>  drivers/clk/sprd/composite.h | 38 +++++++++++++++++++++++++-----------
>  drivers/clk/sprd/div.c       |  6 +++---
>  drivers/clk/sprd/div.h       | 17 +++++++++++-----
>  3 files changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/clk/sprd/composite.h b/drivers/clk/sprd/composite.h
> index adbabbe596b7..74765584021d 100644
> --- a/drivers/clk/sprd/composite.h
> +++ b/drivers/clk/sprd/composite.h
> @@ -19,24 +19,24 @@ struct sprd_comp {
>  };
>
>  #define SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,        \
> -                                _mshift, _mwidth, _dshift, _dwidth,    \
> -                                _flags, _fn)                           \
> +                                _mshift, _mwidth, _doffset, _dshift,   \
> +                                _dwidth, _flags, _fn)                  \
>         struct sprd_comp _struct = {                                    \
>                 .mux    = _SPRD_MUX_CLK(_mshift, _mwidth, _table),      \
> -               .div    = _SPRD_DIV_CLK(_dshift, _dwidth),              \
> +               .div    = _SPRD_DIV_CLK(_doffset, _dshift, _dwidth),    \
>                 .common = {                                             \
>                         .regmap         = NULL,                         \
>                         .reg            = _reg,                         \
>                         .hw.init = _fn(_name, _parent,                  \
>                                        &sprd_comp_ops, _flags),         \
> -                        }                                              \
> +               }                                                       \
>         }
>
>  #define SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg, _table,     \
>                             _mshift, _mwidth, _dshift, _dwidth, _flags) \
>         SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table, \
> -                                _mshift, _mwidth, _dshift, _dwidth,    \
> -                                _flags, CLK_HW_INIT_PARENTS)
> +                                _mshift, _mwidth, 0x0, _dshift,        \
> +                                _dwidth, _flags, CLK_HW_INIT_PARENTS)
>
>  #define SPRD_COMP_CLK(_struct, _name, _parent, _reg, _mshift,          \
>                       _mwidth, _dshift, _dwidth, _flags)                \
> @@ -47,14 +47,30 @@ struct sprd_comp {
>                                  _mshift, _mwidth, _dshift,             \
>                                  _dwidth, _flags)                       \
>         SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table, \
> -                                _mshift, _mwidth, _dshift, _dwidth,    \
> -                                _flags, CLK_HW_INIT_PARENTS_DATA)
> +                                _mshift, _mwidth, 0x0, _dshift,        \
> +                                _dwidth, _flags,                       \
> +                                CLK_HW_INIT_PARENTS_DATA)
>
>  #define SPRD_COMP_CLK_DATA(_struct, _name, _parent, _reg, _mshift,     \
>                            _mwidth, _dshift, _dwidth, _flags)           \
> -       SPRD_COMP_CLK_DATA_TABLE(_struct, _name, _parent, _reg, NULL,   \
> -                                _mshift, _mwidth, _dshift, _dwidth,    \
> -                                _flags)
> +       SPRD_COMP_CLK_DATA_TABLE(_struct, _name, _parent, _reg, NULL,   \
> +                                _mshift, _mwidth, _dshift,             \
> +                                _dwidth,  _flags)

It seems that nothing changes here? Please don't make unrelated changes.

> +
> +#define SPRD_COMP_CLK_DATA_TABLE_OFFSET(_struct, _name, _parent, _reg, \
> +                                       _table, _mshift, _mwidth,       \
> +                                       _dshift, _dwidth, _flags)       \
> +       SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table, \
> +                                _mshift, _mwidth, 0x4, _dshift,        \

I suggest not using hard code here.

Also I think all _OFFSET() should have an offset parameter, that will
be more flexible and logical.

> +                                _dwidth, _flags,                       \
> +                                CLK_HW_INIT_PARENTS_DATA)
> +
> +#define SPRD_COMP_CLK_DATA_OFFSET(_struct, _name, _parent, _reg,       \
> +                                 _mshift, _mwidth, _dshift,            \
> +                                 _dwidth, _flags)                      \
> +       SPRD_COMP_CLK_DATA_TABLE_OFFSET(_struct, _name, _parent, _reg,  \
> +                                       NULL, _mshift, _mwidth,         \
> +                                       _dshift, _dwidth,  _flags)
>
>  static inline struct sprd_comp *hw_to_sprd_comp(const struct clk_hw *hw)
>  {
> diff --git a/drivers/clk/sprd/div.c b/drivers/clk/sprd/div.c
> index c7261630cab4..0fb41d653f1e 100644
> --- a/drivers/clk/sprd/div.c
> +++ b/drivers/clk/sprd/div.c
> @@ -25,7 +25,7 @@ unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
>         unsigned long val;
>         unsigned int reg;
>
> -       regmap_read(common->regmap, common->reg, &reg);
> +       regmap_read(common->regmap, common->reg - div->offset, &reg);

Generally offset should be an increase based on reg, but it is converse here.

>         val = reg >> div->shift;
>         val &= (1 << div->width) - 1;
>
> @@ -53,10 +53,10 @@ int sprd_div_helper_set_rate(const struct sprd_clk_common *common,
>         val = divider_get_val(rate, parent_rate, NULL,
>                               div->width, 0);
>
> -       regmap_read(common->regmap, common->reg, &reg);
> +       regmap_read(common->regmap, common->reg - div->offset, &reg);
>         reg &= ~GENMASK(div->width + div->shift - 1, div->shift);
>
> -       regmap_write(common->regmap, common->reg,
> +       regmap_write(common->regmap, common->reg - div->offset,
>                           reg | (val << div->shift));
>
>         return 0;
> diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
> index f5d614b3dcf1..db6b62ee6a8d 100644
> --- a/drivers/clk/sprd/div.h
> +++ b/drivers/clk/sprd/div.h
> @@ -20,12 +20,14 @@
>   * classes.
>   */
>  struct sprd_div_internal {
> +       u32     offset;

I suggest changing the type to 'signed' int, which would cover the
cases no matter whether the divider register offset is up or down
based on the mux register address. That would be more flexible.

Thanks,
Chunyan

>         u8      shift;
>         u8      width;
>  };
>
> -#define _SPRD_DIV_CLK(_shift, _width)  \
> +#define _SPRD_DIV_CLK(_offset, _shift, _width) \
>         {                               \
> +               .offset = _offset,      \
>                 .shift  = _shift,       \
>                 .width  = _width,       \
>         }
> @@ -35,10 +37,10 @@ struct sprd_div {
>         struct sprd_clk_common  common;
>  };
>
> -#define SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,         \
> +#define SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _offset,        \
>                                 _shift, _width, _flags, _fn)            \
>         struct sprd_div _struct = {                                     \
> -               .div    = _SPRD_DIV_CLK(_shift, _width),                \
> +               .div    = _SPRD_DIV_CLK(_offset, _shift, _width),       \
>                 .common = {                                             \
>                         .regmap         = NULL,                         \
>                         .reg            = _reg,                         \
> @@ -49,12 +51,17 @@ struct sprd_div {
>
>  #define SPRD_DIV_CLK(_struct, _name, _parent, _reg,                    \
>                      _shift, _width, _flags)                            \
> -       SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,          \
> +       SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, 0x0,     \
>                                 _shift, _width, _flags, CLK_HW_INIT)
>
> +#define SPRD_DIV_CLK_FW_NAME(_struct, _name, _parent, _reg,            \
> +                       _shift, _width, _flags)                         \
> +       SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, 0x0,     \
> +                               _shift, _width, _flags, CLK_HW_INIT_FW_NAME)
> +
>  #define SPRD_DIV_CLK_HW(_struct, _name, _parent, _reg,                 \
>                         _shift, _width, _flags)                         \
> -       SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,          \
> +       SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, 0x0,     \
>                                 _shift, _width, _flags, CLK_HW_INIT_HW)
>
>  static inline struct sprd_div *hw_to_sprd_div(const struct clk_hw *hw)
> --
> 2.17.1
>
