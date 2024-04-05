Return-Path: <linux-kernel+bounces-133716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550289A7B1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A651F22E23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7C6CDB1;
	Fri,  5 Apr 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEsuPX5+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A458AD2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361383; cv=none; b=UV3qBQ5zgHnOkDcJ77vZ+8CPLi8k4nb7Z2tB6mQD1pNNErjdNJCEurRwF3WuQZS6bHKYVFygCjVXhMKAZDZkj1Sreiht2cRpXB9sczzKROhhba9hctodeaf+eT571PK2sLNOnTH6DhsVRdKz9jT5HGvTbY+K+6eal/X8qV6/Jzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361383; c=relaxed/simple;
	bh=uTEAcElbjgc42YO5RZICLCtvkeeQwfPNpAbVw/4NQqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o2eYvyVnN373pUBidf1TwymvTROH3ozr7/7PVSNsrrA3fBbuMdv1ZXKszi8dynhTuuu/Way0HW83vcLhnelpxbTMgAGKeLEPtiXKQElqt3Cb7+RrsRgBGtjOZU7lwP/4pmabxDQu3uGPEb5SJdsvTyxJbOWxN7vVn156K8lfaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEsuPX5+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29bf071cc04so2319254a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361381; x=1712966181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c9C5YQrHXZZ5HmBmRXt2H633vB/NFcbA0Pv9V/zyx9M=;
        b=nEsuPX5+3VN30T4oSk9YLixErBMogdK6GRAeSO8mgis2VkZ/+FJQFC1OcbtBAf3txp
         NMgc8jv6/NQX0b+plw8q95JHGpr5gdKx7yv/y3bQTyp+xfDKgkSwpBiDw0q3XqXGwlk/
         QVNc4MBTC8hfhj7AN+V6K6s151xLEUTveYqi3SXVi6pZdwQwwG88liUOANFDEHVmBd4N
         OCAPNoT3W6natg255YndqwXx3jCZtOChhus54Ocanz3f9WZErfGnu+SqvJ1J8o4BhLly
         4oRVRgZG9NQ0ie6021pzGYbxju8Iaa07L5KQGmzvn6FSl9Ziiu9FpsHegQBCFdFfAu6N
         sCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361381; x=1712966181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9C5YQrHXZZ5HmBmRXt2H633vB/NFcbA0Pv9V/zyx9M=;
        b=jN5CSJsQTo5GpD+rtEhg5tWrW3l/mlIzG3u5UUL4WN13itqzmNzo9iV1FgaIUod+in
         rJ7k8u5ck8vBFaFDH2dlZQeKekSb3ZAAIZmk16JRzPpIKTKsepV2MiXNy82oHxkCiVGr
         d+n7S/+OrR43bBTgPxkwuZfaZShYKt5kNCBhpQSPa9FqRfX5zdgqkU4QzlL8m6GyMzt3
         cDBv5ZzD2ShB96dBai/i+yKPIPRLUomSEVOtW0miolcFml+0Zduo+im6ggkCjBFG9rQN
         B1E7e8U9lmJUbj8SKt2Qz5Jo27i9s9gIyqx+EG78UOBh92gn+1km8mtfiRpbdoc5qjFY
         BKtg==
X-Forwarded-Encrypted: i=1; AJvYcCXiJnXel7iHHC+z5HQmADtjMpwdQTqmwAkEck8pH/luD9CAS3B026cRaBMvzelwWwYwY0zOc9xQviZPnyRD3q7NhyxWvyOctE0Qhdh+
X-Gm-Message-State: AOJu0YzeiECVPgbcEx39ky1pqFAqFDlEMb2K3lVmzANSBl22I2eccoHO
	XbQLJ45hKG+Bgk3ev4hnGo7JknXg0QHbwnn1Vbw8z1qhB1feBaXw1/9lX1GA3AeGfj9CjcQBaT3
	I1Q==
X-Google-Smtp-Source: AGHT+IHs9jTGhTQuC9VHaf7pS6UP8HTmTzMNz8fgepBti3jcRSzoDy5YtVrLJpQTYgtMnhp00dCWO2H9Ryg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea01:b0:1e2:b75e:37b5 with SMTP id
 s1-20020a170902ea0100b001e2b75e37b5mr47992plg.2.1712361381133; Fri, 05 Apr
 2024 16:56:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:56:00 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-8-seanjc@google.com>
Subject: [PATCH 07/10] KVM: SVM: Emulate SYSENTER RIP/RSP behavior for all
 Intel compat vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Emulate bits 63:32 of the SYSENTER_R{I,S}P MSRs for all vCPUs that are
compatible with Intel's architecture, not just strictly vCPUs that have
vendor==Intel.  The behavior of bits 63:32 is architecturally defined in
the SDM, i.e. not some uarch specific quirk of Intel CPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.h   |  8 --------
 arch/x86/kvm/svm/svm.c | 14 +++++++-------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 23dbb9eb277c..03d015e9ce33 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -112,14 +112,6 @@ static inline bool guest_cpuid_is_amd_or_hygon(struct kvm_vcpu *vcpu)
 		is_guest_vendor_hygon(best->ebx, best->ecx, best->edx));
 }
 
-static inline bool guest_cpuid_is_intel(struct kvm_vcpu *vcpu)
-{
-	struct kvm_cpuid_entry2 *best;
-
-	best = kvm_find_cpuid_entry(vcpu, 0);
-	return best && is_guest_vendor_intel(best->ebx, best->ecx, best->edx);
-}
-
 static inline bool guest_cpuid_is_amd_compatible(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.is_amd_compatible;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d1a9f9951635..e1266b023203 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1196,7 +1196,7 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (guest_cpuid_is_intel(vcpu)) {
+	if (guest_cpuid_is_intel_compatible(vcpu)) {
 		/*
 		 * We must intercept SYSENTER_EIP and SYSENTER_ESP
 		 * accesses because the processor only stores 32 bits.
@@ -2853,12 +2853,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_SYSENTER_EIP:
 		msr_info->data = (u32)svm->vmcb01.ptr->save.sysenter_eip;
-		if (guest_cpuid_is_intel(vcpu))
+		if (guest_cpuid_is_intel_compatible(vcpu))
 			msr_info->data |= (u64)svm->sysenter_eip_hi << 32;
 		break;
 	case MSR_IA32_SYSENTER_ESP:
 		msr_info->data = svm->vmcb01.ptr->save.sysenter_esp;
-		if (guest_cpuid_is_intel(vcpu))
+		if (guest_cpuid_is_intel_compatible(vcpu))
 			msr_info->data |= (u64)svm->sysenter_esp_hi << 32;
 		break;
 	case MSR_TSC_AUX:
@@ -3081,11 +3081,11 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 * 32 bit part of these msrs to support Intel's
 		 * implementation of SYSENTER/SYSEXIT.
 		 */
-		svm->sysenter_eip_hi = guest_cpuid_is_intel(vcpu) ? (data >> 32) : 0;
+		svm->sysenter_eip_hi = guest_cpuid_is_intel_compatible(vcpu) ? (data >> 32) : 0;
 		break;
 	case MSR_IA32_SYSENTER_ESP:
 		svm->vmcb01.ptr->save.sysenter_esp = (u32)data;
-		svm->sysenter_esp_hi = guest_cpuid_is_intel(vcpu) ? (data >> 32) : 0;
+		svm->sysenter_esp_hi = guest_cpuid_is_intel_compatible(vcpu) ? (data >> 32) : 0;
 		break;
 	case MSR_TSC_AUX:
 		/*
@@ -4328,11 +4328,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_LBRV);
 
 	/*
-	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
+	 * Intercept VMLOAD if the vCPU model is Intel in order to emulate that
 	 * VMLOAD drops bits 63:32 of SYSENTER (ignoring the fact that exposing
 	 * SVM on Intel is bonkers and extremely unlikely to work).
 	 */
-	if (!guest_cpuid_is_intel(vcpu))
+	if (!guest_cpuid_is_intel_compatible(vcpu))
 		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PAUSEFILTER);
-- 
2.44.0.478.gd926399ef9-goog


