Return-Path: <linux-kernel+bounces-60088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D384FFB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3381C21CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6DF3B29A;
	Fri,  9 Feb 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVTnGWNa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43553984A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517027; cv=none; b=EzQERn/Gmlui2ZUJRp/lE8SaOiyVi3WQ4Vurw0xOdba0amwQlzFGGYgbFAr2VsuClJd/zjX2+KpD/w7CrAbEFmllq6rSpK3eXrwMP6uYNzuio4FV4wn/sRUTfxp1fcR0XvJt1wxPWfnJ/S/V0zBqVfk+xEkU2YfbvS21PoqXmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517027; c=relaxed/simple;
	bh=vCfMinZ3ioVa697wfHhRMUGC7BJ9VIJaAEWf+LUoN7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t496lmJYm2fvbPyZ4Z4eizIdMm64dLp9tJzzrfgsm2LRfE1spmtq62ZTekHm5tjtSn5cXKDjxVVyR3YwJT9OLMeilMTc5r3pUgS2S4G/OmdmDLdcSaM6kypKYEOjVvYVEAepdLSizCgzBXtHNRXDBDK2Ej1t9M7Qh6h5fpUKkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVTnGWNa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60482420605so21795947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517025; x=1708121825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EtUmW5C5jIEQG3Xq+wKcQPGgTDr9KsPcRaFSmsaaMus=;
        b=UVTnGWNapPTQj7nVfFqDl2/bgfSHmwVxHNZhcFzxA7vYkFq6lwX/jZfACJPcurBRyg
         G38buWkRMSGsiWw6iPjl00sFZCNjYdBw19qdBJirxaBRWiGkMrDdfdxYFOLq57XcR3IF
         8ChRKcGDg/p9t6pK63ROYdf3j4ONq3rMZmtkvy34ZBib+CApXxppob4U2rJyNYbb5aGj
         eiaryjW9OKAynLTd4KE4FN9i2al6maxDaASNJVhK+mKEj1fqoc9HD5gxrb4+C1u4Vyoi
         ORgjK3PoDp870ie4tpIeSUEscuo4ThiwZe9AEH0Ls03wGUbnEzO+8PrgbuRJrmWbfFuC
         UrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517025; x=1708121825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtUmW5C5jIEQG3Xq+wKcQPGgTDr9KsPcRaFSmsaaMus=;
        b=kWNo4oidEdnCIGOpz2iIHwUv2yEMZAGQ5ykpoIiTv2Avg1r1Ss9LGjDFGtE1paUinq
         YY4Ekv1dZRkTlCBqXqlKb6p05nazzsIYKGLc57WnWt32GCHZIM492/RDs4h8mSq5pSnM
         emZNNkKNrsP3bNi+aXrsnp3OcYO34CYCm91eR9rHtE68PI+6Hv+9V3aoAlrmJRcML7kG
         ZHI9cvBp2IXvx10U+5/FUABmNZ0Y1R9ARiFaGNiT6PblxmPyHCBVyGeRXYOmM+AAKib3
         eM+0G+1kaKaQmYfs0snRlJ24YPgI+KxzcH2E+Ch168ZXsSWXaWXDK7AAFKgLIl/tBrXn
         fj2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnbFETyqZzXOrGNy/IHQhGadyofEJNSFWvHAMfv3LaH2hsL5SqgX3XVN0bvyffM3ohCYMwhQba56DtagOG14jtVIUXN50N9tFzuO4C
X-Gm-Message-State: AOJu0YyB1aWOnFXbPHYjOFZ/xzg19DJRDQ2pgJaLaksbsOKE2iHvUZJs
	M7UlP3uNzTpx30CDl2y0p7wFqcISWFADdz8B3HrcUpj1Ig0DkcfoliGMT4G/6PHYpQ28W1aMZOw
	3RQ==
X-Google-Smtp-Source: AGHT+IHoLzDO4enoLF12MipFfYOPxOqptTuIhXlXrM241lI+t+J+ZGQWc0jkfgWHk3zIV3gHAlO69Fo9B00=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e6cb:0:b0:604:4073:66ca with SMTP id
 p194-20020a0de6cb000000b00604407366camr98778ywe.3.1707517024940; Fri, 09 Feb
 2024 14:17:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:16:58 -0800
In-Reply-To: <20240209221700.393189-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209221700.393189-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209221700.393189-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: nVMX: Clear EXIT_QUALIFICATION when injecting an EPT Misconfig
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Explicitly clear the EXIT_QUALIFCATION field when injecting an EPT
misconfig into L1, as required by the VMX architecture.  Per the SDM:

  This field is saved for VM exits due to the following causes:
  debug exceptions; page-fault exceptions; start-up IPIs (SIPIs);
  system-management interrupts (SMIs) that arrive immediately after the
  execution of I/O instructions; task switches; INVEPT; INVLPG; INVPCID;
  INVVPID; LGDT; LIDT; LLDT; LTR; SGDT; SIDT; SLDT; STR; VMCLEAR; VMPTRLD;
  VMPTRST; VMREAD; VMWRITE; VMXON; WBINVD; WBNOINVD; XRSTORS; XSAVES;
  control-register accesses; MOV DR; I/O instructions; MWAIT; accesses to
  the APIC-access page; EPT violations; EOI virtualization; APIC-write
  emulation; page-modification log full; SPP-related events; and
  instruction timeout. For all other VM exits, this field is cleared.

Generating EXIT_QUALIFICATION from vcpu->arch.exit_qualification is wrong
for all (two) paths that lead to nested_ept_inject_page_fault().  For EPT
violations (the common case), vcpu->arch.exit_qualification will have been
set by handle_ept_violation() to vmcs02.EXIT_QUALIFICATION, i.e. contains
the information of a EPT violation and thus is likely non-zero.

For an EPT misconfig, which can reach FNAME(walk_addr_generic) and thus
inject a nEPT misconfig if KVM created an MMIO SPTE that became stale,
vcpu->arch.exit_qualification will hold the information from the last EPT
violation VM-Exit, as vcpu->arch.exit_qualification is _only_ written by
handle_ept_violation().

Fixes: 4704d0befb07 ("KVM: nVMX: Exiting from L2 to L1")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 994e014f8a50..1eebed84bb65 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -417,10 +417,12 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 		vmx->nested.pml_full = false;
 		exit_qualification &= INTR_INFO_UNBLOCK_NMI;
 	} else {
-		if (fault->error_code & PFERR_RSVD_MASK)
+		if (fault->error_code & PFERR_RSVD_MASK) {
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
-		else
+			exit_qualification = 0;
+		} else {
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
+		}
 
 		/*
 		 * Although the caller (kvm_inject_emulated_page_fault) would
-- 
2.43.0.687.g38aa6559b0-goog


