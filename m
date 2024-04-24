Return-Path: <linux-kernel+bounces-157656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E013A8B141A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9751F254F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBFC13D619;
	Wed, 24 Apr 2024 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1OE30EUz"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C813CA8A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989208; cv=none; b=tVg+QB8QThTNk7tZUoq+eAg03u555s1+fgJ7g2+Uujwp2WOkvIDSk9V6VM0nmgbag7AxRl+gThduRWe9l3noCBwhQQZmiNJJFnpFN1QrV8r8lgadKZK1i8DZlGe+o1KBnZEph21bh6vU+254Tx35tdqiusgoQEwnNCAtNnuLX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989208; c=relaxed/simple;
	bh=uWXMPDYWFG20hlnbBfNogPfpstbdlZgXUMphxfDgl8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/lC/7ZuG+wKpgGKUf00zhhA10EyYOKJXt+7pU5aQsJJO5icfgAydPovs5D15PyNMwVnt44zQXHdrHeISU/G1hfEWLqzaiS+Ny3caJVdpVlx78ALWswkeZbKB9i5iaQ5ylixWPFhiSzzEf3IZZYa7aKRlmoEAP4vbT2sOnpugw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1OE30EUz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de465062289so539829276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713989206; x=1714594006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlhsoXSQQTmdEdl4VNYW2LnzRRCDi53oysOREuqnEbs=;
        b=1OE30EUzyNIBWHQiSzTPmYIkpka0SxF/6+RiOrKS94zV9tDmC6r/3q3rYQJiJObYBi
         gw7fGH4zRibgFtb+adOQcMYZc/ewehFu6AQYuz4GhAWmbsNHAS492gmSj69ukOEi4fTO
         NrCmjv5Tuz2o5leVrmzCCl9yeD7nY2lPSamtNu1TAuGMALtH+BBOjPMlidNwI6J8hiBY
         dSl22yv6n48JyNeGqLEO/oiEw/6xE+F75wcwN9YriNKyqFjuuPHDHWD190s8WvhpPjxS
         hLp1iOIL4sjsx+wLaBs5/lrfP5g+NkbQO8BAb7jxVN5r9tmtYI0uXkGDSKpJBrHwEolJ
         RClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989206; x=1714594006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlhsoXSQQTmdEdl4VNYW2LnzRRCDi53oysOREuqnEbs=;
        b=mP2I97PpAf37bkj2ZZG1Ab94Q56RaUUpFKPlSrJ8AuNEKjE6OaxHdPF+fr/JcL+TCp
         yRDhq9qZ4bnVyyTColcLYGGm35MStbO9givDLfHwqLUeKuDavohffeZ1Awp31ZZru/Gd
         QHDin5tmibu+63MOaeabcke/pN6G8S7SGilUkD1OnDRgz7lhhboM32J8wcsZI9EcDtkn
         fMyqnn80fabxYEv66s9gwKFOX0tYgd97fPtBdicVXesR4Pd63+HAPUAkGtNjwpEoXrsR
         GjZPgGqCVM4lBlTSY0OPZGe5uUzvUx1T/wLr4eAAOgtkFP8rXIpFgbwzzWHOlrUjNhEu
         9Ckg==
X-Forwarded-Encrypted: i=1; AJvYcCUdysec5+rvJRdHSLswjRhp7z1iXC4GbOewBBrlHbAaM3Iy0Gp0HgLcAdPuMwLNkJcS08Tme96WPcAz0smHZEelHkjNiHFviXFmpkqr
X-Gm-Message-State: AOJu0Yz36aiVT7kOxRGcCMNLmEO6iL1AlmiAm89bWFhtW0bXYNKbzZCq
	x45CwnZHPovrAJEKiP2SdKOQ0gOrdYy7mODariqC1ByOa4YwyeUw+PAX5DYt5QCQN7kV1P4do3p
	NWQ==
X-Google-Smtp-Source: AGHT+IEulYAWNLd2E6Oha1x215niivtI5EFQEyjqnPGsHZGbGHkbgrUEjU/lFsGoMGfjxpMEQAlfuW8OdQk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1024:b0:dcc:e1a6:aca9 with SMTP id
 x4-20020a056902102400b00dcce1a6aca9mr1145674ybt.9.1713989205971; Wed, 24 Apr
 2024 13:06:45 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:06:44 -0700
In-Reply-To: <ZgyBckwbrijACeB1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309012725.1409949-1-seanjc@google.com> <20240309012725.1409949-9-seanjc@google.com>
 <ZfRtSKcXTI/lAQxE@intel.com> <ZfSLRrf1CtJEGZw2@google.com>
 <1e063b73-0f9a-4956-9634-2552e6e63ee1@intel.com> <ZgyBckwbrijACeB1@google.com>
Message-ID: <ZilmVN0gbFlpnHO9@google.com>
Subject: Re: [PATCH v6 8/9] KVM: VMX: Open code VMX preemption timer rate mask
 in its accessor
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Shan Kang <shan.kang@intel.com>, Kai Huang <kai.huang@intel.com>, Xin Li <xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 02, 2024, Sean Christopherson wrote:
> On Mon, Apr 01, 2024, Xiaoyao Li wrote:
> > On 3/16/2024 1:54 AM, Sean Christopherson wrote:
> > > On Fri, Mar 15, 2024, Zhao Liu wrote:
> > > > On Fri, Mar 08, 2024 at 05:27:24PM -0800, Sean Christopherson wrote:
> > > > > Use vmx_misc_preemption_timer_rate() to get the rate in hardware_setup(),
> > > > > and open code the rate's bitmask in vmx_misc_preemption_timer_rate() so
> > > > > that the function looks like all the helpers that grab values from
> > > > > VMX_BASIC and VMX_MISC MSR values.
> > > 
> > > ...
> > > 
> > > > > -#define VMX_MISC_PREEMPTION_TIMER_RATE_MASK	GENMASK_ULL(4, 0)
> > > > >   #define VMX_MISC_SAVE_EFER_LMA			BIT_ULL(5)
> > > > >   #define VMX_MISC_ACTIVITY_HLT			BIT_ULL(6)
> > > > >   #define VMX_MISC_ACTIVITY_SHUTDOWN		BIT_ULL(7)
> > > > > @@ -162,7 +161,7 @@ static inline u32 vmx_basic_vmcs_mem_type(u64 vmx_basic)
> > > > >   static inline int vmx_misc_preemption_timer_rate(u64 vmx_misc)
> > > > >   {
> > > > > -	return vmx_misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
> > > > > +	return vmx_misc & GENMASK_ULL(4, 0);
> > > > >   }
> > > > 
> > > > I feel keeping VMX_MISC_PREEMPTION_TIMER_RATE_MASK is clearer than
> > > > GENMASK_ULL(4, 0), and the former improves code readability.
> > > > 
> > > > May not need to drop VMX_MISC_PREEMPTION_TIMER_RATE_MASK?
> > > 
> > > I don't necessarily disagree, but in this case I value consistency over one
> > > individual case.  As called out in the changelog, the motivation is to make
> > > vmx_misc_preemption_timer_rate() look like all the surrounding helpers.
> > > 
> > > _If_ we want to preserve the mask, then we should add #defines for vmx_misc_cr3_count(),
> > > vmx_misc_max_msr(), etc.
> > > 
> > > I don't have a super strong preference, though I think my vote would be to not
> > > add the masks and go with this patch.  These helpers are intended to be the _only_
> > > way to access the fields, i.e. they effectively _are_ the mask macros, just in
> > > function form.
> > > 
> > 
> > +1.
> > 
> > However, it seems different for vmx_basic_vmcs_mem_type() in patch 5, that I
> > just recommended to define the MASK.
> > 
> > Because we already have
> > 
> > 	#define VMX_BASIC_MEM_TYPE_SHIFT	50
> > 
> > and it has been used in vmx/nested.c,
> > 
> > static inline u32 vmx_basic_vmcs_mem_type(u64 vmx_basic)
> > {
> > 	return (vmx_basic & GENMASK_ULL(53, 50)) >>
> > 		VMX_BASIC_MEM_TYPE_SHIFT;
> > }
> > 
> > looks not intuitive than original patch.
> 
> Yeah, agreed, that's taking the worst of both worlds.  I'll update patch 5 to drop
> VMX_BASIC_MEM_TYPE_SHIFT when effectively "moving" it into vmx_basic_vmcs_mem_type().

Drat.  Finally getting back to this, dropping VMX_BASIC_MEM_TYPE_SHIFT doesn't
work because it's used by nested_vmx_setup_basic(), as is VMX_BASIC_VMCS_SIZE_SHIFT,
which is presumably why past me kept them around.

I'm leaning towards keeping things as proposed in this series.  I don't see us
gaining a third copy, or even a third user, i.e. I don't think we are creating a
future problem by open coding the shift in vmx_basic_vmcs_mem_type().  And IMO
code like this

	return (vmx_basic & VMX_BASIC_MEM_TYPE_MASK) >>
	       VMX_BASIC_MEM_TYPE_SHIFT;

is an unnecessary obfuscation when there is literally one user (the accessor).

Another idea would be to delete VMX_BASIC_MEM_TYPE_SHIFT and VMX_BASIC_VMCS_SIZE_SHIFT,
and either open code the values or use local const variables, but that also seems
like a net negative, e.g. splits the effective definitions over too many locations.

