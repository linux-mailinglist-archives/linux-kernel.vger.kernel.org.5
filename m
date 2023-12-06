Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088B88078E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442809AbjLFTuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLFTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:50:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2CFA;
        Wed,  6 Dec 2023 11:50:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701892225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Dhk4+zCj2bSVdaz1f+DwCjhCz2nloe+08Lq1HubewE=;
        b=v+urtsd1FTU9ZhLnfNMCVE4t5FHdgO9qBV8ZKGd9TpMRxHH/CEWRGbEy4B+0vGbO4suTau
        wkZdYWlpRePNfzJLQy0BJa0Rh5RCB44e1qerQk/+rqH2Kuxw1JD5rXXd38vUPHy/UaNfD7
        CuB044qCEi9KUXNO4sdAO5+XlNWUFZr+rKjuYaZ45SI2Tr1BVqhKMx/ElfSYpG8SqoBKQl
        i5d9YiXVBrEUTzLU+M+B8U1EhdRdYXYjwtG+Inz5kqy416Tc2thKlKAt2VcOgX5ZLSfzzD
        av1/CKw9UkzTHaJ5OGGwop03VQVPbDBCweKuV1mA0BYPlLNulU2MD3+7iOvLag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701892225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Dhk4+zCj2bSVdaz1f+DwCjhCz2nloe+08Lq1HubewE=;
        b=lGzQtl9x+ofH+fpqUAxl6pXbPHwEXsgGEzAYM7ctVOK90MAjAnLeYQaVWkrQ4Jcv/RiiwP
        ECczWzS12VAPxEBA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        seanjc@google.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification handler
In-Reply-To: <20231115125624.GF3818@noisy.programming.kicks-ass.net>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
 <20231115125624.GF3818@noisy.programming.kicks-ass.net>
Date:   Wed, 06 Dec 2023 20:50:24 +0100
Message-ID: <87cyvjun3z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15 2023 at 13:56, Peter Zijlstra wrote:
>
> Would it not make more sense to write things something like:
>
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

I don't understand what the whole copy business is about. It's
absolutely not required.

static bool handle_pending_pir(unsigned long *pir)
{
        unsigned int idx, vec;
	bool handled = false;
        unsigned long pend;
        
        for (idx = 0; offs < 4; idx++) {
                if (!pir[idx])
                	continue;
		pend = arch_xchg(pir + idx, 0);
                for_each_set_bit(vec, &pend, 64)
			call_irq_handler(vec + idx * 64, NULL);
                handled = true;
	}
        return handled;
}

No?

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

That does one loop too many. Should be ++loops == MAX_LOOPS. No?

> 			pi_clear_on(pid);
> 			/* once more after clear_on */
> 			done = true;
> 		}
> 	}
> }
>
>
> Hmm?

I think that can be done less convoluted.

{
	struct pi_desc *pid = this_cpu_ptr(&posted_interrupt_desc);
	struct pt_regs *old_regs = set_irq_regs(regs);
        int loops;

	for (loops = 0;;) {
        	bool handled = handle_pending_pir((unsigned long)pid->pir);

                if (++loops > MAX_LOOPS)
                	break;

                if (!handled || loops == MAX_LOOPS) {
                	pi_clear_on(pid);
                        /* Break the loop after handle_pending_pir()! */
                        loops = MAX_LOOPS;
                }
	}

	...
	set_irq_regs(old_regs);
}

Hmm? :)
