Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39657A4FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjIRQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjIRQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:56:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E492F9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:56:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695056171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jqSeGkdJelXJR4R5QDfLd7TCXye/v14hQ40SjD7MaS8=;
        b=IQnxCFYWTQq0YyJLqJzRpw23hTE8dIS14c8Y1HwPOes69H7mj0XQYZjFDR+u4CqQ++Hn+0
        t406NcRjVNdq7L1ZXy3DXPvV7DJ8I3qRKjaA1fZv7G4s7n22mWKuTHitZIT23OoN+DeG5M
        fm2YOubCa7WFRwI+56bywI48hTnENJkD6cLTW1YPch3u594Oihu75KHSTD9dDKgLrFLARu
        E2EpiEc0phGo/X98p/ZmazYuSFX1aBkaVURlAe7ecwrYG51Vp1G7RIoo9pDnJ7DMfZiUxW
        KwfIpz2VBNewQ5ywjEukAVJc0tv0V6hMJXRUi2FMAZEEwxdKi5LHhGzF5JX42g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695056171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jqSeGkdJelXJR4R5QDfLd7TCXye/v14hQ40SjD7MaS8=;
        b=XGi0q3E3DA776cF9oLKi0SG8jJsA57NHDmuH34hbRhnBvHFBvnBAIF0p2VqNe9JOlqrmWO
        4gMzAbu+Ii6yTbDA==
To:     Brendan Jackman <jackmanb@google.com>, luto@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        laijs@linux.alibaba.com, yosryahmed@google.com, reijiw@google.com,
        oweisse@google.com, Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH RESEND] x86/entry: Don't write to CR3 when restoring to
 kernel CR3
In-Reply-To: <20230817121513.1382800-1-jackmanb@google.com>
References: <20230817121513.1382800-1-jackmanb@google.com>
Date:   Mon, 18 Sep 2023 18:56:10 +0200
Message-ID: <87sf7bxvx1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17 2023 at 12:15, Brendan Jackman wrote:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Skip resuming KERNEL pages since it is already KERNEL CR3

This really want's some more explanation than this.

Also the subject line does not make much sense to me. Something like:

  x86/entry: Avoid redundant CR3 write on paranoid returns

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>
> While staring at paranoid_exit I was confused about why we had this CR3
> write, avoiding it seems like a free optimisation. The original commit
> 21e94459110252 ("x86/mm: Optimize RESTORE_CR3") says "Most NMI/paranoid
> exceptions will not in fact change pagetables" but I didn't't understand
> what the "most" was referring to. I then discovered this patch on the
> mailing list, Andy said[1] that it looks correct so maybe now is the
> time to merge it?
>
> Note there's another patch in [1] as well, the benefit of that one is
> not obvious to me though.

The point is that RESTORE_CR3 is only used for exceptions which enter
via paranoid_entry(): #DF, #MCE, #VC, #DB and the NMI low level return
code.

#NMI, #MCE, #VC, #DB use this code path only when the exception
interrupted kernel mode. #DF uses it unconditionally.

Entries from user space for #NMI, #MCE, #VC, #DB switch away from the
IST stack to the thread stack and handle the exception there. So they
won't return via a code path which uses RESTORE_CR3.

So your patch optimizes the CR3 handling vs. kernel entries. If the
exception hits code which has kernel CR3 loaded then restoring the
unchanged kernel CR3 is a pointless exercise. CR3 is guaranteed to be
unchanged as none of those exceptions can schedule when the exception
hit kernel mode, i.e. CPL=0.

Now the second change Lai did is to get rid of the conditional flush.

The reasoning is that the code paths where kernel mode (CPL=0) runs with
user CR3 are pretty small. They all look like this:

     SWITCH_TO_USER_CR3
     // Do the final preparation for return
     IRET 	// SYSRET, SYSEXIT

and therefore the probability that an affected exception hits between
the CR3 switch and the instruction which returns to user space is pretty
small.

The only case where an unconditional flush might matter is #NMI. #DF,
#MCE, #VC, #DB are slow path anyway.

As the probability is low Lai removed the conditional flush optimization
and turned it into an unconditional flush to make the code simpler.

It's debatable whether this matters or not, but as that optimization and
sits in the rarely executed code path it is not hurting either and
avoids the occasional pointless flush when perf(1) is used.

> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -236,14 +236,13 @@ For 32-bit we have the following conventions - kernel is built with
>  .macro RESTORE_CR3 scratch_reg:req save_reg:req
>  	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>  
> -	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
> -
>  	/*
> -	 * KERNEL pages can always resume with NOFLUSH as we do
> -	 * explicit flushes.
> +	 * Skip resuming KERNEL pages since it is already KERNEL CR3.
>  	 */

         /*
          * If CR3 contained the kernel page tables at the paranoid
          * exception entry, then there is nothing to restore as CR3
          * is not modified while handling the exception.
          */

Perhaps?

There are now stale comments vs. the restore mechanism and
paranoid_entry() in some places in entry_64.S. They really want to be
fixed up to avoid lots of head scratching later. E.g. this:

	/* Always restore stashed CR3 value (see paranoid_entry) */
	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14

does not make sense now. Neither does the comment in paranoid_entry()
itself.

Also the macro name is misleading with this change. It does not
unconditionally restore CR3 as the name suggests.

PARANOID_RESTORE_USER_CR3 or something like that makes it clear what
this is about.

There is another detail. The slightly convoluted code flow in the user
restore path noflush handling.

	movq	\save_reg, \scratch_reg
	andq	$(0x7FF), \scratch_reg
	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
	jnc	.Lnoflush_\@

	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
	jmp	.Lwrcr3_\@

.Lnoflush_\@:
	SET_NOFLUSH_BIT \save_reg

The only reason why this code is so convoluted was to reuse the setting
of the NOFLUSH bit for the kernel CR3 write:

	bt	$PTI_USER_PGTABLE_BIT, \save_reg
	jnc	.Lnoflush_\@

which this patch eliminates.

So this logic can be simplified to

	movq	\save_reg, \scratch_reg
	andq	$(0x7FF), \scratch_reg
	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
	jc	.Lwrcr3_\@

	SET_NOFLUSH_BIT \save_reg

Thanks,

        tglx
