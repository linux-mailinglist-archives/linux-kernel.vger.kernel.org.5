Return-Path: <linux-kernel+bounces-73337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BC85C126
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0DB1C21ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D33F78B79;
	Tue, 20 Feb 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnH3DEK1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDDF79922
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446040; cv=none; b=sMrGffp713ovIr761dygD2zNucC0r9rNpUIe2yqYSfDfiR/uDjMDsRfFxgcC4uYzZ8iZmq70hpyT62aFdA/2whWpUVlBRUs8wvcn6nA1f2fA2ei6QVGQEqP4MT0mIYplF1SLwJL+CE+w9oxX/5EcJ8TNpArDGLkOQYw5PaldX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446040; c=relaxed/simple;
	bh=tkQx8P4cA4yFykrMvurCrO/U9EcQdI6W6X9CrUgTWAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KpZ+1vXdiXPM8h4ow7HNxtf5ziJoJP+78knMB/BSQU7YyhjsYEob8umRdySdQVYeXFwCgrwQRMTuJqNZHFo1VniDSij1feJk9cZIFxNFnqiiBxXdDqGefotb1qeWdqsxYbVEb46QdvqiFGXpGefzjZSXfcGg2Kf4OOB7Ojk0GL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnH3DEK1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1db90f7b92bso52075275ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708446038; x=1709050838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaBNvIG1XlI7Rma4r4ZehqM6i4uIMsjEXoMFyCXLWog=;
        b=hnH3DEK1TlZ9XwRPa83LdjKnfEDz6mvX3uvbNOKk5vlHxAcF/xGUsoDiW2kmphZJ8P
         sSzYna9rcvjRU0qhgID4aqNAZCnYGaS7rkjVN74ZngY/yBpmP8AlzeLd7pY1SaEAIjuI
         9xov93twffL7EOgDT1w8w9DHfjjiuHWQ4Pq1IzsCXV8iN8Ka/2MxdYq/TUU4/r1vZktI
         YxIc5uaLt+QDWpwjB/5/5VM3dRkP7AL0S/Jdde+HuZFCJj/j3wJKppg6jTdT4bEzSnq1
         DYB5xhRw4vik1jyn9upwPoZ/PsVFyfq+IxzVOtp7WOMrF7+wd+PDFjNftoT07ZP2HVTi
         Ra5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446038; x=1709050838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaBNvIG1XlI7Rma4r4ZehqM6i4uIMsjEXoMFyCXLWog=;
        b=ppf/1nL9NEqdGLT7fb1nR0H8WgiqWOqAPUfZ4U0iUGt9OCTb48zJypTH0Lg4I1ZWJG
         Lf807nekLZWPCMDZiwCVUn6CnqwQcailQRSl2FGaoPhZbPGyFqH6cKSM8sxmL0wFeK4W
         XEJb/FhrFRvrHtAgwpepHzuR76IN/ZTWJqLsZ6d02MUNbH9pW35hisKTB39IMP8sCRte
         qP1gELx4ndJGHCHVx3NtuS6NTvmE7gEkM7Ipgfau1aWS9BgpD+ItPpuXHOtgQjc6819P
         DCgY0qXpEsD/kMLw+WLkzG3071kZNeSLrEV21KtZBxiOfhaZVyn1Mdt+SN6eW5g8LITJ
         kd9A==
X-Forwarded-Encrypted: i=1; AJvYcCWlYZ/JXg0NYwsgjTx5/w7ei7SJADZhiQ+kzlRVNWRbjsXf8UDCcS5mVIB0zJgHUnMfCZg/Ma80CwWzEUZTLb/ydZJewmSvOqi4pAKj
X-Gm-Message-State: AOJu0YxIRM7UoXA1hpuBK8pq9wyMEUUTSKFb4pHFwjx8KIr769luHYaR
	wy3q/pgVi/9EEmLlBvUyLwE/Ki82shiB+i87a/0KMqw/gD0bTXIeUqchcRT1rIFQ6ZMs3sPmvma
	a0Q==
X-Google-Smtp-Source: AGHT+IHQi9e4VsipuZL3tTtt6H5NilJ+ksQWV/bXRNHygHBVBXjwpN+pFq6S26zUER6fkq27ZHG9pHuUsUo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e74d:b0:1db:e494:4b51 with SMTP id
 p13-20020a170902e74d00b001dbe4944b51mr268101plf.4.1708446038280; Tue, 20 Feb
 2024 08:20:38 -0800 (PST)
Date: Tue, 20 Feb 2024 08:20:36 -0800
In-Reply-To: <Zc5MRqmspThUoB+n@AUS-L1-JOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231010200220.897953-1-john.allen@amd.com> <20231010200220.897953-7-john.allen@amd.com>
 <5e413e05de559971cdc2d1a9281a8a271590f62b.camel@redhat.com>
 <ZUQvNIE9iU5TqJfw@google.com> <c077e005c64aa82c7eaf4252f322c4ca29a2d0af.camel@redhat.com>
 <Zc5MRqmspThUoB+n@AUS-L1-JOHALLEN.amd.com>
Message-ID: <ZdTRVNt5GWXEKL8h@google.com>
Subject: Re: [PATCH 6/9] KVM: SVM: Add MSR_IA32_XSS to the GHCB for hypervisor kernel
From: Sean Christopherson <seanjc@google.com>
To: John Allen <john.allen@amd.com>
Cc: mlevitsk@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, weijiang.yang@intel.com, rick.p.edgecombe@intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, John Allen wrote:
> On Tue, Nov 07, 2023 at 08:20:52PM +0200, Maxim Levitsky wrote:
> > On Thu, 2023-11-02 at 16:22 -0700, Sean Christopherson wrote:
> > > On Thu, Nov 02, 2023, Maxim Levitsky wrote:
> > > > On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> > > > > @@ -3032,6 +3037,9 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
> > > > >  		if (guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDTSCP))
> > > > >  			svm_clr_intercept(svm, INTERCEPT_RDTSCP);
> > > > >  	}
> > > > > +
> > > > > +	if (kvm_caps.supported_xss)
> > > > > +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_XSS, 1, 1);
> > > > 
> > > > This is not just a virtualization hole. This allows the guest to set MSR_IA32_XSS
> > > > to whatever value it wants, and thus it might allow XSAVES to access some host msrs
> > > > that guest must not be able to access.
> > > > 
> > > > AMD might not yet have such msrs, but on Intel side I do see various components
> > > > like 'HDC State', 'HWP state' and such.
> > > 
> > > The approach AMD has taken with SEV-ES+ is to have ucode context switch everything
> > > that the guest can access.  So, in theory, if/when AMD adds more XCR0/XSS-based
> > > features, that state will also be context switched.
> > > 
> > > Don't get me wrong, I hate this with a passion, but it's not *quite* fatally unsafe,
> > > just horrific.
> > > 
> > > > I understand that this is needed so that #VC handler could read this msr, and
> > > > trying to read it will cause another #VC which is probably not allowed (I
> > > > don't know this detail of SEV-ES)
> > > > 
> > > > I guess #VC handler should instead use a kernel cached value of this msr
> > > > instead, or at least KVM should only allow reads and not writes to it.
> > > 
> > > Nope, doesn't work.  In addition to automatically context switching state, SEV-ES
> > > also encrypts the guest state, i.e. KVM *can't* correctly virtualize XSS (or XCR0)
> > > for the guest, because KVM *can't* load the guest's desired value into hardware.
> > > 
> > > The guest can do #VMGEXIT (a.k.a. VMMCALL) all it wants to request a certain XSS
> > > or XCR0, and there's not a damn thing KVM can do to service the request.
> > > 
> > 
> > Ah, I understand now. Everything makes sense, and yes, this is really ugly.
> 
> Hi Maxim and Sean,
> 
> It looks as though there are some broad changes that will need to happen
> over the long term WRT to SEV-ES/SEV-SNP. In the short term, how would
> you suggest I proceed with the SVM shstk series? Can we omit the SEV-ES
> changes for now with an additional patch that disallows guest shstk when
> SEV-ES is enabled? Subsequently, when we have a proper solution for the
> concerns discussed here, we could submit another series for SEV-ES
> support.

The SEV-ES mess was already addressed by commit a26b7cd22546 ("KVM: SEV: Do not
intercept accesses to MSR_IA32_XSS for SEV-ES guests").  Or is there more that's
needed for shadow stacks?

