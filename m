Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC307BD548
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjJIIex convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjJIIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:34:51 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396D49F;
        Mon,  9 Oct 2023 01:34:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f6e6b206fso53460597b3.3;
        Mon, 09 Oct 2023 01:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696840487; x=1697445287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3OahYfdCxv80l6RdHzhMjxT84AMNbMTgSYeJWK9cGg=;
        b=FhaQ0bmWr4pGjG2fPNyJCsGhPuyMXXPxC8mQIQcLscNxOPT/stRjwu9vS7kiy7RZH4
         bOix44miWmmxfn4AvEbj+H00rTMXEkFp58rc2USHm3pllmD+3S1bVL5rgHuEGv/L/QGO
         YVPBJKJDkb957p9PrXiurUrmBlQfd4vEVMDvvmUu6g7KZ85JvS14t2K4nC98iCA4jyEV
         dz58wbZHB0px4tyCD+Rd4WwQUUvKXwHstbYQB51FYYBl+8eJersc83JQsb6/iQm15MHW
         EkNwlppEiC14EKSppf9con6hCftwgLYKofRq4vabp+Sf3D1zLI7gg1BCGRbBPAZEADQE
         3bug==
X-Gm-Message-State: AOJu0YxCt4+kgb0pZYNSRwmRtnRbfwfs/7fNqM5GFuQ69Xdxd6Se9mOa
        NYp+G8MMu+SA13gpZRxuCifqDHW4blOIcA==
X-Google-Smtp-Source: AGHT+IGLIT5L2LUhbRl/eEFCDJDZAyVnsDIz9LVzsCkhPnmfExrcAwF7iiJKW0tB6UUA/552jnxY8g==
X-Received: by 2002:a81:4f94:0:b0:59f:5dc3:9fac with SMTP id d142-20020a814f94000000b0059f5dc39facmr15773219ywb.6.1696840487262;
        Mon, 09 Oct 2023 01:34:47 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id m188-20020a0dcac5000000b0059beb468cb4sm3520024ywd.1.2023.10.09.01.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:34:46 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59f6e6b206fso53460437b3.3;
        Mon, 09 Oct 2023 01:34:46 -0700 (PDT)
X-Received: by 2002:a81:d24f:0:b0:5a1:d398:2e with SMTP id m15-20020a81d24f000000b005a1d398002emr18003738ywl.37.1696840486754;
 Mon, 09 Oct 2023 01:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-sandbar-botch-0f398fd2e289@wendy>
In-Reply-To: <20231009-sandbar-botch-0f398fd2e289@wendy>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 10:34:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVojwgOP8bqHobgbsgUA+7yxUA7v5M6Z800zxrCeuxZjg@mail.gmail.com>
Message-ID: <CAMuHMdVojwgOP8bqHobgbsgUA+7yxUA7v5M6Z800zxrCeuxZjg@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: select ERRATA_ANDES for R9A07G043 only when
 alternatives are present
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-renesas-soc@vger.kernel.org, conor@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

Hi Conor,

On Mon, Oct 9, 2023 at 10:12 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> Randy reported a randconfig build issue against linux-next:
> WARNING: unmet direct dependencies detected for ERRATA_ANDES
>   Depends on [n]: RISCV_ALTERNATIVE [=n] && RISCV_SBI [=y]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_SBI [=y]
>
> ../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
>    59 | void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>
> On RISC-V, alternatives are not usable in XIP kernels, which this
> randconfig happened to select. Add a check for whether alternatives are
> available before selecting the ERRATA_ANDES config option.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -343,7 +343,7 @@ config ARCH_R9A07G043
>         select ARCH_RZG2L
>         select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
>         select DMA_GLOBAL_POOL
> -       select ERRATA_ANDES if RISCV_SBI
> +       select ERRATA_ANDES if (RISCV_SBI && RISCV_ALTERNATIVE)

Perhaps ARCH_R9A07G043 should depend on RISCV_ALTERNATIVE (and
RISCV_SBI) instead?  It's not like RZ/Five is gonna work without the
Andes errata handling present (unless all of them are related to cache
handling, and we can run uncached; also see below)).

>         select ERRATA_ANDES_CMO if ERRATA_ANDES

And then this "if" can go as well.

Any other hard dependencies?
E.g. can RZ/Five work without RISCV_DMA_NONCOHERENT?

>         help
>           This enables support for the Renesas RZ/Five SoC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
