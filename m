Return-Path: <linux-kernel+bounces-130714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB944897BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE0128291F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AE7156C40;
	Wed,  3 Apr 2024 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3wfA4fc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBF15696C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712186137; cv=none; b=lW3LMmq/Z13rmdZg7smoj9x1h9TJ9dHvxpqHGVRXuIW4A4PqaWv4dQNulpFb0cijreyrwVw6noETmHc6M+JUny3+eQjE6CLi4oNTFs7lf2ViQ72v2lezifZslfqzPvcqg0yBohhw28nz16u4iAa5shdPGTv84kYdO+i8oCDVCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712186137; c=relaxed/simple;
	bh=qNXU/bUrc0L/NLVUkTSuOdRJ6SCODkDxrzDMtdi4DyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=obxtzL8YbTogziYaOus/gMGdJSl5GFkrOKO9l72LwheT9F4qP4jdQjJZAws7Bp5/uP3zmLuNeRQSqkYEW1v5275KgEDLOAVCM5h2RUlYwlhFyPobbSdD59Jr2ZdCndhgOVXZPuKl/hyFBpq8SqZx5/kFTzJek97jJysxtinG1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3wfA4fc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ea80a33cf6so286151b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712186135; x=1712790935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IB8YIURPP9Hr/QwsBdTaRFjE5dnhh/l5+FEwiaO3zio=;
        b=F3wfA4fcW6LlM2GZ0QNMjYGd334clyCfrnaotPL9u2ZjLof3IAresrrIy6Jv6XMOF3
         aW5eWsdY4OLCzwT4ws+TuJYtMQTr5LcbUlTah41IlbyHAZgdEon9GvtjQ6agQuLwRJLs
         Wvif4H0aI4zA9o6kz8bla1ayvQKk4JmvqDWisboVsGx0up6B7wLqDlXXCDMADxG6CPU5
         SuMBHMYsoz7UY86IHFSpXDQs7NYdJ43tt5oK3hwgck7vCEnbTnkWHD9fToiuUR7Y6Uk5
         Q0+v85xkmGJBttyunJGWMInLwmDttvfhClucW8NBe1jKof+ZTsCZLo4LNBeyjLOXw2iq
         s1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712186135; x=1712790935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB8YIURPP9Hr/QwsBdTaRFjE5dnhh/l5+FEwiaO3zio=;
        b=d3qc6eyLGlF3BTOhkONTM85gt+vWC6c7Np6CPAOlHkL0W0spHSjIby60HoQkBuCE0v
         KIUA+JEpQk0pZ9gDqjrO1YshvT/UY4pFXybLC4PawuJYSLGoRdN2jG+O0OiegCxZcAJr
         dCuZ0PcO4wwwHUa4h0d9pZViZh8wUeHE8vzZI7kxQjPd6chd9vnREe2tr0zv4yaO7zyz
         Yl/FU0oafy5cbC47HE1mdBuXiOY4MH0gZ2q3mIOeCdvT/5wriuw28lIjhcajEAIcsRXC
         eVr59SXFohIMb2IA1Fps4AsJmGHPpjCikYfVPZblXvg51MODx1mviC4PfmXESVVBf0Ff
         nfOw==
X-Forwarded-Encrypted: i=1; AJvYcCV81PlrJ2+EvfQMdPmpFdiXbp7I0e7F7k6nsHW1KI6BDXPjTUX7bOpLEK9eaiQBwU6poR4gM0c2E443J4AhQubJ2gIaeneyXbRifPVu
X-Gm-Message-State: AOJu0YwaHdHzJ2uk5qdRebpE2xLZI/RjyPrl2r+llp/1oWdyHjG4bn2H
	j1tnsllxdA86tEE8K3D0StgEUf/O6KgCITeGlBgCCTqXp1ife+NHFG0GMW9/8JWIis/Uhua5IkX
	Llg==
X-Google-Smtp-Source: AGHT+IHM2Gi4Oz11LLDFw68UYLc1qaCz0J93vLN5P6N52qnWfR4AFa7CZZ5/Z9OAygbOKXpXYQsncRkeo0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:983:b0:6ea:f815:a428 with SMTP id
 u3-20020a056a00098300b006eaf815a428mr66918pfg.1.1712186135077; Wed, 03 Apr
 2024 16:15:35 -0700 (PDT)
Date: Wed, 3 Apr 2024 16:15:33 -0700
In-Reply-To: <20240319162602.GF1645738@ls.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com>
 <66a957f4ec4a8591d2ff2550686e361ec648b308.1709288671.git.isaku.yamahata@intel.com>
 <ZekKwlLdf6vm5e5u@google.com> <CALzav=dHNYP02q_CJncwk-JdL9OSB=613v4+siBm1Cp2rmxLLw@mail.gmail.com>
 <20240307015151.GF368614@ls.amr.corp.intel.com> <20240319162602.GF1645738@ls.amr.corp.intel.com>
Message-ID: <Zg3jFRZp8F514r8b@google.com>
Subject: Re: [RFC PATCH 6/8] KVM: x86: Implement kvm_arch_{, pre_}vcpu_map_memory()
From: Sean Christopherson <seanjc@google.com>
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, Federico Parola <federico.parola@polito.it>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 19, 2024, Isaku Yamahata wrote:
> On Wed, Mar 06, 2024 at 05:51:51PM -0800,
> > Yes. We'd like to map exact gpa range for SNP or TDX case. We don't want to map
> > zero at around range.  For SNP or TDX, we map page to GPA, it's one time
> > operation.  It updates measurement.
> > 
> > Say, we'd like to populate GPA1 and GPA2 with initial guest memory image.  And
> > they are within same 2M range.  Map GPA1 first. If GPA2 is also mapped with zero
> > with 2M page, the following mapping of GPA2 fails.  Even if mapping of GPA2
> > succeeds, measurement may be updated when mapping GPA1. 
> > 
> > It's user space VMM responsibility to map GPA range only once at most for SNP or
> > TDX.  Is this too strict requirement for default VM use case to mitigate KVM
> > page fault at guest boot up?  If so, what about a flag like EXACT_MAPPING or
> > something?
> 
> I'm thinking as follows. What do you think?
> 
> - Allow mapping larger than requested with gmem_max_level hook:

I don't see any reason to allow userspace to request a mapping level.  If the
prefetch is defined to have read fault semantics, KVM has all the wiggle room it
needs to do the optimal/sane thing, without having to worry reconcile userspace's
desired mapping level.

>   Depend on the following patch. [1]
>   The gmem_max_level hook allows vendor-backend to determine max level.
>   By default (for default VM or sw-protected), it allows KVM_MAX_HUGEPAGE_LEVEL
>   mapping.  TDX allows only 4KB mapping.
> 
>   [1] https://lore.kernel.org/kvm/20231230172351.574091-31-michael.roth@amd.com/
>   [PATCH v11 30/35] KVM: x86: Add gmem hook for determining max NPT mapping level
> 
> - Pure mapping without coco operation:
>   As Sean suggested at [2], make KVM_MAP_MEMORY pure mapping without coco
>   operation.  In the case of TDX, the API doesn't issue TDX specific operation
>   like TDH.PAGE.ADD() and TDH.EXTEND.MR().  We need TDX specific API.
> 
>   [2] https://lore.kernel.org/kvm/Ze-XW-EbT9vXaagC@google.com/
> 
> - KVM_MAP_MEMORY on already mapped area potentially with large page:
>   It succeeds. Not error.  It doesn't care whether the GPA is backed by large
>   page or not.  Because the use case is pre-population before guest running, it
>   doesn't matter if the given GPA was mapped or not, and what large page level
>   it backs.
> 
>   Do you want error like -EEXIST?

No error.  As above, I think the ioctl() should behave like a read fault, i.e.
be an expensive nop if there's nothing to be done.

For VMA-based memory, userspace can operate on the userspace address.  E.g. if
userspace wants to break CoW, it can do that by writing from userspace.  And if
userspace wants to "request" a certain mapping level, it can do that by MADV_*.

For guest_memfd, there are no protections (everything is RWX, for now), and when
hugepage support comes along, userspace can simply manipulate the guest_memfd
instance as needed.

