Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D596C7E4E02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjKHAbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKHAbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:31:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448410F8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:31:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b31e000e97so86533567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403499; x=1700008299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7P2uvgy4SF2Vsxo1O1jFhHP8I0VSiu9GCBS0pSiN+9I=;
        b=ZPMxqx3oMAmJWaPs4jE+4bLs3R0RgHzNJ3eWX5BpULU7LP3zbxMz2scF4oN7UIdgLq
         6fOR5fqMua7hVjTghUO84EX1aH3t0oMPG5p3E7Pfn4RKWxcWrB6UOMNSLQ8z1EnC+31Y
         OBL2iTKk0/PcmOQyGlEmGFq8b/j+23tVzr22i4d2o+0sRZ/f3czFZ2Wt1e+w0Con3nfh
         Zoi3WOVtHodraoHbonVt9u/D6ap6a6ncXZ/0DRmauNpkk1ZF9Tf9qBUWtlHiOjCgALN3
         ArkMMpNZmblOLUsbJ0Cn36Oy3qutNByAoWiVbjLnG8tyBhPTLosA7HFTQT2rN7MpF2rL
         gOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403499; x=1700008299;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P2uvgy4SF2Vsxo1O1jFhHP8I0VSiu9GCBS0pSiN+9I=;
        b=KR5l9Gmc6QxZfy3ZSDzCYw7xgpPltsFzZ6wqvV/WFz3Kshz8QOSADU7EZZo/ni9LU5
         qUpp12q4rl0BJWvcFayVUPvIy3UD3sNscLDEOpV0F7qhfcSmKQ6jakjQQFiswYVWjYj9
         zSyCw6LF8Gvu3kUkRf+msPsWIou+4uMDk0K1RmJTy1n94ZsdPdyZNEqTRKXhaYGsVgfD
         I1swK5u9BqVNd7BKJQWUt3qeJJoSoLN+YazTtF+IgcAs8e0lvwBTUA+ZKo68HDlWdvMi
         RvjiUn+l6wfoBz/ObeRm7dwkPznwj8M/bMrWLvoUojOhFoRMiwX4i3VITznhRHdrPVFI
         Vy5w==
X-Gm-Message-State: AOJu0YwJTZrs7c4zH+56dXYFnrgAOPNaRpqmRuvMH90g9cek6uY52Ade
        2NWKLwiMuwnilRwYo3ymQUiTRLY29Xc=
X-Google-Smtp-Source: AGHT+IHTuDc4+EPinrV5gtZxep5Vfbio+Vf4i0R/KvsNCABGXqAndJJEAJjRxmvT+aQR8GvBdhIr9yUHLMA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:eb4a:0:b0:5a7:be3f:159f with SMTP id
 u71-20020a0deb4a000000b005a7be3f159fmr4903ywe.5.1699403498941; Tue, 07 Nov
 2023 16:31:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:16 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-1-seanjc@google.com>
Subject: [PATCH v7 00/19] KVM: x86/pmu: selftests: Fixes and new tests
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Round 7!  Fix bugs where KVM incorrectly refuses to virtualize fixed
counters and events whose encodings match unsupported arch events, and add
a PMU counters selftest to verify

As an aside, my hope is that in the long term, we can build out the PMU
selftests and deprecate the PMU tests in KUT so that we have everything
in-kernel and in one spot.

v7:
 - Drop patches that unnecessarily sanitized supported CPUID. [Jim]
 - Purge the array of architectural event encodings. [Jim, Dapeng]
 - Clean up pmu.h to remove useless macros, and make it easier to use the
   new macros. [Jim]
 - Port more of pmu_event_filter_test.c to pmu.h macros. [Jim, Jinrong]
 - Clean up test comments and error messages. [Jim]
 - Sanity check the value provided to vcpu_set_cpuid_property(). [Jim]

v6:
 - https://lore.kernel.org/all/20231104000239.367005-1-seanjc@google.com
 - Test LLC references/misses with CFLUSH{OPT}. [Jim]
 - Make the tests play nice without PERF_CAPABILITIES. [Mingwei]
 - Don't squash eventsels that happen to match an unsupported arch event. [Kan]
 - Test PMC counters with forced emulation (don't ask how long it took me to
   figure out how to read integer module params).

v5: https://lore.kernel.org/all/20231024002633.2540714-1-seanjc@google.com
v4: https://lore.kernel.org/all/20230911114347.85882-1-cloudliang@tencent.com
v3: https://lore.kernel.org/kvm/20230814115108.45741-1-cloudliang@tencent.com

 
Jinrong Liang (7):
  KVM: selftests: Add vcpu_set_cpuid_property() to set properties
  KVM: selftests: Add pmu.h and lib/pmu.c for common PMU assets
  KVM: selftests: Test Intel PMU architectural events on gp counters
  KVM: selftests: Test Intel PMU architectural events on fixed counters
  KVM: selftests: Test consistency of CPUID with num of gp counters
  KVM: selftests: Test consistency of CPUID with num of fixed counters
  KVM: selftests: Add functional test for Intel's fixed PMU counters

Sean Christopherson (12):
  KVM: x86/pmu: Always treat Fixed counters as available when supported
  KVM: x86/pmu: Allow programming events that match unsupported arch
    events
  KVM: x86/pmu: Remove KVM's enumeration of Intel's architectural
    encodings
  KVM: x86/pmu: Setup fixed counters' eventsel during PMU initialization
  KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
  KVM: selftests: Extend {kvm,this}_pmu_has() to support fixed counters
  KVM: selftests: Expand PMU counters test to verify LLC events
  KVM: selftests: Add a helper to query if the PMU module param is
    enabled
  KVM: selftests: Add helpers to read integer module params
  KVM: selftests: Query module param to detect FEP in MSR filtering test
  KVM: selftests: Move KVM_FEP macro into common library header
  KVM: selftests: Test PMC virtualization with forced emulation

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   1 -
 arch/x86/kvm/pmu.c                            |   1 -
 arch/x86/kvm/pmu.h                            |   1 -
 arch/x86/kvm/svm/pmu.c                        |   6 -
 arch/x86/kvm/vmx/pmu_intel.c                  | 107 +---
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |   4 +
 tools/testing/selftests/kvm/include/pmu.h     |  95 +++
 .../selftests/kvm/include/x86_64/processor.h  |  82 ++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  62 +-
 tools/testing/selftests/kvm/lib/pmu.c         |  31 +
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 568 ++++++++++++++++++
 .../kvm/x86_64/pmu_event_filter_test.c        | 143 ++---
 .../smaller_maxphyaddr_emulation_test.c       |   2 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      |  29 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   2 +-
 17 files changed, 912 insertions(+), 239 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/pmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/pmu.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c


base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.42.0.869.gea05f2083d-goog

