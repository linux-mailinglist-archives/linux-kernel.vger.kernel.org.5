Return-Path: <linux-kernel+bounces-44673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E368425C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FA61F29A69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B726A337;
	Tue, 30 Jan 2024 13:07:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139F381DA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620048; cv=none; b=ZwzLWBZI32Q2tzD/L4WILEiNFTkBeDQ1FPLPPaaGJhEm/Fcf6JsVNkEzs/HCRlrATDpA3fe1MuCLTYXiVMhtss30Fi+TNMPdbNeO7c8bwHb7XPFrhyQt92jGek7/DGNsUUj/qw2ufsCAzOamMGGwi0CBxJeeRLxs9/94Ofe7rAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620048; c=relaxed/simple;
	bh=FXMnOh+vs1RVOQL0ysJ8/+0JQqXft3V166HIO4cw69Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSBOLCm8pXa+CImL/7UTuPna4IuY3QYGLnq3o6wiIqW5y5copCK+a14pV+vZmjkDmB4UOvR49KvOb0b9EFepINc0ANxokgijptQn2L3N8td/j4BeFtZQZyM8zDWuQXn5BOqKgByXf47scuunx69Jj06lBzT2CdTRTRUaadhqyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80839DA7;
	Tue, 30 Jan 2024 05:08:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8453F762;
	Tue, 30 Jan 2024 05:07:20 -0800 (PST)
Date: Tue, 30 Jan 2024 13:07:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v10 2/6] arm64: add support for machine check error safe
Message-ID: <Zbj0heg7eFukm_5Z@FVFF77S0Q05N>
References: <20240129134652.4004931-1-tongtiangen@huawei.com>
 <20240129134652.4004931-3-tongtiangen@huawei.com>
 <ZbflpQV7aVry0qPz@FVFF77S0Q05N>
 <eb78caf9-ac03-1030-4e32-b614e73c0f62@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb78caf9-ac03-1030-4e32-b614e73c0f62@huawei.com>

On Tue, Jan 30, 2024 at 06:57:24PM +0800, Tong Tiangen wrote:
> 在 2024/1/30 1:51, Mark Rutland 写道:
> > On Mon, Jan 29, 2024 at 09:46:48PM +0800, Tong Tiangen wrote:

> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 55f6455a8284..312932dc100b 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -730,6 +730,31 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
> > >   	return 1; /* "fault" */
> > >   }
> > > +static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
> > > +				     struct pt_regs *regs, int sig, int code)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
> > > +		return false;
> > > +
> > > +	if (user_mode(regs))
> > > +		return false;
> > 
> > This function is called "arm64_do_kernel_sea"; surely the caller should *never*
> > call this for a SEA taken from user mode?
> 
> In do_sea(), the processing logic is as follows:
>   do_sea()
>   {
>     [...]
>     if (user_mode(regs) && apei_claim_sea(regs) == 0) {
>        return 0;
>     }
>     [...]
>     //[1]
>     if (!arm64_do_kernel_sea()) {
>        arm64_notify_die();
>     }
>   }
> 
> [1] user_mode() is still possible to go here,If user_mode() goes here,
>  it indicates that the impact caused by the memory error cannot be
>  processed correctly by apei_claim_sea().
> 
> 
> In this case, only arm64_notify_die() can be used, This also maintains
> the original logic of user_mode()'s processing.

My point is that either:

(a) The name means that this should *only* be called for SEAs from a kernel
    context, and the caller should be responsible for ensuring that.

(b) The name is misleading, and the 'kernel' part should be removed from the
    name.

I prefer (a), and if you head down that route it's clear that you can get rid
of a bunch of redundant logic and remove the need for do_kernel_sea(), anyway,
e.g.

| static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
| {
|         const struct fault_info *inf = esr_to_fault_info(esr);
|         bool claimed = apei_claim_sea(regs) == 0;
|         unsigned long siaddr;
| 
|         if (claimed) {
|                 if (user_mode(regs)) {
|                         /*  
|                          * APEI claimed this as a firmware-first notification.
|                          * Some processing deferred to task_work before ret_to_user().
|                          */
|                         return 0;
|                 } else {
|                         /*
|                          * TODO: explain why this is correct.
|                          */
|                         if ((current->flags & PF_KTHREAD) &&
|                             fixup_exception_mc(regs))
|                                 return 0;
|                 }
|         }
| 
|         if (esr & ESR_ELx_FnV) {
|                 siaddr = 0;
|         } else {
|                 /*  
|                  * The architecture specifies that the tag bits of FAR_EL1 are
|                  * UNKNOWN for synchronous external aborts. Mask them out now
|                  * so that userspace doesn't see them.
|                  */
|                 siaddr  = untagged_addr(far);
|         }   
|         arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
| 
|         return 0;
| }

> > > +
> > > +	if (apei_claim_sea(regs) < 0)
> > > +		return false;
> > > +
> > > +	if (!fixup_exception_mc(regs))
> > > +		return false;
> > > +
> > > +	if (current->flags & PF_KTHREAD)
> > > +		return true;
> > 
> > I think this needs a comment; why do we allow kthreads to go on, yet kill user
> > threads? What about helper threads (e.g. for io_uring)?
> 
> If a memroy error occurs in the kernel thread, the problem is more
> serious than that of the user thread. As a result, related kernel
> functions, such as khugepaged, cannot run properly. kernel panic should
> be a better choice at this time.
> 
> Therefore, the processing scope of this framework is limited to the user
> thread.

That's reasonable, but needs to be explained in a comment.

Also, as above, I think you haven't conisderd helper threads (e.g. io_uring),
which don't have PF_KTHREAD set but do have PF_USER_WORKER set. I suspect those
need the same treatment as kthreads.

> > > +	set_thread_esr(0, esr);
> > 
> > Why do we set the ESR to 0?
> 
> The purpose is to reuse the logic of arm64_notify_die() and set the
> following parameters before sending signals to users:
>   current->thread.fault_address = 0;
>   current->thread.fault_code = err;

Ok, but there's no need to open-code that.

As per my above example, please continue to use the existing call to
arm64_notify_die() rather than open-coding bits of it.

Mark.

