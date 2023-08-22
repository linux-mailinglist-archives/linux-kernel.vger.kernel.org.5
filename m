Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65643784CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHVWj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjHVWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:39:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1A8BCF1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:39:54 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0B1A792009C; Wed, 23 Aug 2023 00:39:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0601692009B;
        Tue, 22 Aug 2023 23:39:53 +0100 (BST)
Date:   Tue, 22 Aug 2023 23:39:53 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Chiu <andy.chiu@sifive.com>
cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>, greentime.hu@sifive.com,
        guoren@linux.alibaba.com, bjorn@kernel.org,
        conor.dooley@microchip.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v1, 2/3] RISC-V: vector: export VLENB csr in
 __sc_riscv_v_state
In-Reply-To: <CABgGipXhfz6iQgf86wj-=e9kzxiJp5N-u7OjL_Aj=wTP1MvRnQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2308222103310.49340@angie.orcam.me.uk>
References: <20230816155450.26200-1-andy.chiu@sifive.com> <20230816155450.26200-3-andy.chiu@sifive.com> <alpine.DEB.2.21.2308170158460.8596@angie.orcam.me.uk> <CABgGipXhfz6iQgf86wj-=e9kzxiJp5N-u7OjL_Aj=wTP1MvRnQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023, Andy Chiu wrote:

> > > diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
> > > index e17c550986a6..283800130614 100644
> > > --- a/arch/riscv/include/uapi/asm/ptrace.h
> > > +++ b/arch/riscv/include/uapi/asm/ptrace.h
> > > @@ -97,6 +97,7 @@ struct __riscv_v_ext_state {
> > >       unsigned long vl;
> > >       unsigned long vtype;
> > >       unsigned long vcsr;
> > > +     unsigned long vlenb;
> > >       void *datap;
> >
> >  I think we really ought to make a distinct structure holding the vector
> > CSR state only, and then have it included as a leading member of a pair of
> > other structures, one for the signal context with a trailing `datap' (or
> > `vregp' or `vreg') member and another one for the regset with a flexible
> > array member of the `char' type, e.g. (actual names TBD):
> >
> > struct __riscv_v_csr_state {
> >         unsigned long vstart;
> >         unsigned long vl;
> >         unsigned long vtype;
> >         unsigned long vcsr;
> >         unsigned long vlenb;
> > };
> >
> > struct __riscv_v_signal_state {
> >         struct __riscv_v_csr_state csr;
> >         void *vregp;
> > };
> >
> > struct __riscv_v_regset_state {
> >         struct __riscv_v_csr_state csr;
> >         char vreg[];
> > };
> >
> > This will make the API cleaner and avoid both UB with making accesses
> > beyond the end of a structure and clutter with an unused entry in core
> > files and data exchanged via ptrace(2).
> 
> Yes, and may I understand why there is a need for having struct
> __riscv_v_csr_state? Unless there is a need for getting CSRs only, yet
> vector CSRs are not meaningful without the content of Vector
> registers.

 Well, it's a data type only, it doesn't *have* to be used on it's own 
just because it exists.

> Personally I'd like to have one universal structure for
> both ptrace/signal/context-swicth(internal to the kernel), or one for
> UAPI and the other for kernel internal-used. Because then we don't
> have to mess with all kinds of access helpers for similar things.

 I'm not sure what kind of access helpers you mean, please elaborate.

> Maybe I lost something or just haven't read enough but doesn't it
> sound confusing that we create two structures in UAPI just for the
> Vector registers dump?

 AFAICT we need two structures, one for the signal context and another for 
the debug stuff, because we represent the vector context differently in 
each of these two cases.  I proposed the embedded `__riscv_v_csr_state' 
structure as a named member, because C doesn't have syntax available for 
embedding an already defined structure as an anonymous member and I didn't 
want to make use of a macro (which would then become a part of the uAPI) 
as means for the same data definition not to be repeated.

 Maybe it's not a big deal though.  If we inlined the CSR context in both
structures, then the definitions could look like:

struct __riscv_v_signal_state {
	unsigned long vstart;
	unsigned long vl;
	unsigned long vtype;
	unsigned long vcsr;
	unsigned long vlenb;
	void *vregp;
};

struct __riscv_v_regset_state {
	unsigned long vstart;
	unsigned long vl;
	unsigned long vtype;
	unsigned long vcsr;
	unsigned long vlenb;
	char vreg[];
};

OTOH I'm not fully convinced this is actually cleaner.  And the CSR state 
is distinct in a way here.

 NB I'm only concerned about the user API and ABI here, because once we've 
set them they'll have been cast in stone.  Conversely we can change an 
internal representation of the vector context at any time, so if we make a 
mistake or change our minds for whatever reason, it is not going to be a 
big deal.

 Cc-ing LKML in case someone not subscribed to linux-riscv wanted to chime 
in.  It's always a good idea to cc LKML on patch submissions anyway.

  Maciej
