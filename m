Return-Path: <linux-kernel+bounces-96630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6AC875F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BB72821A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064C50A7C;
	Fri,  8 Mar 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlFjHzp6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B301CD09
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885365; cv=none; b=qRv3LYl1FrxLlr8ZzVfR58lL0D/EQFdjvTAFizQiBHW1dRMBVcsOxpWzTrPQ4ItbBSj5vuvpBIJFBSkjKUbp/jCyqBDLhsj2xQ3e90O9YGoeKWdl2eERjEBGP8wQtS5R4m/wsNJBMAqc6PQbo4t2RGYxYgXNYGVuZ8kW1VRW8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885365; c=relaxed/simple;
	bh=ICU0JrdQpRwdCB2KuzjtoYE2gLiFJbXgwPyAwy3yB6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gnhyc93zwX0p6IngoojL91h33vSmr4RIbaMPkrZNehKgFBfaalKLn2wD+u2rsyDp22ppko6WRtxi+t978SROlVABS+4spA3oLKmwhDdcXRr+kVNBz6RK5BXiwfXgHQQerZdNtDQXg74v8hV0nfoVDg8W4frEqJ/cI1hGP+nzWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlFjHzp6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso35246467b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709885363; x=1710490163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVM5khotddcw4+zdLDFsWg/Hyre6BquckIFzuEdqmQo=;
        b=SlFjHzp6z6WmZbNDm+K6U93hGjw1go8dg9JbchyGrKA6UQ5d7/zkU68TEdoPcBHo1C
         BwNgyxNs6MB9qlskiEt2zlJxAtfErqd66yRGfVtEWDLDWRKn8lWYld/5th3VR4MZ5Omz
         yrlaxd+HCQRizmGCZA7BXYIX3jaPpmAdWTUCUqaTyx/kZAJ+vAoUeFG4mlBNMJH7FHT/
         IrlCaBQFbdLyaj+WfuSY2v1XzY9vodXDx256CwORjvAkTg/zD6E3OIhnf3NilrHzmVVw
         ynTaxeAfHmJecJ3cb6scekDxDPyMh5R1LnY5lhEO3HCQMBaq02Xpu9VPCxTTx4CJKnWo
         K0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709885363; x=1710490163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVM5khotddcw4+zdLDFsWg/Hyre6BquckIFzuEdqmQo=;
        b=OEQ1r5PL1tpTR9yZdZx/AwYu3OPrCZRFM804v8P6qFtkicP9EOAc3E6iy6mT37fRt4
         FddZJ+sx259I97Prz4OUd3afBV4TP0b87WCaMwX0lPfmjkjVy6IdaqsCRfrSCVGfVxE+
         NcXDqF5xbXhsVs5RRzDSHuhLFyZwVFxGK3nly/6dIZuKelZBBvcDNoiIBW3Xf75S7s1s
         dBQKAk0SlQy8ROJPeeTjsh1gkhs4Nfa1rFHyDLWA4A2nh+LzeBGZvzU7xuaYiU8yOHPC
         /7zOfRNzWQTpWnsXyYNeYbbAnrgHEef08XbMGqhfGH6VF0kW2Mkfl2h5fvOv57qlu/bE
         bRNA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcp843C4rPwu4ORvxvksNfryVRwNf5Z2kAaxMaCxamFaU2eW1j+DsnYlc0ifu8+1bntbisysW31ytCJ3+C8rhHx4b7kGx/t5Oceu6
X-Gm-Message-State: AOJu0YxteHAZlsm2+tYJNLYVP0j4Xcd/NLQLpMTWd4wNaW38wrIdp73g
	KDOA7xChJqqQTWEBViQqgLA6gqqlB9WkzlKfx+M6V3ugnKxm8dyonxIwaVCpcw14aDQ43SuQiiR
	PJfW2J3W+4is0QJuFrA==
X-Google-Smtp-Source: AGHT+IE4e/40kxNJIZ25T26PPyJwuyDGGNrgX2SRxW+xX6qQdtulmHhP+q/CKGklzz9g9RTcpU7g3WnpDj3f5I0S
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:120a:b0:dc7:7655:46ce with
 SMTP id s10-20020a056902120a00b00dc7765546cemr1062959ybu.2.1709885363070;
 Fri, 08 Mar 2024 00:09:23 -0800 (PST)
Date: Fri, 8 Mar 2024 08:09:21 +0000
In-Reply-To: <ZeppLlDeTro6zpIg@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <83b019e2-1b84-491a-b0b9-beb02e45d80c@intel.com>
 <Zeor4DIGj0u6LNIw@google.com> <cb1aaac1-4800-4cae-8aea-acba6353971c@intel.com>
 <Zeo_yUTdGKVed7ff@google.com> <ZeppLlDeTro6zpIg@google.com>
Message-ID: <ZerHsQV8qcyzW0V5@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

> I came up with a kernel patch that I *think* may reproduce the problem
> with enough iterations. Userspace only needs to enable LAM, so I think
> the selftest can be enough to trigger it.
> 
> However, there is no hardware with LAM at my disposal, and IIUC I cannot
> use QEMU without KVM to run a kernel with LAM. I was planning to do more
> testing before sending a non-RFC version, but apparently I cannot do
> any testing beyond building at this point (including reproducing) :/
> 
> Let me know how you want to proceed. I can send a non-RFC v1 based on
> the feedback I got on the RFC, but it will only be build tested.
> 
> For the record, here is the diff that I *think* may reproduce the bug:

Okay, I was actually able to run _some_ testing with the diff below on
_a kernel_, and I hit the BUG_ON pretty quickly. If I did things
correctly, this BUG_ON means that even though we have an outdated LAM in
our CR3, we will not update CR3 because the TLB is up-to-date.

I can work on a v1 now with the IPI approach that Andy suggested. A
small kink is that we may still hit the BUG_ON with that fix, but in
that case it should be fine to not write CR3 because once we re-enable
interrupts we will receive the IPI and fix it. IOW, the diff below will
still BUG with the proposed fix, but it should be okay.

One thing I am not clear about with the IPI approach, if we use
mm_cpumask() to limit the IPI scope, we need to make sure that we read
mm_lam_cr3_mask() *after* we update the cpumask in switch_mm_irqs_off(),
which makes me think we'll need a barrier (and Andy said we want to
avoid those in this path). But looking at the code I see:

		/*
		 * Start remote flushes and then read tlb_gen.
		 */
		if (next != &init_mm)
			cpumask_set_cpu(cpu, mm_cpumask(next));
		next_tlb_gen = atomic64_read(&next->context.tlb_gen);

This code doesn't have a barrier. How do we make sure the read actually
happens after the write?

If no barrier is needed there, then I think we can similarly just read
the LAM mask after cpumask_set_cpu().

> 
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 33b268747bb7b..c37a8c26a3c21 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -750,8 +750,25 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
>  
>  #define LAM_U57_BITS 6
>  
> +static int kthread_fn(void *_mm)
> +{
> +	struct mm_struct *mm = _mm;
> +
> +	/*
> +	 * Wait for LAM to be enabled then schedule. Hopefully we will context
> +	 * switch directly into the task that enabled LAM due to CPU pinning.
> +	 */
> +	kthread_use_mm(mm);
> +	while (!test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags));
> +	schedule();
> +	return 0;
> +}
> +
>  static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
>  {
> +	struct task_struct *kthread_task;
> +	int kthread_cpu;
> +
>  	if (!cpu_feature_enabled(X86_FEATURE_LAM))
>  		return -ENODEV;
>  
> @@ -782,10 +799,22 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
>  		return -EINVAL;
>  	}
>  
> +	/* Pin the task to the current CPU */
> +	set_cpus_allowed_ptr(current, cpumask_of(smp_processor_id()));
> +
> +	/* Run a kthread on another CPU and wait for it to start */
> +	kthread_cpu = cpumask_next_wrap(smp_processor_id(), cpu_online_mask, 0, false),
> +	kthread_task = kthread_run_on_cpu(kthread_fn, mm, kthread_cpu, "lam_repro_kthread");
> +	while (!task_is_running(kthread_task));
> +
>  	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
>  	set_tlbstate_lam_mode(mm);
>  	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
>  
> +	/* Move the task to the kthread CPU */
> +	set_cpus_allowed_ptr(current, cpumask_of(kthread_cpu));
> +
>  	mmap_write_unlock(mm);
>  
>  	return 0;
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 51f9f56941058..3afb53f1a1901 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -593,7 +593,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>  		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
>  		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
>  				next_tlb_gen)
> -			return;
> +			BUG_ON(new_lam != tlbstate_lam_cr3_mask());
>  
>  		/*
>  		 * TLB contents went out of date while we were in lazy
> 

