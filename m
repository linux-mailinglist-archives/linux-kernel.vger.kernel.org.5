Return-Path: <linux-kernel+bounces-133714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D07989A7AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E4283D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284655C36;
	Fri,  5 Apr 2024 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI6QV7zx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FC4F201
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361379; cv=none; b=SO60B5I4akR3L7OhmDjyQKfEO6wDZwR2cS7wJn67St/bWf/iA792hKxkJKoE6c85lsE90ZHWps33PQ3pAufHFZBujOVOrRg0S2mDgEw/PGRxTVGPiHx1C9H6CJMqvT83UHy8/UYe/5itcrxXhYO3s8y3T+gkvD8511OVEUAAJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361379; c=relaxed/simple;
	bh=AljPKUJ52FByOX5/k02Ea5UG3D0X4h61RvjHmr0q7D4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3ueTU2991TDZAhyZv52/Nq9Sbhd88d5epMD7g3yXj5WL29hAOjwO9XpMBbDULedbr6EpR10jL5gOVVqi8GgsYRpe5oxfvkmSCBfWNwKRqlQF0yF2GTJedKw6BlhYSNbrsxK06dCF1QaeXQ1nuyQymdcjf9LzBFCJCslCk8sjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI6QV7zx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a2fe3c35a1so1349098a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361377; x=1712966177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S44Se3gmnxsaX6emvGqSIzjFMncY1DPTABLM/XCmeAQ=;
        b=UI6QV7zxLU3TN6Zq2Zx1ain9zYLouuatuJmohYX4Bgu8bdkE3Nhw8AQ647N2pI2Yfs
         2KR5hUk+6vQ0Co2MAbQrHteIvQYcuYHr/D0R2zR2K+WE/fU/NYQf0D9dPzk5Wtb23ovv
         ox2StBaelZQCOXWG1UR4LqJ2dP3p/v5bUF3epVV8XQ7prQcueXBLu9aNoq3rAQyAGJbW
         bDnJ089S5fkT7g02XLLJthPqiMCJ+wWL42XHViAn7YDWXKYLG9Wy0RnhYUNIrv8XbPFJ
         oU5WyMEoH4A0PAU0+UBrpbdMU03MS5K25zO0p/UIs7BIazAJqBvrRHWWNFk8qyGlgczT
         hdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361377; x=1712966177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S44Se3gmnxsaX6emvGqSIzjFMncY1DPTABLM/XCmeAQ=;
        b=alWja3PFDzwvdyMj7NguqE57ihGTKxY++2ASQKLCiCa/B4Qc/x4aEcEx0yUKOp4gxk
         Q7UUBIZsuBEZHoO3fkyes4SKF2Oplv05fUGBwwWO15/rstNYMRAUuqNnLJFJAKzLYtPQ
         L4zKN855QaiLAyXcoqnQ6JrmKVPWhwIF62sSkXBgdcpDOR54tXoHptJAkofCUNVJzPUv
         wC7QPj2q88mpbEC2FPYiWzenkk2yJvvVrBjNtYZdZm/MT+6/V2PK40COXb2bqlbWrbDX
         yHkpXcw2NJ4RGiWXNJKTC0Uku1wMwOzcxXxP/u/5/5KSaFG65EydQ3sBqKYhajwcmVTx
         eiNg==
X-Forwarded-Encrypted: i=1; AJvYcCUkknEPEnsADwnLNadFjIj41dmAI5cXSWMdKAIvygZP0WL8D+ZNFb6CXuVeLDuPA0MIjEKSwH++BPJhcvpxainXwJwjllzKkK9L4TJv
X-Gm-Message-State: AOJu0YzHW048y/zO+AOtKPRwVvtmeDSaM8u6RYT2FsEF1tN2ZxKTD393
	KJitGy43dapuwtHoyK9pcSyYElnPuhz/DVufp/l9bbpN8MxIZ+zgHcAK5FW8PN276NCrgOR6fpN
	glw==
X-Google-Smtp-Source: AGHT+IFSoeSfmhaaetrSt3kO581BOnUyFdA9ebGWFCQtIhz7u3HLEM4R1TrX5WUOnjWB2WCASTfw9K7dxFg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:214:b0:2a0:40df:2f57 with SMTP id
 fy20-20020a17090b021400b002a040df2f57mr8680pjb.6.1712361376966; Fri, 05 Apr
 2024 16:56:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:55:58 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-6-seanjc@google.com>
Subject: [PATCH 05/10] KVM: x86: Inhibit code #DBs in MOV-SS shadow for all
 Intel compat vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Treat code #DBs as inhibited in MOV/POP-SS shadows for vCPU models that
are Intel compatible, not just strictly vCPUs with vendor==Intel.  The
behavior is explicitly called out in the SDM, and thus architectural, i.e.
applies to all CPUs that implement Intel's architecture, and isn't a quirk
that is unique to CPUs manufactured by Intel:

  However, if an instruction breakpoint is placed on an instruction located
  immediately after a POP SS/MOV SS instruction, the breakpoint will be
  suppressed as if EFLAGS.RF were 1.

Applying the behavior strictly to Intel wasn't intentional, KVM simply
didn't have a concept of "Intel compatible" as of commit baf67ca8e545
("KVM: x86: Suppress code #DBs on Intel if MOV/POP SS blocking is active").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9719141502a..8ea6f4fc910f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8984,19 +8984,17 @@ EXPORT_SYMBOL_GPL(kvm_skip_emulated_instruction);
 
 static bool kvm_is_code_breakpoint_inhibited(struct kvm_vcpu *vcpu)
 {
-	u32 shadow;
-
 	if (kvm_get_rflags(vcpu) & X86_EFLAGS_RF)
 		return true;
 
 	/*
-	 * Intel CPUs inhibit code #DBs when MOV/POP SS blocking is active,
-	 * but AMD CPUs do not.  MOV/POP SS blocking is rare, check that first
-	 * to avoid the relatively expensive CPUID lookup.
+	 * Intel compatible CPUs inhibit code #DBs when MOV/POP SS blocking is
+	 * active, but AMD compatible CPUs do not.
 	 */
-	shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
-	return (shadow & KVM_X86_SHADOW_INT_MOV_SS) &&
-	       guest_cpuid_is_intel(vcpu);
+	if (!guest_cpuid_is_intel_compatible(vcpu))
+		return false;
+
+	return static_call(kvm_x86_get_interrupt_shadow)(vcpu) & KVM_X86_SHADOW_INT_MOV_SS;
 }
 
 static bool kvm_vcpu_check_code_breakpoint(struct kvm_vcpu *vcpu,
-- 
2.44.0.478.gd926399ef9-goog


