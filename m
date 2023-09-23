Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE1B7AC34F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjIWPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:39:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE8100;
        Sat, 23 Sep 2023 08:39:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2139BC433C8;
        Sat, 23 Sep 2023 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695483543;
        bh=44aW6DcKJaHGXelf02UJMtFK5RbIa4QmGjb00e/7p/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fw2A/tcOcobQiglJay8dvPT5bEfVdzbbmq0FwMYYkRDEvMMNze6l5vdxXC61b2ule
         JFCwMCsxrAuMW6D9gVnh2enWSeUtDeXGmVEjWBDuVv9KbPW1MRt9tzybn9NNKJQMj2
         y3Lc/W+nmmCK2KsTrqRVvz29GuwFbt1mGULYw6jBfPPwRcYXpuSga9okI5ya4zHkUD
         tynDeAbBph8ozw0L4VOesv/AFGSBeSrp7QqXSV98fLRWfSHzHFilN6nNqox4/XsFqb
         GBdnrmPrEZw+uXG8gLcDpColobXRcu9WsCK8bgQKX9ms+oqH3fV0ph2eOZh795NWNU
         moLZ9gWnlnDaA==
Date:   Sat, 23 Sep 2023 18:38:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
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
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and
 execmem_free()
Message-ID: <20230923153808.GI3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:34:18PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> 
> [...]
> 
> > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > index 42215f9404af..db5561d0c233 100644
> > --- a/arch/s390/kernel/module.c
> > +++ b/arch/s390/kernel/module.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/moduleloader.h>
> >  #include <linux/bug.h>
> >  #include <linux/memory.h>
> > +#include <linux/execmem.h>
> >  #include <asm/alternative.h>
> >  #include <asm/nospec-branch.h>
> >  #include <asm/facility.h>
> > @@ -76,7 +77,7 @@ void *module_alloc(unsigned long size)
> >  #ifdef CONFIG_FUNCTION_TRACER
> >  void module_arch_cleanup(struct module *mod)
> >  {
> > -       module_memfree(mod->arch.trampolines_start);
> > +       execmem_free(mod->arch.trampolines_start);
> >  }
> >  #endif
> >
> > @@ -510,7 +511,7 @@ static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
> >
> >         size = FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
> >         numpages = DIV_ROUND_UP(size, PAGE_SIZE);
> > -       start = module_alloc(numpages * PAGE_SIZE);
> > +       start = execmem_text_alloc(EXECMEM_FTRACE, numpages * PAGE_SIZE);
> 
> This should be EXECMEM_MODULE_TEXT?

This is an ftrace trampoline, so I think it should be FTRACE type of
allocation.
 
> Thanks,
> Song
> 
> >         if (!start)
> >                 return -ENOMEM;
> >         set_memory_rox((unsigned long)start, numpages);
> [...]

-- 
Sincerely yours,
Mike.
