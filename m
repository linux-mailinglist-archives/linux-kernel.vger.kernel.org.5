Return-Path: <linux-kernel+bounces-141582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077728A204D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B158C2820CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB218B14;
	Thu, 11 Apr 2024 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQnHg+DJ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FF257B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867734; cv=none; b=E0J7lAb2u2qcrTZuIRk+7CRQuBvuUah7+9eJ0+BsVgAiaqMWDHwfgmp0Y4zj2fzPDPpgN3ZGlPffi4xBHo+/z2TKyfK9IBkBw18IS0Z1AwMWvwHc/XhSudIv5OfmttKjKQXAJI17ol0L2jIIZeaMZ8yx3Otu2zhGzHTFUMozz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867734; c=relaxed/simple;
	bh=K0zTKlQD4iwZr8EEqUDQ32HxtvNWjHQxjhUh1dpSKxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QP41AvrotJAq+yo9+ODj5xHJzTsKFh81WfIw3I1jxjxbUzzeoFJ3xl+GCjoTvTCrDKuPxm0uH0yMUjXV/Xa/Yk+TviQ00VrnWovSPwSPF/yJoa5ji8JNoPvHkvKQMympvv0ct28O7LTqrHMDRHZv5ER4hm4v8yqMvMBEZqbOnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQnHg+DJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e3deea5ac0so2390135ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712867733; x=1713472533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKU8rOl0vk3vMy2vP6wjrKgoAIX6EQ9pHPrAJyF797A=;
        b=DQnHg+DJJPHtf5QiqZlW+kX7lP5ULFLa5d/AvysRHt8oP+HMXxImXygH4u6u3y8/u4
         BZOoc40N73XBel5KZY6QIHcnbFH+DhGGZI9gg2ZRC5sfCwVwzfOgqZW0h0n0frt+BWVA
         M/GZNedJ7fyuL1uh9jm103Y6FLJvDqPhTZ4OqUCLNo8kO1oDP5NgA14C/QrUoC4ijl2O
         FvwISfoh3Awlqt5qaYTl4b5GOPSTsjpaMdQs9KndBRDoOoWfTefIcCXifaBIluPtcdr/
         +HDU7k9YYB0mtq5jeLZxmXiPzCe84pG3YPeAuY3VDV7Feqv8ErSRJOFLkDcMS+mKZMzk
         e2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867733; x=1713472533;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKU8rOl0vk3vMy2vP6wjrKgoAIX6EQ9pHPrAJyF797A=;
        b=JjOugh27HEy4DX7qLFSKKdDWVRsLzqY7bQZtw4gD6PkZrPeiPMnqGRgBvb7pic6/g+
         34VEUkpnycQ0i6rSP0ZZBNfulDCCkUrQ25o2kSd7o7UU6eWIRGo0/6gSfVwoW491mf1R
         3h+IrIEgo/5B3/Q52w5ZRxYgbtMmDWi5knebs1o3XRo0Bh15UIj6Ljgd7LXd+NuDDr4V
         qoRqWVLAPVIat6us/FBplfCy3ODm6KZinhoOt8YFYUihHRDXgvMd61bT7kvfwhu9dthM
         BD3lGiXY7pOWzqUu6/ds8kvWsL0ZAE4z0JJse5irNM73Bz02w1JA4WDl53+P8knPoQSZ
         P99g==
X-Forwarded-Encrypted: i=1; AJvYcCX2odn+J+1fVelo6QO70+949kmYczRbZVMR5aqrRMmun62c458xOqXgvlEX0iz6SNp1jrIKZjwFLhQewnqjA9KZArhAtySX6/g5QGGa
X-Gm-Message-State: AOJu0YzoIDMTlYNDeu1RMO+dcrX0aZyhgPxdNJtov/LsRVElmks92NPm
	+hwWnQ2vhRN8M2hxOqMb9OT0SxV97SinuWF0enS/kDtPYB+WJjzZTC46uwQEW990MlKcaHCMxcG
	LBw==
X-Google-Smtp-Source: AGHT+IEgVtZkZGsZujiIXpgynTcdP9oqHaUGgf5djiMTQHf8OpScuYIASwwDa1j4ZIxDCDt6GvNXc+R4I7I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fb4d:b0:1e4:3330:eaf1 with SMTP id
 lf13-20020a170902fb4d00b001e43330eaf1mr1408plb.4.1712867732552; Thu, 11 Apr
 2024 13:35:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Apr 2024 13:35:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411203529.1866998-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Fixes for 6.9-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a big pile of fixes for 6.9.  Many of these were sent even before
the 6.9 merge window, but I was on vacation until rc2, and things piled up.

The back half of the commits were _just_ rebased to drop my version of the
LVTPC masking fixes, but that's your fault. :-)  For giggles, I also pushed
kvm-x86 tags/kvm-x86-fixed-6.9-rcN-unrebased if you or anyone else want a paper
trail for the pre-rebase commits.

Note, there's a perf change in here that didn't get an Ack from anyone, but the
fixes have been on-list for over a month, and I can't imagine anyone objecting
to adding a new feature flag to x86_pmu_capability, which for all intents and
purposes exists purely for KVM.

Thanks!

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.9-rcN

for you to fetch changes up to eefb85b3f0310c2f4149c50cb9b13094ed1dde25:

  KVM: Drop unused @may_block param from gfn_to_pfn_cache_invalidate_start() (2024-04-11 12:58:53 -0700)

----------------------------------------------------------------
KVM fixes for 6.9-rcN:

 - Fix a mostly benign bug in the gfn_to_pfn_cache infrastructure where KVM
   would allow userspace to refresh the cache with a bogus GPA.  The bug has
   existed for quite some time, but was exposed by a new sanity check added in
   6.9 (to ensure a cache is either GPA-based or HVA-based).

 - Drop an unused param from gfn_to_pfn_cache_invalidate_start() that got left
   behind during a 6.9 cleanup.

 - Disable support for virtualizing adaptive PEBS, as KVM's implementation is
   architecturally broken and can leak host LBRs to the guest.

 - Fix a bug where KVM neglects to set the enable bits for general purpose
   counters in PERF_GLOBAL_CTRL when initializing the virtual PMU.  Both Intel
   and AMD architectures require the bits to be set at RESET in order for v2
   PMUs to be backwards compatible with software that was written for v1 PMUs,
   i.e. for software that will never manually set the global enables.

 - Disable LBR virtualization on CPUs that don't support LBR callstacks, as
   KVM unconditionally uses PERF_SAMPLE_BRANCH_CALL_STACK when creating the
   virtual LBR perf event, i.e. KVM will always fail to create LBR events on
   such CPUs.

 - Fix a math goof in x86's hugepage logic for KVM_SET_MEMORY_ATTRIBUTES that
   results in an array overflow (detected by KASAN).

 - Fix a flaw in the max_guest_memory selftest that results in it exhausting
   the supply of ucall structures when run with more than 256 vCPUs.

 - Mark KVM_MEM_READONLY as supported for RISC-V in set_memory_region_test.

 - Fix a bug where KVM incorrectly thinks a TDP MMU root is an indirect shadow
   root due KVM unnecessarily clobbering root_role.direct when userspace sets
   guest CPUID.

 - Fix a dirty logging bug in the where KVM fails to write-protect TDP MMU
   SPTEs used for L2 if Page-Modification Logging is enabled for L1 and the L1
   hypervisor is NOT using EPT (if nEPT is enabled, KVM doesn't use the TDP MMU
   to run L2).  For simplicity, KVM always disables PML when running L2, but
   the TDP MMU wasn't accounting for root-specific conditions that force write-
   protect based dirty logging.

----------------------------------------------------------------
Andrew Jones (1):
      KVM: selftests: fix supported_flags for riscv

David Matlack (4):
      KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty status
      KVM: x86/mmu: Remove function comments above clear_dirty_{gfn_range,pt_masked}()
      KVM: x86/mmu: Fix and clarify comments about clearing D-bit vs. write-protecting
      KVM: selftests: Add coverage of EPT-disabled to vmx_dirty_log_test

Maxim Levitsky (1):
      KVM: selftests: fix max_guest_memory_test with more that 256 vCPUs

Rick Edgecombe (1):
      KVM: x86/mmu: x86: Don't overflow lpage_info when checking attributes

Sean Christopherson (11):
      KVM: Add helpers to consolidate gfn_to_pfn_cache's page split check
      KVM: Check validity of offset+length of gfn_to_pfn_cache prior to activation
      KVM: Explicitly disallow activatating a gfn_to_pfn_cache with INVALID_GPA
      KVM: x86/pmu: Disable support for adaptive PEBS
      KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"
      KVM: selftests: Verify post-RESET value of PERF_GLOBAL_CTRL in PMCs test
      KVM: VMX: Snapshot LBR capabilities during module initialization
      perf/x86/intel: Expose existence of callback support to KVM
      KVM: VMX: Disable LBR virtualization if the CPU doesn't support LBR callstacks
      KVM: x86/mmu: Precisely invalidate MMU root_role during CPUID update
      KVM: Drop unused @may_block param from gfn_to_pfn_cache_invalidate_start()

Tao Su (1):
      KVM: VMX: Ignore MKTME KeyID bits when intercepting #PF for allow_smaller_maxphyaddr

 arch/x86/events/intel/lbr.c                        |  1 +
 arch/x86/include/asm/perf_event.h                  |  1 +
 arch/x86/kvm/mmu/mmu.c                             |  9 ++--
 arch/x86/kvm/mmu/tdp_mmu.c                         | 51 ++++++++----------
 arch/x86/kvm/pmu.c                                 | 16 +++++-
 arch/x86/kvm/vmx/pmu_intel.c                       |  2 +-
 arch/x86/kvm/vmx/vmx.c                             | 41 ++++++++++++---
 arch/x86/kvm/vmx/vmx.h                             |  6 ++-
 .../testing/selftests/kvm/max_guest_memory_test.c  | 15 +++---
 .../testing/selftests/kvm/set_memory_region_test.c |  2 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c       | 20 +++++++-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c      | 60 +++++++++++++++++-----
 virt/kvm/kvm_main.c                                |  3 +-
 virt/kvm/kvm_mm.h                                  |  6 +--
 virt/kvm/pfncache.c                                | 50 ++++++++++++------
 15 files changed, 194 insertions(+), 89 deletions(-)

