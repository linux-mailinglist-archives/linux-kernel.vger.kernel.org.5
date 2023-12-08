Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8793880991E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572994AbjLHCR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjLHCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:17:27 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306591727
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:17:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3eafe3d17so10052687b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 18:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702001852; x=1702606652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7HcAkk9OcO6R26OdgJnZaKpSN5LYlU1FJ4TjFKmXHk=;
        b=w2OtNCVN/oq88R4HPVOGyI2GILwdBmN5uo6io5EXpgCdnhgbt6pU6CGtnvjMBDkxdc
         jsPyz9caKZzOG16LIsArcDBkBxCvB3bOH9gx8UiJhsaEaXh3sT0vXtBHQ50DSO5vPLLA
         euucH1+l8LYpic0atZsoj0K1XrrqqHzH7vR0TljldE2X6L/aakrtmIVe915hZg9/8iIz
         LwEmqoazuAkNSeCz5YGIYRfaseb+Qzg91cVkj6Z6uFUqEiD1g7+46XMFaFngFX+SzKvD
         V3FeZys6mu0Nx6bqnC2wCEL4c+6nsRAg7pUBhtPow9DOPmdtofUMXyz45kiPYTrc3bsp
         3Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702001852; x=1702606652;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7HcAkk9OcO6R26OdgJnZaKpSN5LYlU1FJ4TjFKmXHk=;
        b=QBQEKxn2/tnVnuUfB6IokDyP6Bc2sfekO4oR1MF/RkRfFFHmOLTHwjBRq/bduxXGeL
         xqSF6riFzDKmX9WWCEIyDz0jryIOBAcMkoxZXM5pGCzwxuSSGO/l/HxSttToEm75PJ1D
         RAE+kvvObMRIA71X973n1YehWrhnRQxmvDSGPsWafe4Zw1/ObUc6pQ728b6YOfQkGn/v
         dBTWjESftkIgNjV1AImRLFSuqK/1A7bdnEaMNuv6Drxuvx41rhuqyXUx6bQCH2G4xw/6
         mHHtKmzFH7z70b2VS0zyO42YQ+6+Asqs0i9+RAhKGeigTDwRBfyvIB4XDciTOBwPtG6d
         ia/Q==
X-Gm-Message-State: AOJu0YzwAu2yvpDBUIwul6IlHuGKEMoCCq904vXjI7HacASM/MG4bwSa
        b599cc4DpdrUN4mLVWs1lR7s7TS7gH8=
X-Google-Smtp-Source: AGHT+IF4M/K0KGAhMim7eQLfOFrM5Cj0KkcFsrHAyQxVlnJovHWvRW4FrdnZ3uPQIhVPScAb2KGEmYyn+5Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:14d:b0:db5:3aaf:5207 with SMTP id
 p13-20020a056902014d00b00db53aaf5207mr2547ybh.3.1702001852402; Thu, 07 Dec
 2023 18:17:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  7 Dec 2023 18:17:08 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208021708.1707327-1-seanjc@google.com>
Subject: [GIT PULL] KVM: selftests: Fixes and cleanups for 6.7-rcN
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Please pull selftests fixes/cleanups for 6.7.  The big change is adding
__printf() annotation to the guest printf/assert helpers, which is waaay
better than me playing whack-a-mole when tests fail (I'm still laughing
at myself for not realizing what that annotation does).

The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b2f:

  selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:58:25 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.7-rcN

for you to fetch changes up to 1b2658e4c709135fe1910423d3216632f641baf9:

  KVM: selftests: Annotate guest ucall, printf, and assert helpers with __printf() (2023-12-01 08:15:41 -0800)

----------------------------------------------------------------
KVM selftests fixes for 6.7-rcN:

 - Fix an annoying goof where the NX hugepage test prints out garbage
   instead of the magic token needed to run the text.

 - Fix build errors when a header is delete/moved due to a missing flag
   in the Makefile.

 - Detect if KVM bugged/killed a selftest's VM and print out a helpful
   message instead of complaining that a random ioctl() failed.

 - Annotate the guest printf/assert helpers with __printf(), and fix the
   various bugs that were lurking due to lack of said annotation.

----------------------------------------------------------------
David Woodhouse (1):
      KVM: selftests: add -MP to CFLAGS

Sean Christopherson (7):
      KVM: selftests: Drop the single-underscore ioctl() helpers
      KVM: selftests: Add logic to detect if ioctl() failed because VM was killed
      KVM: selftests: Remove x86's so called "MMIO warning" test
      KVM: selftests: Fix MWAIT error message when guest assertion fails
      KVM: selftests: Fix benign %llx vs. %lx issues in guest asserts
      KVM: selftests: Fix broken assert messages in Hyper-V features test
      KVM: selftests: Annotate guest ucall, printf, and assert helpers with __printf()

angquan yu (1):
      KVM: selftests: Actually print out magic token in NX hugepages skip message

 tools/testing/selftests/kvm/Makefile               |   3 +-
 .../testing/selftests/kvm/include/kvm_util_base.h  |  75 ++++++++-----
 tools/testing/selftests/kvm/include/test_util.h    |   2 +-
 tools/testing/selftests/kvm/include/ucall_common.h |   7 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |   6 +-
 .../testing/selftests/kvm/x86_64/hyperv_features.c |  10 +-
 .../selftests/kvm/x86_64/mmio_warning_test.c       | 121 ---------------------
 .../selftests/kvm/x86_64/monitor_mwait_test.c      |   6 +-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c      |   2 +-
 .../kvm/x86_64/private_mem_conversions_test.c      |   2 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c       |   4 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c       |   2 +-
 .../testing/selftests/kvm/x86_64/xcr0_cpuid_test.c |   8 +-
 14 files changed, 78 insertions(+), 172 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
