Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C737E49AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjKGUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:12 -0500
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB810C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:10 -0800 (PST)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1e9c2c00182so8269091fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388409; x=1699993209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OykAIpEWbk6LIaIkkxOJrcQt1UgoP8zugcDvBcK6nI8=;
        b=Jx32YUgd6pd2PEmb7DKg0AeXcOA8NkJeVohuThV8YEdjMGo17uFHIcdH7AM7GPuOHR
         /T4DrMeSvY++srxHcmSdhO5Qn+IU21i/XIY708A1rDkRmuWWcO1sVIYRAy8UgwQw+lKw
         pg9gOsq6Sy9LgP1p4rIBBDOo7Ww3eQ6Jg3BA4UBk8D2RRlqg0Ye+sAzEDG8b26deoDQ/
         LpyUMAcR2SxjgJNQnLy6aNwhTCGOKEsokOx1Q3RHgZlAQDFhZrlWfavoLpd2/Z8NrdYf
         5COWOWz5MY06NQG2uLtMOAzg8pU1yuqf8UF4NPeTmSS3DGmOQJ/kPVk0JD/6LHZDA+gO
         2TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388409; x=1699993209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OykAIpEWbk6LIaIkkxOJrcQt1UgoP8zugcDvBcK6nI8=;
        b=YV6+sFv0sZqhycC5hSVlYGgRsHEOMjTMyBoIWNn5ifUHotz901gh7iT4qdwwGvbdKD
         R2jTVqWA7xB9zhJC57NOerrCosuHRNTXnT9p5EtklFOOrMBjXeg6KSHkDSCi9L4X4IFt
         P/QKUaZWesyZyk75rSQY9bYHFv2Umzq0ziT+ULluKs7VTSMGPC4i+dvTFZBNGrBHfCSe
         Zn0P7iKECFWT6/1pD5btedTn4yZHgj8gvpNWV/KcWd4Do+q+DCH70UzKA+6Z6RhVsvy9
         YKpL/fynAXrjFIQH+DeRuLuPPS+lfB7/sD7TjLC73TiGn7gmskf20W0E7DOvoV/7ZMFf
         2r8Q==
X-Gm-Message-State: AOJu0YyVDUVifqWswjEDJTdKr8S97nOo1NWwpjUPptpgXYwYLDQMzgoD
        L15rUegE14IpHgjDqT4x5hebYSbPx6Kz0g==
X-Google-Smtp-Source: AGHT+IG4rCA6ipEaucqlLGG43TsOeihXcJEuUzc09doDWaHMWqlINy1ZKn10385vpzpwBT4LVnZtJhFzx4cgwA==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a05:6870:41ca:b0:1e9:9e47:9555 with SMTP
 id z10-20020a05687041ca00b001e99e479555mr1820529oac.11.1699388409723; Tue, 07
 Nov 2023 12:20:09 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:19:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-1-aghulati@google.com>
Subject: [RFC PATCH 00/14] Support multiple KVM modules on the same host
From:   Anish Ghulati <aghulati@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Anish Ghulati <aghulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a rough, PoC-quality RFC to allow (un)loading and running
multiple KVM modules simultaneously on a single host, e.g. to deploy
fixes, mitigations, and/or new features without having to drain all VMs 
from the host. Multi-KVM will also allow running the "same" KVM module
with different params, e.g. to run trusted VMs with different mitigations.

The goal of this RFC is to get feedback on the idea itself and the
high-level approach.  In particular, we're looking for input on:

 - Combining kvm_intel.ko and kvm_amd.ko into kvm.ko
 - Exposing multiple /dev/kvmX devices via Kconfig
 - The name and prefix of the new base module

Feedback on individual patches is also welcome, but please keep in mind
that this is very much a work in-progress

This builds on Sean's series to hide KVM internals:

    https://lore.kernel.org/lkml/20230916003118.2540661-1-seanjc@google.com

The whole thing can be found at:

    https://github.com/asg-17/linux vac-rfc

The basic gist of the approach is to:

 - Move system-wide virtualization resource management to a new base
   module to avoid collisions between different KVM modules, e.g. VPIDs
   and ASIDs need to be unique per VM, and callbacks from IRQ handlers need
   to be mediated so that things like PMIs get to the right KVM instance.

 - Refactor KVM to make all upgradable assets visible only to KVM, i.e.
   make KVM a black box, so that the layout/size of things like "struct
   kvm_vcpu" isn't exposed to the kernel at-large.

 - Fold kvm_intel.ko and kvm_amd.ko into kvm.ko to avoid complications
   having to generate unique symbols for every symbol exported by kvm.ko.

 - Add a Kconfig string to allow defining a device and module postfix at
   build time, e.g. to create kvmX.ko and /dev/kvmX.

The proposed name of the new base module is vac.ko, a.k.a.
Virtualization Acceleration Code (Unupgradable Units Module). Childish
humor aside, "vac" is a unique name in the kernel and hopefully in x86
and hardware terminology, is a unique name in the kernel and hopefully
in x86 and hardware terminology, e.g. `git grep vac_` yields no hits in
the kernel. It also has the same number of characters as "kvm", e.g.
the namespace can be modified without needing whitespace adjustment if
we want to go that route.

Requirements / Goals / Notes:
 - Fully opt-in and backwards compatible (except for the disappearance
   of kvm_{amd,intel}.ko).

 - User space ultimately controls and is responsible for deployment,
   usage, lifecycles, etc.  Standard module refcounting applies, but 
   ensuruing that a VM is created with the "right" KVM module is a user
   space problem.

 - No user space *VMM* changes are required, e.g. /dev/kvm can be
   presented to a VMM by symlinking /dev/kvmX.

 - Mutually exclusive with subsytems that have a hard dependency on KVM,
   i.e. KVMGT.

 - x86 only (for the foreseeable future).

Anish Ghulati (13):
  KVM: x86: Move common module params from SVM/VMX to x86
  KVM: x86: Fold x86 vendor modules into the main KVM modules
  KVM: x86: Remove unused exports
  KVM: x86: Create stubs for a new VAC module
  KVM: x86: Refactor hardware enable/disable operations into a new file
  KVM: x86: Move user return msr operations out of KVM
  KVM: SVM: Move shared SVM data structures into VAC
  KVM: VMX: Move shared VMX data structures into VAC
  KVM: VMX: Move VMX enable and disable into VAC
  KVM: SVM: Move SVM enable and disable into VAC
  KVM: x86: Move VMX and SVM support checks into VAC
  KVM: x86: VAC: Move all hardware enable/disable code into VAC
  KVM: VAC: Bring up VAC as a new module

Venkatesh Srinivas (1):
  KVM: x86: Move shared KVM state into VAC

 arch/x86/include/asm/kvm-x86-ops.h |   3 +-
 arch/x86/include/asm/kvm_host.h    |  12 +-
 arch/x86/kernel/nmi.c              |   2 +-
 arch/x86/kvm/Kconfig               |  29 +-
 arch/x86/kvm/Makefile              |  31 ++-
 arch/x86/kvm/cpuid.c               |   8 +-
 arch/x86/kvm/hyperv.c              |   2 -
 arch/x86/kvm/irq.c                 |   3 -
 arch/x86/kvm/irq_comm.c            |   2 -
 arch/x86/kvm/kvm_onhyperv.c        |   3 -
 arch/x86/kvm/lapic.c               |  15 -
 arch/x86/kvm/mmu/mmu.c             |  12 -
 arch/x86/kvm/mmu/spte.c            |   4 -
 arch/x86/kvm/mtrr.c                |   1 -
 arch/x86/kvm/pmu.c                 |   2 -
 arch/x86/kvm/svm/nested.c          |   4 +-
 arch/x86/kvm/svm/sev.c             |   2 +-
 arch/x86/kvm/svm/svm.c             | 224 ++-------------
 arch/x86/kvm/svm/svm.h             |  21 +-
 arch/x86/kvm/svm/svm_data.h        |  23 ++
 arch/x86/kvm/svm/svm_ops.h         |   1 +
 arch/x86/kvm/svm/vac.c             | 172 ++++++++++++
 arch/x86/kvm/svm/vac.h             |  20 ++
 arch/x86/kvm/vac.c                 | 214 +++++++++++++++
 arch/x86/kvm/vac.h                 |  69 +++++
 arch/x86/kvm/vmx/nested.c          |   6 +-
 arch/x86/kvm/vmx/vac.c             | 287 +++++++++++++++++++
 arch/x86/kvm/vmx/vac.h             |  20 ++
 arch/x86/kvm/vmx/vmx.c             | 332 +++-------------------
 arch/x86/kvm/vmx/vmx.h             |   2 -
 arch/x86/kvm/vmx/vmx_ops.h         |   1 +
 arch/x86/kvm/x86.c                 | 423 ++---------------------------
 arch/x86/kvm/x86.h                 |  15 +-
 include/linux/kvm_host.h           |   2 +
 virt/kvm/Makefile.kvm              |  14 +-
 virt/kvm/kvm_main.c                | 210 +-------------
 virt/kvm/vac.c                     | 192 +++++++++++++
 virt/kvm/vac.h                     |  40 +++
 38 files changed, 1212 insertions(+), 1211 deletions(-)
 create mode 100644 arch/x86/kvm/svm/svm_data.h
 create mode 100644 arch/x86/kvm/svm/vac.c
 create mode 100644 arch/x86/kvm/svm/vac.h
 create mode 100644 arch/x86/kvm/vac.c
 create mode 100644 arch/x86/kvm/vac.h
 create mode 100644 arch/x86/kvm/vmx/vac.c
 create mode 100644 arch/x86/kvm/vmx/vac.h
 create mode 100644 virt/kvm/vac.c
 create mode 100644 virt/kvm/vac.h


base-commit: 0b78fc46e5450f08ef92431e569c797a63f31517
-- 
2.42.0.869.gea05f2083d-goog

