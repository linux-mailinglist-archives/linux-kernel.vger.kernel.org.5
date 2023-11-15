Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13B7ED119
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjKOT70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbjKOT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:59:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD6AF;
        Wed, 15 Nov 2023 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078361; x=1731614361;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrWkTvCzWNuE40twGKi0g9x8mI/HOylHkbIgQH6YMTw=;
  b=ju/wWnCIo1vMui4X1niumgsVsi6O2yJz7ZdSUwrPTOzgNc8GQ0HpWOm8
   xLaZVllvoRfHWbrIfiA3UqRN35vk+4/G5K3TApor77t5jSG7O+vAs/bmN
   NrVPKMlm/nBsGdfZmnv+voItFucz9uonTV0ofJgKmvcJ9jlwj95KTH6K2
   hIsF1HhP+zhjYrU+XJOjY3Bp58DP8v6bEoupyeLrDUTXhs7aEZ6NQTLd/
   sAslhXFgKlEIDxc9BEi9ZSJQvJwtl0k/pknKglTeKvvu2ZWKNZ5BqeE4u
   LxxEE1SzGjcNnIMk1UMemLjgV5Y+OWjftCIGLNbh7jyINVwaNg0YoLUra
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390743032"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="390743032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12880278"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:59:21 -0800
Date:   Wed, 15 Nov 2023 12:04:01 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        seanjc@google.com, Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification
 handler
Message-ID: <20231115120401.3e02d977@jacob-builder>
In-Reply-To: <20231115125624.GF3818@noisy.programming.kicks-ass.net>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
        <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
        <20231115125624.GF3818@noisy.programming.kicks-ass.net>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 15 Nov 2023 13:56:24 +0100, Peter Zijlstra <peterz@infradead.org>
wrote:

> On Sat, Nov 11, 2023 at 08:16:39PM -0800, Jacob Pan wrote:
> 
> > +static __always_inline inline void handle_pending_pir(struct pi_desc
> > *pid, struct pt_regs *regs) +{  
> 
> __always_inline means that... (A)
> 
> > +	int i, vec = FIRST_EXTERNAL_VECTOR;
> > +	u64 pir_copy[4];
> > +
> > +	/*
> > +	 * Make a copy of PIR which contains IRQ pending bits for
> > vectors,
> > +	 * then invoke IRQ handlers for each pending vector.
> > +	 * If any new interrupts were posted while we are processing,
> > will
> > +	 * do again before allowing new notifications. The idea is to
> > +	 * minimize the number of the expensive notifications if IRQs
> > come
> > +	 * in a high frequency burst.
> > +	 */
> > +	for (i = 0; i < 4; i++)
> > +		pir_copy[i] = raw_atomic64_xchg((atomic64_t
> > *)&pid->pir_l[i], 0); +
> > +	/*
> > +	 * Ideally, we should start from the high order bits set in
> > the PIR
> > +	 * since each bit represents a vector. Higher order bit
> > position means
> > +	 * the vector has higher priority. But external vectors are
> > allocated
> > +	 * based on availability not priority.
> > +	 *
> > +	 * EOI is included in the IRQ handlers call to apic_ack_irq,
> > which
> > +	 * allows higher priority system interrupt to get in between.
> > +	 */
> > +	for_each_set_bit_from(vec, (unsigned long *)&pir_copy[0], 256)
> > +		call_irq_handler(vec, regs);
> > +
> > +}
> > +
> > +/*
> > + * Performance data shows that 3 is good enough to harvest 90+% of the
> > benefit
> > + * on high IRQ rate workload.
> > + * Alternatively, could make this tunable, use 3 as default.
> > + */
> > +#define MAX_POSTED_MSI_COALESCING_LOOP 3
> > +
> > +/*
> > + * For MSIs that are delivered as posted interrupts, the CPU
> > notifications
> > + * can be coalesced if the MSIs arrive in high frequency bursts.
> > + */
> > +DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
> > +{
> > +	struct pt_regs *old_regs = set_irq_regs(regs);
> > +	struct pi_desc *pid;
> > +	int i = 0;
> > +
> > +	pid = this_cpu_ptr(&posted_interrupt_desc);
> > +
> > +	inc_irq_stat(posted_msi_notification_count);
> > +	irq_enter();
> > +
> > +	while (i++ < MAX_POSTED_MSI_COALESCING_LOOP) {
> > +		handle_pending_pir(pid, regs);
> > +
> > +		/*
> > +		 * If there are new interrupts posted in PIR, do
> > again. If
> > +		 * nothing pending, no need to wait for more
> > interrupts.
> > +		 */
> > +		if (is_pir_pending(pid))  
> 
> So this reads those same 4 words we xchg in handle_pending_pir(), right?
> 
> > +			continue;
> > +		else
> > +			break;
> > +	}
> > +
> > +	/*
> > +	 * Clear outstanding notification bit to allow new IRQ
> > notifications,
> > +	 * do this last to maximize the window of interrupt coalescing.
> > +	 */
> > +	pi_clear_on(pid);
> > +
> > +	/*
> > +	 * There could be a race of PI notification and the clearing
> > of ON bit,
> > +	 * process PIR bits one last time such that handling the new
> > interrupts
> > +	 * are not delayed until the next IRQ.
> > +	 */
> > +	if (unlikely(is_pir_pending(pid)))
> > +		handle_pending_pir(pid, regs);  
> 
> (A) ... we get _two_ copies of that thing in this function. Does that
> make sense ?
> 
> > +
> > +	apic_eoi();
> > +	irq_exit();
> > +	set_irq_regs(old_regs);
> > +}
> >  #endif /* X86_POSTED_MSI */  
> 
> Would it not make more sense to write things something like:
> 
it is a great idea, we can save expensive xchg if pir[i] is 0. But I have
to tweak a little to let it perform better.

> bool handle_pending_pir()
> {
> 	bool handled = false;
> 	u64 pir_copy[4];
> 
> 	for (i = 0; i < 4; i++) {
> 		if (!pid-pir_l[i]) {
> 			pir_copy[i] = 0;
> 			continue;
> 		}
> 
> 		pir_copy[i] = arch_xchg(&pir->pir_l[i], 0);
we are interleaving cacheline read and xchg. So made it to

	for (i = 0; i < 4; i++) {
		pir_copy[i] = pid->pir_l[i];
	}

	for (i = 0; i < 4; i++) {
		if (pir_copy[i]) {
			pir_copy[i] = arch_xchg(&pid->pir_l[i], 0);
			handled = true;
		}
	}

With DSA MEMFILL test just one queue one MSI, we are saving 3 xchg per loop.
Here is the performance comparison in IRQ rate:

Original RFC 9.29 m/sec, 
Optimized in your email 8.82m/sec,
Tweaked above: 9.54m/s

I need to test with more MSI vectors spreading out to all 4 u64. I suspect
the benefit will decrease since we need to do both read and xchg for
non-zero entries.

> 		handled |= true;
> 	}


> 
> 	if (!handled)
> 		return handled;
> 
> 	for_each_set_bit()
> 		....
> 
> 	return handled.
> }
> 
> sysvec_posted_blah_blah()
> {
> 	bool done = false;
> 	bool handled;
> 
> 	for (;;) {
> 		handled = handle_pending_pir();
> 		if (done)
> 			break;
> 		if (!handled || ++loops > MAX_LOOPS) {
> 			pi_clear_on(pid);
> 			/* once more after clear_on */
> 			done = true;
> 		}
> 	}
> }
> 
> 
> Hmm?




Thanks,

Jacob
