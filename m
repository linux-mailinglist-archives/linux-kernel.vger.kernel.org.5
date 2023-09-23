Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC157AC3A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjIWQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIWQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:26:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EE3D3;
        Sat, 23 Sep 2023 09:26:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE71FC433C7;
        Sat, 23 Sep 2023 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695486404;
        bh=2piJOAc4UtCWCg8jsg4cD2ZIAtKbobPaZdza3lM1trU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1TXhCaOUKwD4i9ywBsaA7fqhllTiUUEop2bqUBzfEeLiBK0GMJal6TZCH02gcByL
         753jvJ06wYTsHa9bNjwSyI/D53kLiYdlB1AiITQEZl13j1+ufZspu8eHeVKiSfnDPa
         Xnzc94p2Es7bJABHatU5GnvCNtXzBwLW/ClIG+R90OCKZCTnz4sBwhPKehiv0ITJJM
         +UjHKGlf0w5d8TT9nGbQtF1BeBR/tDz6eSth+IHkKyRVTlF1gKubvNuOjqYZN8sC6v
         yInZcSWBoyftCQIH5y4EX0l+ogMUchapNByEIoCoBWaItl9SpqS6bxW8Fm8jrgT5Hv
         hjgDbZyqE8rAA==
Date:   Sat, 23 Sep 2023 19:25:47 +0300
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
Subject: Re: [PATCH v3 09/13] powerpc: extend execmem_params for kprobes
 allocations
Message-ID: <20230923162547.GN3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-10-rppt@kernel.org>
 <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:30:46PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:31 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> [...]
> > @@ -135,5 +138,13 @@ struct execmem_params __init *execmem_arch_params(void)
> >
> >         range->pgprot = prot;
> >
> > +       execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
> > +       execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
> 
> .end = VMALLOC_END.

Thanks, this should have been

	execmem_params.ranges[EXECMEM_KPROBES].start = range->start;
	execmem_params.ranges[EXECMEM_KPROBES].end = range->end;

where range points to the same range as EXECMEM_MODULE_TEXT.

 
> Thanks,
> Song
> 
> > +
> > +       if (strict_module_rwx_enabled())
> > +               execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
> > +       else
> > +               execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
> > +
> >         return &execmem_params;
> >  }
> > --
> > 2.39.2
> >
> >

-- 
Sincerely yours,
Mike.
