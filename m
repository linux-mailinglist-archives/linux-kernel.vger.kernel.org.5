Return-Path: <linux-kernel+bounces-141324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865E8A1CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64261F25BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DC3E47B;
	Thu, 11 Apr 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZ4Xfkqb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555423E470
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853098; cv=none; b=shRSje3rJr9WwTejrfA9o84JI0J43dosesIyrMpfc4mKvWKPy3SyepRYQTniaXeY451vkO1SI/CMiMnu04tHw3KG53g+5zyyWPnavsMWj2UTroqPggIVUFo0n8XsFH13ej5ixZblZG9w9pNJoFM2ZMKhnKO09zup8tNJ8bbaSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853098; c=relaxed/simple;
	bh=4j9laXHAzm+DplQ6oWDejgL8l/oTxGEhgcgHFx7limM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mt0aTDUDT2XdjFuQ9s7MZv+BMea93wgXYRbNsYzOSClENKGbuEMm30N4lyqAAhOdc5FlChWW+/5G2wqO/nvzrEqOvjBItPv1fZfPyp7XlqZsKLQOh3uYc3vDaTHDCZTdWvympfPbgVRnmqJ7y3EIKwiKJ4V0d1qBc16K1oDzAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZ4Xfkqb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6a1625e4bso62789b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712853096; x=1713457896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOT4OXJzQmFlPNQvb/vL42zv6TrN8MRbfAFxsZzUsH0=;
        b=YZ4Xfkqbp+FGcfAH0DRZboXNvi8Ew1ngnRph+uInvqwfiYMjH8meZ3aHRCdtCvoFA/
         ihQ95ZUv884k/MQlEo29huyWKkehXDN/QgNc0ZQabID1T3lfPYbfYdxNLn3WoKa1P8kf
         +OadF3rKc3i+db5ioxcOIShIpL5WzxbQ5xkvpj9VkMHobQ5NUjvnLe4RvS6agOaGM1WF
         CxDIwS6xCLkqp5nUQxFGrW4HlWIbZLaIGqIROJTIVevVmLMbOznVWE0pxYC5iauUBQwA
         ERVgau4Xda4eCDuQ0zDBO8lbxSAXEJlHkYV05KN7LsWhwe9zacBMjm8mm4Df+GyUqKQw
         vKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853096; x=1713457896;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOT4OXJzQmFlPNQvb/vL42zv6TrN8MRbfAFxsZzUsH0=;
        b=VbIaRzzfZUtIQuqrb/d4ejoxpRHrjkId4oLhmdfby8V6FkouYaCk1shcwNtFHVV9rM
         lOiaePF67BXKCwmFyVYPvfKgS5q37qJrUM8YHBrY6dgXNQDUdrF4porxoRsGo8TcRIlY
         C4Eyu4Bf/VnVcz2wEzfhssO1KK8ZR2Jf5wpdbokGD4sWNCZPc9c4RHkMH0F7O0zDWpo1
         YhMGbc/vvHQjiqTtKOnmL0NFTbgWuXU9zwI4q6BszuBtWOAKl8XBiijgKoqlc0Lx0nuE
         C6bQCtz3gTwVtjrXtWE+P2Ar25N6fMX2ULK8H/8bNplrAJuy64T4SJqQjY2EgcejRck6
         IS+Q==
X-Gm-Message-State: AOJu0Yx4rqAy5cmTcdjkuNoMwRnZdF/xFZzE2sdjaGWpdqeftAHJx+eV
	cb4dZKswWeBKIXUU2EP+ZQ1YCCJB56VPRyCYw+g1lMmGTSIULQmJZhVrqPHtTK2jMGe8DhniEdn
	rVA==
X-Google-Smtp-Source: AGHT+IGdjls82m2XHZdA1FRueklQHT9m/tP1w/S9yYVAUBWeUwpPLhZmP4/N6M5uOVVUdUX9HhQHnPXsWOo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ed:344:9faa with SMTP id
 fj15-20020a056a003a0f00b006ed03449faamr524pfb.1.1712853096532; Thu, 11 Apr
 2024 09:31:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Apr 2024 09:31:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411163130.1809713-1-seanjc@google.com>
Subject: [RFC PATCH] KVM: x86: Advertise PCID based on hardware support (with
 an asterisk)
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

Force set a synthetic feature, GUEST_PCID, if PCID can be safely used in
virtual machines, even if the kernel itself disables PCID support, and
advertise PCID support in KVM if GUEST_PCID is set.

When running on a CPU that is affected by Intel's "Global INVLPG" erratum,
which does NOT affect VMX non-root mode, it is safe to virtualize PCID for
KVM guests, even though it is not safe for the kernel itself to enable PCID.
Ditto for if the kernel disables PCID because CR4.PGE isn't supported.

Use a synthetic bit instead of having KVM check raw CPUID so that KVM
honors disabling PCID via the "nopcid" kernel parameter, and to guard
against PCID being disabled due to a erratum that DOES affect guests.

Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Tagged RFC because I'm 50/50 on whether or not this is worth doing.  On one
hand, it's a relatively small patch.  On the other hand, we can simply wait for
the ucode fix to roll out (the !PGE case doesn't seem like sufficient motivation
to carry this code).

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kvm/cpuid.c               | 7 +++++++
 arch/x86/mm/init.c                 | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a38f8f9ba657..97006581278c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -227,6 +227,7 @@
 #define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* Intel FlexPriority */
 #define X86_FEATURE_EPT			( 8*32+ 2) /* Intel Extended Page Table */
 #define X86_FEATURE_VPID		( 8*32+ 3) /* Intel Virtual Processor ID */
+#define X86_FEATURE_GUEST_PCID          ( 8*32+ 4) /* "" PCID is safe to expose to KVM guests */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2f1dd059ea79..4ae4b7291b5a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -628,6 +628,13 @@ void kvm_set_cpu_caps(void)
 	/* KVM emulates x2apic in software irrespective of host support. */
 	kvm_cpu_cap_set(X86_FEATURE_X2APIC);
 
+	/*
+	 * On some CPUs, PCID can be used in virtual machines, even if it's
+	 * disabled in the host kernel.
+	 */
+	if (boot_cpu_has(X86_FEATURE_GUEST_PCID))
+		kvm_cpu_cap_set(X86_FEATURE_PCID);
+
 	kvm_cpu_cap_mask(CPUID_1_EDX,
 		F(FPU) | F(VME) | F(DE) | F(PSE) |
 		F(TSC) | F(MSR) | F(PAE) | F(MCE) |
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..9b85beee06dc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -287,6 +287,14 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
+	/*
+	 * PCID is supported in hardware and can be safely exposed to virtual
+	 * machines, even if the kernel doesn't utilize PCID itself, e.g. due
+	 * to lack of PGE support, or because of Intel's errata (which doesn't
+	 * impact VMX non-root mode, a.k.a. guest mode).
+	 */
+	setup_force_cpu_cap(X86_FEATURE_GUEST_PCID);
+
 	if (x86_match_cpu(invlpg_miss_ids)) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);

base-commit: f10f3621ad80f008c218dbbc13a05c893766a7d2
-- 
2.44.0.683.g7961c838ac-goog


