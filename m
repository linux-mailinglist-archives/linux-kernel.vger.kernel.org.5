Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E7786507
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbjHXCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjHXCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:03:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66502E59;
        Wed, 23 Aug 2023 19:03:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so5419096a12.3;
        Wed, 23 Aug 2023 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692842596; x=1693447396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjL4sAUr98Mmw/HylBqttyHvxUAokrUFQ9c9iDys8rc=;
        b=DDQQRb6i+/RmSqq8pC6lSxh1ppqw+AzLRtz8pPT4Kjueblo7Sj3TNfY8Peq5OE6kvB
         aKxd59n5q6KAYj8VWwFBwTI1VvKpXYs3EIaFe8LT9n8YRLkaHRvNdAWBeyXtyIy4IC43
         sXGFbLQYnmFfLxPQZZbUFTROz4Dir++W7hA0xxxVndNorPNf/TOrjq/CND6TpwVg4BA6
         RtyNupidcLw2YvOIdJTIcB9VI6aLq51BB5u2wXLkgRASos2Y22QSWbKBOSD5cI9BuRpf
         7dAKi//14Grrj/erqwB08uvMpP20XVl39NFy/lyRrBClE8qTrBQpmFNiVqOKY1/3PkAT
         t4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842596; x=1693447396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjL4sAUr98Mmw/HylBqttyHvxUAokrUFQ9c9iDys8rc=;
        b=IUgwt/lN9kVExkvsxujx6npERtIExMJiCeiZAWzir2MPUWzCR52ynFxC/udy7bh8m+
         Xv+X0hPBpO0GrCwTv8RO5ngnG8Ov7sk9VRFQLxoTUZvj9rLY+f8KHmo96eCRF46tanrH
         gZiKvzIne5LGpiF/G2UV5vcnhw2d6UOhaLgrJ/0bWU/S4+Yfj+qkZZicdr4Q9oyPnmlY
         zR9g0EVHz0rRGewzLEkUrRn2Rky8dAz7qO19uYMMzrq4MCn8lg7dchlyWO0ncGUPi3D6
         HdWRC1ZDAZXsntD3OTibXPuvc0v+Vibg/hC4gtDJMxGz/1+2Kx1tkoVEQ4f0A8uGd+xP
         njGg==
X-Gm-Message-State: AOJu0YxKSqXrWACOL59wK2mxBxsMa88Yl4nIq+Y/hwQQtyMdWH7GLbSo
        LE85YQraq+KMyYxeWCz0U1saEtT1n5qTWhQr8/s=
X-Google-Smtp-Source: AGHT+IFMkPUHd4p3R7g3gP5YQveLKoBN3UibfETlMIC5FUxaH9SkdjYRlAYQV5QLrY155SkpaQqYgxExgzXbdvq70WM=
X-Received: by 2002:a17:906:255a:b0:99c:47a:8bcd with SMTP id
 j26-20020a170906255a00b0099c047a8bcdmr9576794ejb.67.1692842595616; Wed, 23
 Aug 2023 19:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230805064820.30305-1-zhifeng.tang@unisoc.com>
In-Reply-To: <20230805064820.30305-1-zhifeng.tang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 24 Aug 2023 10:02:38 +0800
Message-ID: <CAAfSe-u2WiMUzyh71ZcMAS_Q+_Uo4skHahMbLNsU1xeUncnpSA@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: Fix thm_parents incorrect configuration
To:     Zhifeng Tang <zhifeng.tang@unisoc.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Cixi Geng <cixi.geng1@unisoc.com>, linux-clk@vger.kernel.org,
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

On Sat, 5 Aug 2023 at 14:48, Zhifeng Tang <zhifeng.tang@unisoc.com> wrote:
>
> The thm*_clk have two clock sources 32k and 250k,excluding 32m.
>
> Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/clk/sprd/ums512-clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
> index fc25bdd85e4e..f43bb10bd5ae 100644
> --- a/drivers/clk/sprd/ums512-clk.c
> +++ b/drivers/clk/sprd/ums512-clk.c
> @@ -800,7 +800,7 @@ static SPRD_MUX_CLK_DATA(uart1_clk, "uart1-clk", uart_parents,
>                          0x250, 0, 3, UMS512_MUX_FLAG);
>
>  static const struct clk_parent_data thm_parents[] = {
> -       { .fw_name = "ext-32m" },
> +       { .fw_name = "ext-32k" },
>         { .hw = &clk_250k.hw  },
>  };
>  static SPRD_MUX_CLK_DATA(thm0_clk, "thm0-clk", thm_parents,
> --
> 2.17.1
>
