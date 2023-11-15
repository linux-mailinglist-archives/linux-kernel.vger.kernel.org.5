Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D447EC2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjKOMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKOMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:42:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26F125;
        Wed, 15 Nov 2023 04:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+r8ivjIfgLZ88YUedyxhSyz2DStbFMG0ACvLMyfn4T8=; b=dQZrzXJarcPyscofRf+ECdjQh3
        s2ZanwodO9ept5SfgdHuqz+W3dpJJaRsGTClg1RCPbdW4uwkneSurlUMt6KsqbZ/eF6FB8TlgPlJ6
        m1PPue2AYsmhzXh1mR5lgXggeZl4dGJ7Ka1275y6fMwAF0zeAMlb3uxXd367bWr5AuXHrC4bnFSVf
        0jWyCxQm1IRy3oE/Mz+/H/t6I48ZPo1b9uLaeEXDNyJoAcPThLzw6OO/gxC4H0URpdJppHV+WuzzJ
        496rAqlN0u8oycYWDFB9hetPDb225KM9vZnsqzjOnh31C8x4B4Tq+xHgT4I1ivsjg4wxvG7BmFMl1
        CpjaXSDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3FDq-00EEE7-0q; Wed, 15 Nov 2023 12:42:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABAE4300427; Wed, 15 Nov 2023 13:42:21 +0100 (CET)
Date:   Wed, 15 Nov 2023 13:42:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        seanjc@google.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification
 handler
Message-ID: <20231115124221.GE3818@noisy.programming.kicks-ass.net>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 08:16:39PM -0800, Jacob Pan wrote:

> +static __always_inline inline void handle_pending_pir(struct pi_desc *pid, struct pt_regs *regs)
> +{
> +	int i, vec = FIRST_EXTERNAL_VECTOR;
> +	u64 pir_copy[4];
> +
> +	/*
> +	 * Make a copy of PIR which contains IRQ pending bits for vectors,
> +	 * then invoke IRQ handlers for each pending vector.
> +	 * If any new interrupts were posted while we are processing, will
> +	 * do again before allowing new notifications. The idea is to
> +	 * minimize the number of the expensive notifications if IRQs come
> +	 * in a high frequency burst.
> +	 */
> +	for (i = 0; i < 4; i++)
> +		pir_copy[i] = raw_atomic64_xchg((atomic64_t *)&pid->pir_l[i], 0);

Might as well use arch_xchg() and save the atomic64_t casting.

> +
> +	/*
> +	 * Ideally, we should start from the high order bits set in the PIR
> +	 * since each bit represents a vector. Higher order bit position means
> +	 * the vector has higher priority. But external vectors are allocated
> +	 * based on availability not priority.
> +	 *
> +	 * EOI is included in the IRQ handlers call to apic_ack_irq, which
> +	 * allows higher priority system interrupt to get in between.
> +	 */
> +	for_each_set_bit_from(vec, (unsigned long *)&pir_copy[0], 256)
> +		call_irq_handler(vec, regs);
> +
> +}
