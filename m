Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80ED7ADDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjIYRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjIYRfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:35:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D2115
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:34:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-692bbab7a4fso5805110b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695663295; x=1696268095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fRgk1GXWHwlF4dpNW6mrZozuiwZl1grW/0QNwyM28U=;
        b=qwvKM4uaM6fxKpqtc/e7PjgDQjZe2GOpjFcneywf1Q6rADXfv+DNMGmreKS9Gl4gMN
         cDwofVmXErcIi1pt6bRGOgGFPgURFVGlq2jgT4Z3nP4vJuTt+h3sIU8KbjuzsP54UpKM
         C1yVm9VHxkRPyDdJcKPpfccW+x4IbEUYHA0Xak6oCyB/P/rpUHxGCcUGDZMDMGpH+nQL
         eUsp/liTkgLriTGqDtOJWs6SkjVsoL/4FIVaR4+cxx3PX7MvLDYwRJFWZGOG8FDspC+9
         yyBV+oz9exydhqMkvzMZU7mvSJNlMO8brZ87ellPfhtN4mOyPufYMFMlDhrJ2RtNJDj6
         x4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695663295; x=1696268095;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+fRgk1GXWHwlF4dpNW6mrZozuiwZl1grW/0QNwyM28U=;
        b=ciKZZvkMI8jb8WL5O61xrJi8nB6TvXUh/9SM8ZwMJRvCXXxFsYTO4PiIS3d347vwG8
         kemtNjBgn2lzUpLH6uH0CDBajN/cTdO0j+9azud3W0DXv114NfSNKuNn/uBCUiY34duu
         tM9e0DN+UZz9rxvHkx15JPUahgw1OnddU+4gCE1dRKtX+yWBrZha2treTenMNhwo/FAW
         Od7RrfXoWYqaDJ26h4ICsgxtP+G9dSAC4WQqkf9nX9ywXppqjWxyEjqsf2nOwrdQdn4i
         NgMNl/tt/Ye6m+gkL2Ohh/L3F/rRPm+rIGnklxeIFp29NW+5Ub4vjVfr40EM6+aeI7Z/
         vl3Q==
X-Gm-Message-State: AOJu0YxTng7xjXn43vTnuuFVzcZPZBGA3nYf9DJWzoTAiM/q18lQJIG4
        pDAqtsuvJMtuAQMUYJOgMQIU82qBj09B
X-Google-Smtp-Source: AGHT+IEIa67JHm4iGq6IbgmEn/O9A05ePGGUAl+33vpiM8knnCja047dfXJXmwFR+tsyhsegkC0w5pFB6gU4
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:3a27:b0:690:29c0:ef51 with SMTP id
 fj39-20020a056a003a2700b0069029c0ef51mr6884pfb.1.1695663294680; Mon, 25 Sep
 2023 10:34:54 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 25 Sep 2023 17:34:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925173448.3518223-1-mizhang@google.com>
Subject: [PATCH 0/2] Fix the duplicate PMI injections in vPMU
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>, Roman Kagan <rkagan@amazon.de>,
        Kan Liang <kan.liang@intel.com>,
        Dapeng1 Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do stress test on KVM vPMU using Intel vtune, we find the following
warning kernel message in the guest VM:

[ 1437.487320] Uhhuh. NMI received for unknown reason 20 on CPU 3.
[ 1437.487330] Dazed and confused, but trying to continue

The Problem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The above issue indicates that there are more NMIs injected than guest
could recognize. After a month of investigation, we discovered that the
bug happened due to minor glitches in two separate parts of the KVM: 1)
KVM vPMU mistakenly fires a PMI due to emulated counter overflow even
though the overflow has already been fired by the PMI handler on the
host [1]. 2) KVM APIC allows multiple injections of PMI at one VM entry
which violates Intel SDM. Both glitches contributes to extra injection
of PMIs and thus confuses PMI handler in guest VM and causes the above
warning messages.

The Fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The patches disallow the multi-PMI injection fundamentally at APIC
level. In addition, they also simplify the PMI injection process by
removing irq_work and only use KVM_REQ_PMI.

The Testing
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

With the series applied, we do not see the above warning messages when
stress testing VM with Intel vtune. In addition, we add some kernel
printing, all emulated counter overflow happens when hardware counter
value is 0 and emulated counter value is 1 (prev_counter is -1). We
never observed unexpected prev_counter values we saw in [2].

Note that this series does break the upstream kvm-unit-tests/pmu with the
following error:

FAIL: Intel: emulated instruction: instruction counter overflow
FAIL: Intel: full-width writes: emulated instruction: instruction counter o=
verflow

This is a test bug and apply the following diff should fix the issue:

diff --git a/x86/pmu.c b/x86/pmu.c
index 0def2869..667e6233 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -68,6 +68,7 @@ volatile uint64_t irq_received;
 static void cnt_overflow(isr_regs_t *regs)
 {
 =C2=BB......irq_received++;
+=C2=BB......apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKE=
D);
 =C2=BB......apic_write(APIC_EOI, 0);
 }

We will post the above change soon.

[1] commit 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions=
")
[2] https://lore.kernel.org/all/CAL715WL9T8Ucnj_1AygwMgDjOJrttNZHRP9o-KUNfp=
x1aYZnog@mail.gmail.com/

Versioning
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The series is in v1. We made some changes:
 - drop Dapeng's reviewed-by, since code changes.
 - applies fix up in kvm_apic_local_deliver(). [seanjc]
 - remove pmc->prev_counter. [seanjc]

Previous version (v0) shown as follows:
 - [APIC patches v0]: https://lore.kernel.org/all/20230901185646.2823254-1-=
jmattson@google.com/
 - [vPMU patch v0]: https://lore.kernel.org/all/ZQ4A4KaSyygKHDUI@google.com=
/

Jim Mattson (2):
  KVM: x86: Synthesize at most one PMI per VM-exit
  KVM: x86: Mask LVTPC when handling a PMI

 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/lapic.c            |  8 ++++++--
 arch/x86/kvm/pmu.c              | 27 +--------------------------
 arch/x86/kvm/x86.c              |  3 +++
 4 files changed, 10 insertions(+), 29 deletions(-)


base-commit: 6de2ccc169683bf81feba163834dae7cdebdd826
--=20
2.42.0.515.g380fc7ccd1-goog

