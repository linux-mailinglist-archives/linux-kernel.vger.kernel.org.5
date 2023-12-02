Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9B80186C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441904AbjLBAER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLBAEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D800CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so1286849a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475461; x=1702080261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFYOzjq2VL9ltumoNAO/cRr/UGIDvUYIMH6fYtB6gdQ=;
        b=nLhnwduTDkp7/vwVen6FS8ULkHNX/AtEYj/pcCxMfiTaxSgqCtDJWhl6U+A4/JAoEX
         Xhm0EsTNpdm1UcspIgrJ77t/Jsy8ro1YdmvdiIl1KYozc62A+uHs2q8Si2KGdJvE2kZC
         +je61+0wGiDjX5L2Te9HNygm44smWZ7nSCDAsEX8uzJ8jEYcGpiVsIi1k79G/7jxb9PR
         g9h8IDAPA/UgCa1RB5eVyTOhrw82uRWsmEXaSW2wCqrM8lgYw/GsOjRqDjLvuhyFYDWl
         JaHZOOy/dzV75zlR8ZHIpSazhWxPJ7VSzOZDZo7p8wdSIJmUtnv2V6tQHmoqFPtT08px
         0mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475461; x=1702080261;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFYOzjq2VL9ltumoNAO/cRr/UGIDvUYIMH6fYtB6gdQ=;
        b=GnLNOx6A8nGlFW2q268Xc8JRC3fQQlY4OVM0cKJTrPSYM0vP2HOMNZSNInZWcx2MPq
         atTsoBGILRDFGGZuoAuv9uPO3OHAvz42QFfUnbAWNSGp2wjMv4FujuBtkWsdvg6RK6CE
         C+ULKuR5dRNSeVYFTS73mjRtNx8o+otlY3EES5W3AUj6aL3+ot2hKT3JD0ocT18YSINt
         2M+9dOzCoKGOZDb72OpFCyhVcKxqWq/PSIIb6+i7IWwWwAgw5mi9YGeW37LBWIxdHYcT
         /H//umI1sA8o+g5Z7f69NvBRXTBq0mTuyNe4x7nRgKX4wxuCBYBGQqSyaVkxgGWis5Kw
         VvcA==
X-Gm-Message-State: AOJu0YzKJLKYpFhUF+HDLPN2fetxvoxI6ekQNnXRxtscGQkTvyAD6CwU
        aLhrVFqL2BAzY6CeeiaXA51ZIV5rm+g=
X-Google-Smtp-Source: AGHT+IHc9rKg8F3PB3igngLCLbvOxvpTOSdedUDtn6wa2GgKO3w6jaVX/2dX5QkWuYkB2xevlwsm7dRHZFI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:154c:0:b0:5c1:589d:b3dc with SMTP id
 12-20020a63154c000000b005c1589db3dcmr4375541pgv.1.1701475460655; Fri, 01 Dec
 2023 16:04:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:49 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-1-seanjc@google.com>
Subject: [PATCH v9 00/28] KVM: x86/pmu: selftests: Fixes and new tests
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another version of fixes and tests for PMU counters.  New in v9 is a
fix for priority inversion of #GP vs. VM-Exit on Intel when KVM fully
emulates a RDPMC with a "bad" index.  For all intents and purposes, this
priority inversion triggered the WARN in v8[*], which is why I included
the fix in this series (and because the fix would conflict horribly).

Dapeng, I dropped one of your reviews (patch "Disallow "fast" RDPMC for
architectural Intel PMUs) as the patch ended up being quite different after
eliminating the early RDPMC index check.

[*] https://lore.kernel.org/all/ZU69h65HwvnpjhjX@google.com

v9:
 - Collect reviews. [Dapeng, Kan]
 - Fix a 63:31 => 63:32 typo in a changelog. [Dapeng]
 - Actually check that forced emulation is enabled before trying to force
   emulation on RDPMC. [Jinrong]
 - Fix the aformentioned priority inversion issue.
 - Completely drop "support" for fast RDPMC, in quotes because KVM doesn't
   actually support RDPMC for non-architectural PMUs.  I had left the code
   in v8 because I didn't fully grok what the early emulator check was
   doing, i.e. wasn't 100% confident it was dead code.

v8:
 - https://lore.kernel.org/all/20231110021306.1269082-1-seanjc@google.com
 - Collect reviews. [Jim, Dapeng, Kan]
 - Tweak names for the RDPMC flags in the selftests #defines.
 - Get the event selectors used to virtualize fixed straight from perf
   instead of hardcoding the (wrong) selectors in KVM. [Kan]
 - Rename an "eventsel" field to "event" for a patch that gets blasted
   away in the end anyways. [Jim]
 - Add patches to fix RDPMC emulation and to test the behavior on Intel.
   I spot tested on AMD and spent ~30 minutes trying to squeeze in the
   bare minimum AMD support, but the PMU implementations between Intel
   and AMD are juuuust different enough to make adding AMD support non-
   trivial, and this series is already way too big.
 
v7:
 - https://lore.kernel.org/all/20231108003135.546002-1-seanjc@google.com
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

Sean Christopherson (21):
  KVM: x86/pmu: Always treat Fixed counters as available when supported
  KVM: x86/pmu: Allow programming events that match unsupported arch
    events
  KVM: x86/pmu: Remove KVM's enumeration of Intel's architectural
    encodings
  KVM: x86/pmu: Setup fixed counters' eventsel during PMU initialization
  KVM: x86/pmu: Get eventsel for fixed counters from perf
  KVM: x86/pmu: Don't ignore bits 31:30 for RDPMC index on AMD
  KVM: x86/pmu: Prioritize VMX interception over #GP on RDPMC due to bad
    index
  KVM: x86/pmu: Apply "fast" RDPMC only to Intel PMUs
  KVM: x86/pmu: Disallow "fast" RDPMC for architectural Intel PMUs
  KVM: x86/pmu: Explicitly check for RDPMC of unsupported Intel PMC
    types
  KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
  KVM: selftests: Extend {kvm,this}_pmu_has() to support fixed counters
  KVM: selftests: Expand PMU counters test to verify LLC events
  KVM: selftests: Add a helper to query if the PMU module param is
    enabled
  KVM: selftests: Add helpers to read integer module params
  KVM: selftests: Query module param to detect FEP in MSR filtering test
  KVM: selftests: Move KVM_FEP macro into common library header
  KVM: selftests: Test PMC virtualization with forced emulation
  KVM: selftests: Add a forced emulation variation of KVM_ASM_SAFE()
  KVM: selftests: Add helpers for safe and safe+forced RDMSR, RDPMC, and
    XGETBV
  KVM: selftests: Extend PMU counters test to validate RDPMC after WRMSR

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   3 +-
 arch/x86/kvm/emulate.c                        |   2 +-
 arch/x86/kvm/kvm_emulate.h                    |   2 +-
 arch/x86/kvm/pmu.c                            |  20 +-
 arch/x86/kvm/pmu.h                            |   5 +-
 arch/x86/kvm/svm/pmu.c                        |  17 +-
 arch/x86/kvm/vmx/pmu_intel.c                  | 157 ++---
 arch/x86/kvm/x86.c                            |   9 +-
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |   4 +
 tools/testing/selftests/kvm/include/pmu.h     |  97 +++
 .../selftests/kvm/include/x86_64/processor.h  | 148 ++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  62 +-
 tools/testing/selftests/kvm/lib/pmu.c         |  31 +
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 617 ++++++++++++++++++
 .../kvm/x86_64/pmu_event_filter_test.c        | 143 ++--
 .../smaller_maxphyaddr_emulation_test.c       |   2 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      |  29 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   2 +-
 20 files changed, 1079 insertions(+), 288 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/pmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/pmu.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c


base-commit: 9f018b692c0114a484cea4faf9758a224774866a
-- 
2.43.0.rc2.451.g8631bc7472-goog

