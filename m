Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620AD809B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573157AbjLHElL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHElJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:41:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C77C10CA;
        Thu,  7 Dec 2023 20:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702010475; x=1733546475;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0uAzEiDxSRoKw5ICj8UQZXUC1J9qaduDJll7Mf5+10A=;
  b=aEhgClsgNkDIs+Sp7xlgdgXjrDsNa4HfzLAoClJA/2STYn9/cgilSn0i
   +gkyt13menIF/g1jMPGeF1x6mMmkxo20EwzZ3phsiuHfSVkrMixC5x7ii
   wbtm7ccXnVc0JwIeZyC1nXL8DE/tMwe+F6kFHMl9FUFVJgX8Yrk8am8j+
   Z5AhemGE8twf2uLeRXH8l7B+Fylp8RZnz2M/dGRwOqUTauRMELyxiUaPX
   NMpeyZmuQ1+FTovUZD7X+AXIXkG6h1ln2l1Ogqhb6mY81MK/QzBvRyguU
   1pB0wZjeEF1gH3O3lFngL1v74LvYLuY9HgA0ntC857LwODqoYKZZruHzz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460834949"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="460834949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 20:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="19956989"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 20:41:15 -0800
Date:   Thu, 7 Dec 2023 20:46:07 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        seanjc@google.com, Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification
 handler
Message-ID: <20231207204607.2d2a3b72@jacob-builder>
In-Reply-To: <87cyvjun3z.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
        <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
        <20231115125624.GF3818@noisy.programming.kicks-ass.net>
        <87cyvjun3z.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, 06 Dec 2023 20:50:24 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Wed, Nov 15 2023 at 13:56, Peter Zijlstra wrote:
> >
> > Would it not make more sense to write things something like:
> >
> > bool handle_pending_pir()
> > {
> > 	bool handled = false;
> > 	u64 pir_copy[4];
> >
> > 	for (i = 0; i < 4; i++) {
> > 		if (!pid-pir_l[i]) {
> > 			pir_copy[i] = 0;
> > 			continue;
> > 		}
> >
> > 		pir_copy[i] = arch_xchg(&pir->pir_l[i], 0);
> > 		handled |= true;
> > 	}
> >
> > 	if (!handled)
> > 		return handled;
> >
> > 	for_each_set_bit()
> > 		....
> >
> > 	return handled.
> > }  
> 
> I don't understand what the whole copy business is about. It's
> absolutely not required.
> 
> static bool handle_pending_pir(unsigned long *pir)
> {
>         unsigned int idx, vec;
> 	bool handled = false;
>         unsigned long pend;
>         
>         for (idx = 0; offs < 4; idx++) {
>                 if (!pir[idx])
>                 	continue;
> 		pend = arch_xchg(pir + idx, 0);
>                 for_each_set_bit(vec, &pend, 64)
> 			call_irq_handler(vec + idx * 64, NULL);
>                 handled = true;
> 	}
>         return handled;
> }
> 
My thinking is the following:
The PIR cache line is contended by between CPU and IOMMU, where CPU can
access PIR much faster. Nevertheless, when IOMMU does atomic swap of the
PID (PIR included), L1 cache gets evicted. Subsequent CPU read or xchg will
deal with invalid cold cache.

By making a copy of PIR as quickly as possible and clearing PIR with xchg,
we minimized the chance that IOMMU does atomic swap in the middle.
Therefore, having less L1D misses.

In the code above, it does read, xchg, and call_irq_handler() in a loop
to handle the 4 64bit PIR bits at a time. IOMMU has a greater chance to do
atomic xchg on the PIR cache line while doing call_irq_handler(). Therefore,
it causes more L1D misses.

I might be missing something?

I tested the two versions below with my DSA memory fill test and measured
DMA bandwidth and perf cache misses:

#ifdef NO_PIR_COPY
static __always_inline inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
{
	int i, vec;
	bool handled = false;
	unsigned long pending;

	for (i = 0; i < 4; i++) {
		if (!pir[i])
			continue;

		pending = arch_xchg(pir + i, 0);
		for_each_set_bit(vec, &pending, 64)
			call_irq_handler(i * 64 + vec, regs);
		handled = true;
	}

	return handled;
}
#else
static __always_inline inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
{
	int i, vec = FIRST_EXTERNAL_VECTOR;
	bool handled = false;
	unsigned long pir_copy[4];

	for (i = 0; i < 4; i++)
		pir_copy[i] = pir[i];

	for (i = 0; i < 4; i++) {
		if (!pir_copy[i])
			continue;

		pir_copy[i] = arch_xchg(pir, 0);
		handled = true;
	}

	if (handled) {
		for_each_set_bit_from(vec, pir_copy, FIRST_SYSTEM_VECTOR)
			call_irq_handler(vec, regs);
	}

	return handled;
}
#endif

DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
{
	struct pt_regs *old_regs = set_irq_regs(regs);
	struct pi_desc *pid;
	int i = 0;

	pid = this_cpu_ptr(&posted_interrupt_desc);

	inc_irq_stat(posted_msi_notification_count);
	irq_enter();

	while (i++ < MAX_POSTED_MSI_COALESCING_LOOP) {
		if (!handle_pending_pir(pid->pir64, regs))
			break;
	}

	/*
	 * Clear outstanding notification bit to allow new IRQ notifications,
	 * do this last to maximize the window of interrupt coalescing.
	 */
	pi_clear_on(pid);

	/*
	 * There could be a race of PI notification and the clearing of ON bit,
	 * process PIR bits one last time such that handling the new interrupts
	 * are not delayed until the next IRQ.
	 */
	handle_pending_pir(pid->pir64, regs);

	apic_eoi();
	irq_exit();
	set_irq_regs(old_regs);
}

Without PIR copy:

DMA memfill bandwidth: 4.944 Gbps
Performance counter stats for './run_intr.sh 512 30':                                                             
                                                                                                                   
    77,313,298,506      L1-dcache-loads                                               (79.98%)                     
         8,279,458      L1-dcache-load-misses     #    0.01% of all L1-dcache accesses  (80.03%)                   
    41,654,221,245      L1-dcache-stores                                              (80.01%)                     
            10,476      LLC-load-misses           #    0.31% of all LL-cache accesses  (79.99%)                    
         3,332,748      LLC-loads                                                     (80.00%)                     
                                                                                                                   
      30.212055434 seconds time elapsed                                                                            
                                                                                                                   
       0.002149000 seconds user                                                                                    
      30.183292000 seconds sys
                        

With PIR copy:
DMA memfill bandwidth: 5.029 Gbps
Performance counter stats for './run_intr.sh 512 30':

    78,327,247,423      L1-dcache-loads                                               (80.01%)
         7,762,311      L1-dcache-load-misses     #    0.01% of all L1-dcache accesses  (80.01%)
    42,203,221,466      L1-dcache-stores                                              (79.99%)
            23,691      LLC-load-misses           #    0.67% of all LL-cache accesses  (80.01%)
         3,561,890      LLC-loads                                                     (80.00%)

      30.201065706 seconds time elapsed

       0.005950000 seconds user
      30.167885000 seconds sys


> No?
> 
> > sysvec_posted_blah_blah()
> > {
> > 	bool done = false;
> > 	bool handled;
> >
> > 	for (;;) {
> > 		handled = handle_pending_pir();
> > 		if (done)
> > 			break;
> > 		if (!handled || ++loops > MAX_LOOPS) {  
> 
> That does one loop too many. Should be ++loops == MAX_LOOPS. No?
> 
> > 			pi_clear_on(pid);
> > 			/* once more after clear_on */
> > 			done = true;
> > 		}
> > 	}
> > }
> >
> >
> > Hmm?  
> 
> I think that can be done less convoluted.
> 
> {
> 	struct pi_desc *pid = this_cpu_ptr(&posted_interrupt_desc);
> 	struct pt_regs *old_regs = set_irq_regs(regs);
>         int loops;
> 
> 	for (loops = 0;;) {
>         	bool handled = handle_pending_pir((unsigned
> long)pid->pir);
> 
>                 if (++loops > MAX_LOOPS)
>                 	break;
> 
>                 if (!handled || loops == MAX_LOOPS) {
>                 	pi_clear_on(pid);
>                         /* Break the loop after handle_pending_pir()! */
>                         loops = MAX_LOOPS;
>                 }
> 	}
> 
> 	...
> 	set_irq_regs(old_regs);
> }
> 
> Hmm? :)


Thanks,

Jacob
