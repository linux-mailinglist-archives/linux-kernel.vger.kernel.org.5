Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E57DB3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJ3HBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:01:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B19191;
        Mon, 30 Oct 2023 00:01:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B1CC433C7;
        Mon, 30 Oct 2023 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698649274;
        bh=EmJn7V2xcCxlebppxaDAhU12OFutDZWRBy0vMaSrWuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyer+0uyv1jhu2jxdwK+n1O2/sIgGI7ezOwxQC871hHJ3Cd/JKl9lBlO3pXltUpO2
         tybWUbFkw8nG3yYnKj5NWsk/KsMeh5cYt2Zf06cFoE4cK0SwwSOQ0meQsCZJmwrLES
         ZjfIwnoeXu/25/54cCJrG0ThSOL/VsSYVOr1W/9QTaMgDvrgblTvcHPZrDSbxEy8fw
         AT95UrDI+b348FRlIe6JpCkizTZtGaE3kNe+nAOZWv5ZyGWJevSARlVxf0OsNjI/Uk
         BM7kNTKVl9T3dS3d/hE9ctd5XEbBUeRh4TuIA6DuyqF/4ni+SgBncpCAAQy/vXTAcB
         87xr+yc2RIXWg==
Date:   Mon, 30 Oct 2023 09:00:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
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
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 04/13] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Message-ID: <20231030070053.GL2824@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-5-rppt@kernel.org>
 <20231023171420.GA4041@willie-the-truck>
 <20231026085800.GK2824@kernel.org>
 <20231026102438.GA6924@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026102438.GA6924@willie-the-truck>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:24:39AM +0100, Will Deacon wrote:
> On Thu, Oct 26, 2023 at 11:58:00AM +0300, Mike Rapoport wrote:
> > On Mon, Oct 23, 2023 at 06:14:20PM +0100, Will Deacon wrote:
> > > On Mon, Sep 18, 2023 at 10:29:46AM +0300, Mike Rapoport wrote:
> > > > diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> > > > index dd851297596e..cd6320de1c54 100644
> > > > --- a/arch/arm64/kernel/module.c
> > > > +++ b/arch/arm64/kernel/module.c

...

> > > > -	if (module_direct_base) {
> > > > -		p = __vmalloc_node_range(size, MODULE_ALIGN,
> > > > -					 module_direct_base,
> > > > -					 module_direct_base + SZ_128M,
> > > > -					 GFP_KERNEL | __GFP_NOWARN,
> > > > -					 PAGE_KERNEL, 0, NUMA_NO_NODE,
> > > > -					 __builtin_return_address(0));
> > > > -	}
> > > > +	module_init_limits();
> > > 
> > > Hmm, this used to be run from subsys_initcall(), but now you're running
> > > it _really_ early, before random_init(), so randomization of the module
> > > space is no longer going to be very random if we don't have early entropy
> > > from the firmware or the CPU, which is likely to be the case on most SoCs.
> > 
> > Well, it will be as random as KASLR. Won't that be enough?
> 
> I don't think that's true -- we have the 'kaslr-seed' property for KASLR,
> but I'm not seeing anything like that for the module randomisation and I
> also don't see why we need to set these limits so early.

x86 needs execmem initialized before ftrace_init() so I thought it would be
best to setup execmem along with most of MM in mm_core_init().

I'll move execmem initialization for !x86 to a later point, say
core_initcall.
 
> Will

-- 
Sincerely yours,
Mike.
