Return-Path: <linux-kernel+bounces-141453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD08A1E72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B188D1F2847A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464221384A4;
	Thu, 11 Apr 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWrAwXEd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42994D9F2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858886; cv=none; b=QFpgsxD+4h86sm8a7D/HCJm3bSOcUFG0KyXUaNIrdr5Sx0hWd3135yE0s4RXM8GjG39M8qXD5hXjcM16H5PtIyY7kG4K89yuwvNWnxfJHW2dYoXPPS/XlxYRVJsFa3rwijs0IdI6hY+EK44TM7p+9mN/AgwwIWB9QzmkUJU/O9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858886; c=relaxed/simple;
	bh=VGQCL3mzonvhlfeFM/FLLnPemQv3LzNNv5aOxHxA3fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLH1/2vRxBwpwRhQ4ZcmZcM7FxxXyFPTfm2gN+vkMzsorpVfFxUgeRvebIGYEbe0WMRwYdopLXY78Gcg4oF0VWY5E2ep2Qoa+6vFHmoROmCxuJ+/nRTOgcSMpLsyc/Z0KR70aGkCE+NnFa4ZuKU9aXs3ZBy+aQB5XCsUf6LbXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWrAwXEd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-417d14b39feso971405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712858882; x=1713463682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF9ah2ntSllTmBnh03qU9h5oVsQBiEEOr0oLbxSFsGs=;
        b=zWrAwXEdVUItApaRoHDqqtiDmciPtO0gWHOqh1t0Yysmv6oaYFoS1nJf0vi75vYu3D
         MxaagZAwHGCUv6mnyRFTRVa8Alui/moY5kEan3o38nnE1hRnywdtgQg9BhBGLIeNuJYx
         f2DRYuJhYuqFOUFageLqogRQsV9iHWrQYsEkpab0K/BKaNkjc1lFQ/AojQBx0gWdA6Jn
         8nP+dD6dOfi3sJyznt+z7qtEiSYdcXBteWo7ZHbrMeafceUlgJyh9T7SE6nnhmf9k1Q1
         PkFgwlS67jkQs+uOYMFwYruASCizC11JPC/ZrEWknToJhj8bqNUcSEOkVnnIUT+payXq
         5dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858882; x=1713463682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF9ah2ntSllTmBnh03qU9h5oVsQBiEEOr0oLbxSFsGs=;
        b=iGoPjvNn9+YxTTpg04DvrffObmsWv4Nfrs9aLdP/MnBkiVCmaZT5Z6+kr8X+WNIeNq
         LNdvap46XE25EFMzczysuvDe26xRSlHrLCc+dEWSpFeVrIv28hd0/i0m4kFveD5KiR42
         esoe3n7FLkchfIKCNqwLpfKB0SXNHqVizzx5fHkKFe6urPwGAWnnY3ZST6x6nNWS15Bg
         kFF1AD3rcNPQmv5bXbLw2IvMwEHlOiXyB67P47g7qOCRETsXX3cL4jZ/XsBBN3KULuFA
         mQKxN8DVe19nrXaICU2MBJ+Z0ATjyme0CIk3tKZLPhYEOl7PGbmvFUeJsLITe7j8kaOP
         T23A==
X-Forwarded-Encrypted: i=1; AJvYcCUtEzS1mXVa9/NIpDRYDiwyQzsHw4waVUFvOYJr2cH1nLaAjINqkoTrpeMS7AFdN1NkokjOF65b1c/6imHf1xR31O+BKRC8n/mbINN7
X-Gm-Message-State: AOJu0Yx6615faLlD2LEXsgbeU5QwHw7vatHRZiKT2SAaGcuIvphJzW7Q
	Xs+BEYSJGU9rCrzPwqIGv/BAK/Spt+iEI5fnzvVrluYZsdxGL+0XW0e2cOhd7evfBE2o70/Yl8J
	RSC9BYh6Q5sLnJAo72nbm/xc+fSOyNWhx3HCT
X-Google-Smtp-Source: AGHT+IEiceYluBXhzFycxHV9lNDFzL73YQ5JDtztY+Gf/8JctaddlSPwXQ5PFONIuLRV5abA4HCPeSQtllcEjNpQPdk=
X-Received: by 2002:a05:6000:eca:b0:346:bc1b:4efa with SMTP id
 ea10-20020a0560000eca00b00346bc1b4efamr230532wrb.32.1712858881999; Thu, 11
 Apr 2024 11:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-6-jthoughton@google.com> <ZhgZHJH3c5Lb5SBs@google.com>
 <Zhgdw8mVNYZvzgWH@google.com> <CALzav=f=_+UQBJv_eZ=t5wE0AytVo1mwfDoum+ZyNfNHvyOccQ@mail.gmail.com>
In-Reply-To: <CALzav=f=_+UQBJv_eZ=t5wE0AytVo1mwfDoum+ZyNfNHvyOccQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 11 Apr 2024 11:07:35 -0700
Message-ID: <CALzav=euNq2eaHYg79V=sZWytGBh-=TNoHNwRMgChy+DsCNRrw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] KVM: x86: Participate in bitmap-based PTE aging
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Yu Zhao <yuzhao@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Gavin Shan <gshan@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Rientjes <rientjes@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:00=E2=80=AFAM David Matlack <dmatlack@google.com=
> wrote:
>
> On Thu, Apr 11, 2024 at 10:28=E2=80=AFAM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2024-04-11 10:08 AM, David Matlack wrote:
> > > On 2024-04-01 11:29 PM, James Houghton wrote:
> > > > Only handle the TDP MMU case for now. In other cases, if a bitmap w=
as
> > > > not provided, fallback to the slowpath that takes mmu_lock, or, if =
a
> > > > bitmap was provided, inform the caller that the bitmap is unreliabl=
e.
> > > >
> > > > Suggested-by: Yu Zhao <yuzhao@google.com>
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > > ---
> > > >  arch/x86/include/asm/kvm_host.h | 14 ++++++++++++++
> > > >  arch/x86/kvm/mmu/mmu.c          | 16 ++++++++++++++--
> > > >  arch/x86/kvm/mmu/tdp_mmu.c      | 10 +++++++++-
> > > >  3 files changed, 37 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm=
/kvm_host.h
> > > > index 3b58e2306621..c30918d0887e 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -2324,4 +2324,18 @@ int memslot_rmap_alloc(struct kvm_memory_slo=
t *slot, unsigned long npages);
> > > >   */
> > > >  #define KVM_EXIT_HYPERCALL_MBZ             GENMASK_ULL(31, 1)
> > > >
> > > > +#define kvm_arch_prepare_bitmap_age kvm_arch_prepare_bitmap_age
> > > > +static inline bool kvm_arch_prepare_bitmap_age(struct mmu_notifier=
 *mn)
> > > > +{
> > > > +   /*
> > > > +    * Indicate that we support bitmap-based aging when using the T=
DP MMU
> > > > +    * and the accessed bit is available in the TDP page tables.
> > > > +    *
> > > > +    * We have no other preparatory work to do here, so we do not n=
eed to
> > > > +    * redefine kvm_arch_finish_bitmap_age().
> > > > +    */
> > > > +   return IS_ENABLED(CONFIG_X86_64) && tdp_mmu_enabled
> > > > +                                    && shadow_accessed_mask;
> > > > +}
> > > > +
> > > >  #endif /* _ASM_X86_KVM_HOST_H */
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 992e651540e8..fae1a75750bb 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -1674,8 +1674,14 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm=
_gfn_range *range)
> > > >  {
> > > >     bool young =3D false;
> > > >
> > > > -   if (kvm_memslots_have_rmaps(kvm))
> > > > +   if (kvm_memslots_have_rmaps(kvm)) {
> > > > +           if (range->lockless) {
> > > > +                   kvm_age_set_unreliable(range);
> > > > +                   return false;
> > > > +           }
> > >
> > > If a VM has TDP MMU enabled, supports A/D bits, and is using nested
> > > virtualization, MGLRU will effectively be blind to all accesses made =
by
> > > the VM.
> > >
> > > kvm_arch_prepare_bitmap_age() will return true indicating that the
> > > bitmap is supported. But then kvm_age_gfn() and kvm_test_age_gfn() wi=
ll
> > > return false immediately and indicate the bitmap is unreliable becaus=
e a
> > > shadow root is allocate. The notfier will then return
> > > MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
>
> Ah no, I'm wrong here. Setting args.unreliable causes the notifier to
> return 0 instead of MMU_NOTIFIER_YOUNG_FAST.
> MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE is used for something else.

Nope, wrong again. Just ignore me while I try to figure out how this
actually works :)

