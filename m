Return-Path: <linux-kernel+bounces-97662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3371876D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B36AB20EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF634CDEB;
	Fri,  8 Mar 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmM625sV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384B4E1BC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937440; cv=none; b=YZ9DBXG/j9GT5txUatUoFOhxxR9EYP+ZsDCMFW6ifbJElV0WbBweYeNkB94NJG6UGHVN1ftu+zkI7KtwwFwBoC5GhpG35GDfv58xcx4gpdTdk1Z9aDuRC5fHZAKhAiQBQB4eQESBm7pOXub0JcmIEaYvGlTGkby9pCvW1OCjAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937440; c=relaxed/simple;
	bh=Cx7f0LVK3agk27XVlL40f1u6TZkbMfoIz9OO1MplwA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Raw52dsT/tVd0Zs8cZKhkDVZqKLw4Wjd9kjrbqV4yMAy1StI7+bKGljTUZ+esSU2xy4TNOyOE/dMmHRzzb4+eU/+bZaAApZS/LEwEWjQQLy335sx6yfvoep+sN70T4b5acKSXn7JmygBQ9YfYCNpUFjvf5jaQeFT0H8LMMy92vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmM625sV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0890f2cdso15236277b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937437; x=1710542237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk7WezRe+PQVWxoR7gEA577W4P7MYaIjcJoEoxf0Qyg=;
        b=qmM625sV/JqZDDgDZuEn4n+emjohCMS8mdug4+HlKH2i4wCc3tKdJDO0PRFoajjHTe
         lt6y1hro7zH36/RpOsXkDW23MFEsGZ2llP+EfG/0YL0+W/+371YNkijRkY1hGT0hSrD9
         oOoOSU3zvgq8LHgUVF1em3x+4g6Ec+DS3N2Xko5lpIYZ+tv/PO+HIT3C3rfrUJYC2PUR
         OL+rUJ1bjAWVQ0P/UajvnlL8nICyfeVC8hgShNRejwwZaMguVitlgulpYv6ZnLmvxv7y
         OerSGxMKC7++3ZYm3IqpMmwPlvnxnNbukF1jyYbEKJVO5RIb7NPvyLAli2OXn8Hh3Lj9
         ZzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937437; x=1710542237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wk7WezRe+PQVWxoR7gEA577W4P7MYaIjcJoEoxf0Qyg=;
        b=bv852bw+S0E/LjGZ5rxEfxtL59MxyfE2Zf6D/kSshBr9gSOmxDX9TFxxz0bBTuKCrm
         eGs/7JeB7U70Ei2+KP6zAkkI7fWRgiDa1xdAUuFvzFimyTifjU7uggDoBG7bjjnl9h/q
         ATPl34iHiL82ZoKgYa77Zl8qNsYLhANsfM+qTqv4XyqEB6pbrjxxCIYYU6bkFBIyJ8nc
         KJNmkftWkixDPAgKqVXfK/LtIPZ/F66HI8VV+2B3vgc0W+JDTAguok4HPCjdI1oiY3Te
         D07a+nOR36zBgDuFcx0JhAt5okA0nKH9PO1eKYOwHw74Qm/lxenKtIUQRhnSaMcFs5ud
         8LQw==
X-Forwarded-Encrypted: i=1; AJvYcCUR6d0YC++YNRM5L4HJA9JbPPXrLbuak9hIEV/f49QlvUIBkZc0wL7C4DQ+TzeWAEwEBkSZHr+5aAD9GhJW9tvuz9euzvcgPpy7ehH0
X-Gm-Message-State: AOJu0Ywiu9zf6jFvenFe08izufTryAqAguL28BzOelzVWdAa1BrWYbOh
	cNVe8e+rs7fXTjbGOaIZ8QX4WEettE2Wx3RYHBLCCAkx155HY1xij7GK79qunP1HRDLjyHoZW5z
	y2w==
X-Google-Smtp-Source: AGHT+IGnmjfvlcjZuy3b19/cYW0QdWQ7KiHDZyOkuNlHhwxG/abXYYKbahuS+mfiBMwV9TjogKtbf11y14k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4f43:0:b0:609:fcd2:2749 with SMTP id
 d64-20020a814f43000000b00609fcd22749mr150967ywb.4.1709937436831; Fri, 08 Mar
 2024 14:37:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 14:36:58 -0800
In-Reply-To: <20240308223702.1350851-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308223702.1350851-6-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: PMU changes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Lots of PMU fixes and cleanups, along with related selftests.  The most notable
fix is to *not* disallow the use of fixed counters and event encodings just
because the CPU doesn't report support for the matching architectural event
encoding.

Note, the selftests changes have several annoying conflicts with "the" selftests
pull request that you'll also receive from me.  I recommend merging that one
first, as I found it slightly easier to resolve the conflicts in that order.

P.S. I expect to send another PMU related pull request of 3-4 fixes at some
point during the merge window.  But they're all small and urgent (if we had a
few more weeks for 6.8, I'd have tried to squeeze them into 6.8).

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pmu-6.9

for you to fetch changes up to 812d432373f629eb8d6cb696ea6804fca1534efa:

  KVM: x86/pmu: Explicitly check NMI from guest to reducee false positives (2024-02-26 15:57:22 -0800)

----------------------------------------------------------------
KVM x86 PMU changes for 6.9:

 - Fix several bugs where KVM speciously prevents the guest from utilizing
   fixed counters and architectural event encodings based on whether or not
   guest CPUID reports support for the _architectural_ encoding.

 - Fix a variety of bugs in KVM's emulation of RDPMC, e.g. for "fast" reads,
   priority of VMX interception vs #GP, PMC types in architectural PMUs, etc.

 - Add a selftest to verify KVM correctly emulates RDMPC, counter availability,
   and a variety of other PMC-related behaviors that depend on guest CPUID,
   i.e. are difficult to validate via KVM-Unit-Tests.

 - Zero out PMU metadata on AMD if the virtual PMU is disabled to avoid wasting
   cycles, e.g. when checking if a PMC event needs to be synthesized when
   skipping an instruction.

 - Optimize triggering of emulated events, e.g. for "count instructions" events
   when skipping an instruction, which yields a ~10% performance improvement in
   VM-Exit microbenchmarks when a vPMU is exposed to the guest.

 - Tighten the check for "PMI in guest" to reduce false positives if an NMI
   arrives in the host while KVM is handling an IRQ VM-Exit.

----------------------------------------------------------------
Dapeng Mi (1):
      KVM: selftests: Test top-down slots event in x86's pmu_counters_test

Jinrong Liang (7):
      KVM: selftests: Add vcpu_set_cpuid_property() to set properties
      KVM: selftests: Add pmu.h and lib/pmu.c for common PMU assets
      KVM: selftests: Test Intel PMU architectural events on gp counters
      KVM: selftests: Test Intel PMU architectural events on fixed counters
      KVM: selftests: Test consistency of CPUID with num of gp counters
      KVM: selftests: Test consistency of CPUID with num of fixed counters
      KVM: selftests: Add functional test for Intel's fixed PMU counters

Like Xu (1):
      KVM: x86/pmu: Explicitly check NMI from guest to reducee false positives

Sean Christopherson (32):
      KVM: x86/pmu: Always treat Fixed counters as available when supported
      KVM: x86/pmu: Allow programming events that match unsupported arch events
      KVM: x86/pmu: Remove KVM's enumeration of Intel's architectural encodings
      KVM: x86/pmu: Setup fixed counters' eventsel during PMU initialization
      KVM: x86/pmu: Get eventsel for fixed counters from perf
      KVM: x86/pmu: Don't ignore bits 31:30 for RDPMC index on AMD
      KVM: x86/pmu: Prioritize VMX interception over #GP on RDPMC due to bad index
      KVM: x86/pmu: Apply "fast" RDPMC only to Intel PMUs
      KVM: x86/pmu: Disallow "fast" RDPMC for architectural Intel PMUs
      KVM: x86/pmu: Treat "fixed" PMU type in RDPMC as index as a value, not flag
      KVM: x86/pmu: Explicitly check for RDPMC of unsupported Intel PMC types
      KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
      KVM: selftests: Extend {kvm,this}_pmu_has() to support fixed counters
      KVM: selftests: Expand PMU counters test to verify LLC events
      KVM: selftests: Add a helper to query if the PMU module param is enabled
      KVM: selftests: Add helpers to read integer module params
      KVM: selftests: Query module param to detect FEP in MSR filtering test
      KVM: selftests: Move KVM_FEP macro into common library header
      KVM: selftests: Test PMC virtualization with forced emulation
      KVM: selftests: Add a forced emulation variation of KVM_ASM_SAFE()
      KVM: selftests: Add helpers for safe and safe+forced RDMSR, RDPMC, and XGETBV
      KVM: selftests: Extend PMU counters test to validate RDPMC after WRMSR
      KVM: x86/pmu: Zero out PMU metadata on AMD if PMU is disabled
      KVM: x86/pmu: Add common define to capture fixed counters offset
      KVM: x86/pmu: Move pmc_idx => pmc translation helper to common code
      KVM: x86/pmu: Snapshot and clear reprogramming bitmap before reprogramming
      KVM: x86/pmu: Add macros to iterate over all PMCs given a bitmap
      KVM: x86/pmu: Process only enabled PMCs when emulating events in software
      KVM: x86/pmu: Snapshot event selectors that KVM emulates in software
      KVM: x86/pmu: Expand the comment about what bits are check emulating events
      KVM: x86/pmu: Check eventsel first when emulating (branch) insns retired
      KVM: x86/pmu: Avoid CPL lookup if PMC enabline for USER and KERNEL is the same

 arch/x86/include/asm/kvm-x86-pmu-ops.h             |   4 +-
 arch/x86/include/asm/kvm_host.h                    |  11 +-
 arch/x86/kvm/emulate.c                             |   2 +-
 arch/x86/kvm/kvm_emulate.h                         |   2 +-
 arch/x86/kvm/pmu.c                                 | 163 ++++--
 arch/x86/kvm/pmu.h                                 |  57 +-
 arch/x86/kvm/svm/pmu.c                             |  22 +-
 arch/x86/kvm/vmx/nested.c                          |   2 +-
 arch/x86/kvm/vmx/pmu_intel.c                       | 222 +++-----
 arch/x86/kvm/x86.c                                 |  15 +-
 arch/x86/kvm/x86.h                                 |   6 -
 tools/testing/selftests/kvm/Makefile               |   2 +
 .../testing/selftests/kvm/include/kvm_util_base.h  |   4 +
 tools/testing/selftests/kvm/include/x86_64/pmu.h   |  97 ++++
 .../selftests/kvm/include/x86_64/processor.h       | 148 +++--
 tools/testing/selftests/kvm/lib/kvm_util.c         |  62 ++-
 tools/testing/selftests/kvm/lib/x86_64/pmu.c       |  31 ++
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  15 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c       | 620 +++++++++++++++++++++
 .../selftests/kvm/x86_64/pmu_event_filter_test.c   | 143 ++---
 .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c |   2 +-
 .../selftests/kvm/x86_64/userspace_msr_exit_test.c |  29 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c       |   2 +-
 23 files changed, 1262 insertions(+), 399 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/pmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/pmu.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c

