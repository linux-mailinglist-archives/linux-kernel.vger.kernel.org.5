Return-Path: <linux-kernel+bounces-95953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45C87554C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21EA1F21FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A27130AF8;
	Thu,  7 Mar 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5IGP6fr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60E1DA27
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833022; cv=none; b=Ed2JIgPgHc2hmvp996JlL55s6FLC6KGVbemwQbvk2Z5KayiCHQ0ltztaer48XDzl83TNrPGqXTgyiP7wZ8YRoo55DHaK5jaOmTOvNTHOL7wIOT2nD2cLUqPtrQtrJuUh7OpO1y7nQX34E/w6KsVc7isyvSj4iEilwIm31BBLLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833022; c=relaxed/simple;
	bh=d+uJbvrJni6Hk3MuASRhRdMts5GdhPUHOSsQge7P9kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVMwNq9uaCoPLCCEU9UrLlQxbdK5bLWMr5I7EPjWiwN7tz1aetRs7TPMr+6JCP7asTaeTKD2gL2McI3vU1X++5knZuh5NGW2MaswTmr9SowtBchktLcVdaRzUMRh3B4Rjy24XfRx3WEuEPUcGQnDE2Lh9Vz0K4kOhA3WA4pJQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5IGP6fr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709833020; x=1741369020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d+uJbvrJni6Hk3MuASRhRdMts5GdhPUHOSsQge7P9kU=;
  b=U5IGP6frdmeqNwU2CaXDirQyULjNLTsTEi7cucL7vLw9VSzMoq1cm5T6
   6IsZ1kQQnFxcPi9CkeewqCNVbb5yuQa/te3TmD542/KV5VTPHkJf4svzr
   R/yg/MN1pvqjyFu/Tgtj6AwCNY7twqhNZwCa06ERd4HIpcXOWDf0HPGMQ
   y0iuuuZe241KKWxxCW6iRv6FGG1mr+76OxRr0sS6jXfhBI0e5z/2m6SI9
   +dNKZtvMDx6axAk0qwdBmllcaxeX936ShWbYFUEzCpbv2+iYddKT5rWNf
   ESzXzClslVrPoicWTqc+/5mh1Z8cicfFXk0tNe91T+JXXbYJcDy/cLrNX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="29963049"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="29963049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14844346"
Received: from yuqiangu-mobl.amr.corp.intel.com (HELO [10.209.57.176]) ([10.209.57.176])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:36:59 -0800
Message-ID: <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
Date: Thu, 7 Mar 2024 09:36:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240307133916.3782068-2-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I know we all have different rules, but any time you could spend absorbing:

	https://www.kernel.org/doc/html/next/process/maintainer-tip.html

would be appreciated, especially:

> The condensed patch description in the subject line should start with
> a uppercase letter and should be written in imperative tone.


On 3/7/24 05:39, Yosry Ahmed wrote:
> In switch_mm_irqs_off(), we read the 'mm->context.lam_cr3_mask' into
> 'new_lam', which is later passed to load_new_mm_cr3(). However, there is
> a call to set_tlbstate_lam_mode() in between which will read
> 'mm->context.lam_cr3_mask' again and set 'cpu_tlbstate.lam' accordingly.
> If we race with another thread updating 'mm->context.lam_cr3_mask', the
> value in 'cpu_tlbstate.lam' could end up being different from CR3.

Your description is fine (modulo the we's).  But I slightly reworded it
to make it more plainly readable:

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.  That means
that a context-switching kernel thread can race and observe the mm's LAM
metadata (mm->context.lam_cr3_mask) change.

The context switch code does two logical things with that metadata:
populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
'cpu_tlbstate.lam' and CR3 can end up out of sync.

This de-synchronization is currently harmless.  But it is confusing and
might lead to warnings or real bugs.

--

> Fix the problem by updating set_tlbstate_lam_mode() to return the LAM
> mask that was set to 'cpu_tlbstate.lam', and use that mask in
> switch_mm_irqs_off() when writing CR3. Use READ_ONCE to make sure we
> read the mask once and use it consistenly.

Spell checking is also appreciated.

..
> -static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
> +static inline unsigned long set_tlbstate_lam_mode(struct mm_struct *mm)
>  {
> -	this_cpu_write(cpu_tlbstate.lam,
> -		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
> +	unsigned long lam = READ_ONCE(mm->context.lam_cr3_mask);
> +
> +	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
>  	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
> +	return lam;
>  }

The comments about races need to be _here_ so that the purpose of the
READ_ONCE() is clear.

It would also be nice to call out the rule that this can only
meaningfully be called once per context switch.

> @@ -633,7 +628,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>  		barrier();
>  	}
>  
> -	set_tlbstate_lam_mode(next);
> +	/*
> +	 * Even if we are not actually switching mm's, another thread could have
> +	 * updated mm->context.lam_cr3_mask. Make sure tlbstate_lam_cr3_mask()
> +	 * and the loaded CR3 use the up-to-date mask.
> +	 */

I kinda dislike how the comment talks about the details of what
set_tlbstate_lam_mode() does.  It would be much better to put the meat
of this comment at the set_tlbstate_lam_mode() definition.

> +	new_lam = set_tlbstate_lam_mode(next);
>  	if (need_flush) {
>  		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
>  		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);

This is less a complaint about your change and more of the existing
code, but I wish it was more obvious that set_tlbstate_lam_mode() is
logically shuffling data (once) from 'next' into the tlbstate.

The naming makes it sound like it is modifying the tlbstate of 'next'.

But I don't have any particularly brilliant ideas to fix it either.
Maybe just:

	/* new_lam is effectively cpu_tlbstate.lam */

> @@ -705,7 +705,6 @@ void initialize_tlbstate_and_flush(void)
>  
>  	/* LAM expected to be disabled */
>  	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
> -	WARN_ON(mm_lam_cr3_mask(mm));
>  
>  	/*
>  	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
> @@ -724,7 +723,7 @@ void initialize_tlbstate_and_flush(void)
>  	this_cpu_write(cpu_tlbstate.next_asid, 1);
>  	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
>  	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
> -	set_tlbstate_lam_mode(mm);
> +	WARN_ON(set_tlbstate_lam_mode(mm));

The "set_" naming bugs me in both of the sites that get modified here.
I'd be with a new name that fits better, if we can think of one.


