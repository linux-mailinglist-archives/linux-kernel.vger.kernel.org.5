Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF57E86B3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjKJXzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKJXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:55:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F87420B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b31e000e97so35609347b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660533; x=1700265333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY8LgwN808IydVRIyG0fx7z1NJlKrZCLfSJxMdvZJ8k=;
        b=28XEm44pIR6dQ2xTd3KRVxDuOXSQAPzkTN+G6oIvUcTpZvus8PXlXlFjBtbjtSYixA
         Xuf3lOLI+huPYrWYnBrX8MbVNHyguUykQDS/sW78EAzscQjlsbmHeacyOAwZ9Axls8Wh
         yZ/bSbAS6Wpa7mxJYG2yitNv7p4JI5GO5G1a3bbdihfvUMOQxAc5IWpxVro+LxSZTRlS
         FNIO6l5b3v0UEi/22deV6wj7LgEZK3pVq6iKlgHZFKCTW9elTiclt/GcYIy+0rP6cRjC
         b1WUTCF6AOSK2FRe/fiPE4jspkmCuKo2I0csWOLiLa65/7ce4tAzChTeKNYYq5c6auu4
         mMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660533; x=1700265333;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PY8LgwN808IydVRIyG0fx7z1NJlKrZCLfSJxMdvZJ8k=;
        b=qCiu1/hrOcGlhJaZ5TmnkJQkNFrJ6nJrf2EajBZNMsxS/1BKkQDDVRL3tNFhFLTy9r
         w/7/Kf94LMRBN7y0EhDZc0lPRA66r3KaOpVGUhif0hTpN7K078Mt6KIEP6oAdFNaov9/
         Hu0jPvy+BCKoyNxqHuIfxTC8x2zLysPb9MzI4aS9mA/Z24U4jdRSB0fKPScuFKzNlTML
         nzy7qc/1IlLhDSUu7Gr3lnyHyNHGnnuCE9gwtZlnXwbp2wC6AYOZH6eOXDs4QHV+0Ndm
         hApiswXfG56V0VrIcvjYTEHHQc6xQEqIQqUJolAW9Sy84KUlRO3PO5po2WgJ2ZzGFYGQ
         poMQ==
X-Gm-Message-State: AOJu0Yx/vZCkTijP2d1CnhlIgVlxSv7BMmvtFAaXB+PpXC9pjZAKrIag
        xsX5GgG0xSWSjrKuOBSYq7/EQcdI4mY=
X-Google-Smtp-Source: AGHT+IFUT80IUQyz+DyvIJ1S3oZm0hrIuvXccKSjJSddXVOa73GAlW/yQGZGK6et3Ys0SEobeZ5TBSWMUnI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d78d:0:b0:5be:a164:5669 with SMTP id
 z135-20020a0dd78d000000b005bea1645669mr18569ywd.7.1699660533389; Fri, 10 Nov
 2023 15:55:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:19 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-1-seanjc@google.com>
Subject: [PATCH 0/9] KVM: x86: Replace governed features with guest cpu_caps
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
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

Replace the poorly named, confusing, and high-maintenance "governed
features" framework with a comprehensive guest cpu_caps implementation.

In short, snapshot all X86_FEATURE_* flags that KVM cares about so that
all queries against guest capabilities are "fast", e.g. don't require
manual enabling or judgment calls as to where a feature needs to be fast.

The guest_cpu_cap_* nomenclature follows the existing kvm_cpu_cap_*
except for a few (maybe just one?) cases where guest cpu_caps need APIs
that kvm_cpu_caps don't.  In theory, the similar names will make this
approach more intuitive.

Sean Christopherson (9):
  KVM: x86: Rename "governed features" helpers to use "guest_cpu_cap"
  KVM: x86: Replace guts of "goverened" features with comprehensive
    cpu_caps
  KVM: x86: Initialize guest cpu_caps based on guest CPUID
  KVM: x86: Avoid double CPUID lookup when updating MWAIT at runtime
  KVM: x86: Drop unnecessary check that cpuid_entry2_find() returns
    right leaf
  KVM: x86: Update guest cpu_caps at runtime for dynamic CPUID-based
    features
  KVM: x86: Shuffle code to prepare for dropping guest_cpuid_has()
  KVM: x86: Replace all guest CPUID feature queries with cpu_caps check
  KVM: x86: Restrict XSAVE in cpu_caps based on KVM capabilities

 arch/x86/include/asm/kvm_host.h  |  40 ++++++----
 arch/x86/kvm/cpuid.c             | 102 +++++++++++++++++++-------
 arch/x86/kvm/cpuid.h             | 121 +++++++++++--------------------
 arch/x86/kvm/governed_features.h |  21 ------
 arch/x86/kvm/lapic.c             |   2 +-
 arch/x86/kvm/mmu/mmu.c           |   4 +-
 arch/x86/kvm/mtrr.c              |   2 +-
 arch/x86/kvm/reverse_cpuid.h     |  15 ----
 arch/x86/kvm/smm.c               |  10 +--
 arch/x86/kvm/svm/nested.c        |  22 +++---
 arch/x86/kvm/svm/pmu.c           |   8 +-
 arch/x86/kvm/svm/sev.c           |   4 +-
 arch/x86/kvm/svm/svm.c           |  50 ++++++-------
 arch/x86/kvm/svm/svm.h           |   4 +-
 arch/x86/kvm/vmx/nested.c        |  18 ++---
 arch/x86/kvm/vmx/pmu_intel.c     |   4 +-
 arch/x86/kvm/vmx/sgx.c           |  14 ++--
 arch/x86/kvm/vmx/vmx.c           |  63 ++++++++--------
 arch/x86/kvm/vmx/vmx.h           |   2 +-
 arch/x86/kvm/x86.c               |  72 +++++++++---------
 20 files changed, 282 insertions(+), 296 deletions(-)
 delete mode 100644 arch/x86/kvm/governed_features.h


base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.42.0.869.gea05f2083d-goog

