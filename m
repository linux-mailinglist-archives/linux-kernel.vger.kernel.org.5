Return-Path: <linux-kernel+bounces-87663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650386D787
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8960E1F21D34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29E74C07;
	Thu, 29 Feb 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmzF74//"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97574BEA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248015; cv=none; b=O3B+1w//MiQnnjgyRLuCa627MJLFSIZGKrmiqBm+6hK1PzQl+fF9a0SkMFUpntWlrHkjjqYu+ZsXjBqR92LqRulEdL3LqYb37FU2bCVZB6wWBJ7Lv2TklO7M0/D6ViDqsmFltfFu3eutl8yagNtgVagRVSLKmT61hKbnFLV54Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248015; c=relaxed/simple;
	bh=xlv4BCWUd+xW1oov75VPMIAgTQnOq8HdvUJUz5cAOE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pKvBJcjgdYN7Bo/dFSPI5txypoJOE+OsfpJfKiZw9S+eLBeecCkqBYyC3tM6dq7BpV9+/ynsSyueaZH8kEYs1U4iShpfdQoIB1scZL7d4h6XSpo9Q9jV5DCrWvv574BPwVaztmn74yTPI1t8Uh5DcE6glMCVsP9EMygXo3sSV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmzF74//; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e5588db705so1210362b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709248012; x=1709852812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDSHqiXfNKpfl7COydQUrDyx9a3y4hCYnPwB57HeAq4=;
        b=vmzF74//eEnu3FEZLvDTrbaKWrHKwN7zPUve1BN473bFERGEAiIRRD+OhFE7prwF6S
         TG9eusVU4Dy3O0jkT89W+9V8w+EiIK5SwoOPH3CamhnPFItXpwCxl5HbxvWExFK1z0DK
         oa5PV9w9iwPmnZhzZL1BndkUIy5I2grBHyNasg//eux/xH8uNx3XVmkWFJGcYo9B3Efq
         t2p03mOEsi/l4goNKK6l8cyYiZLFHQDKq1LWSOEIcZtz922m8nRIqaqcoVzEr7LDmKSM
         k77mt0qF/YSp+Evm/BhxLhp/KaPd3phOGzOrUAV0YadS8o2Uow0yxDoyPa4RSf4bwJ9Q
         QmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248012; x=1709852812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDSHqiXfNKpfl7COydQUrDyx9a3y4hCYnPwB57HeAq4=;
        b=IRDtVr//jMAmvOFmanq+a8NOqYbASB6Y8+tP6gdsFdvOqso4tiSl0/NntgAbNGeHKU
         WlVcykDFnvdUO16O7eNJkhLIosNy3X9uvsyouajHcZpxP7vdyTaB0ZQIgvNK0MauaKmK
         ieic4ASaUMEKUgTen/g6eqbhREgFNY88F2r9yoexWAjV+H3mcF6a9RhBHS4Fs6PiLME7
         p7h6SGHmbUAo03GJ2cDP2UCTucSYCl3UmZGh8vgqVUKcMUovLRL/BJkE5O5ZwZw7tNvw
         /YUWbW86w/pSs5dgOPzLbTwPbnVUmxQOBb5WkeXMhI4vV13KeMELfnMV3Dxc2PXduekp
         3BAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYvsflwWryxw1XcHxPsNBq5o/wQYCdreN8OwqVXJX7hmfMwHejJrpKMtA1nMmIIjJZR4kjfjuL6SCCkErgN/BRPRCVDWWm2hujxnXz
X-Gm-Message-State: AOJu0YyohJ1Z3dvI/1nnrdEir6SYuN3z7dnpVwITWOZWyhfTTgBU4rPI
	VDHsg39jkkqMaXma/sX0SPfusPSCMTkpZl4u2bZYVl22s+jK9mW8fJ548Q01MYvUyuTVhLBZuE7
	+PA==
X-Google-Smtp-Source: AGHT+IGyOJM16ooLf22gCZwTXPwwrqBH5Gu9wh/XTg/dFAQ9ybGaCE2NIcDjGHVD/eYJmV6aRvTArFW5Iac=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d09:b0:6e5:4142:ea1c with SMTP id
 fa9-20020a056a002d0900b006e54142ea1cmr4589pfb.3.1709248012512; Thu, 29 Feb
 2024 15:06:52 -0800 (PST)
Date: Thu, 29 Feb 2024 15:06:51 -0800
In-Reply-To: <2237d6b1-1c90-4acd-99e9-f051556dd6ac@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-9-seanjc@google.com>
 <2237d6b1-1c90-4acd-99e9-f051556dd6ac@intel.com>
Message-ID: <ZeEOC0mo8C4GL708@google.com>
Subject: Re: [PATCH 08/16] KVM: x86/mmu: WARN and skip MMIO cache on private,
 reserved page faults
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 01, 2024, Kai Huang wrote:
> 
> 
> On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > WARN and skip the emulated MMIO fastpath if a private, reserved page fault
> > is encountered, as private+reserved should be an impossible combination
> > (KVM should never create an MMIO SPTE for a private access).
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index bd342ebd0809..9206cfa58feb 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5866,7 +5866,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
> >   		error_code |= PFERR_PRIVATE_ACCESS;
> >   	r = RET_PF_INVALID;
> > -	if (unlikely(error_code & PFERR_RSVD_MASK)) {
> > +	if (unlikely((error_code & PFERR_RSVD_MASK) &&
> > +		     !WARN_ON_ONCE(error_code & PFERR_PRIVATE_ACCESS))) {
> >   		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
> >   		if (r == RET_PF_EMULATE)
> >   			goto emulate;
> 
> It seems this will make KVM continue to call kvm_mmu_do_page_fault() when
> such private+reserve error code actually happens (e.g., due to bug), because
> @r is still RET_PF_INVALID in such case.

Yep.

> Is it better to just return error, e.g., -EINVAL, and give up?

As long as there is no obvious/immediate danger to the host, no obvious way for
the "bad" behavior to cause data corruption for the guest, and continuing on has
a plausible chance of working, then KVM should generally try to continue on and
not terminate the VM.

E.g. in this case, KVM will just skip various fast paths because of the RSVD flag,
and treat the fault like a PRIVATE fault.  Hmm, but page_fault_handle_page_track()
would skip write tracking, which could theoretically cause data corruption, so I
guess arguably it would be safer to bail?

Anyone else have an opinion?  This type of bug should never escape development,
so I'm a-ok effectively killing the VM.  Unless someone has a good argument for
continuing on, I'll go with Kai's suggestion and squash this:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cedacb1b89c5..d796a162b2da 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5892,8 +5892,10 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
                error_code |= PFERR_PRIVATE_ACCESS;
 
        r = RET_PF_INVALID;
-       if (unlikely((error_code & PFERR_RSVD_MASK) &&
-                    !WARN_ON_ONCE(error_code & PFERR_PRIVATE_ACCESS))) {
+       if (unlikely(error_code & PFERR_RSVD_MASK)) {
+               if (WARN_ON_ONCE(error_code & PFERR_PRIVATE_ACCESS))
+                       return -EFAULT;
+
                r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
                if (r == RET_PF_EMULATE)
                        goto emulate;

