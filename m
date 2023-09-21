Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E47AA524
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjIUWey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjIUWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:34:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9E91;
        Thu, 21 Sep 2023 15:34:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F8C433B7;
        Thu, 21 Sep 2023 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695335672;
        bh=fncpICFIZJhs+CFipAysf+2ViMsb5Ntfqci2xnszhTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mfa0wr7Z0lJ3IA4HjAqOtrk9SSrWWB+YGbaJc16KYeVVOnawrEHs3dy+iDauvghvS
         XAHLDo1Oga4nzW8Yi1caKnTTFJMqd7AtLKV54l/hFjnIDnOa7YaUJG8OwSNQt6PDO1
         7A+xKgOCxHubIbnNN8HZ22TUVPtwpthTbmR6DHRJsZoaCg1nFEuNlqOAO63MKUXx9I
         SVjAKnxkUVKeWQXgqE8UM2tHBIJCB/eo8eJdbedgXyDGRo4W6Xudl4FTLuPEDPrLWB
         k28dHj46DhheR/Wrwnz4X+g5x8ZjJWpuI68P2lkJi7EwbKR/MM3KSc5SviEdI3D0pl
         RSPtrB9bT5Klg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so2475989e87.1;
        Thu, 21 Sep 2023 15:34:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YxkPH9yPeEzUjolYs2nLgmIYm5KeOqZ5uYnB5mOKuU+CKwC7sG8
        LVNp9039AwQpDHQGRruHF22jJea51vSNxJYxToc=
X-Google-Smtp-Source: AGHT+IFZJtrM0/Sc4i9G46WkcXtuEGlwSrtGZZ9iCEr70spXydIPXGtt7clCqr3CvwCB3MyRIs3nmXQD2zetfl7/+As=
X-Received: by 2002:a19:6445:0:b0:503:3446:8ef5 with SMTP id
 b5-20020a196445000000b0050334468ef5mr4362567lfj.10.1695335670837; Thu, 21 Sep
 2023 15:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-3-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-3-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 15:34:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
Message-ID: <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and execmem_free()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>

[...]

> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index 42215f9404af..db5561d0c233 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -21,6 +21,7 @@
>  #include <linux/moduleloader.h>
>  #include <linux/bug.h>
>  #include <linux/memory.h>
> +#include <linux/execmem.h>
>  #include <asm/alternative.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/facility.h>
> @@ -76,7 +77,7 @@ void *module_alloc(unsigned long size)
>  #ifdef CONFIG_FUNCTION_TRACER
>  void module_arch_cleanup(struct module *mod)
>  {
> -       module_memfree(mod->arch.trampolines_start);
> +       execmem_free(mod->arch.trampolines_start);
>  }
>  #endif
>
> @@ -510,7 +511,7 @@ static int module_alloc_ftrace_hotpatch_trampolines(s=
truct module *me,
>
>         size =3D FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
>         numpages =3D DIV_ROUND_UP(size, PAGE_SIZE);
> -       start =3D module_alloc(numpages * PAGE_SIZE);
> +       start =3D execmem_text_alloc(EXECMEM_FTRACE, numpages * PAGE_SIZE=
);

This should be EXECMEM_MODULE_TEXT?

Thanks,
Song

>         if (!start)
>                 return -ENOMEM;
>         set_memory_rox((unsigned long)start, numpages);
[...]
