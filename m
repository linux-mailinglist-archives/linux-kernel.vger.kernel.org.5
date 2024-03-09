Return-Path: <linux-kernel+bounces-97735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688B876E95
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72179286F01
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACF33D3A7;
	Sat,  9 Mar 2024 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK90p5J5"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1AC3A8CC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709947669; cv=none; b=Eri9WTnWaI3EThKLZVsjZZWlw8g9aqx8ekjOLlfcd159L5CHv1EGGxl/Q5JwnVS6c1JJIt3Mp37JCfIZtXcO0HM+8iBSsGVpcuNCLKxpW9CqOr8Ei+RZIZXjzzdGbVBI3/Y0eL9F2r8aLhW8VLqHa0EM34qtkNeC/6MVInAN8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709947669; c=relaxed/simple;
	bh=3RB5ybb2eWpxvWqhePHFkoyZ4DVvi7cGA85H74hezaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FFkPdX2pQexz8Es71dgaFtBeQQX7qXwxooFbncQnF94iNkUXG7BdWZJxZz+YQo+afVv9jCPcis+ywVf9S0jyq4O5yDtfM21Y7FwxI4lJ2LJKMfTeI0H2ywFEW1LI6O2HZWyLSgYoSaCGL6NS2dkghsj3xLfi7+3z4yz1KbkgFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YK90p5J5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e62136860eso1259939b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 17:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709947668; x=1710552468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PaASkSwAWfMjl4NBiq05b1lXThMlN3vSRBX1XjjeH98=;
        b=YK90p5J5vNtDrnM0FcqgUm4DVGGNSX2ISZ9v8TsPAGelJTpKv6H7wWyWT9haJFvRMN
         SJ20rVLUPaWXboYVMXl9nvKXCPWXiyI6yKWcS+Rdm/d9sm9RD8XGLraae+4tMRPfaoWv
         1mkz0S8imx37mTaSjlo45m2JScfQ9DowpwF+J182eLATqzUa8aG/s8dLHrrgPRTdN8xy
         fKahl9V9jXo/x2rzh4qwSHDwQuLDWP7adiSLpo2rRiJZB+ccDxAZ2VPWO5ax9FuQXvF7
         9UNa7PIVE0goTmyB0me0rEvNQBNeV2uAkIr7CgiD+U6kmdEGiZqUKmy6voqT3W7OC/Wt
         3aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709947668; x=1710552468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaASkSwAWfMjl4NBiq05b1lXThMlN3vSRBX1XjjeH98=;
        b=RcPPM/yscWJHjYqH7WGpSVvF6gN/GL3ex7Y1hpcO06wxPKYDQonOgnWNrNUUPe4GoL
         2+u7yZY5gjvxrto57dc3w8fybGfuoXA3JNCzvqnUE4bAhMTuKQcG0CpZij6lQjLs3K09
         /K4lkfOZnQhTFAQ936fnBz6ytykgXFWiWU/fDCx/HtbENuhwqqmtv2wS8xexKkd4Fjwt
         jZ9gBvFWXWETEvZlPyZd3JXDoYqJNlxthMZiQM7usiyZ5lY4+MiS+0UcLIweAt/Y71G3
         6FUR9GX0n55lA/pvYFdJzesEovhJEx9jO2rXW3mKxHAkEndSv3QN7P74r2jqAidyy+lf
         vnNg==
X-Gm-Message-State: AOJu0Ywj4iWp/TCIRtH2UpdhT2+pnw+jJ2S6hCeOAJKga3+pMtYDiOTv
	AIr/J5xAS2asCzq3Fjg6N329xSR6mt8kMTviBnn1AN9dAU8DNce8vxX9xu+r1YX6U5J/tXMRksU
	llA==
X-Google-Smtp-Source: AGHT+IECrHtNs6BgHJfPn5W88AEGOjcbjO3YQOnM3DErPQrq0yT7XiAUw/mEaCIWPLmtk4712WYOVZyywRg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1389:b0:6e6:691f:42f5 with SMTP id
 t9-20020a056a00138900b006e6691f42f5mr47078pfg.0.1709947667900; Fri, 08 Mar
 2024 17:27:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:27:25 -0800
In-Reply-To: <20240309012725.1409949-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309012725.1409949-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309012725.1409949-10-seanjc@google.com>
Subject: [PATCH v6 9/9] KVM: nVMX: Use macros and #defines in vmx_restore_vmx_misc()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Shan Kang <shan.kang@intel.com>, Kai Huang <kai.huang@intel.com>, Xin Li <xin3.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin3.li@intel.com>

Use macros in vmx_restore_vmx_misc() instead of open coding everything
using BIT_ULL() and GENMASK_ULL().  Opportunistically split feature bits
and reserved bits into separate variables, and add a comment explaining
the subset logic (it's not immediately obvious that the set of feature
bits is NOT the set of _supported_ feature bits).

Cc: Shan Kang <shan.kang@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
[sean: split to separate patch, write changelog, drop #defines]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 06512ee7a5c4..6610d258c680 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1322,16 +1322,29 @@ vmx_restore_control_msr(struct vcpu_vmx *vmx, u32 msr_index, u64 data)
 
 static int vmx_restore_vmx_misc(struct vcpu_vmx *vmx, u64 data)
 {
-	const u64 feature_and_reserved_bits =
-		/* feature */
-		BIT_ULL(5) | GENMASK_ULL(8, 6) | BIT_ULL(14) | BIT_ULL(15) |
-		BIT_ULL(28) | BIT_ULL(29) | BIT_ULL(30) |
-		/* reserved */
-		GENMASK_ULL(13, 9) | BIT_ULL(31);
+	const u64 feature_bits = VMX_MISC_SAVE_EFER_LMA |
+				 VMX_MISC_ACTIVITY_HLT |
+				 VMX_MISC_ACTIVITY_SHUTDOWN |
+				 VMX_MISC_ACTIVITY_WAIT_SIPI |
+				 VMX_MISC_INTEL_PT |
+				 VMX_MISC_RDMSR_IN_SMM |
+				 VMX_MISC_VMWRITE_SHADOW_RO_FIELDS |
+				 VMX_MISC_VMXOFF_BLOCK_SMI |
+				 VMX_MISC_ZERO_LEN_INS;
+
+	const u64 reserved_bits = BIT_ULL(31) | GENMASK_ULL(13, 9);
+
 	u64 vmx_misc = vmx_control_msr(vmcs_config.nested.misc_low,
 				       vmcs_config.nested.misc_high);
 
-	if (!is_bitwise_subset(vmx_misc, data, feature_and_reserved_bits))
+	BUILD_BUG_ON(feature_bits & reserved_bits);
+
+	/*
+	 * The incoming value must not set feature bits or reserved bits that
+	 * aren't allowed/supported by KVM.  Fields, i.e. multi-bit values, are
+	 * explicitly checked below.
+	 */
+	if (!is_bitwise_subset(vmx_misc, data, feature_bits | reserved_bits))
 		return -EINVAL;
 
 	if ((vmx->nested.msrs.pinbased_ctls_high &
-- 
2.44.0.278.ge034bb2e1d-goog


