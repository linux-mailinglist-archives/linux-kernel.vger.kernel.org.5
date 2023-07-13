Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8C75152B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjGMAW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjGMAWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30CB1995
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8172F619DD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E6C433C9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689207731;
        bh=53e5HYBjtna0vDGuXWnqkXj1xC6mo6JvkjpwJaby3Ao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AzoIx9wHr3k9qSvB2A0Oa+wbKH7XCUqJH4G43N6TSHrCYKxWJowsngbt3Rw2wbh3q
         QACJGzVwnmet9xVQeMLQdMOpv/HhjVdBnk9tABq8IykZCFG1+M+VL5qZ27Ci2upwLJ
         LSiMKH0+36tu63CFGDtMHP25NRHDkb/C9+1FbJBnS3zu6HvGLZnXeLoQnOmKH9uuQ7
         8xF8jpV6fEFwO4AtG/aKlqlr3HhUPnfxSdPCi7aGijwx5TNcnxIuu0Qga1yCsu7kSQ
         zpGoVINKzKaRH8yjy4SBsBqPwrMthjGXHFBn77ww0sCmo79BLg8u8wg//XBZvQMkhS
         kMZwX52emSv6Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso228809e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:22:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLZFbt8UVNdXJIRRu7o2lSnbhPqaSbrK6d0Fj5cEN3N4bEexkzRP
        3xQq3oundDYEz8tKGhFHnJEjDnbpDpCImquQwEc=
X-Google-Smtp-Source: APBJJlGB+/ycMH8jAxFyzWVEpdJwmx4SCYYeZsQvOAEUuyfzZoM/VwHrjCsO+dmLZaIEHnImNesMHW8I6SxbrUlMhh8=
X-Received: by 2002:a19:7b11:0:b0:4f8:6600:4074 with SMTP id
 w17-20020a197b11000000b004f866004074mr18043887lfc.17.1689207729930; Wed, 12
 Jul 2023 17:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230628131442.3022772-1-sameo@rivosinc.com> <20230628131442.3022772-4-sameo@rivosinc.com>
In-Reply-To: <20230628131442.3022772-4-sameo@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 12 Jul 2023 20:21:58 -0400
X-Gmail-Original-Message-ID: <CAJF2gTTc3O+RYmwtfLe0M1D58LH8fXGWMrJLYxjx17aHakAZUQ@mail.gmail.com>
Message-ID: <CAJF2gTTc3O+RYmwtfLe0M1D58LH8fXGWMrJLYxjx17aHakAZUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Implement archrandom when Zkr is available
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 9:15=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.com> w=
rote:
>
> The Zkr extension is ratified and provides 16 bits of entropy seed when
> reading the SEED CSR.
>
> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> that CSR and filling an unsigned long with valid entropy bits.
>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  arch/riscv/include/asm/archrandom.h | 70 +++++++++++++++++++++++++++++
>  arch/riscv/include/asm/csr.h        |  9 ++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 arch/riscv/include/asm/archrandom.h
>
> diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm=
/archrandom.h
> new file mode 100644
> index 000000000000..8987cd0b891d
> --- /dev/null
> +++ b/arch/riscv/include/asm/archrandom.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Kernel interface for the RISCV arch_random_* functions
> + *
> + * Copyright (c) 2023 by Rivos Inc.
> + *
> + */
> +
> +#ifndef ASM_RISCV_ARCHRANDOM_H
> +#define ASM_RISCV_ARCHRANDOM_H
> +
> +#include <asm/csr.h>
> +
> +#define SEED_RETRY_LOOPS 10
> +
> +static inline bool __must_check csr_seed_long(unsigned long *v)
> +{
> +       unsigned int retry =3D SEED_RETRY_LOOPS, valid_seeds =3D 0;
> +       const int needed_seeds =3D sizeof(long) / sizeof(u16);
> +       u16 *entropy =3D (u16 *)v;
> +
> +       do {
> +               /*
> +                * The SEED CSR (0x015) must be accessed with a read-writ=
e
> +                * instruction.
> +                */
> +               unsigned long csr_seed =3D csr_swap(CSR_SEED, 0);
> +
> +               switch (csr_seed & SEED_OPST_MASK) {
> +               case SEED_OPST_ES16:
> +                       entropy[valid_seeds++] =3D csr_seed & SEED_ENTROP=
Y_MASK;
> +                       if (valid_seeds =3D=3D needed_seeds)
max_longs =3D 1? needed_seeds only could be 2/4.

> +                               return true;
> +                       break;
> +
> +               case SEED_OPST_DEAD:
> +                       pr_err_once("archrandom: Unrecoverable error\n");
Do we need this pr_err? Could we treat it as a return false? Yes, it's
a hardware problem, but not serious.

> +                       return false;
> +
> +               case SEED_OPST_BIST:
> +               case SEED_OPST_WAIT:
> +               default:
> +                       continue;
> +               }
> +       } while (--retry);
> +
> +       return false;
> +}
> +
> +static inline size_t __must_check arch_get_random_longs(unsigned long *v=
, size_t max_longs)
> +{
> +       return 0;
> +}
> +
> +static inline size_t __must_check arch_get_random_seed_longs(unsigned lo=
ng *v, size_t max_longs)
> +{
> +       if (!max_longs )
if (max_longs =3D=3D 1) ?
> +               return 0;
> +
> +       /*
> +        * If Zkr is supported and csr_seed_long succeeds, we return one =
long
> +        * worth of entropy.
> +        */
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_lon=
g(v))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +#endif /* ASM_RISCV_ARCHRANDOM_H */
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index b98b3b6c9da2..7d0ca9082c66 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -389,6 +389,15 @@
>  #define CSR_VTYPE              0xc21
>  #define CSR_VLENB              0xc22
>
> +/* Scalar Crypto Extension - Entropy */
> +#define CSR_SEED               0x015
> +#define SEED_OPST_MASK         _AC(0xC0000000, UL)
> +#define SEED_OPST_BIST         _AC(0x00000000, UL)
> +#define SEED_OPST_WAIT         _AC(0x40000000, UL)
> +#define SEED_OPST_ES16         _AC(0x80000000, UL)
> +#define SEED_OPST_DEAD         _AC(0xC0000000, UL)
> +#define SEED_ENTROPY_MASK      _AC(0xFFFF, UL)
> +
>  #ifdef CONFIG_RISCV_M_MODE
>  # define CSR_STATUS    CSR_MSTATUS
>  # define CSR_IE                CSR_MIE
> --
> 2.41.0
>

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
