Return-Path: <linux-kernel+bounces-97738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D6876E9E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A3D281265
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261102557F;
	Sat,  9 Mar 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSayU958"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DA17554
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709948208; cv=none; b=H1oi9hdd17f4HucTXgsMdEDZfPOREfLD0Fe5opUsTmAFuF0VBUjuEjvocpyclGveqEsMNn29nyvNZm+K6Bl1f+UvCPrAC6maYAToMdtp9oQOMrf6PCUI5iGtN3o/DUuUzqqsvAI9yXlz2cFJT29CPJWJ8TlO3umDzBw8Xfgq3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709948208; c=relaxed/simple;
	bh=VJikoSrQo43avUuqAwx40juOg+W7uxK2JNJYf8WFBZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OtoGlMAl7ME+QyHEuNGXX2C+gy/dC3bZVGPi+A2qzOMyWuKW+VGAX2qp78bhbVHfjeecLdJsBt7TG0FYt67I31N500lVkQURJL9ttUDUVlijWPl2ir36Hj6zfEvN2GoYEaEgQRIqpNoHWcJskZJEw8+3DPf+Wmu8bGNjMaz5AmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSayU958; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so4408994276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 17:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709948205; x=1710553005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=y0BhAxRzKsAvo5OwS6Sm/EpbJRorm6UaRPV9uoZ1QIo=;
        b=KSayU958IypRqhH6kxzGdePO9rJCxvJvHnnbJwOF3DXada6AHEmKUR7DUusDA9o+sM
         Vl/XG26p9FuhfOTRUu2lxWDdSBtxN9sknEqghv66KejDsDUO3gu2pTCJhTBz9+k7agZj
         T3RbtUq+GIFywlsOn2ttMMAx6GdNM/kBdtEwgDWLP2qM8/RPc5lVPm525aLSG9CRbPw+
         7iQoIOB9iykvSg+Wz5Ie7gomuvSB+SxSnZiDF7wKeLPoirEHhJ5MebajYYmqU48bezrO
         3lWWi+wDK5bhJ9JOaDDZ2AN6FW2uYoI4ooY2qgxmTterp/w/RO/akHoJEGeJkvihd5Ex
         CKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709948205; x=1710553005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0BhAxRzKsAvo5OwS6Sm/EpbJRorm6UaRPV9uoZ1QIo=;
        b=bjkNEn/TER+jcZVor65MPTHcc2EV5s63lAYttA9mupSyOrnR1NXWBhMERNp9zgyGz6
         Qic3HvD4nmbK1bxfNVbWUASr0z9le+7MT7whbweX9bxPEhhXBCeNYJWS9bySkXEsDkx5
         ragXAv6UZ+Y4cfj0EJ8dRN727hNoPefh/1JeFjBGc0r05kDVqiEexV29M762FOBP9oV2
         RKLVGZXFJ4bdrTdfPzgNLNgIJp67IgEEgodrAG0hL03jXEHVc9/67P/NvCgX+CHntVCR
         7aZB/5v5fbKaK452QQfnqK066ivzMK4/KIPxFiMY/RXJzQLc9kgdlEHqxQjjCQcLKNG/
         iCkw==
X-Forwarded-Encrypted: i=1; AJvYcCXb9VQwC1wgzQ4ngNwn0NGzx2lhw9z+KNcu5GdqfOJAbjq8PJVKY0W1g8CZO7zEhz4Os0ZPBL4VOo/BSY/2glHWM+oNPHcCrKHx1csI
X-Gm-Message-State: AOJu0Yxh+jqznX2dB9b/dsB7w+NzHXExNJmVp3/m1PLbYdZCKA4OdfIe
	7XHzrxuHXJV3Tu5q2t/35/NwuscSUpttOhhrOvYjtoximtKCv/p1047cVx5Gzl14+NK1me8JGdI
	+qA==
X-Google-Smtp-Source: AGHT+IE7Q4/FbKsrxNDlfIOzAZB8pOyKI7MQmZxeak1X4epqT0OuTAuCFMQulvj7P9tT6+ZcW27G4fYd7Cs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aa83:0:b0:dc2:3441:897f with SMTP id
 t3-20020a25aa83000000b00dc23441897fmr188875ybi.6.1709948205744; Fri, 08 Mar
 2024 17:36:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:36:40 -0800
In-Reply-To: <20240309013641.1413400-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309013641.1413400-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309013641.1413400-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86/pmu: Set enable bits for GP counters in
 PERF_GLOBAL_CTRL at "RESET"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Babu Moger <babu.moger@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Like Xu <like.xu.linux@gmail.com>, Mingwei Zhang <mizhang@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Set the enable bits for general purpose counters in IA32_PERF_GLOBAL_CTRL
when refreshing the PMU to emulate the MSR's architecturally defined
post-RESET behavior.  Per Intel's SDM:

  IA32_PERF_GLOBAL_CTRL:  Sets bits n-1:0 and clears the upper bits.

and

  Where "n" is the number of general-purpose counters available in the processor.

AMD also documents this behavior for PerfMonV2 CPUs in one of AMD's many
PPRs.

Do not set any PERF_GLOBAL_CTRL bits if there are no general purpose
counters, although a literal reading of the SDM would require the CPU to
set either bits 63:0 or 31:0.  The intent of the behavior is to globally
enable all GP counters; honor the intent, if not the letter of the law.

Leaving PERF_GLOBAL_CTRL '0' effectively breaks PMU usage in guests that
haven't been updated to work with PMUs that support PERF_GLOBAL_CTRL.
This bug was recently exposed when KVM added supported for AMD's
PerfMonV2, i.e. when KVM started exposing a vPMU with PERF_GLOBAL_CTRL to
guest software that only knew how to program v1 PMUs (that don't support
PERF_GLOBAL_CTRL).

Failure to emulate the post-RESET behavior results in such guests
unknowingly leaving all general purpose counters globally disabled (the
entire reason the post-RESET value sets the GP counter enable bits is to
maintain backwards compatibility).

The bug has likely gone unnoticed because PERF_GLOBAL_CTRL has been
supported on Intel CPUs for as long as KVM has existed, i.e. hardly anyone
is running guest software that isn't aware of PERF_GLOBAL_CTRL on Intel
PMUs.  And because up until v6.0, KVM _did_ emulate the behavior for Intel
CPUs, although the old behavior was likely dumb luck.

Because (a) that old code was also broken in its own way (the history of
this code is a comedy of errors), and (b) PERF_GLOBAL_CTRL was documented
as having a value of '0' post-RESET in all SDMs before March 2023.

Initial vPMU support in commit f5132b01386b ("KVM: Expose a version 2
architectural PMU to a guests") *almost* got it right (again likely by
dumb luck), but for some reason only set the bits if the guest PMU was
advertised as v1:

        if (pmu->version == 1) {
                pmu->global_ctrl = (1 << pmu->nr_arch_gp_counters) - 1;
                return;
        }

Commit f19a0c2c2e6a ("KVM: PMU emulation: GLOBAL_CTRL MSR should be
enabled on reset") then tried to remedy that goof, presumably because
guest PMUs were leaving PERF_GLOBAL_CTRL '0', i.e. weren't enabling
counters.

        pmu->global_ctrl = ((1 << pmu->nr_arch_gp_counters) - 1) |
                (((1ull << pmu->nr_arch_fixed_counters) - 1) << X86_PMC_IDX_FIXED);
        pmu->global_ctrl_mask = ~pmu->global_ctrl;

That was KVM's behavior up until commit c49467a45fe0 ("KVM: x86/pmu:
Don't overwrite the pmu->global_ctrl when refreshing") removed
*everything*.  However, it did so based on the behavior defined by the
SDM , which at the time stated that "Global Perf Counter Controls" is
'0' at Power-Up and RESET.

But then the March 2023 SDM (325462-079US), stealthily changed its
"IA-32 and Intel 64 Processor States Following Power-up, Reset, or INIT"
table to say:

  IA32_PERF_GLOBAL_CTRL: Sets bits n-1:0 and clears the upper bits.

Note, kvm_pmu_refresh() can be invoked multiple times, i.e. it's not a
"pure" RESET flow.  But it can only be called prior to the first KVM_RUN,
i.e. the guest will only ever observe the final value.

Note #2, KVM has always cleared global_ctrl during refresh (see commit
f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")),
i.e. there is no danger of breaking existing setups by clobbering a value
set by userspace.

Reported-by: Babu Moger <babu.moger@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c397b28e3d1b..a593b03c9aed 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -775,8 +775,20 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pebs_data_cfg_mask = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
-	if (vcpu->kvm->arch.enable_pmu)
-		static_call(kvm_x86_pmu_refresh)(vcpu);
+	if (!vcpu->kvm->arch.enable_pmu)
+		return;
+
+	static_call(kvm_x86_pmu_refresh)(vcpu);
+
+	/*
+	 * At RESET, both Intel and AMD CPUs set all enable bits for general
+	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
+	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
+	 * in the global controls).  Emulate that behavior when refreshing the
+	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
+	 */
+	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
+		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
-- 
2.44.0.278.ge034bb2e1d-goog


