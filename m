Return-Path: <linux-kernel+bounces-97691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB8876DDE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FE11C21544
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505991DA3A;
	Fri,  8 Mar 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRAxvtG5"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269223BBC3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709940491; cv=none; b=VtajWtM1yRTquyMWY+18CRpn31xI0LitqxNNSEL9eVZRxkk9zi59vjKWRJFqjBnZ3HG8cwkeb9fxSUVpPH46tcuFbqYXY2O6Mckb6KY5g6mxQST8QsUKCuaRJSVqiTyGj1wkIbkRMwi5VP56FXDsegkq86Img897KnjAjsJpssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709940491; c=relaxed/simple;
	bh=BpN4iQW4PFrq3WVtA7bWTxphTlwS/fKO8mFIPGOtpZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Buf6KesE8K8fF1dyjozZqoHrJ5Kso/cYHfRjGcaj0l/8HvngFtkFH7JQE5O6EGKNAa7gOWf6H5NXQVTbtXOQCiV7s6BSauXYHGAtzXukb4XdXgluosIv91dgKiVD8GE1po4HiBwqSyEY0LaqXHQlWSIpK1bX/zi7WXFjTH1gYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRAxvtG5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e62136860eso1216144b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709940489; x=1710545289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N25dHtdFBFZm2u6EyvcAjsvLHySdv26qbRgS6+X49N0=;
        b=WRAxvtG5vRvZT1YNgSI3niXFlBqKbkMll4cCmp0t2El7oTO7DAnbQPbVBh32wrJUSe
         cv9yJIe7ue5azDN59RnFZjVgj5USUN66eJgB+2HNRyjl1nbVaqMWAEHjJH4AiSKxBvXW
         EneuvUgimHyFAO4GERAM4m9qku9haemxByAN/taS6tgkzVX+sscMoTIzkxZO/7ax7C02
         CclO62pZPcPddmFvlJdaCtqZ+PVmVCZTMEszjPwwj++mZ1ABTQ98C8oPezyAE+BpxAXN
         uRvN8UxwpmpqSZQo4PqOPTRwd8ramGkQdzmS234re6X+XsxGK+6yIGYjwtj5ap17wOXk
         UuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709940489; x=1710545289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N25dHtdFBFZm2u6EyvcAjsvLHySdv26qbRgS6+X49N0=;
        b=pXgK+koaaJNX26JBgqMTUzcREISNeWOHqcZ0oTHdYStMFaVGfJCQA9Jhuh8v8WOqqa
         KQL3ruLHlmthi0vG3Pu7FWrV65ZWtchu/wQZEnwcpPOV4f+H1AiYieAN5iUz4x5K7bM1
         XvY5fS4D/jIsYp7RWqcEYUAtOC0Fqb5HMMB0DgE7wmjik4/CiY7doTLThZsCn0XIl8pO
         FZ0TiYGdaVk2EXha8aXxa0ePfi14N06c5vH+PlNGVcYk9d/Rlxo7ZBvO9L9E7W5rucMP
         8oIIfJbaD1lB3G4iZWs76YPgk9dHsjjcj1k4SQqEykx8ZyHRinohR6+ZbhHrp8Thql05
         DbBw==
X-Forwarded-Encrypted: i=1; AJvYcCWCmZS0Wjq/wjVPlOC+VrhGQf/KLX65bJRZlLchglaGiqYoi/0BIwG8mbBT7q5X2YGS1JsxauGO8T2Sa9kmXhQPMjIhP/j9UGUrtijz
X-Gm-Message-State: AOJu0Yz/vEX7EvvjXbXKyE0U4xsNq1jCM4BzRfkFjYaKtsBqCSMVrkHN
	H/+c6VefIu3YyujtGcc5/jKbXv2wVr4PtNOlI7KV72vcHnZVO4CrgsK65SlV4oKlEMnMBDfM8NZ
	gmQ==
X-Google-Smtp-Source: AGHT+IGN3zZ+AWtJsEXlh5PO0OTuMsdAAMR54BndbvnDsWJGS/ngLorn4ve0GCie0y+F/f1QDNXI6IGNe7w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1817:b0:6e6:508e:395c with SMTP id
 y23-20020a056a00181700b006e6508e395cmr23698pfa.3.1709940489438; Fri, 08 Mar
 2024 15:28:09 -0800 (PST)
Date: Fri, 8 Mar 2024 15:28:08 -0800
In-Reply-To: <ZeqZ+BDTN5bIx0rm@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-10-seanjc@google.com>
 <ZeqZ+BDTN5bIx0rm@yilunxu-OptiPlex-7050>
Message-ID: <ZeufCK2Yj_8Bx7EV@google.com>
Subject: Re: [PATCH 09/16] KVM: x86/mmu: Move private vs. shared check above
 slot validity checks
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 08, 2024, Xu Yilun wrote:
> On Tue, Feb 27, 2024 at 06:41:40PM -0800, Sean Christopherson wrote:
> > Prioritize private vs. shared gfn attribute checks above slot validity
> > checks to ensure a consistent userspace ABI.  E.g. as is, KVM will exit to
> > userspace if there is no memslot, but emulate accesses to the APIC access
> > page even if the attributes mismatch.
> > 
> > Fixes: 8dd2eee9d526 ("KVM: x86/mmu: Handle page fault for private memory")
> > Cc: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Cc: Chao Peng <chao.p.peng@linux.intel.com>
> > Cc: Fuad Tabba <tabba@google.com>
> > Cc: Michael Roth <michael.roth@amd.com>
> > Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 9206cfa58feb..58c5ae8be66c 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4365,11 +4365,6 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  			return RET_PF_EMULATE;
> >  	}
> >  
> > -	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> > -		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > -		return -EFAULT;
> > -	}
> > -
> >  	if (fault->is_private)
> >  		return kvm_faultin_pfn_private(vcpu, fault);
> >  
> > @@ -4410,6 +4405,16 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  	fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> >  	smp_rmb();
> >  
> > +	/*
> > +	 * Check for a private vs. shared mismatch *after* taking a snapshot of
> > +	 * mmu_invalidate_seq, as changes to gfn attributes are guarded by the
> > +	 * invalidation notifier.
> 
> I didn't see how mmu_invalidate_seq influences gfn attribute judgement.
> And there is no synchronization between the below check and
> kvm_vm_set_mem_attributes(), the gfn attribute could still be changing
> after the snapshot.

There is synchronization.  If kvm_vm_set_mem_attributes() changes the attributes,
and thus bumps mmu_invalidate_seq, after kvm_faultin_pfn() takes its snapshot,
then is_page_fault_stale() will detect that an invalidation related to the gfn
occured and resume the guest *without* installing a mapping in KVM's page tables.

I.e. KVM may read the old, stale gfn attributes, but it will never actually
expose the stale attirubtes to the guest.

