Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC257683C6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjG3FIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 01:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3FId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 01:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70DE46
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87DC560B94
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 05:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA341C433C8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 05:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690693710;
        bh=XpeJJeL0WZEhViGFyUqsZL1awMfqrIn2dAk+4dHsN/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IZ+cRMVQdtYhnnmfNb5b+pamm1g1ZYESKZ9wch6UkSvECZGGJ5uv8Hfo7mJxExgfH
         7WNSeQlq4QFappAaFFhAe/qDZo0KhRDhuadE3r7Hs75fXyah3AcIijt+rY0NWektVC
         vrg3nIUUf0J2r8QJJq2inKYLMcJIM6TX3uFqoNUaMwQ7z/anzFWbDXBvquaDbS17or
         LI69T67tOEn7xPXyYHo1pfG9bEEw+TycuMSv3dCiai0DhBpWhsbzLEvpGxeACbPTeq
         mLA75lOaTHfc83HFcirV6IBvSePbharTLI0VJ1+cnxuuRKWRWqKeoALfAXxe4J5pcH
         d0HBTvLoqVwbA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bdcade7fbso426808166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:08:30 -0700 (PDT)
X-Gm-Message-State: ABy/qLbejKjtNNGXBVyxQ2PTt5zOO+vx15LeymbeQ5UVpgL1Rifk1AXz
        TxMtsyG01qvSiFC4oLYFqG1SN/LJtvVMGkGkrUU=
X-Google-Smtp-Source: APBJJlG33jDViSYrDkErS/CQJtTrUVb2jig4MFHtRtnqUjG3GGtNTNTD7veq9WS1yay4/EUcPFaz61OsEcVQktlB8lc=
X-Received: by 2002:a17:906:101a:b0:99b:d9f3:9a98 with SMTP id
 26-20020a170906101a00b0099bd9f39a98mr3227051ejm.74.1690693709138; Sat, 29 Jul
 2023 22:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
In-Reply-To: <20230725132246.817726-1-alexghiti@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jul 2023 01:08:17 -0400
X-Gmail-Original-Message-ID: <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
Message-ID: <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The RISC-V kernel needs a sfence.vma after a page table modification: we
> used to rely on the vmalloc fault handling to emit an sfence.vma, but
> commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
> need to explicitly emit a sfence.vma in flush_cache_vmap().
>
> Note that we don't need to implement flush_cache_vunmap() as the generic
> code should emit a flush tlb after unmapping a vmalloc region.
>
> Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/mod=
ules area")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cacheflush.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
> index 8091b8bf4883..b93ffddf8a61 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page=
)
>  #define flush_icache_user_page(vma, pg, addr, len) \
>         flush_icache_mm(vma->vm_mm, 0)
>
> +#ifdef CONFIG_64BIT
> +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start, end=
)
Sorry, I couldn't agree with the above in a PIPT cache machine. It's
not worth for.

It would reduce the performance of vmap_pages_range,
ioremap_page_range ... API, which may cause some drivers' performance
issues when they install/uninstall memory frequently.

> +#endif
> +
>  #ifndef CONFIG_SMP
>
>  #define flush_icache_all() local_flush_icache_all()
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
