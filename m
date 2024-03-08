Return-Path: <linux-kernel+bounces-96426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDA875BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A567B1F226EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7D225AE;
	Fri,  8 Mar 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOTX4I2F"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FC5C99
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861172; cv=none; b=e3OXV2NNERN5vtCfxd9dbSD/P1inFu902dgaI9cxzBJ20NSrmyZf+LKTAJ8ahkx2tKUgdzr3iF5Hhoau8GSp0EX0+87unXF/8RLXOA0fhFLdMcI3Oc27sg4DnDJ/Y3Gjs7nB0+I9pGiSwLxeAWzhmO/MpW3qoPMS8rjpupk0S48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861172; c=relaxed/simple;
	bh=96/XRL80irZ1AuzIiP5NMtaMObce9uge3pe95rZ2qaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIB2eS4JIPfSgOeRy/of1C1Ekh6GKJfJcmwT3IWdjUlzIezKDQr/PbQ8PxGFL6JxZQB16piTgIrScM/B04c+9e9D3vmsAy9dXUeX0kxpidU+rfRmbC+aOO20zl/Wdp3A9Sru0lPLwP2HmiLG039E+QCBeYo4UTt6jnv1lnAdgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOTX4I2F; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so692894276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 17:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709861169; x=1710465969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXseg/OXOOaXO0QfrFbk0NsY7v7P+AZODbEPqN/H3o8=;
        b=NOTX4I2FwRuz4WRVyWC5vckRc0fbxV8qjDu/yfFJXwzSJFLZwxYY1ygxfZbMH6R/Bp
         K5wAAPl/Y1dSzerGPNx/ZnTInXFrlAjTCoKNFUl81LWR0euytgfnK4EJv0r8UyHM9CUQ
         UaS2jAc0DXgo/DCji19ckPy0XgeYm8qORh1ifE1KDgU1O97sF6T0bEUg/xcCw+69fq5P
         FLzbG6udEsklYWRgmMVYsQ0uFYXatu9/+2MP+1sy4aHYeVsQfsrIRCFuSqA6zPfilvDG
         RbIuDyFDJkkm8nl0YfTKFUEhjGFFDcnYq67GP5vSZ0cEKiwHUbUsPNBugA6tJ6I3qfHU
         fXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709861169; x=1710465969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXseg/OXOOaXO0QfrFbk0NsY7v7P+AZODbEPqN/H3o8=;
        b=H0y+Itxju7LM3xtVKY1LzC3T4oSa85feuCgGwl4K5U4zJP/2ZFOyBXbwLvJmy7EHrP
         Y7q8UZ4kIWElq3VeDNVzyRnQ48vsriThP0VHETlsGODKhYAGBKf57kEZ42v4DsEp89ab
         kzUyOH41baoVnJnefZpCcsPJj8RviWy+gVqggg4+TvGj2iNMwThwCV/JAhlbVafYHzrR
         Bua48gxdl5TWnoaIzeT6sex5qqPtTz+yPJoiBebtBy0UEnF3hS2qAtcfZOo9/SsN4YAT
         ZGn6wAK5hpvyU3aBQPxngSx8yWfwm+j/bJAE0EVZNwf8eugEfi+k9wIaP7dy7B2dwX8V
         6fMw==
X-Forwarded-Encrypted: i=1; AJvYcCV+0wztp6aVWWBcVu5ypmhXPJ/FVl+cDnIDlPRRZwF1y/Ix50Hk0PK0sWGpnHFOlHr5nuRlzgotzLyNcCngp4y1dxFKxFl6i3ZVv/di
X-Gm-Message-State: AOJu0YxtQHFInxDZ0YKEpdjVIPWyG5Py0WfidKCEimHVIQ1GybzPA4Sf
	FJXbJUyIbuzaBb47Fn+Lt/XXHC+9gMP8E3plgnY/MqX6JU3f1B50j6fY53BHvtdM5uODmldGgcc
	sqRLcoQzXmI9PMYuZvw==
X-Google-Smtp-Source: AGHT+IFwilqH/mUypD/jBtdQECzEjD7iyvfhQwzvfhI6NuQeEvEpas/utpcVa7OIlx3iC/kKszoRugEj08/+/mjC
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:18d3:b0:dc7:82ba:ba6e with
 SMTP id ck19-20020a05690218d300b00dc782baba6emr666616ybb.7.1709861168825;
 Thu, 07 Mar 2024 17:26:08 -0800 (PST)
Date: Fri, 8 Mar 2024 01:26:06 +0000
In-Reply-To: <Zeo_yUTdGKVed7ff@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <83b019e2-1b84-491a-b0b9-beb02e45d80c@intel.com>
 <Zeor4DIGj0u6LNIw@google.com> <cb1aaac1-4800-4cae-8aea-acba6353971c@intel.com>
 <Zeo_yUTdGKVed7ff@google.com>
Message-ID: <ZeppLlDeTro6zpIg@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 10:29:29PM +0000, Yosry Ahmed wrote:
> On Thu, Mar 07, 2024 at 01:39:53PM -0800, Dave Hansen wrote:
> > On 3/7/24 13:04, Yosry Ahmed wrote:
> > > I thought about doing inc_mm_tlb_gen() when LAM is updated, but it felt
> > > hacky and more importantly doesn't make it clear in switch_mm_irqs_off()
> > > that we correctly handle LAM updates. We can certainly add a comment,
> > > but I think an explicit check for CPU LAM vs. mm LAM is much clearer.
> > > 
> > > WDYT?
> > 
> > The mm generations are literally there so that if the mm changes that
> > all the CPUs know they need an update.  Changing LAM enabling is 100%
> > consistent with telling other CPUs that they need an update.
> > 
> > I'd be curious of Andy feels differently though.
> 
> The mm generations are TLB-specific and all the code using them implies
> as such (e.g. look at the checks in switch_mm_irqs_off() when prev ==
> next). We can go around and update comments and/or function names to
> make them more generic, but this seems excessive. If we don't, the code
> becomes less clear imo.
> 
> I agree that the use case here is essentially the same (let other
> CPUs know they need to write CR3), but I still think that since the LAM
> case is just a simple one-time enablement, an explicit check in
> switch_mm_irqs_off() would be clearer.
> 
> Just my 2c, let me know what you prefer :)
> 
> > 
> > >> Considering how fun this code path is, a little effort at an actual
> > >> reproduction would be really appreciated.
> > > 
> > > I tried reproducing it but gave up quickly. We need a certain sequence
> > > of events to happen:
> > > 
> > > CPU 1					CPU 2
> > > kthread_use_mm()
> > > 					/* user thread enables LAM */
> > > 					context_switch()
> > > context_switch() /* to user thread */
> > 
> > First, it would be fine to either create a new kthread for reproduction
> > purposes or to hack an existing one.  For instance, have have the LAM
> > prctl() take an extra ref on the mm and stick it in a global variable:
> > 
> > 	mmgrab(current->mm);
> > 	global_mm = current->mm;
> > 
> > Then in the kthread, grab the mm and use it:
> > 
> > 	while (!global_mm);
> > 	kthread_use_mm(global_mm);
> > 	... check for the race
> > 	mmdrop(global_mm);
> > 
> > You can also hackily wait for thread to move with a stupid spin loop:
> > 
> > 	while (smp_processor_id() != 1);
> > 
> > and then actually move it with sched_setaffinity() from userspace.  That
> > can make it easier to get that series of events to happen in lockstep.
> 
> I will take a stab at doing something similar and let you know, thanks.

I came up with a kernel patch that I *think* may reproduce the problem
with enough iterations. Userspace only needs to enable LAM, so I think
the selftest can be enough to trigger it.

However, there is no hardware with LAM at my disposal, and IIUC I cannot
use QEMU without KVM to run a kernel with LAM. I was planning to do more
testing before sending a non-RFC version, but apparently I cannot do
any testing beyond building at this point (including reproducing) :/

Let me know how you want to proceed. I can send a non-RFC v1 based on
the feedback I got on the RFC, but it will only be build tested.

For the record, here is the diff that I *think* may reproduce the bug:

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b268747bb7b..c37a8c26a3c21 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -750,8 +750,25 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #define LAM_U57_BITS 6
 
+static int kthread_fn(void *_mm)
+{
+	struct mm_struct *mm = _mm;
+
+	/*
+	 * Wait for LAM to be enabled then schedule. Hopefully we will context
+	 * switch directly into the task that enabled LAM due to CPU pinning.
+	 */
+	kthread_use_mm(mm);
+	while (!test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags));
+	schedule();
+	return 0;
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 {
+	struct task_struct *kthread_task;
+	int kthread_cpu;
+
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
 		return -ENODEV;
 
@@ -782,10 +799,22 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
+	/* Pin the task to the current CPU */
+	set_cpus_allowed_ptr(current, cpumask_of(smp_processor_id()));
+
+	/* Run a kthread on another CPU and wait for it to start */
+	kthread_cpu = cpumask_next_wrap(smp_processor_id(), cpu_online_mask, 0, false),
+	kthread_task = kthread_run_on_cpu(kthread_fn, mm, kthread_cpu, "lam_repro_kthread");
+	while (!task_is_running(kthread_task));
+
 	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
 	set_tlbstate_lam_mode(mm);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
+	/* Move the task to the kthread CPU */
+	set_cpus_allowed_ptr(current, cpumask_of(kthread_cpu));
+
 	mmap_write_unlock(mm);
 
 	return 0;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 51f9f56941058..3afb53f1a1901 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -593,7 +593,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
 				next_tlb_gen)
-			return;
+			BUG_ON(new_lam != tlbstate_lam_cr3_mask());
 
 		/*
 		 * TLB contents went out of date while we were in lazy


