Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F97E0C89
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjKDACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKDACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296CD4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5acac8b6575so29028047b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056161; x=1699660961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1vwaM2DB2ZPo75zwBjfZLUSbsGuidXuSs+KvMaedrA=;
        b=U7k0fgSL0ChCzVSk+LY/nMNq+Fh1lR24W5eb04iaTSHxlCejo+5Re4lcDFMuCSU7iy
         YsfLB1b3okhIqrpnTwfpF5qSqU8J5krWJVWkBfCpRZgY8lXUJ0kSXOktzY8IYO9wQzFG
         ztEYUosZR7xCmzwUkLo4T6eCTXjfIhDQ1XB18mhmor4umc17CV4PcghDvADukSrKDm/g
         PhTKj4Ah+0LfLMBoVOCFgVYX5hD6HCnINRBowQclx54OfqKPX1+bpvm4Ki8NGI9BsbGV
         m+B4bHia+SVV2NY5Y/30nQnGXWmHpAqF8wQMurImoKYlm+H7vxprY+MMnsRmNVL9nFk7
         /QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056161; x=1699660961;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1vwaM2DB2ZPo75zwBjfZLUSbsGuidXuSs+KvMaedrA=;
        b=ctd8WgPxZ8A9AF2IyPyMySmnVOmNLaYdCNfsHnS2i+H6COHoAp4XvjikauhyGDDMm6
         3L/R8FHxL0oe7g3PQgmdbR7crAOUXhMbLN5jgL4eKdaHQUz5uo4IR6sHOd7BJuy78PWU
         cin7eLjgwDaJ4OOwGfjofOlGKO2Iuxy5nUlOTjRHpdGAcHC58UTvYJ8/4mVVblwZa6y2
         alsLVOSS09iLWu+CrcdVQXcSter4TjyDbeItUbmUga3NLyGUvNeCuArT0c6+V3K26LZE
         AAiE10RWe49Pgraut4e6c2xGhne/UWtA+Rl4F5zHZeyGDobG9PfLNzlJ4jwQbODr37B2
         AlUA==
X-Gm-Message-State: AOJu0YzvVWU6/eseC/r+o6QTRRQWjcSMjZWdRb729BlFWPipwaz71sG+
        Dv51+TYSMmiQ0mYVNIhTs5zccO5O8fY=
X-Google-Smtp-Source: AGHT+IF5AxnhFRgiHUG2/4Rf88i9qr0QIptng+hsRGK9Hr4ht4+X+ShlIZ9uXoZYLxuZnBPC3J9BMD+v46U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3209:b0:5b8:d09e:704d with SMTP id
 ff9-20020a05690c320900b005b8d09e704dmr6284ywb.1.1699056161023; Fri, 03 Nov
 2023 17:02:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-1-seanjc@google.com>
Subject: [PATCH v6 00/20] KVM: x86/pmu: selftests: Fixes and new tests
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series that just keeps on growing.  This started out as a smallish
series from Jinrong to add PMU counters test, but has now ballooned to be
fixes and tests (that to some extent do actually validate the fixes).

Except for the first patch, the fixes aren't tagged for stable as I don't
*think* there's anything particularly nasty, and it's not like KVM's vPMU
is bulletproof even with the fixes.

v6:
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

Sean Christopherson (13):
  KVM: x86/pmu: Don't allow exposing unsupported architectural events
  KVM: x86/pmu: Don't enumerate support for fixed counters KVM can't
    virtualize
  KVM: x86/pmu: Don't enumerate arch events KVM doesn't support
  KVM: x86/pmu: Always treat Fixed counters as available when supported
  KVM: x86/pmu: Allow programming events that match unsupported arch
    events
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
 arch/x86/kvm/pmu.h                            |   5 +-
 arch/x86/kvm/svm/pmu.c                        |   6 -
 arch/x86/kvm/vmx/pmu_intel.c                  |  67 ++-
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |   4 +
 tools/testing/selftests/kvm/include/pmu.h     |  84 +++
 .../selftests/kvm/include/x86_64/processor.h  |  80 ++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  62 +-
 tools/testing/selftests/kvm/lib/pmu.c         |  28 +
 .../selftests/kvm/lib/x86_64/processor.c      |  12 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 567 ++++++++++++++++++
 .../kvm/x86_64/pmu_event_filter_test.c        |  34 +-
 .../smaller_maxphyaddr_emulation_test.c       |   2 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      |  29 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   2 +-
 17 files changed, 877 insertions(+), 109 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/pmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/pmu.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c


base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.42.0.869.gea05f2083d-goog

