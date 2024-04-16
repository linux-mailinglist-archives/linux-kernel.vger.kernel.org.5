Return-Path: <linux-kernel+bounces-147749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CFF8A7889
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B75B2812B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95B13AA4D;
	Tue, 16 Apr 2024 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMrwmiiW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C813A889
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309701; cv=none; b=tl22zHdQ/QZ3tAFffKhfDItQIsISvqCU4CdkZGOjM8siiYK8zC0YsNlWYoJitfJvtfUXtncSxapWtY98TXd9o0Uze6gNw/is3JN1fd8iXwa9669F5HsVlK+XwdJ5MZ3xlJZ5W98APPDFz90fRHScd7C9QDqg26eSkQzcSKfu/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309701; c=relaxed/simple;
	bh=TZ1TDxtq5mS8jogcFiQ2mpp3PgNw6F0xy2onDnlG92k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AXuLO2RClvgiOlJuoDDBxPJc1QK0F4LBy7IaChhdqZ20VwZbFhuvRZtzvqWma0kU0zpd0lKLaNsoTh2oaiYibWjiC2+fov3G3K2G5NtSgLU8+QOxEdaYR1WRnyI/8DXv0FZLZ0XMNZf24Y3mIQI9U9GUhVUHZad25zQNcBWoWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMrwmiiW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso7571601276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713309699; x=1713914499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRAv116/X/EXCKcRiElV2IY/zNoHQwSQq8KUhnFUBgo=;
        b=lMrwmiiW3hTemU5QPn9CXadYznXPgOyWjF7H1Lx+83zxlohEqNpzFYNMVEVq+jJv7r
         oRi1VHnHgDaKWZWcQE08leAbZ8IdqX1AYuOMH9TUApvmOQHuHHsi9xMxnRnAj2U0hlKq
         VN7VXvVMyZS9vnODyMPAWxA48KhTQEX5CNDXjRVZ6zsgoR9MyPuxGaEoY5ZCbJaChmwb
         p0U5WWXoEJ3cY5miDaOPm8FmYwTc5y7AxIW965ogcmFf1DKSDZjuvY07aBqK4K9JgKLj
         aYCcAdOYmTi/mDxYNCMPHMkHyjEZzGqWwM0z0i1vZc0P5Vb4wwdXIIH2zmR2doUcNuOq
         6foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309699; x=1713914499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRAv116/X/EXCKcRiElV2IY/zNoHQwSQq8KUhnFUBgo=;
        b=crlHolbUXOLpcs0SazevtTnsE7jSUiRsqN+OPsKhDxpd/WJiBrmGdSPuMtXVay/6MP
         JwG6YLHklJeDdHOaGNQwCdrpTvcmARG4EEyetXhOhUTRB7CUpW381Kc/PkobPMxoIWa0
         AFJ/TQVM6IyKoMhmZVTrqt6y0SHtDt0m38d/6z0VGdJLnUAJ61qSolSs4wfcJchfrLDZ
         Ia2fJMUVyTEWvvXsT1rA4OkgHOmXHWGB/9GgRB5DdJ7r22B3VYRSIFpbE04CaSITLxnB
         8G77S43Fqceo0byVYxduturieFei4LNsdSRiPtfxt/l4TTrvZG94j6xsAxDZgH9j2V+G
         KJMw==
X-Forwarded-Encrypted: i=1; AJvYcCU8HX1AAeKE+1kKkkBlW8aCQmiacFJyH0u3AeUaGZqsJIk+m+f26M1/J6PgKg4CbYdXkBK+qBabcXGQWTtUXfXVkYuf1tYMZ7jJ42hr
X-Gm-Message-State: AOJu0YwkVrrohINhftIAfOsLkl7FKJxx40xFDQ6kfrZAt1Z4E+ABzFXW
	M0+9TMQxQdQNOI0+BC18woSiIFlqDfRTzhpI4QrWd93hr1W+r6jFfK8XBt943Ln3R3Cllo47GOT
	rgQ==
X-Google-Smtp-Source: AGHT+IHhox7XZBxgo4niwaT1Qmgey2WMckjhlZukXGiEaC7r8lfkTzDaY+UCmRBkb7dqS2tm6mqQFKH6dto=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:9cf:0:b0:dc7:4af0:8c6c with SMTP id
 y15-20020a5b09cf000000b00dc74af08c6cmr1530605ybq.6.1713309699386; Tue, 16 Apr
 2024 16:21:39 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:21:37 -0700
In-Reply-To: <af4c78c1-ccd5-4c4d-92de-564a44fa815b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411144322.14585-1-xry111@xry111.site> <20240411144322.14585-2-xry111@xry111.site>
 <ZhgOPRIA5lyhTfGs@google.com> <af4c78c1-ccd5-4c4d-92de-564a44fa815b@intel.com>
Message-ID: <Zh8IAcT0fQoyes_1@google.com>
Subject: Re: [PATCH v7 2/2] x86/mm: Don't disable INVLPG if the kernel is
 running on a hypervisor
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michael Kelley <mhklinux@outlook.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 11, 2024, Dave Hansen wrote:
> On 4/11/24 09:22, Sean Christopherson wrote:
> > In other words, simply checking HYPERVISOR *might* be safe, but it might not.
> > If we wanted to be paranoid, this could also check X86_FEATURE_VMX, which also
> > doesn't guarantee VMX non-root mode and would unnecessarily restrict PCID usage
> > to setups that allow nested VMX, but AFAIK there aren't any hypervisors which
> > fully emulate VMX.
> 
> X86_FEATURE_HYPERVISOR is most commonly used for vulnerabilities to see
> if the data coming out of CPUID is likely to be garbage or not.  I think
> that's the most important thing to focus on.
> 
> It's arguable that x86_match_cpu() itself should just have a:
> 
> 	/*
> 	 * Don't even waste our time when running under a hypervisor.
> 	 * They lie.
> 	 */
> 	if (boot_cpu_bas(X86_FEATURE_HYPERVISOR))
> 		return NULL;
> 
> (well, it should probably actually be in the for() loop because folks
> might be looking for an X86_FEATURE_* that is set by software or derived
> from actually agreed-upon host<->guest ABI, but you get my point...)
> 
> If the hypervisor is duplicitous enough to keep X86_FEATURE_HYPERVISOR
> from getting set, then the hypervisor gets to clean up the mess.  The
> kernel can just wash its hands of the whole thing.
> 
> So, there are two broad cases and a few sub-cases:
> 
> 1. "Nice" hypervisor.  Kernel sees X86_FEATURE_HYPERVISOR and knows that
>    x86_match_cpu() and invlpg_miss_ids[] are irrelevant because:
>  1a.  It is running in VMX non-root mode and is not vulnerable, or
>  1b.  CPUID is a lie and x86_match_cpu() is meaningless, or
>  1c.  The kernel is in ring3 and can't execute INVLPG anyway.  Whatever
>       is running in ring0 will have to deal with it.
> 2. X86_FEATURE_HYPERVISOR is unset.
>  2a. "Mean" hypervisor. All bets are off anyway.
>  2b. Actual bare metal. Actually look for the bug.
> 
> I _think_ I'm OK with skipping the mitigation in all of the #1 cases and
> applying it in both of the #2 cases.  I don't think that checking for
> VMX makes it much better.
> 
> Am I missing anything?

I'm a-ok with just checking HYPERVISOR, I agree that the hypervisor is fully
responsible for correctly emulating PCID and INVLPG stuff for (1c).

My reaction was really just to the changelog equating HYPERVSIOR to VMX non-root.

