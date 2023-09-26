Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FE7AE75A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjIZIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjIZIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:05:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933D116;
        Tue, 26 Sep 2023 01:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB07C433C7;
        Tue, 26 Sep 2023 08:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695715524;
        bh=+Amk36a0CBOiKu5+FtjGQvFX395/lzfG991XVrUkCKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLx2TLWKtN7VAMAOy6Z+yt+5L2H3WvCxgk6fo3xEAFTVDZv0mPqQm9oryMdet+1qZ
         obrB5TY2nE/qbUSfaI1uId3y2yRK2qnxEYYQpqf8IMXRqLpaWcyp6r1h8W5YGqDDxg
         /Ipk9rb4CjRrT7bowSHMduOUAEuaFMTD7nXxu83iUI+O1xmmOj2PJsMoiGARKNDMsM
         m8lXDTJPRNGVXjXTr34wm+BzlG4p+UzrUM7cd5TVxTprWIBaR+mK3IXevwTFE0yWC2
         SIHL7mRKLFjL2iR5rLVY4OdrYFjdV9kMecllhx3OCPX+UXN+tAGab3AHw/soEZdxZb
         tvxNd43ZGN+BA==
Date:   Tue, 26 Sep 2023 11:04:22 +0300
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
Message-ID: <20230926080422.GP3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
 <20230923153808.GI3303@kernel.org>
 <CAPhsuW6TxG87ZBwQ_027iiE+_UmXweZEPh8wKHkHo7wA+qXZUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6TxG87ZBwQ_027iiE+_UmXweZEPh8wKHkHo7wA+qXZUg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 03:36:01PM -0700, Song Liu wrote:
> On Sat, Sep 23, 2023 at 8:39 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Sep 21, 2023 at 03:34:18PM -0700, Song Liu wrote:
> > > On Mon, Sep 18, 2023 at 12:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > >
> > > [...]
> > >
> > > > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > > > index 42215f9404af..db5561d0c233 100644
> > > > --- a/arch/s390/kernel/module.c
> > > > +++ b/arch/s390/kernel/module.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/moduleloader.h>
> > > >  #include <linux/bug.h>
> > > >  #include <linux/memory.h>
> > > > +#include <linux/execmem.h>
> > > >  #include <asm/alternative.h>
> > > >  #include <asm/nospec-branch.h>
> > > >  #include <asm/facility.h>
> > > > @@ -76,7 +77,7 @@ void *module_alloc(unsigned long size)
> > > >  #ifdef CONFIG_FUNCTION_TRACER
> > > >  void module_arch_cleanup(struct module *mod)
> > > >  {
> > > > -       module_memfree(mod->arch.trampolines_start);
> > > > +       execmem_free(mod->arch.trampolines_start);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -510,7 +511,7 @@ static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
> > > >
> > > >         size = FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
> > > >         numpages = DIV_ROUND_UP(size, PAGE_SIZE);
> > > > -       start = module_alloc(numpages * PAGE_SIZE);
> > > > +       start = execmem_text_alloc(EXECMEM_FTRACE, numpages * PAGE_SIZE);
> > >
> > > This should be EXECMEM_MODULE_TEXT?
> >
> > This is an ftrace trampoline, so I think it should be FTRACE type of
> > allocation.
> 
> Yeah, I was aware of the ftrace trampoline. My point was, ftrace trampoline
> doesn't seem to have any special requirements. Therefore, it is probably not
> necessary to have a separate type just for it.

Since ftrace trampolines are currently used only on s390 and x86 which
enforce the same range for all executable allocations there are no special
requirements indeed. But I think that explicitly marking these allocations
as FTRACE makes it clearer what are they used for and I don't see downsides
to having a type for FTRACE.
 
> AFAICT, kprobe, ftrace, and BPF (JIT and trampoline) can share the same
> execmem_type. We may need some work for some archs, but nothing is
> fundamentally different among these.

Using the same type for all generated code implies that all types of the
generated code must live in the same range and I don't think we want to
impose this limitation on architectures.

For example, RISC-V deliberately added a range for BPF code to allow
relative addressing, see commit 7f3631e88ee6 ("riscv, bpf: Provide RISC-V
specific JIT image alloc/free").
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
