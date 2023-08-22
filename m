Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3757840D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjHVMag convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 08:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjHVMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:30:35 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC40CC6;
        Tue, 22 Aug 2023 05:30:32 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-591ba8bd094so28226167b3.3;
        Tue, 22 Aug 2023 05:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692707431; x=1693312231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEdxVNTi234IeBu9/mHN8tlhC03wKCbKIUsue9+Lnac=;
        b=ibiEjVl3q8Sus6COOoABXoT5Xb+E2o5i/m8mb+yD51DbXhf3VzrJbEA+B6ZBdJOWhb
         1huPvhsqdulKrl2IBp+obISA+hl0qhiSFFn5roFz+JeLAU2xxroNCsSxx45GYNveUBvA
         hTpH8uhwfoI2Bre5MzNWsLKEA5KG6PvCQX/k+WvPK6Ms5pXLxXMTE5gDCW4b5al7lB6S
         ZBXJM2sKCyZBbM2LeZnU5yH5w9mTU7rpFs3nGNkiWchPs28zNmYGQihgOQZsQUz7+5HK
         eFQpiMEfiHk/dduGbxkdttYj7R05YS8UOkEc6NC8r4zRqk7xtPgpqo2Kfx5mIhfwTTfD
         Bkrw==
X-Gm-Message-State: AOJu0YxVZRutOUUcX1aykPa/HBlXySnI7u+vppnrBs8Z8maPscu2lOrU
        Ad5rz7Doy/agnaT6F19gyZeCdM2wKeC7pQ==
X-Google-Smtp-Source: AGHT+IGR1mTIG39kiVb88hgmT+rATK+lNwQdkqjIs2Y/klit0w1NFXKOX5CHShvHXXkplckJOS6hbA==
X-Received: by 2002:a81:8886:0:b0:58e:2827:4d93 with SMTP id y128-20020a818886000000b0058e28274d93mr11496109ywf.38.1692707431041;
        Tue, 22 Aug 2023 05:30:31 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id m139-20020a0dca91000000b0058c55d40765sm301305ywd.106.2023.08.22.05.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 05:30:28 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5922b96c5fcso17915057b3.0;
        Tue, 22 Aug 2023 05:30:28 -0700 (PDT)
X-Received: by 2002:a25:bcc7:0:b0:d52:f4d7:5587 with SMTP id
 l7-20020a25bcc7000000b00d52f4d75587mr9783496ybm.31.1692707427833; Tue, 22 Aug
 2023 05:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230721221552.1973203-2-contact@jookia.org> <20230721221552.1973203-6-contact@jookia.org>
In-Reply-To: <20230721221552.1973203-6-contact@jookia.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Aug 2023 14:30:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2m54UAH0X2dG7stEg=grFihrdsz4+o7=_DpBMhjTbkw@mail.gmail.com>
Message-ID: <CAMuHMdV2m54UAH0X2dG7stEg=grFihrdsz4+o7=_DpBMhjTbkw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: sun4i_can: Add support for the Allwinner D1
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Sat, Jul 22, 2023 at 12:18 AM John Watts <contact@jookia.org> wrote:
> The controllers present in the D1 are extremely similar to the R40
> and require the same reset quirks, but An extra quirk is needed to support
> receiving packets.
>
> Signed-off-by: John Watts <contact@jookia.org>

Thanks for your patch, which is now commit 8abb95250ae6af2d ("can:
sun4i_can: Add support for the Allwinner D1") in linux-can-next/master.

> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -185,10 +185,10 @@ config CAN_SLCAN
>
>  config CAN_SUN4I
>         tristate "Allwinner A10 CAN controller"
> -       depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
> +       depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST

This makes this question pop up when configuring a kernel for any RISC-V
platform, not just for Allwinner RISC-V platforms.

In comparison, drivers/clk/sunxi-ng/Kconfig does have some

    depends on MACH_SUN<foo>I || RISCV || COMPILE_TEST

but these are gated by ARCH_SUNXI at the top of the file.

I'm not sure what's the best way to fix this:
  - Replace RISCV by ARCH_SUNXI?
    This would expose it on more ARM sun<foo>i platforms, making the
    MACH_SUN4I || MACH_SUN7I superfluous?
  - Replace RISCV by RISCV && ARCH_SUNXI?

Thanks for your comments!

>         help
>           Say Y here if you want to use CAN controller found on Allwinner
> -         A10/A20 SoCs.
> +         A10/A20/D1 SoCs.
>
>           To compile this driver as a module, choose M here: the module will
>           be called sun4i_can.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
