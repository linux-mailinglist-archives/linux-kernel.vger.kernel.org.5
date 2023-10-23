Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE707D3D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjJWRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:21:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3794;
        Mon, 23 Oct 2023 10:21:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977DEC433C7;
        Mon, 23 Oct 2023 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081670;
        bh=WQYEKm0Mc7inaH0wFnxcEUmfAmPR1JoMV7fRygVNKQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOVDksWfw+hV9R+Z5ZexM6NcY3xDNdzdq9AsRt4vO9wMdxWhqWWcxLwP+eW4A962q
         Qk6ekhq2Ipm65VVsfFxXGy8qQeQOWzCvDqLJfEU8nWaZHFbI6flnaXvlVH0CRDWH+w
         hIMRahts5mdD+tpF+6eXFcpVMEl1Ep7tHL5W7fbVdPmlfZ6yQugf14RafBolwJcEMn
         21vyDdZz0h9WC0+Q/QJBX2oIB6fGQ1kXhcFuxCsKB2tbLoPEgU/BSdSOixB9qw31iO
         OgDPN8A4Uqs6uFqTMJcPk6zjMZ/offJmG+hcHSxPefHsLKYd1oYsfoKs6fvoRIkbKX
         wMvEth+vb/+ag==
Date:   Mon, 23 Oct 2023 18:21:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
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
Subject: Re: [PATCH v3 07/13] arm64, execmem: extend execmem_params for
 generated code allocations
Message-ID: <20231023172059.GB4041@willie-the-truck>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-8-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918072955.2507221-8-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:29:49AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The memory allocations for kprobes and BPF on arm64 can be placed
> anywhere in vmalloc address space and currently this is implemented with
> overrides of alloc_insn_page() and bpf_jit_alloc_exec() in arm64.
> 
> Define EXECMEM_KPROBES and EXECMEM_BPF ranges in arm64::execmem_params and
> drop overrides of alloc_insn_page() and bpf_jit_alloc_exec().
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/arm64/kernel/module.c         | 13 +++++++++++++
>  arch/arm64/kernel/probes/kprobes.c |  7 -------
>  arch/arm64/net/bpf_jit_comp.c      | 11 -----------
>  3 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index cd6320de1c54..d27db168d2a2 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -116,6 +116,16 @@ static struct execmem_params execmem_params __ro_after_init = {
>  			.flags = EXECMEM_KASAN_SHADOW,
>  			.alignment = MODULE_ALIGN,
>  		},
> +		[EXECMEM_KPROBES] = {
> +			.start = VMALLOC_START,
> +			.end = VMALLOC_END,
> +			.alignment = 1,
> +		},
> +		[EXECMEM_BPF] = {
> +			.start = VMALLOC_START,
> +			.end = VMALLOC_END,
> +			.alignment = 1,
> +		},
>  	},
>  };
>  
> @@ -140,6 +150,9 @@ struct execmem_params __init *execmem_arch_params(void)
>  		r->end = module_plt_base + SZ_2G;
>  	}
>  
> +	execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
> +	execmem_params.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
> +
>  	return &execmem_params;
>  }
>  
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 70b91a8c6bb3..6fccedd02b2a 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -129,13 +129,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	return 0;
>  }
>  
> -void *alloc_insn_page(void)
> -{
> -	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> -			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> -			NUMA_NO_NODE, __builtin_return_address(0));
> -}

It's slightly curious that we didn't clear the tag here, so it's nice that
it all happens magically with your series:

Acked-by: Will Deacon <will@kernel.org>

Will
