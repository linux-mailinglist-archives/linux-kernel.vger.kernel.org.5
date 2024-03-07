Return-Path: <linux-kernel+bounces-96215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6748758B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA391C212E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F31139571;
	Thu,  7 Mar 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHnJMIFT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E913A255
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844142; cv=none; b=E42V4cEWld8hK1LkQr0LotlZKpbOxNl6v+SDWn5ALoXX73XUQN2mOMWWVyEQJavkPXOFdH0LYpEBvoCIZ/iq7xMOuVWe6ZSKsHJkS0XLbhvJgs7Shh6x9cYnSW/d+uUkLiE76pfEbn06WngpuOK8IAYOqP4DCKxhvd8cvM4vuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844142; c=relaxed/simple;
	bh=MRctrYkPSgIQeXMoX8razLFpnd9bab4bZkfsjfKzl30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RRmyVH4wKbsXyl1djhn87xpLrEwIGEpAaSlVZImUa0d23KRQp3wnVlISP59ZYQYehrGqRofBSq8kuxYco9EKvXb8LmwgcFnlnJEgno/fqB6gVcrLc3fmc7lDAuug6aj1kqkiX0xHRUaD/a/9fNwGnLHpsjqXLUomZ4Bue7pzLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHnJMIFT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dcabe5b779so14900745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709844140; x=1710448940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQdNtN78xJnCksQQbRN+GLBXoPr5M5Y4bjQ8v3llxL0=;
        b=ZHnJMIFTPkjstc2I6wjhovoxTTRS/mfUcVbMEcJxAkgiPQssTVDdzcqwiKoUVpN1jV
         W1JuJoAxlgX/X9SvJ2kx/hKBwr1ow6/3y8oxeeDVFytkKjuVaNfuDPZGdyFpKR8Livob
         HceG22AjBHQiN2wo5LFbwwTz7diXYAUogm2VNy7gzhuzv1OCa5d2Hdgla1PBhfwXBW0T
         hEeH9Lht0m/RMKJ4KBDmjeFKy5ruM1ZAOTiYDB/E9YzzLsv+WqxxHMoQD+tb1Z8ABS8W
         ejzFHPekObc3hZF1E+gE0k7sRgNFPwx7OqDEvHdKC0TejBqcPHSmpT7Lo/vzpY7ZTPsL
         TnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844140; x=1710448940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQdNtN78xJnCksQQbRN+GLBXoPr5M5Y4bjQ8v3llxL0=;
        b=HzMghySX7ndnSqB0pEF96Fxi3KRj8amG4jx8hStEZUJprMnmdRcK8MpFIndEIN44mU
         T3/1clO7C8wgvSrkMO1UevFZRHnZV3F3U8a0DvPxei8Y8XhrlJdPLMxlyMpMQhi0ySe6
         tpd3pa7oaqMoUYP84PIh5zrs7H6MzV+m1qAKeysol1UbPeay1XE8Hn5QCGmq1GSIdTYw
         VKGWehS3Wy9pokUGq/DDPIl2gxvV6zC0YpTJYw+vl17O9XKCkzT6LiGwpDEvxirOs+Mm
         SW/Dz3i805WvcliT+Yw8Ahn3Ik3qsoS337nfH8bHg5ryJlo1ohAAxN+kQSg8veh1UYXN
         yVNA==
X-Forwarded-Encrypted: i=1; AJvYcCV7NXCJeiK6m5IkkgpdgLGddVdHqJuMCNkUhaXw0a8esl5uMRTNghSBvJNmg07gMJVlBDFIoS7IOfed+fi2iemIrSOkh3ZAOKSLdZk0
X-Gm-Message-State: AOJu0Yzl47Oj264gqisEikCiJEYBdYgVelkNmyKfXBldQiZU4iu7Ffb0
	QrxCT5w4KV/a0bwDuV8tFWYxWLh11wVP7nO4j5HOfQYA5wh5MlTOAjOn86zwG66lUxv+6TAna1U
	9dSItV1Lf2rIKwXLT3g==
X-Google-Smtp-Source: AGHT+IHE8t4oN+uf/OQDciimdaaIli2dbKCyNod+F1ML8w/S26BvIeQRNR8rcjQpok9SEW4/QlY+jBrUrmk9QumG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:cec8:b0:1dc:df25:76d4 with SMTP
 id d8-20020a170902cec800b001dcdf2576d4mr493481plg.11.1709844140048; Thu, 07
 Mar 2024 12:42:20 -0800 (PST)
Date: Thu, 7 Mar 2024 20:42:18 +0000
In-Reply-To: <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
Message-ID: <ZeomquHvZs9-BKKK@google.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 09:36:58AM -0800, Dave Hansen wrote:
> I know we all have different rules, but any time you could spend absorbing:
> 
> 	https://www.kernel.org/doc/html/next/process/maintainer-tip.html

Thanks for the quick review and tips.

I didn't know this existed, I will take a look before respinning.

> 
> would be appreciated, especially:
> 
> > The condensed patch description in the subject line should start with
> > a uppercase letter and should be written in imperative tone.
> 
> 
> On 3/7/24 05:39, Yosry Ahmed wrote:
> > In switch_mm_irqs_off(), we read the 'mm->context.lam_cr3_mask' into
> > 'new_lam', which is later passed to load_new_mm_cr3(). However, there is
> > a call to set_tlbstate_lam_mode() in between which will read
> > 'mm->context.lam_cr3_mask' again and set 'cpu_tlbstate.lam' accordingly.
> > If we race with another thread updating 'mm->context.lam_cr3_mask', the
> > value in 'cpu_tlbstate.lam' could end up being different from CR3.
> 
> Your description is fine (modulo the we's).  But I slightly reworded it
> to make it more plainly readable:
> 
> LAM can only be enabled when a process is single-threaded.  But _kernel_
> threads can temporarily use a single-threaded process's mm.  That means
> that a context-switching kernel thread can race and observe the mm's LAM
> metadata (mm->context.lam_cr3_mask) change.
> 
> The context switch code does two logical things with that metadata:
> populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
> 'cpu_tlbstate.lam' and CR3 can end up out of sync.
> 
> This de-synchronization is currently harmless.  But it is confusing and
> might lead to warnings or real bugs.

Thanks a lot! I will adopt your version moving forward :)

> 
> --
> 
> > Fix the problem by updating set_tlbstate_lam_mode() to return the LAM
> > mask that was set to 'cpu_tlbstate.lam', and use that mask in
> > switch_mm_irqs_off() when writing CR3. Use READ_ONCE to make sure we
> > read the mask once and use it consistenly.
> 
> Spell checking is also appreciated.

I did run checkpatch. Did it miss something?

> 
> ...
> > -static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
> > +static inline unsigned long set_tlbstate_lam_mode(struct mm_struct *mm)
> >  {
> > -	this_cpu_write(cpu_tlbstate.lam,
> > -		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
> > +	unsigned long lam = READ_ONCE(mm->context.lam_cr3_mask);
> > +
> > +	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
> >  	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
> > +	return lam;
> >  }
> 
> The comments about races need to be _here_ so that the purpose of the
> READ_ONCE() is clear.
> 
> It would also be nice to call out the rule that this can only
> meaningfully be called once per context switch.

I wanted the comments in switch_mm_irqs_off() where the races actually
matter, but I guess I can make the comment more generic and specify that
the return value is used to write CR3 so we READ_ONCE keeps CR3 and
tlbstate.lam consistent.

> 
> > @@ -633,7 +628,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
> >  		barrier();
> >  	}
> >  
> > -	set_tlbstate_lam_mode(next);
> > +	/*
> > +	 * Even if we are not actually switching mm's, another thread could have
> > +	 * updated mm->context.lam_cr3_mask. Make sure tlbstate_lam_cr3_mask()
> > +	 * and the loaded CR3 use the up-to-date mask.
> > +	 */
> 
> I kinda dislike how the comment talks about the details of what
> set_tlbstate_lam_mode() does.  It would be much better to put the meat
> of this comment at the set_tlbstate_lam_mode() definition.

Agreed. I will move most comments to set_tlbstate_lam_mode().

> 
> > +	new_lam = set_tlbstate_lam_mode(next);
> >  	if (need_flush) {
> >  		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
> >  		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
> 
> This is less a complaint about your change and more of the existing
> code, but I wish it was more obvious that set_tlbstate_lam_mode() is
> logically shuffling data (once) from 'next' into the tlbstate.
> 
> The naming makes it sound like it is modifying the tlbstate of 'next'.

We can update the function name to make it more verbose, maybe something
like update_cpu_tlbstate_lam()? We can also try to put "return"
somewhere in the name to imply that it returns the LAM mask it sets, but
I can't make that look pretty.

> 
> But I don't have any particularly brilliant ideas to fix it either.
> Maybe just:
> 
> 	/* new_lam is effectively cpu_tlbstate.lam */
> 
> > @@ -705,7 +705,6 @@ void initialize_tlbstate_and_flush(void)
> >  
> >  	/* LAM expected to be disabled */
> >  	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
> > -	WARN_ON(mm_lam_cr3_mask(mm));
> >  
> >  	/*
> >  	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
> > @@ -724,7 +723,7 @@ void initialize_tlbstate_and_flush(void)
> >  	this_cpu_write(cpu_tlbstate.next_asid, 1);
> >  	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
> >  	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
> > -	set_tlbstate_lam_mode(mm);
> > +	WARN_ON(set_tlbstate_lam_mode(mm));
> 
> The "set_" naming bugs me in both of the sites that get modified here.
> I'd be with a new name that fits better, if we can think of one.

Is it because it's not clear we are updating cpu_tlbstate (in which case
I think update_cpu_tlbstate_lam() is an improvement), or is it because
the function returns a value now? If the latter we can put "return" in
the name somewhere, or keep the function void and pass in an output
parameter.

