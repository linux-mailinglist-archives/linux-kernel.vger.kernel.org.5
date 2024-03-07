Return-Path: <linux-kernel+bounces-96231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C881C8758FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D85A2861E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182513A268;
	Thu,  7 Mar 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uD1xC3PB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42513A241
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845477; cv=none; b=f++cOIsdcZM9pDhatp2yqC5AwlfvNofGM9HfHjyGlsdfsFlFRg1J2TXawwbBYxaWAT942+DUC9eXKOe6+Fedaw7He/K7w5aIXK03Zi+I84/MHdQjCG05biqteeX518BxTK10VPoQSssfAHPDMeZAq1F+xNy4MA0Xaop6DUFCM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845477; c=relaxed/simple;
	bh=VCKYs7F5IXKI69c4iNS+pMTerV0VKmt+Az6+0VU8Y2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SCW3/ZPMtgC1R+YEnGEseU5jYPyNxdn91TMEVTnmnT2o09oYg/9ehU1RQ6fo8ChQwupWuk10qtrfAt0m5lDe0zzpFuzrd8UDAfPnbMmFSJwrgE+gi79Nu6YVJSlrpQZlt+cRpBvgEXZtSE11GGtPO5VBQZnme4gmlOxJptdT26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD1xC3PB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a024c9f5aso1454657b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709845475; x=1710450275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abcHkgaJlKdL9AQhodGhEJEYkKj/UXzrFfTMg7S4USk=;
        b=uD1xC3PBaH1l/0cxAficSF3WRwgVGcQ543k47Zsw8yAHwAb8NKLxjGDwAcTLDcR1Bc
         WabhhzbcbrPwWvhG+e+ebObWRepIz5oWPYRi659V5I8RsgL495nOzUth1QrNvJ8+1c6u
         IWEirDVkOB/gq3WbWjG9B3uF0W5rfqNZTB3Q+KjV6DmVnn5orHsEIter4gNJhNDuELqX
         xIOTre4Gxr/7b8GbNYVCeZoICbQD/YZOP8P8DPRzQys2D09to+ZbGXtPHqc77QPfH5qm
         ruRKCEv9zZTF5KRyY3K6kc0J7QOOi4+6gCkWVuj0b1AzSUuFDBEHLVKR0HDr+W1dZoYn
         CVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845475; x=1710450275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abcHkgaJlKdL9AQhodGhEJEYkKj/UXzrFfTMg7S4USk=;
        b=u9Xh/teOsvPd+xzKbFiXnNvJvoy63+3xsDfuzGbDSYBjmgsPUB3GBg1HyGBWov4yA3
         SWtEV6dvPn7lej5499zKbmeY1oCaR8jJ84ETCX0dYlIRGGlv0EmeeqEX2B2cb3Y2Y0vW
         TvCc1EEZd3+S6abxkvXnKNgxQ1v3fXUlzSjz6KC/ft1jMp2FbMi0hUNDehf/WXoeR1Bj
         9nG16+NXT2fPWlVF9KJB9ss6ZIAfWfp+VdCFP2/DdqdYovmDy726F05yB8jBirgn2MDU
         Gtqc4HJSHGH69AVAxM1pePQ5JycK1kMfa9R2vNCW5LxKzTunS7FkEnYKEntIBeM336Y6
         vvxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjhp38KlEQ8RuhuEIq4RFlHufTKwH4COJSbVEJIU3/8x8Q5waa9BsX/JOLGWSaCbJVS7SJMY4E7c4PiW9O9vbJPsXY381N3+HYQs0w
X-Gm-Message-State: AOJu0YzzgNG6vK5/kzYhSi7MFff9mKzg5Ge3KAVUuEFBNQMU39xRkTwT
	whXeVRPRvHHlbsbbOESvH+ohagVn6i2TZgz022kodiWICoDhAFxRVzAGYSfhZQFne9FuOGeLK/7
	BJTRVNBk3vFyuUfWohA==
X-Google-Smtp-Source: AGHT+IE8Sm8RJ83g5TnEYwVTx6zL2GcqFCr63p/hfZyRIx4GyskOlcNRsPAvrRyFlxHBpp5sVjMNiBqUc/W5XILv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:85:b0:609:3cdf:c737 with SMTP
 id be5-20020a05690c008500b006093cdfc737mr4815606ywb.10.1709845474926; Thu, 07
 Mar 2024 13:04:34 -0800 (PST)
Date: Thu, 7 Mar 2024 21:04:32 +0000
In-Reply-To: <83b019e2-1b84-491a-b0b9-beb02e45d80c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <83b019e2-1b84-491a-b0b9-beb02e45d80c@intel.com>
Message-ID: <Zeor4DIGj0u6LNIw@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 07:29:34AM -0800, Dave Hansen wrote:
> On 3/7/24 05:39, Yosry Ahmed wrote:
> > -		/*
> > -		 * Read the tlb_gen to check whether a flush is needed.
> > -		 * If the TLB is up to date, just use it.
> > -		 * The barrier synchronizes with the tlb_gen increment in
> > -		 * the TLB shootdown code.
> > -		 */
> > -		smp_mb();
> > -		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
> > -		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
> > -				next_tlb_gen)
> > +		if (!need_flush && !need_lam_update)
> >  			return;
> 
> Instead of all this new complexity, why not just inc_mm_tlb_gen() at the
> site where LAM is enabled?  That should signal to any CPU thread that
> its TLB is out of date and it needs to do a full CR3 reload.

It's not really a lot of complexity imo, most of the patch is reverting
the if conditions that return if a TLB flush is not needed to have a
single if block that sets need_flush to true. I can split this to a
different patch if it helps review, or I can do something like this to
keep the diff concise:

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2975d3f89a5de..17ab105522287 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -576,7 +576,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
                 * process. No TLB flush required.
                 */
                if (!was_lazy)
-                       return;
+                       goto check_return;

                /*
                 * Read the tlb_gen to check whether a flush is needed.
@@ -588,7 +588,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
                next_tlb_gen = atomic64_read(&next->context.tlb_gen);
                if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
                                next_tlb_gen)
-                       return;
+                       goto check_return;

                /*
                 * TLB contents went out of date while we were in lazy
@@ -596,6 +596,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
                 */
                new_asid = prev_asid;
                need_flush = true;
+check_return:
+               if (!need_flush && /* LAM up-to-date */)
+                       return;
        } else {
                /*
                 * Apply process to process speculation vulnerability

.but I prefer the current patch though to avoid the goto. I think the
flow is easier to follow.

I thought about doing inc_mm_tlb_gen() when LAM is updated, but it felt
hacky and more importantly doesn't make it clear in switch_mm_irqs_off()
that we correctly handle LAM updates. We can certainly add a comment,
but I think an explicit check for CPU LAM vs. mm LAM is much clearer.

WDYT?

> 
> Also, have you been able to actually catch this scenario in practice?

Nope, by code inspection (as I admitted in the commit log).

> Considering how fun this code path is, a little effort at an actual
> reproduction would be really appreciated.

I tried reproducing it but gave up quickly. We need a certain sequence
of events to happen:

CPU 1					CPU 2
kthread_use_mm()
					/* user thread enables LAM */
					context_switch()
context_switch() /* to user thread */


IIUC we don't really need kthread_use_mm(), we need the kthread to be
scheduled on the CPU directly after the user thread, so maybe something
like:

CPU 1					CPU 2
/* user thread running */
context_switch() /* to kthread */
					/* user thread enables LAM */
					context_switch()
context_switch() /* to user thread */

It doesn't seem easy to reproduce. WDYT?

