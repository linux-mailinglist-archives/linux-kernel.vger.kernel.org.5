Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7384278670C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 07:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjHXFQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 01:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbjHXFQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 01:16:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B06410F8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 22:16:51 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 9E3A72127C77; Wed, 23 Aug 2023 22:16:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E3A72127C77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692854210;
        bh=yoa11dF1W36OFoui57V4JhQEHXmLDPKkDUP4mF+AO7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6gwuBV5WzYxGjnP+FcTDTsSbb7DF4z8tRCIS0lkts6KLv0ymn2vjm7TOmmMUiizs
         H90B0HVRqQ7K2vAkRgYf5UyhKj/VbhO6lyGPKN36haw/JcBh1dU6MRkYriHFQyCEMP
         SVsU5HzT8l/d3FMcYctMzg/qIrQXj7bPyg6g78X0=
Date:   Wed, 23 Aug 2023 22:16:50 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/numa: Add Devicetree support
Message-ID: <20230824051650.GA29529@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16885DEA2F3248B137EACC22D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <PUZP153MB0635C754D81715D1B60A6D6FBE10A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB0635C754D81715D1B60A6D6FBE10A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:29:57AM +0000, Saurabh Singh Sengar wrote:
> 
> 
> > -----Original Message-----
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Thursday, August 3, 2023 12:19 AM
> > To: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> > mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> > x86@kernel.org; hpa@zytor.com; luto@kernel.org; peterz@infradead.org;
> > linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] RE: [PATCH] x86/numa: Add Devicetree support
> > 
> > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, June
> > 27, 2023 12:28 AM
> > >
> > > Hyper-V has usecases where it need to fetch NUMA information from
> > > Devicetree. Currently, it is not possible to extract the NUMA
> > > information from Devicetree for x86 arch.
> > >
> > > Add support for Devicetree in the x86_numa_init function, allowing the
> > > retrieval of NUMA node information from the Devicetree.
> > >
> > > Additionally, relocate the x86_dtb_init function before initmem_init
> > > to ensure the Devicetree initialization prior to its utilization in
> > > x86_numa_init.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  arch/x86/Kconfig        | 1 +
> > >  arch/x86/kernel/setup.c | 2 +-
> > >  arch/x86/mm/numa.c      | 3 +++
> > >  3 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > > c531b16ee0bf..a2ada193b2d8 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -1567,6 +1567,7 @@ config NUMA
> > >  	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
> > >  	default y if X86_BIGSMP
> > >  	select USE_PERCPU_NUMA_NODE_ID
> > > +	select OF_NUMA if OF
> > >  	help
> > >  	  Enable NUMA (Non-Uniform Memory Access) support.
> > >
> > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c index
> > > fd975a4a5200..940c92a6a5e9 100644
> > > --- a/arch/x86/kernel/setup.c
> > > +++ b/arch/x86/kernel/setup.c
> > > @@ -1220,6 +1220,7 @@ void __init setup_arch(char **cmdline_p)
> > >
> > >  	early_acpi_boot_init();
> > >
> > > +	x86_dtb_init();
> > >  	initmem_init();
> > >  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
> > >
> > > @@ -1261,7 +1262,6 @@ void __init setup_arch(char **cmdline_p)
> > >  	 * Read APIC and some other early information from ACPI tables.
> > >  	 */
> > >  	acpi_boot_init();
> > > -	x86_dtb_init();
> > >
> > >  	/*
> > >  	 * get boot-time SMP configuration:
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c index
> > > 2aadb2019b4f..a6d3d331fda2 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/nodemask.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/topology.h>
> > > +#include <linux/of.h>
> > >
> > >  #include <asm/e820/api.h>
> > >  #include <asm/proto.h>
> > > @@ -733,6 +734,8 @@ void __init x86_numa_init(void)
> > >  		if (!numa_init(amd_numa_init))
> > >  			return;
> > >  #endif
> > > +		if (acpi_disabled && !numa_init(of_numa_init))
> > > +			return;
> > >  	}
> > >
> > >  	numa_init(dummy_numa_init);
> > > --
> > > 2.34.1
> > 
> > This looks good to me.  I've looked and don't see any obvious issues in
> > moving x86_dtb_init() earlier in setup_arch().  But I also know the setup
> > ordering can be very tricky to get working correctly with a wide range of
> > platforms, and I don't have that expertise.
> > But with those caveats,
> > 
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> Hi X86 Maintainers,
> 
> Is this good to be accepted ?

Thomas/Borislav,

Kind reminder to review this.

- Saurabh


> 
> - Saurabh
