Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A30774F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjHHXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHHXrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C457F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D1B62E4B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81503C433D9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691538463;
        bh=389UaCJRCPWbGhB538d72pDJuAiVDJ/Ht7Zki/SMrHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z7Ax2CJ1h6ttitp46s+XIWct3qdaEHuFoRUIICdcSOQfk5ZGeIoHwmYAcxnTg3nGZ
         zLzKcMgvEebiIhvKgbEytj99g/mj94rgeGhh1vL/KRSmVyg6JtwbzlBukKkVGFN327
         On7fungrwYtaOW6Hod6BYnuyzfzNyETzGUHgCfty1Km/V4DeRjdB4B6VapNdI/4Mho
         kEyK7ZKcLJO7Ulr248KHrhE4L6AHfDjqRN4w/a9mlBMYIH56LJ7bn/w4K5S981dip7
         GbzyTd6ddQAsTD+9f/NjoRozXmEHh7CTEFsm6jtKSf01ea3P7grGxW/3d06E8xKEXx
         x+eBNwKsq+x/A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c47ef365cso919805066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:47:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YxfsnZir6uChwIEfRyWb+QFkrftFpD3jaeoJLedPYnLP8CHqyTh
        mEeH7L2dK0B2nOA1WNVkRk5zzXrKKrJpMEJO7kY=
X-Google-Smtp-Source: AGHT+IF8GwQocRR0UF6D0EtxHHZUG5eeMP9PHbArq+HL2uAklIhtaIJ4aeif2R8AnJ7MNJZXVG3HcpN5x1NgHJP3sqs=
X-Received: by 2002:a17:906:84:b0:99b:674c:44eb with SMTP id
 4-20020a170906008400b0099b674c44ebmr945758ejc.9.1691538461697; Tue, 08 Aug
 2023 16:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com> <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
In-Reply-To: <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Aug 2023 07:47:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRfaHngCtLmuQY967qo_kpitKqYXxDA5bA3FaF5kWz8Mg@mail.gmail.com>
Message-ID: <CAJF2gTRfaHngCtLmuQY967qo_kpitKqYXxDA5bA3FaF5kWz8Mg@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
To:     dylan <dylan@andestech.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:14=E2=80=AFPM dylan <dylan@andestech.com> wrote:
>
> On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > The RISC-V kernel needs a sfence.vma after a page table modification:=
 we
> > > used to rely on the vmalloc fault handling to emit an sfence.vma, but
> > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > vmalloc/modules area") got rid of this path for 64-bit kernels, so no=
w we
> > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > >
> > > Note that we don't need to implement flush_cache_vunmap() as the gene=
ric
> > > code should emit a flush tlb after unmapping a vmalloc region.
> > >
> > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc=
/modules area")
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include=
/asm/cacheflush.h
> > > index 8091b8bf4883..b93ffddf8a61 100644
> > > --- a/arch/riscv/include/asm/cacheflush.h
> > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *=
page)
> > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > >         flush_icache_mm(vma->vm_mm, 0)
> > >
> > > +#ifdef CONFIG_64BIT
> > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start,=
 end)
> > Sorry, I couldn't agree with the above in a PIPT cache machine. It's
> > not worth for.
> >
> > It would reduce the performance of vmap_pages_range,
> > ioremap_page_range ... API, which may cause some drivers' performance
> > issues when they install/uninstall memory frequently.
> >
>
> Hi All,
>
> I think functional correctness should be more important than system perfo=
rmance
> in this case. The "preventive" SFENCE.VMA became necessary due to the RIS=
C-V
> specification allowing invalidation entries to be cached in the TLB.
>
> The problem[1] we are currently encountering is caused by not updating th=
e TLB
> after the page table is created, and the solution to this problem can onl=
y be
> solved by updating the TLB immediately after the page table is created.
>
> There are currently two possible approaches to flush TLB:
> 1. Flush TLB in flush_cache_vmap()
> 2. Flush TLB in arch_sync_kernel_mappings()
>
> But I'm not quite sure if it's a good idea to operate on the TLB inside f=
lush_cache_vmap().
> The name of this function indicates that it should be related to cache op=
erations, maybe
> it would be more appropriate to do TLB flush in arch_sync_kernel_mappings=
()?
>
> [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.=
html
Not all machines need it, and some CPUs prevent PTE.V=3D0 into TLB
during PTW, which is stronger than ISA's requirement.

So could we put an errata alternative here?

>
> Best regards,
> Dylan
>
> > > +#endif
> > > +
> > >  #ifndef CONFIG_SMP
> > >
> > >  #define flush_icache_all() local_flush_icache_all()
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Best Regards
 Guo Ren
