Return-Path: <linux-kernel+bounces-94800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A33874562
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BAA1F230BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DFA4A28;
	Thu,  7 Mar 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFmJmBEV"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532B525D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773117; cv=none; b=IIwlVhMIYLNlgoEx+JNfzabHBgsrNMZT2olXzOV1r4vZ8Mt1LPbp/uWrzZ0EABlepfh66NHhMj/rKBuGQFEV0JGpXq10VcdaPom/PM8VV/4huCHgGWPL0TKc0ypwzED35jzcqpiUweYe81F9TNxnWrpiwHCg0GheLh7lC5DoqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773117; c=relaxed/simple;
	bh=MZ06/FnKdpF7EpHBWXvXS06dDQwjud1EBOqxLUdR4v8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iLBZ9QsCbZkmibkxQNPW7MVjrwERANF/9YRDTs/YTBCtM8kgN9tm/mcNN/ikCez4Zd2LtFNXcCYprFVpom3Fj97c0f0wuo747OMK1DkBl7mESaRc0O83XBxc2uRpBKArk3fb31HXpEGRw91d2z2PEz70pPs1L1klSnKaNDhvyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFmJmBEV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e5d234fb2bso348034b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709773116; x=1710377916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmRQNGCRtnjmRvh6sRQ5xEu1hAgcZnkmkF6J3pyfr1U=;
        b=GFmJmBEV3ZEPtkpYrHWVhNG6TXewl8jULZut3OJ97/r/8tgTRWxkbp71gqecYsla92
         oAWPa7gnU5+z1/V39f8fXyFpbzZ0QFDAP77B1cbMTbh4FbDGV9Sdl0YT+XRItz9qNwud
         3OenFIbT/ylF68oFWNyZbMjN9O5URynnJ4IUD/UPPJ0mXblzjx/ox+zWUBc8lPg39GHr
         1qJ8xmZxH/6VahjFEoVXqaSdnAYCfP3DgwmCYcUrBR92OdGcE+FB4zlIwJF/kkSEoi7P
         UZNzWNdWsCEn8mUVI93wJmIs1ftliQY0m7uL49KjGGdbJCvM8jG518ncdXJFyD053FAZ
         GVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709773116; x=1710377916;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmRQNGCRtnjmRvh6sRQ5xEu1hAgcZnkmkF6J3pyfr1U=;
        b=Ix4N/HNdZvmA5c6Rg7Q17GGSVepd6VyCil2xI2hFNHr0KScw/R8Vrw9JB+r2yxxJ8+
         rK8MxgNRjHyfEl7Cm02QvJSCfTKcVX54hdj4AsLPaeZFDu6dyBG9wno0FsxGi28xWJ3B
         AUSbEmZEBJlBv2yGcYNjg68itR6pt6jQemwjCFco0GhlW1qLtTlzC62uYIb5zfFDMHBE
         66cyxgJdFiQGLbpgK9awDjLYkaIgVwcQ7uTNBeTf7BF3dp9wyOm5K0sznkSGw9UILtNj
         WT4NfSmVZ90o452W46tpizfh0B/vbMowdttHc2yj5N1ektpZg0pWJmwSfaQAu3Kuxf4H
         EzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtRYndrmOGRG9BmVbPzp4H5WDBAvpGBLXMFBwOs+fRSE0J/Yzpa+iEHOZ1pyJ+5p5KMYOUkd1nM2jPCDAsje8Qqa267qJpUi/+/0SN
X-Gm-Message-State: AOJu0Ywjn1xCLBCilPxHAnPVMjDQg9iS4AhiFPq99C4DEpO5srRkBl1t
	t91ty8IsyEH6r56zVheho1+3TTlAfgxiAad7HOX3YB5cajlP69kO14DOGcDioHTrwh1Hgl5tNcY
	Rsg==
X-Google-Smtp-Source: AGHT+IGIG+GBlQTENCyrDeP5/bdimzYYp6TGnKTwGmCTJ2ir6tHwOlEgRf5XNTZcp18EgHSc03M+AlwZBP0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1808:b0:6e5:9a0a:b66a with SMTP id
 y8-20020a056a00180800b006e59a0ab66amr786472pfa.3.1709773115641; Wed, 06 Mar
 2024 16:58:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 16:58:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307005833.827147-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/pmu: Disable support for adaptive PEBS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <like.xu.linux@gmail.com>, Mingwei Zhang <mizhang@google.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop support for virtualizing adaptive PEBS, as KVM's implementation is
architecturally broken without an obvious/easy path forward, and because
exposing adaptive PEBS can leak host LBRs to the guest, i.e. can leak
host kernel addresses to the guest.

Bug #1 is that KVM doesn't doesn't account for the upper 32 bits of
IA32_FIXED_CTR_CTRL when (re)programming fixed counters, e.g
fixed_ctrl_field() drops the upper bits, reprogram_fixed_counters()
stores local variables as u8s and truncates the upper bits too, etc.

Bug #2 is that, because KVM _always_ sets precise_ip to a non-zero value
for PEBS events, perf will _always_ generate an adaptive record, even if
the guest requested a basic record.  Note, KVM will also enable adaptive
PEBS in individual *counter*, even if adaptive PEBS isn't exposed to the
guest, but this is benign as MSR_PEBS_DATA_CFG is guaranteed to be zero,
i.e. the guest will only ever see Basic records.

Bug #3 is in perf.  intel_pmu_disable_fixed() doesn't clear the upper
bits either, i.e. leaves ICL_FIXED_0_ADAPTIVE set, and
intel_pmu_enable_fixed() effectively doesn't clear ICL_FIXED_0_ADAPTIVE
either.  I.e. perf _always_ enables ADAPTIVE counters, regardless of what
KVM requests.

Bug #4 is that adaptive PEBS *might* effectively bypass event filters set
by the host, as "Updated Memory Access Info Group" records information
that might be disallowed by userspace via KVM_SET_PMU_EVENT_FILTER.

Bug #5 is that KVM doesn't ensure LBR MSRs hold guest values (or at least
zeros) when entering a vCPU with adaptive PEBS, which allows the guest
to read host LBRs, i.e. host RIPs/addresses, by enabling "LBR Entries"
records.

Disable adaptive PEBS support as an immediate fix due to the severity of
the LBR leak in particular, and because fixing all of the bugs will be
non-trivial, e.g. not suitable for backporting to stable kernels.

Note!  This will break live migration, but trying to make KVM play nice
with live migration would be quite complicated, wouldn't be guaranteed to
work (i.e. KVM might still kill/confuse the guest), and it's not clear
that there are any publicly available VMMs that support adaptive PEBS,
let alone live migrate VMs that support adaptive PEBS, e.g. QEMU doesn't
support PEBS in any capacity.

Link: https://lore.kernel.org/all/20240306230153.786365-1-seanjc@google.com
Link: https://lore.kernel.org/all/ZeepGjHCeSfadANM@google.com
Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: stable@vger.kernel.org
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhang Xiong <xiong.y.zhang@intel.com>
Cc: Lv Zhiyuan <zhiyuan.lv@intel.com>
Cc: Dapeng Mi <dapeng1.mi@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7a74388f9ecf..641a7d5bf584 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7864,8 +7864,28 @@ static u64 vmx_get_perf_capabilities(void)
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-		if ((perf_cap & PERF_CAP_PEBS_FORMAT) < 4)
-			perf_cap &= ~PERF_CAP_PEBS_BASELINE;
+
+		/*
+		 * Disallow adaptive PEBS as it is functionally broken, can be
+		 * used by the guest to read *host* LBRs, and can be used to
+		 * bypass userspace event filters.  To correctly and safely
+		 * support adaptive PEBS, KVM needs to:
+		 *
+		 * 1. Account for the ADAPTIVE flag when (re)programming fixed
+		 *    counters.
+		 *
+		 * 2. Gain support from perf (or take direct control of counter
+		 *    programming) to support events without adaptive PEBS
+		 *    enabled for the hardware counter.
+		 *
+		 * 3. Ensure LBR MSRs cannot hold host data on VM-Entry with
+		 *    adaptive PEBS enabled and MSR_PEBS_DATA_CFG.LBRS=1.
+		 *
+		 * 4. Document which PMU events are effectively exposed to the
+		 *    guest via adaptive PEBS, and make adaptive PEBS mutually
+		 *    exclusive with KVM_SET_PMU_EVENT_FILTER if necessary.
+		 */
+		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
 	return perf_cap;

base-commit: 0c64952fec3ea01cb5b09f00134200f3e7ab40d5
-- 
2.44.0.278.ge034bb2e1d-goog


