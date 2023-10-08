Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1087BCDBE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbjJHKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjJHKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:11:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED58C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:11:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA90C433CD
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696759903;
        bh=anTSxeHmgVC+wUa5CZQEweK0ru9RY3rK8/qOldhQRI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jyWUMXP2C7qQ5bvF80TgLwAiwvxjiu35k7JKjmr2yc3gz1o/VIY/DVg3xgkS8S5KO
         fpqjleX6D+NA0ih2ktqp43aJn7Bck74y6drzG5yXQyJ0xjUU70Dcgw4YD+fMfHwMl2
         KxjV5+lMjhY0M2BP4ElnDs3ohYBhWWPAvAazkzZ2kHAc9Q2YH3MCh2LDtGdX5+fdlD
         x6+6er4nuf/BE9MM0CqXsy7zr75uzH7RDnh51uzYBUMJ9XZhoT9KG5429ZPJRiItaz
         UlaZEakhHG0pZCMl9mIsjEIRnMgfaC5skSnJtFm07V4M8AWJUcjRoxUKNK8acLJqMD
         yoC3UFHVqt/tw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso6386401a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:11:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YxViakuErdpiLbGFCNJR03+rW9tt5dxzbL05b85yXlGHj58A8eT
        8lelYOGTk1QZoPovWz4WsvdKhlayJikQBq6HGNU=
X-Google-Smtp-Source: AGHT+IEZh4FpuUW0n0QqCNDBpXRuPHCr5YjuwnacjFnzmcOW2Lym8q8t50grRMgRb78Xrb/5TbjwLsbVz6ZeN5wzrHU=
X-Received: by 2002:a05:6402:78c:b0:522:3a0d:38c2 with SMTP id
 d12-20020a056402078c00b005223a0d38c2mr11555622edy.9.1696759901490; Sun, 08
 Oct 2023 03:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231001103433.3187-1-jszhang@kernel.org> <20231001103433.3187-3-jszhang@kernel.org>
In-Reply-To: <20231001103433.3187-3-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 8 Oct 2023 18:11:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSUku1TNLT2aOe0zhdwrrD6+7boSEs+8Rtr6MLntd36AQ@mail.gmail.com>
Message-ID: <CAJF2gTSUku1TNLT2aOe0zhdwrrD6+7boSEs+8Rtr6MLntd36AQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: errata: thead: use pa based instructions
 for CMO
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sun, Oct 1, 2023 at 6:46=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> T-HEAD CPUs such as C906/C910/C920 support phy address based CMO, use
> them so that we don't need to convert to virt address.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/errata/thead/errata.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index 3fefeb1b456e..632557f36b19 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -58,9 +58,9 @@ static bool errata_probe_pbmt(unsigned int stage,
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000000    11001     00000      000      00000  0001011
>   */
> -#define THEAD_inval_A0 ".long 0x0265000b"
> -#define THEAD_clean_A0 ".long 0x0255000b"
> -#define THEAD_flush_A0 ".long 0x0275000b"
> +#define THEAD_inval_A0 ".long 0x02a5000b"
> +#define THEAD_clean_A0 ".long 0x0295000b"
> +#define THEAD_flush_A0 ".long 0x02b5000b"
>  #define THEAD_SYNC_S   ".long 0x0190000b"
>
>  #define THEAD_CMO_OP(_op, _start, _size, _cachesize)                   \
> @@ -79,23 +79,17 @@ asm volatile("mv a0, %1\n\t"                         =
                       \
>
>  static void thead_errata_cache_inv(phys_addr_t paddr, size_t size)
>  {
> -       void *vaddr =3D phys_to_virt(paddr);
> -
> -       THEAD_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> +       THEAD_CMO_OP(inval, paddr, size, riscv_cbom_block_size);
>  }
>
>  static void thead_errata_cache_wback(phys_addr_t paddr, size_t size)
>  {
> -       void *vaddr =3D phys_to_virt(paddr);
> -
> -       THEAD_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +       THEAD_CMO_OP(clean, paddr, size, riscv_cbom_block_size);
>  }
>
>  static void thead_errata_cache_wback_inv(phys_addr_t paddr, size_t size)
>  {
> -       void *vaddr =3D phys_to_virt(paddr);
> -
> -       THEAD_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +       THEAD_CMO_OP(flush, paddr, size, riscv_cbom_block_size);
>  }
>
>  static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops =3D {
> --
> 2.40.1
>
Thx, Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
