Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25276C0C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjHAXUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E852103
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58C2D6176E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9D1C433CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690932027;
        bh=ZOeGcgWaXxL8wuJgurZ4REa3i8T6uB8qhuJywzbdmLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPmiaR1yH2dH1mzCRYahn8YlHiWivScDx9PpXotQrLCNxgcRLf9s8PVglkY/PbCS2
         j2Qy6jwLbDwlkz5I1zVZHhNJuDVCpeaOenYNveo+5RB18Usp8LQ0hEDvh7jQmXrRX4
         BFskpt+xWSMJtb84SR59FesSFH6IFGUjZseR1Mi4ugXdWcT1FBNBKE81nsFiV8/vXt
         B34frGrRdJFBxcQ0yBa33BlwBXBTRWYk7MLEw2ZeUZUdwx06iywkDY5Nbo/cO5rotq
         G8YRxJ6KVsCE5dlH3okgPlzgBUWnS3Z5XzQsTt8Oq1LOqLRMnvsmfcCPJVQa8A4Xgh
         X9WKSqPtfCxmA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so667211a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 16:20:27 -0700 (PDT)
X-Gm-Message-State: ABy/qLas9hqH90BoxQJpYNUPkZKHyzopQF6dcX29+8Ye1vGrgpqdfBD8
        /2pXvcphEOgLaLDcB/TYn68N19GoGHRjCyr2x+A=
X-Google-Smtp-Source: APBJJlG2Jz5+Ht3aUrbh9y9w1k/w4uNbdCHSctd/waCLLP2ugvWE7le66rEWjh9fBF03E2qmRF5NOiKj2dOZ3e0GMgk=
X-Received: by 2002:a17:907:961f:b0:988:d841:7f90 with SMTP id
 gb31-20020a170907961f00b00988d8417f90mr4861360ejc.27.1690932025958; Tue, 01
 Aug 2023 16:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801111014.1432679-1-suagrfillet@gmail.com> <CAHVXubgv1xmH7ZF9WsBQ=hYYk1PpKH5PUmYnSH1QTU-Jg1=xOA@mail.gmail.com>
In-Reply-To: <CAHVXubgv1xmH7ZF9WsBQ=hYYk1PpKH5PUmYnSH1QTU-Jg1=xOA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Aug 2023 19:20:14 -0400
X-Gmail-Original-Message-ID: <CAJF2gTR-OTfbYVZD2uWm4GFOxbva_OpR70tbhYf197bX+yngRQ@mail.gmail.com>
Message-ID: <CAJF2gTR-OTfbYVZD2uWm4GFOxbva_OpR70tbhYf197bX+yngRQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Correct the MODULES_VADDR
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, sergey.matyukevich@syntacore.com,
        david@redhat.com, wangkefeng.wang@huawei.com,
        panqinglin2020@iscas.ac.cn, woodrow.shen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 8:05=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Hi Song,
>
> On Tue, Aug 1, 2023 at 1:10=E2=80=AFPM Song Shuai <suagrfillet@gmail.com>=
 wrote:
> >
> > As Documentation/riscv/vm-layout.rst describes, the 2G-sized "modules, =
BPF"
> > area should lie right before the "kernel" area. But the current definit=
ion
> > of MODULES_VADDR isn't consistent with that, so correct it.
> >
> > Before this patch, the size of "modules" from print_vm_layout() is not =
2G.
> >
> > [    0.000000]      modules : 0xffffffff2ff2f000 - 0xffffffffae600000 (=
2022 MB)
> > [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000 (=
1024 MB)
> > [    0.000000]       kernel : 0xffffffffae600000 - 0xffffffffffffffff (=
1305 MB)
> >
> > After this patch, the size is 2G.
> >
> > [    0.000000]      modules : 0xffffffff3a000000 - 0xffffffffba000000 (=
2048 MB)
> > [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000 (=
1024 MB)
> > [    0.000000]       kernel : 0xffffffffba000000 - 0xffffffffffffffff (=
1119 MB)
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 75970ee2bda2..7c57e17fc758 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -53,8 +53,8 @@
> >  #ifdef CONFIG_64BIT
> >  /* This is used to define the end of the KASAN shadow region */
> >  #define MODULES_LOWEST_VADDR   (KERNEL_LINK_ADDR - SZ_2G)
> > -#define MODULES_VADDR          (PFN_ALIGN((unsigned long)&_end) - SZ_2=
G)
> >  #define MODULES_END            (PFN_ALIGN((unsigned long)&_start))
> > +#define MODULES_VADDR          (MODULES_END - SZ_2G)
> >  #endif
> >
> >  /*
> > --
> > 2.20.1
> >
>
> The documentation is approximative, the modules must stay within a 2GB
> window to *all* the kernel symbols, hence the __end - 2G, not __start.
Thus, the ftrace detour trampoline could cover all kernel symbols.

--=20
Best Regards
 Guo Ren
