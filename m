Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26587E0C00
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjKCXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjKCXFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:05:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD5D50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:05:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso34834427b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052744; x=1699657544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEfjFh44NmfiqSsnTU+vPV5C1Ip8OtIT4vR69i+9ITE=;
        b=RKqc6eDX2SdkS4IAXyxsVP5uyHSFrqCn504HqK2Q9x74/0/bq4uYAgZ1VTGPS+xCt5
         okpVbhKtNCLyeaDsIiVQoQugYdYqEhZxTFN8sAS17f3KendUwVBx0uajTIGlqlMvsT9g
         xRvKdamt7Vu5uU2HjMEczbxWya8LWewblmvNdmmzcQ0VQMENf2BbfcB2fOmif/Bc5zix
         4XL/Y82V1aydNOlG9lVATHcmxsln1Cgk/evPJKvzeOWe+ea7aXJJkvSuotgecVPRIYhB
         tZ/NtXB9AXVD1h9oylQrAvx3CFStuDMPty6piDVULoGvxShxYjkGO5Kx9OpzUY+BPvUu
         H5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052744; x=1699657544;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEfjFh44NmfiqSsnTU+vPV5C1Ip8OtIT4vR69i+9ITE=;
        b=oVumXZ9Hyo6o9R7h5Wfqvlnnt0CIMEl9/fe23K24r7oxcZbEP7tJMaoMDT6aIbmKRj
         9tDaO8bM56w7vfvwolcVdsgEDknIkWKOVM1OQW4047qA6at+EiSCm0pgpDhR3cLgb3hH
         S+kwZkcmWOMHZR5Mun6zj4DwCjeh+9Ijy7uSMhlMBklXt1+F/VpuwbSsENh7DpA08VDh
         W+OEeGbzlotTodsmwj3u34MM2XZ/llE4dg8FRF4VO9jA2/mN9K1elOqKqtmX41/CkwN6
         zWuv3MSqw3b5F0766GXRFOdKY/pz4ZhRP5XqirATGCklAnAYaQ4dDQPrvvJ1c88XgSad
         AESw==
X-Gm-Message-State: AOJu0YxjKhVcPYk/o9Gao9+r9aqLDhsGhf49Kw6NRlw1btPx2xN88CZJ
        hqhNCgeAHUU47m3UQYBgjH0v89znrjw=
X-Google-Smtp-Source: AGHT+IHq92zkFtQr6pUqAXNv5xuFcW/QuhURF5kl3POGKy2n8bFZrmBZRBlxSK9AesUH9GJsJZrHtBHQM6Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d785:0:b0:592:7a39:e4b4 with SMTP id
 z127-20020a0dd785000000b005927a39e4b4mr82946ywd.6.1699052743920; Fri, 03 Nov
 2023 16:05:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 16:05:35 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103230541.352265-1-seanjc@google.com>
Subject: [PATCH v2 0/6] KVM: x86/pmu: Clean up emulated PMC event handling
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
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

The ultimate goal of this series is to track emulated counter events using
a dedicated variable instead of trying to track the previous counter value.
Tracking the previous counter value is flawed as it takes a snapshot at
every emulated event, but only checks for overflow prior to VM-Enter, i.e.
KVM could miss an overflow if KVM ever supports emulating event types that
can occur multiple times in a single VM-Exit.

And as Mingwei root caused, emulating overflow while the perf event is
running can result in duplicate overflow events, e.g. if the perf event
overflows between taking and checking the snapshot.  This bug is largely
masked now that KVM correctly sets LVT_MASK when delivering PMIs, but it's
still a bug, e.g. could cause problems if there are other side effects.

Patches 1-5 are (some loosely, some tightly) related fixes and cleanups to
simplify the emulated counter approach implementation.  The fixes are
tagged for stable as usersepace could cause some weirdness around perf
events, but I doubt any real world VMM is actually affected.

Dapeng, I intentionally omitted your Reviewed-by from the last patch as
the change from v1 isn't trivial.

v2:
 - Collect reviews. [Dapeng]
 - Emulate overflow *after* pausing perf event. [Mingwei]

v1: https://lore.kernel.org/all/20231023234000.2499267-1-seanjc@google.com

Sean Christopherson (6):
  KVM: x86/pmu: Move PMU reset logic to common x86 code
  KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing
  KVM: x86/pmu: Stop calling kvm_pmu_reset() at RESET (it's redundant)
  KVM: x86/pmu: Remove manual clearing of fields in kvm_pmu_init()
  KVM: x86/pmu: Update sample period in pmc_write_counter()
  KVM: x86/pmu: Track emulated counter events instead of previous
    counter

 arch/x86/include/asm/kvm-x86-pmu-ops.h |   2 +-
 arch/x86/include/asm/kvm_host.h        |  17 ++-
 arch/x86/kvm/pmu.c                     | 140 +++++++++++++++++++++----
 arch/x86/kvm/pmu.h                     |  47 +--------
 arch/x86/kvm/svm/pmu.c                 |  17 ---
 arch/x86/kvm/vmx/pmu_intel.c           |  22 ----
 arch/x86/kvm/x86.c                     |   1 -
 7 files changed, 137 insertions(+), 109 deletions(-)


base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.42.0.869.gea05f2083d-goog

