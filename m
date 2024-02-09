Return-Path: <linux-kernel+bounces-60089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6626284FFB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF291F23CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07F3984A;
	Fri,  9 Feb 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsOg8o9F"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BD3B1A0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517030; cv=none; b=WLOt4t2BI6MDSzz2EqB7yQjOfo11GoEAhfxyKh4T1ZnmClRmWZSMP0MPSsjjFHH7IVe3IFi5DYWkhpMrxw4a2qiy9ZpACBegq8FDgvxHTqj9Tkt5PHfbUQ/MOYMfpdeqqDQd6e6XXjOdQFj3sOLycV93yg+vxYhRuYBXrAVQal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517030; c=relaxed/simple;
	bh=m+yWYZl+6lZDOPSuIdLV5f59M0wUnPDZJiBRg1Mk2Ys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GYdOzLzue6DHw4hMhdIXBZEUE9SDNGplo8okbpjad2uHDfI+Q0qoD7YyrKiz3SnWswsPHELXg9V379g8DNGtftkpIltsD4RW7PQvAMEYspiuFC9yq1NMJpX63rHeVJ4/I9hTHXKNwtXE/flMVeyqTMsJLhnFT9ql7Cr5ScNnIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsOg8o9F; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602dae507caso27271847b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517027; x=1708121827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mZnCItuDvbZkdQunBsA68aRkk/hge2O9/C7d+7lVbaA=;
        b=OsOg8o9FSAY+COwOunvTqVB6HEDwfvnuw8wuVq1CNyCzrkFAkyG2t6bPpkls2pIz02
         UjxPu9U/BKE6D4sHuQR1l0HJ7VxlDMatJtxZXvPKN0KkdiDUbLSjKBaUGVk3Nvx0LIPP
         X4JdP8Q0PW307h7lmZaUo7oSrHmmL3Rbl11K3Xm8PSiBE4MBl9InqIH0yCqP3fNleDvc
         cGZptsW2xIX5shNynInYQFwIYPPdLbGQfwUJAMQy6LFMjfdWSmCq9XshcrbYsKmck+Rc
         uthntkNCGsNAnhIV8wy8PdqUGL3mapKcnnTS5YRrU2cVclK2hJWgi66A43psmAAV2Cl+
         gKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517027; x=1708121827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZnCItuDvbZkdQunBsA68aRkk/hge2O9/C7d+7lVbaA=;
        b=KlvNB7oE+ZtPSamNruS2VHvRye05yW9QZtt7JDLKWB8neFv/QjHtPR+BvpgmbJM2+o
         TcmBEVY0xgBzbUkk4KYG9fEfjnQIM+Xx1MPiLOuT9pi10C0vg1l7i9eKPBs06Uz2crQP
         Cx5ZllcegCK4c6zWQn1c3b5SGIhF2wHFMCi8eKSkIIt8Ni+CQTc1p0uPFMbU7aP2R7aF
         XafdTszQzzDFGK+S4ZpzB7u3uI0VgfjRhaurihD+70bZ9Nn7ifwmxAPdW1ncEHYmaNhi
         zMb2x9SkhdjV14P63UKA7URldPjD6qXMhroyuo28fzoZs9RrGlB1B3pYFwYFmDmHxqsf
         sOvw==
X-Gm-Message-State: AOJu0YyOOFqoLIBT4cy00uHhjDvW18gXapeZseDwjFcTHgIaqGRkC+Yn
	0YgWYLj8wHB7EJb/h4aRpZ+kghmhnNS9HixWZVJEEjUpCpNiGQY6MZQ2gIV7twsWY3ISU5v9Kw7
	CpA==
X-Google-Smtp-Source: AGHT+IG7SXxnosYhngfLQSClff0kUEyE2VzBUkFxPSnvX7G5Tmbn2tgydx2K3G2DqXoPQ1DqOxXgJo1dEk4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9c08:0:b0:dc6:f21f:64ac with SMTP id
 c8-20020a259c08000000b00dc6f21f64acmr114763ybo.12.1707517026937; Fri, 09 Feb
 2024 14:17:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:16:59 -0800
In-Reply-To: <20240209221700.393189-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209221700.393189-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209221700.393189-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: x86: Move nEPT exit_qualification field from
 kvm_vcpu_arch to x86_exception
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the exit_qualification field that is used to track information about
in-flight nEPT violations from "struct kvm_vcpu_arch" to "x86_exception",
i.e. associate the information with the actual nEPT violation instead of
the vCPU.  To handle bits that are pulled from vmcs.EXIT_QUALIFICATION,
i.e. that are propagated from the "original" EPT violation VM-Exit, simply
grab them from the VMCS on-demand when injecting a nEPT Violation or a PML
Full VM-exit.

Aside from being ugly, having an exit_qualification field in kvm_vcpu_arch
is outright dangerous, e.g. see commit d7f0a00e438d ("KVM: VMX: Report
up-to-date exit qualification to userspace").

Opportunstically add a comment to call out that PML Full and EPT Violation
VM-Exits use the same bit to report NMI blocking information.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  | 14 +++++++-------
 arch/x86/kvm/vmx/nested.c       | 14 ++++++++++++--
 arch/x86/kvm/vmx/vmx.c          |  2 --
 5 files changed, 20 insertions(+), 14 deletions(-)

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
index 1eebed84bb65..4d0561136e70 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -409,18 +409,28 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long exit_qualification;
 	u32 vm_exit_reason;
-	unsigned long exit_qualification = vcpu->arch.exit_qualification;
 
 	if (vmx->nested.pml_full) {
 		vm_exit_reason = EXIT_REASON_PML_FULL;
 		vmx->nested.pml_full = false;
-		exit_qualification &= INTR_INFO_UNBLOCK_NMI;
+
+		/*
+		 * PML Full and EPT Violation VM-Exits both use bit 12 to report
+		 * "NMI unblocking due to IRET", i.e. the bit can be propagated
+		 * as-is from the original EXIT_QUALIFICATION.
+		 */
+		exit_qualification = vmx_get_exit_qual(vcpu) & INTR_INFO_UNBLOCK_NMI;
 	} else {
 		if (fault->error_code & PFERR_RSVD_MASK) {
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
+			exit_qualification = fault->exit_qualification;
+			exit_qualification |= vmx_get_exit_qual(vcpu) &
+					      (EPT_VIOLATION_GVA_IS_VALID |
+					       EPT_VIOLATION_GVA_TRANSLATED);
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 		}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d4e6625e0a9a..a24fba6b7741 100644
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
-- 
2.43.0.687.g38aa6559b0-goog


