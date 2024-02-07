Return-Path: <linux-kernel+bounces-56749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DB84CE8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF20B222E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F48005D;
	Wed,  7 Feb 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0HHLloK"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191377FBD9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321876; cv=none; b=qfhdU70Zpfy+k3Rz1TQnQFoj0PYHdvAThy4UPepXclzVdE8wOKX+5XDRg4TzHyZLV6MSIcC3r4ApcgYIDmIU8vcucdN/ZB9oX4YphbJq+S8XjQGn1MPXKrwX8VA4l+UnVPC9J9bO0cCnMi5UHsnmTbO+2hpqWbpsihR2ouiIPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321876; c=relaxed/simple;
	bh=U784qeJ6nBxw6wDG9iod93zWSvHO8kFyVXpJtlwp29g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vz2u20CIHekFiXi8/QAar2Xjkc8KvR89Vw2NAprCJD/9Hk3dLu77sCZb9rUb6T7SzKLpQ3aYz1g2nxr3BdS1L+YB3XovYKNPVDULXlf2vJnIp9EOzlB9ZPsJYuv9liAtPt0eQx8TirDdMGABlcjwRkuLHqHwnWYJKJKAqoZ/oGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0HHLloK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d94eeacec4so7502095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707321874; x=1707926674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJsjt56qloa4KV7GYlBT9c9OJM+llHEZl1DwXvaLHRs=;
        b=H0HHLloKoqrB+Y+zJeHbIoaUJfg3xDQnm/bOGJjVNecz88lJpERqSEYpJDHz4PoLx3
         J4FO8Xa8c6CuZO81ueSRhT+G3Iz1C+7keUmOHTr32oAk6SaIsn52Ey3jMzsDsic5ORMd
         p7MZaO+u4HpRLAhzgShT8TV1SCyzV9ZQ4w8OvqP7YbA27HgH/GuourbNjaOcnr2I39Ex
         YhBeMWMdK5pxHg2NQQe2fniU1jMq/xBy3/FujWa3GlwEgJf6gkglRx5QW1/7nceqGFZ0
         e8E5wqxZQgqC6p5WOXcJCz4VDztV1FDs1r+vJtsjJi92F4RcVmqLPhMjWXj68q8V+zsG
         k9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321874; x=1707926674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJsjt56qloa4KV7GYlBT9c9OJM+llHEZl1DwXvaLHRs=;
        b=kZRTu0A5lVOhdZbQ70FVWwtfKNeeapT588HMT0c77CGk0Z/lESd2m64EQQXZuB2zbk
         A6kGwu6RwIFQFM9VSSMGFG/NwKEo9hWlv1k/AqSrbMPaHS5RfhFcqFhFWKHpxmznYwIK
         UkPN4t29W9zdh2aKgGtuE868wfv7BlrEv/uH1Pay4FtbpLflu4uaHetXU0bNEQ+wyQPh
         HpxbR1sBWuYBcX1OSV1HIh79QynRlqxCXpNoZNzGXccAbntYR7Mpxh5KEk85HvN4Apsr
         gNvTO/LLBOKucmyUnzQKf6Gacd1kHbzFhFxiS4XEvx6EDEASDy9uVbWpxfshvHgqrzKi
         ukAw==
X-Gm-Message-State: AOJu0YxuQUCe1KoXLJYLvVrFpncpOLOyJQK8voQ2Q2r2diFznFaENUkA
	pnDQ3JEqObLKDwmT5YpO9hV97Va0ByaMA5RPA8GHnxMiFCiVAbAs0UXb0PsIEe+OcjvJC7GftHp
	3ZA==
X-Google-Smtp-Source: AGHT+IFyJtG5EyhxDAVsDKIAhWMowCgx/MJODI19A69KOcFop9G1VyI2+SVO5855R6027qmcImXZ1i7tGXQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e804:b0:1d9:47e7:3c86 with SMTP id
 u4-20020a170902e80400b001d947e73c86mr205386plg.0.1707321874324; Wed, 07 Feb
 2024 08:04:34 -0800 (PST)
Date: Wed, 7 Feb 2024 08:04:32 -0800
In-Reply-To: <20231229022652.300095-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231229022652.300095-1-chao.gao@intel.com>
Message-ID: <ZcOqEBTJ5espqX0E@google.com>
Subject: Re: [PATCH] KVM: VMX: Report up-to-date exit qualification to userspace
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 29, 2023, Chao Gao wrote:
> Use vmx_get_exit_qual() to read the exit qualification.
> 
> vcpu->arch.exit_qualification is cached for EPT violation only and even
> for EPT violation, it is stale at this point because the up-to-date
> value is cached later in handle_ept_violation().

Oof, vcpu->arch.exit_qualification is *gross*.  At a glance, it should be
straightforward to get rid of it and use the fault structure to pass the info
that comes from the MMU.  I'll post a patch, assuming it works.

As for this patch, I'll get it applied for 6.9.

---
 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  | 14 +++++++-------
 arch/x86/kvm/vmx/nested.c       |  5 ++++-
 arch/x86/kvm/vmx/vmx.c          |  2 --
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ad5319a503f0..7ef4715d43d6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -993,9 +993,6 @@ struct kvm_vcpu_arch {
 
 	u64 msr_kvm_poll_control;
 
-	/* set at EPT violation at this point */
-	unsigned long exit_qualification;
-
 	/* pv related host specific info */
 	struct {
 		bool pv_unhalted;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 4351149484fb..b5791a66637e 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -26,6 +26,7 @@ struct x86_exception {
 	bool nested_page_fault;
 	u64 address; /* cr2 or nested page fault gpa */
 	u8 async_page_fault;
+	unsigned long exit_qualification;
 };
 
 /*
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 4d4e98fe4f35..7a87097cb45b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -497,21 +497,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * The other bits are set to 0.
 	 */
 	if (!(errcode & PFERR_RSVD_MASK)) {
-		vcpu->arch.exit_qualification &= (EPT_VIOLATION_GVA_IS_VALID |
-						  EPT_VIOLATION_GVA_TRANSLATED);
+		walker->fault.exit_qualification = 0;
+
 		if (write_fault)
-			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_WRITE;
+			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_WRITE;
 		if (user_fault)
-			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_READ;
+			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
 		if (fetch_fault)
-			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
+			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
 
 		/*
 		 * Note, pte_access holds the raw RWX bits from the EPTE, not
 		 * ACC_*_MASK flags!
 		 */
-		vcpu->arch.exit_qualification |= (pte_access & VMX_EPT_RWX_MASK) <<
-						 EPT_VIOLATION_RWX_SHIFT;
+		walker->fault.exit_qualification |= (pte_access & VMX_EPT_RWX_MASK) <<
+						     EPT_VIOLATION_RWX_SHIFT;
 	}
 #endif
 	walker->fault.address = addr;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 994e014f8a50..15141b08c604 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -407,10 +407,13 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 		struct x86_exception *fault)
 {
+	unsigned long exit_qualification = fault->exit_qualification;
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 vm_exit_reason;
-	unsigned long exit_qualification = vcpu->arch.exit_qualification;
+
+	exit_qualification |= vmx_get_exit_qual(vcpu) &
+			      (EPT_VIOLATION_GVA_IS_VALID | EPT_VIOLATION_GVA_TRANSLATED);
 
 	if (vmx->nested.pml_full) {
 		vm_exit_reason = EXIT_REASON_PML_FULL;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e262bc2ba4e5..1de022af7dcb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5771,8 +5771,6 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) != 0 ?
 	       PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 
-	vcpu->arch.exit_qualification = exit_qualification;
-
 	/*
 	 * Check that the GPA doesn't exceed physical memory limits, as that is
 	 * a guest page fault.  We have to emulate the instruction here, because

base-commit: 873eef46b33c86be414d60bd00390e64fc0f006f
-- 


