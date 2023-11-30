Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD26B7FE676
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjK3CDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3CDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:03:17 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656D1B3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:03:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b3b819f8a3so9212839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701309802; x=1701914602; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMHvFiMROSG+UECf9EDgEvz9utpLKQRQIUCySBf/XdM=;
        b=CWzQ1udrJIppsx2FCyEVGlvaGszNZBW8Tmt8FYCKNJwRc2A5mKWobPn/jbt8k10uYQ
         RuNGfFd4XY6IJsN3RDFMmyt1LeY9yk6Ig0/sMVC+rDdfpM8aEya09mmyVDQXSBB80rd5
         +EigSKiIso8TY+Wt+AuFVQahud84VIPJ8Ccq1+HccUUHt+jnlngjtfEKYAYkdWfRYHg/
         19qba0x2KGrO6SACz8hPO3/eYkVLltItoUgaKn0cXF7SI3cTGfREBZoRUTazP8D//BMF
         1ZyDHCDIqQYC98eZ4ovdorxcdfhOS74zJGZrsztbCmy60PmKmy1VoNwZGovEm+rcrAj0
         9XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701309802; x=1701914602;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMHvFiMROSG+UECf9EDgEvz9utpLKQRQIUCySBf/XdM=;
        b=MCG2jKVbVCeWhGEHV8A2nz7POEgpnX/B3OC1gOw/Yp+N83cWeu9WR9wk2ltlNxyzZc
         VErmWnLYMjj8b3o4kHEoVeT5yvvZHOXFVDoXqL8Zp3Dwa6oT8l47Y3DjLoD+FPoqk4y+
         w8tL+uITMfJAsj8fMDhXEBHPusOOayeaLxs2S6jnRR/neI7jt/72j/9eOmsRVPu0Xhom
         WDYTi34E7j/27sBZCGmivsMPRCIr8t6WRfjxEYIAa1p8J62QGjMRv28FS2CWV6Oe3vvS
         30kPDS8z75u+z+kkCyTs3W5Hr+Ma2l5ernZ7WjWmIkKLZil4jMLeEpPHMoRhnWdejw8X
         YIQQ==
X-Gm-Message-State: AOJu0YwPCJFJLWos3izgDFMqG8+Q/ysJ3kHb0h5Xz9QTZW0J5Mw6laTO
        aDbTkZhvbOmgJBH9G93k0dvb6I2w/7MZvz7dxnTZZA==
X-Google-Smtp-Source: AGHT+IGHdHZ22CvUdt56tBi04dJ6xajGniHBuy2DMTqBS9U2zF1Nunoe8hZn2GjICroWye5/VnxpTjVuzljCoi9q3MM=
X-Received: by 2002:a05:6602:2285:b0:79f:dbec:ac4d with SMTP id
 d5-20020a056602228500b0079fdbecac4dmr21483885iod.19.1701309802205; Wed, 29
 Nov 2023 18:03:22 -0800 (PST)
MIME-Version: 1.0
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 30 Nov 2023 10:03:11 +0800
Message-ID: <CANXhq0rm0eTX8Ze8KdB-jqrw6Q3WC-jepqOCaZKgkSEKnQ-OFg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Invalid instruction cache after copy the xol area
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 18 May 2022 01:17:53 PDT (-0700), po-kai.chi@sifive.com wrote:
> > We need to invalid the relevant instruction cache after
> > copying the xol area, to ensure the changes takes effect.
> >
> > Signed-off-by: Po-Kai Chi <po-kai.chi@sifive.com>
> > ---
> >  arch/riscv/kernel/probes/uprobes.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> > index 7a057b5f0adc..9d52beeac73c 100644
> > --- a/arch/riscv/kernel/probes/uprobes.c
> > +++ b/arch/riscv/kernel/probes/uprobes.c
> > @@ -165,6 +165,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >       /* Initialize the slot */
> >       void *kaddr = kmap_atomic(page);
> >       void *dst = kaddr + (vaddr & ~PAGE_MASK);
> > +     unsigned long addr = (unsigned long)dst;
> >
> >       memcpy(dst, src, len);
> >
> > @@ -177,10 +178,9 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >       kunmap_atomic(kaddr);
> >
> >       /*
> > -      * We probably need flush_icache_user_page() but it needs vma.
> > -      * This should work on most of architectures by default. If
> > -      * architecture needs to do something different it can define
> > -      * its own version of the function.
> > +      * Flush both I/D cache to ensure instruction modification
> > +      * takes effect.
> >        */
> >       flush_dcache_page(page);
> > +     flush_icache_range(addr, addr + len);
> >  }
>
> This brings up a handful of issues:
>
> * This always inserts a 32-bit breakpoint, but that's not quite correct.
>   This should really be checking the _next_ instruction as well to
>   insert a 16-bit breakpoint if it's a 16-bit instruction as otherwise
>   userspace might jump into the middle of the breakpoint.
> * These instructions can be concurrently executing, which relies on some
>   instruction fetch ordering that's very lightly specified.  We don't
>   rely on that elsewhere (see stop_machine() in kprobes), but we
>   probably should.  It's probably worth adding something to probe the HW
>   to make sure this is supported.
> * Adding the icache flush defeats a uprobes advantage in that we'll now
>   be triggering remote execution (to do the remote fence.i).  One option
>   could be to defer the fence and wait on it, but not sure if that's
>   sane and it'd likely require a lot of
>
> This also leaves a bit undefined WRT icache aliasing, at least in terms
> of the API used.  IMO it'd be
>
>     diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
>     index 9d52beeac73c..c857346864fc 100644
>     --- a/arch/riscv/kernel/probes/uprobes.c
>     +++ b/arch/riscv/kernel/probes/uprobes.c
>     @@ -165,7 +165,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>         /* Initialize the slot */
>         void *kaddr = kmap_atomic(page);
>         void *dst = kaddr + (vaddr & ~PAGE_MASK);
>     -   unsigned long addr = (unsigned long)dst;
>
>         memcpy(dst, src, len);
>
>     @@ -179,8 +178,10 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>
>         /*
>          * Flush both I/D cache to ensure instruction modification
>     -    * takes effect.
>     +    * takes effect.  We don't need to flush the whole icache, but that's
>     +    * all RISC-V defines so rather than worry about aliasing this just
>     +    * flushes everything.
>          */
>         flush_dcache_page(page);
>     -   flush_icache_range(addr, addr + len);
>     +   flush_icache_all();
>      }
>
> which will end up doing the same thing but avoids the ambiguity.  I went
> ahead and put this at palmer/riscv-uprobe_fencei with that and some
> other minor things fixed up, LMK if that looks OK and I'll take it on
> fixes.
>

Hi Palmer,
Could I know if you have plans to include this fix in the upcoming RC
versions? Thanks

> Thanks!
