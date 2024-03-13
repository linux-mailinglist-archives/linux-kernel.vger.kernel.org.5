Return-Path: <linux-kernel+bounces-100968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667F87A032
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B106F282605
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59C9BA2B;
	Wed, 13 Mar 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOJI5zZ1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A5AD21
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710290264; cv=none; b=uwoY7nn7e+BOLEsc7fGqvEsD+vKTm96KBU7Afz8+x9GkZmeo3hDGRAU7eM8y1Ye6gzqpTCUV363O6DVuVp+3wBoHAtDL0MhCBcI4Q8CdqEYwupm4Xz+gYzzfHUJD6tTl4tToesjd5xfUrhg5VX9IV93Ah+82Fxeqtn8OXaILRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710290264; c=relaxed/simple;
	bh=BzYTgFDjDlAZ8gd0aJem3WcOLgliR9hFAU3WbEOdgKE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KrL1Jkclst4FEL7Ssk9l69bdvIC6RQAB80h5CrC2OQHLL/VY+c4XPY1f/SvxvEDUwf+5I9NsU5QxjkzpWjqLulBwoQUFE8BhO5mfy6xajKtYadiETvm1Q0sULMWyzYikPPRHCJJzGPP3AILGvv/FlxTtsuLRJEx95vwQ/3kx+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOJI5zZ1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29905ac5c21so3550207a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710290262; x=1710895062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN6BqTkzmWFAitAntlkeoxPS8Fbt0V4TAnmgFajnS5s=;
        b=uOJI5zZ1UnY5zLPDikYpp76E4IgXuwwunWDCl7ylkt1Z2vgjbSKrNFLjFxgLrk99pb
         HX5zragIngk9+gBKh0K0S0u8n/cXl0W83ErD8f85JT3mGIq8ZmKjtTzaME8RUtZ987BM
         QHMmAMvFB80/6Nj7T6C1/ZU6OVEGv3x4w8m0OGzYHyGzxYojbbrtZo6kAwcN3uTSc6go
         Ry6Dq4zIKJDcNZ8M6tMoFIlzsGt9Jfd4GeVuH5jhYRZxjpZPYy9DgJVTSOjEUZQu8IzX
         /78+Pm553/dQtOMKmgzS94eBzuoeshD7V4FH/cbY6DV9tKtjHsIgyyDtpN+1ZjvnJ4s9
         lSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710290262; x=1710895062;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN6BqTkzmWFAitAntlkeoxPS8Fbt0V4TAnmgFajnS5s=;
        b=lERy0Q6hWrQahiTbBFqX04X9GwcaOtrFbH9Cwy6OVHRqwXvUenglFj+C65qsACOdbn
         DN13pTLb6pJ2aPUBtpBCwe+azpwKBvvhPRDpa5DoYltP7Qg0QO422xnXsI1If2vvbjRu
         mDkJGLNnrHo5ZR5LeMbGU+2it3xrhGZ56GUH0LtUwDA/aozl2fZ98xDmVrdVHtvw0+A/
         sGyBd5jtkzHGZvJz9sJKJKrVt6BZw9FHgG+yWaN9VB1gc1AegPv1WGZXLxR2VifbTqve
         lgSn3f3fozLBK+MrST3jmI03fzh8Qim1Pt1C3mdB+NYKjsyCsyOHD5rOdjxpn4gRE34Y
         arYw==
X-Forwarded-Encrypted: i=1; AJvYcCX9OKJoW9mE0PdOO1c3/S8abX3FpPFLVWHUe9xt84A8+rbZaKBi1GJEHD4T4fCreojyYyOaUKeeu0dChNkZaxzkGjy3a8sMBhael2Kl
X-Gm-Message-State: AOJu0YydtmAG1pJF7992cJviEd2r5dhWk4mLGi1pYwUH8b30wpLUtdJp
	wgPsyujFn0GqhMURHHb5LOX4LZ+HyhUK5I/ofQ87GOm03i+r1xGNccxAv1quZYSUgj6+9KdgrSM
	a7TDezg==
X-Google-Smtp-Source: AGHT+IFOcXyyJqNiS9fge7qoPOEN0ZRSGxQ46UefUM0RsUmQTeHfbkDtG1MSKEDKixQDPn2+HgYCIu51+HhF
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:1a8e:b0:29c:1421:c567 with SMTP id
 ng14-20020a17090b1a8e00b0029c1421c567mr32478pjb.8.1710290261701; Tue, 12 Mar
 2024 17:37:41 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Wed, 13 Mar 2024 00:37:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240313003739.3365845-1-mizhang@google.com>
Subject: [PATCH] KVM: x86/pmu: Return correct value of IA32_PERF_CAPABILITIES
 for userspace after vCPU has run
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aaron Lewis <aaronlewis@google.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

Return correct value of IA32_PERF_CAPABILITIES when userspace tries to read
it after vCPU has already run. Previously, KVM will always return the guest
cached value on get_msr() even if guest CPUID lacks X86_FEATURE_PDCM. The
guest cached value on default is kvm_caps.supported_perf_cap. However, when
userspace sets the value during live migration, the call fails because of
the check on X86_FEATURE_PDCM.

Initially, it sounds like a pure userspace issue. It is not. After vCPU has
run, KVM should faithfully return correct value to satisify legitimate
requests from userspace such as VM suspend/resume and live migrartion. In
this case, KVM should return 0 when guest cpuid lacks X86_FEATURE_PDCM. So
fix the problem by adding an additional check in vmx_set_msr().

Note that IA32_PERF_CAPABILITIES is emulated on AMD side, which is fine
because it set_msr() is guarded by kvm_caps.supported_perf_cap which is
always 0.

Cc: Aaron Lewis <aaronlewis@google.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 40e3780d73ae..6d8667b56091 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2049,6 +2049,17 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = to_vmx(vcpu)->msr_ia32_sgxlepubkeyhash
 			[msr_info->index - MSR_IA32_SGXLEPUBKEYHASH0];
 		break;
+	case MSR_IA32_PERF_CAPABILITIES:
+		/*
+		 * Host VMM should not get potentially invalid MSR value if vCPU
+		 * has already run but guest cpuid lacks the support for the
+		 * MSR.
+		 */
+		if (msr_info->host_initiated &&
+		    kvm_vcpu_has_run(vcpu) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
+			return 1;
+		break;
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!guest_can_use(vcpu, X86_FEATURE_VMX))
 			return 1;

base-commit: fd89499a5151d197ba30f7b801f6d8f4646cf446
-- 
2.44.0.291.gc1ea87d7ee-goog


